Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F546BA;
	Sat,  9 Nov 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111272; cv=none; b=TIHZbOpcR7freWgUsa/qKdPMqlbyi5lDh+ArxVM0rIYfcFGWVB2NkUzqluyLBD3sLDxm895qd+ZZfXUAf9aLcId5zvwzHs8ri2RyTUK7UL7lXssmDhIcsknA3lSL3SiJTrFVUuVTn2wpAZQ2MqVnaZIsRkQfhdqVKs7d4nztJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111272; c=relaxed/simple;
	bh=QrIjeYEypWTOQvLqSMnMi86kaid9PJ5NEwZZQ/p/SFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4myvXN0k9hq8XcTu5EYwv0pr+lymLA+Ens8e3pt2sEJ0CztIyadYOiCH2pBtIOKo5jNtJ+24r9bOEnKlqGkVW3Eu6r3FJ1+/1GrVEL1ZrU6wHs75jA3zJrzIhM3d8Yur+EN0qu2fGn10z6u3/t/LcBS0xYzbnseX1C4ggq3pbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcwl5sqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcwl5sqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815E7C4CECD;
	Sat,  9 Nov 2024 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731111272;
	bh=QrIjeYEypWTOQvLqSMnMi86kaid9PJ5NEwZZQ/p/SFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcwl5sqO7jEs4hBqJzucHuT89QL4yVed7fYDUoyS0geqvPty2ZbYOw7gyNM3qnQfk
	 45kncNGMj0qc5GvFclFSKsAuCpO5JJxy7r0OCvnzOcmUF/3g43Jl3hSHLjZwqLrhZC
	 fgfx0B8GGuZLkvp6oDgmivhiD6RP8cb5IP30PRPk6czP5e4U9umTnuhG3cRmIqWuc5
	 VY+bzkNqZTyEzIvIC9kCZqNOspLFE/swQquF2FQg4O7viyU7cyuRdGJafQm4ps+Pov
	 8MV1REr+bjn6o2+Nosorjf9XFpAJQJ8y71xEN2U2mMW4KJZ9mtMZMzjcmx7I+Z049m
	 902rYvOabSB6Q==
Date: Fri, 8 Nov 2024 16:14:30 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: Re: [PATCH v2 3/4] perf test: Don't suppress the libtraceevent
 tests, skip them
Message-ID: <Zy6pZoMbDFrV_QaC@google.com>
References: <20241105142616.761042-1-acme@kernel.org>
 <20241105142616.761042-4-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105142616.761042-4-acme@kernel.org>

Hi Arnaldo,

