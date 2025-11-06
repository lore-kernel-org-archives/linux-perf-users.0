Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235A35B134
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470975; cv=none; b=WO9JvF2JruwAM2J2AuQ1fnbOGbRqXsVeXcMll9qW7nuZgcY9HifynFYF0jrrrz3NgLSSHsXVX4zHA0SSsV98zQY9i60j/3lRF7ennR5k8nqnKRFZDo190MD/xZEPHFRk0QXM/wvj2dWBiA89ZuDC9zHhQ6JTt5Eph9ZoNzt8XyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470975; c=relaxed/simple;
	bh=sWmDIev9bpAFqHQEit38MtJHcI5r4PnZTO5Rq4PESvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V4Aeuoh3F7OZeLziMbzHKwYhburG3hNEb4fCdui4hTZkxAWm11LLKLDgnjtaXYyKae/TDdL1MR6RZEJioNOREPTXyGi70VNIlqWmC0Tl2X9y44pufTUEKp41sQCgRxidA7gmBglp/M1fIgB5oxhezGKQRdh1RFFVMbWGuUAw4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2ci66lE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2ci66lE"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ba795c4d4a2so110176a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470972; x=1763075772; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=D2ci66lE5nc0lGXVaHHf5foxMEWSar90Mj1MkBNZKKbUWirP+ujQsdEXq0FPvy7257
         +2ImzMEvwIX4WmjM0psZuDeL6tvABEjRGCrvogSXSXg0HUZfKlsxeIP5CVoKKh7jLMej
         zP+9i965PrpoiLUztK1/5Yui+xiLS7nnrWOTsRHBK1f4a44iQRrWxL6hCi61eleJcVr2
         jA44uVOQEqNjs5YdH03GDfhlAuhkkiU+vmq7V349CNHbApR6Mm+7nNRGhnQi5w8qExXh
         wXWxPkGNiyQbYCpmQnF2EY+ljetsb28qn/gyOspe9bwSTCR7sNzdyRL4/Ev4+emliuIX
         frQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470972; x=1763075772;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=PEQmk63376Ca1aAzgnRSDQyvAlIQBngZSozp9r4DeFV6HAC/sEneZ/6yoqCHcTrvAx
         ySLzwYWFlVQaZh1Qrj03+osiixCa6EXRO0l75Et/WFb5+jwFSpxPzvWhkuj7YPjC6D9G
         02yKBbpy0z8wIg2ydSpZYBhzDklRLbFFvuVJH8iBr7VaSg3CXtotbDdMwxdcUyTKd4cZ
         cQYvUCDV1s9Oj6z+4EX79nQRLcOusTbiBuWpbdpSYie0sWSvd+NuO1RHylTVznpY80ab
         uUolAb0/B21TNrMqvvLyGWo8gpe/kxfwm3X+Yuw/dg+di3B0sJxDsfCvuOD+KLq3NrMm
         CT8A==
X-Forwarded-Encrypted: i=1; AJvYcCXFIEb3oOQEda9W+ockk02LzRuyFcrV2ZwwfcqUNXymA6sOSpXSqehUaq/8Psk+PLzCdBdQHbZ4KIOL2NPc+4LR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz069CAyFqq/hVH+S8nuSd3Z61jOv4qitiMC7k96/CYUeL+mWBm
	vZYNHj4PaoElK37nntPlHsS3btBI1vjVs/do7xrxxaseBhk1pBd796vDS2LaOJLnx7bDpj8vUzL
	JFiIFrl8aWw==
X-Google-Smtp-Source: AGHT+IGBJoqUSUV5oY44MlCZl/Yj+DzzQV47ahJQCa0URDEki8/IhMDxl1V00M/JS6qtnjUKZxP5yWJpJHYa
X-Received: from dlii34.prod.google.com ([2002:a05:7022:41a2:b0:119:c6ec:cc42])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d481:b0:23f:fa79:15d0
 with SMTP id d9443c01a7336-297c04545b0mr16134955ad.46.1762470971950; Thu, 06
 Nov 2025 15:16:11 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:07 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-18-irogers@google.com>
Subject: [PATCH v2 17/18] perf test stat csv: Update test expectations and events
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
2.51.2.1041.gc1ab5b90ca-goog

