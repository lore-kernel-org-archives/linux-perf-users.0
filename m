Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1D320A04
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333608; cv=none; b=htjvIy5/z3CFPX2mIFqGw2F2W7uH3qzTPFzIXwBJ91GCrgtJDwvYq74/dcGnKpJnphwLCRxXzUbdiFEnshW61TUlaL7AsvlSViob9vag7IBBGpWtvIWPCNkw4jNEbwxF/BnNseHc0Ew3woWSG6PeOrdc0B5Ca53mfcnQNkWG/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333608; c=relaxed/simple;
	bh=Th4oNpEign19QBlqYVk6v1Kk/mRq0uDHMyFEWiu/Cs0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eaKvtJs/3PeQkJRhYo1vuteaIO6tCeRXBhmAHDhBfnzoOjDiGHIiE1hKMhQByH958g2gASwKJuvPGuhuxJ3bl5MX8HUdpf+J/EpcIpjjBc0/+J9pTaoAH3zQPL5xqEImKMFeD8IpQ76aw4fxCPelDrFe+xpgGt0IBHX09bWWooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmykP9Jw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmykP9Jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611BB1F000C4;
	Sun, 18 Oct 2026 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792333607;
	bh=Th4oNpEign19QBlqYVk6v1Kk/mRq0uDHMyFEWiu/Cs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lmykP9JwcRg312cz5YfsjYOrtmf+v+Bs/b4H+0We+kSYBoo9O4DYGgz1rtuKDl8C+
	 LV6YKdei+DfXuex20SHo2m5RmSiU5Ppz2NQVhvatHuiLNdBMPWPaPf+/pMRoXvvRz6
	 k1hyQmyaCUoE65GBF+XwebBUMoXyxKDkrWAbpyK2nOCM/IKI86REj8LmDnEXQXld0r
	 RC7GycoLWM4zcQzuLEkOCHeH9cl4eVTK7oggIl7tjI0EU08+ydvY09lj5YSu3vtB2F
	 6xERNGFOYWazjPmQ0W0q1yap9kM86djqfFONwM3FYICzrtVtq7+NYafR/J+nPwEtvK
	 IvOQd7DXlkomw==
Message-ID: <sashiko-outbox-176197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] alpha: use user_stack_pointer() in KSTK_ESP()
 and dump_elf_thread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-3-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
 <20261018-alpha-perf-regs-v3-v3-3-52be85332c57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:26:46 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Both open-code the same PCB lookup.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-alpha-perf=
-regs-v3-v3-0-52be85332c57@gmail.com?part=3D3

