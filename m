Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9F13C918
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861671; cv=none; b=BnDk5aepkggolwa/jQBeH/E9FEFm6YWWDJRpzAos+l0fVybWoZ4CvG4dfOu6vuYVUnVuKSX3/R+UlgNPPG/WUi53bm2i/Qem6YGRABgLSfYk1yhmZoHWNjVCgthvrsVEgtkvlxsp52lj3k6zgQhvCUAB3/yeIbYz2n4feO/wMjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861671; c=relaxed/simple;
	bh=+aUfocHe0NHlBACBdwP1Q+/VurCqCsCzdlTDhcynhII=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=smCu4RQQDFM7ctZYcTZ2FBxbmJKSwErNsqF8edNJURPhHr5yL1SKGkbyjJCTY/exroRQozp2hkFHK6pcub75kP9FYVIsAET8pvJjFsiF7ij5Ne8A+jglV+eVdGemBEuMdCpwraYfPm4XjGySDdns8TM7ZDbGQVPEqVA45N/HLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wKkweGEt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wKkweGEt"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d150e8153so239921b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721861668; x=1722466468; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eekgr3NTyqDF+LJggsbNJvCbBRahU9sAv9IDLYzUPPc=;
        b=wKkweGEtdIfb0iEUoflTtXB1zesWoWe4DKhSDV2ENRZyMAqOM0dHqt49YHkh9FaW54
         4MGKhnK71ryU2OUdNBMEADq/EK9ldisMm/P1Ly40ocoiY5Nj6pQzp52Gt0bcLKHArMRi
         EzUQQUgUkZpmn6n6Bw0dJ4hY39zFbvr8BgsL5AMWR8Rt4QBNUjiCTh3li5wra7Ox/0EY
         eZbbkJ40T9HDNYU2KGmmiGhRo/u9MTjfvzsae7HG3eQ3+331pBRfVYVE1c/LOSJdjaAn
         O/xrQPBoT4VyMwwiTUsfZmUBW6t7nglew0G7NWhOS9bJLSWwF+ZvofJraQR2W5ffe9Cz
         SXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721861668; x=1722466468;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eekgr3NTyqDF+LJggsbNJvCbBRahU9sAv9IDLYzUPPc=;
        b=o7kfy7ONM91lehkAo1U0Z7xBWpC3IZtBLdmapmVhDBk6Qios4m2MBZEtORXBntabf/
         JS6azK9JhCXg2eeWBfCw27JDUFDnhItf0iuKdvTtStHcE41FZ7539nBHbYNRD5u8yrFI
         NqnL3cbSNZt9uxhki6yIr5qERSqEpN5KkfUr7KZNczwgvNXVBWOC/Sll9AuNHnxgwNU6
         kaaex/pJkhdY7YoRlEGfO7ISykAOvsZm87Pw59eDEP795zt1DLPPz75n6VWIPeJqMJqU
         D5GttlzEwd2rYlkgclBOg5OleXZRitysNB6Av7+tZNl0CKGhQizIX+8EouRRPP/hesom
         oNNw==
X-Gm-Message-State: AOJu0Yy5wKKEKOLjzlGh0mR/hjd8tAk/sW2HHZkTW8qsvefSUcMuQBgJ
	v9GOeehaN3ZeVOKOdleht30JvonZWVSHJS1jVAOx4QoYZ+O8WimzfUN8/bDcH5I=
X-Google-Smtp-Source: AGHT+IEYAhZtaF+kduNn/OnN+ESLY+GctNib8JaUTUyemhs2fRyZg/73gn3rEkEyGqz3q3xjSafSxg==
X-Received: by 2002:a05:6a00:1acd:b0:70d:2438:db48 with SMTP id d2e1a72fcca58-70e9ef9956amr4749912b3a.15.1721861668355;
        Wed, 24 Jul 2024 15:54:28 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874c6fsm74992b3a.165.2024.07.24.15.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:54:27 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] perf: Add PERF_EVENT_IOC_SET_EVENT_LIMIT
Date: Wed, 24 Jul 2024 15:54:10 -0700
Message-Id: <20240724-perf_set_event_limit-v1-0-e680c93eca55@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKGoWYC/x3MwQqEIBRG4VeJu04wi8ReJUKq+Z0ulIWKDETvn
 szyW5xzU0RgRBqqmwIyRz59QVNXtG6z/0Lwp5iUVJ3UqhMXgrMRySLDJ7vzwUlIbVyzGNO3uqe
 SXgGOf//tOD3PC/sLCBtmAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Atish Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721861667; l=5296;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=+aUfocHe0NHlBACBdwP1Q+/VurCqCsCzdlTDhcynhII=;
 b=L7e2avlVMy8p8PvC1yhC5tzvONswegVvxFGaopksDZE/gE/jda5tEN7UTRcf55E1w7Z/T+vuH
 qfEHMwAbYoZBH9eFlP+A6DYDGLV2TfpYRCHLGrtfuYlV3ye3ixNqOgo
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

My motivation here is to have a program that is able to detect when an
arbitrary other program has reviewed some number of PMU overflows.
PERF_EVENT_IOC_REFRESH is not useful in the scenario since that ioctl
enables the event immediately. This new ioctl flag
PERF_EVENT_IOC_SET_EVENT_LIMIT allows a program to setup a event_limit
and then enable the event when ready at some later time.

