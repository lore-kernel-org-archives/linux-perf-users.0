Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BF328617
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422718; cv=none; b=HWjLOrKEEkPVSFltcjh9yDrDfSVNzhqlUeVzRaMoVgoY80vR4tlbPNLEY1G/YUbfBABW+f2yLrXHha9VJWYKdMxDlF98hvrP1/hSP3CAMXbX7RRattQaDvt1pza+a1ay0DFdNtR/udR6HeQD6N1VCw+8R9k42BUuhI33pWgKv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422718; c=relaxed/simple;
	bh=B2gk04B2aeaqoOcUpyvWb8TroOcFFUIngrROjwLCGKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpIVr4kp5KlQCQaSffc4uIQjdEK+OOHDls3Gsty+X+bNEZsXResTPLhUV2Gb/CgkAb+ymBoOzihaZgQrS93t9yAi5Wgnbv+83T0nUZCbs8V26bsPykkvXaX5u+N+v3u6gML5DYDbRbZXQTNAiWlYt/Oms1HVGRzX9f1nzWpFYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Togdtpcr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Togdtpcr"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359a16a400so5127154f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2026 05:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771422716; x=1772027516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYx47k8dyRpM97gMYzAlYbIru4B1EN9fBdkfbNWwdnI=;
        b=Togdtpcr/mIFtMEyXcsO6lnYEpoeYsXgoJhypgOceBguqcbHSXChmVHeO98kJAEd60
         WbAICdFUpmR1J4B22RCQoFmFtIb1ggVETRMo2PqI3Otfm2bKJa+5cLTxg560oSXclW0Z
         T3ZfERiFg0FH+5dUAOc4h9XQuvYnxJ8+UgyCdsODrQ/6Dopz4XmgTYBw20T/wYXRBAfj
         tEw/vd+U7SezgVIUsqJ56n7pTlhqIKzmhoj7uVApXmUfs+cxAjfEpRjJBLyAc3bOiGM5
         y4sTFime+kwXkioCSCsBoPXI63Jh4tfHTqQABZUI7useck/QNf4/6V+ITHK4Pg1uu7U2
         6k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771422716; x=1772027516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYx47k8dyRpM97gMYzAlYbIru4B1EN9fBdkfbNWwdnI=;
        b=E9EZprlpAOIsmssLAYcg+ApGcZcAg0qNkm4RSV6hOYmMcC45sUfJDsF1uyZN2nXinn
         5K81jl8Kl0OnaZtj0X+TrOJ8QmcPCmsrzn8qUUa30t1HixlqKkm+J+uaYDSHljTW4+am
         LA9rBwqKHd0Lcy0JySbGtqrre/w2azXopMJfWRv75ci7Ig1R7HMp8WfUEApzmrqx9EZD
         G7S89LkR1lwp0kx3YSLDi8wGzPI2l7zhDRy/iBua4MUlNNd89T4XyTgdKWR4w6a+rOYR
         tZJ3+owhZxG9E6OdGyRDcq90zD3xYCqmcd3POxAw8+EMfE8r8R3nGzW56lR3illfpt6a
         gntQ==
X-Gm-Message-State: AOJu0Ywo3nn6h+psKrcMkOA3X/ApsLRdnHjsId3K+J019lZMXDR8ZaWs
	LlAYKUR74hWOU9H7lw4xKqjYTCzrAL3wuZ1nUUOxfIxRYpvmxFJxhqLc
X-Gm-Gg: AZuq6aIicfE6iYDguXcDMwlYwby933OMRXS4gN1mQVKlS11zyjMloUJzHFe30k/Qe1p
	AcLKkBxktj6JpFGSXJLxRsIOK8jYrgY8ANgf4hE6053VuzRMISATXbMCZECkP6qMjE98IQN7igY
	4m3AwiDx5YP5SRQXjzvWzXzCNLEyUAYBPUGYUV2XND71AFKljUo4t3oCFIBgv0T5pYGnWS15+cj
	gsvUq8d6UF34LRKx2z1hog7Q1+mIcq0laNwdL5LTfUz8MmxT05Mq1NCqbzE7n+CVDq4Nqk1+v0V
	x4fr7s1Qt3E00basDOKP40S4ilf10JHaROUCFf1mdAFna7NwHkBxGtt+SFG6NBjshS0U5eOZtxb
	X/q+giXHPg/mUbHt6eDCEyO2Pa3aqGzdMzjkPpmDi7hXqNzdWd/nYD+sHdI6X0xVcCEXjzutj+J
	7i/FBZPQA2jQXEniD2EaKDkofC31yExhBxhr5ejwAT2h6tcDE+5KChjIRDUdir/TxdJgqkSNMVJ
	1LCyF1jzxtHNzI2f4AjTVi9Xa//VnOyoeIzT4puE4IJuh0=
X-Received: by 2002:a05:6000:2882:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-43958e57504mr3195980f8f.55.1771422715780;
        Wed, 18 Feb 2026 05:51:55 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a74918sm42069851f8f.17.2026.02.18.05.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 05:51:55 -0800 (PST)
Date: Wed, 18 Feb 2026 14:51:53 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Levi Zim <i@kxxt.dev>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v3] tools build: Fix rust cross compilation
Message-ID: <47mkwq2jzflgnswzvtz6rflu5hi6qlg4k55plizxj3y6fgqjb6@qbfqtpuwqqek>
References: <20260218084736.33114-1-9erthalion6@gmail.com>
 <d1a55d2d-b2b6-4763-a6b6-c7aa843c43ac@kxxt.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a55d2d-b2b6-4763-a6b6-c7aa843c43ac@kxxt.dev>

> On Wed, Feb 18, 2026 at 06:57:18PM +0800, Levi Zim wrote:
> On 2/18/26 4:47 PM, Dmitrii Dolgov wrote:
> > +    RUST_TARGET_FLAGS_riscv	:= riscv64-unknown-linux-gnu
> 
> riscv64-unknown-linux-gnu is not a valid rust target triple.
> It should be riscv64gc-unknown-linux-gnu [1] if this is applied to build user-space Rust binaries.

Indeed, need to fix that, thanks. I've double checked, the rest seems to
be fine.
