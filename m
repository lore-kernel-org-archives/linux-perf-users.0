Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B220C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6637961BFB
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 12:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhKPMyW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:54:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236390AbhKPMyV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Nov 2021 07:54:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E695361BF6;
        Tue, 16 Nov 2021 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637067084;
        bh=hNWrCBvNIwOpy/dKK0KAFyGJtAhtz+Xu5PosDrypwq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mK/jhGYpFezl5TgLzDAbRd4kYcIoYnDPMpyQAD9hvGKELZ72CQghA6Ej6IElnndKx
         diINfNGmHMTsBzvWB+fGdnrtVTaV15msrnKTWMWpFIl+kNtiiOTn0Lj97/W1hOeZez
         k5TzZf/4jR5hCsyzFckWKlPi1ky74FZPkUnmDdDvAEdo5dDCkpG+QdrLnY9xUDtBSJ
         0hpOy9KC1UF0fh/TijvfwsxL8TWNiNf3MdD3huD58V6xz5ida+pGHwg7jEtWWob3Ur
         IM7HQDFje4io2UNQhx2d+V7jB7BzOvHVSZf3QfFmwwOpptvYw0D64d4A90deUYcyJA
         DDguqmazGvd5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 371D54088E; Tue, 16 Nov 2021 09:51:21 -0300 (-03)
Date:   Tue, 16 Nov 2021 09:51:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] perf test: Add basic stress test for sigtrap handling
Message-ID: <YZOpSVOCXe0zWeRs@kernel.org>
References: <20211115112822.4077224-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115112822.4077224-1-elver@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Nov 15, 2021 at 12:28:23PM +0100, Marco Elver escreveu:
> Add basic stress test for sigtrap handling as a perf tool built-in test.
> This allows sanity checking the basic sigtrap functionality from within
> the perf tool.

Works as root:

[root@five ~]# perf test sigtrap
73: Sigtrap                                                         : Ok
[root@five ~]

Not for !root:

⬢[acme@toolbox perf]$ perf test sigtrap
73: Sigtrap                                                         : FAILED!
⬢[acme@toolbox perf]$ perf test -v sigtrap
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
73: Sigtrap                                                         :
--- start ---
test child forked, pid 3812428
FAILED sys_perf_event_open()
test child finished with -1
---- end ----
Sigtrap: FAILED!
⬢[acme@toolbox perf]$

I'll add the following patch on top of it, with it I get:

⬢[acme@toolbox perf]$ perf test sigtrap
73: Sigtrap                                                         : FAILED!
⬢[acme@toolbox perf]$ perf test -v sigtrap
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
73: Sigtrap                                                         :
--- start ---
test child forked, pid 3816772
FAILED sys_perf_event_open(): Permission denied
test child finished with -1
---- end ----
Sigtrap: FAILED!
⬢[acme@toolbox perf]$


diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index febfa1609356c4c5..6344704619cd8a49 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -5,9 +5,11 @@
  * Copyright (C) 2021, Google LLC.
  */
 
+#include <errno.h>
 #include <stdint.h>
 #include <stdlib.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/string.h>
 #include <pthread.h>
 #include <signal.h>
 #include <sys/ioctl.h>
@@ -115,6 +117,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 	struct sigaction oldact;
 	pthread_t threads[NUM_THREADS];
 	pthread_barrier_t barrier;
+	char sbuf[STRERR_BUFSIZE];
 	int i, fd, ret = TEST_FAIL;
 
 	pthread_barrier_init(&barrier, NULL, NUM_THREADS + 1);
