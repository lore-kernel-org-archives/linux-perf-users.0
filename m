Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD371C5499;
	Thu, 14 Aug 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191450; cv=none; b=isPCHPZlBZAfMX8Qf00/uOOFfwNL3eA/kCFhRFt4ZBSICyTHu4RGDVDshFqzgvRpmhJEcBceIOUFXht54TtS2RszNfdFhyMaMrivPL8xpS5qtABMAryTQHnhVyJ0SWlZjBC7xjjuIe2ozviyQmZCuifTXBfRlFyB8VBmUrL9hHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191450; c=relaxed/simple;
	bh=0UilVLBRQmcUeYVcORqikEOE/4O5h1ywi0EL0oU6T/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqirpuPy44Bi8PH9nOp6XNba1E9rvXm3EdX4M2AJWrEGmiWYgn18WIq/TtU0Y4DbvHQemogh5cDZtsF9oQ+rezpqifJ6vjTHv2zXGwHpMo8KO/l+1IYlkZpkcx01/mmpt6DfiRGaqeSodQ4gyRCH9NWKr1KwzB4smtWy//3HoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDpYYgn2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDpYYgn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755191449; x=1786727449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0UilVLBRQmcUeYVcORqikEOE/4O5h1ywi0EL0oU6T/I=;
  b=ZDpYYgn2Tg65fZv1o0jIQPWB6jUXwCUbGVHifCVbol4RdRNIC9NgeON5
   +mvhNZZyE7RD7MUYDWN51pSgi5IIxuxSBDAMbtUS4Fex4LFjsbZhv2t3o
   LDGavOYwdjC9XmkCu3CqbvnV3hZEXYdnors/vNM3rJFXI3MOAVyNLrThN
   uYyq7UpCYcTkNsVlER0g+d1qzy/rPBNCsNtAB49NGGDmBvUepNI2NikkY
   YDRj46LxVJy+dfM8flTzGLX2t0IbIuZjb+0Xc6BMYiSIdoI1v8ZlNocyy
   0dNNJmoNRXcIQXz+FH5okRttAF6sTEob/Nl+vbuOPj9AovXzlx1b5eG3N
   w==;
X-CSE-ConnectionGUID: eE6hNtUUQ9aIfk8DdFuXjw==
X-CSE-MsgGUID: FpPPPn2PR1ST+l4h0BaXxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61146678"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61146678"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 10:10:47 -0700
X-CSE-ConnectionGUID: s38axFLNR+u9VkMeyz1vbw==
X-CSE-MsgGUID: iWDVuTODRmCXvlttYl9MbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="165996379"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 10:10:47 -0700
Received: from [10.246.149.5] (kliang2-mobl1.ccr.corp.intel.com [10.246.149.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 23A0420B571C;
	Thu, 14 Aug 2025 10:10:46 -0700 (PDT)
Message-ID: <2166dd91-7838-4ba9-9a5f-43b7ba4a5ce2@linux.intel.com>
Date: Thu, 14 Aug 2025 10:10:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Add test case for event group throttling with
 inactive events
To: Yunseong Kim <ysk@kzalloc.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20250813163251.490451-2-ysk@kzalloc.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250813163251.490451-2-ysk@kzalloc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-13 9:32 a.m., Yunseong Kim wrote:
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

I don't think the test case should focus on the error messages. It can
easily be found by many other ways.
Also, the current bug can trigger errors in kmsg. You cannot guarantee
that all the failing cases trigger an error message.

I think the test should make sure that the closed event cannot be
accidentally reopened by the throttling mechanism.
If so, I think it would be better to compare the results of the disabled
event before and after throttling. There should be noting count.
The enabled event should be count normally.

Thanks,
Kan>
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

