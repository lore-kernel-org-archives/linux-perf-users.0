Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818152;
	b=hTegAy510ZLzrDknZbMjafmztyyzGTfpLOsXonYSHzYLczuC2b5JnZAos3DIKAhMQlFl
	 lniysKGMnVVply8uAG2XhHJyOFyYc+NCCPJ4howW7fukMoLpYAmUiiLqicS0rO/A15ROu
	 WlMTXsbh5Fd9u2IP8p1vR5F0AdDfQTGTR7ta7dHHg2FuJS4V2ytqssQTBefl8xdvqkP4G
	 caEh4eQHcilYcaytoPRmIocSpEtKCUHldYvTKQaIGPC2kO47n+XASWKpBpx+hq3DyaNN5
	 bjmsOGnBaBw2Fva/oyrn2vtYtQJ9DmC/BKdIS72Zl8LQU79zALGJiFahhB711YtKVCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=piDg0wkr896rFpc3RMbnDrxXW3s/QWiYNEnX+RIOA/E=;
	b=0tAotrHRds5nEBtT1jzA3h4++VPF9uTH8XbY+jnZNJDon8s4ukhhFd03mTj6Euqf5Z2A
	 1+KbS60PJMp5TtvOalDsNXM6ysaQIJfijW1zfKn//0kxGDArTWWfMZ0k1JIYtJp2Y3DVD
	 ZDc5PRDuFeFq8Ze0qOU5xukkasWeQxjUR4t0yWKbNmOZflI1ykGMC+DgMARJpaGPWhJOv
	 3rb4fSGs/I7Jxv1k/mdoETTfyPiBTOjx56UNucDhqsU/bPzu0NekGyIQfKGUpHmZjkE7X
	 +Pft4h8XsaLd6uRUnfOVw5G2BLPepGLFsUkVH8qHjl/Fh0LXE2P6rtcdBp1AooYVgHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Z5j/iBGv";
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF7606D803
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FCF7606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z5j/iBGv
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b2d149693fso9794767b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818151; x=1794422951; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=piDg0wkr896rFpc3RMbnDrxXW3s/QWiYNEnX+RIOA/E=;
        b=Z5j/iBGvpFBhtcpCy48pscuY8quInxYDiVFLtTwg5BmFWxrIE0y80sw4FIuLEGzklp
         88XPyfJGGsk9GesPjIIncGgk07ouUBMay5vvfYsT3iyJ9BNw00D/kJyPdE83zKVtgLL6
         PhNJmRFlwnAiqAKwCz8CIaobdzEL7lPgLaZT3DtlnKeeJe47M6OCZhMlE/1EeeDVbvht
         iGAgWIhbWxyemyZryo7HQm4aXYYXr4SpqlCNXMCyfvEx/iQS6fVBgF13Os60ILm8RWPr
         6Jdv9RGNAdcB8h5934NbwjFkDjy+4CywOIjB6JHIk+4o/s7cIIM+6xAjlwQZVOg+ifO0
         M86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818151; x=1794422951;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=piDg0wkr896rFpc3RMbnDrxXW3s/QWiYNEnX+RIOA/E=;
        b=dSpVP16gQpS8YGaOa2omXKmHzL386hR+fwMt+7YJy2uwe9Q86JCXeDQBp5cSTsL2D5
         jHCtaJr1KYXiMahs1Y6I2F4JCuhNPi5wVdo5PRUFaLgs6yCEyq/6wu5rLlSAIxSKastV
         fh4xdPYD2HC1+hd4yXRK0nOkWZLepbaHF85iCvZycspm6dlfpR7HvCLRAcjIXYgh3d/u
         fK9VCF9QQxfIqlfofZNiN+ceDxsKFov7GpH3bWii0R/zrqQAtIkAWNwIwXiZGI80Z66N
         GGPF/XsPV7ujQcWGic38cWVZGhlT9enD80gvHxPhaFrEx4AD0xUyvZEJ5HrRqZIvZXjY
         11Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzHZawRdWabpBlHYlu3NkES8jglQI5tUkq4DZ8DO93+N0BDD/EwLnUwCWbipCVi+pAYW4ZKvdxF/eMpA/TeEUa5@vger.kernel.org