This solves the first problem. The second problem that I am debating a
solution for is that the refresh SIGIO signals are marked as duplicate
signals and not always delivered to userspace. I will attach a simple
program below that can be ran a handful of times to catch this behavior.
REFRESH is supposed to send a SIGIO for every overflow, with an si_code
of POLL_IN for each signal except the last one which has a si_code of
POLL_HUP. However, __send_signal_locked() in kernel/signal.c will
occasionally catch this POLL_HUP signal before all POLL_IN signals have
been processed, thus treating this signal as a duplicate and dropping
with this logic:

	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
	/*
	 * Short-circuit ignored signals and support queuing
	 * exactly one non-rt signal, so that we can get more
	 * detailed information about the cause of the signal.
	 */
	result = TRACE_SIGNAL_ALREADY_PENDING;
	if (legacy_queue(pending, sig))
		goto ret;

I am sending this patch to begin a conversation on this issue with
REFRESH. One solution could be to only treat a signal as a duplicate in
__send_signal_locked() if the si_code is the same. Another solution is
to only use event_limits with a value of one, as any other number will
run into this race condition. If consistent signals are desired, sigtrap
can be used, but that also doesn't support enable_on_exec.

Here is a minimal test program for dropped signals. Can be ran on a loop until
program halts waiting for signal that will never arrive.

while ./signal 1 1; do sleep .01; done

// signal.c

int fd;
pid_t pid;

struct read_format {
	unsigned long long value;
	unsigned long long time_enabled;
	unsigned long long time_running;
};

int counter;

static inline int sys_perf_event_open(struct perf_event_attr *attr, int pid, int cpu, int group_fd,
		        	      unsigned long flags)
{
	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
}

static void sig_handler(int signum, siginfo_t *siginfo, void *user_context)
{
	struct read_format rd;
	counter++;
	read(fd, &rd, sizeof(rd));
	printf("fd: %d, signum: %d, si_code: %d, counter: %llu, time to overflow: %llu. time enabled: %llu\n", signum, siginfo->si_fd, siginfo->si_code, rd.value, rd.time_running, rd.time_enabled);
	if (counter == REFRESH_COUNT) {
		printf("Hit refresh count\n");
		close(fd);
		kill(pid, SIGKILL);
		if (siginfo->si_code == POLL_HUP) {
			exit(EXIT_SUCCESS); 
		} else {
			printf("INCORRECT COUNT! Expected POLL_HUP on second signal.\n");
			exit(EXIT_FAILURE); 
		}
	}
}

int main(int argc, char *argv[])
{
	char sbuf[128];

	if (argc < 3)
		goto invalid_args;

	unsigned long long num_instructions = atoll(argv[1]);
	unsigned int num_samples = atoi(argv[2]);
	unsigned long long sample_periods = num_instructions / num_samples;

	pid = fork();

	if (pid) {
		struct sigaction sa = {
			.sa_sigaction = (void *) sig_handler,
			.sa_flags = SA_SIGINFO
		};
		struct perf_event_attr pe = {
			.type = PERF_TYPE_HARDWARE,
			.size = sizeof(pe),
			.config = PERF_COUNT_HW_INSTRUCTIONS,
			.sample_period = sample_periods,
			.wakeup_events = 1,
			.disabled = 1,
			.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD,
			.read_format = PERF_FORMAT_TOTAL_TIME_RUNNING | PERF_FORMAT_TOTAL_TIME_ENABLED,
			.exclude_kernel = 1,
			.exclude_idle = 1,
			.exclude_hv = 1
		};

		if (sigaction(SIGIO, &sa, NULL) < 0) {
			fprintf(stderr, "FAILED setting up signal handler\n");
			exit(EXIT_FAILURE);
		}

		fd = sys_perf_event_open(&pe, pid, -1, -1, PERF_FLAG_FD_CLOEXEC);

		if (fd == -1) {
			fprintf(stderr, "FAILED opening perf: %s\n", strerror_r(errno, sbuf, sizeof(sbuf)));
			exit(EXIT_FAILURE);
		}

		ioctl(fd, PERF_EVENT_IOC_RESET, 0);
		ioctl(fd, PERF_EVENT_IOC_REFRESH, REFRESH_COUNT);

		fcntl(fd, F_SETFL, O_RDWR | O_NONBLOCK | O_ASYNC);
		fcntl(fd, F_SETSIG, SIGIO);
		fcntl(fd, F_SETOWN, getpid());

		while (1);
	} else {
		while (1);
	}

invalid_args:
	printf("FAILED: Please provide at least 2 args: number of instructions, number of samples. eg: %s 10000 5\n", argv[0]);
	exit(EXIT_FAILURE);
}

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
      perf: Document PERF_EVENT_IOC_SET_EVENT_LIMIT

 include/linux/perf_event.h            |  4 ++--
 include/uapi/linux/perf_event.h       |  1 +
 kernel/events/core.c                  | 17 +++++++++++------
 tools/include/uapi/linux/perf_event.h |  1 +
 tools/perf/design.txt                 |  5 +++++
 5 files changed, 20 insertions(+), 8 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-perf_set_event_limit-079f1b996376
-- 
- Charlie

