Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939425;
	b=PK6X/Fp33AQZ/iOWdnTpXJmoB/om+LS4AmiXvO2zeYRRb04W7/z0VxEIc1oFDXlxS+RG
	 e22qs2XEVbAZMuskrmmg9iP8Xk+dw6pLohksH1MDA27MA+E4GFZ7pjyx0s5I3rcID2AvO
	 nfXudZSrfUdbdJRk8bZB9p2jIwNSxalKafo7DVTf8apZfRTZ0lFyYg7wfDLLwGriT15kK
	 oArB2J76v+BqfbkyULqvsUhw7OMqMQMyOu9w2sqtOKYwj9IumeWNFApXBvcBdZGrTW6ws
	 9GIy88VnWammx9YNwURaLTwunVR38u7o9Bnko/mvBR1MhvBo7FaLd1FyYX9d/r6bkAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=47g1VXWwcWmIpSCCJnbC3hN9QV0J0KL7MKQIzmbLAQo=;
	b=zDcj1DKGTLG+mhehgUoB940l2a+1gXKmh7T33VZStZCgJZMXBEODalGnTpPhPGtxNPTc
	 7G3a79PfrtpCxxq/FHAYByYR9ebMMzfl75yyQROG931LUStsiJ8KT+xV3hCuH0wVWJliB
	 pxjhVwpI1W2LQ/oukKLSFj7O00QMnWQlWzZ+R1XvquXdBrUppRgziq+G1wrwqCUynlery
	 KojWIPWIDjwxoRDUWGlSp0/UPkguDJKfI1d5KPit5Sdh9yazZ0+bTiSOn855cUHrH2r/d
	 QxkrQzFMIkJSvjLuDiuVYfNyopRFiHrxw1Wbf0UpLUnyuA0y0LcyfghffS0/le2CQ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqRXgOeR;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400D606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D400D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqRXgOeR
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b31ca7e0bcso1333267b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939424; x=1794544224; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=47g1VXWwcWmIpSCCJnbC3hN9QV0J0KL7MKQIzmbLAQo=;
        b=eqRXgOeRyMtmw+gBDNQudSlG7TdFPZc/MsISYWl8NjT2JKZxYOzSpirwSyRXuT3H0P
         BJmsYH95QtsjvqTY24KsGatYygspWarRD9CZ/CA+Hray8l9urUgQ/J7nRlI6H1xpMh4y
         HIQ8aFrYhHVC3is3Mp7yhx9kx4jvy4m0OFwX8Kmuc6bdBDMPCRYEImdtxYuxqx2RunZZ
         DWe8Wy7U+3rkP3I3ObqQmvBSJS+jlGl2xu2pADnnD/HYZFcVhHFgbNALpDUqE5NFUCZU
         DEJ/3CGi7qK2n2IyZvA84H9tA5fxCd9bqgPHViU3IgJvJlygCkKSDfUBmfbTR1cJ61qi
         pZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939424; x=1794544224;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=47g1VXWwcWmIpSCCJnbC3hN9QV0J0KL7MKQIzmbLAQo=;
        b=XmKkuc19FGew3VqYRyRfPVPGi4+oFAkaP6BiSlS14x1mr3V5j96dlzn5daqvNSWfpu
         8f9ZejFF4NXUO1XMSyq+p+fnTWfaYsUTcMKThpwMkrFE/apJ7RPYfO7cAOKgjGpvcHQg
         py0l2Gnabk9c59tZWbQMwDf3US++zjpyMPm5C2pJKK/6B6FK1xKlYkLsisCUd7OMElKq
         QsuKrgW/JMYyrg1TKnIzWQvYXkNyH9LwzcFWnSq4lyvTM1/8+4J+7j9isfDll/IYax1Q
         MrZbJo8rK7WyVUaqD8l6RQK129HtBXxvnVOW9Mpoa7ByM1tU9EYmcrMBRL+akexuoic5
         iWBA==
X-Forwarded-Encrypted: i=1; AL+hErHL3wgn9FCipNWDiwSi+yTeUTIFY3ZmbJHO2abWrWr+A7DWxXeEySWCwZSXCC7ZXmfJ9tA0j0alR797d2tTdXG2@vger.kernel.org
X-Gm-Message-State: APuU4Z9cEZJYqySAvY8z+pcSzq8PG1cT4TuKqiWT6NsRJFCyYeo1IOpP
	hVdMswgGbBGLQ+W+qHBO4fVCGkWLiWOZnF95Lye2sVhX2n4Oo03zNCf0
X-Gm-Gg: AYBFou3t3ku11vMX0zmWEAPnjWZp1FVTHtXa/X3q3GHEXdrtCoIe9JLD64vLag9RGt9
	DmsNuRivHL9TKPtEgW9pDVp/LOTHV+OcoIblouSikjNBgcBHadG3v7Q66E5OdGZDzhq5qZs6wH9
	7q7QWUykuRUwB1wTvP6I3YC9LwOK9FXpXti40B1XOlaiycTcxYEB2h9nWMbEVOXHtM7t59ZDyfs
	fKZweI5M1wzMWVIcx4R5kI+3RIK8gu6ThuZWHGOZoLmtIx2h2DvjsVzkUSIr3t0EDZAs2fbgRAC
	tHJeWSnvlKwmb16Y4qBRKnOMnWQnOH5WU2Z0tFUVLg9QyYJ8wW2/nj/c8xn5z1RDPd5y/FVUZb/
	Tkh2BDUZydPjngKqX3+oyTgBIiY6pIyNFdA1PJCoM9pZcSJX3efGtmf4/C6VKnHOytsBiaWjzOl
	rkeHkVIcEsZw3h4vQyf2We1LaKlFpMjSCZOxw/84iKDwiFB/yOgnUI2TEY2kfjcUbAoxEYpnk83
	T1pSxPmXtnQqkVExEBoE+YBYEcPdSbDuVIohRKhAhpk9ZPMuL/0RE8UqwLtK/TH+PGsbN76Cvnp
	GJkYu30cWxyDw7sRMmNhuJ4JnBJvDal9qDrwh33PCNvc1kdAHrvBW4JJkxYwBs9NAQfGkNqS85M
	sHU2pDyA/8Q==
