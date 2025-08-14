Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92921C176;
	Thu, 14 Aug 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202666; cv=none; b=WbxY7bHE2KalQ4xYGpM/+ppnuNRn4J6FAcsR8n6JxANhVTX6j07yrjJo8p9lRnFiUeRZxtwe6PJTMGSoB3XRpMGCmTFMyLpZ5S2GS4xCb6WCz/FOoMlqT6lgZkrDY5hdGwuiVqiGgHHSLSHoejiZZNtpOTFx4d1xjXSQtYSQOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202666; c=relaxed/simple;
	bh=9e8v5kOR3PZ87QHVrrTk11R5Rs66wpPbSHI98cR4aPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmEbr5iWxZwwYX12Ua6rk/23Es0endMqG5w+RCOn9lByTGAq2EwBXk9RqQ6I1bIiFCDj5hQd8nCcmKJy790ISNYKWmWWQBZpfjcDI6jRRyqsIEiyZHphFvs9sq7Jfp88WL9GUZdQEb41H1f+/iHiyQJEyi+/SGW6vgyV7vVmqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4717384710so179393a12.1;
        Thu, 14 Aug 2025 13:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202664; x=1755807464;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvj6SKhift+LlIF14/+ugsBeD23sBew6ofzYvk9SRA4=;
        b=oTnmlYl64WHpOAiR/nqlaaSkAU/XT935jRDh1eA2Va6CbtjzqcuKbILiR3YPCJMzsd
         3cxfX/T3MplH+sncj1evDVbPWR/Nw4u9iL87JNHbLntCIgO5JbsaMnv2NSrq/cBmRCId
         Cr3e3JqGXOnVz4VYhRbEXGvCBAZp9ym6rrhFYhO3wYu/cx9bqv/E3g1JQ3fXFJGQtxNd
         nlpWgooAkqzFnBLuYdjwZPOMYx21b1J+pbHGi0q523DwIISxT8AqKMw0V43CIJaXFdof
         dy3jDDNr1O4D+iZFF982Uq+0W0w2niDEnQxeCpegimhnlzS2yMZGnNxcz6V0/3aTJ/P0
         060g==
X-Forwarded-Encrypted: i=1; AJvYcCUH4ml3iukla1sssv9vNRB/2PUsn7XTqib1YyW+qd5ZzinzFmnntihXUJHut9yudjh5pBnXDkMAK2iYVulox8Cbog==@vger.kernel.org, AJvYcCUuVWwG7oPHwyf4g5np6wHapPhpkonGTnlVOg+1y8uSU5V49veuWCQ4ZnL8nAoVvX8JF4jnrnVIoBa/Zbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9QKw6VL0RMVBt727FxTUhcvz1h3l7t5/kM7MH8vNQZ122l3n5
	JfKdlg5/fQ4moxVdcijo2D1Cs2rYTQbecd3itGD4pmR/Fgl0vk9tFtGy
X-Gm-Gg: ASbGncvkmUbBsIJQkjI8AN8ABaT097TC93DDrJDI5Xaf4zf66i+Uv116mnzMa85Go+P
	a7I15jP7Tmzl76X4rfLXmsy3B2RKeUVgAOpVh/6n/de0y4b5lNVnqvAxytjZroatTE+/xkR9E2b
	1/Ma3achgkj0bYiAIiGyMCBu4CkyHacV2s5nn6YPBqAqseNp6PrZMV6zxarCib+GsoGsy2wKp86
	UeRyMg3vNb1mNo6jKiTRtIY0WT9EcptFExxZ88hrEf1Fhc000AFl8hoia74ZdxogZYrXlFvhGbX
	J11lF8SHojlbAhi/G2CZpNuCfiE0fxvSGoUJtao9QSViq47AIydF9yLUGYzfG6OxGRARLVzzqNr
	rAL8EEIo5mB5l5c2Js33msSxNhtCFW5LRm4gimAqyZ8A=
X-Google-Smtp-Source: AGHT+IE2iCf24VCFAVC0TjcGj05sxHyyP3zKoWJMSVHSiSSZ55Ms9KEvQwpxjuwS605N+f6JSO6LyA==
X-Received: by 2002:a17:902:d4c7:b0:240:7c3c:dd7b with SMTP id d9443c01a7336-244586b63famr33121015ad.7.1755202664222;
        Thu, 14 Aug 2025 13:17:44 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b642931sm30163998a12.0.2025.08.14.13.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:17:43 -0700 (PDT)
