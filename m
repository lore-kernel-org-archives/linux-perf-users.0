Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606560;
	b=l0Xags5W+1PxBKwcOf0Ho0mpu2jTDZ1XqOf2DjP3tk63Mp95VMtlzOhWdg1koUUNyxNe
	 vJuqtorAzzBmW9oWidEE8Q0OkQHNoQUzJWA15cRkRx8i0BwIjHrHM+Lg5ibF1u/Ts/7Us
	 kDtDqCSeLSzdeo/0If/04pU0s2kP/4dAiAYnljXKIj144IxpDpw61Pmy2rrGFOl6zWsS+
	 cmAccGa6jRTclf/6KURe+yHjiYWjaGj4WqLP8NDznTRYl2PZdJUhcbHz/C/VwmpID67Lf
	 DNlml/zI9SDRCzgC6uiaKmp/aU/mcExK49m5pCTNZIZRItTZfsMlnCNaWNEl3NdsLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Nj5LFje5rjDypMD41TfYsvDxSNpFbWc1YeYlPKh1FBk=;
	b=kU9Q6LUcdsKxgEyRcq/fUyPcllTD1S7zNZw1ebbpIp16JKYqkjzBriTx4bIPgbYZfE4e
	 MpcF3wdTob12Jv2VGoO3Q74J9hKhOp2zryd0oLlAFCun0zs6SxuT4cuTDL3Ywi+NduyGa
	 QSydtfxmPixZBSccNgckgkp6zLnGJVvTvTQGju8ZogvKmyKL4f3asJOAEy0xa3vrsR3ld
	 0tG45UYGIbbGLIwVIABN7WMi//Xe5mksZxKxwXe84a6gT24WhDQXLrHYKhBEU8VIKhQ7d
	 dBdJs5H3T+/s6pLuNZZhY+1p5Dc+4dnjiVNleuJ9cJGv4gYR/JBO3rP3sLinj+6pv4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HrsJn1+B;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECFD606A33F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ECFD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HrsJn1+B
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-154e9d2d94fso4135980c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606559; x=1795211359; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nj5LFje5rjDypMD41TfYsvDxSNpFbWc1YeYlPKh1FBk=;
        b=HrsJn1+BXV/HlMswlZZaDDXgQ3AT81GVhGYSxgvypgJ7PDBQhDiZCz1wVWvVrvWVAf
         N5YBYVHiA/kwnDqXFwae1m8W9TZIVMCZh8tnqSWfurAfjVnRLY+DevtWgiUr3VMeho/p
         bbOyuY4JnTh3RM4KQcbs8/a6gnrwXUmrxj44Vuadh1mUmrY4QHudKyVvvOT0tVF67oCu
         DL7j4J1LI09/R1f/Dpv+nH2dSvfxhy40yhZM5DGqmfyl+H7eosvovttatYCeNuAEtV8o
         0TWLqWSIkmffsrg3uSnkcVPdXazSSWUKoUEbTJqCn9GoJ7jDnSr5laqRo2IWSATmLE55
         LLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606559; x=1795211359;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nj5LFje5rjDypMD41TfYsvDxSNpFbWc1YeYlPKh1FBk=;
        b=AGygsqEXpJXQonXXmgYSnsnSh4xucgdaUF/bL6D/tzYUaAbTI8zPeKup7y9UQMgOND
         lZ5mBuyHFY2KYKgLxlL8ArxVhU2Wk26TeOjznPUK3BFxdrXASnC28EcLaspGxIB0pngh
         EhK98uXTXsojSKDVrkGyu35WCefqAjBiUBBnyKUQ5HjWoOamIG7HiiDSbdqk3qu2uKAt
         ODMnePrsl/8Upj0iK1D36L0FvZu53nLH7x+SBxVOjJCLbxmRYRgJ9sEAPC5FZuMeAYyN
         9t+DzWFUvJUM5iwux4F0jwTXY4OLGcbazMF3akb5UJNDXSZ9gyY4ZTPc+9RAQ474v4py
         gQ0A==
X-Forwarded-Encrypted: i=1; AL+hErFeiuzCb74x3Ke8E0cuF09sDr+QTM7yJonCWKYdcw56gpJYZe/kbaUspVh4y5x//HV8unqEHy3fzAYPTM5AC+NG@vger.kernel.org
X-Gm-Message-State: APuU4Z+0n78LkHtxpDI7oDwfSkN6nE7OYUxzaG0sA8RDbKA7KdpIp6PN
	RvkWGadq+0IOYvwW/sNz1G3QH3MVNZjY8VR0rIPLMQFryZgvKsiMi7FeSEHtx4bV7wilmGQjGg4
	0kPQ17IEhSQ==
X-Received: from dlec2-n1.prod.google.com ([2002:a05:701b:4282:10b0:1a7:2bf1:46cc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:260a:b0:1b2:6a01:f55e
 with SMTP id a92af1059eb24-1b50312bccfmr3345764c88.34.1794606559279; Fri, 13
 Nov 2026 13:49:19 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:27 -0800
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
Message-ID: <20261113214850.3329699-4-irogers@google.com>
Subject: [PATCH v1 03/26] perf stat: Fix per_pkg_mask key leak on hashmap__add failure
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In check_per_pkg(), key is allocated with malloc() before checking
whether the (die, socket) pair is already present in per_pkg_mask. If
hashmap__find() misses and hashmap__add() fails (e.g. -ENOMEM), key is
never freed.

Free key when hashmap__add() fails.

Fixes: 034f7ee130c1 ("perf stat: Fix wrong skipping for per-die aggregation")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 6da3dbbde0e2..e7013449271d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -363,8 +363,11 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 	if (hashmap__find(mask, key, NULL)) {
 		*skip = true;
 		free(key);
-	} else
+	} else {
 		ret = hashmap__add(mask, key, 1);
+		if (ret)
+			free(key);
+	}
 
 	return ret;
 }
-- 
2.56.1.703.gf848ed807c-goog