X-Received: by 2002:a05:690c:e3e2:b0:8b3:1fab:fbe2 with SMTP id 00721157ae682-8b3419a12a6mr8656357b3.36.1793939423575;
        Thu, 05 Nov 2026 20:30:23 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f7cc461sm11048007b3.17.2026.11.05.20.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:22 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v7 00/14] alpha/perf: add ProfileMe sampling
Date: Thu, 05 Nov 2026 23:30:19 -0500
Message-Id: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XRTU7DMBAF4KtUXmM0Hv/FrLgHYmE748YobaKkR
 KAqd8cpQkTx8knzvbeYO5tpyjSzl9OdTbTkOQ/XEuzTicXOX8/Ec1syQ0AjABX3/dh5Pk5Dyj1
 diBtyjXfWxqAVK2qcKOWvR+Pb+2+eP8MHxdtWs110eb4N0/djchHb3V97U7UvggNvlQoaQ0IN8
 Hq++Nw/x+HCtvYFd15C7bH4aAGTiEajxaOX/16AqL0s3mGrhQjag1JHr/Yea6+KN4IAkibR+ub
 o9d7L2uviQyDppE0hSX/0Zu/r7yxm25fSIDl04OXer+v6Az5mPMAAAgAA
X-Change-ID: 20261024-alpha-profileme-6e98a977cb54
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10792; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=qCkQ3NZ5P5b1xXYTO4UiFWQiPe2jOJYehrL5aC+fA4o=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht8xmpdYsPXpM5+zPtNzzpbIXxL/3Ot5x0Wj2sqgr
 /myqaNrx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFyzuZqRYdnvlQmMqd
 1OFzOsDq13iDi4+G7TTCmhB9fZ1WcarFiw4ybD/yB5DoFL7kuW3L7r/Wta0xHtBdLMn28tNjRje
 XJZt5x7JicA
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

Patch 1 stops alpha_pmu_del() from indexing the counter arrays at -1
for an event that a failed group schedule rolls back before it has a
counter. Patch 2 fixes a constant passed to the wrong PALcode call, with
no functional change. Patch 3 adds the sysfs format and event attributes
the perf tool needs to name raw events. Patch 4 fixes counts lost when
an event is stopped before its first start, and patch 5 stops reporting
user registers that the entry code has not saved yet. Patch 6 ignores
counter interrupts that were pending when the counter was rewritten,
and stops counting an overflow twice when a read races its interrupt.
Patch 7 adds ProfileMe sampling, selected with precise_ip or a new
profileme config bit, so cycles:p and perf record's default event use
it. Patch 8 attaches the status registers to each sample as
PERF_SAMPLE_RAW data, and patch 9 adds an option to randomize the
sampling interval so that it cannot lock onto a loop. Patches 10 and 11
report what PCTR1 counted as the sample weight and the data source of
memory accesses, DTB hits and misses. Patch 12 adds filters that keep
only retired, mispredicted or trapping instructions, and patch 13 makes
precise events sample only retired ones. Patch 14 lets ProfileMe events
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
warnings. As a normal user, perf record took 8746 samples, none of them
in the kernel. A two-event group multiplexed against a third event,
which makes the core roll the group back through alpha_pmu_del(),
counts the same instructions as one event counted alone.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v7:
- New patch 1: do not update or turn off counter -1 in alpha_pmu_del()
  for an event that group_sched_in() rolls back before it has a
  counter. Found by Sashiko.
- Patch 7: park the ProfileMe counters only for an event that had them.
- Patch 9: keep the randomized interval positive when the counter
  overshot by nearly a whole period. Found by Sashiko.
- Patches 2 to 14: picked up Reviewed-by and Tested-by from Magnus
  Lindholm.
- Link to v6: https://patch.msgid.link/20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com

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

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: James Clark <james.clark@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
To: Matt Turner <mattst88@gmail.com>
To: Magnus Lindholm <linmag7@gmail.com>
To: Michael Cree <mcree@orcon.net.nz>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org

---
Matt Turner (14):
      alpha/perf: do not update an event that has no counter in alpha_pmu_del()
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
 arch/alpha/kernel/perf_event.c           | 675 +++++++++++++++++++++++++++++--
 arch/alpha/kernel/perf_regs.c            |  13 +
 7 files changed, 754 insertions(+), 24 deletions(-)
---
base-commit: 330517c63aa9b48227b6ab45f01003effac77ae4
change-id: 20261024-alpha-profileme-6e98a977cb54

Best regards,
--  
Matt Turner <mattst88@gmail.com>

