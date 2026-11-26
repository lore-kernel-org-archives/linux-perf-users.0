Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682125;
	b=VwcgRE1bqdChz6zNRyK7pbude6i1FmB0UN6ERchcSYNrCKO5pjSVzToEmBFgRSWd7R/r
	 XMgqun/dE26Ic7SPi0iD/i3RR+a+c2UT/k0dzySN4hkK10WHZ2KljuwjdnDrP5AAF4g4K
	 Jz480JrST2nT9g1GMCtzpCZS8T5l77QITg8wYf733KW4DjZlyY11o0v+ZO3UgF2Rn6v4I
	 AK7a4pFrR8LZGHPqOjVGIbeAOFEZYEBA39Wmxrh5HHCZ4+c7tEEkgbULbviaWs0OkwpJQ
	 h2oeckjx3NZAUlpcXBjYKezew19a9c6omfFQ1PhphdY6t8kcJynS0E5IiYHloVi2XWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wju/ZY29mXlpytj+HDutRVcQ7b8HOQHzo0p6Lx4yc28=;
	b=qnrKuF3Uc50mfECr1kc/WnxdjsS47cRK1AVi6dS7Wtq6c6jZTAws8vy1vUOHXKrN55jH
	 cXpkUssR4yJ2ytXt3adXLpnSt1pfST7XYcYaefMJSUKBgEmNF1hVUnMFLDbm/11fxc4Vu
	 3uqVWYoXOFq/BYXyix5uAozLBm6+t/O5DsZDjbG8ptnP+B8cs+p9DSF8IWyTCioGrTF5m
	 tl1cTE8Vrwyjx32OvgexC56KzyT2mOq4BSBrEMkgOrlFCommdj0Mr8rKnaBbk2/vohpLA
	 4DTR92pBia06yWsOz5u/p81KBPTZwe/23o1EK9t+FcKF6GSohbWvN2+dJcS4HOjvsfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isKhUmNn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB70606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isKhUmNn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001A21F000C4;
	Thu, 26 Nov 2026 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795682125;
	bh=wju/ZY29mXlpytj+HDutRVcQ7b8HOQHzo0p6Lx4yc28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=isKhUmNn8YeRXwdaqqI/0TX7O3x64+GanRzxFlriZDcjXDg2vK8vGTXgIcqaqSevA
	 haULB36Ys4LRe9yrlzuPEeLs4A8wjS5ujqUrFovp4mT6yxV8cKNPf/xaEfbtstoIYH
	 idMyLQC64EKv7T2BMnN/yq2Tj1z7bpoOD1yDmuvM5hDQImGNT8Mf4XYpFXhTLCxsvi
	 +nm3IlnYSBEt2SkGT4h19dZrDgcuee9Jcj/sNcPAAcXwkv5CLT9eyeBZmeIXIb91LL
	 F2K5L4HrRgrTVhn/YbRp9kAdnClNP7CNN8pT8OfTD0V9Q+xvtqqgrVAqwYDXkoDFYm
	 8oT5RA5XDLUPA==
Message-ID: <sashiko-outbox-235039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: qcom_l3_pmu: Remove CPU hotplug instances on
 probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261126-a35bb25eb5-u21-0@mail.sdu.edu.cn>
References: <20261126-a35bb25eb5-u21-0@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:35:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> If perf PMU registration fails after CPU hotplug setup, the hotplug
> callbacks retain a pointer to freed device data. A completed probe also
> lacks a corresponding removal path.
>=20
> Remove the hotplug instance on failure and detach it before
> unregistering the PMU on removal.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: 3071f13d75f6 ("perf: qcom: Add L3 cache PMU driver")
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-a35bb25eb5=
-u21-0@mail.sdu.edu.cn?part=3D1