@@ -123,19 +126,19 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 	action.sa_sigaction = sigtrap_handler;
 	sigemptyset(&action.sa_mask);
 	if (sigaction(SIGTRAP, &action, &oldact)) {
-		pr_debug("FAILED sigaction()\n");
+		pr_debug("FAILED sigaction(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out;
 	}
 
 	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
 	if (fd < 0) {
-		pr_debug("FAILED sys_perf_event_open()\n");
+		pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_restore_sigaction;
 	}
 
 	for (i = 0; i < NUM_THREADS; i++) {
 		if (pthread_create(&threads[i], NULL, test_thread, &barrier)) {
-			pr_debug("FAILED pthread_create()");
+			pr_debug("FAILED pthread_create(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
 			goto out_close_perf_event;
 		}
 	}


 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/sigtrap.c      | 154 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  4 files changed, 157 insertions(+)
>  create mode 100644 tools/perf/tests/sigtrap.c
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 803ca426f8e6..af2b37ef7c70 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -65,6 +65,7 @@ perf-y += pe-file-parsing.o
>  perf-y += expand-cgroup.o
>  perf-y += perf-time-to-tsc.o
>  perf-y += dlfilter-test.o
> +perf-y += sigtrap.o
>  
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>  	$(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 8cb5a1c3489e..f1e6d2a3a578 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -107,6 +107,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__expand_cgroup_events,
>  	&suite__perf_time_to_tsc,
>  	&suite__dlfilter,
> +	&suite__sigtrap,
>  	NULL,
>  };
>  
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> new file mode 100644
> index 000000000000..febfa1609356
> --- /dev/null
> +++ b/tools/perf/tests/sigtrap.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Basic test for sigtrap support.
> + *
> + * Copyright (C) 2021, Google LLC.
> + */
> +
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <linux/hw_breakpoint.h>
> +#include <pthread.h>
> +#include <signal.h>
> +#include <sys/ioctl.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +#include "cloexec.h"
> +#include "debug.h"
> +#include "event.h"
> +#include "tests.h"
> +#include "../perf-sys.h"
> +
> +#define NUM_THREADS 5
> +
> +static struct {
> +	int tids_want_signal;		/* Which threads still want a signal. */
> +	int signal_count;		/* Sanity check number of signals received. */
> +	volatile int iterate_on;	/* Variable to set breakpoint on. */
> +	siginfo_t first_siginfo;	/* First observed siginfo_t. */
> +} ctx;
> +
> +#define TEST_SIG_DATA (~(unsigned long)(&ctx.iterate_on))
> +
> +static struct perf_event_attr make_event_attr(void)
> +{
> +	struct perf_event_attr attr = {
> +		.type		= PERF_TYPE_BREAKPOINT,
> +		.size		= sizeof(attr),
> +		.sample_period	= 1,
> +		.disabled	= 1,
> +		.bp_addr	= (unsigned long)&ctx.iterate_on,
> +		.bp_type	= HW_BREAKPOINT_RW,
> +		.bp_len		= HW_BREAKPOINT_LEN_1,
> +		.inherit	= 1, /* Children inherit events ... */
> +		.inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
> +		.remove_on_exec = 1, /* Required by sigtrap. */
> +		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
> +		.sig_data	= TEST_SIG_DATA,
> +	};
> +	return attr;
> +}
> +
> +static void
> +sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
> +{
> +	if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
> +		ctx.first_siginfo = *info;
> +	__atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
> +}
> +
> +static void *test_thread(void *arg)
> +{
> +	pthread_barrier_t *barrier = (pthread_barrier_t *)arg;
> +	pid_t tid = syscall(SYS_gettid);
> +	int i;
> +
> +	pthread_barrier_wait(barrier);
> +
> +	__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
> +	for (i = 0; i < ctx.iterate_on - 1; i++)
> +		__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
> +
> +	return NULL;
> +}
> +
> +static int run_test_threads(pthread_t *threads, pthread_barrier_t *barrier)
> +{
> +	int i;
> +
> +	pthread_barrier_wait(barrier);
> +	for (i = 0; i < NUM_THREADS; i++)
> +		TEST_ASSERT_EQUAL("pthread_join() failed", pthread_join(threads[i], NULL), 0);
> +
> +	return TEST_OK;
> +}
> +
> +static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrier)
> +{
> +	int ret;
> +
> +	ctx.iterate_on = 3000;
> +
> +	TEST_ASSERT_EQUAL("misfired signal?", ctx.signal_count, 0);
> +	TEST_ASSERT_EQUAL("enable failed", ioctl(fd, PERF_EVENT_IOC_ENABLE, 0), 0);
> +	ret = run_test_threads(threads, barrier);
> +	TEST_ASSERT_EQUAL("disable failed", ioctl(fd, PERF_EVENT_IOC_DISABLE, 0), 0);
> +
> +	TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_THREADS * ctx.iterate_on);
> +	TEST_ASSERT_EQUAL("missing signals or incorrectly delivered", ctx.tids_want_signal, 0);
> +	TEST_ASSERT_VAL("unexpected si_addr", ctx.first_siginfo.si_addr == &ctx.iterate_on);
> +#if 0 /* FIXME: enable when libc's signal.h has si_perf_{type,data} */
> +	TEST_ASSERT_EQUAL("unexpected si_perf_type", ctx.first_siginfo.si_perf_type,
> +			  PERF_TYPE_BREAKPOINT);
> +	TEST_ASSERT_EQUAL("unexpected si_perf_data", ctx.first_siginfo.si_perf_data,
> +			  TEST_SIG_DATA);
> +#endif
> +
> +	return ret;
> +}
> +
> +static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> +{
> +	struct perf_event_attr attr = make_event_attr();
> +	struct sigaction action = {};
> +	struct sigaction oldact;
> +	pthread_t threads[NUM_THREADS];
> +	pthread_barrier_t barrier;
> +	int i, fd, ret = TEST_FAIL;
> +
> +	pthread_barrier_init(&barrier, NULL, NUM_THREADS + 1);
> +
> +	action.sa_flags = SA_SIGINFO | SA_NODEFER;
> +	action.sa_sigaction = sigtrap_handler;
> +	sigemptyset(&action.sa_mask);
> +	if (sigaction(SIGTRAP, &action, &oldact)) {
> +		pr_debug("FAILED sigaction()\n");
> +		goto out;
> +	}
> +
> +	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> +	if (fd < 0) {
> +		pr_debug("FAILED sys_perf_event_open()\n");
> +		goto out_restore_sigaction;
> +	}
> +
> +	for (i = 0; i < NUM_THREADS; i++) {
> +		if (pthread_create(&threads[i], NULL, test_thread, &barrier)) {
> +			pr_debug("FAILED pthread_create()");
> +			goto out_close_perf_event;
> +		}
> +	}
> +
> +	ret = run_stress_test(fd, threads, &barrier);
> +
> +out_close_perf_event:
> +	close(fd);
> +out_restore_sigaction:
> +	sigaction(SIGTRAP, &oldact, NULL);
> +out:
> +	pthread_barrier_destroy(&barrier);
> +	return ret;
> +}
> +
> +DEFINE_SUITE("Sigtrap", sigtrap);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 8f65098110fc..5bbb8f6a48fc 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -146,6 +146,7 @@ DECLARE_SUITE(pe_file_parsing);
>  DECLARE_SUITE(expand_cgroup_events);
>  DECLARE_SUITE(perf_time_to_tsc);
>  DECLARE_SUITE(dlfilter);
> +DECLARE_SUITE(sigtrap);
>  
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints using the
> -- 
> 2.34.0.rc1.387.gb447b232ab-goog

-- 

- Arnaldo
