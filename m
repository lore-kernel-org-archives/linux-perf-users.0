Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9921922DA
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495651; cv=none; b=OSFPOjJxiKkU1CtM8CQRHpVtsBDgcn6GntB1z2+Xm3AQIP0Ljx5Or7n6H+/FLVVnfOhbYUenZZilkhbqQ5Rq8LV4piiL1FuO772LCPTXr/IVdgQcveqzGps+0dzd1sxSWPktwu9NEstXEJRdEW12PE71W9tj+yo6bAy3V81RUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495651; c=relaxed/simple;
	bh=SmGvrb/RiIfmEnAttLomvZlQJWQIDHH0GVeuoCluYbI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KS7YmADYpBKT6/wgQdbWTnB4qWKo/g2gc2PTc0GsehFx+EoF9waoKmIU6m3acziMAy9IpyBoYZSZ/iujLdHAw4tUjRq5Ze+u5cdnylwOSFq1tdlmtoRknmsKMtlUDLRRkcA9tpf2BFW76z7cefOqjJbs5IyOVOVjIuK1kEcO9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdlGMOYc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdlGMOYc"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e8826e03bso8161904276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495649; x=1724100449; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OP9aiQs3LSZ3NoWhBifFY5k1xgj0LP87bCzLwLOVCg=;
        b=qdlGMOYcTaT5MjZvJh0zqs/ocDvMweE5jAXKXA06vkWpJ26RGrp5YZVi3XPrM200qx
         QuZTsSucQFQmh5tVgtfh25wjWqboD41Ynoc2x+xNDvhsCY2sPn3fmlTUoVLhzmxYz9z0
         JzkgIT1G6O/4+YEYSBQSkUrKMG1a1oKlaz4L7dc6Uh9iiZgFcRdHbDOjf2XvmxjIXNyz
         kDSWHvnlcepES0mQmULSuL5RGaTYWETYSpG8mT04IbNFZTk7hgBy+wiBiPcEOHkzYtss
         oNQga7k2MFBWX5jITYonDCV935cKyXZgd8/Yp1Qzbz1iqsy3dMYOSnQFl9RnntOPrajy
         nRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495649; x=1724100449;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OP9aiQs3LSZ3NoWhBifFY5k1xgj0LP87bCzLwLOVCg=;
        b=v5Q/raHNjhnCk+pjismMobr4QIhFRBgbRlP8cwyq4jrrbcv/vksb9cA/HR+UISvxla
         1gf/PTsjnvQ1CB3GJSiuT57wGNMvomgCeontNQizzG2iw5GZ33ugQ9iRk2REdw5Its7Q
         kZK/Z68kE4Y/TmiU++3AtzdONG7BdqYpja69dhVcFsrpvcou1hVDDBkaKrHLjQAkiQ5O
         oGt+V5zlm4TyYPXHWEMbEuyty4YF69SP4YfpZhYk5xWK+XOKMQvSmfssmCxpfLPWHIZK
         YIuDCcf2stb77zm+cG/dKnJpUQHZTP/qOymvWXQGNWlN4s/+0lAArmFEArliV/dFizPu
         yqbA==
X-Forwarded-Encrypted: i=1; AJvYcCWXZSfpYfBqLSm9CdZDC5mnZ2l6TuxBV4oAcSJGhSPEUC+HX0COA1l1ohQ86GMniAFti8ZIVacmI+TdEC3adY6ISWbpY27Ds87Ir+0/9Hdw8Q==
X-Gm-Message-State: AOJu0YzyjddB7MJgNIMBH7bNwS3xADsVUKxK3iYztE54i5R82+E3cceT
	+rtl17XUlS1pYjCi9aODVu5M4axQOJm/iWs6Fb7FVJiUvXzUWRUN43G+bANE4EnAkzBAnWRC8Gr
	j8bB9Mw==
X-Google-Smtp-Source: AGHT+IF6KGsif2kcc/WLiE8m4uQ1YeulYGefZc5LJwWTscJn9uh205dobOwh2Y783hd/EsBConXuVHwlLeeL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:abe9:0:b0:e03:5b06:6db2 with SMTP id
 3f1490d57ef6-e113cd4619fmr2756276.3.1723495649104; Mon, 12 Aug 2024 13:47:29
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:46:54 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 02/27] perf s390-cpumsf: Remove unused struct
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
2.46.0.76.ge559c4bf1a-goog

