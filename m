Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDF1DE3AA
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963766; cv=none; b=iCt3WjKtj87GyUXO3DCTOaSdWZqlerC8NrhcghyQKazLV159Cqegrfrqe6iOFghvgRQrg1PXw7lIVuG7q5Xjpvs8ieeKHMP3OawXL2uEmSZ1vpFZxdgoKnGzCM/OksS0wsNb+xxgSReoAnO+ZVc2kt8+LyLmumtT9g5o/HsX9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963766; c=relaxed/simple;
	bh=BwcnXHvWKb+RT9sUijfODMh+FsJEE5mPxKIUSQOlBdo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=iOSHzJEcl3ONsKHtiO96B/xDJ+NVuzx0T38c0VImKPRdS6hPM2IWOcQGuF/mTqBAvtJNy1/Fa2xZfyTbNcTHGBT5SrMoQajQwm7B+bd0B3bg0ggXd/OA586rBdxYKKlJXeMPcULkRmhtaNrWG9ek/BFoKBOFN/RYGxm4vSnZpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTHKaYYQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTHKaYYQ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so1073526276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 23:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963763; x=1731568563; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wIF/aFyjH0swzXh//3pYKGTGeXLDfUk5PCZEh9QeTEg=;
        b=vTHKaYYQrAd/7C1usGa3g0C3H2f4NR4oEFfCyRBVa9t9ZYMTEHsqJmvfEVPLR9pBPp
         3aTfXxUmqc8n3bwoc5vfV8Cspa2iF1cpAaSwKp3AzYPhJSWkJ8ra4o8K69NaGsHoyK+9
         7+7LcaVCeZ97dbNkxvd8Re7NKaJXqyfKh/oQAhLC4wRnWoMRgf5IjEY121ynPEqN/YEB
         bDO1LU04NnP4EwG8necxZ1QVh5ttnLiw8ET/mDI7Yht+/dIlDuye1AwdOl6MqdvrTVoA
         DnCQDFSwpLdKYh1YgMcXCF6nGOUq7zBYJxMicjYks/bfZp5SgtR8dLTcWqUXVgkY4F3H
         VPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963763; x=1731568563;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIF/aFyjH0swzXh//3pYKGTGeXLDfUk5PCZEh9QeTEg=;
        b=MQQZ7q23HGiSo/MsYi2U/5Sopw5xW133eLmC/q/jiANWQL4gjJWp3qqhZKmdhXP1p0
         ONLk7n5T7CtogzF9Dd2q8CwnRZ5HS6Dto7K3/2fZfCZIFFYvzBWPcHp7YWgXv7ZVlcdp
         GcP0dH1TaH1rOMuR5MAuHEJsJUXtsa5Ik+rezkIkh/VYABJQ9tu077XWZt7dkAjED5g0
         gQVItCIW2Kdh5oyqKGt3QxyEVleGRIwgaDDOOSyINDo0HKbvvOUlOkUscvXaO5cWoPxS
         lUu3iCnq0282+9Q/LcdY01Dwba7I5nnWDDVMdHiUq5ErmipoADcjx7dPSAUz02rDcb0w
         Jm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVEO6fnWciNgLyVjukS6UAGJRDIypYTbaCvLH5si95ssxI3Unvg7BT16D20MpRB+JoPc8ZLeVj+aW1Ev0ReiJx@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpwj1pHJLIiIrsTxbl85gV8BWZgrw7Xpm1z6E/b5jvxqg/b2o
	pQxwRQXBIAZScg2KjM5c0ymQRTQOOeOHcEowl1jRxucnoVuGuuUAJSEie1HHLbwd21xXudeNc78
	lmAPbcg==
X-Google-Smtp-Source: AGHT+IHvCILyN5DpJxEsgBeXCmm3giFiBD6WLezeO39x4rZhcquIeovnhv7BJuOVaBOHsKZJ7wG2BPFJsN4k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a25:600b:0:b0:e30:cbcf:181c with SMTP id
 3f1490d57ef6-e3368e1f4femr4836276.2.1730963763338; Wed, 06 Nov 2024 23:16:03
 -0800 (PST)
Date: Wed,  6 Nov 2024 23:15:53 -0800
Message-Id: <20241107071600.9082-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 0/7] Refactor cpuid and metric table lookup code
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
lookup:
https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
These patches remove a lot of the logic relating CPUIDs to PMUs so
that the PMU isn't part of the question when finding a metric table.
For time reasons, it doesn't go as far as allowing system metrics
without a metric table as a metric table is needed for metrics to
refer to other metrics, and the refactoring of that resolution is a
hassle.

Ian Rogers (7):
  perf header: Move is_cpu_online to numa bench
  perf header: Refactor get_cpuid to take a CPU for ARM
  perf arm64 header: Use cpu argument in get_cpuid
  perf header: Avoid transitive PMU includes
  perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
  perf jevents: Add map_for_cpu
  perf pmu: Move pmu_metrics_table__find and remove ARM override

 tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
 tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
 tools/perf/arch/arm64/util/pmu.c         | 20 ------
 tools/perf/arch/loongarch/util/header.c  |  4 +-
 tools/perf/arch/powerpc/util/header.c    |  4 +-
 tools/perf/arch/riscv/util/header.c      |  4 +-
 tools/perf/arch/s390/util/header.c       |  6 +-
 tools/perf/arch/x86/util/auxtrace.c      |  3 +-
 tools/perf/arch/x86/util/header.c        |  5 +-
 tools/perf/bench/numa.c                  | 51 +++++++++++++++
 tools/perf/builtin-kvm.c                 |  4 +-
 tools/perf/pmu-events/empty-pmu-events.c | 39 ++++++-----
 tools/perf/pmu-events/jevents.py         | 39 ++++++-----
 tools/perf/pmu-events/pmu-events.h       |  2 +-
 tools/perf/tests/expr.c                  |  5 +-
 tools/perf/util/env.c                    |  4 +-
 tools/perf/util/expr.c                   |  6 +-
 tools/perf/util/header.c                 | 82 ++++++++----------------
 tools/perf/util/header.h                 | 23 +++----
 tools/perf/util/pmu.c                    | 25 --------
 tools/perf/util/pmu.h                    |  2 -
 tools/perf/util/probe-event.c            |  1 +
 22 files changed, 187 insertions(+), 229 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog

