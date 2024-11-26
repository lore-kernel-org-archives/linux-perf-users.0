Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525B1CBEA4
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626520; cv=none; b=Zw0zdHI7Hq5Kz6Wepbc9heiXtEnAQtN42dQAtZEIRBMHbWJSnB/ymyrKe9TdZ54GWsljugRzgTtNINhxLFcuaEwo0nCZD6uMiGkFEHTP9ji3swm6XeZ4TKicFB0xeyqMek7mEU77OJ4SHTORxqMVM4gBx26C7/HguUKR/vFnS68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626520; c=relaxed/simple;
	bh=bLpl3tYuDEt9O5K0IWIBOVcOMOWV3eCaOMMHky+xf+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/UnQoovxHcoh6Wz2AWsKmniK72mcHtOJ+lezqBC1lneoaE1+/FsKGqtlAUxCfBoVirEGNyaoaoYQSjeLkVF1AzlFyttpGstwsFgQDgZ/zCROQGr2DGvCBcm3+Q6iOCmo5y90ZTAa4SPNveombuBOcDSGbRgEH7h2SNMH+1lMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Tue, 26 Nov 2024 14:08:32 +0100
From: Guilherme Amadio <amadio@gentoo.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com
Subject: Re: SIGSEGV on perf's 'Basic parsing test'
Message-ID: <Z0XIUP4PK064Rdue@gentoo.org>
References: <Z0D8a10VE1oIucuZ@gentoo.org>
 <Z0VgyFKPCo-Ync8E@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0VgyFKPCo-Ync8E@google.com>

Dear Namhyung, Ian,

On Mon, Nov 25, 2024 at 09:46:48PM -0800, Namhyung Kim wrote:
> On Fri, Nov 22, 2024 at 10:49:31PM +0100, Guilherme Amadio wrote:
> > Dear Arnaldo, Namhyung, Ian,
> > 
> > I noticed that on perf-tools-next, some new tests fail on my machine
> > with a segmentation fault. I am on perf-tools-next at the following
> > commit: 85c60a01b85ee956adf8d46c253fc50f75363e8f.
> 
> I've added a couple of fixes for the HWMON tests.  Can you please test
> it again with the latest branch?

Thank you. The test no longer crashes, which is good. However, it still
fails as shown below:

gentoo perf $ sudo ./perf test 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name                                         : FAILED!
gentoo perf $ sudo ./perf test -vF 11
--- start ---
---- end ----
 11.1: Basic parsing test                                            : Ok
--- start ---
Testing 'temp_test_hwmon_event1'
Using CPUID AuthenticAMD-23-71-0
hwmon_pmu: removing event 'pwm3' that has no input file
hwmon_pmu: removing event 'intrusion0' that has no input file
hwmon_pmu: removing event 'pwm5' that has no input file
hwmon_pmu: removing event 'pwm2' that has no input file
hwmon_pmu: removing event 'pwm7' that has no input file
hwmon_pmu: removing event 'pwm4' that has no input file
hwmon_pmu: removing event 'pwm1' that has no input file
hwmon_pmu: removing event 'intrusion1' that has no input file
hwmon_pmu: removing event 'fan5' that has no input file
FAILED tests/hwmon_pmu.c:159 failed to parse event 'temp_test_hwmon_event1', err 1
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
---- end ----
 11.2: Parsing without PMU name                                      : FAILED!
--- start ---
Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
FAILED tests/hwmon_pmu.c:159 failed to parse event 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/', err 1
event syntax error: 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
                     \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'hwmon_a_test_hwmon_pmu'
---- end ----
 11.3: Parsing with PMU name                                         : FAILED!

Best regards,
-Guilherme

> Thanks,
> Namhyung
> 
> > 
> > After compiling perf with DEBUG=1 and running the test on gdb, this is
> > the stack trace that I get from the crash:
> > 
> > Reading symbols from ./perf...
> > (gdb) run
> > Starting program: /home/amadio/src/linux/tools/perf/perf test -F 11
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> >  11.1: Basic parsing test                                            : Ok
> > event syntax error: 'temp_test_hwmon_event1'
> >                      \___ Bad event name
> > 
> > Unable to find event on a PMU of 'temp_test_hwmon_event1'
> > 
> > Program received signal SIGSEGV, Segmentation fault.
> > __GI___libc_free (mem=0x1c0b4908070c0a7a) at malloc.c:3375
> > 3375      if (chunk_is_mmapped (p))                       /* release mmapped memory. */
> > (gdb) bt
> > #0  __GI___libc_free (mem=0x1c0b4908070c0a7a) at malloc.c:3375
> > #1  0x000055555564fbc8 in __zfree (ptr=0x7ffff6c00031) at ../../lib/zalloc.c:13
> > #2  0x000055555581997c in evsel__free_stat_priv (evsel=0x5555560d8ca0) at util/stat.c:148
> > #3  0x0000555555819c90 in evlist__free_stats (evlist=0x5555560d7d30) at util/stat.c:215
> > #4  0x000055555575d0dc in evlist__delete (evlist=0x5555560d7d30) at util/evlist.c:187
> > #5  0x00005555557124d9 in do_test (i=0, with_pmu=false, with_alias=false) at tests/hwmon_pmu.c:198
> > #6  0x0000555555712587 in test__hwmon_pmu (with_pmu=false) at tests/hwmon_pmu.c:212
> > #7  0x000055555571263b in test__hwmon_pmu_without_pmu (test=0x55555605ae40 <suite.hwmon_pmu>, subtest=1) at tests/hwmon_pmu.c:229
> > #8  0x00005555556c8e9d in start_test (test=0x55555605ae40 <suite.hwmon_pmu>, i=10, subi=1, child=0x5555560d7818, width=64, pass=1) at tests/builtin-test.c:424
> > #9  0x00005555556c9588 in __cmd_test (suites=0x5555560d73e0, argc=1, argv=0x7fffffffe200, skiplist=0x0) at tests/builtin-test.c:571
> > #10 0x00005555556ca0b5 in cmd_test (argc=1, argv=0x7fffffffe200) at tests/builtin-test.c:773
> > #11 0x0000555555645459 in run_builtin (p=0x555556047050 <commands+624>, argc=3, argv=0x7fffffffe200) at perf.c:351
> > #12 0x0000555555645704 in handle_internal_command (argc=3, argv=0x7fffffffe200) at perf.c:404
> > #13 0x0000555555645865 in run_argv (argcp=0x7fffffffe00c, argv=0x7fffffffe000) at perf.c:448
> > #14 0x0000555555645bb6 in main (argc=3, argv=0x7fffffffe200) at perf.c:560
> > (gdb) quit
> > 
> > 
> > Please let me know what other information you'd like to have from my system.
> > The CPU is an AMD 3950X and the motherboard is an ASUS Pro WS X570-ACE if that
> > helps.
> > 
> > $ uname -a
> > Linux gentoo.cern.ch 6.12.0-gentoo #1 SMP PREEMPT_DYNAMIC Mon Nov 18 16:50:03 CET 2024 x86_64 AMD Ryzen 9 3950X 16-Core Processor AuthenticAMD GNU/Linux
> > $ dmesg | sed -ne '/DMI/{p; q}'
> > [    0.000000] DMI: ASUS System Product Name/Pro WS X570-ACE, BIOS 4902 08/29/2024
> > 
> > Best regards,
> > -Guilherme
> > 
