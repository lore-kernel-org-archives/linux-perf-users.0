Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872077;
	b=AIHhGV7fKoHFiZg72B7+Vy9LZBbDQHzKW2jnTZ/7o3s94s4GgFzfm63T8+Z65DAdjaSu
	 BelmePcMxYK09jqPRLe5Ai5jSCSgNO9ksbOM9qLDzgtlbLYU+m1Ii0TGHlPmDrdFGQiHB
	 cWMQj/qZcb6n5lpruugp0i2MqG9fOtbiOCsmKIr52PJW5VCfHw61rB55uxDWS9rn90HPc
	 kMtcbyO1xfF1uAt90K7vBpUfZAzb9xkY8z/l4bugMsNmXJnl4xyPQYD3PYgJnYWR5fPNF
	 C7OG8tFmPA5Ym8P92Ols5R3I/8EYhfy+2YdFLWe3zL4P+SXYRl/PfZNKsfD4vkSHI+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872077;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=wh7tZ4dBme0Fg9cjGo5JMGl3AKYv9NnOu7mfYcISPmQ=;
	b=WVBLJ0XqHiFdI8eHR2QG5DGPEFJN3320utloPawi1oMFbUY62qrkSfLdJ6HZuiC58LCY
	 gqLcbcvxpMtEk0m8vIKU8xq9tCRDcyexpJ0lK30kPKyzP4ElgA4dG91vGcpXtyAPYtz+T
	 K2vnWhW440aGkXmJOPUQq3NcOurXLljdDVLNy6apfHr8ZRGP4LkpNkPlzFUzVUrc5bxlb
	 v7MqdER3NBXk15rPliR1tcQwZLBqpTVprUTI3VCR2vee75C2zSfH7wwLGru1guMuMs4hZ
	 6R2LyDwMzF88oqazAEOgiGjBElwyKARzBhrBysOutTG9gZ3A9F1/WVwrXN/wt/D24rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FBC606A326;
	Thu,  5 Nov 2026 09:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5FBC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jKyCB2Qckz1yFc;
	Thu,  5 Nov 2026 17:47:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 13D8A40A7E;
	Thu,  5 Nov 2026 17:47:46 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgA3O_7BUOxqN6GADA--.54237S2;
	Thu, 05 Nov 2026 17:47:45 +0800 (CST)
Message-ID: <d1b24bbf-9111-4766-87c8-ff97adcac727@huaweicloud.com>
Date: Thu, 5 Nov 2026 17:47:45 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] perf/core: Fix sigtrap task_work races
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1793870900.git.wutengda@huaweicloud.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <cover.1793870900.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3O_7BUOxqN6GADA--.54237S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ZF1kZFyrXw17Jr4kur1kAFb_yoWDuF13pF
	Wakr1kKrW8JryUtw43Aa1DAw1SywnrAFy7JrZ5GryIya15Ww1rAFWxtw4Y9F18Gr4xGa42
	yanrGw1S9rs8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UQ6p9UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/11/5 17:30, Tengda Wu wrote:
> Two fixes for sigtrap task_work handling since the switch to always
> enqueue SIGTRAP via task_work.
> 
> The warning splats and PoCs for both patches are too long to inline in
> the commit messages. They are sent as separate replies to this cover
> letter, one per patch.
> 
> Patch 1 fixes a re-entrancy race in __perf_event_overflow(): pending_work
> was set only after task_work_add(), so an NMI could re-enter and enqueue
> the same pending_task twice, creating a cycle in the task work list and
> unbalancing the event refcount. Claim pending_work with cmpxchg() before
> enqueuing, and clear it if the enqueue fails.
> 
> Patch 2 fixes a WARN_ON_ONCE() in perf_sigtrap() triggered by the context
> fast-swap path swapping ctx->task while a sigtrap event has pending task
> work. SIGTRAP is targeted at ctx->task, so exclude sigtrap events from
> fast-swap alongside inherit+sample-read events.
> 

This is the warning splat and PoC for patch 2
("perf/core: Disable context fast-swap for sigtrap events").

Warning observed before the fix:

