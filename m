Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF140175A68
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411949; cv=none; b=FiQf+jvOHNfkJNm3+HyAkJ6TZiYhJYPYmQWChw9kcMboMY9tEtOr59TFdTNRHwx9vlHWl2KKtesK3/wWIqZr7qw5TaS5AnTfheMmxYucSkXNBRm+oicWaekTn+eo/ruTxdhjmJRyEsugcMksjDkw76jzZmorntoDXpflR0Y6h4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411949; c=relaxed/simple;
	bh=qER5N07CuYQtyRXpVM5gJcLoRBQRKoOCJqUXRvmh4xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EA5aoqn44HubYr+Z09S79J/k0htBo686uX2+oXXnHQ5DlmNMdD14yfycju009mJ0J6NppvR2K/s4XtDOJScF59jPCYUKgWiJZu7hAx+o+f56KMJHZNQ9WOahQ7awCuWbN5uBOqtRY+ppQ3JpjHp99BpMcfpRYSYlKlOuYcdp64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBspNgSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBspNgSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426A91F00893;
	Tue,  2 Jun 2026 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411948;
	bh=pC/E1gD1uNBF6qlxbiHMU/Wd0O04VPnUfZvaozZXkb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBspNgSZAhTiskPR7tSUha5QGXWjdWXXK/jCcVkAvUoIbsBhr9qN3wlIs2opKEpst
	 gzKguhwWvSbjkQ88eAUjytPZ2Q1NopuW9QHxRnskIaJRLqsR2Uyp0gI0OTSLbs5k+y
	 IXyNFEECrA91K7PycQWMu2Oo8Jf+FxIkd+Qsny3SrAm2ySs5w1LoGRC541wHfzj7nB
	 ly0VRTIrkaifDWVU+pCik88/Qo3JLCP/bi8gOocFQALgkY4bblCxNrjUYN5YLZk62L
	 AuvywkkhIDLmDqrFeURbIJjLssNa21hFRSWyQxBskAyZra/+aHlBuSO7L8aZOwuzRn
	 Yc4e/NhDt9QpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/23] tools/thermal: Fix typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-2-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-2-631baf679fe7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:52:26 +0000
Message-Id: <20260602145228.426A91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Fixing the `CFGLAS` typo to `CFLAGS` introduces linker flags (`-Wl,=
-lthermal` and `-Wl,-L.`) into the C compilation phase (`CFLAGS`). This bre=
aks the build under Clang because the unused linker arguments during the `-=
c` compilation step trigger a warning that is turned into a fatal error by =
`-Werror`. Furthermore, these flags are useless because `CFLAGS` is not eve=
n passed to the `$(CC) --shared` link step in these Makefiles.
--

commit 93498abb92499dd9b72fc403e55f192942d97b46
Author: Leo Yan <leo.yan@arm.com>

tools/thermal: Fix typo

This commit fixes a typo in the tools/thermal/lib/Makefile, changing CFGLAS
to CFLAGS for the thermal library linker flags.

> diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
> --- a/tools/thermal/lib/Makefile
> +++ b/tools/thermal/lib/Makefile
> @@ -60,8 +60,8 @@ override CFLAGS +=3D $(EXTRA_WARNINGS)
>  override CFLAGS +=3D -Werror -Wall
>  override CFLAGS +=3D -fPIC
>  override CFLAGS +=3D $(INCLUDES)
> -override CFGLAS +=3D -Wl,-L.
> -override CFGLAS +=3D -Wl,-lthermal
> +override CFLAGS +=3D -Wl,-L.
> +override CFLAGS +=3D -Wl,-lthermal

[Severity: Low]
Does adding these linker flags into the C compilation phase break the build
when compiling with Clang?

Since the Makefile also specifies -Werror, passing -Wl,-lthermal and -Wl,-L.
during the C compilation step might trigger a fatal unused argument warning
under Clang.=20

Are these linker flags actually needed in CFLAGS, or should they be added to
LDFLAGS instead, considering CFLAGS doesn't appear to be passed to the shar=
ed
link step?

Also, does the prior commit in this series introduce this same behavior in
tools/lib/thermal/Makefile by fixing an identical typo?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init-v7-0-631baf679fe7@arm.com?part=3D2
