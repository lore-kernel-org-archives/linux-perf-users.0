Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092231986E;
	Thu, 14 Aug 2025 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755201979; cv=none; b=qb2BN2vX8ZI+qjILIGyDKdwqlRSj5bl47PJnFXVdJlw7zSVQOSLwczEhsw7zG+ccr8CgQKRhlLggQN4J2H9WCuvaai5rfo/mipSAVxlhZFEg+R0FsV7byIJe+8OZROuZDbMeUYFQ7AchDqhq7vjpSRZ88J1m2T2sBoPsGYlBhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755201979; c=relaxed/simple;
	bh=DSEVssbYUW7EyFNuLSgJP6Mv9qIDhRmUfjzP270dk4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpzUqrR8hfIFm64HhJNqvt5mA+QW02diLDOes83Xv5fk8Kb9kaM9znRHNEqkfYbtXdyfeRKC3q3W9JqxjaZvwKMhKOKDXUoLlFkpFuLy1cMzgZu4tYS20TV1RApSGoK9v0rDoDo5S11hR/V1Xhjt2TEsKNdJJMLfJOdPlbmA1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP9lAoce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP9lAoce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A05CC4CEED;
	Thu, 14 Aug 2025 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755201977;
	bh=DSEVssbYUW7EyFNuLSgJP6Mv9qIDhRmUfjzP270dk4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XP9lAocefRcO21s2gc28mBdiZ0ZRwcyh8VXqxXpvYSfNV/hPuWrIxJzLm35ed38Pi
	 /hJmwnzZyNeXbuVFF5FMp4WeN70XS5uaOUs1DXquSIBBv9FeRZ0UetCAgKewNE8RX9
	 4rrHdY/pFMBzHKfH7NUekomLyG+JdLojM4zuEDgJdsHj9aGh5AzriobGPfw8sKdUcT
	 60ph8erWUjJILDOOYSrc3nUXlGPvnF6nK04EeR3PCAJfY3XxcLhtFB60aULie5WRgR
	 HpfdBypBrQflldgb+IeMQC8vRChl8KsdEojDigStV2yiUCQyY8gPfAyMnhUJXRnPK8
	 /mONfczzJGqdw==
Date: Thu, 14 Aug 2025 13:06:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Add test case for event group throttling with
 inactive events
Message-ID: <aJ5Bt1q3AZFxxz_U@google.com>
References: <20250813163251.490451-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813163251.490451-2-ysk@kzalloc.com>

Hi Yunseong,

On Wed, Aug 13, 2025 at 04:32:52PM +0000, Yunseong Kim wrote:
> A recent UBSAN shift-out-of-bounds report was identified when throttling
> event groups that included inactive (PERF_EVENT_STATE_OFF) events.
> This occurred because pmu->start()/stop() could be called on these events,
> potentially leaving event->hw.idx at -1. This leads to undefined behavior
> when PMU code later uses this negative index as a shift exponent.
> 
> The issue need to ensuring perf_event_throttle() and
> perf_event_unthrottle() skip inactive events entirely.
> 
> Introduce a new perf test suite, "event group throttle", to verify this
> fix and prevent regressions.

Thanks for your work!

I'm curious what happens if it runs on unfixed kernels.  I suspect this
should be in the selftest so that it can tie with the kernel fix.

By having this in the perf tools test suite, you cannot guarantee if the
kernel has the fix.  And it may turn the kernel into an unstable state
easily.

Thanks,
Namhyung

