Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000754;
	b=m8v2EAXMXg0RpD12R7w8mr3GJ1Va3/C+lTeGJkYj22TdqDLl26BbQz7fuGHTdOjYexmV
	 LnYkL2HTXYNfSUEw61h5SntY4q6bjWeXG05L/EObj/6VVGx4+wSNI8bsbBAwjQYnJdxmV
	 IM+b79N3pnzitHb1hGBrk2khArQOKHzbBiGUBcAPptjegOqm6gDJTclOR2xTydvsNvwkp
	 aYxT6bp0g0sBuBBiF8rp8+DgtAL18ESECMWvBVgphEnUY1wZnajl1Odb/Wml1q6DlqT00
	 eaIAxm2Y5i/9qqxyvr3IqS8Pv7nTOi1aYAo7OZGau5YABjESwwvKp25p5PuOPzFuyZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000754;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=/YPy7EtqEBxvhYpVJg5255qtXW8TP8P3A9Yp5QpHQrs=;
	b=XRkc+9U565gRuQFtafe5UQoaK4r+7lDRbflWcEj74ZYQOQoTs/AfS7nKDZP3NExtBj6h
	 kdImda1D+sGGNyO4vrNTojSKPATRptqpUgdnNVAlRzVMvLIw5CKaknM1j/95qiaJxAPU7
	 Vm5OJKYzt4jM9wkjdIzTXtcQjKem26XQDrYj71b+RmzdRew5hf/YkMlFU+3ahTu2rREhs
	 F8zX83GLjk6cklf3+t6V5fSCx7Mg9H4ws/3ylfRlqFSHX5mT/n9NnfPFjf2Hk2yaUehJC
	 +RJYAdrhk1HRYWUPDrdomBIC+Al354KPfSW0axVEtF3WRck9/fxzgkTbOvMwi2jVeBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+jvgTNP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115F606A329;
	Fri,  6 Nov 2026 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+jvgTNP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF701F008A2;
	Fri,  6 Nov 2026 21:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000753;
	bh=/YPy7EtqEBxvhYpVJg5255qtXW8TP8P3A9Yp5QpHQrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=M+jvgTNPcTZJQwyGpIVg7LORfd80qPqCvwfmv00IFSDKglKybrFh2Q86T49BHN6Pw
	 eepnOm9XDnJOzR8jyW4GTgSo3lEYeFxB9nyTtrxOzgnmJKLhHV6XyzmT63kw1ebYRN
	 wWN0aMRfaBm50as9/t8q/UshKEYybFS4atrCAPh/OE6njzaTzKco5O3n+uLjx1FjKw
	 YSWHS/0jaTGRZncGCfuR/mMc6TL1e3ki/tezwZCUMBkNKHOZLXPQSiMk53E+L133A5
	 lelRsVAlGY0qCqMy6TP2FFzfu7SwBSWYiLOsC+xEazaQxO4IjRGdBNRgz80tthFnb0
	 OL6Gpn+UFGlqg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>, Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
Subject: Re: [PATCH v3 00/14] perf cs-etm: Fix bogus branch samples on
 exceptions
Message-Id: <179400075194.23155.10383549774960029763.b4-ty@b4>
Date: Fri, 06 Nov 2026 13:32:31 -0800
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

On Fri, 30 Oct 2026 15:13:07 +0000, Leo Yan wrote:
> CoreSight currently models exception entry by changing the preceding
> instruction range into a taken branch. This can give an IRQ the source
> PC of an instruction that already retired and overwrite a real branch
> immediately before the exception.
> 
> For an untaken B.LS followed by an IRQ, perf script currently reports:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


