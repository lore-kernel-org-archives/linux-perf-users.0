Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554719;
	b=yRXTsB4IJKdFaSrD/+35NSEXOQ3+/UXRdonGw5Cp8zTrtKaFffXj45YCGw/Mg1YNFIRM
	 0J7ujS9Yv9VbeYrykAIMxWU8yexN1T80wNcYB7rNl7gjRolt6zVP5OYgZ0T18u/t88Gu4
	 eoKviz9D4cEP+6Tr3HpUg2L0EdEZ9Nhvw0QOVKyW928kX48UUBww0sCowRnbrJxyHOZ5X
	 D2zeuUZSvN7G+go3cxd5KllurZuAOSaS+G/ASdIiBVfhglgPWOWGHENpiBcv+J3qVOUpQ
	 qyB4uWOsXUWZH0CqMxfWMIQE3a6i3GN5BIsHnUIiCDQPVx9fXjb4A9ODCU9rTugcapQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554719;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=uLXRnIBT9Cz7nleA3d/y84tKsqUOLljvF1aGeuz0Kt8=;
	b=x3CU1pHcoFkW0q1vHUn65fCkaZ30IOZ0RsJA5Mtq8TASOVC3yD+RHmDRrI64RefL4hS/
	 ZrtZg/Fd6sWV44Rfr8ibN/ucMKv9B2C9XOqNQj1gZcYHgzuzIJvtdJVy0/9bbO3l6ua+2
	 Z2xer2Ns0BU8qxH7lm6ZbfQj0m3nk1Ic6ra7aR3qt/BiHfGeHm/sci9JPTKYu0uuOlWxW
	 QHzJBzLbf5m6vjYeT3oT/whI1wVb+VyMYOowW4KTlQdpGKMcQk3ZqNuIEVEFEROYzEa7U
	 F3Zb4Zuu+xNyO7rOPoy2q9fBz3rprDJJmfP4CvCXZm3ci/fk13Phjr/GAuaQqstQC/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ZPahEWbY;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C462606A31E;
	Tue, 24 Nov 2026 21:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C462606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ZPahEWbY
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jYwVG32MLzMlKd;
	Tue, 24 Nov 2026 22:11:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795554710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uLXRnIBT9Cz7nleA3d/y84tKsqUOLljvF1aGeuz0Kt8=;
	b=ZPahEWbYEWdvTRpm5nHezyIWvKlmtyqte3xSytqMHThB8gC4uKZwuJSWb3hHQPujDldy4F
	6NGew085UdnAZ+JugEpYg3yeej5uPLzpY1TRXWPZYaq6X1VGH8hq4KrrJM4I3kOxQbqxMi
	mBMSt8hq246PBiBsJBjkk0eFFnfREwnXwZUS9QTbwJbAvVKs8C3uafCfVFMuksKSU4fyu+
	63xMr4IyHmeFUmHDBiMWAPHYkXzy3S0Uct6auiONsUvyoiziiqEHQE58XVkUGmZZg4JT94
	2CJqzWn2c2bLU7gD9zWCjiVmvdZilXMcWT4a7cVbQ1uJyd9fYREgAWIQvcLRfw==
From: Oancea Catalin <john3@mailbox.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/amd/core: Handle overflows of counters stopped by a throttle
Date: Tue, 24 Nov 2026 23:11:46 +0200
Message-ID: <20261124211146.61378-1-john3@mailbox.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dd2b0bdb214adc26a17
X-MBO-RS-META: sb34jjxorsi4wzsu3ao8uiji41e6dt4a

amd_pmu_v2_handle_irq() reads PerfCntrGlobalStatus once, handles the
overflows of the counters which are set in cpuc->active_mask and warns
about every status bit which is left over:

  New overflows for inactive PMCs: 2
  WARNING: arch/x86/events/amd/core.c:1031 at amd_pmu_v2_handle_irq+0x86e/0x9a0
  Call Trace:
   perf_event_nmi_handler
   nmi_handle
   default_do_nmi
   exc_nmi

Throttling stops the whole event group, so perf_event_overflow() can
stop counters which the loop has not reached yet. When both events of a
group overflow in the same NMI and the first one is throttled:

  amd_pmu_v2_handle_irq()
    status = 0x3
    counter 0: x86_perf_event_set_period()
               perf_event_overflow()
                 perf_event_throttle_group()
                   x86_pmu_stop(leader)    clears active_mask bit 0
                   x86_pmu_stop(sibling)   clears active_mask bit 1
    counter 1: not in active_mask, skipped
    status = 0x2                           warning

The overflow of the sibling is not handled. Its period is not set up
again and its status bit stays set, because only the handled bits are
acknowledged.

An unprivileged task can trigger this with perf_event_paranoid at its
default of 2: open a group of two sampling events with short periods
(raw event 0x76, exclude_kernel, sample_period 20000 and 20011) on the
task itself and spin in user space. With six such tasks the warning
shows up within seconds.

Take a copy of active_mask before the loop and walk the counters which
were active on entry. For a counter which was stopped in the meantime,
update the count, clear the status bit and set up the next period as
before, but do not deliver a sample, as the event is throttled.

