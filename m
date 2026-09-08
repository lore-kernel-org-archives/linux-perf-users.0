Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B121429D
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788833441; cv=none; b=nl822VXk6iI7SzI6ipS88Se6e3jgwIjUjflw9fDFWthGT3PRreZG5Y3gXuRGBEhLuMh4C06L5gJsvGL46q/s1mMKH3Xqf6sco2ESds2KZaG2bRjKAwNC8ka98UYgSYsav4uJLOTGecPdcjuq/Hvc/iD14JrN+LN0tf0TxrA1Ssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788833441; c=relaxed/simple;
	bh=jJETLTbXf2RxLrkCoXE3+QMC0/IBFzpojmvIewRY/NA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tji5TGhkAKZl3e6TPEpLvQaIFmDeWZjSXuT6LOeNgDvl4ddjr+BdgVF97aCIL1wMgBGtAaefUVMOk6H5rLqjsN++bsCl+keoto6VqorU9gV6RdRiC/EuKzOWSWgT+UJlaZCH1dlI4vhnjNo/may1T/R/AEJUIrEIhfZ7t/ah7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0F+ZqKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0F+ZqKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AF21F00A3A;
	Tue,  8 Sep 2026 02:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788833440;
	bh=jJETLTbXf2RxLrkCoXE3+QMC0/IBFzpojmvIewRY/NA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0F+ZqKypt8JW/ElDh8ybWG2uMb482fIZhJ0X4YJRT85CJL3Q/gAwIRbMYWV5+BC/
	 k/Tgy1h6grtroRVCuMdi1J1rKg0VLAIHbnkIeYytvLkci4pZ4rGe/2xibpUgW24Mj3
	 dW7CyMX+WGy8XYo1XZKWp/jxdyqShhP3lglrj2BpQ/0m9BWX1+RmsMCQR1Z5095i3K
	 Bc8MEvs7tJl89iebDMpeJJUtrp8sCERBJQSX5Zkxn4VOogjQ7EnKGaV6ZNujQlq12P
	 A6tGEtebfLFErEfLFcDSQX9WFSMSzSIJU9WaI07OYFUQRskd3cttRgy0ADLEPLvHHt
	 7plpTFHarEAJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908020347.1836653-3-zong.li@sifive.com>
References: <20260908020347.1836653-1-zong.li@sifive.com>
 <20260908020347.1836653-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 02:10:39 +0000
Message-Id: <20260908021040.02AF21F00A3A@smtp.kernel.org>
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
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908020347.1836=
653-1-zong.li@sifive.com?part=3D2

