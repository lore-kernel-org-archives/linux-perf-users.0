From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 0/9] perf test: the testsuite again
Date: Sun, 27 Mar 2016 14:25:04 +0200
Message-ID: <20160327122504.GO4015@krava.sund.root.ku.dk>
References: <alpine.LRH.2.20.1603161423550.13911@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbcC0MZH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 27 Mar 2016 08:25:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1603161423550.13911@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

On Wed, Mar 16, 2016 at 02:50:06PM +0100, Michael Petlan wrote:
> Hi all,
> 
> after some time, I am sending the proposed testsuite again. I have fixed
> couple of things there since last time.
> 
>   * three verbosity levels are now supported (perf test suite -vv)
>   * logs and temp files are stored in /tmp/, so the main tree is not
>     spoiled anymore
>   * more things can be parametrized from the outside
>   * log parsing should be more robust now
> 
> The testsuite is roughly tested on x86_64, i386, ppc64, s390x and aarch64.
> The following patches should be applicable upon the Arnaldo's tree, to the
> 'perf/core' branch.
> 
> Some issues to be discussed:
> 
> 1) Packaging
> 
> While the other tests are packed within perf, the character of this suite
> does not fit that model very well. Nowadays, it is run only when the dir
> 'testsuite' is found in the current dir. Otherwise the test is skipped.
> I still haven't found any better solution for this.
> 
> 2) In case it gets into the kernel tree, where the 'upstream' will be?
> 
> I have been developing the suite in my github repository [1]. I am planning
> to continue with that, if the suite gets or not into the kernel tree. There
> are still many testcases missing. I also backport the suite for RHEL testing
> purposes.
> 
> It is easier for me to continue the development there and merge bigger
> chunks into the kernel tree, than move all the development here. Is that
> an acceptable model?
> 
> Is there anything else that you would like to point at?
> 
> Thanks.
> Michael

so when I run 'sudo perf test suite -v' I assume I'm getting
one test pre line output with status at the begning:

======== base_report ========
-- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
-- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
-- [ FAIL ] -- perf_report :: test_basic :: basic execution (output regexp parsing)
-- [ FAIL ] -- perf_report :: test_basic :: number of samples (output regexp parsing)
-- [ PASS ] -- perf_report :: test_basic :: header
-- [ FAIL ] -- perf_report :: test_basic :: show CPU utilization (output regexp parsing)
-- [ FAIL ] -- perf_report :: test_basic :: pid (output regexp parsing)
-- [ FAIL ] -- perf_report :: test_basic :: non-existing symbol (output regexp parsing)
-- [ FAIL ] -- perf_report :: test_basic :: symbol filter (output regexp parsing)
## [ FAIL ] ## perf_report :: test_basic SUMMARY :: 6 failures found
## [ SKIP ] ## perf_report :: cleanup :: testcase skipped


that seems great, and it'd be nice if you could frce this 1 line per 
test even if some test fails and spits out some error message, like:

-- [ PASS ] -- perf_probe :: test_listing :: userspace functions list
Failed to find the path for kernel: Invalid ELF file
  Error: Failed to show vars.
-- [ FAIL ] -- perf_probe :: test_listing :: kernel variables list (command exitcode + output regexp parsing)
-- [ PASS ] -- perf_probe :: test_listing :: userspace variables list
Failed to find the path for kernel: Invalid ELF file
  Error: Failed to show lines.
-- [ FAIL ] -- perf_probe :: test_listing :: kernel lines list (command exitcode + output regexp parsing)
Failed to find the path for kernel: Invalid ELF file
  Error: Failed to show lines.
-- [ FAIL ] -- perf_probe :: test_listing :: kernel source lines list (command exitcode + output regexp parsing)
-- [ SKIP ] -- perf_probe :: test_listing :: userspace lines list :: testcase skipped


which breaks otherwise nice output ;-)

jirka
