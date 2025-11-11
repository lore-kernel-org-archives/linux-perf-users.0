Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229B368268
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896173; cv=none; b=QQfyN15VxRA0ef62S2GKGQXugZFCUbWLDQuv8QhSVTanCkVF3BOtbjTcjIU/XZUnBupIkbYv3BIl0FlK46lNyveLDCB2hBvubSFrvDApGmAdACdV7VsOJkxWsoqwSbTEahKoW6F7QfHYYWN0kjYqujZ0aYC231PfdjzWCcTcAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896173; c=relaxed/simple;
	bh=sWmDIev9bpAFqHQEit38MtJHcI5r4PnZTO5Rq4PESvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hmxhzbqrHWsj9Sh2qCZpPN/2dh9gYWYqQPisvxxWA0cFU9rnjogN1PcBA/bLUI9XKKFXUJbFrWhWb2ky04QYIHZC12q+i7fXa/ZWhedXBoheibq70egH2C2YhjiM1Xfu+MK7qtlow4ZobK/AjcK5xrnwdxJ/9PLFL6F8xopdEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yl0sNGpF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yl0sNGpF"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso305513a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896170; x=1763500970; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=Yl0sNGpFWcZfAn6hsHOA4+RKIEq8KLLgJFB7K+0MqwVk6hnyCoru6G5f+NKPAStHS/
         3Rk/2ewm99lY0jbFai7eaE3m9C5P5zjdk0y0PyIyXpD4UEX58XS+2Yc7VXf/shMHZMmW
         i/LLR+BtZ5mU9OGqB2GsV3dhteHmscTseiAf10TDpVXL+DfMmF3W6XS+MEGkpf5m114Q
         VCvmOIadXrCJwOO5WXtJvuGaSpSSrBEc+3X1pT7RRBGGDDS6Irzq7f+ji5kxa4KpxhDj
         eVrfDgAHWv+9LoU2Hd6h+HMAtoL83T4k70WiRcGDS78lcu/YfPLcClMiCs/hc2r3Qn0y
         /l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896170; x=1763500970;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=JCxG5qfvjg156GiPC76WxyI3rXC55Z0UhhzGUkfD29lWSxumSVRgA7im3ZLXh5NHfO
         W/1Y0JGWM7Q50yvN6wJtiPPKUk3kIRlUwvQl/VephzfxCWBtx0N8gAHbD/ps7bXJQmsk
         WDkB2BWDABQj6RPMIfDt/NiXAx0F5xHjLyMPYFrr6NHucHXy/PXYfsuU3+L85uIQ/G75
         6ZbyxtQNF+vOgBj4GaeyG+DwV0rieKs8Iqw2tgG+VxsnExbj2UqvITYndY4KsTLyIGmp
         Hn3rtvQLmjf/9tu2TnNCA647jQDyvOmsTBfoUQILnhf2TnfuFVfbwOMiu3iIz4meK5Sz
         NZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB1NbUm1I8i44tGCNnZWtvPvb1gbYqqayvn5HZOK5EroflZWG77quM5M6yza3tTwivoFNb0QKesPwbyllLqwh1@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeVkqOHfgowFxgay4tQuG0lDejgWkrdVVqVK7FyyaR303MZeK
	Ot7kq1GZsFxT4NOSoW/7Mbw0w56cIwrGPEAXCrfAeRiHjj4BUnbptNpn/xdj0vVnVjggo7zb5BK
	eLuk3U075JQ==
X-Google-Smtp-Source: AGHT+IGa1PP5X8ELy/S04L/tdAuInta41DDPrTLa3E5LR9MCE5O7NiyATGZSAleEAa6z/AFamcPHwu6JFIoG
X-Received: from dlbrp11.prod.google.com ([2002:a05:7022:160b:b0:119:78ff:fe11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0f:b0:297:c0f0:42a1
 with SMTP id d9443c01a7336-2984edca7c2mr7947525ad.44.1762896170041; Tue, 11
 Nov 2025 13:22:50 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:05 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-18-irogers@google.com>
Subject: [PATCH v4 17/18] perf test stat csv: Update test expectations and events
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

