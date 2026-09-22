Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE66477991
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060076; cv=none; b=IH2f7vD3f2lV75PgeNG9hmxqi4+ZX5xZiyewT6ryBOU8Rl9uRxV2ctfNOiV2ZRp/ukWFHkoqQSjTjmSrVGYOVK6u6iSzt8+hw/HObdO1ByFxw8fMZzpPzx3MbZSqXfrqbm6lFWbvoECav4KRTzM09J+AG9UoxkxONlnuE6yI0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060076; c=relaxed/simple;
	bh=F9twVgDdR1d/MZIlZKvNOSS+qGN9o2jzryIwEyafe4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VB52LLFm7r137q6U2m1IoQzajjJ8CB9r3CNJTuQphrEsVJkBiCW3LdCXSNkQLl6MIUGv1f+KeH9WG/pEenhBYAT1U9uWTB001f9otICNS1V9kRvSstk+3U0OmmU+C5Hg2yO4QHmnrKY0BrQCVZuUQMIRYgt61HrogR4oITYMjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuY53IWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuY53IWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43BB1F000FF;
	Tue, 22 Sep 2026 06:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790060070;
	bh=F9twVgDdR1d/MZIlZKvNOSS+qGN9o2jzryIwEyafe4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UuY53IWrpynD2Mpaim0OwS5z2tErG+w19Lzd/yR9daw6Y3vT5KOXCgRbIzYjQsFJH
	 wglnXiseczKh3RJJJRQMNsdffkqFghR+SwDPV2dnrMwn+EXlcQjqX3P287Y0zT8PZ3
	 VqEUM0FxLs21aDt/+rSbP5uGlgFJK2W7tLX7HXyBMEuGPa/H8/v1H6ENE4ccSVYvEQ
	 lUThQCkbMnWVDL9bASj51k5tRU8QI6Qrtnt0uuvLcwm/IvmNj2JuBrJEGyvK75eZs6
	 Nr2FNdlza/2amkuIsS/ygQUr2agIt/envHCHB17svjUd2ERWjhQG9f5j9dnzEPImAQ
	 1sqzEYX+niaJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 sched.h header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Huth" <thuth@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922064641.61120-1-thuth@redhat.com>
References: <20260922064641.61120-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:54:29 +0000
Message-Id: <20260922065429.E43BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> While the GCC and Clang compilers already define __ASSEMBLER__ auto-
> matically when compiling assembly code, __ASSEMBLY__ is a macro that
> only gets defined by the Makefiles in the kernel. This can be very
> confusing when switching between userspace and kernelspace coding, or
> when dealing with uapi headers that rather should use __ASSEMBLER__
> instead. Let's standardize now on the __ASSEMBLER__ macro to avoid
> this confusion.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922064641.6112=
0-1-thuth@redhat.com?part=3D1

