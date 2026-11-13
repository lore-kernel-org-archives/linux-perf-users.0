Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555939;
	b=RO9i5vVK9Qj/1Ac2mENmUxSWU5nHRaqSs8GNxfplpUgjM3wyECP4K4n+WNFN6CZfZ2PP
	 DOKCaLYerbUymOpeEZHYMmGwrBeyPUdAOvedy5zefrDPICIEXn62HgZvFodT/Iqpl0Uqm
	 CuD0sOKxLIWhQDB1kyy3vq1Nb4JnOoc4zHXkpywxRlq2i6jzyFmYuLpa4Vwd7D5IYTHX4
	 StY7d6Yhu56wxdSDxBFoj8LXBaYCRu6E3lJHOy4h+uGH3Yf/5GdG0i5j6zxmpuyG7mjdF
	 ZQAL2ie48gsgO1ZV/L+ztdZHcm0awhKqEoec6sX/q/Tb9me6vJRmcF3pMtge7p4GwTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=kbWlqp+PP/iOtneW45+dH29ZaoMSJzg0Kt8GaqbeqFg=;
	b=08sHJS+5dUBBj3hKGd4aHc0H4vxioDYUJBRuDO5VkclH6Ic2iz8aV670x8Osnx/KXgbU
	 ZMZZExVda9PkabtjKNl3bXSGxyBalYt1v9dF4RYatFvWdg97t5Axl6ikA5RJ7xf2lnpqz
	 DZ8QnoOv+IMKb7BBkWBWElPZZhlnGq4JF64n6V2VldKg7vU9WkYScpHtCVkIug41Ftve5
	 w5c+g9CvxjV02SnmHAl6457jmq5v/Ij4UGGx2ZBJnt1/JX6Xz0xu6SvW9H3pXgcZjDKt8
	 zw29j/8XGUE+5Gcy0UX7rYAREKyHXqKWwcJ6BZRNSIuW27es00EkipHt0fB+OEe6tSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=t2eQgRLD;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218C606A31C;
	Fri, 13 Nov 2026 07:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A218C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=t2eQgRLD
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD59Ubn538073;
	Thu, 12 Nov 2026 23:41:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=kbWlqp+PP
	/iOtneW45+dH29ZaoMSJzg0Kt8GaqbeqFg=; b=t2eQgRLD/RmvWb7N/qU5+bMRi
	GhDv0VCkJTJ0s5wqGty4WdDQRTYeNPX4zYtl2lhZ/sD/Wqg9V0xGyWR6H4racf9j
	v2St+1gHRTymjyqpbaO67tfLQD57W32EPy5gys+us5YzYlOI838NuT8vHeyfV/w5
	FcI5ZKRTreF4Z09RCEtywhkDAQysTNFe+njzT9ckA52Z6AQpG40+NyAxr3eRfX5w
	eiYisMSOfOCkJYMAhjzbfZX8TcV5okDb6eU74T0pA08q+BWm6UPVMjNSOuAS2Ztg
	orIYa+n1ITNdrsSGHPRZIeRbj/PS7u10rmfDK5zWWucCXuw5sWt+LaPXciQaw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5m58y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Nov 2026 23:41:26 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 07:41:25 +0000
From: Amir Ayupov <aaupov@fb.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland
	<mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>
CC: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
        Leo Yan
	<leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@arm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <coresight@lists.linaro.org>
Subject: [RFC] perf: SW strobing for AUX trace windows
Date: Thu, 12 Nov 2026 23:41:18 -0800
Message-ID: <20261113074125.4146687-1-aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TeBQbyJhNnt7OsioNUmOuBeD9qrPZ2ef
X-Proofpoint-GUID: TeBQbyJhNnt7OsioNUmOuBeD9qrPZ2ef
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX8YgYw2Q5Vr3W
 aB7/ij6KdmeTFP4tlH8bDd0ud6DM94XYAeOMl+p9Goe8mjlLZG5jBHp9Qcq0Hxq4YVX++iDMZVF
 MFsAgPyS8EfOV0dUOUBFhCf4sMZ6V04=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af6bf26 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=PIE9aPrNAAAA:8
 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=fzWWWYk9tbCSLr39xJAA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=fyCUWhYcF35ZrUaEDlGM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX0eHq8I9s5mZP
 SRkR9GxFR/AkR1ywrf5JBBWBxn0tzL2ge3YoFFb92hvykbgzTMv7/31fNVBdR7r79mlrLC2Vy7V
 dmR2WaNTTlP/oq5qvXJZGEacrZhJimzsi/zPcDP58EC27uyXQ5slGQMveB+iK14D3SIAX1QDeRG
 zDhb3ag1KXX9EsgNdpu9X1999kootxIgIu6j+hpv2nnVjSga5I+iaYOBhxnrIqR3X+kOn18OdYE
 gbF0OYLiSBWo09gstQ6jsqMlroQtqfGjhNsil8v5IIDEVCJ50Z3GPt3K+U92/ftAWPd+MnQsrBt
 v68wqROmGqcD258UoiduSykPQL0gO06KNF+8Z6kgokQNOynWU6mBa3S6te3vZX0ObSLakq3wN1R
 jfBpgfrbwMawnnm/LuHb0NoM7DZBpomfdOw+f6ns7MoKurLVOXAgX7ad06l5FVKNvkKWTaLaGUT
 q0N+2ErIYbUlgXvB5yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01

Hello,

I'm reaching out for an input on the preferred approach to add perf
support for "software strobing": AUX trace windows started and stopped
by PMU events. The context for this ask is context-sensitive sampling
with ARM ETM: https://aaupov.github.io/blog/2026/10/02/csspgo-etm.

