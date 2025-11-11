Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652734B68F
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833894; cv=none; b=ge54BfBdbp2Ogr10dQ/2EBPt3f5A8fbzdbkGaGSzaUfQMDFKPFhJ2AH940WuLgG57IO1F3lJNEAVTW+I1un7JVT8IZ1ZE8dHIXIT9P6z89PBlGHhqoMLYRcvBK7oO6J2wHm1v6LBflsliCEYJ0yV3jrrH1fmvxTxaBVABTWg5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833894; c=relaxed/simple;
	bh=bWlWZmoSbjMlQJvhT1Kc+8bbCD51npTRBtHHE+YWJoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qIMCvRpjuxbYy7z4V/bD8yzYRAJ8TKhBR0BL4OVk5/DRGBcwf3U/5e3IWRvEriJTY/Bfe44KuyLuRrNzEuquEJrm5EuhmcYdaWw+MPH5xHbvf3VcLdQQ88hd3Y2egRZjTlLxWFBhuikx2DvsWO5T2HYSX53GJVVGUhAM1rpuXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aelZsAfp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aelZsAfp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297df52c960so74287875ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833892; x=1763438692; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=aelZsAfpOM3JxfqCQ/zPPvgLAjX2plnqRxNhPoYwHz2KsxCR3s5f2uu2afV3X7n7yi
         ee5vaZwb4zBKcLTeaBDHqjU1zTBxa3WFdGISgPuY/VsHyV5TzcXCdENKdpzM/njbtbqF
         RD5GvkdvF8otfYAB+Dhv+iI0YhnkJoUwkd/BiE/4z0LrUYr1I0pcwArcnALBnOm7Tv78
         6G2ezJpd6xo3wYaKSgJun16QASLJna6MV/wcW7NBra0Iw6LEPnRzde0kguiiS2dj0FyF
         2suU7KwwvnMG+SDyqBX81dJTMn1/FZzn2fBVoY1FnlsCiazqGXj1yBh7eEn83AqRq/xx
         OK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833892; x=1763438692;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ja604hKaX8qDrZr8dkd1ADzyH8Os+oHlUQ1fcptNWsg=;
        b=hibtRqwlwh1ADgKfngJZP4uWc8zi8ik9X0ub9kblEGqycUd6sIngtujJU5ZHoyYO/s
         DpkjiqEu366cW8UfW+bTwvk2jS0yFaMxBaIH3nUyp80ZZXYEk07W+0z6Pr7jqZGmePju
         ZclpxR1MZ96MTbLprMgqXqXtI+vE/SuWGUYaVJQU6yNoLS38Myd/+tSe7PapqcSz9Ile
         D+rp7+SI42yHjYYddeGVPJQJyThmZZsk+eeOsk8GdmjV10Y4aMi0CUhu9nZAYGHUCjhf
         0sO8qRIk9CsGTBl6WDnUbLJdewc4HI6mSHYtsVmFzth2BWC59KHorhwaIrT8clSWb9Gw
         B9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvGJHu8DNvRigHmZSV+LVGDOBT/lAALC+s2735zJLhRZ4MbvT4KrextGccVmmeMFwCGY0ZuRhFrLV6JZAzfjFo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Jm9RpSdm8xt0o79D+D9LG6Ycrs5bJ/YyhpDxTIoWAm/03mVy
	zDHW/EUkrn82QHEIbQNCr5J2Ch1nn8tVOddGTqoS6V1xm1hdmYtbVLNOT4bKt5Ad/Nlko5joz+6
	2wgWDqgZQjw==
X-Google-Smtp-Source: AGHT+IErWkHeqed2GrqiOy88wuRY0tqtNPYJOqc0LJ1kt+lmnAJczl2sta01fh79caMHsqjCpCPCmGcxFpwB
X-Received: from dybpf10.prod.google.com ([2002:a05:7301:410a:b0:2a4:6c32:42a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d485:b0:294:f310:5218
 with SMTP id d9443c01a7336-297e4be8af6mr152083305ad.0.1762833891972; Mon, 10
 Nov 2025 20:04:51 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:13 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-15-irogers@google.com>
Subject: [PATCH v3 14/18] perf test metrics: Update all metrics for possibly
 failing default metrics
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

Default metrics may use unsupported events and be ignored. These
metrics shouldn't cause metric testing to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 6fa585a1e34c..a7edf01b3943 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -25,8 +25,13 @@ for m in $(perf list --raw-dump metrics); do
     # No error result and metric shown.
     continue
   fi
-  if [[ "$result" =~ "Cannot resolve IDs for" ]]
+  if [[ "$result" =~ "Cannot resolve IDs for" || "$result" =~ "No supported events found" ]]
   then
+    if [[ "$m" == @(l1_prefetch_miss_rate|stalled_cycles_per_instruction) ]]
+    then
+      # Default metrics that may use unsupported events.
+      continue
+    fi
     echo "Metric contains missing events"
     echo $result
     err=1 # Fail
-- 
2.51.2.1041.gc1ab5b90ca-goog

