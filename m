Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361833;
	b=zjo3qDLCVQx2TYNZASPE0CPAdHe2Eo7bMqK1pWVOHwbtRdaZEZqCNLZli2Pl7evtVEEP
	 YxvQEuJUfh3C56a7MPHLh54UJPBnf2MC0ZY0X03+yNVUpphCyikySlnVuZx6iDFXXqgGB
	 bUJ3tD3koWOXwYfafUA8n2niJySWoiaRYkJkDZDhQOOFcg27eFpg3lXaG0S4KSu8sXHxp
	 KJctKizoN5YrxQp+BIkGDpyftK4115yTZLfe4OFHrahQL5e9KcnBvegcc3157W7HGZf8h
	 36Uo4/OpG5Iuvx1ukBp6gQj5XYLbRcaULtvlRlArSCGEE+b1e2YmfyINJZ+c8dZMAcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361833;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qAPz+q05J224FADG5AGvB6vTxv/qL4tcXrC9H9Sjahg=;
	b=Mnpyphi0sCTPTG6ghgYudLmkucVhxLUU0dAPovIOvZuLk7WOGj9wF0BnU4Ldl1WpKu9o
	 QjHSbOC3gBMXxdwB5v23fDdvlhxcdPBsmjQqQ7uGMUINtAVmrO6HCJMyaD2D1JwqI491M
	 zyqvxtpME4UjsEeIeoMbmGQbUV7dqmsaZ2pcyPtXKPMrslnJxbGkm51UFeFOGzlH+zJCZ
	 VP7baIu/42BgmEFTfP4RUL5m+fOenNLa4KOnPnA6kDuvmRWcCndSAABNLZA4GSzKnb5M/
	 aRkBxlYMiAAKFpg8RnO1ukmggxGStax2QOL6WqrPOhwzw5VLejXYnzSOXzhLHrQwJ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+wSqpex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF299606A31E;
	Fri, 30 Oct 2026 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+wSqpex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4BC1F0093A;
	Fri, 30 Oct 2026 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361832;
	bh=qAPz+q05J224FADG5AGvB6vTxv/qL4tcXrC9H9Sjahg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X+wSqpexr2WBrOmsc/ciaqLCuSTHbRwzwV5/UogvJFEABK9V1tMvRXzq5GZ1ymkAH
	 VMVvqaiqlBfZoA1/BHmgJnpfmjXtKak6144qshL8u96+G5LFWcAOhTqfPJ0pVqn6dn
	 1l6/TBGsPnd7Yq4Ns36BpdIeIRC98z1wG7wvbQvW3iHlPZ0w6mlKYAtn16VmJcp5FV
	 DBOqNOOLB+4A6xRfxImMleZ6U0+w0GOOwt/9jEzsGdsHlGcciakCIlqL2uIrBMVvUv
	 l1Ynw/toqblBmjKGF0Enfvl1/D417O8V+EhELAD0u1pp4nZ/6/nwDuY0LPYIlhhrH3
	 XAIyrXTT8zDXQ==
Date: Fri, 30 Oct 2026 12:03:46 +0000
From: Will Deacon <will@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	"moderated list:BROADCOM BCM5301X ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:ARM PMU PROFILING AND DEBUGGING" <linux-perf-users@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Support for BCM5301X AXI trace PMUs
Message-ID: <auSHoj46Os6gSEUH@willie-the-truck>
References: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261027175124.3518239-1-florian.fainelli@broadcom.com>

Hi Florian,

On Tue, Oct 27, 2026 at 10:51:21AM -0700, Florian Fainelli wrote:
> This patch series adds support for the BCM5301x PMUs which are AXI trace
> engines present in the chip.

Do these replace/interact/support the series from Ian at:

https://lore.kernel.org/r/20261002175738.3242646-1-irogers@google.com

?

Will
