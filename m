Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818439;
	b=KsnloMdFVbwQEqVjYpJ9clIYB7RV/5jr9IDKuOBc2mYP5bK5Yj7vIXEgBHiasoyh9Bn9
	 LiQONmHIAjJRoKqtycwd+qCuXI1VuuSQbIFQgGSkrI7wgdRf5r4lIMxZ/MeUiUJFbdfsE
	 /U6zcGnPS+WrdnmmDMIqI0DjkoS2bE1gc6CS4XEP/riwaOSYwkWKWHV6c9T6jKnzsKZ1B
	 JpvAMdD7Sx6MSFNOl3I1IsxzJ68EdhdrpSJv0i6o4F6ofizUw5V/0loNvMV6lMRhrNpL/
	 Um35t5EN/e8IGKOTPccjCrPvAu/AjVMXfjsUhINiCUPzFELrGn+1d7kvdixw1DyOchQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MW25hjDMN9fnl42Jgp9cMMEDFOlPXuWurbBc7DgYrdY=;
	b=do6QGwPqjkbJWYOBO0H3VgM7Pd1j0XqDBbL0wT0wlCvFnyM03yR5rfFF7oUybtsKB5wm
	 EaX+hrU2ARiv7LjxAamC9iE5ZVZJltyInVGQfk0N+LgTWbbWF/L4RKXzG98lX33J1EpLV
	 3B/8yQ3AAacW/mK5Jzb9/lgVw2STe10bK463BMNif3OBfSvS/ngjyP8hYq+dt4/0nspPr
	 XVeNsJxOb8PbHDlzde0EPLer1ZaBx7R4ra7kT+mstHJ+hXYKUWDKRJ+aLWo7fGimEDNOa
	 qtxxhkYD3P7kRWEMTMAveXCp3b4+qg/AttIj5ywC+l7uLzR1NvEy7IDyOOFomkpT58g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygO6a+B5;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F86606EE93
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08F86606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygO6a+B5
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0f59a5fdaso12496677b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818438; x=1794423238; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MW25hjDMN9fnl42Jgp9cMMEDFOlPXuWurbBc7DgYrdY=;
        b=ygO6a+B5rv6ddJNrX1cdMEwGNrWTj7H6ceQS2/xXOBM9XJoCUp5m+OcgzbUzn4leVF
         WyLIygXkFMxs2pgG1y+a0EaSTqSfsbjw+YIetz7PdcsTGWLwHuInr9DpZPsTlEBjIH3B
         R2lVkkcSptzriK3Iw14QyfW2wLTp9AckPLZhEDOyBDJtkJfEExWsaFcgydbOwFwlSvYb
         yhBEgRGu1TZOCaCocH1YcriJd+C4GZYOp9gE4naazA4LU95eXiSE+lWEONn0JIpGEdb5
         aRTV4yWpzjOASQJpSC27jvxfOaEddPoIMH3arUzPtY/nOK1SlA7OuBfhlYls+23Btfdt
         sKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818438; x=1794423238;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MW25hjDMN9fnl42Jgp9cMMEDFOlPXuWurbBc7DgYrdY=;
        b=lUJPIJ5wIH+lYgRLWtiaCfAtgalc3zX64ee9ytBSxsZ+TrXIrmrPw69avw9pPsl+Qn
         0iCZGQuEHIEgTmASR9+iR9cmk894jbrpVYUkUIGYzG3wcodVF/d+j3bzKB5P27nuGPwW
         iInhteWVeO3XHcVy2vJIEoE1/tj8TVOecG6+Pua+crNyDR/Lgry14/OH8gGM0jiy11Fj
         qc+6g6apZQZTg5yWgOayOG9lBhoSzLZae/LQOk3i+BvnwRJ/TUwCc47bl42ju++E/71N
         Byyt60dcTknEyzqqqi1ErurKzvgOBda8UFYSk6t/yjOD8ag8AAJexY6bYHFXv3P53vqn
         JB/Q==
