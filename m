From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Mixed group of sw/hw counters are not started if sw counter is group leader
Date: Tue, 29 Jan 2013 12:25:31 +0100
Message-ID: <CAGz0_-0ti+_3cXQhYUAb_-zKqHBcPVYjFtQ86ZGr8utXF13Rag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailsender1.informatik.tu-muenchen.de ([131.159.0.97]:54459
	"EHLO mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755149Ab3A2LeS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Jan 2013 06:34:18 -0500
Received: from mail-ve0-f171.google.com (mail-ve0-f171.google.com [209.85.128.171])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mail.in.tum.de (Postfix) with ESMTPSA id 338C52401C2
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jan 2013 12:25:33 +0100 (CET)
Received: by mail-ve0-f171.google.com with SMTP id b10so183290vea.16
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jan 2013 03:25:32 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I've noticed an odd behavior of the perf event subsystem.

If the flag "disabled" in struct perf_event_attr is set to 0, the
counter should be automatically started after the perf_event_open
system call (perf/design.txt).

This is only working if the first perf counter is of type hw or all
counters in the group are sw counters. If a sw counter comes first
and the group also contains hw counters, the read call shows that the
first counter is started, but not counting. All other counters are neither
started nor counting.

Value: 0 Enabled: 7599 Running: 6706
Value: 0 Enabled: 0 Running: 0
Value: 0 Enabled: 0 Running: 0

If the order of counters is changed to sw,hw,sw, perf_event_open will
return the error: invalid argument.

If a hw counter comes first, everything works as expected.

Is there any secret rule that says hw counters come always first? I've
found no documentation on that and I would expect, that the order of
counters should have no influence, except of group leaders.

Is this behavior intended or a regression?

The Kernel version: 3.7.4

Here is my test code.

---

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <linux/perf_event.h>
#include <asm/unistd.h>

long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
		int group_fd, unsigned long flags)
{
	int ret;

	ret = syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
	return ret;
}

struct read_format
{
	uint64_t value;
	uint64_t time_enabled;
	uint64_t time_running;
};

int main(int argc, char **argv)
{
	struct perf_event_attr pe[] =
	{
			{
					.type = PERF_TYPE_SOFTWARE,
					.size = PERF_ATTR_SIZE_VER3,
					.config = PERF_COUNT_SW_TASK_CLOCK,
					.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED|
									PERF_FORMAT_TOTAL_TIME_RUNNING,
					.inherit = 1,
			}
			,
			{
					.type = PERF_TYPE_SOFTWARE,
					.size = PERF_ATTR_SIZE_VER3,
					.config = PERF_COUNT_SW_CPU_CLOCK,
					.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED|
									PERF_FORMAT_TOTAL_TIME_RUNNING,
					.inherit = 1,
			}
			,
			{
					.type = PERF_TYPE_HARDWARE,
					.size = PERF_ATTR_SIZE_VER3,
					.config = PERF_COUNT_HW_INSTRUCTIONS,
					.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED|
									PERF_FORMAT_TOTAL_TIME_RUNNING,
					.inherit = 1,
			}
			,
	};

#define NUM_EVENTS sizeof(pe)/sizeof(struct perf_event_attr)

	struct read_format start[NUM_EVENTS], stop[NUM_EVENTS];
	int i, ret, group_leader = -1, fd[NUM_EVENTS];

	for (i = 0; i < NUM_EVENTS; i++)
	{
		ret = fd[i] = perf_event_open(pe + i, 0, -1, group_leader, 0);
		if (ret == -1)
		{
			perror("perf_event_open");
			exit(EXIT_FAILURE);
		}

		if (group_leader == -1)
		{
			group_leader = fd[0];
		}
	}

	for (i = 0; i < NUM_EVENTS; i++)
	{
		ret = read(fd[i], start + i, sizeof(struct read_format));
		if (ret != sizeof(struct read_format))
		{
			perror("read start");
			exit(EXIT_FAILURE);
		}
	}

	printf("Measuring this printf\n");

	for (i = 0; i < NUM_EVENTS; i++)
	{
		ret = read(fd[i], stop + i, sizeof(struct read_format));
		if (ret != sizeof(struct read_format))
		{
			perror("read stop");
			exit(EXIT_FAILURE);
		}

		printf("Value: %u Enabled: %u Running: %u\n",
				(unsigned int) (stop[i].value - start[i].value),
				(unsigned int) stop[i].time_enabled,
				(unsigned int) stop[i].time_running);
	}

	return 0;
}
