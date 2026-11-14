Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624997;
	b=FLqbgQvlV2+DYwglfL6/Gv277lRlr/1lUDFHz4MimVnmT4UrlulcsHlvJOb09LX9B7dM
	 AMNrIBKHhr6IJoZYITOAHLIrRe5TCen40V3/MMH/9AViO8ojmgJvDNX1a9jpk2Ed8kHiG
	 SJQIhqNJBej+BYJWMKN4rfzOZ7c1afrLj6UMM/c+ATdpseZXDw0KcDG3rme6x3lxpq9Kp
	 2BDh+mptNSgvZEtRR5mRZ8j2cDDifYKtGO6+X58xu1iovxffq2o+AlACBd/JOfH+a230c
	 beBvraB/RmbevlmY8L3vgaLythHPYscIFWtAZZr+XAMQR1/7r1X3aq6zlhyEoEQn1bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624997;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=D9MDJiDvaiNByxEbVJa68l5o/+4Q4FEiyhGxQDnwg/o=;
	b=lxiawzDeHuseINwPRPDjwhoyrzMdlH6Hp/yGhxilpvNcMMNd6WRadTRHA+8Vjfay7UWr
	 mdExtlQlGHZf3gu6WPkbEtYFWwgEiMF4dOzuL5rugcZD4BZphaJ+J+hDqdPfTu45xWmw+
	 AQEAx+mgaPIQWtvi6+z1V8Q0XoYv1s3pnTpIslEp4xI1Tuo1DF+4Yn93rgXOCAOOpGDVN
	 DgREo9QwrD69iPXY7ju9zzLJZDpefacK/dpGXhEhiGpGgtWIO/qQ4EMH8vdnT/B2SCh6G
	 ybD3Kv++u4fKww7v0TKNLjtXoa0FBfuSyrrA+EUJLDygW13Tzi2XVdyM8+luZhVU8nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYPnTbNA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE5606A896;
	Sat, 14 Nov 2026 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYPnTbNA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387681F000CA;
	Sat, 14 Nov 2026 02:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794624997;
	bh=D9MDJiDvaiNByxEbVJa68l5o/+4Q4FEiyhGxQDnwg/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fYPnTbNABBYoeOa2mwpSwYr2SbVvBkrCLR1XKjDyxFvyhmAlSe07wxBHB7qsufclO
	 MolaAyY5dchGFH8eM0pv0wnemuR7lNNwAPf3V8x+ZJp9yHXSW9Rz5wpR43X6R3pjZJ
	 3pfnKi4jw7TAHMS2VjxT7w+SWn7TvfAhXDVaP5XivGoI8a3O6VWxwWm3a1iesjxNyL
	 MYD1Ygs1gHVCekbgjWHCJntbMJibbUtM76BoknXTzI7JW2pAInFYcJFQ4Zn9pl7IR1
	 rdnDuVVKT0vmasyU9Xdtiut0gHtiw8aBw6DspRge58KmUQv4KFfTOrMEdSLPSk0Ctv
	 A1iv3B2nhCMxw==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, acme@kernel.org, 
 Lalit Maganti <lalitmaganti@gmail.com>
Cc: james.clark@linaro.org, leo.yan@linux.dev, adrian.hunter@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261018081452.1014460-1-lalitmaganti@gmail.com>
References: <20261018081452.1014460-1-lalitmaganti@gmail.com>
Subject: Re: [PATCH] perf python: Set up callchain parameters for sessions
Message-Id: <179462499666.532197.1169725510573610936.b4-ty@b4>
Date: Fri, 13 Nov 2026 18:56:36 -0800
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
X-Mailer: b4 0.15.2

On Sun, 18 Oct 2026 09:14:52 +0100, Lalit Maganti wrote:
> perf.session never calls callchain_param_setup(), so callchains are
> resolved with callchain_param.record_mode left as CALLCHAIN_NONE rather
> than set from the sample type as in perf script and perf report.
> 
> On arm64 this loses frames: when a sample hits a function before it has
> pushed its frame record, its caller is only in the link register, and
> recovering it needs record_mode CALLCHAIN_FP. Comparing the callchain of
> every sample with perf script, on a frame pointer recording of a
> two-thread workload on arm64, 4 of 4494 samples miss a frame, e.g.:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


