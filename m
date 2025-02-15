Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1319E7ED;
	Sat, 15 Feb 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739614417; cv=none; b=jzZYjinmUOlG1WW7XzEWWaKAvo/VF4T046bDemMtvE6vBsTbBt8GYzttOUXjKEsZ/7PdjX7QBRSgCIS7w+cLV2VngIK5/q7ZZhtv2cmFdz6FB9CnDKr7AW/EPbtgSej9xvmDiu4a95q5dASTSmJtxDY7D9EUMtsJrPPkDWvwj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739614417; c=relaxed/simple;
	bh=nx2PoXHsvS/XVR8uJBkBCEecgQMqraMnp2Xv51E+fsc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FlC6zMDv/qeoKCXYVJBR1LhsSdnAYUw8gJQLSFDhFJKcidoZB63B0W7BthpNsO/4Zv1u+KUm7XDXQfwhB156DaiCniXSAcOnWPGtTjiO3UPcop/ewiN9s1dkgC7bqwzsK39m/nQqGoL1WnbJys/XELp+/lZ5queG+vfR/T31Bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=HB64S2On; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HB64S2On"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51FACZA8072435
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 15 Feb 2025 02:12:36 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51FACZA8072435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025011701; t=1739614357;
	bh=nx2PoXHsvS/XVR8uJBkBCEecgQMqraMnp2Xv51E+fsc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HB64S2OnDCnHJCIOjYmyUwbzasS2j8r8/OdLWABpVAysVT0YdaUahvaCoscAHzQjs
	 OgPOlRIcH1AFqVX/MaJllQHo/VAK+EZt0OkUly03NeDh0deW2raXYjYlwr+bPKt8wr
	 lhciD6koXeIgYvQzlVich/BOJprcwhlDgw0necXj6GZ5XJT/fZW0UsYWQoIsSXR9HI
	 KIdGxiX2VdIxeeOG9mf2c631oLYcAVsQ9LZjVSkbjwLaJY3EuTnopdbQUOK8lPsMSC
	 z0+oLovjz8+0j8QO2MJMnWT6A+7TyXpdvMGBzOaXI8nXRISZi/OyCo70NwOroIjolh
	 9SgByjdeyC9yQ==
Date: Sat, 15 Feb 2025 02:12:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, "Xin Li (Intel)" <xin@zytor.com>
CC: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, will@kernel.org, peterz@infradead.org,
        yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com,
        nik.borisov@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/5=5D_x86/cpufeatures=3A_A?=
 =?US-ASCII?Q?dd_=7Brequired=2Cdisabled=7D_feature_configs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250214215823.GEZ6-8f5wt--IWggtl@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com> <20250106070727.3211006-2-xin@zytor.com> <20250214215823.GEZ6-8f5wt--IWggtl@fat_crate.local>
Message-ID: <469D0BEE-76D6-4417-B5B0-0054D3F96784@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

CX8 is the name of the CPUID flag, for better or worse=2E=20

It seems to me to be a bit silly to have dummy symbols that mean literally=
 the same thing, but =2E=2E=2E
