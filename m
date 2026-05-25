Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216635F16F
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751160; cv=none; b=I/F43GAYIBqzXVmiz6M6Rv0iMSteKYhhlYVR+fljm/IBXZMce4OSzxTgCqrc9SnY7w0Uw+ZKc56DrnppD12qi/8benf5v5jwcOXcP2ND1ZuEhIMO6Yr/jzMGMLvEI5R+sWFvyalW0N/JFyNZRmkfQGCD4dKv1Pprvd6HCc9EPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751160; c=relaxed/simple;
	bh=ExpM3z+KmSlM1Oxntu5RoLA8nq07uwVp4YjIR7ZUaP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CuvEn6Mrib0XaB10xvX1IsQgfc5TEZ6PbMZCfCb1aZSYe+Ul2v9FMPlOjFdxYfrj7DNJNsFxSUs3krEfUKDPO0cVYwJpXYeH4PfqUdoi/a7ljv5LYVk3FWtT352sZ6Hx9NZZ+8Bq0BUoFytd6fVlaKvEE8gqq25VoELpKSbENOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tchM55Jj; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tchM55Jj"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ef37c3f773so10070154eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751158; x=1780355958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JwB/penh1h7iB3PCt1rj+s/LDOfq1j86b86CSw3tD20=;
        b=tchM55JjDXx8oRxD203XWeVG86YDW4orhjS4aCH99w4tl1CJW/ZiCwJLq53AJsF2rv
         gtm/i727EzTkYRyt+nnf84Fu0eCz+DP1SGkhEQtpL9i94vqNpYLr2cROTAD46VSGM9RU
         rjxdmusbKVi2AUXeb8Y05rQp4StFSK6zOJQ8d7G1/CcA/Y/jcYKi5fouuZOaYIrDHD1I
         dmEwMgXrUw6hl7D4ce+/F6Y2AR+U87veJ0kdnqo8QfB8pGVUX2rau5J0EKA0Y7CZlRzb
         CSg+cn356TEnmzjnHAZVwKufADppSk9nAtnMKeSEbKuBCQXsDtyROmnn09ZgtxBNVIwT
         zSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751158; x=1780355958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwB/penh1h7iB3PCt1rj+s/LDOfq1j86b86CSw3tD20=;
        b=lGanpWPhPhQTO8sO2qbDjutYXylc8W96pYOhAIsOOEZr6psSyWX0v69Va2UdGttS6V
         V8dCBOwvSKDw23LorA0KaOgD2bah9FctQK9fgApGL9SQ2Jap6diCc27SN8GjCPtNImoe
         p+zWOC5hWBkoylhn+W67In2hxRkBpIW60N+2fVqV67cMLir9BDjcvYKxmOMsVH1r1XxI
         2nrLiuejQ9EjDcNn1A8u2Q5foHTwgdyuiA/1UIpHV4txRT0mquCfkB4ivrocVoPjGsRF
         dpmoGATlqMYjDs9rKG5RotogS5gLzKLFeTX21j9llGVkLNOLivvRE37OLlY3kTE5j0Bn
         id+w==
X-Forwarded-Encrypted: i=1; AFNElJ/uDnIhnE2nTpgY6yhUzmS0D5K6Z+1OoyNEvfCQo3vlT7f1uDL/NdEjACVCYNaOBxaY3zCPa42cZNXDnkOOSLzg@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6PyhdB6rna9aPPsJ2ipPQ2+ZHrQwNhoeQrsfLJHZp8FkFg9o
	akPzmGA4dDLhnMZ6xLyPzdsW0oU7hb0+sDw640oLSGQ24H/IuxsrKRkRl1hIOCI0nBZdOFEZPX2
	x6Z7MkjYQKA==
X-Received: from dlboy5.prod.google.com ([2002:a05:7022:1285:b0:132:f653:503c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ba3:b0:135:a6a:f7e8
 with SMTP id a92af1059eb24-1365fc65494mr5170412c88.36.1779751157932; Mon, 25
 May 2026 16:19:17 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:50 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-5-irogers@google.com>
Subject: [RFC PATCH v2 04/14] perf stat: Extend STD output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run all
standard CPU and thread aggregation checks under the --new print flag:

  - check_system_wide
  - check_system_wide_no_aggr
  - check_interval
  - check_per_thread
  - check_per_node
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that standard console outputs produced by the decoupled
printing engine are verified across all core CPU-aggregation modes.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/tests/shell/stat+std_output.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 233e0a50eb33..8dee005a7281 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -121,6 +121,17 @@ fi
 # New API basic checks
 perf_cmd="--new -o ${stat_output}"
 check_no_args "STD (New API)" "$perf_cmd"
+check_system_wide "STD (New API)" "$perf_cmd"
+check_interval "STD (New API)" "$perf_cmd"
+check_per_thread "STD (New API)" "$perf_cmd"
+check_per_node "STD (New API)" "$perf_cmd"
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr "STD (New API)" "$perf_cmd"
+	check_per_core "STD (New API)" "$perf_cmd"
+	check_per_die "STD (New API)" "$perf_cmd"
+	check_per_socket "STD (New API)" "$perf_cmd"
+fi
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

