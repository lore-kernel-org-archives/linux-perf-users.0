Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBEA277013
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601136; cv=none; b=XcxqUrwPaldDPZmU6C4btpy5E7PyeKZcxrDf6OBpRcY9K8gkcB9e1g/OrFIG+kLTIMmyUiNaw0KOk8/rWVmJRppwqRFh/ItEsW+Jv7Ebdkj2PU4mDXpkOeO8XzakeKHNtA2GCrg5oWkUQx1i+2S+vrkwaIk3bNS2E1ISYNIRN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601136; c=relaxed/simple;
	bh=Gnr8aN6GsTXLF4rZkpbbCQxr1ke1Ni185cKQORktmN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WOMa15rnXiiD9llC51lD4xs97tkBDPXSyCzvCszwieWGtxvmY+SXz2Na2/J7fSjXXrX8QfZo2VfOuPY4hYPke03aI62Fe7RVoRJGahhH9Ep2oRvOJA6DyK0S28iA8jyFL/XDCZNWCcBRZpVmxYRoKu+ODPLGgLnPjxJGPna+RmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFWag6NR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFWag6NR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f58171440so189672b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601134; x=1759205934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH93BLUOeILn9fmSsLk5rxs6+k76FrXoN/c2VrpOq9k=;
        b=ZFWag6NRlzAY7tFwWrj4DyjHZM+Cy1iWHIgkoXTiXUovpu00HwDJQDz5k1uLc2PL6h
         A5jQAySxWwwJYg5rCRLXf1mWC97lckFAyZIFM7a1hvg9u1bmfL7YFzYAHM29oa8fIDEI
         zuLzRg2/bxFK+qxpp31knCymcx6x9V5tg0AEcXmmY4IHDbG1yKvHsj492Z8Z7/Eo4r8c
         FdTJV9Jy4wh9GRFCYJ7E8oamstn+pujFvPMSixLZtJaKm81VlCF00vCab+Cy/IKtakbz
         IdgUdYbQavTelifSIIXg5rmwbQBEJNWe64zpUypqndlzcRmJEs+dsqXhznG+dTdJBuoH
         al5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601134; x=1759205934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QH93BLUOeILn9fmSsLk5rxs6+k76FrXoN/c2VrpOq9k=;
        b=SUgqzBBaL/NskKMjbH9b86Z8Ibpd4A4QMZ5RxmJuNFSp1wbXdTfFIF92NEovS7//iO
         cLJ+A7YXFjtjzAY7JSY2As44Y4qCqFQ9qu4G8qdGKQjwd5b4Uu7ZJrG85GYLX8PKKqy6
         crtJfx7Np1L8tBAMVHskIjZN0+rHKzKX4zd/SYmBUunhSy1RghHolrzynV74zvlDl2Lx
         pdjUzy91ilFdHdBsqCyyZx2mUPSU5qyGmwtp+TrgsjU538mMVCDcE/cFiw47LEsB3+qe
         U5rfDmQAn2hOqSgOHtic7LGeKnAvt4z2ZLznlGYjkNTlceYDc4cTSwkm4Lpu8EaY0t6g
         a7NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT7N2QbhcJXSwblHmBk5c8sdWbhrrpvoQ0v8q8c9Isjrjvd7rrWneheMBvqy6eA2RysJ/eU8cVLF/xT/FSexsp@vger.kernel.org
X-Gm-Message-State: AOJu0YzGTxfWXE2yq35u4JQaDo1tVvtmtD1GC4g9RjzA7Nqyp4rbWbxj
	rP2mUQjsqckm97dWVlH+lTwTOhAalwYauowLjL/YCGG0TpALmOSnwGMAkwIBVAWUQ2tSVVrYgd7
	ohiZvqL85QQ==
X-Google-Smtp-Source: AGHT+IFyAixlcbtHZAnaioZmflv1EKxs1Vwy3hK8MLnGqBgeSQ2SKufLmEyGsX4gTa1Ceuvwp94u1yJFmZEh
X-Received: from pfrg28.prod.google.com ([2002:aa7:9f1c:0:b0:77f:4da4:298c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e94:b0:77f:156d:f5a0
 with SMTP id d2e1a72fcca58-77f53ae6296mr1566302b3a.31.1758601134060; Mon, 22
 Sep 2025 21:18:54 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:22 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-4-irogers@google.com>
Subject: [PATCH v5 03/25] perf perf_api_probe: Avoid scanning all PMUs, try
 software PMU first
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Scan the software PMU first rather than last as it is the least likely
to fail the probe. Specifying the software PMU by name was enabled by
commit 9957d8c801fe ("perf jevents: Add common software event
json"). For hardware events, add core PMU names when getting events to
probe so that not all PMUs are scanned. For example, when legacy
events support wildcards and for the event "cycles:u" on x86, we want
to only scan the "cpu" PMU and not all uncore PMUs for the event too.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_api_probe.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1de3b69cdf4a..6ecf38314f01 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -59,10 +59,10 @@ static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const cha
 
 static bool perf_probe_api(setup_probe_fn_t fn)
 {
-	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
+	struct perf_pmu *pmu;
 	struct perf_cpu_map *cpus;
 	struct perf_cpu cpu;
-	int ret, i = 0;
+	int ret = 0;
 
 	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
@@ -70,12 +70,23 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
-	do {
-		ret = perf_do_probe_api(fn, cpu, try[i++]);
-		if (!ret)
-			return true;
-	} while (ret == -EAGAIN && try[i]);
-
+	ret = perf_do_probe_api(fn, cpu, "software/cpu-clock/u");
+	if (!ret)
+		return true;
+
+	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	if (pmu) {
+		const char *try[] = {"cycles", "instructions", NULL};
+		char buf[256];
+		int i = 0;
+
+		while (ret == -EAGAIN && try[i]) {
+			snprintf(buf, sizeof(buf), "%s/%s/u", pmu->name, try[i++]);
+			ret = perf_do_probe_api(fn, cpu, buf);
+			if (!ret)
+				return true;
+		}
+	}
 	return false;
 }
 
-- 
2.51.0.534.gc79095c0ca-goog

