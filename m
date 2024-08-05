Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF716C6A6
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887079; cv=none; b=ZUW9vlsDdMTnbHsndYRscT69hBBnKDtZfHJPurQpmeNqnhxcLtAOY1GycjLrucGkpbWsSmejprY/4BfaLJksVQgSe8ubJB+/qHm9CjhdiQU6vcJBDHVKFzA8DXhijEnQVnFP2vQUZA0zEZl5/oFLvwk+0/PUwfTY2lkWE97vawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887079; c=relaxed/simple;
	bh=1QrCpPczpIYO0QWueMZ+t45S7nwr5IGQhXhieD/M880=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cDIKvgBRChc/UL10wraQeUnPT+DZvZ/05b3N1Qk6+dza1W/a1xjnZmU5CirDgu3XpuDSpFvOUlIkg/OvpLBMrMA1qr/5HVnzv6kkA5BziCe6sJYB4LFcRj9nexSJDvlOp5FJU4xW+kXU66EV31GJyLZLGMAS26d2ug7eL9ElaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKB4q9Ee; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKB4q9Ee"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso14886505276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887077; x=1723491877; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6LamGx0sdNwDED1VdCLCVyXTKgGz4JF2HbccvXV2xg=;
        b=NKB4q9Ee1MY0aFCkFmQN/AQFqY2c6MLZrcEgEIQRpLJ9r/VpXkI+CdZXsAbS+Q5xVT
         mVtXnzwkMib1veQOwagNqzY6gPtZmQchcfbTRrA7iYeCMXSo88RXSZyRBys6KNXPdoiU
         c/CViDmXGSuhfLMJCxrd/tYMvqS4o1UZx7vd9lQwvOMUFG8pgvkskj4iggXfm4BFiH5L
         GS9nFD6dzGMY8RwVCe4wc8xwQTHfNaU6gGNfEwRIRR0XbWjF8WjqChpkR75LQX88VXO7
         cbS1BqbmEmZPmMeWYxWWzzXzFLnCZy7wjjp0uE9BmQwufydOZptXc79doaDqP2NUuAJ8
         D6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887077; x=1723491877;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6LamGx0sdNwDED1VdCLCVyXTKgGz4JF2HbccvXV2xg=;
        b=H2MS6AN9UbRjPVjN3Tid+iedKaqwAyeJAUC7BzcE3nGJ42sPpW+OsWBiWp7FjBSqFi
         gKaSYHNwHHa2MQQczRPXVkzGM0zlfQ+FVFfbtumXtSEdUoUupJVsQdDxISyJHolxj1tQ
         5JhvCDUcuahC4bG/6DCCDoAOYdDtKZtow73zQuTvDIpgUppgTmSD+cyuL3Dq6hVpcI5L
         Uvde5RDc3Z2Hk8xxxeTXOEPV9nOGyBuhkvCk85zPhZdxFl83mDINY1sfuNkwcoCMlLJI
         G8v0OWzCf0sifVHzr1IDgJsEaSdBx/RfSRMcdyvCx/tca1pI2aFRcQceWpppX8bBu0uR
         biNA==
X-Forwarded-Encrypted: i=1; AJvYcCUQLk7i/bWFyw8xADrat2ajG8mlgV+4SLuctn6W7biMdQgS692DsPrO3qC4YaeGKgHZ2t5wK38LVp48GnODr9BtLEL2YOIHQ//Wd0NbUFGpEA==
X-Gm-Message-State: AOJu0YxijiikZ+fWLsNMr4xryg1u3skMzaoRghqX3OrwKVGFGG6Rtou5
	fPgCHprHocyabu91pIhWoiTznMf+GOLMQ4lF2LF5M7UpV2dxYRVIL6gdMxHKsL+5ArXQpa+Gw0u
	WerjNxg==
X-Google-Smtp-Source: AGHT+IFdv3oV3aqOKUmsPGI61CM1Ai9LluPAyOkHwx2uTCKWXxhzLAfMUs0X+MdhGbjcuYrJiIZPaJSwZtB4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1f65:8dc8:61d0:4b08])
 (user=irogers job=sendgmr) by 2002:a05:6902:1148:b0:e0b:fe07:1e19 with SMTP
 id 3f1490d57ef6-e0bfe072223mr13804276.0.1722887076925; Mon, 05 Aug 2024
 12:44:36 -0700 (PDT)
Date: Mon,  5 Aug 2024 12:44:22 -0700
In-Reply-To: <20240805194424.597244-1-irogers@google.com>
Message-Id: <20240805194424.597244-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 3/5] perf pmu-events: Remove duplicated ampereone event
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

OP_SPEC is repeated twice in the file which will break invariants in
perf list as discussed in this thread:
https://lore.kernel.org/linux-perf-users/20240719081651.24853-1-eric.lin@sifive.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/arm64/ampere/ampereone/instruction.json    | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
index 18d1f2f76a23..9fe697d12fe0 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
@@ -77,9 +77,6 @@
     {
         "ArchStdEvent": "OP_RETIRED"
     },
-    {
-        "ArchStdEvent": "OP_SPEC"
-    },
     {
         "PublicDescription": "Operation speculatively executed, NOP",
         "EventCode": "0x100",
-- 
2.46.0.rc2.264.g509ed76dc8-goog

