Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59F3C37A2
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514165; cv=none; b=W6TteQxgOzPGUaL8bCDTNFsjMUpCUOy5t2QUH+jIKPUjSMOdh2rOk/mV38kujZBBj3r8pHFIcNzRdvCUTZ8jyCEPKHI0FwCWyo/tU09F4UNbk0d4+2TMXE/9/8h4OXXRZFpPLk7GkTM/TVobNaxYcSEtiR4BjHuHyRURaemAvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514165; c=relaxed/simple;
	bh=DscurflqUz1gWeMA3fumlkzYr97Q8g4tA5X5bFkhxbc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t88ksbBQn13l7YX8u/S/+3t/2THn1CNwfnKQOlHyKxARg48L4UMXMUCwAvZ8cY6pNu2q8ffQFuXUUk94MDfqPtFUq7nE1nEv15/efYkgQNSpCI0LvM0Oez6FhQLVTxQOQcaRS+f8COIjkn61dht+EeYTB36Pjcb5boUVF7irhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw5wPchP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw5wPchP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040F51F00A3E;
	Fri,  4 Sep 2026 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788514162;
	bh=DscurflqUz1gWeMA3fumlkzYr97Q8g4tA5X5bFkhxbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mw5wPchPnmyUXoRnHRLlpsjaUzFhlfir3Wzkh5Y4UxVogfNjM49WyPRiyj0jbLbhh
	 HhWP16T083s/4w2hGs+fJB9MnP78BMmipbpvKfPTB4PvcYT8hyXLtLtMXNpNIcDVtV
	 k6+lt5eRP3R5MSR6pxH12FUya7y/lAjCEJ9ZSGpiVEfYxjBSQjN+2BJbRHKmvYIcLW
	 pIC4ED7J7wwW1lmy4kD51q3AyaLLi1ZL3HGxzpGEtPaOiduTRTU6DZ4i4/wxk342a3
	 FAOOGGQSuiWWU4LlL+A8toTKiHgMprlei4xKJInW+2x5F3o9ZdKQu/zBpXcCxfs1Ti
	 QCUo9Cpw9I2dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904092136.113321-3-zong.li@sifive.com>
References: <20260904092136.113321-1-zong.li@sifive.com>
 <20260904092136.113321-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:29:21 +0000
Message-Id: <20260904092922.040F51F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
>=20
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904092136.1133=
21-1-zong.li@sifive.com?part=3D2