> 
> The test sets up a scenario designed to trigger frequent throttling:
> 1. A parent event (leader) is created with sample_period = 1.
> 2. A child event is created in the same group but initialized with
>    disabled = 1 (inactive).
> 
> A process opens these events and runs in a tight loop. The frequent
> sampling of the leader causes the entire group, including the inactive
> child event, to be rapidly throttled and unthrottled by the kernel.
> 
> The test monitors /dev/kmsg during execution, looking for "UBSAN",
> "Invalid PMEV" "WARNING:", or "BUG:" messages.
> 
> To ensure robustness and avoid false positives from unrelated prior kernel
> messages, the test opens /dev/kmsg and uses lseek(SEEK_END) to skip all
> existing log entries before starting the test loop. If /dev/kmsg cannot be
> accessed or seeked (e.g., lack of CAP_SYSLOG), the test handles it
> appropriately by skipping or failing.
> 
> Related Reproducer by Mark Rutland
> Link: https://lore.kernel.org/lkml/aIEePonPatjNrJVk@J2N7QTR9R3/
> 
> Related Kernel Fix
> Link: https://lore.kernel.org/lkml/20250812012722.127646-1-ysk@kzalloc.com/
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> ---
>  tools/perf/tests/Build                  |   1 +
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/event_group_throttle.c | 132 ++++++++++++++++++++++++
>  tools/perf/tests/tests.h                |   1 +
>  4 files changed, 135 insertions(+)
>  create mode 100644 tools/perf/tests/event_group_throttle.c
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 3e8394be15ae..e22e2f285500 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -70,6 +70,7 @@ perf-test-y += util.o
>  perf-test-y += hwmon_pmu.o
>  perf-test-y += tool_pmu.o
>  perf-test-y += subcmd-help.o
> +perf-test-y += event_group_throttle.o
>  
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
>  perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 85142dfb3e01..d302bf9d1535 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -141,6 +141,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__symbols,
>  	&suite__util,
>  	&suite__subcmd_help,
> +	&suite__event_group_throttle,
>  	NULL,
>  };
>  
> diff --git a/tools/perf/tests/event_group_throttle.c b/tools/perf/tests/event_group_throttle.c
> new file mode 100644
> index 000000000000..7d5191d7e812
> --- /dev/null
> +++ b/tools/perf/tests/event_group_throttle.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <time.h>
> +#include <sys/wait.h>
> +#include <signal.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <linux/perf_event.h>
> +#include "perf-sys.h"
> +#include "tests.h"
> +#include "debug.h"
> +
> +static struct perf_event_attr attr_parent = {
> +	.type = PERF_TYPE_HARDWARE,
> +	.size = sizeof(attr_parent),
> +	.config = PERF_COUNT_HW_CPU_CYCLES,
> +	.sample_period = 1,
> +	.exclude_kernel = 1,
> +};
> +
> +static struct perf_event_attr attr_child = {
> +	.type = PERF_TYPE_HARDWARE,
> +	.size = sizeof(attr_child),
> +	.config = PERF_COUNT_HW_CPU_CYCLES,
> +	.exclude_kernel = 1,
> +	.disabled = 1,
> +};
> +
> +static pid_t run_event_group_throttle(void)
> +{
> +	pid_t pid = fork();
> +
> +	if (pid == 0) {
> +		int parent, child;
> +
> +		parent = sys_perf_event_open(&attr_parent, 0, -1, -1, 0);
> +		if (parent < 0) {
> +			pr_debug("Unable to create event: %d\n", parent);
> +			exit(-1);
> +		}
> +
> +		child = sys_perf_event_open(&attr_child, 0, -1, parent, 0);
> +		if (child < 0) {
> +			pr_debug("Unable to create event: %d\n", child);
> +			exit(-1);
> +		}
> +
> +		for (;;)
> +			asm("" ::: "memory");
> +
> +		_exit(0);
> +	}
> +	return pid;
> +}
> +
> +static bool is_kmsg_err(int fd)
> +{
> +	char buf[1024];
> +	ssize_t len;
> +
> +	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
> +		buf[len] = '\0';
> +
> +		if (strstr(buf, "UBSAN") || strstr(buf, "WARNING:") ||
> +		    strstr(buf, "BUG:") || strstr(buf, "Invalid PMEV")) {
> +			pr_debug("Kernel log error detected: %s", buf);
> +			return true;
> +		}
> +	}
> +
> +	if (len < 0 && errno != EAGAIN) {
> +		pr_debug("Error reading /dev/kmsg: %s\n", strerror(errno));
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int test__event_group_throttle(struct test_suite *test __maybe_unused,
> +				int subtest __maybe_unused)
> +{
> +	time_t start;
> +	pid_t pid;
> +	int fd;
> +
> +	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
> +	if (fd < 0) {
> +		/*
> +		 * If /dev/kmsg cannot be opened (e.g. permission denied), skip the test
> +		 * as we cannot verify the absence of kernel errors.
> +		 */
> +		pr_debug("Failed to open /dev/kmsg: %s. Skipping test.\n", strerror(errno));
> +		return TEST_SKIP;
> +	}
> +
> +	/*
> +	 * Seek to the end to ignore past events (like EFI boot warnings).
> +	 * This typically requires CAP_SYSLOG.
> +	 */
> +	if (lseek(fd, 0, SEEK_END) < 0) {
> +		pr_debug("Failed to seek to end of /dev/kmsg: %s\n", strerror(errno));
> +		return TEST_FAIL;
> +	}
> +
> +	start = time(NULL);
> +	do {
> +		pr_debug("Starting event group throttling...\n");
> +		pid = run_event_group_throttle();
> +
> +		sleep(8);
> +
> +		pr_debug("event group throttler(PID=%d)\n", pid);
> +		kill(pid, SIGKILL);
> +		waitpid(pid, NULL, 0);
> +
> +		/* Check for errors during the run */
> +		if (is_kmsg_err(fd)) {
> +			close(fd);
> +			return TEST_FAIL;
> +		}
> +	} while (time(NULL) - start < 10);
> +
> +	return TEST_OK;
> +}
> +
> +DEFINE_SUITE("event group throttle", event_group_throttle);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 97e62db8764a..031856a710b2 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -179,6 +179,7 @@ DECLARE_SUITE(event_groups);
>  DECLARE_SUITE(symbols);
>  DECLARE_SUITE(util);
>  DECLARE_SUITE(subcmd_help);
> +DECLARE_SUITE(event_group_throttle);
>  
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints using the
> -- 
> 2.50.0
> 
