//
//  main.c
//  R3
//
//  Created by zp on 15/10/28.
//  Copyright © 2015年 Netease. All rights reserved.
//

#include <stdio.h>
#include "r3.h"
#include <assert.h>

void test()
{
    node *n = r3_tree_create(10);
    
    int index1 = 1;
    // insert the route path into the router tree
    r3_tree_insert_path(n, "/bar1", &index1); // ignore the length of path
    
    r3_tree_insert_path(n, "/bar", &index1); // ignore the length of path
    
    int index2 = 2;
    r3_tree_insert_pathl(n, "/zoo", strlen("/zoo"), &index2 );
    
    int index3 = 3;
    r3_tree_insert_pathl(n, "/foo/bar", strlen("/foo/bar"), &index3 );
    
    int index4 = 4;
    r3_tree_insert_pathl(n ,"/post/{ab}/ab", strlen("/post/{id}/ab") , &index4 );
    
    int index5 = 5;
    r3_tree_insert_pathl(n, "/user/{id:\\d+}/{id1:\\d+}", strlen("/user/{id:\\d+}/{id1:\\d+}"), &index5 );
    
    
    // if you want to catch error, you may call the extended path function for insertion
    char *errstr = NULL;
//    node *ret = r3_tree_insert_pathl_ex(n, "/foo/{name:\\d{5}", strlen("/foo/{name:\\d{5}"), NULL, &data, &errstr);
//    if (ret == NULL) {
//        // failed insertion
//        printf("error: %s\n", errstr);
//        free(errstr); // errstr is created from `asprintf`, so you have to free it manually.
//    }
    
    
    // let's compile the tree!
    errstr = NULL;
    int err = r3_tree_compile(n, &errstr);
    if (err != 0) {
        // fail
        printf("error: %s\n", errstr);
        free(errstr); // errstr is created from `asprintf`, so you have to free it manually.
    }
    
    
    // dump the compiled tree
    r3_tree_dump(n, 0);
    
    
    // match a route
    NSMutableDictionary *matchedResult = [NSMutableDictionary new];
    node *matched_node = r3_tree_matchl(n, "/bar", strlen("/bar"), NULL, matchedResult);
    assert(matched_node && *( (int*) matched_node->data ) == 1 && matchedResult.count == 0);

    
    matched_node = r3_tree_matchl(n, "/foo/bar", strlen("/foo/bar"), NULL, matchedResult);
    assert(matched_node && *( (int*) matched_node->data ) == 3 && matchedResult.count == 0);
    
    matched_node = r3_tree_matchl(n, "/post/tt/cd", strlen("/post/tt/cd"), NULL, matchedResult);
    assert(!matched_node);
    [matchedResult removeAllObjects];
    
    matched_node = r3_tree_matchl(n, "/user/13/213", strlen("/user/13/213"), NULL, matchedResult);
    assert(matched_node && *( (int*) matched_node->data ) == 5);
    assert(matchedResult.count == 2 && [[matchedResult objectForKey:@"id"] isEqualToString:@"13"]
            && [[matchedResult objectForKey:@"id1"] isEqualToString:@"213"]);
    
    [matchedResult release];
    // release the tree
    r3_tree_free(n);
}

int main(int argc, const char * argv[]) {
    // insert code here...
    test();
    printf("Hello, World!\n");
    return 0;
}
