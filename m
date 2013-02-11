From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Perf record premature termination
Date: Mon, 11 Feb 2013 10:50:12 -0800
Message-ID: <1360608612.17632.193.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32261 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758821Ab3BKSuL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 Feb 2013 13:50:11 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, ak <ak@linux.intel.com>

David,

When I am doing a profiling of kernel compile with 32 threads on a 4
socket westmere machine, I found that perf record terminated right away
for the version of perf in 3.7 kernel source tree.
There's no profile data recroded and the compile is running in
background.

$ make -j32 &
then
$ sudo /test/perf record -a -g -f sleep 5
sleep: Terminated

I've bisected the patch responsible to the following patch.

Tim


8d3eca20b9f31cf10088e283d704f6a71b9a4ee2 is the first bad commit
commit 8d3eca20b9f31cf10088e283d704f6a71b9a4ee2
Author: David Ahern <dsahern@gmail.com>
Date:   Sun Aug 26 12:24:47 2012 -0600

    perf record: Remove use of die/exit
    
    Allows perf to clean up properly on exit. If perf-record is exiting
due
    to failure, the on_exit should not run as the session has been
deleted.
    
    Signed-off-by: David Ahern <dsahern@gmail.com>
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link:
http://lkml.kernel.org/r/1346005487-62961-8-git-send-email-dsahern@gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
