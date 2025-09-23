Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240F31B104
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666840; cv=none; b=HK2z8Xm/36aGWzOBXizK++W0m+vCRWKQdm+6JNNvIh3DUekJmW9IeYyvx7Q1rY1KNkUh5hZqW1clgIAxIlg/waEuyQuUDKmOyXn4ExWdFVOJQPaOiASIYnqG9psql6AarR4dSI4Ko8wd62JDWkT119q1+CyhmfBRZzEv91EbjNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666840; c=relaxed/simple;
	bh=42iBM+j6OaHjeb87rjIgQvbVIu0m2YAxZp+bcUWwqIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mJnSOVVLrVj6MhzmZY9j85VGglqu0BASVmqFSHSaBes28u2/U75jYznodduZfrylwzrb2XumslCY7FVZ9WOM3+SbOmyqrKNybJRBVD01XgOIwOPrmicYyT8KhfJaZzFsIfj9AWBqW/85rxSohbfh2kzqFBARqFOl+jxD92ZfoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etqglgIK; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etqglgIK"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-30cce8e3ceaso5441888fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666837; x=1759271637; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMlKXhObDH6+v/xxS2IL1R5qtxgnEu4dYtMPfrzR6FE=;
        b=etqglgIKueYvokthz4WDaYvD0T4MJLbVqfc//c/19CG8pKD2YhvR4H0/h1IK32/UwF
         tiMlZFj+HFV1NTpi+kXK2wsqk/Zr878sUXCvwUTkymNsoMsdaSJ49/+W0xMnQCe2Qup7
         wbOM6uFC1lbA0dVPp/q55oZNi++jb/ZqgQxqgUsxmylrRJQpC7F0j6wbFVsgR1onPIeY
         LNuYj4k3Axs11QAxb9juVyowXlgDbCjQa3Be3fMgupIndRNizXoRSOJ3Cwk5jYfwg+dz
         0yWDgcxB6025ogqdmXZZ1srVck0w9nhAIiBZf567mkucenU57bjnOOSnFOHaCdgxJrGW
         vEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666837; x=1759271637;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMlKXhObDH6+v/xxS2IL1R5qtxgnEu4dYtMPfrzR6FE=;
        b=V3dVXHVwOnNg6rF3L2ScHIK5CgFsO977iSrv6loS6SNOp2XxCAdM6FmvDL+ltdxYeg
         uVv3myv+1HYUNNkycVonPrwRg1PhQiIqA3COub5lndndRe9Fp1Zmz1yJ6Henfy7JSqdT
         DLB+t/5qCRFP9F3i+9N1EUxiz435lqs8dRviz3oWGeCwZhUJqPEbAZ8KlSNak2fqNXjq
         1bKrhS5EjL0Y4pvMTU3iQr2p3FT3sskxPf/PFeEF714P9Ddnuw7xPn2llKPddOs7zgH3
         BFIA1+DhqF1RwPvBEFmN3+sLVP1AHGDLtR7/YphFZapd3zBwNzrkY32zUkik8hre06zL
         /yyw==
X-Forwarded-Encrypted: i=1; AJvYcCXrMvikgUaUNYPwNhtIH5rlFtUMMQFCF+ps3+sMNAMrzpiqyZzV18xVgxJ4D1/YsTMe0ZPyCoBu833CZhOCu+00@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oWqQwmz535UvE8w8ulnGS0m3+bZp71enm3k/pCZ2x/fFI4M9
	TLL/ERk4xxdV521KkpXYwr9I8ijOrALDklw5poun6QkhVWyIiPxuId0qW0dDgOxYKMDP58P7fa2
	cbhvoR1M4CQ==
X-Google-Smtp-Source: AGHT+IGmI59971cWhRtBH4s39QCrFKkDrBGJN0Xxu36OFFEhisXlDVwIUaX5vr4py2tnOPIW3tuiMk4t7ch7
X-Received: from oabhq10.prod.google.com ([2002:a05:6870:9b0a:b0:345:c5fa:1f7d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:2012:b0:331:6f29:7e05
 with SMTP id 586e51a60fabf-34c6442b549mr2507400fac.0.1758666837211; Tue, 23
 Sep 2025 15:33:57 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:04 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-21-irogers@google.com>
Subject: [PATCH v6 20/28] perf evlist: Avoid scanning all PMUs for evlist__new_default
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than wildcard matching the cycles event specify only the core
PMUs. This avoids potentially loading unnecessary uncore PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 80d8387e6b97..e8217efdda53 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -101,16 +101,24 @@ struct evlist *evlist__new_default(void)
 {
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
-	int err;
+	struct perf_pmu *pmu = NULL;
 
 	if (!evlist)
 		return NULL;
 
 	can_profile_kernel = perf_event_paranoid_check(1);
-	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
-	if (err) {
-		evlist__delete(evlist);
-		return NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		char buf[256];
+		int err;
+
+		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+			 can_profile_kernel ? "P" : "Pu");
+		err = parse_event(evlist, buf);
+		if (err) {
+			evlist__delete(evlist);
+			return NULL;
+		}
 	}
 
 	if (evlist->core.nr_entries > 1) {
-- 
2.51.0.534.gc79095c0ca-goog

