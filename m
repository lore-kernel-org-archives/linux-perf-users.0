Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77B3630A7
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412529; cv=none; b=vDs5Oiru/Ma2sAP46695fm/owjnsRbqgm8keOkphRl9aRNOKyVJ6HSC6tFsxsnG7s1CIzfrwrywkwuUC8M/YuFQ7bh+WmXuokWVoQpNzRICcbByPiejPJxVyK1u2JjRJ+US0wFE5rb+27FJPZ9A89h/d7HShzxqEJFulI92y0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412529; c=relaxed/simple;
	bh=0tWz21MpGonQpEPy2t1XZ6pEbjzklEFWGrZ6ny1LeZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CfNiX8OsxiQv0NS4HGADjiOLni2fpofCVOd++R0TMm+oDMymYW0MlzZCsy8FbhHjbQuIvOr2k1vr1qMAsWbGn/6dbdiMNZF6EP8abeag/NqcI7qXd6ZtcnDKEHyb4S1ntMYDwzM6nVjrqnGE0D9ogoRM/fK+CQ99f70mIQ/4ScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4xhpX9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4xhpX9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2321E1F00893;
	Tue,  2 Jun 2026 15:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412528;
	bh=COQWYRVChh8G/fvlCWj7mAkYUqSg2KabQuudnmCbosM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4xhpX9i0OCVGFqEH/mdpTJCKKxSdcf8JDkd45tILqAhzzCTeFFTMiMei1grg1Lmq
	 WD4/t4JhXrq2eXGEuE4fq4EpmmeoLi6rHnRaktzcOhC8REq8TkszcSU18as+wuImhy
	 Dt6Vg7KdAT3lc+SIvTG2sWoSTp8QQNztHGoLeizBAsSbSFspsCQvJEBBoJ5Ub4CX/Z
	 wuwc+pJ5nfLeP9jtX6GDp7qBOLI8cUt0dO62yjWS2Puqi2054VgxMeJwE90ol7QcMP
	 pRuXG1+YVNdHHB9HgjRfJPavVIqYtMBc2o9H6pzBjiuY8IBnNr6n/TsRgScbE5G516
	 52ofzEzx5FHuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/23] selftests/nolibc: Use a dedicated cross
 cc-option helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-5-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-5-631baf679fe7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:02:07 +0000
Message-Id: <20260602150208.2321E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Renaming `cc-option` to `cross-cc-option` in `Makefile.nolibc` b=
reaks compiler flag probing in `Makefile.include` during cross-builds with =
Clang.
--

commit 2287b14b38d381104f1caab4547ea009ec49cae7
Author: Leo Yan <leo.yan@arm.com>

selftests/nolibc: Use a dedicated cross cc-option helper

This commit renames the nolibc cc-option helper to cross-cc-option to ensure
CLANG_CROSS_FLAGS is used for architecture-specific flag probes. This keeps
cross-build checks explicit and avoids clashing with the common tools helpe=
r.

> diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testi=
ng/selftests/nolibc/Makefile.nolibc
> --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> @@ -23,7 +23,7 @@ include $(srctree)/scripts/subarch.include
>  ARCH =3D $(SUBARCH)
>  endif
> =20
> -cc-option =3D $(call __cc-option, $(CC),$(CLANG_CROSS_FLAGS),$(1),$(2))
> +cross-cc-option =3D $(call __cc-option, $(CC),$(CLANG_CROSS_FLAGS),$(1),=
$(2))

[Severity: Medium]
Does this change break compiler flag probing in Makefile.include during
cross-builds with Clang?

Since cc-option is no longer overridden to include $(CLANG_CROSS_FLAGS) her=
e,
uses of cc-option in Makefile.include will fall back to the generic cc-opti=
on
defined in scripts/Makefile.compiler.

For example, Makefile.include evaluates:

__CFLAGS_STACKPROTECTOR =3D $(call cc-option,-fstack-protector-all) \
    $(call cc-option,-mstack-protector-guard=3Dglobal)

Because CC is left as just clang without any target flags in this context,
the generic cc-option will probe the host compiler instead of the target
compiler. Could this discard valid target flags if the host doesn't support
them, altering test coverage and breaking feature enablement for the nolibc
test suite?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init-v7-0-631baf679fe7@arm.com?part=3D5