X-Forwarded-Encrypted: i=1; AKwUvBx6E+FzIjNdYiHnis85yAUxssu8mqMQ0FBuX0pRYZeLjmnvUtaT6PtPk7zqX61LBk1p8nRJNGXN67rMiQaNqWlS@vger.kernel.org
X-Gm-Message-State: APuU4Z/eV5+GYawR7tVyjR1S11bmdyt4GTLmKM6eAAgSUCLUEfB5CgPL
	3S6O8OZ1jwvo/1dGkuhcaJ6fSMgWAGKQDg7ws9gAnX6CqyhWFDExh+hr
X-Gm-Gg: AYBFou27/0+rywSDYz57LEeYnBC/8EdcYfRTYCg6h2yOkbBcKRgjJ6KCzmBHeRQwhS7
	Oxpj8GSwokPa94wqhsvSEjTR7aRVdQPsK7uW8frJd0/mw67IFoaiWRHwZgDoxRWSGYozSsCANO4
	/rnhes6eqohMbYIeqseT1NeYwH8nJdO2ru0ARQWvz9RbnVlNEjCZ/VVhvyPiTxdt53XsB0SHJ1A
	x/ZmfRsq+Hn7WyDHZUQ2AZN8hoZGKsKrc99LKp7mnQN//M6AzB8JqE41RJ3ZDdrDuYIEm/fG03Z
	Er1YynjwzyUIrb/turZv767sY4+X3dnf6RFHq/dpu3qovOTso6MufHp4DXgojnWiVfM8leACtw8
	spAqlkkLzGOEhxF6k63nEffDYb+3TGt0Ne15KGodWr6fyv6wC6WGA7U4Gq8UVuSgqpR1SKntNJG
	+9j94SUrDNqilwkhoLIXpzm447hdHJuC1PWWyulo1hta+y1gbjZrDeBnVLg/KiDEjleb5ACe2RY
	CB4bjWsvmTxAzqPwMzf52Mkl0xXps8ladzWWBI3fLkvi3qLLEnyGDzoo3yHeVgmsC1ZZc7+lBKS
	maefVCZl0GV8qBJkzK0Krxhu0cc0qUZYdvmKMDkM57N+DbFNUozcoxVvjSGBrlLy12vvY7AySq8
	yOFYUuhT5sw==
X-Received: by 2002:a05:690c:f05:b0:8b0:9e27:fcd0 with SMTP id 00721157ae682-8b2b66c4171mr120311327b3.21.1793818437748;
        Wed, 04 Nov 2026 10:53:57 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309b9f50csm24364847b3.38.2026.11.04.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:53:57 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 0/3] perf alpha: Decode ProfileMe samples
Date: Wed, 04 Nov 2026 13:53:55 -0500
Message-Id: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOTQ6CMBAF4KuQrq2ZTgmCK+9hXJQyhRr+0iLRE
 O5uwYXEhLh8mZnvzcQ8OUuenaOJORqtt10bQnyImK5UWxK3RcgMARMBmPKenOGq7ivFe9cZW1N
 DPIUwy7KcJEoWTntHxj5X9nr7ZP/I76SHxVo2KuuHzr3W3lEse38qRsGBmzjRIpNpASAuZaNsf
 dRdw5aKETeIhB0EA5JpQgM5UIL4i8gvEl7ZQWRA4twkJIpCnaTcIvM8vwFL/6wuVAEAAA==
X-Change-ID: 20261028-perf-alpha-profileme-8010299be323
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4163; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=mwri5c3a60UO9UOwmoXQFRAV5LNNQJzOrWjLaoTcg4E=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe17s4z+N4sOaUzbn2ZQ/cRSQ8XdIsV4bMNdms1ZiWd
 TSuOZml4yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK7pEmFk2F0nFFCxut
 H/RXVl+NMnmw3eHBdWTn3BqLHL99U5z6a75owMGywOb8kukUj4aH+xTIXVlN3jxIS957Y6rTURY
 rdj8rnPAAA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The Alpha kernel series "alpha/perf: add ProfileMe sampling" adds