[  370.271075] ------------[ cut here ]------------
[  370.271206] WARNING: kernel/events/core.c:7654 at perf_pending_task+0x2ad/0x330, CPU#1: fastswap/1414
[  370.273456] Modules linked in:
[  370.273990] CPU: 1 UID: 0 PID: 1414 Comm: fastswap Not tainted 7.3.0-next-20261027+ #4 PREEMPT(lazy)
[  370.275315] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/4
[  370.277114] RIP: 0010:perf_pending_task+0x2ad/0x330
[  370.277989] Code: 4c 8b ab c8 fe ff ff 49 ff 8d e8 00 00 00 e9 37 fe ff ff 4c 89 ef e8 52 c2 24 00 e9 e6 fd ff ff e8 a8 9
[  370.280596] RSP: 0018:ffff88810922fe10 EFLAGS: 00010283
[  370.281502] RAX: ffff8881093b9240 RBX: ffff888108f18398 RCX: 0000000000000000
[  370.282606] RDX: ffff88811679b6c0 RSI: 0000000000000004 RDI: ffff888103287680
[  370.283691] RBP: ffff888108f18000 R08: 0000000000000001 R09: ffffed1021245fbf
[  370.284834] R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
[  370.285958] R13: ffff888103287600 R14: ffff888108f18260 R15: 0000000000000000
[  370.287097] FS:  00007f6f8537e600(0000) GS:ffff88826ff74000(0000) knlGS:0000000000000000
[  370.288387] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  370.289168] CR2: 00007f6f84a0c000 CR3: 00000001100a2006 CR4: 0000000000170ef0
[  370.290336] Call Trace:
[  370.290688]  <TASK>
[  370.291034]  ? count_memcg_events+0x273/0x410
[  370.291720]  task_work_run+0x13d/0x200
[  370.292365]  ? __pfx_task_work_run+0x10/0x10
[  370.292956]  irqentry_exit+0x3a8/0x700
[  370.293579]  asm_exc_page_fault+0x26/0x30
[  370.294143] RIP: 0033:0x401316
[  370.294695] Code: c6 bf 2a 01 00 00 b8 00 00 00 00 e8 14 fe ff ff c9 c3 55 48 89 e5 89 7d fc 48 89 75 f0 48 89 55 e8 8b d
[  370.297200] RSP: 002b:00007ffe7c0027f0 EFLAGS: 00010206
[  370.297963] RAX: 000000000000002e RBX: 0000000000000001 RCX: 00007f6f85254d13
[  370.299006] RDX: 00007ffe7c002800 RSI: 00007ffe7c002930 RDI: 0000000000000005
[  370.300021] RBP: 00007ffe7c0027f0 R08: 0000000000000000 R09: 00007ffe7c002b67
[  370.301043] R10: 00007f6f8537e8d0 R11: 0000000000000246 R12: 00007ffe7c0030f8
[  370.302066] R13: 0000000000401a8a R14: 00007f6f853b7aa0 R15: 0000000000403e08
[  370.303112]  </TASK>
[  370.303495] ---[ end trace 0000000000000000 ]---

PoC (not easily reproducible, needs several rounds of running):

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include "perf_event.h"
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static volatile sig_atomic_t sigtrap_count;

static int perf_open(struct perf_event_attr *attr, pid_t pid, int cpu)
{
	return syscall(__NR_perf_event_open, attr, pid, cpu, -1,
		       PERF_FLAG_FD_CLOEXEC);
}

static void sigtrap_handler(int sig, siginfo_t *info, void *ctx)
{
	(void)sig;
	(void)info;
	(void)ctx;

	sigtrap_count++;
}

static int set_cpu(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);

	return sched_setaffinity(0, sizeof(set), &set);
}

static int read_msr_tracepoint_id(void)
{
	static const char * const paths[] = {
		"/sys/kernel/tracing/events/msr/write_msr/id",
		"/sys/kernel/debug/tracing/events/msr/write_msr/id",
	};
	char buf[64];
	unsigned int i;

	for (i = 0; i < sizeof(paths) / sizeof(paths[0]); i++) {
		int fd = open(paths[i], O_RDONLY | O_CLOEXEC);
		ssize_t n;

		if (fd < 0)
			continue;

		n = read(fd, buf, sizeof(buf) - 1);
		close(fd);

		if (n <= 0)
			continue;

		buf[n] = '\0';
		return (int)strtol(buf, NULL, 10);
	}

	return -1;
}