Message-ID: <33e0a02b-8d50-4cbf-b247-8859f972a598@kzalloc.com>
Date: Fri, 15 Aug 2025 05:17:38 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Add test case for event group throttling with
 inactive events
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20250813163251.490451-2-ysk@kzalloc.com>
 <2166dd91-7838-4ba9-9a5f-43b7ba4a5ce2@linux.intel.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <2166dd91-7838-4ba9-9a5f-43b7ba4a5ce2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Liang,

Thanks for your feedback.

On 8/15/25 2:10 AM, Liang, Kan wrote:
> 
> 
> On 2025-08-13 9:32 a.m., Yunseong Kim wrote:
>> A recent UBSAN shift-out-of-bounds report was identified when throttling
>> event groups that included inactive (PERF_EVENT_STATE_OFF) events.
>> This occurred because pmu->start()/stop() could be called on these events,
>> potentially leaving event->hw.idx at -1. This leads to undefined behavior
>> when PMU code later uses this negative index as a shift exponent.
>>
>> The issue need to ensuring perf_event_throttle() and
>> perf_event_unthrottle() skip inactive events entirely.
>>
>> Introduce a new perf test suite, "event group throttle", to verify this
>> fix and prevent regressions.
>>
>> The test sets up a scenario designed to trigger frequent throttling:
>> 1. A parent event (leader) is created with sample_period = 1.
>> 2. A child event is created in the same group but initialized with
>>    disabled = 1 (inactive).
>>
>> A process opens these events and runs in a tight loop. The frequent
>> sampling of the leader causes the entire group, including the inactive
>> child event, to be rapidly throttled and unthrottled by the kernel.
>>
>> The test monitors /dev/kmsg during execution, looking for "UBSAN",
>> "Invalid PMEV" "WARNING:", or "BUG:" messages.
> 
> I don't think the test case should focus on the error messages. It can
> easily be found by many other ways.
> Also, the current bug can trigger errors in kmsg. You cannot guarantee
> that all the failing cases trigger an error message.
> 
> I think the test should make sure that the closed event cannot be
> accidentally reopened by the throttling mechanism.
> If so, I think it would be better to compare the results of the disabled
> event before and after throttling. There should be noting count.
> The enabled event should be count normally.
> 
> Thanks,
> Kan>

I agree with your suggestion to change the test case. I will modify the
test to verify the count of the disabled event instead of relying on kernel
log messages.

