Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD22F281504
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763157955; cv=none; b=aXit1b8VVqLv1TFt+fVfD7H+aFYkK6LQVxvwZRpjz+OCCL9kqBPRqdS5GR6XDf8iq+uINZqztg9by88YNAsNP6UmoP0oh113MwbqZ9fuxtXJncZ9go92vfZwQSxI4GFsLxuspXVmX70/UACiCtdE23ag2ZP7sGmyL4xE5fdaEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763157955; c=relaxed/simple;
	bh=zhcX27muJyHTT20S3etQ+RMyEd69b4f/ujGQsQ3mCDs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=CP7VMsY5pNNjZ+xG58JoKah0xcIp/NXYnxkRBA5EsEYNf1EXxsHc6tQp/YDRnnR4aGUYw+NSKZ/qKpwIKPaDj6dG49MFry7d1rQAJT0FP45maJh5MZ/DzbkGNShCPQxj6fNQg7dGm5FFl8bciNTA7dWtmsqj9wTYAAVfiy7YkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JivCOCkg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JivCOCkg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso2436746a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763157953; x=1763762753; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TGg06q41zuHacVdpk8KUL56GJtMGarsroIk+uCwK5tY=;
        b=JivCOCkgVOkDsqiNpV3aY9v8fF2Wn6I4AtZJGTJSwu6buVsHgzT3Kp8bLYzkkuMSVW
         JBg3w1KfNEj1qaietPixEG3CBbmvkE54Q8pKDMKu3Z6BFjqmJ+xfOXcsg4ojrEr54hLX
         lvCsVDMIbPjPopni0pwi6VNMOaW3knJ3rNx95sbF3swnDsTH+82Vvv+XIrKgSt666sEI
         gwtET7AjCWelr2NRQeS6s49UJQosDuD7AjdT9KqJcaOhH3p0M8Bej6GL+CON9Ba1Gjjn
         a3noB0l3lm1g0tXNfdBqHc3h5mgcYAjhT0EDFD9dJtDo1FGo6kEvg59VeGd9fAAgpuAf
         jyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763157953; x=1763762753;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGg06q41zuHacVdpk8KUL56GJtMGarsroIk+uCwK5tY=;
        b=p9p31K29VtxB1u9w5yPMAGpfJtBunDNilusYQEnIOkStCTuLQH4aps/kJiOVu1DFwb
         2Vz4Jeh0ILDB5Yg5QErKw9fRkMTOTUTlnKo8XpYKJzZZe/8oRXfXRanLo2lusKislttt
         axbrEd9G0tEY3hKuQXGIqsGTHU15uT7DF1Ob566v1g20Cccu8l0ckUr6Mdrvv4a00ox2
         QHXf6278vKY0OhHHLYYp99tn0mWs6CdktmmTMI/3pRCsnByiQ2btI4ZHv07cuVbD5xli
         z7XCC5YkSauRU35FyzjIrTEIA2htZ23CAdGc/Jwhau7MPG5KiRASIsQ8eOqmKjq9AzQg
         fCtg==
X-Forwarded-Encrypted: i=1; AJvYcCX3vyDMoHTHXYGOC0glsjLuFjVkH/CiOAdBIcl0GlbWJh/yRZdW4qJcRtLQzY/VmKAh59xeMblIfUPeINUV0JDg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26mR9DbwcKFVy3VzgCRBwcP6rHW57Dylqv6sLwfWq6pdBm/gT
	y1VCh1bDXitOlZvSzyOOuAxvzGarM+xKvd2esmnxWUiW/w3V+QUTJAGtL5y5pYDNnx1/szXFYz9
	+Czl10FOCHQ==
X-Google-Smtp-Source: AGHT+IH2M4o3nxQCWuklkQY81RBghPiB0517MY8gvuoIctf+UDUGEnYMKsqb7YcK3dvU0og0n38oyEUU1eey
X-Received: from dybmf11.prod.google.com ([2002:a05:7301:90b:b0:2a2:2846:c507])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:73d0:b0:2a4:3593:ddd3
 with SMTP id 5a478bee46e88-2a4ab77d82cmr2387143eec.0.1763157952864; Fri, 14
 Nov 2025 14:05:52 -0800 (PST)
Date: Fri, 14 Nov 2025 14:05:45 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114220547.496562-1-irogers@google.com>
Subject: [PATCH v1 1/3] perf header: Switch "cpu" for find_core_pmu in caps
 feature writing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Writing currently fails on non-x86 and hybrid CPUs. Switch to the more
regular find_core_pmu that is normally used in this case. Tested on
hybrid alderlake system.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a2f808841b33..e69b271f8073 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1560,7 +1560,7 @@ static int __write_pmu_caps(struct feat_fd *ff, struct perf_pmu *pmu,
 static int write_cpu_pmu_caps(struct feat_fd *ff,
 			      struct evlist *evlist __maybe_unused)
 {
-	struct perf_pmu *cpu_pmu = perf_pmus__find("cpu");
+	struct perf_pmu *cpu_pmu = perf_pmus__find_core_pmu();
 	int ret;
 
 	if (!cpu_pmu)
-- 
2.52.0.rc1.455.g30608eb744-goog