/*
 * Open inherited MSR tracepoint event.
 *
 * The event is created by the worker. Forked children inherit
 * the event and get their own child perf context.
 */
static int open_msr_sigtrap_event(int tracepoint_id, int cpu)
{
	struct perf_event_attr attr;

	memset(&attr, 0, sizeof(attr));

	attr.size = sizeof(attr);
	attr.type = PERF_TYPE_TRACEPOINT;
	attr.config = tracepoint_id;
	attr.sample_period = 64;
	attr.sample_type = PERF_SAMPLE_IP;

	attr.pinned = 1;
	attr.exclusive = 1;
	attr.exclude_idle = 1;
	attr.exclude_user = 0;
	attr.exclude_kernel = 0;

	attr.inherit = 1;
	attr.remove_on_exec = 1;
	attr.sigtrap = 1;
	attr.sig_data = 7;

	return perf_open(&attr, 0, cpu);
}

/*
 * Open inherited cache-miss event.
 */
static int open_cache_miss_event(int cpu)
{
	struct perf_event_attr attr;

	memset(&attr, 0, sizeof(attr));

	attr.size = sizeof(attr);
	attr.type = PERF_TYPE_HARDWARE;
	attr.config = PERF_COUNT_HW_CACHE_MISSES;
	attr.sample_period = 100;
	attr.sample_type = PERF_SAMPLE_IP;

	attr.pinned = 1;
	attr.exclusive = 1;
	attr.exclude_idle = 1;
	attr.exclude_user = 0;
	attr.exclude_kernel = 0;

	attr.inherit = 1;

	/* The hardware event does not own pending_task. */

	return perf_open(&attr, 0, cpu);
}

/*
 * Generate memory pressure and frequent voluntary context switches.
 */
static void workload(unsigned int ms)
{
	struct timespec start, now;
	uint64_t elapsed;
	const size_t bytes = 8 * 1024 * 1024;
	volatile unsigned char *buf;
	volatile uint64_t x = 1;
	uint32_t index = 0x12345678;

	buf = malloc(bytes);

	if (buf)
		memset((void *)buf, 0, bytes);

	clock_gettime(CLOCK_MONOTONIC, &start);

	do {
		for (unsigned int i = 0; i < 100000; i++) {
			x = x * 1664525 + 1013904223;

			index = index * 1664525 + 1013904223;

			if (buf)
				buf[(index & (bytes - 1)) & ~63U]++;

			/*
			 * Yield every 64 iterations to increase
			 * sched_out/in activity on the same CPU.
			 */
			if (!(i & 63))
				sched_yield();
		}

		clock_gettime(CLOCK_MONOTONIC, &now);

		elapsed = (uint64_t)(now.tv_sec - start.tv_sec) * 1000;

		if (now.tv_nsec >= start.tv_nsec)
			elapsed += (uint64_t)(now.tv_nsec -
					      start.tv_nsec) / 1000000;
		else
			elapsed -= (uint64_t)(start.tv_nsec -
					      now.tv_nsec) / 1000000;

	} while (elapsed < ms);

	free((void *)buf);
	(void)x;
}

/*
 * Forked child:
 *
 *   - inherits worker's perf events;
 *   - inherits worker's CPU affinity;
 *   - executes a short workload;
 *   - exits without explicitly closing perf event FDs.
 */
static void one_child(void)
{
	sigtrap_count = 0;

	workload(5);

	_exit(0);
}

/*
 * Worker:
 *
 *   1. Bind to the target CPU.
 *   2. Create perf events with inherit=1.
 *   3. Repeatedly fork short-lived children.
 *   4. Wait for child exit.
 *
 * All workers share the same CPU.
 */