On Tue, Nov 05, 2024 at 11:26:15AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> As suggested by Namhyung for the "import perf" python binding test, skip
> the tests that require perf being linked with libtraceevent, telling the
> reason:
> 
>   $ make -C tools/perf NO_LIBTRACEEVENT=1
>   # perf check feature libtraceevent
>          libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
>   # ldd ~/bin/perf | grep traceevent
>   #
>   # perf test
>     1: vmlinux symtab matches kallsyms                 : Ok
>     2: Detect openat syscall event                     : Skip (not linked with libtraceevent)
>     3: Detect openat syscall event on all cpus         : Skip (not linked with libtraceevent)
>     4: mmap interface tests                            :
>     4.1: Read samples using the mmap interface         : Skip (not linked with libtraceevent)
>     4.2: User space counter reading of instructions    : Skip (not linked with libtraceevent)
>     4.3: User space counter reading of cycles          : Skip (not linked with libtraceevent)
> <SNIP>
>    14: Parse sched tracepoints fields                  : Skip (not linked with libtraceevent)
>    15: syscalls:sys_enter_openat event fields          : Skip (not linked with libtraceevent)
> <SNIP>
>    32: Track with sched_switch                         : Skip (not linked with libtraceevent)
> <SNIP>
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linux.dev>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/Build                      | 12 +++++-----
>  tools/perf/tests/builtin-test.c             |  6 -----
>  tools/perf/tests/evsel-tp-sched.c           | 16 +++++++++++--
>  tools/perf/tests/mmap-basic.c               | 26 +++++++++++++++++++--
>  tools/perf/tests/openat-syscall-all-cpus.c  | 11 ++++++++-
>  tools/perf/tests/openat-syscall-tp-fields.c | 11 ++++++++-
>  tools/perf/tests/openat-syscall.c           | 11 ++++++++-
>  tools/perf/tests/switch-tracking.c          | 23 +++++++++++++++++-
>  8 files changed, 96 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 01ed9335db4dba4e..c57ac14e7114e291 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -5,13 +5,13 @@ perf-test-y += tests-scripts.o
>  perf-test-y += parse-events.o
>  perf-test-y += dso-data.o
>  perf-test-y += vmlinux-kallsyms.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-all-cpus.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-tp-fields.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) += mmap-basic.o
> +perf-test-y += openat-syscall.o
> +perf-test-y += openat-syscall-all-cpus.o
> +perf-test-y += openat-syscall-tp-fields.o
> +perf-test-y += mmap-basic.o
>  perf-test-y += perf-record.o
>  perf-test-y += evsel-roundtrip-name.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) += evsel-tp-sched.o
> +perf-test-y += evsel-tp-sched.o
>  perf-test-y += fdarray.o
>  perf-test-y += pmu.o
>  perf-test-y += pmu-events.o
> @@ -29,7 +29,7 @@ perf-test-y += task-exit.o
>  perf-test-y += sw-clock.o
>  perf-test-y += mmap-thread-lookup.o
>  perf-test-y += thread-maps-share.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) += switch-tracking.o
> +perf-test-y += switch-tracking.o
>  perf-test-y += keep-tracking.o
>  perf-test-y += code-reading.o
>  perf-test-y += sample-parsing.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index d2cabaa8ad922d68..5ebeaf3d7b69a8d0 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -60,11 +60,9 @@ static struct test_suite *arch_tests[] = {
>  
>  static struct test_suite *generic_tests[] = {
>  	&suite__vmlinux_matches_kallsyms,
> -#ifdef HAVE_LIBTRACEEVENT
>  	&suite__openat_syscall_event,
>  	&suite__openat_syscall_event_on_all_cpus,
>  	&suite__basic_mmap,
> -#endif
>  	&suite__mem,
>  	&suite__parse_events,
>  	&suite__expr,
> @@ -74,10 +72,8 @@ static struct test_suite *generic_tests[] = {
>  	&suite__tool_pmu,
>  	&suite__dso_data,
>  	&suite__perf_evsel__roundtrip_name_test,
> -#ifdef HAVE_LIBTRACEEVENT
>  	&suite__perf_evsel__tp_sched_test,
>  	&suite__syscall_openat_tp_fields,
> -#endif
>  	&suite__hists_link,
>  	&suite__python_use,
>  	&suite__bp_signal,
> @@ -95,9 +91,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__thread_maps_share,
>  	&suite__hists_output,
>  	&suite__hists_cumulate,
> -#ifdef HAVE_LIBTRACEEVENT
>  	&suite__switch_tracking,
> -#endif
>  	&suite__fdarray__filter,
>  	&suite__fdarray__add,
>  	&suite__kmod_path__parse,
> diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
> index 3da6a76eac3856d1..a7d3a59f01217280 100644
> --- a/tools/perf/tests/evsel-tp-sched.c
> +++ b/tools/perf/tests/evsel-tp-sched.c
> @@ -1,10 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/err.h>
> -#include <traceevent/event-parse.h>
>  #include "evsel.h"
>  #include "tests.h"
>  #include "debug.h"
>  
> +#ifdef HAVE_LIBTRACEEVENT
> +#include <traceevent/event-parse.h>

I'm about to process this for the header path.

https://lore.kernel.org/linux-perf-users/20241105105649.45399-1-yangyicong@huawei.com/

> +
>  static int evsel__test_field(struct evsel *evsel, const char *name, int size, bool should_be_signed)
>  {
>  	struct tep_format_field *field = evsel__field(evsel, name);
> @@ -31,10 +33,12 @@ static int evsel__test_field(struct evsel *evsel, const char *name, int size, bo
>  
>  	return ret;
>  }
> +#endif // HAVE_LIBTRACEEVENT
>  
>  static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unused,
>  					   int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT

It doesn't look good we need #ifdef every places.  Is it possible to
check it as an integer value and return early if it's not available?

	if (!HAVE_LIBTRACEEVENT)
		return TEST_SKIP;

I guess it'd break where it just checks if it's defined.  Probably we
need a separate global variable to be set using the value.

Obviously it cannot be applied if it needs to see the definition of
data type in the libtraceevent.  But I think encapsulated things
already.


>  	struct evsel *evsel = evsel__newtp("sched", "sched_switch");
>  	int ret = TEST_OK;
>  
> @@ -87,12 +91,20 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
>  
>  	evsel__delete(evsel);
>  	return ret;
> +#else
> +	return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>  
>  static struct test_case tests__perf_evsel__tp_sched_test[] = {
>  	TEST_CASE_REASON("Parse sched tracepoints fields",
>  			 perf_evsel__tp_sched_test,
> -			 "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +			 "permissions"
> +#else
> +			 "not linked with libtraceevent"
> +#endif

Hmm.. maybe it needs to update the reason of the skip.  Something like
this?

	if (!IS_ENABLED(CONFIG_LIBTRACEEVENT)) {
		test->skip_reason = "not linked with libtraceevent";
		return TEST_SKIP;
	}

Thanks,
Namhyung


> +			),
>  	{	.name = NULL, }
>  };
>  
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 012c8ae439fdcf56..f87ec3c40e091d5d 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -10,6 +10,7 @@
>  #include "evsel.h"
>  #include "thread_map.h"
>  #include "tests.h"
> +#include "tests/tests.h"
>  #include "util/mmap.h"
>  #include "util/sample.h"
>  #include <linux/err.h>
> @@ -31,6 +32,7 @@
>   */
>  static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>  	int err = TEST_FAIL;
>  	union perf_event *event;
>  	struct perf_thread_map *threads;
> @@ -167,10 +169,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>  out_free_threads:
>  	perf_thread_map__put(threads);
>  	return err;
> +#else
> +	return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>  
> -static int test_stat_user_read(int event)
> +static int test_stat_user_read(int event __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>  	struct perf_counts_values counts = { .val = 0 };
>  	struct perf_thread_map *threads;
>  	struct perf_evsel *evsel;
> @@ -264,6 +270,9 @@ static int test_stat_user_read(int event)
>  
>  	perf_thread_map__put(threads);
>  	return ret;
> +#else
> +	return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>  
>  static int test__mmap_user_read_instr(struct test_suite *test __maybe_unused,
> @@ -281,23 +290,36 @@ static int test__mmap_user_read_cycles(struct test_suite *test __maybe_unused,
>  static struct test_case tests__basic_mmap[] = {
>  	TEST_CASE_REASON("Read samples using the mmap interface",
>  			 basic_mmap,
> -			 "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +			 "permissions"
> +#else
> +			 "not linked with libtraceevent"
> +#endif
> +			),
>  	TEST_CASE_REASON("User space counter reading of instructions",
>  			 mmap_user_read_instr,
> +#ifdef HAVE_LIBTRACEEVENT
>  #if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
>  			 (defined(__riscv) && __riscv_xlen == 64)
>  			 "permissions"
>  #else
>  			 "unsupported"
> +#endif
> +#else
> +			 "not linked with libtraceevent"
>  #endif
>  		),
>  	TEST_CASE_REASON("User space counter reading of cycles",
>  			 mmap_user_read_cycles,
> +#ifdef HAVE_LIBTRACEEVENT
>  #if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
>  			 (defined(__riscv) && __riscv_xlen == 64)
>  			 "permissions"
>  #else
>  			 "unsupported"
> +#endif
> +#else
> +			 "not linked with libtraceevent"
>  #endif
>  		),
>  	{	.name = NULL, }
> diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
> index fb114118c87640b8..72dc22bef917f17d 100644
> --- a/tools/perf/tests/openat-syscall-all-cpus.c
> +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> @@ -22,6 +22,7 @@
>  static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __maybe_unused,
>  						  int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>  	int err = TEST_FAIL, fd, idx;
>  	struct perf_cpu cpu;
>  	struct perf_cpu_map *cpus;
> @@ -122,13 +123,21 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
>  out_thread_map_delete:
>  	perf_thread_map__put(threads);
>  	return err;
> +#else
> +	return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>  
>  
>  static struct test_case tests__openat_syscall_event_on_all_cpus[] = {
>  	TEST_CASE_REASON("Detect openat syscall event on all cpus",
>  			 openat_syscall_event_on_all_cpus,
> -			 "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +			 "permissions"
> +#else
> +			 "not linked with libtraceevent"
> +#endif
> +			),
>  	{	.name = NULL, }
>  };
>  
> diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
> index 3943da441979c0fc..cc0e31958646e88c 100644
> --- a/tools/perf/tests/openat-syscall-tp-fields.c
> +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> @@ -26,6 +26,7 @@
>  static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused,
>  					  int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>  	struct record_opts opts = {
>  		.target = {
>  			.uid = UINT_MAX,
> @@ -144,12 +145,20 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
>  	evlist__delete(evlist);
>  out:
>  	return ret;
> +#else
> +	return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>  
>  static struct test_case tests__syscall_openat_tp_fields[] = {
>  	TEST_CASE_REASON("syscalls:sys_enter_openat event fields",
>  			 syscall_openat_tp_fields,
> -			 "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +			 "permissions"
> +#else
> +			 "not linked with libtraceevent"
> +#endif
> +			),
>  	{	.name = NULL, }
>  };
>  
> diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
> index 131b62271bfa270b..2ca0b7d2cca7672e 100644
> --- a/tools/perf/tests/openat-syscall.c
> +++ b/tools/perf/tests/openat-syscall.c
> @@ -17,6 +17,7 @@
>  static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
>  				      int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>  	int err = TEST_FAIL, fd;
>  	struct evsel *evsel;
>  	unsigned int nr_openat_calls = 111, i;
> @@ -69,12 +70,20 @@ static int test__openat_syscall_event(struct test_suite *test __maybe_unused,
>  out_thread_map_delete:
>  	perf_thread_map__put(threads);
>  	return err;
> +#else
> +	return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>  
>  static struct test_case tests__openat_syscall_event[] = {
>  	TEST_CASE_REASON("Detect openat syscall event",
>  			 openat_syscall_event,
> -			 "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +			 "permissions"
> +#else
> +			 "not linked with libtraceevent"
> +#endif
> +			),
>  	{	.name = NULL, }
>  };
>  
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 5cab17a1942e67d7..591ae74b663af3c1 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -22,6 +22,7 @@
>  #include "util/sample.h"
>  #include "pmus.h"
>  
> +#ifdef HAVE_LIBTRACEEVENT
>  static int spin_sleep(void)
>  {
>  	struct timeval start, now, diff, maxtime;
> @@ -314,6 +315,7 @@ static int process_events(struct evlist *evlist,
>  	free_event_nodes(&events);
>  	return ret;
>  }
> +#endif // HAVE_LIBTRACEEVENT
>  
>  /**
>   * test__switch_tracking - test using sched_switch and tracking events.
> @@ -325,6 +327,7 @@ static int process_events(struct evlist *evlist,
>   */
>  static int test__switch_tracking(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>  	const char *sched_switch = "sched:sched_switch";
>  	const char *cycles = "cycles:u";
>  	struct switch_tracking switch_tracking = { .tids = NULL, };
> @@ -581,6 +584,24 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
>  out_err:
>  	err = -1;
>  	goto out;
> +#else
> +	return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>  
> -DEFINE_SUITE("Track with sched_switch", switch_tracking);
> +static struct test_case tests__switch_tracking[] = {
> +	{
> +		.name = "switch_tracking",
> +		.desc = "Track with sched_switch",
> +		.run_case = test__switch_tracking,
> +#ifndef HAVE_LIBTRACEEVENT
> +		.skip_reason = "not linked with libtraceevent",
> +#endif
> +	},
> +	{	.name = NULL, }
> +};
> +
> +struct test_suite suite__switch_tracking = {
> +	.desc = "Track with sched_switch",
> +	.test_cases = tests__switch_tracking,
> +};
> -- 
> 2.47.0
> 
