Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988528;
	b=zH6lDRVZcpSPK2rUAwQThcTmHS7nTWqFJFSFrTZNIzVOcgCVDVG8rkGOQArcsQfJtlDe
	 66jmld0GfxLO09zjG3fbPktvwbpKtGGvaxxcis1C2+dlETrE6Est5UB1cNas59vuQb96x
	 j0hKcAjWELjqsUw2eDOmEv1kJGwkvgvLb9mU6YNOvOeoFrUpSY6JhiFbPCzQ5NLsIohx6
	 fLchniaNaub+3T2VC9BGrUx4xjHgieI4PIXuRbqDpqLN52uef/uj2eb85PbfJ14MnA8Hm
	 QNc31xxVRjTIy6FOJoBUFMXxQBAea3ZKhtoO0JJO3/MIzHaCQVzinDyWvqANseroTVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZOqOW53r1xMJrMe5oJFMrv6wgbQkRbuC6VFPZwStICs=;
	b=GlRsRf6g+X/PgFrv7uc6ZYjuNA+bYJjRHwtrc4CXD3+3v32mjaPce8obVo9c1uvAMJfv
	 Q/+/0KYsis5qqWWIpEwgqsRmJg7wQtIPEhXivKN6paWQbgxz8Ed9B3kqzK7TOAPW8aXX0
	 vkxC3XF5V/Ly3GswwpM2kIBg07jCsBNh+ikZIv/tiLVIU0SFOnQ1SHRr9bOBMfXq0iG7n
	 4WXNMc+j7xwRlpEyYIeKTZEvlQlcS4/uDXwLZWgDII+Z8JcV2qb/a6t4u8SF+gRDbvYL5
	 6qgrCpNKhUIp9n10TajT3HSvIbPQ3W2SbrvolMhV2O0bFvFEaKrVEx8xMj751y80CUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G8+jmleB;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DA606A884
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 07:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC0DA606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G8+jmleB
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36fa5673fccso2140005eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 23:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794988527; x=1795593327; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZOqOW53r1xMJrMe5oJFMrv6wgbQkRbuC6VFPZwStICs=;
        b=G8+jmleBsZ3wv7TAOWc4vi6RuQt29LXTEi3Zgq9CTn1dBE+DEwSnEfMHE9ubUah+6K
         uJkHPBLpdPcDtOHPwwiDaztYZFJWF/hgnRJxms5qliOkaxhvjFy0qZwll5C1Jge89TEx
         pd9+Q3V68rcCgwkmyE2f45KnAyU+gPYC8IBBAOfZs0KgzNpwfsrNmscapwkfAFT4Euz7
         Dx40ZUoXZD4Tq+cV/BTmfTkSra8i1HiL7cNKGAvq6V1Svbj+LofuDeDt+ZKur7VEsNRM
         gqzU1BLUzwYmCHAOep6btAl0jLLmimKVYRfKR0Ap1gQT0K5//7RtzhlycJ3+Stv4vusF
         hDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794988527; x=1795593327;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOqOW53r1xMJrMe5oJFMrv6wgbQkRbuC6VFPZwStICs=;
        b=pY5jM/CCm07fOgwqqQVTLaN//Q0KnnXdqtViIcThnGjyUIMYbQr4EOA3qg+B9Flhef
         9Jzs2vWNjhDOmTtYsyixI+JCaErJSE9+LsW8y/0TKSrn9uN+KUkgYzuuZ4JCg6DbV7Co
         aD50KoPgpCk+sD4PwdniNrIkaw2rImg79ekIvbxA3PGqfhFHrQypri+LM8tR2+Ar3giq
         ok88xN92U0OITUX9fzSn6mm9jJmDLn9B/iqIhy7XZibz1G2AtunLsGKj+I2cgDo1HMfw
         qzMlnqO0VdO2LNFroQ+Uq0O5ebiNL1iEGlHQxpVSOdkwpplyDLZQ1G4QZ15dRLs3hXRu
         uwZw==