static void worker(int cpu, int tracepoint_id, time_t end)
{
	struct sigaction sa;
	unsigned long iter = 0;
	int hw_fd, tp_fd;

	memset(&sa, 0, sizeof(sa));

	sa.sa_sigaction = sigtrap_handler;
	sa.sa_flags = SA_SIGINFO | SA_RESTART;
	sigemptyset(&sa.sa_mask);

	if (sigaction(SIGTRAP, &sa, NULL))
		_exit(10);

	if (set_cpu(cpu)) {
		dprintf(2, "[%d] sched_setaffinity failed: %s\n",
			getpid(), strerror(errno));
		_exit(13);
	}

	/*
	 * Open hardware event first, then tracepoint event.
	 */
	hw_fd = open_cache_miss_event(cpu);
	if (hw_fd < 0) {
		dprintf(2, "[%d] open cache-misses failed: %s\n",
			getpid(), strerror(errno));
		_exit(11);
	}

	tp_fd = open_msr_sigtrap_event(tracepoint_id, cpu);
	if (tp_fd < 0) {
		dprintf(2, "[%d] open msr tracepoint failed: %s\n",
			getpid(), strerror(errno));
		close(hw_fd);
		_exit(12);
	}

	dprintf(2,
		"[worker %d] cpu=%d hw_fd=%d tp_fd=%d started\n",
		getpid(), cpu, hw_fd, tp_fd);

	while (time(NULL) < end) {
		pid_t pid;
		int status;

		pid = fork();

		if (pid < 0) {
			if (errno == EINTR)
				continue;

			perror("fork");
			break;
		}

		if (pid == 0)
			one_child();

		/*
		 * Worker sleeps in waitpid().
		 * Child runs on the same CPU.
		 * Child exit wakes the worker.
		 */
		for (;;) {
			pid_t ret = waitpid(pid, &status, 0);

			if (ret == pid)
				break;

			if (ret < 0 && errno == EINTR)
				continue;

			if (ret < 0)
				perror("waitpid");

			break;
		}

		iter++;
	}

	dprintf(2,
		"[worker %d] cpu=%d iterations=%lu sigtrap=%d\n",
		getpid(), cpu, iter, (int)sigtrap_count);

	/*
	 * Keep the parent events alive throughout the workload.
	 * Child inherited events are released through child exit.
	 */
	close(hw_fd);
	close(tp_fd);

	_exit(0);
}

int main(int argc, char **argv)
{
	int cpu = argc > 1 ? atoi(argv[1]) : 1;
	int workers = argc > 2 ? atoi(argv[2]) : 8;
	int duration = argc > 3 ? atoi(argv[3]) : 60;

	int tracepoint_id;
	int ncpu;
	int created = 0;

	pid_t *pids;
	time_t end;

	if (workers < 1)
		workers = 1;

	if (duration < 1)
		duration = 1;

	ncpu = (int)sysconf(_SC_NPROCESSORS_ONLN);

	if (cpu < 0 || cpu >= ncpu) {
		fprintf(stderr,
			"invalid cpu %d (online cpus: %d)\n",
			cpu, ncpu);
		return 1;
	}

	tracepoint_id = read_msr_tracepoint_id();

	if (tracepoint_id < 0) {
		fprintf(stderr,
			"cannot read msr:write_msr tracepoint id; "
			"check tracefs/debugfs and CONFIG_X86_MSR\n");
		return 1;
	}

	pids = calloc((size_t)workers, sizeof(*pids));
	if (!pids)
		return 1;

	end = time(NULL) + duration;

	fprintf(stderr,
		"msr:write_msr id=%d cpu=%d workers=%d duration=%ds\n",
		tracepoint_id, cpu, workers, duration);

	fprintf(stderr,
		"Both perf events use inherit=1.\n");

	fprintf(stderr,
		"All workers and children are pinned to CPU %d.\n", cpu);

	fprintf(stderr,
		"Children yield frequently and exit after short workloads.\n");

	for (int i = 0; i < workers; i++) {
		pid_t pid = fork();

		if (pid < 0) {
			perror("fork worker");
			break;
		}

		if (pid == 0)
			worker(cpu, tracepoint_id, end);

		pids[created++] = pid;
	}

	for (int i = 0; i < created; i++) {
		while (waitpid(pids[i], NULL, 0) < 0) {
			if (errno == EINTR)
				continue;
			break;
		}
	}

	free(pids);

	fprintf(stderr, "All workers finished.\n");

	return 0;
}

Thanks,
Tengda

