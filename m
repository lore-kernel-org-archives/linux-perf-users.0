Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEC38C2DE
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532135; cv=none; b=UFtu/l7uCCogTlxjFAjWchjfsp/Xeg8PQHtzAMrZj11RyQdOBJxImQ4sgo2/+K/JAoPJnwjdKaC6WBuWgmXBXDfUAvifJjG/5YvxKHIPwp9vlFnJXi5d5c0cMujDphg0/GkEEByfWEeUWjRrebD7omYQ1T+XXYXwuJXRlQsNasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532135; c=relaxed/simple;
	bh=DaF1WA85q36ajkUp2wWjzs8vEjfcfgQEKe7dAK+cruo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=AJ7h4ZGm8HftiyEmN3sktrm1m6e23OBaZwk+VIQAHtcYhKbmTdzsXKUWmq7R2riA4V0y2l50zHwYi6ehdzr29CGKW7oZ21AMq9Zqdz7h7EaLe+0CbxuM6RFiP6EY6iunY/OlNJvJV+x38/eQ/hAnsCJ397Woa9geKZ6FyVdspWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8ya+zOI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8ya+zOI"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso9845783a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532130; x=1785136930; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T1rQiWC4b1Qi8oqfTxdLB8xh9GtA5nvI8VX0/xhDq6k=;
        b=c8ya+zOIEKjFGbDfM7wiYgIpuMb5c0Ou9CrW5QZKkr56wvyRScRxoKFke/+62MAtNS
         R5gxQJ4bvwOhwHaexwAv91lu8SAiEhkEaa/tg8yOfKYMpjrN2V1ahgQHkkXzHBshluxv
         206HCpDUU4lJRvTvavnFlbMRtaX0nbSUD/7pKgFMt/0uk+Gr9KLAl9sltcuUUq9Nj5Xg
         b4LKmWPnSrpmh9+ncvbCeetVbwqMN62S0gZqYvVCTo3T7HY/tb9+G/JoReTBGNGB58tV
         lzFVqQ/2TVClLtYCqpcEUSSqVq3FaBBJMtPGmtjwtysHVG7Q0TosEbfv8lfk15xceUgJ
         v2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532130; x=1785136930;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T1rQiWC4b1Qi8oqfTxdLB8xh9GtA5nvI8VX0/xhDq6k=;
        b=Tfo7QCCbY+Nr8Wn/LpVDH22O250EBmy9XRyS/EDL105O0iL1KcNZFYNDPY2F9a5iVD
         GUkSLEhzZEuWaAfv/rPEvxPZR+/KQ9DIcrKokokIUesQKwrUWWI1DSwVHcmgWiNJISw9
         pwIN0frjAYS0pd1VuTbN1FGqRBDvS2RJyd9SuFmJveItLTMQMcidBy8bHGjRBMNByitv
         tekvVMHS5nqk/fnZMD8rKdKElWi0WDb9BcUYQs8LAZk0AejF22vNcdWTfvVhiGuUfbZB
         wtiJyf7hVtD/eYs4gW1Z+ut2VnFs2wNS0Lvb+wz8fccPz83iIiVZJSiaAki6k7ol8Bpi
         fPfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSJfKQVatLJhv46u1aT6EBV5IEGJMAbP1T7VGML/xueRsTo5UsyREgcIGhm64Og2fUqhgJqVy2grlXmObTmYJH@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEtWcnjpfidLXjHTcxLHuf8FgyA9PzAIDPavxuTbyZ7WowQ+9
	ZgciSdt1K+M5hyhN23FSCMU+ptUKuM9i4ieg/sM7SLrl2nR7cp2gDRsR
X-Gm-Gg: AfdE7cnhld7ufmDhudBLfKET9H8XEWsTuUjixUSLWxNvXcnQ8o+8vjpS96iw4kHVUxV
	Q2Ces9BLif7IbXHtV+4WxcZ4c78nrnzlO5QzvV2EtArQc+H+YMPlbOocI+re9+eR8PNvx5rYzdM
	B5y2Tn1gNBWHwqGIuhBCT1/p+LFg4XVzs9jbY5FLCxhAcDHeAYNeTbjW3SYZYKac5490KrECLI1
	U5Wak/yGPml+ZLQREtpDeSq3LfLVhj8Uelwda1T9EDuPqkhZ3gACJ/XTWt8nK/ORHpminUy5JIG
	vFIOn5mTyN+ALqcU+ew1gOhjermCcHhT+UgjNfxj97Gp9b0juCOwv8YCVuJbAG8CBhnNIZ+3Njs
	ImkObMghedESmAzL3xqi3UPkWC/ueS8evF+/ZGiZZU7xl2+w+G2RPlact3xU6g4Y3oVKbqc5Zs1
	PonpvdtRQusn6P4sOA4yicMmBZ++oXgt/V1RIzm+Y=
X-Received: by 2002:a17:90b:2691:b0:387:df8f:1408 with SMTP id 98e67ed59e1d1-38e4b5ad2a9mr14741701a91.41.1784532130478;
        Mon, 20 Jul 2026 00:22:10 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 03/22] RISC-V: Add Sxcsrind ISA extension definition
 and parsing
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
In-Reply-To: <20260701-counter_delegation-v8-3-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-3-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211934.543975.9634665501136926362.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=387;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=DaF1WA85q36ajkUp2wWjzs8vEjfcfgQEKe7dAK+cruo=;
 b=RXEmXx3bUlqTR60e37EoLeCgujoBbcJb1A9/syNgqmenEp+jMQ5zhL3lYU2n1ecg3AztUmOp0
 223x7CuCQiDBG4mckQKZidh3U7VcQ7UofEjiHekyrNNXCwnACr4Cm4W
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:46:51 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> The S[m|s]csrind extension extends the indirect CSR access mechanism
> defined in Smaia/Ssaia extensions.
> 
> This patch just enables the definition and parsing.

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

