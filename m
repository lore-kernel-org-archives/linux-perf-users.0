Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75851B86F0
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264443; cv=none; b=EDgkD6Qz+kFxu1xZTf5S9EvWpMmaU/G9DNHu6ItCbrh+4Mw6PoNUJwBhFVyzLDbAmI1sx78a2bp53j6WnnB2/XxjBy+1HhBaVTYPm2krVJJ+PoVCJx9G7327iziaJmD2FTX2C4KJKrg2QeOA0uaxyXbV6pOT5hNOwkmZOnPUhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264443; c=relaxed/simple;
	bh=HQ9pjS5EUr1pSL3eFHsOIf2h0mDHhIWLrampeLYlMAs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fVduk0mugXIqzs12xxuXr8SbdrT/zR544aL7OFYPUuCCnM+Nd8tY1RWO0MIIc8f6ujljyA2iewb8LVsmhLujRBSkbZTsGUivLf+imjgpD0ZgJD7tLc3kgC7O7NievC+qe+mdoYPCXE+TNcUpg1EJzwVi5wrUdCOVbRmNhXNxQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cqzm34n+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cqzm34n+"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654c14abdcfso7013147b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264441; x=1721869241; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rfk9ucJoML9tijv9a95Eu3szNeRcTXRIy2V/XQr/gxQ=;
        b=Cqzm34n+XsYfliHmsC6eCxl1AtFWGMX24ljMwmNkZnEUoE8jOG43Hcg2OT0b1Y3tVA
         c3Mni9YXKsy07iE4pd1+ZtRtU+VsaOtQvXYjNF8zuod/7HvOP3uRaOzhRJbcXKDrHiF/
         WHWMPNkJLdWrbqoorkjxPr7jQ/PJWNBzloU78vhugxoNOPjSqcZAcHyXsPFZnCZ5zRIz
         aMW9O81JZB99b6+5kNV6uDBpxSOPg/+gKaKKlGS0srSIsxGHD8E0P8rurNMmI/hSD/ow
         0SkwwSRI3RMUH3fcgD/V3iAskN9F50+y87Jpj/qqCyhLuWKUybcArKe8d5EMpVniIWHt
         i5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264441; x=1721869241;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfk9ucJoML9tijv9a95Eu3szNeRcTXRIy2V/XQr/gxQ=;
        b=P5BJ2HTxulGZissXaFpLEi4lg86p9VmJ0dua2wWVt94VhHTYS9dwSl941q8Vo50IyA
         QvKqSpRw2BwBicubvb0OH3XXYbXydIokZmudYY8yJwGQe6H+Tavls4nP9lFkyNzfgrRk
         37vb+1WdNf+rz6NiZKHICFTRhG9IqB5o+Op0z5wizChNVy+K8/R7/YviIiUgsjSHKwwg
         izJV/xop5Xn2aOsM9/6Vtl7XlGvMB4NujIOT7NO5PWmaysjQPFSMBbZFOAvfW45QNIVD
         srnBZ/NiZc0YqQ36KLYNFOmoywjRYosfWaMGY3nieKwgEi5jCfDOmsKDN9qJshXGxo/d
         lYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCsxaYyETGSmeQY2aV/Yk/i71nl1Aw/jNvQJWNqFQ2SyOQPUFjNA0lXtJSnramcshwm89s/MyCo8Hz5FxcakIT/HMLfJqILNbRAFKk/1uDFg==
X-Gm-Message-State: AOJu0Yy6gHfGpseMT6jHMTau8wO2i/xIkg64SjYmA0Mcw1bas0tkEtV2
	o6zOmaeXN2Vyw7WCO5AruaX1Pkngam83osFCvsTNFOFblwztMZP76AaQw4WdFmbZ9JCQ8j5xXmm
	X2kOLwA==
X-Google-Smtp-Source: AGHT+IF1OSvxnc+b1qvFcgOaFfrd5/kufXk1J812jAsRRfTuvf0iLiBjVTC4aFaquSt3jO72OgbZ/5EwdMFh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:4784:b0:665:24b0:e936 with SMTP
 id 00721157ae682-6660a82d4d3mr115707b3.4.1721264440715; Wed, 17 Jul 2024
 18:00:40 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:59:58 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 02/27] perf s390-cpumsf: Remove unused struct
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

struct s390_cpumsf_synth was likely cargo culted from other auxtrace
examples. It has no users, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/s390-cpumsf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6fe478b0b61b..4ec583e511af 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 	return err;
 }
 
-struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
-	struct perf_session *session;
-};
-
 static int
 s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
-- 
2.45.2.1089.g2a221341d9-goog

