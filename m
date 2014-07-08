From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Fwd: filtering perf itself
Date: Tue, 08 Jul 2014 13:45:08 -0700
Message-ID: <87tx6roa0b.fsf@tassilo.jf.intel.com>
References: <CAE40pdeACbvYJN0BMh9edGGLvdpV_H1Kn5ccgBh7GFuDHiuWGQ@mail.gmail.com>
	<CAE40pdePzcfHfZzuOC6DyFc2H7DQMZ_JzADvx_guDS+Eg4SJtw@mail.gmail.com>
	<53BAEA99.7050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12413 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893AbaGHUqH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Jul 2014 16:46:07 -0400
In-Reply-To: <53BAEA99.7050602@gmail.com> (David Ahern's message of "Mon, 07
	Jul 2014 12:44:41 -0600")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, linux-perf-users@vger.kernel.org

David Ahern <dsahern@gmail.com> writes:

> On 7/7/14, 12:38 PM, Brendan Gregg wrote:
>> G'Day perf users,
>>
>> Is there a way to filter perf from tracing itself?
>>
>> Here's an idle system:
>>
>> # ./perf record -e syscalls:sys_enter_read -a sleep 5
>> [ perf record: Woken up 2 times to write data ]
>> [ perf record: Captured and wrote 0.569 MB perf.data (~24864 samples) ]
>> # ./perf record -e syscalls:sys_enter_write -a sleep 5
>> [ perf record: Woken up 0 times to write data ]
>> [ perf record: Captured and wrote 150.381 MB perf.data (~6570251 samples) ]
>>
>> Note the disparity. perf is capturing its own writes, creating a feedback loop.
>
> Not a filter, but works around the problem using mmap'ed output file:
>
> https://github.com/dsahern/linux/commit/ae2d7010256f5a5b247fb4df9f764a911a34a2f3

The problem is just getting the perf pid into the filter, right?

Something like this patch should work.

Actually it works most of the time, sometimes there are still EINVALs.

-Andi


commit 414db7523d44fe3afeaed3e2fc879a28263878ba
Author: Andi Kleen <ak@linux.intel.com>
Date:   Tue Jul 8 13:37:24 2014 -0700

    perf, tools: Add PERF_PID
    
    It's currently difficult to filter out perf itself using a filter.
    The best way is to use the pid. But it's difficult to get the pid
    of perf without using hacks.
    
    With this patch the following works
    
    % perf record -e syscalls:sys_enter_write -a --filter 'common_pid != PERF_PID' ...
    
    Signed-off-by: Andi Kleen <ak@linux.intel.com>

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d460049..b6c5e51 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -41,7 +41,7 @@ OPTIONS
           'mem:0x1000:rw'.
 
 --filter=<filter>::
-        Event filter.
+        Event filter. PERF_PID represents the perf pid.
 
 -a::
 --all-cpus::
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1e15df1..90ed63f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -967,6 +967,7 @@ int parse_filter(const struct option *opt, const char *str,
 {
 	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
 	struct perf_evsel *last = NULL;
+	char *pid;
 
 	if (evlist->nr_entries > 0)
 		last = perf_evlist__last(evlist);
@@ -983,6 +984,14 @@ int parse_filter(const struct option *opt, const char *str,
 		return -1;
 	}
 
+	/* Assume a pid has not more than 8 characters */
+	pid = strstr(last->filter, "PERF_PID");
+	if (pid) {
+		char buf[9];
+		snprintf(buf, 9, "%08d", getpid());
+		memcpy(pid, buf, 8);
+	}
+	fprintf(stderr, "filter |%s|\n", last->filter);
 	return 0;
 }
 



-- 
ak@linux.intel.com -- Speaking for myself only
