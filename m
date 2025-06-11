Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89221421D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657752; cv=none; b=NZiezvQMb1UJ9Rsq4dZqgqeWsH0IUHL8+V9OkvKYZzRKRRC/OMUzOAASnC+4G+JYGJFTyONVhggN4KkAwZGkiTSJj5vPSeima+KioQD1AiNEDKBdj/Gq1b+82JvBL1NGQVS0hJs34vjmO8RH34x06sh7OUzPoxBELXyxJs2mSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657752; c=relaxed/simple;
	bh=lMUzWucCt2ROmASLRaeGsCDbhBIUAz/hWwGBLXVbmLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Ahw0BQE6Owm0T0qGgXk3iFP80gngQFkkiaVgnHaSAnnXbDE+EGac2Frwv3nGp5LF/wgBWq2zpyAem4pGqd2g5oEv7u2kut1eJdVFNKF4Ff+t2fu0JovV14rHd7qN1jl0Ue65q+2kPSvMUN5a9cIAkQXWobOvZjpuXBx04NzWBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5CG/QBv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5CG/QBv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2350804a43eso105645245ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657750; x=1750262550; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nK9QQXvMHqIOnx7BDdzxOsoSdak/8YKazW30SmjV1l8=;
        b=X5CG/QBvdscGiCcYoikUF+y5ufKZcqVSAjPcgdk//nh3QGruHN9Gl8auT7PfSXKvJZ
         g57UUzj25J9l+HJGYlgTmG9YxhTfl6FE6/hIbo/5WZdYArNBlB3Gm7JIoni8DvLfaUHp
         AIbqeEFpzYnIc/2G0MAtxQxMB4qpdA2QG8k2nZwrkX+JeQqJubobWuYNyehGwhIcXdsc
         2umuK+KbgAdpUbNoTI4nnPpgEbB9ZlA+ILHKE1VcHpnYQlnUTX9GeIl1m4L+1PeGHXn9
         /ZOZFTXrkSLYyvVasHQcvnMNebay6+hRWeCj1UepSzK4phwB1jBPSeCxWF38D2iX3y6p
         gayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657750; x=1750262550;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nK9QQXvMHqIOnx7BDdzxOsoSdak/8YKazW30SmjV1l8=;
        b=Iuu37b6nRky9srQMHXgyYXnPDiuSpDfDh88JPTn2dQMK69E/NuLx1C7AdfC67KK47H
         /WSv+BFhtL72/DMTaKLDtP1aX48CvoSeqC1YhbaDZmwb262BYP4bLPoNnPx6gDr/VuMW
         BLWwft4SxQ/GFUm6pXvNORMcLlUN/YV3d++jDJJZbqBGGLR3Jfoxqo2q9wcGCZmF2HEx
         /HWfZbUA365fFOZWIv+2BljSnSjqdpsA4z3zaWVhneAH4mnLhmTyINVXVvNnr4oefrEK
         K3N684Uk60QNNFV5N3GKrpulkf1K5UCjAGZZFPzCAj9s8KYL81tEtTIzM3Cfno1owPXO
         TxOA==
X-Forwarded-Encrypted: i=1; AJvYcCUemu8ITLiRiOIbu5/WK9Pwcyv6mWpbe4E7OthwrKdHOJlY7+5zdHMJxKfvq2teZ4OsiZxJKyaskX5lNFaVPfAu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wi6awWt4vXYMyoWklapIGywp2uyubWpPxxjf5D5NW1eW18Cd
	3Y3eZikoLg0Jd05InGlfE7E7dcDWgUJQjxzwofEoaIAK/fZy6MkmGgFiZxchjLX+UmujeH1tkT+
	DxLsv/QlUlg==
X-Google-Smtp-Source: AGHT+IFwynm1t6c+9BuOMfilAtMdqdGHfJBn6YJirPC4Yz8p5qPArARQgQARTAV9Uf7sO1arawH6VL/ym+Fq
X-Received: from plhy18.prod.google.com ([2002:a17:902:d652:b0:235:54f:4f12])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d547:b0:235:ea29:28e9
 with SMTP id d9443c01a7336-23641b15570mr61294375ad.38.1749657750396; Wed, 11
 Jun 2025 09:02:30 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:02:01 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-11-irogers@google.com>
Subject: [PATCH v2 10/15] perf pmu: Tolerate failure to read the type for
 wellknown PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If sysfs isn't mounted then we may fail to read a PMU's type. In this
situation resort to lookup of wellknown types. Only applies to
software, tracepoint and breakpoint PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 76b7ded7fbf4..c0c12880146a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1180,6 +1180,32 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 	return 0;
 }
 
+static __u32 wellknown_pmu_type(const char *pmu_name)
+{
+	struct {
+		const char *pmu_name;
+		__u32 type;
+	} wellknown_pmus[] = {
+		{
+			"software",
+			PERF_TYPE_SOFTWARE
+		},
+		{
+			"tracepoint",
+			PERF_TYPE_TRACEPOINT
+		},
+		{
+			"breakpoint",
+			PERF_TYPE_BREAKPOINT
+		},
+	};
+	for (size_t i = 0; i < ARRAY_SIZE(wellknown_pmus); i++) {
+		if (!strcmp(wellknown_pmus[i].pmu_name, pmu_name))
+			return wellknown_pmus[i].type;
+	}
+	return PERF_TYPE_MAX;
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name,
 				  bool eager_load)
 {
@@ -1199,8 +1225,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * that type value is successfully assigned (return 1).
 	 */
 	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &pmu->type) != 1) {
-		perf_pmu__delete(pmu);
-		return NULL;
+		/* Double check the PMU's name isn't wellknown. */
+		pmu->type = wellknown_pmu_type(name);
+		if (pmu->type == PERF_TYPE_MAX) {
+			perf_pmu__delete(pmu);
+			return NULL;
+		}
 	}
 
 	/*
-- 
2.50.0.rc0.642.g800a2b2222-goog

