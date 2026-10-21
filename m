Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592203;
	b=5b6iij9f8dXL3+Rdjv9Lp18Lm6YcT8cdbeWNYVWfvrtdpphBTRdoZ3baUhNiuQDvpQUA
	 B/V1F9DL6FuB+SZr7O086TXYqGN0l8o/97a5cHPm5sJ3aPyUVIad4ysInM5pK934n4k1v
	 YSyeOnLUygCrRtymgPYAZuS/x3q8uSSbb3rqsJW1qSJbfTnVmaoAJyK7JKuMpxg77AGIf
	 fDtUsQkgBL5Mm9deBDmbvT87eD0sxPeOEj3q9exz2csAHEvwXz+986Fir42R5v8faDPvU
	 xNtLf0QVLV4ZIMZ5Tm/mkATnQ6HEKGPVewR73gMvkzImMF8mPc7ZiZyHZxSAo79FPAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6vw8BFSRQ/2Pr6gEks5F+/0NN1DbpHkowONhrXv+xvA=;
	b=Ej6zmbYn+13XJd1ha7wCRped7Xqjo1+wRAz4z3rzRN8ftnkMiY3NUBeCA4A/IryepFxB
	 fZZSTC5QS+D+pUtlFlI7ESIGeV/iA+jrecOJ5RagosaOIC7e03t7ZJ65yiXzovm7GCs8z
	 WP9hQ1nOMG15HO7lsmYRPGbKSJ4DAhmszjDAevPNF9QowOGrYhBI3FnJd06vcdGvY+krw
	 dY91t46VClmun2ylUgV2NyCQ/MCXcvLSj36/Pb+8XTNu5WFj0EsmNVlK9W1+QMg65LSVU
	 wfiaC6A/7i4hFdXHXTXyKWPTP0ND+wMwhYolSyGoacCGcJoLnpYhMnxrmwiV11RfLbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pXSGAQo1;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24268606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 14:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24268606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pXSGAQo1
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1d293b293so4543465e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592201; x=1793197001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vw8BFSRQ/2Pr6gEks5F+/0NN1DbpHkowONhrXv+xvA=;
        b=pXSGAQo1w8u14Mqjow8UJEyWhUYYrB69TR9aQWEvGhCixOimy04HdT28SeOD45WDA8
         WZuL6oVBY9ffx5cWYPjDbaxAACUw0I2cR+uYT0Garv289rUubRh3xjXR1nrBNtIX/5FJ
         //LmE5q+Ac91zAhqvjkoPK4RH6nyoZgQUVElCtFuC0wnSLsYE+XX+JgycGZlB4nsL9Rc
         tDz+B0XCbUVxgDkfrOIWRU4KVUme5crpdq4X8RqDqnl9gBoRPOY+6tFkb3K5AufjEyQm
         9bcq2POPABcLk8k4ZCxTYDlp0TYL38yllkQxGg8TvQnn6YwvqmbF7rq5SJTl3mZHN03k
         TnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592201; x=1793197001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6vw8BFSRQ/2Pr6gEks5F+/0NN1DbpHkowONhrXv+xvA=;
        b=E4xH86pK5FXeNv9W+QMe/uJB8pAj46a4P+i7Ba6Itse2SEr37x9aXnrrh8WZlV8I6A
         NcJjkWxb3nETiWFIaeFC2Ev9i93min1WTkXEbgOFEd6ZVaim1iRe7BpwkLR10AOn4cPK
         AO+bTnN3q3syZ4j8HA0+PzRU3isY+nxoLSLc3UZ63cFD2s8WD2QguuWk1iMDXsSh2GwB
         Bld0PzZS3Ywr2PoNzMdleXF28KS76SNVGwtnAkPwAtrkkHZuwBo828Dtq/z968ozUk9P
         +mfD4weds2YL+HSoVYmT7OuSewFsEOPs3TxBJZOTB9EF/x3ciR03RQ2g7YBvPNtjRSIA
         J/Lg==
X-Forwarded-Encrypted: i=1; AKwUvBzAbyjkZ8GhkvwfFo0kE7GSGgd0avFGP9SkBmhrM03zWELT22sQXu/kXeIQ6nkM71u0pQlK8PNF+THHDzGE5TNv@vger.kernel.org
X-Gm-Message-State: AFq9FYLeqVkuJUaKqfAKrAhSQbnbZ4M6E8nY7amQUm6xYMojnWcJKFpi
	/4JVbCzBr17If+hZOPBmx3rfFUV1H8NBLzC7VOt/kr1lGnZ2EW3qgVRd
X-Gm-Gg: AYBFou0LyIMm70dnhn0IksPKhqWPxuLqDhdVBG5fCqbR3X2SCSLAs0+ZXDPgLZEqsJP
	K1bCzdYOS8bV2Fo8yTpGtOCJv220cFUEmudeQJdCl8gMc8iN4vLnDLpOGVqgzhTPC6MKJd5NFbu
	jfccfDgnwRFKYUwDJrOhtdwpIEYK+xnkjZqEdrg6I4YEi+3401OWIbq3fK0lfkMcAKPGF8pnQ9y
	u5AtOB5F42Y3g+aDH09C1sL6iN/0tmJIs4+tibO0Ofza2T5p8hmS2docHFLsoaoe/8YA5omaxm4
	mtybZM64oaU4N/W789KoBVJ0bdHLX0KzG/fuu9PgVGGiZMIwZLbINsorvdL023/sHjvUhTyIZuQ
	ZOkOocvJOVXMsh//rqPcmfbZGGQzAHlvzGwxzzNYi16mswq2dtPOS7EGVE8Pdd0RFUwewNQIES8
	Z0Fo35UcYGY4bff+xCbr3ASVjLmwFqjf9aacnxurtEzcogpUtkppBi4slZ7IieTjb07oFAKf3sa
	DGh8yGh56PRBBl5crduK1grCZ5lAWFfuF+ozU3j/qOrBw==
X-Received: by 2002:a05:600d:14:b0:4a0:eae0:b30e with SMTP id 5b1f17b1804b1-4a1fdd29c25mr38502685e9.22.1792592200397;
        Wed, 21 Oct 2026 07:16:40 -0700 (PDT)
Received: from fedora ([2.35.202.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb698cebsm117409555e9.1.2026.10.21.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:16:39 -0700 (PDT)
From: Francesco Nigro <nigro.fra@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	kan.liang@linux.intel.com,
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Francesco Nigro <nigro.fra@gmail.com>
Subject: Re: [PATCH] perf test: Add test for events re-armed with PERF_EVENT_IOC_REFRESH
Date: Wed, 21 Oct 2026 16:16:30 +0200
Message-ID: <20261021141630.2408518-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <sashiko-outbox-180295@kernel.org>
References: <sashiko-outbox-180295@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On systems with Transparent Huge Pages (THP) or multi-size THP (mTHP) set
> to "always" [...] As a result, overflows only reaches 489 (or fewer)
> instead of NR_EVENTS (1000), and count_overflows() returns TEST_FAIL.

Confirmed: on master with transparent_hugepage=always the software case
gets 489 of 1000 overflows. With madvise(MADV_NOHUGEPAGE) on the buffer it
gets all 1000, and the tracepoint case still gets 1. I'll send a v2 with
that change.

Thanks,
Francesco