ProfileMe sampling to the Alpha cpu PMU. Each ProfileMe sample carries
the profiled instruction's PMPC and its I_STAT and PCTR_CTL status as
PERF_SAMPLE_RAW data, which says whether the instruction retired,
whether it trapped and why, whether it was a mispredicted branch,
stalled before map, or was killed on a wrong path, and what PCTR1
counted while it was in flight:

  https://lore.kernel.org/r/20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com

This series is the perf tool side. Patch 1 decodes the raw data in perf
report -D and perf script -D, as is done for AMD IBS. It copies the new
uapi header from the kernel series into tools/arch, so it should wait
until that header is merged. Patch 2 adds a script that sums the status
by symbol or by instruction, in the style of DCPI. Patch 3 gives perf
mem a ProfileMe event, as the kernel series reports the DTB hits and
misses of loads and stores in the data source.

To try it, with the kernel series applied:

  perf record -R -e cpu/instructions,profileme/ -- ./workload
  tools/perf/python/alpha-profileme.py --pc

I tested this on an AlphaServer ES47 (EV7). Sampling a loop whose
branch tests random data reports that branch mispredicted in 21% of its
samples, and 0% with sorted data. As a normal user, perf mem record on
a loop that loads one word from each page reports the load's DTB hits
and misses.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v4:
- Patches 1 and 2: ignore TRP, and MIS and the trap type with it, for
  an instruction killed before it was mapped, as the kernel series
  does. Thanks to Ian Rogers.
- Patch 2: record cpu/instructions,profileme/ in the example, as a
  precise event now samples only retired instructions, which leaves
  the killed% and invalid% columns at 0. Thanks to Ian Rogers.
- New patch 3: add a perf mem event for Alpha, cpu/cycles,profileme/.
  Suggested by Ian Rogers.
- Link to v3: https://patch.msgid.link/20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com

Changes in v3:
- Patch 1: silence -Wpacked around the uapi header, which breaks the
  build where __u64 is 4-byte aligned, such as sh4.
- Patch 2: only read raw data from cpu PMU events, as a tracepoint's
  payload can pass for ProfileMe status. Thanks to Magnus Lindholm.
- Patch 2: print a table for each thing PCTR1 can count, so that mixing
  events no longer averages unrelated values. Thanks to Magnus Lindholm.
- Link to v2: https://patch.msgid.link/20261030-perf-alpha-profileme-v2-0-9ce2f0b0e622@gmail.com

Changes in v2:
- Patch 1: copy the raw data out of the sample and convert it from
  little endian, so that it decodes on strict-alignment and big-endian
  hosts.
- Patches 1 and 2: follow the new 28-byte struct alpha_profileme_sample
  from kernel v2.
- Link to v1: https://patch.msgid.link/20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com

---
Matt Turner (3):
      perf alpha: Decode ProfileMe raw samples
      perf python: Add alpha-profileme.py
      perf alpha: Add perf mem support

 tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
 tools/perf/Documentation/perf-mem.txt          |   3 +
 tools/perf/arch/alpha/Build                    |   2 +-
 tools/perf/arch/alpha/util/Build               |   2 +
 tools/perf/arch/alpha/util/mem-events.c        |  17 +++
 tools/perf/arch/alpha/util/mem-events.h        |   7 +
 tools/perf/arch/alpha/util/pmu.c               |  11 ++
 tools/perf/check-headers.sh                    |   1 +
 tools/perf/python/alpha-profileme.py           | 178 +++++++++++++++++++++++++
 tools/perf/util/Build                          |   1 +
 tools/perf/util/alpha-sample-raw.c             | 156 ++++++++++++++++++++++
 tools/perf/util/sample-raw.c                   |   2 +
 tools/perf/util/sample-raw.h                   |   2 +
 13 files changed, 412 insertions(+), 1 deletion(-)
---
base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
change-id: 20261028-perf-alpha-profileme-8010299be323

Best regards,
--  
Matt Turner <mattst88@gmail.com>

