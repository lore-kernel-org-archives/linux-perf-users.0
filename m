Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988530;
	b=rGw2VhIPLFHGCDtrvk2pWMy5kHnOEEISAWsZYxYJeJrZzCxvBs45e94+qwQP6W/YeO3y
	 R8Y70PRtW+tfC5j1YzNkom3n4+6utl6dsa0/XuT4T3g1zSYsQvNq5lgpmihMa7GhJgUX5
	 QcEHfdXE2HG2CHTWtqlFKhcObyBw1GMJKmYgR/U6FTufdMiGKPkI1xmWmwMfCZmpcAO5S
	 rWA9vcLU61fUTGvJQdM0cLWdZS/M5GAx05OB1TExwSbOG/gANYULeqA9iAEcAbHE9mqwQ
	 Y6+kjY9P4DbCkVEfgsrRS9PkuWjuaYbJG2yTOlUkRSw+yqIhqwTjOWNnOhvH4xxmMAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JwQhcIOGcjOxphKeILS+5+EKK4GNKccVQCIJqtLQ9r8=;
	b=xvd1MS5txPUDkUMLhuh3AIDE7ZiVrycIMB/yth6dvMyGSd3cKbDznl/m9edqGp4Blg1j
	 cAw2oCMHpYw6VD4HJV69H9ySYzaqcBRSdoro/Co+G5iFJWluUpR5hJpmEVkIlOJsL32G/
	 Hb+PLY+t0SNIcDHsKHKCv/HIp0/Sj87UbzZgy0lYyVtWgYXl/e7ORVn+VNyXGHWFutoCP
	 F7DPeqgG2LH2msBXNjAB0HxSpTf5aWe/8U1ce+Zzmmvo59ATkk2CJKwDR0X8TGQu839bl
	 xt9X+4GviHSMYiAWJIVYvemOK90uL+ubBmj+KnIVW70zy4m/JlLcWtRrVzF3FsKinyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XyJkOTqh;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F540606A881
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 07:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F540606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XyJkOTqh
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3a348a6dbso1502309c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 23:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794988529; x=1795593329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JwQhcIOGcjOxphKeILS+5+EKK4GNKccVQCIJqtLQ9r8=;
        b=XyJkOTqh27uUQlBwbxDrFYFzQs2zYRPweIigoEuAf2m0EgFcEBLjBvSlpEGObO36iG
         4xw7/ZnoaVkVdJGZ9WCuahZPq/mO6lrixZ9PAXcARjsFLnhHm9K3FDoISWsh2Wh5eUsB
         bH2AMeaXam0a9RFy2ik0CcUun/zY3LequVMIukrYKEjI04S58a8k8OZDteLzl44HhnDb
         AAmU59FVBfW1ur278HvBlno04C4jFD3Im0GmRa10525gB1uWhCX2g9ygAPZkeXFYdM5o
         m7mmo6j2lXE40kqm6sBNWXEIQj9Ji7ldph2vwDVFOoWxKUZDuBOwpEFnOdGRZPxQshGF
         +yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794988529; x=1795593329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwQhcIOGcjOxphKeILS+5+EKK4GNKccVQCIJqtLQ9r8=;
        b=KuoNAVuay+GKZK9LrSyqL4Kz1DVfQ/p33ZlzPuhyryMfIjHegrNKfCQRx8drfqz0YQ
         pd0tSmeEA5pH9aUqNZmCmq7qgcU1atEGNS2usbl9V8tiJ0pZxsatv+J0VXndGMaZSmoS
         j7GAWuL18Fy4uHa+9IAY5I+29ev1F2czvXyvaKVGGOeHXY0+CPmbgyjHbs6tWXE1dUUE
         TGRJbnxviW8HFxldyJio6sCdK5ekoRwweFCF/e3/DhjD4d/TEz4dv4lWAwdfFH91Aw7R
         ArZ1vyv4HHrH1aHG2joPLjIFw8Cw9quAP+3nAlsuNkqgBUEQGAAaljf1c0YOj7HHrIqo
         xlPQ==
X-Forwarded-Encrypted: i=1; AL+hErGwS5VbsvS9QKabBrju9oywGyTFNSgZ4Yh8vZjyxR4omyxqwNDMnGGx3Cso37YJoZ9JSz/0ul02cpYSIy22rl6H@vger.kernel.org
X-Gm-Message-State: APuU4Z9HOvJGcVMfFU2uYmAAA76g4Mvt2MEHwW0P7czNZqGfq8UfQWfH
	iLoEg1uj0vHS0VCJO5CM3Q0C4ci75fg9mIeFxIm3EZrsQyVOwyBNAvPhKAi6Anhw125fB3AxZQl
	43QNEcVQSnw==
X-Received: from dlgw16-n2.prod.google.com ([2002:a05:701a:cc90:20b0:1b5:35b8:3a82])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2903:b0:1b5:39a3:75e5
 with SMTP id a92af1059eb24-1b543c33197mr1752962c88.33.1794988528819; Tue, 17
 Nov 2026 23:55:28 -0800 (PST)
Date: Tue, 17 Nov 2026 23:55:15 -0800
In-Reply-To: <20261118075516.1278903-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118075516.1278903-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118075516.1278903-5-irogers@google.com>
Subject: [PATCH v1 4/4] perf pmu: Free alias on error paths in perf_pmu__new_alias()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In perf_pmu__new_alias(), alias is allocated with zalloc(), but if
parse_double() fails on any of the retirement latency fields or
io__getline() fails when reading sysfs alias terms, the function returns
ret directly without freeing alias.

Call perf_pmu_free_alias(alias) on both error paths, matching the
existing perf_pmu__convert_scale() failure path.

Fixes: 84bae3af20d0 ("perf pmu: Don't eagerly parse event terms")
Fixes: fc807b6bde6a ("perf pmu-events: Add retirement latency to JSON events inside of perf")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1ae8bcf..adf85d0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -607,8 +607,10 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		ret = parse_double(pe->retirement_latency_max, NULL,
 				   &alias->retirement_latency_max);
 	}
-	if (ret)
+	if (ret) {
+		perf_pmu_free_alias(alias);
 		return ret;
+	}
 
 	if (val_fd < 0) {
 		alias->terms = strdup(val);
@@ -621,6 +623,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
 		if (ret) {
 			pr_err("Failed to read alias %s\n", name);
+			perf_pmu_free_alias(alias);
 			return ret;
 		}
 		if (line_len >= 1 && alias->terms[line_len - 1] == '\n')
-- 
2.56.1.703.gf848ed807c-goog

