From: Mark Hills <mark@pogo.org.uk>
Subject: perf cannot see call graph, visible in gdb
Date: Thu, 5 Sep 2013 17:48:07 +0100 (BST)
Message-ID: <1309051629550.29229@wes.ijneb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx.ij.cx ([212.13.201.15]:62968 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751522Ab3IERQt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Sep 2013 13:16:49 -0400
Received: from mark (helo=localhost)
	by wes.ijneb.com with local-esmtp (Exim 4.77)
	(envelope-from <mark@pogo.org.uk>)
	id 1VHcj1-0000rB-5R
	for linux-perf-users@vger.kernel.org; Thu, 05 Sep 2013 17:48:07 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I have a pre-compiled .so library, which was given to me for profiling.

gdb can see a complete call stack -- both the library and my own code, as 
expected.

But in perf the callgraph for the library is not present. I'm using "perf 
record -g", and the callgraph for the other code is seen.
 
In what cases could gdb see the stack, but perf cannot?

Many thanks

-- 
Mark


---
# System is Scientific Linux 6.3 (derived from RedHat 6.3)

$ uname -a
Linux star 2.6.32-358.el6.x86_64 #1 SMP Fri Feb 22 20:37:17 CST 2013 x86_64 x86_64 x86_64 GNU/Linux

$ rpm -q perf
perf-2.6.32-358.el6.x86_64

$ rpm -q gdb
gdb-7.2-56.el6.x86_64

# The library which is missing the callgraph is librj.so

$ perf script -L
[...]
radford. 16009 1117798.447638: cycles: 
            7ff2836dd906 RjMetaDataGetStr (/mnt/scratch/radford/librj.so)

radford. 16009 1117798.471449: cycles: 
            7ff2837213a2 RjFile::getChar() (/mnt/scratch/radford/librj.so)

radford. 16102 1117798.707682: cycles: 
        ffffffffa0fa9281 rpc_task_release_client (/lib/modules/2.6.32-358.el6.x86_64/kernel/net/sunrpc/sunrpc.ko)
        ffffffffa0fb1f7b rpc_release_resources_task (/lib/modules/2.6.32-358.el6.x86_64/kernel/net/sunrpc/sunrpc.ko)
        ffffffffa0fb2a84 __rpc_execute (/lib/modules/2.6.32-358.el6.x86_64/kernel/net/sunrpc/sunrpc.ko)
        ffffffffa0fb2cc1 rpc_execute (/lib/modules/2.6.32-358.el6.x86_64/kernel/net/sunrpc/sunrpc.ko)
        ffffffffa0fa93a5 rpc_run_task (/lib/modules/2.6.32-358.el6.x86_64/kernel/net/sunrpc/sunrpc.ko)
        ffffffffa0fa94c2 rpc_call_sync (/lib/modules/2.6.32-358.el6.x86_64/kernel/net/sunrpc/sunrpc.ko)
        ffffffffa106af6d nfs3_rpc_wrapper.clone.0 (/lib/modules/2.6.32-358.el6.x86_64/kernel/fs/nfs/nfs.ko)
        ffffffffa106b34c nfs3_proc_access (/lib/modules/2.6.32-358.el6.x86_64/kernel/fs/nfs/nfs.ko)
        ffffffffa10531e9 nfs_do_access (/lib/modules/2.6.32-358.el6.x86_64/kernel/fs/nfs/nfs.ko)
        ffffffffa10534b8 nfs_permission (/lib/modules/2.6.32-358.el6.x86_64/kernel/fs/nfs/nfs.ko)
        ffffffff8119053d __link_path_walk ([kernel.kallsyms])
        ffffffff811909ca __link_path_walk ([kernel.kallsyms])
        ffffffff8119174a path_walk ([kernel.kallsyms])
        ffffffff8119191b do_path_lookup ([kernel.kallsyms])
        ffffffff811925a7 user_path_at ([kernel.kallsyms])
        ffffffff811869bc vfs_fstatat ([kernel.kallsyms])
        ffffffff81186b2b vfs_stat ([kernel.kallsyms])
        ffffffff81186b54 sys_newstat ([kernel.kallsyms])
        ffffffff8100b072 system_call_fastpath ([kernel.kallsyms])
              320a6da735 __xstat64 (/lib64/libc-2.12.so)
            7ff282d09247 Evaluate(RjNode*, RjHiderGlobals*) (/home/mark/built/rathiders.so)
            7ff283701585 RjHiderEvaluate (/mnt/scratch/radford/librj.so)
            7ff283701585 RjHiderEvaluate (/mnt/scratch/radford/librj.so)
