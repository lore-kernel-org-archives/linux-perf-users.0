Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA734EEFD
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328790; cv=none; b=WPw4NBkMnIUsQ+gfM3m/Zlg2fs1351+9wLtUIypmAohBph5uWrl3AtYZZ3sknNwdJFVUyZMt9GyYukxk6PW7RiuK61e77L5JoGds932rTpOAiZ0n4k51ViH6aedoKBK+sc/35k0UNABjCDPnBXw3HPoyqR5xnWFoG7BuHT99eSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328790; c=relaxed/simple;
	bh=yAXsZhxvHyHEQLXos94jIHAJ3UZbjk6e3qIEtM58ctc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=P9npUTefogzmAADbTj4/BMAJCMBo2w0AwqXz6KzplaHe1unvfipfve9rGpTvRQm4vohOTcn5TpNYohYTB+WQVoG3vyq3xyBLieky7C7jq5davqAU9sC2lbYD+6OOIm35d+yMEaqk1VPUrStvYDU8RZimv7DeDy3tFHJH9soVA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRMTlaKD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRMTlaKD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so4894818a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328788; x=1761933588; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+GqPNh/zh5jE+hbuHQPcYDyfHhHCRzurjNcqVZkY2gg=;
        b=YRMTlaKDCXaJjZWE/GVULI7UW6UzTbOREPsR+ErTuoVR8Ch1gLLVGD6yqM2stBcI7E
         sYAXjcxPLL58ZhhP+YjsLmQJS4GKHvpk1XQTg/qGU/8qI4EnwV+1lPaUGUbuZMQKJ8KU
         tSluW4dIsIiQs5pdT7SVpPczyfLMM9ovFL/051Rl4kthfiXKRn740b6myXGaTNdFkB+F
         0Zd1YBv5WWV2SVBYI0DqKYtydMWJeFWKeQsavTD3+chmo06FDlwmnZZG70a/Qj/5mfej
         QVcy3fiFDZbRZ9k336PclyqSNnKof1rG+lXM/t8SAkr3SsMx2YH/gT3HWb/zUFqNDNdC
         vJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328788; x=1761933588;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GqPNh/zh5jE+hbuHQPcYDyfHhHCRzurjNcqVZkY2gg=;
        b=L0kOBXIxu/5SVQj5bY1K2gXMZVe+jfYNrFBcToCkjYNNuaUPluPeQck/urv/S3Xjef
         JwgQAbSo4NEJ8VYD5v8juUZC164t6Q30JbLba3QgOlPK/y6FRDtrGbm8DzYfhJoCH5CK
         aiHwIC4Nuy+VYnXWc4uqS58r38qRiflQj5LoZicS/vye3WQ6vTVq/DRIuhZPPk3ZQpTp
         s77jwcb0p5I77hv6f+eeTaGzPJN2hbRfH67nYGBcVmcB062ocVkURflqjfvG82ggphEG
         cJKkugIKM+Xxo75ixuyJPLYe/2JiSrY8JkFj2x0C+mxM/t5UVRhCF3lTK4tmwnOXooEw
         Nsvg==
X-Forwarded-Encrypted: i=1; AJvYcCUl/JN0uFz7rnG63dFRg+Jl85OhJImrXsMxZPrQxyHZuTOg6CjAcWQEu47mGsmcJL6UCoJP8Nn18rk1tC3nQnLN@vger.kernel.org
X-Gm-Message-State: AOJu0YygcU1szBSiScCO5fO+f2Zh2DxXw6pZqwBlQUFRbA8IF49WOwy2
	gWNmYeGz1eQC2lO7iEytxm1Tm5ZpaLib7Tcz2xGU0/+xa2aCG6/AXLBRy3Yyd6/2YqkhP8Gx9cs
	mxJ8T/I/kjQ==
X-Google-Smtp-Source: AGHT+IGI97mAtuqdO6OgV7iYK43SUTMj0/LhdECvBdjMp+FRWjR96CthVK9UYiaa2g7HS9K9cguw9qEme2CU
X-Received: from pjbmd3.prod.google.com ([2002:a17:90b:23c3:b0:32b:35fb:187f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d60f:b0:329:ed5b:ecd5
 with SMTP id 98e67ed59e1d1-33bcf8eb21fmr38489811a91.19.1761328788381; Fri, 24
 Oct 2025 10:59:48 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:57 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-23-irogers@google.com>
Subject: [PATCH v1 22/22] perf test stat csv: Update test expectations and events
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
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Explicitly use a metric rather than implicitly expecting '-e
instructions,cycles' to produce a metric. Use a metric with software
events to make it more compatible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/stat_output.sh | 2 +-
 tools/perf/tests/shell/stat+csv_output.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index c2ec7881ec1d..3c36e80fe422 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -156,7 +156,7 @@ check_metric_only()
 		echo "[Skip] CPU-measurement counter facility not installed"
 		return
 	fi
-	perf stat --metric-only $2 -e instructions,cycles true
+	perf stat --metric-only $2 -M page_faults_per_second true
 	commachecker --metric-only
 	echo "[Success]"
 }
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 7a6f6e177402..cd6fff597091 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -44,7 +44,7 @@ function commachecker()
 	;; "--per-die")		exp=8
 	;; "--per-cluster")	exp=8
 	;; "--per-cache")	exp=8
-	;; "--metric-only")	exp=2
+	;; "--metric-only")	exp=1
 	esac
 
 	while read line
-- 
2.51.1.821.gb6fe4d2222-goog