Observed on v7.4-rc4-162-g8d7fe9885c62 in a KVM guest (virtual
PerfMonV2 PMU, KASAN and lockdep enabled), not on bare metal. An MSR
trace of the guest shows the sequence above: status 0x3, a write to
counter 0, both event selects disabled, no write to counter 1. With
this change the trace shows counter 1 being written after the two
disables, and the warning did not trigger in six runs from fresh boots.

The problem was found with syzkaller. The reproducer, the analysis and
this patch were produced with an AI coding assistant (Claude Code,
model Claude Mythos 5.2).

Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Signed-off-by: Oancea Catalin <john3@mailbox.org>
Cc: stable@vger.kernel.org
---
Notes for reviewers, not for the changelog:

Testing was done only in a KVM guest (-cpu host on a Ryzen 9 7945HX host
running 6.12.107, so KVM's virtual PMU), with KASAN, lockdep and HZ=1000.
I have not run this on bare metal or on a non-debug kernel, where the NMI
is much faster and throttling harder to reach.

Without the patch the reproducer below triggered the warning on 4 of 4
fresh boots as root, 2 of 2 as uid 65534 and 1 of 1 as uid 65534 in a user
namespace. With the patch: 0 of 6 fresh boots (3 root, 2 uid 65534, 1 user
namespace), 90 seconds each, no other warning. In a 20 second MSR trace of
one CPU with the patch, the sequence "status 0x3, counter 0 written, both
event selects disabled, counter 1 written" occurred about 2100 times.

Not verified: that the counts and samples of the sibling are right after
it is unthrottled. The second counter of the guest counted unreliably even
without sampling, which I attribute to the host's counters being shared
with other VMs, so I could not measure it.

Not looked at: x86_pmu_handle_irq() and the Intel handler also skip
counters which are no longer in active_mask. They do not warn, but an
overflow of a sibling stopped by a group throttle would not have its
period set up again there either, if I read them correctly.

The Fixes: commit was checked by test: with the same config and
reproducer, 9734e25fbf5a warns (2 of 2 fresh boots) and its parent
ca559503b89c does not (0 of 3, 90 seconds each). 9734e25fbf5a is in v6.16
and later. I did not test the stable trees.

The kernel .config is the syzkaller one I fuzz with; I can send it.

---- repro.c ----
// Reproducer for "WARNING in amd_pmu_v2_handle_irq" (New overflows for inactive PMCs).
// Reduced from a program found by syzkaller.
//
// Each worker opens a group of two hardware sampling events on its own task,
// both with a short fixed period, enables them and burns CPU in user space
// for a moment, then exits. NPROC workers do this in a loop.
//
// Build: gcc -O2 -static -o repro repro.c        Run: ./repro   (stop with ^C)
#define _GNU_SOURCE
#include <linux/perf_event.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <unistd.h>

#define NPROC 6

static int ev(unsigned long long config, unsigned long long period, int group)
{
	struct perf_event_attr a;

	memset(&a, 0, sizeof(a));
	a.type = PERF_TYPE_RAW;		/* CPU hardware counter */
	a.size = sizeof(a);
	a.config = config;
	a.sample_period = period;	/* short fixed period: many interrupts per tick */
	a.sample_type = PERF_SAMPLE_IP;
	a.disabled = 1;
	a.exclude_kernel = 1;		/* what an unprivileged user may ask for */
	return syscall(SYS_perf_event_open, &a, 0 /* this task */, -1 /* any CPU */, group, 0);
}

static void once(void)
{
	volatile unsigned long n;
	int leader = ev(0x76, 20000, -1);	/* 0x76: CPU cycles */

	ev(0x76, 20011, leader);
	prctl(PR_TASK_PERF_EVENTS_ENABLE, 0, 0, 0, 0);
	for (n = 0; n < 30000000; n++)
		;
}

int main(void)
{
	int i;

	for (i = 0; i < NPROC; i++) {
		if (fork())
			continue;
		for (;;) {
			pid_t p = fork();

			if (p == 0) {
				once();
				_exit(0);
			}
			waitpid(p, NULL, 0);
		}
	}
	pause();
	return 0;
}
---- end of repro.c ----

 arch/x86/events/amd/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce566..8d3781816418 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -958,6 +958,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	static atomic64_t status_warned = ATOMIC64_INIT(0);
 	u64 reserved, status, mask, new_bits, prev_bits;
+	DECLARE_BITMAP(active, X86_PMC_IDX_MAX);
 	struct perf_sample_data data;
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
@@ -994,8 +995,15 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	/* Clear any reserved bits set by buggy microcode */
 	status &= amd_pmu_global_cntr_mask;
 
+	/*
+	 * perf_event_overflow() can throttle and thereby stop the whole group.
+	 * Walk the counters which are active now, so that a pending overflow
+	 * of a sibling stopped that way is still consumed.
+	 */
+	bitmap_copy(active, cpuc->active_mask, X86_PMC_IDX_MAX);
+
 	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
-		if (!test_bit(idx, cpuc->active_mask))
+		if (!test_bit(idx, active))
 			continue;
 
 		event = cpuc->events[idx];
@@ -1014,6 +1022,10 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
+		/* Stopped by a group throttle in an earlier iteration */
+		if (!test_bit(idx, cpuc->active_mask))
+			continue;
+
 		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		perf_event_overflow(event, &data, regs);

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.56.1

