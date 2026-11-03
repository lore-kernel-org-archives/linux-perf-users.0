Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738258;
	b=iwKMDx9aTv2eH09MCAaXIwvMNgYRl+KSyckPUojrW6YoDsaR4PIJRHX7KE5L/589EMRn
	 BholpN3+pzkXeUfqy4aVXBQhruiLVQa3m9r6h+sXbI9mdkaNGmuxrYw2Fq8rmj/B4q4Na
	 QG6uRfGSQpkqZUrYmh5iNA6iaUeJfIlBQd2VxK0EF90R3VBGw/xvoSd3JCcjKkTaQ9zzl
	 OqqSkIf47fhl5NKN4HwSgSD0l6seo4FeaIbPrNe/MZ/TdnfpSEJJF/iC7OVpP+KLU6aKn
	 fzjksuN0ZUCUVR8W2k5rC9f7WuXbb7Uejxx1gsAaTXa9TI39ljP8CokMRk58gIRNvvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=CAJZ9w7PvYuaNBVJxa/d2is14JnTz6y5YmlVXkPbIHM=;
	b=l5mYfZ8WL54XIbnAjg96WVCgrUdJRjhQ6vJFIc0T1Lx3QEA2494XVFfqTmr11TGtyI2m
	 XtEEo0IxV7e+t1TObrP+PlRg/GB1Yla4sXJOTvQ0/3/eEYyscYQGvXlykYMXeEZ+p3IQ3
	 pA5otbmYDyAJc9TZW+362ZH6fvGP4by0Gnw9mcxyzTLh64hRz8LeA0oV134oG1lALt0Ps
	 QMeQPdo8r5RI5vM1+Zp/pm9Y9Z/dzpSBMGWJO5vzSt9oDO5YREjsCp79xf3B9wbEHIyNa
	 L2JryLFDvp0EYhQ2gBkTY2s85g0Jqv3DJsDQgnJx0BYrQ/NHx7W3yWwnhrr4ti5luEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLGSc2nu;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1897A606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1897A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DLGSc2nu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0cf2c0785so18527b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738257; x=1794343057; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CAJZ9w7PvYuaNBVJxa/d2is14JnTz6y5YmlVXkPbIHM=;
        b=DLGSc2nua2sAubmMqauOCurDIC1jpM1/FNHFFjxO1+5wcsfGHs5wqAClpQZLXUC+ov
         jhnY+w6ETBzizbTMhO170i+b4aHBR4ulnDzV70xpGFUvcdLwVEP1xCwPyGP1l2XfvLDo
         svwSe9jXr5c5piF+m+ABt66W1+03HXkxo+JJbxgO+5WKOjJ3St9ole8EfIVPl7OgsP/x
         E5Y7f479u7z1lf7f0Wzf4w6tZhmAeaCm8F54oTD02QIi6zZ7ZCYk47W9rbOyaxttbt9A
         Bv3oQJZnEAPZpwdMOkqs3hVF81EynJ1d/uRpQm2xGi+3kZkfOgqRQ4aARwdsOKska4nJ
         lIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738257; x=1794343057;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CAJZ9w7PvYuaNBVJxa/d2is14JnTz6y5YmlVXkPbIHM=;
        b=i+uscQs1LXET3D/nSzsYEqz05Gax2jYrSBnlMnOG+JXXr7/MBgAFcRGRJaI1NWsdrq
         K+YDXOObVs0VNQpUh/j7UL5q3av1+ipHMFPzUrz96Iim/MJmgYGa5TRGywf/TkxqZbBH
         Io6G8DgMkbsnOb2wpn78AWus37JVEY6gxAgyvRNvK3Zi+uTM7y7AhR0c1BtxgQ6aUQ5K
         g97TQ3hSqhiy9JSOqz90h3zzWs5XVdc1FM7e39rQMfv0lrdRtoX2f6e8By/GNbBollPd
         xY58YKa/X84cKJ2Y3H9EpTaZzTeoiBFlE1wa0OYJworuGYjqK3OVFw0s8AKcXVWnzKuO
         SNMw==
X-Forwarded-Encrypted: i=1; AKwUvBxNIvS0eWs1mcdM7vNW/VC/E8C5vNCYPpAlX/08DkZjHhWdt8dMiMLtIHSOCNSGGo5VYXlkJOr+4ZXLxJDQJOmG@vger.kernel.org
X-Gm-Message-State: APuU4Z8Cjf0kavDL7U6N/9cBNDA9L0oCnzOcsZycEXhnAb0uyy0yDyf3
	uf4jhF32Omjn3pr0lfCKQf5OjAvVrAjNZAa1nhR1TaH0FnCZr5JGZAST