>> To ensure robustness and avoid false positives from unrelated prior kernel
>> messages, the test opens /dev/kmsg and uses lseek(SEEK_END) to skip all
>> existing log entries before starting the test loop. If /dev/kmsg cannot be
>> accessed or seeked (e.g., lack of CAP_SYSLOG), the test handles it
>> appropriately by skipping or failing.
>>
>> Related Reproducer by Mark Rutland
>> Link: https://lore.kernel.org/lkml/aIEePonPatjNrJVk@J2N7QTR9R3/
>>
>> Related Kernel Fix
>> Link: https://lore.kernel.org/lkml/20250812012722.127646-1-ysk@kzalloc.com/
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
>> ---
>>  tools/perf/tests/Build                  |   1 +
>>  tools/perf/tests/builtin-test.c         |   1 +
>>  tools/perf/tests/event_group_throttle.c | 132 ++++++++++++++++++++++++
>>  tools/perf/tests/tests.h                |   1 +
>>  4 files changed, 135 insertions(+)
>>  create mode 100644 tools/perf/tests/event_group_throttle.c
>>
>> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
>> index 3e8394be15ae..e22e2f285500 100644
>> --- a/tools/perf/tests/Build
>> +++ b/tools/perf/tests/Build
>> @@ -70,6 +70,7 @@ perf-test-y += util.o
>>  perf-test-y += hwmon_pmu.o
>>  perf-test-y += tool_pmu.o
>>  perf-test-y += subcmd-help.o
>> +perf-test-y += event_group_throttle.o
>>  
>>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
>>  perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
>> index 85142dfb3e01..d302bf9d1535 100644
>> --- a/tools/perf/tests/builtin-test.c
>> +++ b/tools/perf/tests/builtin-test.c
>> @@ -141,6 +141,7 @@ static struct test_suite *generic_tests[] = {
>>  	&suite__symbols,
>>  	&suite__util,
>>  	&suite__subcmd_help,
>> +	&suite__event_group_throttle,
>>  	NULL,
>>  };
>>  
>> diff --git a/tools/perf/tests/event_group_throttle.c b/tools/perf/tests/event_group_throttle.c
>> new file mode 100644
>> index 000000000000..7d5191d7e812
>> --- /dev/null
>> +++ b/tools/perf/tests/event_group_throttle.c
>> @@ -0,0 +1,132 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <time.h>
>> +#include <sys/wait.h>
>> +#include <signal.h>
>> +#include <sys/syscall.h>
>> +#include <sys/types.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <linux/perf_event.h>
>> +#include "perf-sys.h"
>> +#include "tests.h"
>> +#include "debug.h"
>> +
>> +static struct perf_event_attr attr_parent = {
>> +	.type = PERF_TYPE_HARDWARE,
>> +	.size = sizeof(attr_parent),
>> +	.config = PERF_COUNT_HW_CPU_CYCLES,
>> +	.sample_period = 1,
>> +	.exclude_kernel = 1,
>> +};
>> +
>> +static struct perf_event_attr attr_child = {
>> +	.type = PERF_TYPE_HARDWARE,
>> +	.size = sizeof(attr_child),
>> +	.config = PERF_COUNT_HW_CPU_CYCLES,
>> +	.exclude_kernel = 1,
>> +	.disabled = 1,
>> +};
>> +
>> +static pid_t run_event_group_throttle(void)
>> +{
>> +	pid_t pid = fork();
>> +
>> +	if (pid == 0) {
>> +		int parent, child;
>> +
>> +		parent = sys_perf_event_open(&attr_parent, 0, -1, -1, 0);
>> +		if (parent < 0) {
>> +			pr_debug("Unable to create event: %d\n", parent);
>> +			exit(-1);
>> +		}
>> +
>> +		child = sys_perf_event_open(&attr_child, 0, -1, parent, 0);
>> +		if (child < 0) {
>> +			pr_debug("Unable to create event: %d\n", child);
>> +			exit(-1);
>> +		}
>> +
>> +		for (;;)
>> +			asm("" ::: "memory");
>> +
>> +		_exit(0);
>> +	}
>> +	return pid;
>> +}
>> +
>> +static bool is_kmsg_err(int fd)
>> +{
>> +	char buf[1024];
>> +	ssize_t len;
>> +
>> +	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
>> +		buf[len] = '\0';
>> +
>> +		if (strstr(buf, "UBSAN") || strstr(buf, "WARNING:") ||
>> +		    strstr(buf, "BUG:") || strstr(buf, "Invalid PMEV")) {
>> +			pr_debug("Kernel log error detected: %s", buf);
>> +			return true;
>> +		}
>> +	}
>> +
>> +	if (len < 0 && errno != EAGAIN) {
>> +		pr_debug("Error reading /dev/kmsg: %s\n", strerror(errno));
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int test__event_group_throttle(struct test_suite *test __maybe_unused,
>> +				int subtest __maybe_unused)
>> +{
>> +	time_t start;
>> +	pid_t pid;
>> +	int fd;
>> +
>> +	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
>> +	if (fd < 0) {
>> +		/*
>> +		 * If /dev/kmsg cannot be opened (e.g. permission denied), skip the test
>> +		 * as we cannot verify the absence of kernel errors.
>> +		 */
>> +		pr_debug("Failed to open /dev/kmsg: %s. Skipping test.\n", strerror(errno));
>> +		return TEST_SKIP;
>> +	}
>> +
>> +	/*
>> +	 * Seek to the end to ignore past events (like EFI boot warnings).
>> +	 * This typically requires CAP_SYSLOG.
>> +	 */
>> +	if (lseek(fd, 0, SEEK_END) < 0) {
>> +		pr_debug("Failed to seek to end of /dev/kmsg: %s\n", strerror(errno));
>> +		return TEST_FAIL;
>> +	}
>> +
>> +	start = time(NULL);
>> +	do {
>> +		pr_debug("Starting event group throttling...\n");
>> +		pid = run_event_group_throttle();
>> +
>> +		sleep(8);
>> +
>> +		pr_debug("event group throttler(PID=%d)\n", pid);
>> +		kill(pid, SIGKILL);
>> +		waitpid(pid, NULL, 0);
>> +
>> +		/* Check for errors during the run */
>> +		if (is_kmsg_err(fd)) {
>> +			close(fd);
>> +			return TEST_FAIL;
>> +		}
>> +	} while (time(NULL) - start < 10);
>> +
>> +	return TEST_OK;
>> +}
>> +
>> +DEFINE_SUITE("event group throttle", event_group_throttle);
>> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
>> index 97e62db8764a..031856a710b2 100644
>> --- a/tools/perf/tests/tests.h
>> +++ b/tools/perf/tests/tests.h
>> @@ -179,6 +179,7 @@ DECLARE_SUITE(event_groups);
>>  DECLARE_SUITE(symbols);
>>  DECLARE_SUITE(util);
>>  DECLARE_SUITE(subcmd_help);
>> +DECLARE_SUITE(event_group_throttle);
>>  
>>  /*
>>   * PowerPC and S390 do not support creation of instruction breakpoints using the
> 
> 

Thank you,
Yunseong Kim
