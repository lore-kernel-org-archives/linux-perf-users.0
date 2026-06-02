Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353A360EC6
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413338; cv=none; b=TgYDVJZknrXDaHDncCIfdO/NVelDZmeEhifS3CcoI5Zl50rsMxm82xAxWcRKf5IWyAJBkfAy03/nYk75yMfF2/HyGHo688SgI2PxXzldJEdHVdl3wjqFCSGKgJW2v+RRCidup2H+iu78Bh1e7CwMNoGGXKFCBRYO+vWhFSK75I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413338; c=relaxed/simple;
	bh=33iz1PtJFuuUYzv4x1b4Ls8poJZ3eqM3BZXUVJRD/XM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oysDptjX0JD2b1GE3yPJOWKrCEUnqKT5ZzuHurf+mpS5hNaTvvx94u4/+Z8nNvhjo7f2cujXh9ZlEqMVrbKHw92bHSh7ibR43fVLuotd6swX1Kr4mtROevbN5Bq+dBnDJOduAAfOMHUWXIJMQHXypk4Z8SNcpdtJwUOBi5hDrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GknEHOqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GknEHOqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6001F00893;
	Tue,  2 Jun 2026 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780413336;
	bh=33iz1PtJFuuUYzv4x1b4Ls8poJZ3eqM3BZXUVJRD/XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GknEHOqJmxya6W+RNWaOEk5Z7n3licWSDw6Pni60fV4WilYGOQOpSSzqSx3yuzvZR
	 m/kjDv6AOOVbmuUDXONA29t8+Fujs66JocD1qaBcvS9Cdkrrr+cOuVLZyZjSqjDZH6
	 HKFGrzpoqpu5CFFFBz9LczA5hY6OBNluRWx1e8d9sPsq5i08BE1x6Wv9RjdNcRJBsg
	 jP5iFYfCRIoYEXetwsELuD88XUuDevNM4YqEKI5GGDd/VMW9yHtjTzMnAsZ4sL+7Iy
	 KzdQJBsGVlt9xJzk7rrfDC0WxZfr1K2/dEoq+8zKNm6gyj2zsm0XmVoHrdck1oZ0Mp
	 tvggJE3IByS5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 23/23] selftests: Include tools Makefile.include
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-23-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-23-631baf679fe7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:15:36 +0000
Message-Id: <20260602151536.9C6001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Including `tools/scripts/Makefile.include` inside `tools/testing=
/selftests/lib.mk` breaks normal assignments to `EXTRA_CFLAGS` in selftest =
Makefiles, causing silent loss of compiler flags and test coverage.
--

commit 969534670ab7ca5eb2e61c1ef0a49417bd7e304d
Author: Leo Yan <leo.yan@arm.com>

selftests: Include tools Makefile.include

This commit includes tools/scripts/Makefile.include from selftests/lib.mk
to reuse LLVM cross-build validation and flags. It aims to improve Clang
cross builds by deriving cross-compile options directly from the GCC
cross toolchain.

> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib=
.mk
> index f02cc8a2e4ae3..e2e2d8aa57280 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -1,11 +1,17 @@
[ ... ]
> +selfdir =3D $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
> +top_srcdir =3D $(selfdir)/../../..
> +
> +include $(top_srcdir)/tools/scripts/Makefile.include

[Severity: Medium]
Does including Makefile.include here break EXTRA_CFLAGS assignments in
individual selftest makefiles?

tools/scripts/Makefile.include modifies EXTRA_CFLAGS using the override
directive:

override EXTRA_CFLAGS +=3D $(FLAG_ZERO_INIT)

According to GNU Make semantics, once a variable has been appended using
override, any subsequent normal assignments without override are ignored.

For example, tools/testing/selftests/x86/Makefile attempts to append
flags later:

EXTRA_CFLAGS +=3D -DCAN_BUILD_32

Because of the earlier override, this normal assignment is silently dropped.
Consequently, tests like single_step_syscall.c evaluate #ifdef CAN_BUILD_32
as false in main(), silently skipping 32-bit specific test coverage.

Could this be resolved by either removing the override in Makefile.include
or updating selftest makefiles to also use override for EXTRA_CFLAGS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init-v7-0-631baf679fe7@arm.com?part=3D23