X-Gm-Message-State: APuU4Z9Dd3J77wMiQ6Gqx20B5MTuQvB1lqC4qyC1MMEeakAs/bkS6nG6
	4QjbJuxx7mBk2K+KVY+uC/tSYK2my/1tsNUBtrbh40ByZNvJeU22QBk1
X-Gm-Gg: AYBFou0tpR4lHJG/SlNZcRpvkgIokVytAiwFSwbUa2nSt0dY4XnI1FnDJo0VwtzyY6V
	UagqDM59ZMN7zlzsHfjozuaIhx5zQqvBpwcImKUOIBVusmjQEAhcuIQF7mu63wHahdtPPYfXUQe
	Vo0NkACFdwpLNHOMhHsKMPfOSsQ079x5Qrclxbc7PkXdwcuYfnKnI3C02nw2o7BBksa9sXZ3zFp
	oV8ngQ8k3mV7dqSrxOnquWi60yBkb5oKBsT1jwq8jVcRlR0a561hyluP4s3mwGauTDB6eqntj8N
	pGvhdrjAGzbXGCDxY+snrUnDmNCVV056JGpTH7UZaidhYSJ+axHHLCkhQJVCh0BFCPS691UbJOu
	huN2OptpHBVnKcYhK6FFG/VZy2agDQHkmxosR6SsweoO7foCwtJcsx4+mB1RQTGpYbKimGvJf6C
	OXw4FbBYw5Rz7iDnUHiDthFEtG9/vA0XY3shyxMF4MRTvYwtJ8IjyrlDRyAOGjNe4gJ0oK1NEpk
	CvqGnbrp9ERX4oyWHMhfng2VmMo/51RV47dFVZJEPSN9J1NlFCLobXMlQTe64zUGJ2r8VSGmCva
	QRt7RJea8SDh+3DTIaCQNSyvcMFGtp+oYTcQFqKV9VQyj/NRT8ljFzlkfJTzwJ32H4CJOv1MKHw
	jx7uFvMyzdA==
X-Received: by 2002:a05:690c:e250:20b0:8aa:dc82:36ad with SMTP id 00721157ae682-8b2b67caa19mr70567167b3.94.1793818151074;
        Wed, 04 Nov 2026 10:49:11 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3099291d7sm24706727b3.16.2026.11.04.10.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:49:10 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v6 00/13] alpha/perf: add ProfileMe sampling
Date: Wed, 04 Nov 2026 13:49:07 -0500
Message-Id: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNwW6EIBDG8VfZcC7NMIBoT32PZg+Aw0qjq8Gt2
 Wbjuxe3aWrk+CXz+8+DzZQizezt9GCJljjH8ZpH9XJivrPXC/HY5s0QsBKAitt+6iyf0hhiTwP
 xipraNsZ4pxXLakoU4v1Z/Dj/7vnLfZK/bZntoovzbUzfz5eL2O7+6nVRXwQH3irlNLqAGuD9M
 tjYv/pxYFt9wZ2XUHrM3hvAIHyl0eDRy38vQJReZt9gq4Vw2oJSR6/2Hkuvsq8EAQRNorX10eu
 9l6XX2TtHspEmuCDt3q/r+gN2L1u3wAEAAA==
X-Change-ID: 20261024-alpha-profileme-6e98a977cb54
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9122; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=pmhGZDVDJCKEuesx0SlMhKrYItLTNfTs1SyhVTCk9PI=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe16l8Z9l0cutV12n3dHdURd67Mcc+8d28X6eKL5VuC
 /GP1mAQ6vjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhrQmcxMjxamtzy+m
 bm0+d2Lv/+8SsEpQapNZp0vq7d0vr25nN+rSJGhkPBEj8silftyOXYPq1sspja68URVikrZ4quO
 VDOb86SxAUA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The 21264 from EV67 on, and the 21364, have a second performance counter