X-Gm-Gg: AYBFou1Ve0amCT95g5qd5aYfwk66YevMhxQnGbAZ2M+ED5SommH0NnujDB34nTAUncF
	CIWqDzlFWh3sJN5WldyP9lnxnQUkXwRNI1nB44hzMmg45RbBlDrIKTfnK8QGuOqIU+X6b8xITDU
	Osr82TnkNz+0jeC9sEhL+hJMiVCRHNKRWzUqbq7QimNX7arzuAb//iyE60iG5C20256oYwz3wzJ
	V4G4eDi0u1jxmbRwtMZjGYuros0ybIOl012E/TTi7qZFVOh/Cd0ZbpFVPBfLqhfFgfTLxbMRHHQ
	dfW5MYxalwqxHBY1F5JOF2CJCV/HCkIGETxpYfR02eIktddSfmlmv3P7/c6JBchEwr+Nj8jNGEc
	tiy9gzvVnd+kGcMdVQUIyErjSAuaNnRRQGN9trAswKcg3o1+VnlfCYjv/3GKxyFdrknMHUS/00r
	Xb5GnMQkSaL58wRK8QqP5QaZ9i6Qn/akaFG7fmnt2GMw03xqw5bvDlCTgefA5a8Dw+mlk5iYWqP
	HWgvE2gHkOERKolXCz4c6pLZpv7kx/U3IKTbSwBMuLGLLSPw0/MRH0wkiNCn5XS7HpqRtodDz7e
	zC8Qc3KoMtURgWplsrlfWJAEAqItza37ZAHRQ67LccaGctpsiAtI3YPH9oOH969aW7fnn/v51nR
	5Mw1Qf94pL6DQdW+wA25kpYyeFzLtHoM=
X-Received: by 2002:a05:690c:386:b0:8ab:a473:fde9 with SMTP id 00721157ae682-8b2b67a4c22mr85235777b3.95.1793738256981;
        Tue, 03 Nov 2026 12:37:36 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b30997aa84sm4668747b3.29.2026.11.03.12.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:37:36 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 00/11] alpha/perf: add ProfileMe sampling
Date: Tue, 03 Nov 2026 15:37:33 -0500
Message-Id: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNTW6DMBCG4atEXtfRzGDz01XvEXVhm3FwBQHZC
 WoVcfeaRFVRWH7SPO/cReIYOIn3w11EnkMK4yUP/XYQrjOXM8vQ5i0IqEQgJU0/dUZOcfSh54F
 lyU1tmqpyViuR1RTZh+9H8fT53Olmv9hd18x60YV0HePP4+WM691fvd7VZ5QgW6WsJutJA3ycB
 xP6oxsHsdZn2vgC9p6ydxWQR1dqqujVF/8eAfe+yL6hViNabUCpV6+2nvZeZV8iA3jN2Jp665d
 l+QWfvFLhgAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7353; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=refArfxK4ah7c+vGUWppYA8/fex5U3SemuzZ82rLSjs=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeufG9kzsYre8k5i/z68nWyWKtr/IX6J9cH65YYbepb
 KuiubhYx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFzzSYPhn7I2/7Gzk+
 ruL8/ccSH8wL4NjR94rO/I7vyr+JxrcqalzVeGfzrn01Uv7m52y3w6h7F7m+WHgvmLYtdIOXf9L
 xTmubyJjQ0A
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
user registers that the entry code has not saved yet. Patch 5 adds
ProfileMe sampling, selected with precise_ip or a new profileme config
bit, so cycles:p and perf record's default event use it. Patch 6
attaches the status registers to each sample as PERF_SAMPLE_RAW data,
and patch 7 adds an option to randomize the sampling interval so that it
cannot lock onto a loop. Patches 8 and 9 report what PCTR1 counted as
the sample weight and the data source of DTB misses. Patch 10 adds
filters that keep only retired, mispredicted or trapping instructions,
and patch 11 makes precise events sample only retired ones.

A separate series for perf-tools-next adds a decoder for the raw data
to perf report -D and perf script -D, and a script that sums the status
by symbol or by instruction, in the style of DCPI.

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
warnings.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
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
Matt Turner (11):
      alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the logging options call
      alpha/perf: add sysfs format and event attributes
      alpha/perf: clear PERF_HES_UPTODATE when an event starts counting
      alpha/perf: do not report user registers from the entry code
      alpha/perf: implement ProfileMe sampling
      alpha/perf: attach ProfileMe status as PERF_SAMPLE_RAW data
      alpha/perf: optionally randomize the ProfileMe sampling interval
      alpha/perf: report the ProfileMe window count as the sample weight
      alpha/perf: report the data source of ProfileMe DTB misses
      alpha/perf: add ProfileMe sample filters
      alpha/perf: sample only retired instructions for precise events

 arch/alpha/include/asm/perf_event.h      |   2 +
 arch/alpha/include/asm/ptrace.h          |  12 +
 arch/alpha/include/asm/wrperfmon.h       |  36 +++
 arch/alpha/include/uapi/asm/perf_event.h |  31 ++
 arch/alpha/kernel/entry.S                |   9 +
 arch/alpha/kernel/perf_event.c           | 535 ++++++++++++++++++++++++++++++-
 arch/alpha/kernel/perf_regs.c            |  13 +
 7 files changed, 625 insertions(+), 13 deletions(-)
---
base-commit: 330517c63aa9b48227b6ab45f01003effac77ae4
change-id: 20261024-alpha-profileme-6e98a977cb54

Best regards,
--  
Matt Turner <mattst88@gmail.com>

