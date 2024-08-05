Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A516D33D
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887081; cv=none; b=LjWmHpyogOO9tGk2RhpLsk6V1gV9eZK+ngg2no+mrjrkQ7qU2AkoE+vJZD8bJ1l7UuvJEwZoSxGE96w8NsqAk123Wly8k5JAnSMfiQuje8IyqnC52cOl/9A3R+ZxwYoRAsn9Z+rB/lO4aYVr6mdaVqrXsQZw2AuZvcnVEZe18KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887081; c=relaxed/simple;
	bh=OkprP2+30CGqXbCJlToyp/lfbM9hlW0HK2ABpa1Qa+8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oOydXmytWSYUpI15JqMrg/LhtXrREgP4hpca30wrUem5IN2Rqo0Q+9ZEk5v98bP+0UIR37Sit6+3uXHEYmGK1pLdTH5HW3iJ6BNbezfN8u04wWTt3OzCjTriv0BgAXZXW2DGPH62/BLqIJXag2rqw9LbFr3sHI19qH+YdUbEjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDZIL9Th; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDZIL9Th"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0be2fa8f68so7187881276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887079; x=1723491879; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lfe4gxEvYKxDxRwW2qESsqEIUodbK6p7qv/mhdEEZFQ=;
        b=mDZIL9ThEPLP1K13LNI+vvWAkXI/9Ru9T9Zqs837qXFvHOSkW/aT8GHBZ45B9JDrvv
         WwK2ovuATFuI0fWDoOr5QbSD8lxs1OG7fHuSxoDcmsTnoeiPMmOKomd+rgyPdVGURBgd
         Dgs4luyX89aXiyHoa1hTsBTlMadPunpCqosXyVBmV4GW01hBnX489Um+gJ5Gcn2IUXq9
         EnY+euCrOZyPM419mhN5j2IKQECaQ6tfdHS7DBR8IuCZ/2fjDWG/3frBsfcW8pzSfAda
         a6FWWAOSMPtbto2aoKQ5Fb4sxvDKSXfcke0pFuLBHC9BwycnFcLTp8vhrqvFqPIXe0Rk
         S8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887079; x=1723491879;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lfe4gxEvYKxDxRwW2qESsqEIUodbK6p7qv/mhdEEZFQ=;
        b=C9OeuN0Gc/5ZjKgS+brOt1O0X4fHFnQ8PnOBWxNVc0SjP0v3gP54PCvTmuC1oSlpDv
         BxKGhkPu7e3zZ/I3DGdf5wGQTp/0/N+OZRfFQBbT9QGImvZAZYYKmg6MmkTJqwD0+tOh
         5H2SksVVwGikIScWzWMw1QKBcUGs+HHVeGyHQMI9iBANRf7N9gpURdI+vSHjPBb9YS4R
         dFpd0ijGiP+7b028vyl0DmVotpOxbqNwSyLCjiUjYHP6Ry53FBRIolKoQ0Ex1uylebQj
         dsYlMF8O5+AU4dt9gUBz/+6buZXi0/gKZvbeg4menZZVTpO4TLDc2CtXnIZbsCPaEsHD
         GrIA==
X-Forwarded-Encrypted: i=1; AJvYcCXsFAscQ+xbbjTE/V7a3FD7qtSuW1+S3BIq7Y4EJBNFPdVRybPsoTeEGVeOgwMpGLb4Ow7ygR4UxPotRYG+C1YBANxOxHH2QBc9HgSs3pLtdQ==
X-Gm-Message-State: AOJu0YxKXWWxghTgsntoUUXQ03f97Ugmz8kYCoxWpzkTdAGqc4raKcDi
	13xIAb0oLF15lmOkVixd25lsKPnVcATmBPECQ+XJ6F7I2hbRX4ZoqESJbjYJalFY7ZqRgwYmVmN
	FuCC9yw==
X-Google-Smtp-Source: AGHT+IGrmti4jOH/kazGkyLVxy/soVqkMo0+E8STQu6tXr+6jrpf9QaL4kxNGpeU3MiUA4lgzpOT4h7CHrFx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1f65:8dc8:61d0:4b08])
 (user=irogers job=sendgmr) by 2002:a05:6902:2311:b0:e0b:6bb1:fac with SMTP id
 3f1490d57ef6-e0bde421a34mr35840276.9.1722887079301; Mon, 05 Aug 2024 12:44:39
 -0700 (PDT)
Date: Mon,  5 Aug 2024 12:44:23 -0700
In-Reply-To: <20240805194424.597244-1-irogers@google.com>
Message-Id: <20240805194424.597244-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Charles Ci-Jyun Wu <dminus@andestech.com>, Locus Wei-Han Chen <locus84@andestech.com>, 
	Atish Patra <atishp@rivosinc.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, 
	Eric Lin <eric.lin@sifive.com>
Content-Type: text/plain; charset="UTF-8"

FW_SFENCE_VMA_RECEIVED is repeated twice in the file which will break
invariants in perf list as discussed in this thread:
https://lore.kernel.org/linux-perf-users/20240719081651.24853-1-eric.lin@sifive.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json      | 3 ---
 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json      | 3 ---
 .../perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json | 3 ---
 .../perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
index 9b4a032186a7..5a996fa4b837 100644
--- a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
@@ -35,9 +35,6 @@
   {
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
-  {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
-  },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
   },
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
index 9b4a032186a7..5a996fa4b837 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
@@ -35,9 +35,6 @@
   {
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
-  {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
-  },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
   },
diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
index 9b4a032186a7..5a996fa4b837 100644
--- a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
@@ -35,9 +35,6 @@
   {
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
-  {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
-  },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
   },
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
index 9b4a032186a7..5a996fa4b837 100644
--- a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
@@ -35,9 +35,6 @@
   {
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
-  {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
-  },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
   },
-- 
2.46.0.rc2.264.g509ed76dc8-goog