mode, ProfileMe, alongside the Aggregate mode that the driver uses today.
An Aggregate mode sample reports the PC where the overflow interrupt was
taken. On an EV7 that is anywhere from 15 instructions before to 12
after the one that overflowed the counter, which makes perf annotate
output close to useless. In ProfileMe mode the CPU picks one fetched
instruction, follows it down the pipeline, and reports its PC along with
what happened to it: whether it retired, whether it trapped and why,
whether it was a mispredicted branch, stalled before map, or was killed
on a wrong path, and what PCTR1 counted while it was in flight.

Patch 1 fixes a constant passed to the wrong PALcode call, with no
functional change. Patch 2 adds the sysfs format and event attributes
the perf tool needs to name raw events. Patch 3 fixes counts lost when
an event is stopped before its first start, and patch 4 stops reporting
user registers that the entry code has not saved yet. Patch 5 ignores
counter interrupts that were pending when the counter was rewritten,
and stops counting an overflow twice when a read races its interrupt.
Patch 6 adds ProfileMe sampling, selected with precise_ip or a new
profileme config bit, so cycles:p and perf record's default event use
it. Patch 7 attaches the status registers to each sample as
PERF_SAMPLE_RAW data, and patch 8 adds an option to randomize the
sampling interval so that it cannot lock onto a loop. Patches 9 and 10
report what PCTR1 counted as the sample weight and the data source of
memory accesses, DTB hits and misses. Patch 11 adds filters that keep
only retired, mispredicted or trapping instructions, and patch 12 makes
precise events sample only retired ones. Patch 13 lets ProfileMe events
exclude user or kernel samples, so that perf record works without root
at the default perf_event_paranoid.

A separate series for perf-tools-next adds a decoder for the raw data
to perf report -D and perf script -D, and a script that sums the status
by symbol or by instruction, in the style of DCPI, and a perf mem event.

The two modes cannot run at the same time, because PCTR_CTL[SL0] sets
the mode for both counters. A ProfileMe event is scheduled alone, and
perf multiplexes it with any other hardware events. perf stat does not
ask for precise events, so it keeps using Aggregate mode.

To try it:

  perf record -e cycles:p -- ./workload
  perf annotate

I tested this on an AlphaServer ES47 (EV7). Samples from a
16-instruction loop land on all 16 instructions rather than on 4 PCs.
DTB misses and unaligned traps are attributed to the faulting load. A
branch on random data shows up as mispredicted in 21% of its samples,
and in 0% with sorted data. A 12 minute perf record -a while building
git took 4.45 million samples with no warnings. Sampling every 10000
instructions, which used to wedge the CPU, ran 66 times without a hang.
With precise_ip, killed instructions went from 67% of the samples of a
mispredicting loop to none. On two CPUs, this version survived 62 runs
that mix sampling, filters, context switches and multiplexing, with no
warnings. As a normal user, perf record took 8763 samples, none of them
in the kernel.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v6:
- New patch 5: ignore an overflow interrupt for a counter that has not
  overflowed since it was written, and do not count an overflow twice
  when a read races its interrupt. Counters are now written at most
  half their range below overflow, so the two can be told apart.
  Suggested by Ian Rogers, after Sashiko found that a PCTR1 interrupt
  pending when a ProfileMe event was scheduled in was taken as a
  window close.
- Patch 6: drop the stopped event check and the caveat about stale
  interrupts, which patch 5 now covers.
- Patch 10: also report a memory access that retired without a DTB
  miss trap as a DTB hit, a load into $31 or $f31 as a prefetch, and
  leave out the ldq_u UNOP. Thanks to Ian Rogers.
- Patch 12: say in the commit message that the kept samples carry the
  full period, so the sample rate in frequency mode falls by the
  killed fraction. Thanks to Ian Rogers.
- New patch 13: honor exclude_user and exclude_kernel for ProfileMe
  events by dropping samples, so perf record works without root.
  Suggested by Ian Rogers.
- Link to v5: https://patch.msgid.link/20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com

Changes in v5:
- Patch 5: refuse precise_ip 3, as a sample with a PALmode PMPC keeps
  the interrupted PC. Thanks to Magnus Lindholm.
- New patches 8 to 11, from Ian Rogers' suggestions: the sample weight,
  the data source of DTB misses, config1 filters, and retired-only
  precise samples. The last changes what a default perf record shows.
- Link to v4: https://patch.msgid.link/20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com

Changes in v4:
- Patch 4: move __entry_save_end past the r16-r18 stores in entSys,
  as PAL_callsys does not save them and interrupts are still enabled
  there.
- Patch 5: report the user registers when the profiled instruction is
  in the entry code but the interrupt was taken after it, since
  perf_get_regs_user() sees the PMPC rather than the interrupted PC.
- Link to v3: https://patch.msgid.link/20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com

Changes in v3:
- New patch 3: clear PERF_HES_UPTODATE when an event starts counting,
  so that a stop before the first start does not lose the count.
- New patch 4: report no user registers for a sample taken in the entry
  code, where the frame at task_pt_regs() is not complete. An interrupt
  nested on one taken there is still not caught.
- Patch 5: a user instruction whose interrupt is taken in the kernel now
  reports its PC with no registers or user stack, as the frame at
  task_pt_regs() may not be built yet. Thanks to Magnus Lindholm for
  finding this and for the fix.
- Patch 5: also move the counter away from overflow when a ProfileMe
  event is removed, or stopped without PERF_EF_UPDATE, as
  alpha_pmu_del() does not go through alpha_pmu_stop().
- Patch 5: ignore an interrupt that was pending when the event was
  stopped. Document that rewriting a counter does not cancel one.
- Link to v2: https://patch.msgid.link/20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com

Changes in v2:
- Patch 1: explain why bit 0 clear means all processes, although the
  Architecture Reference Manual says otherwise.
- Patch 3: fix a CPU wedge during high-rate ProfileMe sampling. The
  ProfileMe counters are now written twice, and a stopped counter is
  moved away from overflow, as EV67 HRM PALcode restrictions 32 and 38
  require.
- Patch 3: set the profiled PC in place in the trap frame of the
  instruction's mode instead of in a pt_regs copy on the stack, so
  sampled registers and stack values are those of the right frame.
  A kernel instruction whose interrupt is taken in user mode gets a
  per-CPU frame holding only its PC, so the user frame is not changed.
- Patch 4: drop the reserved field and pack the 64-bit fields of
  struct alpha_profileme_sample, so they are 8-byte aligned in the
  sample record and the record needs no padding. This changes the raw
  data layout.
- Patch 5: compute the jitter with mul_u64_u32_shr() and saturate the
  sum, so that large periods cannot overflow.
- Link to v1: https://patch.msgid.link/20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com

---
Matt Turner (13):
      alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the logging options call
      alpha/perf: add sysfs format and event attributes
      alpha/perf: clear PERF_HES_UPTODATE when an event starts counting
      alpha/perf: do not report user registers from the entry code
      alpha/perf: ignore overflow interrupts the counter does not account for
      alpha/perf: implement ProfileMe sampling
      alpha/perf: attach ProfileMe status as PERF_SAMPLE_RAW data
      alpha/perf: optionally randomize the ProfileMe sampling interval
      alpha/perf: report the ProfileMe window count as the sample weight
      alpha/perf: report the data source of ProfileMe memory accesses
      alpha/perf: add ProfileMe sample filters
      alpha/perf: sample only retired instructions for precise events
      alpha/perf: honor exclude_user and exclude_kernel for ProfileMe events

 arch/alpha/include/asm/perf_event.h      |   2 +
 arch/alpha/include/asm/ptrace.h          |  12 +
 arch/alpha/include/asm/wrperfmon.h       |  36 ++
 arch/alpha/include/uapi/asm/perf_event.h |  31 ++
 arch/alpha/kernel/entry.S                |   9 +
 arch/alpha/kernel/perf_event.c           | 660 ++++++++++++++++++++++++++++++-
 arch/alpha/kernel/perf_regs.c            |  13 +
 7 files changed, 742 insertions(+), 21 deletions(-)
---
base-commit: 330517c63aa9b48227b6ab45f01003effac77ae4
change-id: 20261024-alpha-profileme-6e98a977cb54

Best regards,
--  
Matt Turner <mattst88@gmail.com>

