Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095135A143
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470969; cv=none; b=plQ/Aa3D8pWFpbg8a1B8OiXqJG8wprV+kQepkBLd+qpG8yVPF7c8uK/kEYi31waM9/eUSDT/kKGFhZ6fqsjRbik9uwHmSWo7LsOFem9XVDZLmOss+fOz9gmhbt7SLwyVs22LppEqlabRH5ibRVZDGhgfGQHjanh/CrfO430QLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470969; c=relaxed/simple;
	bh=NQZLwrJVuAq7AnAGYojD2+FNeBDfMGlmTWdY5sb/Yxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UftQxF29IWxCpFELDsomXrdb6OAyd+w/6p1NfgwTHUzlKAwEyaFEmQUYeyfImIoZzUXGa2Ghb4qUJUc8I3g2hp12APlkzTB5jcMCaJetKa0WdMcPeTYOJKlEc+JYZ/Uk9MgfQS+8TAsT/dVlNfv/BFZ1QAmh5crEo2k/UYM/664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWFOQQUe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWFOQQUe"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-272b7bdf41fso3065085ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470967; x=1763075767; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=NWFOQQUe8v8/GpDgi/IMW4HZTWq3cryI1Af1I0SHMizuR/ijzlyxSuF768DZnJUQqO
         cvYhwbBoVufnjvwDR2CUP36PWn9FvGL8cLgmnav78K6VJwjCjlZEHVYfBmiEMUGD1Xni
         bT3SJnEDebyWA3nxJDn10CvxMm8aS4Y4wA2jJ8yTU3P16kUBAi2+pvN4sG37W3z6nsJM
         r+uPlKSx9cUUMVL3wvbMtDt3qFxXpkzLpBE53rOZFrqfvQWseTOndBb1vC+4B3ofGRF2
         ZL/2456Lh/nnqg8eNs8Eze1P0F1RIbYO56BAEQm4SN6m6HcLFkHbdhhCLypBGaKLJ/sm
         TeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470967; x=1763075767;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Snl9m+Gsuclyili9Jia8BWYLwnDqexlNgmsV+/z8jHs=;
        b=s4M0IOzHyDMP20S42PVo26T8RFbuVocfjFc1ML7jFQnROMtRIwS9+WPg+ui3rHQUTr
         LJcdj/tdKQhyBwamyYeMendRXJgUk486OERiZZc7uDWAIGZ95iZw7/s44dHN5wWud+xH
         6tEjhp48rvLcdjNDbIY5h8MnOKvecyZlhIYPrPu1q0BqxRQzj5Be1UlQVIUoiUkaea1L
         Pk2YOdoVnbXp8BETb6q/9hATqB+kkF2GCE7eNC27nvP4GTkk1Yihee/sGmImxtliyFB9
         XdJlqiS1LvLmpvbnVIEO5fUcolSf4ChvjSB0vX0BgbAiDdPWW3yWJn+PEkRRNPFc2m3R
         bu3g==
X-Forwarded-Encrypted: i=1; AJvYcCUTzYkAjq6EGwlXCXM4sFZ83udJVl3mMLrtxKmMfyC471Sc7PYtmWa2rFYIZEuhyD9yz61ZioAiz6z7UsaNOuYn@vger.kernel.org
X-Gm-Message-State: AOJu0YxckOwshwbTgtdfTsl86awvsVcicddKNhxwHuR6atca/LqRxPS5
	8rfVWpWsqngj4NiIXrnkptLMGVp3PTMFkjvUz4NznTULj1kN166Z2+e95DOnTd/kI48JYWjtn5x
	1oogQNzsvDg==
X-Google-Smtp-Source: AGHT+IFc3t+pl+dtq2Ew3dKGXbYWje+bXWKgsuDNMN96A/1Pua+fxj/lreuHJRndBsoMYTI4pD+iANneYzz2
X-Received: from dlbps9.prod.google.com ([2002:a05:7023:889:b0:119:49ca:6bac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac4:b0:262:2ae8:2517
 with SMTP id d9443c01a7336-297c03936f3mr16182735ad.5.1762470967518; Thu, 06
 Nov 2025 15:16:07 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:05 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-16-irogers@google.com>
Subject: [PATCH v2 15/18] perf test stat: Update shadow test to use metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Previously '-e cycles,instructions' would implicitly create an IPC
metric. This now has to be explicit with '-M insn_per_cycle'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+shadow_stat.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 8824f445d343..cabbbf17c662 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -14,7 +14,7 @@ perf stat -a -e cycles sleep 1 2>&1 | grep -e cpu_core && exit 2
 
 test_global_aggr()
 {
-	perf stat -a --no-big-num -e cycles,instructions sleep 1  2>&1 | \
+	perf stat -a --no-big-num -M insn_per_cycle sleep 1  2>&1 | \
 	grep -e cycles -e instructions | \
 	while read num evt _ ipc rest
 	do
@@ -53,7 +53,7 @@ test_global_aggr()
 
 test_no_aggr()
 {
-	perf stat -a -A --no-big-num -e cycles,instructions sleep 1  2>&1 | \
+	perf stat -a -A --no-big-num -M insn_per_cycle sleep 1  2>&1 | \
 	grep ^CPU | \
 	while read cpu num evt _ ipc rest
 	do
-- 
2.51.2.1041.gc1ab5b90ca-goog

