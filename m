Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7E391E7C
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277776; cv=none; b=ktsAinrQ6ZAvXQsnLOA0sn1SHQ1bshgf8AR0+EYtNyH4+1CE//tDJfrB+bvTZD8CitDPjeGhln8UsWhSKDbwD6rnXTbY0FO5S6QOmW5O9yXPkIV+vs2OrWoRPMZ9GN51OgwYqbe4iPuO8QVAHJv57t3Y4jMSJveJuvv7cKO784k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277776; c=relaxed/simple;
	bh=gfF1XSUW9RYN2guzMzHstFa6A/b5Bv4OiVOfjk9zxPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ppgmW4Y3cdrvW2WEtTA11CYkrFK+VgGYAICi5xZ5tqCD2jmhDzYFVdocVa6H9ZddD6IXGfBzGY3rrpfJCMwZYr1fo0ZQ5wSOpCt56wCGnHcl4UjmQsgwC5XsOpWrpXSd2+641w1e3k5fEOL3YrjX45KgxQYYUsbGL+cAiLE8cOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvuOR/Za; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvuOR/Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FD31F000FF;
	Tue,  6 Oct 2026 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791277771;
	bh=gfF1XSUW9RYN2guzMzHstFa6A/b5Bv4OiVOfjk9zxPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cvuOR/Zam6onQo8T2ISKqexdQIUmHFjEEDdaEdtW+7WhSnqk1Ar9fqcOpc+i5nD5I
	 AMiSnITo3jGZeDOeP0rd9yifnB7ohPN11u71Fo5PEBgxjBzgHQslUeI1Mnmkv7ML4D
	 a160b3+gvIfzE7rn2fLjxramDkt1Mf6W/Z4Z/pNkYKOnqTDyzqx1a+kIX3oBwnBRit
	 /ugoZhnJeFIzjIqY0/5QnT8kBzDMTyz2kZHH7AECLkVK7h+kmMIZOwASU1qAptLzwh
	 RhYQOPZ/u7uO08WX50jbyMAHxI9EkM6EeGuHPuTcmAgOhA1G1MXQ2ZtQw2Myocdi/2
	 AEMJNz+VJnLhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006090327.309550-3-zong.li@sifive.com>
References: <20261006090327.309550-1-zong.li@sifive.com>
 <20261006090327.309550-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 09:09:30 +0000
Message-Id: <20261006090930.F1FD31F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006090327.3095=
50-1-zong.li@sifive.com?part=3D2

