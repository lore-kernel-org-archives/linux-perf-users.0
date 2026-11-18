Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007188;
	b=sebTLtiAv+t7oLR1kj418dEKutQvhU/WSSYDmId/CmXvXxdfmFuZQIaYsGc2Hz4+c6eX
	 UslQWDT3cLfBceZtLrGCGO2RJbQJEUYXszXQJCesmJrBWclgPqjpFfeQXoKhMSi/mbMZS
	 yvJ6Xx1yEgcv07+zdmk1rGt+F8TYHWXv/RK0jvXSh6eKBJXlQmKX4rZLRrJvwao3c0Bpr
	 YPE57g0buhISTjQMKqJTWIJ2jL2xj1/pMyVp2p84guj6qkpWBXgj9OFUzHPQyOR1ryM1h
	 +J868xmQlpFptK7G5o5yO+JcILJjlBWgKL/MRKMJxaVazusWrJXwja5unBZLoc6d8Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DyYtVveBhQy52iIUqNxGmc614rtRmx5Sogui3LnM34E=;
	b=XGtPgfajWJRcXzSn2X0VVTq79GAYBS8NvLqQmoifUdcOgkUFN8ZPwlOZ31356T4ISvb4
	 uDx00hObMVDsIa0c/H5qO7Jpr+AQBnYMXNwpXIP3WyjbhmAA2tpJ21Y2jSftp28514gLE
	 tG/G5DnF5chWui2ZaMGttgmhtnkdYty50hiYfJR3PuEtaJw28Ql354Mo8V0VcrCRzZl2G
	 OY7w9QVMBXQNygb+/BzqijbzRd5M2VazAQ1tN5lvjejiOOMKpZ7Np8YJ4RxHW87dRkUW/
	 8XinxGEz28fHAyWjilded4+PGHbTK+1bBVwYuCjRI5Y5XhqYEjhLHOR9vF4Y1lUup/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="F3ds/Y6i";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF634606A338
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 13:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF634606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F3ds/Y6i
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b3b75aae4cso741333a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 05:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795007187; x=1795611987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DyYtVveBhQy52iIUqNxGmc614rtRmx5Sogui3LnM34E=;
        b=F3ds/Y6iTAFk6c9okiHX4ugqJMur/U27X6JeeAJ+yzfGm0q4P2rBjaloJgMDKUr2/W
         34tCb0YlWvaAgF2fQL4f2Xcvuoro9nCd1LfXYXKmm4CyIqaxlMCF9o+vkiAjcyvDc/uI
         ysgwTZw0SGro996TrtCOaN9mXeVmFXu2WJe7KphPz9Zy0Z2kly+HcWaC1s/z5tH69wtZ
         v+yxhZv2dKyRATvbRm6FcqW4Fxtz+H33a+AyhlkW6K7JbUrOMO0oolMfhgmivnE3pQ69
         v0b6WJn9lqV6pFXwDSfEqAC5mLbH6CwDZ4dEpLHdp30XdPD9y1tDcR3kHyWnC+6/CF4Z
         zSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795007187; x=1795611987;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DyYtVveBhQy52iIUqNxGmc614rtRmx5Sogui3LnM34E=;
        b=khscxvPDsB2/hYl/vfz70CoHWJ3yw6oDg+zrhHDk3mTphcrEkmd3Yto+12ASkHVdwq
         jlleb248wiOodS062so0KFxKSwwCfXIoag0MXHEsURF/BqsuChSDIkjG7Ww3msKjaZ6V
         eE7hHeW+Qpg6lHS1WB8f/JdCvkvuHImWrVGM1VyoAulZOcfIUo684tylyr4PXq8yUgWV
         8oQiA8I2WtRYT5N6MRKVhN0HeqFyeXl0by38cDxsfRlegp/W1z6GNbj93MEY7Ch+5T9u
         xSvbgLCgSwTzIowfcxLmrA3oCui35aczCTzH4Q5No5MqG5JnHlDNChB4Oc1rEM9s0I1E
         WKaQ==