I've prototyped three approaches explained below, but I'm open to
alternatives (I'm not an expert and all options were explored with AI).

Motivation
--------

Context-sensitive profile needs "hybrid" samples with synchronized
call- and branch stacks as input. On Intel, they're collected with LBR+
PEBS. With tracing (ETM), sampling event needs to take a callchain
sample (with fp or dwarf unwinder), and pause tracing. After trace
decoding, synthesized branch stacks are attached to the pause event.

AUX pause/resume _almost_ supports this:
```
  perf record -a -e '{cs_etm/aux-action=start-paused/,
                      cycles/aux-action=resume/,
                      cycles/aux-action=pause,call-graph=fp/}' -c 10000000
```
The problem is that there's no notion of tracing window:
pause and resume events are unrelated, so the effective "window"
can be of any length. What's worse, pause events falling into paused
trace don't get the branch stack but still have overhead.

What we need is some mechanism of setting those tracing windows with
PMU events. There are several options how to achieve that, but they
all need perf changes.

pmu_pulse (coresight-only)
----------------------------------------------

The first attempt was to try to avoid perf/core entirely, and extend
a coresight config with pulsing ETE external output on every cycle
while tracing is enabled [1]. This way, pause event on TRCEXTOUTn
ends the window after exacly N traced cycles. The use of ETE external
output is pure coincidence, just a way to count cycles only while
tracing is enabled.

However, the review has raised that the config is not self-contained
and requires a lot of checks to only enable it on capable HW:
- needs a helper in the arm64 PMUv3 header and a move of PMU
  definitions - needs arm64 maintainer's approval;
- only works on ETE whose PMU counts TRCEXTOUTn,
- the window is always measured in traced cycles;
- is restricted to ETM, doesn't help Intel PT,
- the further it is from a pure config change, the less understanding
  I have to support the patch series further.

I decided to abandon that approach and ask for a better/more general
solution, hence this RFC.

Option 1: userspace stagger, PERF_EVENT_IOC_PERIOD-based
---------------------------------------------------------------------------

I prototyped this as `perf record --aux-action-stagger=W`:
- pause and resume count the same event with the same period,
- opened with a long "guard" period,
- on each cpu:
- perf sets the resume period via ioc_period,
- spins for W cycles in a busy loop,
- sets pause period.

Then both counters stay fixed window apart (not exact from run to run).
Related: this approach is hit by an issue fixed for Intel PT
in 2e17bf3a469a "perf/x86/intel/pt: Fix stop/start with no update".
ARM coresight needs an equivalent fix.

Cons:
- It only works per CPU or system-wide, no pid targeting.
- Inherited children start without the offset.
- Minimum window is ~2000 cycles on neoverse v2
- The code implementing "arming" is large/ugly because it does
  an atomic kernel action in userspace.

As a curiosity, the documentation lists that old ioc_period would make
this stagger trivial:
> PERF_EVENT_IOC_PERIOD
    This updates the overflow period for the event.

    Since Linux 3.7 (on ARM) and Linux 3.14 (all other
    architectures), the new period takes effect immediately.
    On older kernels, the new period did not take effect until
    after the next overflow.

- Open resume event with period T (without starting it),
- Open pause event with first staggered period T+W,
- Change second and subsequent pause periods to T using ioctl,
- Enable the group, both counters start together on every CPU.

Inheriting stagger in children would still be an issue though.

Option 2: attr.first_period (small uapi change)
---------------------------------------------------------

To support this fixed stagger, we could add a new first_period field:
if set, the first overflow would be set to first_period, then reloaded
to sample_period.

It addresses shortcomings of ioc stagger:
- children inherit the field,
- event group is scheduled together.

The core change is starting period_left (and last_period) from
first_period. PMUs opt in with a new capability, because software events
and some PMUs set up period_left themselves; other PMUs return
-EOPNOTSUPP. The arm PMU opts in. The attr grows to
PERF_ATTR_SIZE_VER11.

Cons: the window is in units of the sampling event.

Option 3: cross-event "arming" (attr.aux_pause_armed)
---------------------------------------------------------------------

This extends aux-action with a new bit (aux_pause_armed):
- aux pause event period is set in an overflow of aux resume in group,
- restarts from the full period,
- on overflow, pauses aux tracing:

This is the most flexible and general solution:
```
  # resume every 10M cycles, trace 5000 cycles
  -e '{cs_etm/aux-action=start-paused/,
       cycles/aux-action=resume,period=10000000/,
       cycles/aux-action=pause-armed,period=5000,call-graph=fp/}'

  # resume on page faults, trace 100k instructions
  -e '{intel_pt/aux-action=start-paused/,
       page-faults/aux-action=resume/,
       instructions/aux-action=pause-armed,period=100000/}'
```

Compared with second option:
- The trigger and the window can count different events.
- The pause event raises one interrupt per window.
- It works with any hardware event, on any architecture with an AUX
  tracer that supports pause (PT and ETM today).
- It needs no PMU driver changes.

The prototype adds about 60 lines to kernel/events/core.c, plus the
uapi bit and perf support.

Cons:
1. the core has to keep a disarmed event stopped across group
scheduling, throttling, ioc_period, power mgmt.
2. rearming happens in the overflow handler (in NMI/IRQ).
3. Software pause events are not supported.


Question
---------

Does it sound reasonable for perf to support this, or it's better
to pursue pt/coresight-specific solutions? In the end, my use case
is about tracing.

If yes, which option is preferable?
- Option 1 with restoring first period behavior that was already there,
- option 2 as cleaner fix,
- option 3 as completely general but with more core state to track,
- something else?

[1] https://lore.kernel.org/r/cover.1792989860.git.aaupov@fb.com

Thanks,
Amir
