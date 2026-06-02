Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6C34DCC8
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412434; cv=none; b=keFeeXiemyohNyDebVbFNhvj/FZZVj9M9SPBe7BI1v8RX573IzYqTy22eZU7xMGdcAcwo5AZkTubRIneGtHwMDFRQ65AqELKud8Cvb+I/o7lsYlpM0ylVy+AlHK+KQpre+1RG28ei+Apq+hws26teResAiIxjUpWnwqqd33Rd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412434; c=relaxed/simple;
	bh=xKunNtFp6ZUv29I+0HpaAHRo5IWkT1fUDxhcXataI0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RPwJXfrNUHzGLATWUrUIKCq7boNmSJPD/R/+W2Zm7LrbiuuxVw+H4lRgP2XF1n5wZcKJwlwmVoJFXV1s16d2+M63yKxpQXVJlL5g30OYiOTPKOI0HpTu9dZu7vu2cEG6d+0ig1yujFxdZiXkZOZ8U8okuO9eBfQ2eEdimeFge0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTEoBVI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTEoBVI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9E61F00893;
	Tue,  2 Jun 2026 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412433;
	bh=gmO+kQAYjluw7X+f2eOwBMPxrAX9SZQeyYxf9LBWHDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UTEoBVI3rml9nYCNwzJ4oD2cTbhg+Y0620VTx3jaby7Z1YOOgFHuZ7rfhGijdJlJz
	 UgJa5HgxUKrG2EjiDnlCeLp/+2NCjO8VKx8uOTw0BUhvQ/nhfZl6B4GL9zkERZvB7t
	 UDyiE9/7AtVmyXNBTR+2HnCX0/0tw/zuyMe8wyBL2n1WfpPo3T73U6QldOFn2csVCb
	 rEvElZ8Dq5tLn1O+NHJZ+LEGqPTaSavZI4Amv9TfyO0o9Tq37xkgj6Ru3gys7/UYDY
	 RDHL4kTTjEwdnS3Ve9Wj7p9mhZ6qISG9yDZSVpR1eUGqsR/o//7O/llEypIgXXEsMf
	 3DlhC6neaZImg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/23] tools build: Append extra host CFLAGS for
 fixdep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-8-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-8-631baf679fe7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:00:32 +0000
Message-Id: <20260602150032.CE9E61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The link step for `fixdep` replaces `KBUILD_HOSTLDFLAGS` with `HOST=
_CFLAGS`, unintentionally dropping all host linker flags.
--

commit fdc8f23a99f210f1577aab161879510c7af15c47
Author: Leo Yan <leo.yan@arm.com>

tools build: Append extra host CFLAGS for fixdep

This commit introduces a local HOST_CFLAGS variable that combines
KBUILD_HOSTCFLAGS and HOST_EXTRACFLAGS, and passes it to the fixdep build
process to ensure host compiler options are included.

> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 3a5a3808ab2a1..2761f80df7611 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile

[ ... ]

>  $(FIXDEP): $(FIXDEP_IN)
> -	$(QUIET_LINK)$(HOSTCC) $(FIXDEP_IN) $(KBUILD_HOSTLDFLAGS) -o $@
> +	$(QUIET_LINK)$(HOSTCC) $(FIXDEP_IN) $(HOST_CFLAGS) -o $@

[Severity: Low]
Does this unintentionally drop the host linker flags?=20

By replacing KBUILD_HOSTLDFLAGS with HOST_CFLAGS during the link step for
the fixdep executable, we might be missing required linker flags like LFS
options or custom library paths.=20

Should this step retain KBUILD_HOSTLDFLAGS instead of or in addition to
HOST_CFLAGS when generating the binary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init-v7-0-631baf679fe7@arm.com?part=3D8