X-Forwarded-Encrypted: i=1; AL+hErEYNxIAdrS/geb8qyhNTouikNQ749HAz0CP4HpCmXKKyWWWH0q7WqAwbCEkrxxchA5v1SjmEryKmzkoAW8nwUke@vger.kernel.org
X-Gm-Message-State: APuU4Z83hwGTsOX5qrsV33Lbkh1P9yh6Pg4OOW90W9vwKS4/r1UZj5RM
	F01+awZNPUqCP4AE0z64rkgneANSiKW/Em4MDa5i+WiJ3Da+s+o4/VcxZEsbEL2pDE9sxuKsNsM
	h/DFbZ9BWhg==
X-Received: from dycpr12.prod.google.com ([2002:a05:7301:fd8c:b0:370:71c0:f285])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4304:b0:36e:1fbe:3571
 with SMTP id 5a478bee46e88-3827dd04088mr1751455eec.3.1794988526706; Tue, 17
 Nov 2026 23:55:26 -0800 (PST)
Date: Tue, 17 Nov 2026 23:55:14 -0800
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
Message-ID: <20261118075516.1278903-4-irogers@google.com>
Subject: [PATCH v1 3/4] perf metricgroup: Fix realloc() leaks in
 resolve_metric() and __add_metric()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In resolve_metric(), growing the pending array assigns the result of
realloc() directly back to pending; if realloc() fails after earlier
iterations succeeded, the existing pending allocation is overwritten
with NULL and leaked.

Similarly, in __add_metric(), assigning realloc() directly to
root_metric->metric_refs overwrites the existing pointer with NULL on
failure, preventing metric__free(root_metric) in the root caller from
freeing the prior metric_refs array.

Use temporary pointers for both realloc() calls, freeing pending before
returning -ENOMEM in resolve_metric() and preserving
root_metric->metric_refs for metric__free() in __add_metric().

Fixes: 80be6434c36f ("perf metric: Modify resolution and recursion check")
Fixes: 46bdc0bf8d21 ("perf metric: Simplify metric_refs calculation")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 779fe56..489f13b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -771,10 +771,15 @@ static int resolve_metric(struct list_head *metric_list,
 		if (pmu_metrics_table__find_metric(table, pmu, cur->pkey,
 						   metricgroup__find_metric_callback,
 						   &pm) != PMU_METRICS__NOT_FOUND) {
-			pending = realloc(pending,
-					(pending_cnt + 1) * sizeof(struct to_resolve));
-			if (!pending)
+			struct to_resolve *new_pending;
+
+			new_pending = realloc(pending,
+					      (pending_cnt + 1) * sizeof(struct to_resolve));
+			if (!new_pending) {
+				free(pending);
 				return -ENOMEM;
+			}
+			pending = new_pending;
 
 			memcpy(&pending[pending_cnt].pm, &pm, sizeof(pm));
 			pending[pending_cnt].key = cur->pkey;
@@ -863,6 +868,7 @@ static int __add_metric(struct list_head *metric_list,
 			return -ENOMEM;
 
 	} else {
+		struct metric_ref *new_refs;
 		int cnt = 0;
 
 		/*
@@ -879,10 +885,11 @@ static int __add_metric(struct list_head *metric_list,
 		}
 
 		/* Create reference. Need space for the entry and the terminator. */
-		root_metric->metric_refs = realloc(root_metric->metric_refs,
-						(cnt + 2) * sizeof(struct metric_ref));
-		if (!root_metric->metric_refs)
+		new_refs = realloc(root_metric->metric_refs,
+				   (cnt + 2) * sizeof(struct metric_ref));
+		if (!new_refs)
 			return -ENOMEM;
+		root_metric->metric_refs = new_refs;
 
 		/*
 		 * Intentionally passing just const char pointers,
-- 
2.56.1.703.gf848ed807c-goog

