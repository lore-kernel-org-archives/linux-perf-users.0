From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/9] perf test: Adding an entry for the perftool-testsuite
Date: Tue, 15 Dec 2015 13:03:46 +0100
Message-ID: <20151215120346.GB5074@krava.brq.redhat.com>
References: <1449514379.24573.251.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965122AbbLOMDs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Dec 2015 07:03:48 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id D960868E1F
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Dec 2015 12:03:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1449514379.24573.251.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Dec 07, 2015 at 07:52:59PM +0100, Michael Petlan wrote:
> In order to be able to run the bash/subcommand-based testsuite directly
> from perf test a new perf-test entry has been created for it.
> 
> The driver (suite.c) runs all the tests  that it finds in the testsuite
> directory: tools/perf/testsuite/   (rather ./testsuite as it expects it
> it being run from the perf's directory).
> 
> In case the testsuite is not found, the testcase is skipped. If this is
> not the desired behaviour, some packaging will be needed.
> 
> Usage:
> 	./perf test suite
> 
> or
> 	./perf test suite -v

so -v has following output now:

	--- SNIP
	[jolsa@krava perf]$ sudo ./perf test suite -v
	38: Testsuite                                                :
	--- start ---
	test child forked, pid 11670
	======== base_annotate ========
	-- [ PASS ] -- perf_annotate :: setup :: building the example code
	Line did not match any pattern: "Lowering default frequency rate to 2000."
	Line did not match any pattern: "Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate."
	-- [ FAIL ] -- perf_annotate :: setup :: record data (output regexp parsing)
	## [ FAIL ] ## perf_annotate :: setup SUMMARY :: 1 failures found
	-- [ SKIP ] -- perf_annotate :: test_basic :: help message :: testcase skipped
	-- [ PASS ] -- perf_annotate :: test_basic :: basic execution - annotate
	-- [ PASS ] -- perf_annotate :: test_basic :: dso filter
	-- [ PASS ] -- perf_annotate :: test_basic :: no-source
	-- [ PASS ] -- perf_annotate :: test_basic :: full-paths
	-- [ PASS ] -- perf_annotate :: test_basic :: print-line
	-- [ PASS ] -- perf_annotate :: test_basic :: redirected input
	-- [ PASS ] -- perf_annotate :: test_basic :: execution without data
	## [ PASS ] ## perf_annotate :: test_basic SUMMARY
	-- [ PASS ] -- perf_annotate :: cleanup :: clean-up logs

	======== base_buildid ========
	## [ PASS ] ## perf_buildid-cache :: setup SUMMARY
	-- [ SKIP ] -- perf_buildid-cache :: test_buildid-list :: help message :: testcase skipped
	Line did not match any pattern: "2e228243285efef5d8b66c729703b4aebdd12c86 [kernel.kallsyms]"
	Line did not match any pattern: "b5105437a54662622e6d461cf3036e79e9261f4f [vdso]"
	Usage: file [-bcEhikLlNnprsvz0] [--apple] [--mime-encoding] [--mime-type]
		    [-e testname] [-F separator] [-f namefile] [-m magicfiles] file ...
	       file -C [-m magicfiles]
	       file [--help]
	Usage: file [-bcEhikLlNnprsvz0] [--apple] [--mime-encoding] [--mime-type]
		    [-e testname] [-F separator] [-f namefile] [-m magicfiles] file ...
	       file -C [-m magicfiles]
	       file [--help]
	-- [ FAIL ] -- perf_buildid-cache :: test_buildid-list :: buildids check (output regexp parsing)
	...
	--- SNIP


could you ensure following output:

	[jolsa@krava perf]$ sudo ./perf test suite 
	38: Testsuite                                                : FAILED!

	[jolsa@krava perf]$ sudo ./perf test suite -v
	38: Testsuite                                                :
	--- start ---
	test child forked, pid 11670
	-- [ PASS ] -- perf_annotate :: setup :: building the example code
	-- [ FAIL ] -- perf_annotate :: setup :: record data (output regexp parsing)
	## [ FAIL ] ## perf_annotate :: setup SUMMARY :: 1 failures found
	-- [ SKIP ] -- perf_annotate :: test_basic :: help message :: testcase skipped
	-- [ PASS ] -- perf_annotate :: test_basic :: basic execution - annotate
	-- [ PASS ] -- perf_annotate :: test_basic :: dso filter
	-- [ PASS ] -- perf_annotate :: test_basic :: no-source
	-- [ PASS ] -- perf_annotate :: test_basic :: full-paths
	-- [ PASS ] -- perf_annotate :: test_basic :: print-line
	-- [ PASS ] -- perf_annotate :: test_basic :: redirected input
	-- [ PASS ] -- perf_annotate :: test_basic :: execution without data
	## [ PASS ] ## perf_annotate :: test_basic SUMMARY
	-- [ PASS ] -- perf_annotate :: cleanup :: clean-up logs
	## [ PASS ] ## perf_buildid-cache :: setup SUMMARY
	-- [ SKIP ] -- perf_buildid-cache :: test_buildid-list :: help message :: testcase skipped
	-- [ FAIL ] -- perf_buildid-cache :: test_buildid-list :: buildids check (output regexp parsing)
	...

	[jolsa@krava perf]$ sudo ./perf test suite -vv
	unleash the hell ;-)

	or even add -vvv ... would be suite developers choice anyway ;-)


thanks,
jirka
