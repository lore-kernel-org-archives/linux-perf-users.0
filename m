From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 0/9] perf test: the testsuite again
Date: Tue, 29 Mar 2016 19:28:16 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1603291917040.7107@Rudolf-RHEL-7>
References: <alpine.LRH.2.20.1603161423550.13911@Rudolf-RHEL-7> <20160327122441.GL4015@krava.sund.root.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747AbcC2R2T (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2016 13:28:19 -0400
In-Reply-To: <20160327122441.GL4015@krava.sund.root.ku.dk>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

On Sun, 27 Mar 2016, Jiri Olsa wrote:
> ctrl-c does not stop the suite.. I checked and you run several
> command on background.. is there a reason for that?
>
>
> [jolsa@krava perf]$ sudo ./perf test suite -v
> 44: Testsuite                                                :
> --- start ---
> test child forked, pid 25786
> ======== base_stat ========
> -- [ PASS ] -- perf_stat :: test_basic :: basic execution
>
> ...
>
> -- [ PASS ] -- perf_annotate :: test_basic :: redirected input
> -- [ PASS ] -- perf_annotate :: test_basic :: execution without data
> ## [ PASS ] ## perf_annotate :: test_basic SUMMARY
> ## [ SKIP ] ## perf_annotate :: cleanup :: testcase skipped
>
> ======== base_report ========
> ^C
> [jolsa@krava perf]$ ^C
> [jolsa@krava perf]$ ^C
> [jolsa@krava perf]$ -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
> -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
> -- [ FAIL ] -- perf_report :: test_basic :: basic execution (output regexp parsing)
> -- [ FAIL ] -- perf_report :: test_basic :: number of samples (output regexp parsing)
> -- [ PASS ] -- perf_report :: test_basic :: header
>
>

I think this is a generic behaviour of perf-test itself. In the case of the
testsuite it just has a bigger "race window" you can hit with the C-c.

Every test forks:

---- end ----
roundtrip evsel->name check: Ok
12: Check parsing of sched tracepoints fields                :
--- start ---
test child forked, pid 8304
test child finished with 0
---- end ----
Check parsing of sched tracepoints fields: Ok
13: Generate and check syscalls:sys_enter_openat event fields:
--- start ---
test child forked, pid 8305
mmap size 528384B
test child finished with 0
---- end ----

And I managed to C-c the test 14 hitting the "race window", so it continued
printing something:

14: struct perf_event_attr setup                             :
--- start ---
test child forked, pid 8306
running './tests/attr/test-record-C0'
unsupp  './tests/attr/test-record-C0'
running './tests/attr/test-record-basic'
unsupp  './tests/attr/test-record-basic'
running './tests/attr/test-record-branch-any'
unsupp  './tests/attr/test-record-branch-any'
running './tests/attr/test-record-branch-filter-any'
unsupp  './tests/attr/test-record-branch-filter-any'
running './tests/attr/test-record-branch-filter-any_call'
unsupp  './tests/attr/test-record-branch-filter-any_call'
running './tests/attr/test-record-branch-filter-any_ret'
unsupp  './tests/attr/test-record-branch-filter-any_ret'
running './tests/attr/test-record-branch-filter-hv'
unsupp  './tests/attr/test-record-branch-filter-hv'
running './tests/attr/test-record-branch-filter-ind_call'
unsupp  './tests/attr/test-record-branch-filter-ind_call'
running './tests/attr/test-record-branch-filter-k'
unsupp  './tests/attr/test-record-branch-filter-k'
running './tests/attr/test-record-branch-filter-u'
unsupp  './tests/attr/test-record-branch-filter-u'
running './tests/attr/test-record-count'
unsupp  './tests/attr/test-record-count'
running './tests/attr/test-record-data'
unsupp  './tests/attr/test-record-data'
running './tests/attr/test-record-freq'
unsupp  './tests/attr/test-record-freq'
running './tests/attr/test-record-graph-default'
unsupp  './tests/attr/test-record-graph-default'
running './tests/attr/test-record-graph-dwarf'
unsupp  './tests/attr/test-record-graph-dwarf'
running './tests/attr/test-record-graph-fp'
^C
[root@muflon perf]# sh: line 1:  8357 Terminated              PERF_TEST_ATTR=/tmp/tmpzPprWC ./perf record -o /tmp/tmpzPprWC/perf.data --call-graph fp kill > /dev/null 2>&1
unsupp  './tests/attr/test-record-graph-fp'
running './tests/attr/test-record-group'
unsupp  './tests/attr/test-record-group'
running './tests/attr/test-record-group-sampling'
unsupp  './tests/attr/test-record-group-sampling'
running './tests/attr/test-record-group1'
unsupp  './tests/attr/test-record-group1'

When looking at `ps aux | grep perf | grep -v grep`, you can see the following:

# in this case you won't hit the "race window", C-c would work
root      8286  0.0  0.1  76944  5692 pts/0    S+   18:16   0:00 perf test -v
root      8292  0.0  0.0  81316  3640 pts/0    S+   18:16   0:00 perf test -v

# in this case you hit the "race window" (run ps aux exactly when a sub-test
# was running), so C-c would kill the perf test itself, but not the PID 8307
# (which will continue printing stuff)
root      8286  0.0  0.1  76944  5692 pts/0    S+   18:16   0:00 perf test -v
root      8306  0.0  0.0  76944   936 pts/0    S+   18:16   0:00 perf test -v
root      8307  1.6  0.3 192668 12340 pts/0    D+   18:16   0:00 /usr/bin/python2 ./tests/attr.py -d ./tests/attr/ -p ./perf -v

When the testsuite runs, it usually runs some /bin/bash instead of the python2
here. Since the testsuite spends most of the time in running the subtests outside
of the C code (known issue), your chance that you hit that moment by C-c is pretty
high. I don't think it can be fixed without re-designing the perf-test itself.

Regards,
Michael

>
> jirka
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
