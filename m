Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606558;
	b=m7m0avMmhyaIo2zfaKAfSFVbvbxWFkK/ZfshyEJCICVpMbe93z2CuV2/7+QP3sMdZWnl
	 WDVzZDaIlI4gJ4FuwIJ5DvR00NyY4x3UlZOC3rS4WNOCqDboWCMJEbnfsj+ZsrPQvo12P
	 ymJ0gJqZ0ShhXvvvYSCutNMzxqtnr7oII2q+wYzSnR9XdpSnwjHI2LsQxWwyTn1I/vV9R
	 RjoRieXKC/u+GVzsFaHZ30EKpSsx6UjEgJKxJfLqAgWfp6QKymeQ8LCLzzc2DxQ5OnkQE
	 Qeaoq0EiTxKb6CTpVHB70FieeTcmTbQ1xwC/1OWnbKl2La3ww7g0kxW/BAdxMUvd1Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZKLb1qEzYpahK26h3xDx9a51GP88hkzTLPyeAyDMP8U=;
	b=nzSc0QlwK/0w1n3FieFQUJd8iKSuxTVwmv9WLokUBnGLal3FuLFFEANq+pO/JacmhScN
	 knCD6veK33xJQmR8mxUiGZuLmZK3BD2+9JgjEBUL5DeOeRYaDkXQrhJLb5c9Xd+M3fwG1
	 JftEi7umkTI3/Ts2vd7prgclskv7W9erpsJ0MPpL+sdXxJ1GgfJrYbWG69tdvwavSpsCw
	 DFp6UPm94iU5od7LoRzLk9nfz3Qpj1H1JcIEfL4jEfotGDLbKw1eCtHIhw1fVfruD6sd7
	 9sHmrXNwE9JOR8sgBc++lcVbT6knVewSTIflTaBHLmnllQu5yBgNxugSH1P0l5x1w1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ajMngymd;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841A606A335
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0841A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ajMngymd
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-375bac6bd21so1058235eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606557; x=1795211357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZKLb1qEzYpahK26h3xDx9a51GP88hkzTLPyeAyDMP8U=;
        b=ajMngymd0xeiTDMc+5FjOWouV4K/hXo20PZUf0GBjlR3tZfs62jhbmkvJYOIC7immD
         pl0os11mXb73WtsfXc1sb9aIFFNNFtwFhPASHpS01SB/jZ8kQxT36OhT6RU/NvzJmiiM
         l0JXFgUTEzDnGAI5B5QW06nK9PrWx/Tq1TGxSjHB7J+tmYMHt2CMyRBTXsLZg88SCaRu
         Rmt4LIygTJBkQF7lVYWdqARlK2TdtWGwZ1C12iyWNJpl8bh45KhueuwXP0SK6xDSTVGD
         WNOkiIlTuJomcW/K3dH8X3DfIw31SYPGt5xYORmy18ZLZBY7DETn9CepEcYPZmc7eXB/
         xblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606557; x=1795211357;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZKLb1qEzYpahK26h3xDx9a51GP88hkzTLPyeAyDMP8U=;
        b=gTw7n+IH14rmU+JDfkjSALCPTolkLlqFhr+aTskR98vVgc7DGjhiYsuzO3KAehrchB
         FOUHN+FrvjSSf3F8T/f+s74x+l3YSoVzO7JJ3qHJsqFZTwj9EPcyHzzgMRGawJcgTzek
         8N1/2oP0zMZyADrjBpNq0D1A3i5vajqnZEGHTRGDu5RjXkbO/ZghXbqh8/cjsdMYmNgr
         DJaB13/RVxw8ngCgXZIC6gpahcR37wSt6o20nVOzTDjjBRcltNMd+F3mf6UmQh5yppdR
         hGrukokbdxhXxL4IntLRbV+bIysEbU8yR7wfl3OmL9QYSL4J+JKQC8nVkMJ4H8/ftPUU
         6IAg==
X-Forwarded-Encrypted: i=1; AL+hErHrEncqaiQVqNpCBZID/6VnbF7oc96TnClsqKey/YtGAiJJogkwJwP10AoXuWTFOD7vHYbUiULz/b+juf5ABU6r@vger.kernel.org
X-Gm-Message-State: APuU4Z8JnRZZ9ZLKxqGKBeGPv0HV/Kvtx7/a9LrKA/dQwu/smqcTLljj
	Yr5fifsKiO7wTTpKuOpNaTmyG7Tdh3fyXbTg9pzFn5PUHuB1hVHM6Rkzm5dk2/UTg3+DajFyXO2
	TxMShR0H9Xg==
X-Received: from dyaw18-n1.prod.google.com ([2002:a05:693c:4152:10b0:373:6c70:7c9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:430b:b0:36c:dd3b:a3e4
 with SMTP id 5a478bee46e88-379658c791fmr2991727eec.3.1794606556845; Fri, 13
 Nov 2026 13:49:16 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:26 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-3-irogers@google.com>
Subject: [PATCH v1 02/26] perf annotate: Fix sym_hist_entry memory leak when
 zeroing histograms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

annotated_source__samples maps keys to heap-allocated struct
sym_hist_entry pointers, which annotated_source__delete() frees before
destroying the hashmap. However, symbol__annotate_zero_histograms()
called hashmap__clear(notes->src->samples) directly without freeing the
stored sym_hist_entry values, leaking every entry whenever histograms
are zeroed.

Iterate over notes->src->samples and free each entry before calling
hashmap__clear().

Fixes: d3e7cad6f36d ("perf annotate: Add a hashmap for symbol histogram")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 86a4beec6528..9af1d6b72da9 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -164,7 +164,14 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * sizeof(*notes->src->histograms));
-		hashmap__clear(notes->src->samples);
+		if (notes->src->samples) {
+			struct hashmap_entry *cur;
+			size_t bkt;
+
+			hashmap__for_each_entry(notes->src->samples, cur, bkt)
+				zfree(&cur->pvalue);
+			hashmap__clear(notes->src->samples);
+		}
 	}
 	if (notes->branch && notes->branch->cycles_hist) {
 		memset(notes->branch->cycles_hist, 0,
-- 
2.56.1.703.gf848ed807c-goog

