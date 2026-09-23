Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79633EDAA2
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148173; cv=none; b=ZMl37plPrOhwLZz7gf/ZtfnHtYYV9YJ84qlynXVhmF0G9KvDep7XMDO/Nf7s2FOqYMcqUtLzU/iQh4u5PHcG/gTOInJ+2zHzk+m8cNFzGNBu/mCgpZ/QQIsYRQ84X2qRybSS2qAjOysoZVMeNC1A0FHSetp8dHAEY2Bm9GQ/9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148173; c=relaxed/simple;
	bh=29dvKUd7rcBWZldP18gm0vRYCYOtEu6/fYe3ZUSyDJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TeZN3vi0htbRz+5Fl0rtU3t/RewXBEve4r/w8frM7+wHeVX/nm9SBat5PPZ8w4SUPIlOo2BXfkvs0o7KInb8FRepEQkG5kazHqGBa9c4yLMO6xfAV9Kzo9Re6X8wMwJUvvF/qs4s90O2AX9qU8l4RMb29SccGfVKIZkrFQGRgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4spvZCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4spvZCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E673A1F00893;
	Wed, 23 Sep 2026 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148171;
	bh=p0JmTmxPy+xoDaOhXAS/2uM3Gko0lBJntAFvlRiFWTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4spvZCngLP2CLBxuqa98wjT6eM3+c/ItrookPnH+UcCh2PcbGHcv6rlZAXXx2aUW
	 /w9l0mZoF4/a72oUrcO+GX2e2S/ppmZWxXSujx6FS3qKSMFH/LuStMY7KCOOz3IR5p
	 LC864Nle+10xyeg7RCptr7e7YeqExmQVaEKCKXaS9xChGn/s/kaOFqGpxjU8px7Tjd
	 bwxh5RByS7C/lx1JQUfWT+qvqpWJmt8PFerM8MiZ20xNctd2DZtWgnJUqXuaRnALuH
	 0s2MwmiPHoJSfvdFQzESYKEa9sjquwcIflR4qziURsB+ZTuIStjR79v0SuLfGAjnRD
	 8m+cqNPxK5p0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/23] perf trace: Bound the fixed size augmented
 argument beautifiers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8a2a96e2f9c8511fa5f162682acac29807243972.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <8a2a96e2f9c8511fa5f162682acac29807243972.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:22:50 +0000
Message-Id: <20260923072250.E673A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The timespec, sockaddr and perf_event_attr beautifiers read a fixed
> sized type out of the augmented payload without checking that one is
> there. The payload is only as long as the augmenter made it, which for
> a sockaddr is the addrlen the tracee passed and so can be as little as
> two bytes, and which for a perf_event_attr is the attr size the tracee
> chose.
>=20
> Gate each of them on syscall_arg__augmented_args_valid() with the size
> it needs before its first read, so that a payload too short for the
> type leaves the raw pointer printed instead, as happens when there is no
> augmented data at all.
>=20
> Two reads that are unbounded for reasons other than the header go with
> them:
>=20
>   - perf_event_attr__fprintf() always reads a whole struct
>     perf_event_attr, so an attr from an older version is read past its
>     end. Copy the payload into a zero padded local instead of reading it
>     in place, which also replaces the local copy that was only made to
>     fix up a zero size field.
>=20
>   - af_local__scnprintf() prints sun_path as a plain string, but the
>     payload holds only addrlen bytes and the path need not be NUL
>     terminated. Pass the payload length to the address family printers
>     so the path is printed with a bound, and so that the AF_INET and
>     AF_INET6 printers do not read a sockaddr_in or sockaddr_in6 out of
>     a payload too short to hold one.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D9

