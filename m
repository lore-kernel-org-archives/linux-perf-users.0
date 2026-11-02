Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621746;
	b=jKbfiY3XO05R9opm10a7GcbtpgbhMb9LMJCng3sPK+VIWhugX9+X6fgxsvSWMJVEjTRB
	 vY0TEF7nyhqewJLdK/Ioo9np+8wRYPLaZDsK26sOv+tSeHoyGnsEFDgMIW5su3FIb6El/
	 sa9YnG2GBd/SIeCoqykEro7XmUZ2dNuTX5IsCWjGC2bH83RXTBsdkZjbTmuc4LYjxZ+Sk
	 PTLmw7xhI8JwL9g5G5zMWf429p9ZEyT81R2ptqMA1hBseF7URx0+mdCiHfyu7LRWxxLqq
	 D2572FZmDKD+nkuJU5Oq/B8GtHI28MwM3SmG9QkXi3Y6sXqtGtg+/aX7qlZz6ulQ1bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ITCoMNDpL30MY89egTwFARcFVAAHOqspG7oErRSdzzE=;
	b=j31zSgZRzj7xGsQzJOon+dQLFczhCDrO0qmFXLMsYD6XOsaLHeQ5QQOOT/Mr6VL40ij8
	 OggwBoyrr4Y+vBnX+FhsUSQqkXKcPGEB6AmsrCKkSodQI/0/fGxJJbMU2ZgC9ksahuHND
	 rogUGOVHQMX+dxFOaDic8yiktRbeUEw3Yk/PkQUYkkO/O2essHLcSvEM7Erp4rPIH72GP
	 puO0KtK22D70iYbyk+0pIvbPWdhkg67o8gCgQIzKe44lCIG0bz7ZqDJ+HInCYabAEO5je
	 uzx1yjg5TZjpzqanuoPrebVm0QAlefbnOUTqZk1feM3BjOMmaWTo7lJo1t9INwosyvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m5IrfOIA;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EBC60A260E
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61EBC60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m5IrfOIA
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so14970995e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621745; x=1794226545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITCoMNDpL30MY89egTwFARcFVAAHOqspG7oErRSdzzE=;
        b=m5IrfOIAVDpYc1M50pM62wsyTxiPDCTiw+cam/tLVnjwdpOBSVau6FgHz93uQ2w9rK
         HqgWKm1r5/nwqAJB9yOBZUhtnT7oxxMTnea+KfsWJBvi4p7l80i91jAxA44dFRs1c/mq
         wgqgDPzIttI/Xgu29+1qFyztWH0IqX60ir5MHs8mmyGG+nAlZM+Lf9jlF/iucreYdz2H
         gg5wEe3bwIzwt0+cBXKeuthobcVjuQURvHgv5om7L0sdfNsOnWzQfZxu/t2cduzjr4Pe
         sU6RfXdtWOej9BKpC4DqLu4qR7+15Ydv5unv+K9GRd6jv6kYUksP/NLk1apYe0fjkQb6
         YJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621745; x=1794226545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITCoMNDpL30MY89egTwFARcFVAAHOqspG7oErRSdzzE=;
        b=b25NQHnMlds3O0ofC/MUzGD0nxdVPzdM9Yf8b4rh8k8dAMoaM+QKX0/xtqI3J7Llpt
         8MkzC1eXsBDOq2g4u42dFbK1ygJLgvwT1DEZC1k91Ybn6NWK2J29gAKolKYZKTkIhbo2
         v8/+2iruo9rDV4Pc5O13ClMMXFSnrvpTNOAm3hxM0zK2q4867TjskBkk/p8XB8kkk1a+
         fpn0chHGXlKhOrg8my4UDgJdNQIMBDqJ3dT5hlcuVc4f0fVynueMmzia1zXCr46RHGZw
         lI7gqesCprFRv7WcvTeXlRu2SFM53lJFVZhpf/UgbWWMOKT0gUNRiRQkZL4K7dVEBVJH
         LpZg==
X-Forwarded-Encrypted: i=1; AKwUvByHHZjlHzWytH6m3vQjXfooeZxzjvMMgxE92Cm84M0MD2S3Wnhqh0cSyT/c1N6VLV6u/FVn3wJ6N8itJcCSxd6o@vger.kernel.org
X-Gm-Message-State: AFq9FYIAx7ysCcSDJ7TuXxiN/hp1kHwuXP/NU81rqO1ozxcX1H5fHfWR
	fFMHN2k7KHEF2Su8FU1S/LyyIvz4yVhy7G6+Tvt1ZizWs16KdNNnMzk4ONpr5UmdaR8=
X-Gm-Gg: AYBFou2LjZUEli9DIPxznxNyeUykqWdWSQjpX/G0cAWcQKEpkwfKvmM7vUwKRZtBywJ
	PFb28JYml4XyzO+YQ3XSWts6soqBhMyXP24y09JsG8wBXS8Sl9wohHL97OKTW8vXmp4etouX34t
	AQj5CyqFCyP8feBsEGBb6TRQpWCfolxZ5XRL/wAKNlPaocxyBSebD50mGC71697MPtoPYL6fgtR
	6uikN2WCehva6emclJFzYmrkUNRgaUerKMEhvJR6sF77MoRELhtO07muqi9TRBPuhA7S44y/E2i
	3hqj2Kk1UAcipUmmmymu4aVxgNZQMTA5sXfyr1ZJC378MypFtLqe1iKT1PGRksSR51LdZmHm9vc
	QRahYHK2QGFrNew7KTlwphF9Fek4uKXibkEeFqQPzaYhedHhxfZz2x9h4381azx6Lx2ALPtixcq
	kPlRbOUjUw78cLx71Lgm3RVcG9twDCINCHTIxCBLW5MxGAXyPFkspJakYUQf7ut5+6nP/lAvEOR
	vs8BI31rKzk1i8pkUmKbpEbLi53MI5JULsYQAjPcNvhP2dR/sOfC4sq5fOF+x1s27yP5HIpH6zE
	iDsUhWF0yEltGy5d4uXAfLJBoR6uRhUJRWDzAaEtMJCNoatQOF5E/g==
X-Received: by 2002:a05:600c:3b0e:b0:4a7:7d22:c50c with SMTP id 5b1f17b1804b1-4ac150b2243mr246272115e9.2.1793621744767;
        Mon, 02 Nov 2026 04:15:44 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:44 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:16 +0000
Subject: [PATCH v3 02/18] perf cs-etm: Warn for invalid timestamp option
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-2-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

Instead of silently returning an error, print a useful warning.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d2861d66a661..acfdb3f53821 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -176,8 +176,11 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 	 *  0b01000 Implementation supports a maximum timestamp of 64bits.
 	 */
 	trcidr0 &= GENMASK(28, 24);
-	if (!trcidr0)
+	if (!trcidr0) {
+		pr_err("%s: timestamp not supported by HW, disable with %s/timestamp=0/\n",
+		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 		return -EINVAL;
+	}
 
 	return 0;
 }

-- 
2.43.0

