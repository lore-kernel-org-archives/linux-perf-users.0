Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1F4949F1
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041854; cv=none; b=no/JzOH5M5w8Sz5EjePlQawmQp+OR2qS6a7B9pGEfGNqLhjOCpHZNfpf4bUBgYvQVxc/BMrZTjXbxRpnLEOdR5vOIjuHl1f1H98auv5BEV9MGvwk15ohA57VElkKx5duKQihwIxAPC5+jCl4qFVaougPSbgXFZeWeJfhykrg8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041854; c=relaxed/simple;
	bh=5rl03LcIECCaTFJyLzi/CX4y8+jYxILqaa6AA+es0k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TbledW5T9/KpPEXCnRNJU9TP3W+pPX5LQkOKt30g87g5IaxuSvoc2ZVfZ3FM2wULAK/FDgpg21rZzzvdTQnkx/VzL7ASDCZ/Uo+WUMJ1CpCt0SFPGga0o+LCJfQdvg8YtNoJtsIUYQLuKLvw/Z6Am/zJzUeRRazAlYFS3BrDHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBbniq/5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBbniq/5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8584e3fc96so3008806a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781041852; x=1781646652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=joR1akmty7bWKs2aos/a2r2cuYEn9MQeFTvwKeRRZg8=;
        b=YBbniq/579NQxlqlut5QOWlABF48uFlO7l0g6+pr3nQpeoXOQLUh12hLKJ0chsOknq
         d5wopjin11oV4cyjaEK/SfmUAhcbkjqKlk8Kn7hdyeW4FKUfPN91fbLU8JZNbRoFmbBM
         7t5UzkLE/Mlta00b9vyQMPZGT/tBvgK4yy0yFs9txqFhe0gBOwqf00WKURM4isU3utt8
         T1dV/xx/PnNAlxyzO1p5IOzEB8r/aA0WW/w8jGHideyR6UEB5pLTCoNnbYaTnGzCZGfT
         q12SSPxJOS3frUQcXbIR4nFe1wIa7GvUZej+9zfSKzVFaFgejS+8gXs/Jg40+p9eD9cM
         fAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041852; x=1781646652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joR1akmty7bWKs2aos/a2r2cuYEn9MQeFTvwKeRRZg8=;
        b=Hv4OPkk/9u8DOCy5Kfn9+GYB2qwuMoFQ0uFPXOjtdn+mr/SVHLF8pjV4KAxR1kG6f8
         v+++kyLi3XRHYWg8KnFQLE1k+s25+y6uFPGTBWaDRKT67JJfxGb0EHAwtSbz7IAe2+Xe
         XO8WA7mjyDc0fq0dMOIIjl3hiSVoryakUzSvxngMkXl07jif0tjXCLK9UI42AMVDp57f
         WRAbjKhNmMjZeTfno7nkpIZgtia1c3C+pe76MWjn00G/DHGGaoH2MHXMTZiqOczud6Rs
         HZXaM4T/JZaNzs9GYQDo8WHD3yUa8sumto2VtkjBJ7Z9INaZYAGzCqIzAUd5HJURmnmy
         hxZg==
X-Forwarded-Encrypted: i=1; AFNElJ9rhWfSeZULACC2fKj5GHzPYt3visYj5pFgRHKPToqqYTdgAfSOV+dU0HnYSOeV6MuAK6dt4qoAZUYuW8oB1DYr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx42n6TVO6AxCy1uJtKyzTcylsw0Hd9QUcGbEzmsqLB/lKxnInl
	2W95r7nu9FNyFBH9iJTCAmcVevU0SOATTtSWgvuepA1LXfRWYxzU5o8y392GhCxuahhrqWJkFhu
	EFKRZVA==
X-Received: from pgam4.prod.google.com ([2002:a05:6a02:2b44:b0:c80:2987:4220])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d80d:b0:398:7df5:2dae
 with SMTP id adf61e73a8af0-3b4ccd3a845mr27121760637.9.1781041851840; Tue, 09
 Jun 2026 14:50:51 -0700 (PDT)
Date: Tue,  9 Jun 2026 14:50:42 -0700
In-Reply-To: <20260609215046.2391903-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609215046.2391903-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609215046.2391903-4-ctshao@google.com>
Subject: [PATCH v1 3/6] perf vendor events intel: Update graniterapids events
 from 1.18 to 1.19
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/875354c88686ef50387d9601f52354a6da8f24cc

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../arch/x86/graniterapids/uncore-interconnect.json    | 10 ++++++++++
 .../arch/x86/graniterapids/uncore-memory.json          |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv             |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
index 5eb1145f204f..9f0c4c7198b0 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -808,6 +808,16 @@
         "PerPkg": "1",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of Write Transactions as Secondary",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
index f559e27e2815..9cd2905726fd 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
@@ -539,7 +539,7 @@
         "Unit": "IMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Precharge due to (?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to page table : Counts the number of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 0f39073805ba..b8ea72b99c52 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.24,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.12,grandridge,core
-GenuineIntel-6-A[DE],v1.18,graniterapids,core
+GenuineIntel-6-A[DE],v1.19,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
-- 
2.54.0.1099.g489fc7bff1-goog

