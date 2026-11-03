Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738276;
	b=YO9veHfHO/J/xaz40orHezd9199e7C0TPD7SS2Mye/Yc17vljvGKgDMj8PXrzIdWHsNn
	 FrbfMmmgPfg4y8b06RGIv18K0UW7pruIedZYj2LYclxbzDbf9x9ZnTgrFehBJJpIH2I5z
	 /HvGeBLuwLKo/FQSAkumEcgG+3twMZVcq/gzye2SmiBAqw0+dykSJSifM+A08SLADzkqR
	 M9/xi7Bh1lUJZZ0Um5n2vD2gtKc+onhfMCjNo0tLV3TEMHwXlvZykFzCSt824gPJbKHVD
	 y9UJDtkeeZH+NdkZphWu7ouSdRjhVpeBz+cN9GcoWbpxFwSmoiQlv6MwTzUPXRXCOkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=LnnXxzKAtyL33rBzDInbJu9ukQjb7gHbfl0z0zsb55U=;
	b=Ge8n9wJ1sYJU7nu9FAG0+D+HEBVaMHZJvTQMhzt7nrGhneXpIglvUrmGY6HZo5v1uttI
	 PyhZQG87ZOcuuVBI73d4zg8jAd6IcKdMGhHasK96WmQUxxskBWEKqjESix5eXXsXgL32o
	 ep23mhXR6v38jGl3XCNqnsmIeHTzizGtWdT5s0X5Ag33hRPS9zxACAdMmiH+HbRjUKawV
	 awVPDKonbjHkLm/l3McfVYTPsgcNyNrDp0Dc0SgIn7BqdOVOJTsl1z6+S89GAXansPLzu
	 TGCMy2s0dt4oxZzhikGYF6uRkcxdT+umYqskEqtAzPaRC8w3WIkndUN/nKcHfi8LjTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CpOqorIK;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BB606EEB8
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419BB606EEB8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CpOqorIK
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b308fca7c3so36537b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738275; x=1794343075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnnXxzKAtyL33rBzDInbJu9ukQjb7gHbfl0z0zsb55U=;
        b=CpOqorIK9GCerjKACiSe45Y5HoEFDz6mcFUuRcFrqqpfGThEefTr/dsteDSiDIDmh5
         dMUQPBxVmnhb8ZvAaYNtKCSb6zuAo3r0zNXfdKJUJqUAuBBopmDWlCcr1xEH1s/yb9wy
         V9cTDVnOCrolCa38xP9QSnr3fPtBAEPZlGbZohPr7WdYtqOUse4R4iQQBM825MCuXvBR
         G7PYJ9mFafyCEWAMGdlhG9BIBu0sayHHVx6a13nnJvAEZ44fc9OYgtCRTZbZcSu8zVA7
         YxinKrbGC2G2ycx4G0z+Xn2Rw7ezG1u+umz/X/yvr3AaFIAuYyT2N9dUMxtXbux/OeXH
         Y3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738275; x=1794343075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnnXxzKAtyL33rBzDInbJu9ukQjb7gHbfl0z0zsb55U=;
        b=PBYyj0OZ0DxuCzpJ+QS0joGpMD8mzzbfOVOf2PQo1jNgsGkgn+0XI2OMmH1fgnuse4
         2P/IWGJkRP/AY7u1NplMMe2PbmseXuAl/UVbzESm2ykUeeLjI15bgjIDv1hzY38TIyLU
         aI7dx9milbwOJPlLIGtMP9DsODZJO8o2Zu9PWxfhHCAtuk2qdBaPi4cJvGizjflvUcnH
         bN3N1aboQ4Iy5L49ZiPOsulqEt0Qe/5pPHy0K5REsLqt4iFAPhRnFHnao2kU18YIJW1q
         yG/+p1Xl1x+VO0KdgN/CrhcjBiurBhLlVe7YuAZSSqQ2/Ylfelz06aJdzjryNlfhgRP+
         FTmg==
X-Forwarded-Encrypted: i=1; AKwUvBzq26iV3M+7xMHmXgY+4XjB36AFJmfk4qNG31zgIBih05Z3kwBYiJH2wE8zsj2zCyRAjBG/A5qRNZCpfMosYnXG@vger.kernel.org
X-Gm-Message-State: APuU4Z9578Ku7Qol7wH9qREakJ/pTZ2bjq98ldfCjkUTDZ0ujVnu1py4
	jy8uJMq37ep9n0OdZrz+p8oKDwnUkaAyzr9ZmY7icfut7LyLF1MKrGpP