X-Forwarded-Encrypted: i=1; AL+hErHLUJmZXXQQ0pJ83vtt7o2OBQasghBUnVCmKv2xEX6KQ0fK32PvZK9cqkhnux4JSld2asA8Nj4wjtcMx+UUQumb@vger.kernel.org
X-Gm-Message-State: APuU4Z+iqPhCzRycJb0nHY4zy6mN0pSOB+Ekyl70OpiFcgfHMY0FTOFF
	hWQMF47/WxTMXQiCwTC4DHR7N4VmYQJpDzbm7zo6jF07dh0GcBy4adwO
X-Gm-Gg: AZFdTZc6EUAA1CoRn5W8zBJtEqCUX3kaAY53AqFK6ci+P+MvebCdpnp9PzvEwwpY/62
	+2GsDkt4whxGAXyk3T9qi/OFUjs83Xhn9QD2+a8iT0OEdh8xyGoAAwNkNOPTRyN8A0M3J8xA/ux
	Nt5/Nav/sEgL5wDpFPoUNIYspcbbetsgmrJgnYEaMFzeFaMhLlS0WtD+jOevQPDFgTtmu/s7kDU
	vduR/qoQDiLUYcvSGo81ToWacCJ5jBoOqmepxs8xd4aqkPYmLUNXJLPjcJV5Rd5cSHTdipcwFIn
	wpYZN4L6SsVYwNfdmA0LEHZ9sglGndHhmfc0jF62P0RYrcPbH1qyUFQTQAGDUDFx4JdRLELhtYO
	ghNCbGqHKLoij5/xo+vvw3yCmibIK8dX9zKO0xlYEdg93rwOkYKPIZDgXrm4J26/HpZ3rqsaiUY
	09q02AnfG2wA49/fC+n4gls52eNAXLxgSXzRUrN+yUv1+yRNNOoRUo5WxiNVExysX3i/Mc3O6e9
	CsgcsoiVbjkOP5NuUX6lK6v0YO2NkPPoirjylmyKtDwzZc26HaXGLhAth3VDTBmOY7kWwJKYiZR
	QVOKZf0Gw2hB9p3H5JfeC5lWXN8Y3RMa
X-Received: by 2002:a17:90b:2243:b0:3b3:c44b:b774 with SMTP id 98e67ed59e1d1-3b3d07a7a7fmr2534441a91.45.1795007186887;
        Wed, 18 Nov 2026 05:06:26 -0800 (PST)
Received: from macbookair ([187.40.224.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1c03e04sm4314633a91.15.2026.11.18.05.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:06:26 -0800 (PST)
Date: Thu, 19 Nov 2026 00:06:16 +1100
From: Myria Sarvay <myrialsarvay@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	Yuvan Shen <yuvanshen09@gmail.com>
Subject: Re: [PATCH v2 02/15] drivers/perf: apple_m1: Remove unused variables
Message-ID: <av2iyF3Ssa5mwgTH@macbookair>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-2-acf1e78da039@gmail.com>
 <865wxu1jfa.wl-maz@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865wxu1jfa.wl-maz@kernel.org>

On Wed, Nov 18, 2026 at 11:13:45AM +0000, Marc Zyngier wrote:
> On Sat, 07 Nov 2026 10:48:49 +0000,
> Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org> wrote:
> > 
> > From: Myria Sarvay <myrialsarvay@gmail.com>
> > 
> > These variables are calculated elsewhere as well, remove the extra dead
> > code.
> > 
> > Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
> > Fixes: a639027a1be1 ("drivers/perf: Add Apple icestorm/firestorm CPU PMU driver")
> 
> Not quite. In this patch, the variables were very much in use. They
> became useless with 75ecffc361bbc ("drivers/perf: apple_m1: Refactor
> event select/filter configuration").
> 
> Please adjust the tag accordingly, or just drop it because this really
> isn't a fix, only a minor cleanup.

Yeah, sashiko picked this up. I had fixed it locally for v3, but was
just waiting for other reviews before sending another series with just a
fixes tag. Thanks for picking it up!

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
