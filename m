From: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Subject: perf report: null ptr dereference in utils/env.c
Date: Tue, 18 Oct 2016 16:13:45 +0000
Message-ID: <D6EDEBF1F91015459DB866AC4EE162CC02499B19@IRSMSX103.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16945 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964973AbcJRQOB (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2016 12:14:01 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: "jolsa@kernel.org" <jolsa@kernel.org>

Hi,
Am I the only one getting segfaults in perf report (4.8-rc8/4.9rc-1)?
It happens simply when I try to exit it.

Program received signal SIGSEGV, Segmentation fault.
perf_env__exit (env=env@entry=0x1fc4d00) at util/env.c:25
(...)
(gdb) list
(...)

24              for (i = 0; i < env->nr_numa_nodes; i++)
25                      cpu_map__put(env->numa_nodes[i].map);
26              zfree(&env->numa_nodes);
 
 (gdb) print env->nr_numa_nodes
$1 = 2
 (gdb) print env->numa_nodes
$2 = (struct numa_node *) 0x0    

This line was introduced in the following patch:
https://patchwork.kernel.org/patch/9213995/

Thanks,
Lukas