X-Gm-Gg: AYBFou3sSNdADw1AOJXfrRjnbCAdH82BAN65OuSOPY01JOkzrKHCOH3bl+j8ZC7f7Yn
	WYICPwDuF12aVx8LWlCibkOgGWai9kdSAWW+aykNxkP+8vKdHH8zyKvpcLKCN34vRykqcyd+04Q
	7xzSrOOBi5XXa+S3W0Lj5RicpQjq77NbxZpGsN413CVIvTkAO1i4DF69jZ/1wQpyNrk9WpZafrb
	/MjuCnw+tGRaq6a71m/RWHtoCdJ6wN1f2jODO+189W0LyDF4f7qMMqcOpVvjCzfpooZHhaFW/kb
	Uu+Ez0iVFKvRA7rvEUrBY1PYXfqaDDz7/vMyMcazqBvHsLab9zVQos20sZYA1WCgEgHrV9isoNW
	1n45rpjNnNuqat3fepS/HMyBmrsvzDkZVyo5lAb5CidqpgjZgcpGUYLwqvzDlF+fixjIuO2LlNK
	G+3Z/VVA9mQ2lHNegJnyImW1+hBq4oGgCZli3TyTi57faG2uQ6Ewo08OQdqrUrZGyo04jRrQdtm
	hVNYl3fWu7g74bbgP6MXBE0M8fiZ/TkzlLFyvb/M7v7rfN3ECYO8R9Zw8wluawsIOaX1uc/7sHt
	0Hdx0XxTiXvthK/P/8H8m5e/v7bDaJCHfmA6CmkojGfR8Bbu+JUtyuRps+AkOnksEuoJdI9KN3Z
	JBjrsuTKxmw==
X-Received: by 2002:a05:690c:e3c4:b0:8b1:901:b9ee with SMTP id 00721157ae682-8b2b66ced27mr105221827b3.13.1793738275325;
        Tue, 03 Nov 2026 12:37:55 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b30992b0aasm4710137b3.17.2026.11.03.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:37:54 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 03 Nov 2026 15:37:44 -0500
Subject: [PATCH v5 11/11] alpha/perf: sample only retired instructions for
 precise events
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
Message-Id: <20261103-alpha-profileme-v5-11-bbe3937fbf3a@gmail.com>
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
In-Reply-To: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=CuA3WhUURsXwQIW0gkFRSbJkBWkVnkSIwyFkyFPC6gI=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJeufGf09o+49Gias1NPsuuzbly+Zk1r27+tZ6a8sWBp
 Sn98TwBHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNtJmMDHeU6rfPlV
 2yKv5c24mpXJfOOG6cGv2+RLertEH/QoV9+yaG/5mFny68XGTU+qmipWfO2ROTWoLNTy9TdLw9r
 /dFQ8XvDZwA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

ProfileMe samples include instructions killed on a wrong path, which
show up as hot spots in perf report although they did no work. On an
EV7 loop with a randomly mispredicted branch, 19% of the samples were
killed before being mapped and another 48% later.

PEBS and AMD IBS op samples are of retired instructions only, so make
precise_ip imply the retired filter, unless filters are given. The
profileme bit still selects every sample. With cycles:p, both kinds of
killed sample went to 0%.

DTB miss samples, whose instruction is aborted, are then dropped too:
their data source now needs cpu/cycles,trapped/p.

Suggested-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index bed671fe726d..c108b5488a50 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -825,6 +825,11 @@ static int __hw_perf_event_init(struct perf_event *event)
 	if (attr->config1 && !profileme)
 		return -EINVAL;
 	hwc->config = attr->config1;
+	/* As with PEBS, precise samples are of retired instructions. */
+	if (attr->precise_ip && !attr->config1 &&
+	    !(attr->type == PERF_TYPE_RAW &&
+	      (attr->config & ALPHA_PERF_CONFIG_PROFILEME)))
+		hwc->config = ALPHA_PERF_CONFIG1_RETIRED;
 
 	if (attr->type == PERF_TYPE_RAW &&
 	    (attr->config & ALPHA_PERF_CONFIG_RANDOMIZE)) {

-- 
2.55.0

