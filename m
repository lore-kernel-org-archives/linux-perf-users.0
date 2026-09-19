Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BE3AAF63
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780119; cv=none; b=l2FtgRelzcVM6POtKD4GHlM2iyolG2lSlf2F6duQ0pmzUrKB3soYMIxKksOiu61AP7SgyK2zapDxQs8NlqYYo9hj+I6PnZJZLmO9krfwb0U678XUbG2LAg1hL2X2LYlAl/vdgkWPNlr4WVmoyWYWIB6S9bV6VsuMsBXMlhlqWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780119; c=relaxed/simple;
	bh=KuM9hSGC3TA54vioYK7Jwt7ez1Styowhlu5YCm5F8b0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b9zxBsPpbg32JEEPAIOlhiZzfDEEQoH8Xj3Fu/+X/X0zIP3vi5HWRqtB0ImxupRIWjVHVfPj6Hp1/WCgonyS6NLKpJj0swdP6QQa7QMehxAcuH44yvGlEcZh4KVEgM3NtAQK1ggyfGZMmpBp1Q5Ketg464laV++bejBdX9P+HMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZWkJWqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZWkJWqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4CF1F000FF;
	Sat, 19 Sep 2026 01:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780104;
	bh=girRsS0+GmNIoz20sEShnFopkDUnUutqAMy2aWVrlxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZWkJWqtxggHRPpHxKavz1rgWIrnSEVcb2dbZgjB2gvCCLS5YVK4QQBQax5RWVFn/
	 qyUyoj7qWp/gGUD1Bj31RIEKg/6QTPALukDNSP7GNnnzJ9aQTZo8d2HpebT4Oo9w19
	 j7cF/PZwp7HYsfskMXjlM4FlgFIRZPODIjBn2EbRTsL/WCGPyJKeDfEtK3yF+SaZZb
	 0V/5aZ10dwvn61d1uhlN3GtHftHDSyzxxjNNL7U9V4ATBjM/iDzqwB6H+aC276bQiy
	 KMLjt9phtyhgT1nJLG0bJ+lbONR7F6V9tkVoSc3t3oCJpWOJ08ndW33aCiPUyMSI7I
	 uy7BimXc5NKUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 perf-tools-next 2/7] perf trace: Validate payload
 bounds in augmented string beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919005530.728615-3-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
 <20260919005530.728615-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:08:23 +0000
Message-Id: <20260919010824.2F4CF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: parser desynchronization on empty augmented string
--

commit c657a00bfdd12e1a3584bb0cd84d1c32e885c3a9
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Validate payload bounds in augmented string beautifier

This commit adds bounds checking for augmented string sizes in perf trace
to prevent out-of-bounds reads and integer overflows when parsing malformed
perf.data records. If validation fails, it falls back to raw pointer printi=
ng.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 20fffc24507b5..91461ab927b63 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1898,12 +1898,21 @@ static void thread__set_filename_pos(struct threa=
d *thread, const char *bf,
>  static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg=
 *arg, char *bf, size_t size)
>  {
>  	struct augmented_arg *augmented_arg =3D arg->augmented.args;
> -	size_t printed =3D scnprintf(bf, size, "\"%.*s\"", augmented_arg->size,=
 augmented_arg->value);
> +	size_t printed;
> +	int consumed;
> +
> +	if (arg->augmented.size < (int)sizeof(*augmented_arg))
> +		return 0;
> +
> +	if (augmented_arg->size <=3D 0 || augmented_arg->size > arg->augmented.=
size - (int)sizeof(*augmented_arg))
> +		return 0;

[Severity: Medium]
When a BPF program pushes an empty augmented string record (e.g., size <=3D=
 0
due to a read failure like -EFAULT), does returning early here cause the
payload parser to desynchronize?

By returning 0 without consuming the header (sizeof(*augmented_arg)) and
advancing the parsing pointer arg->augmented.args, it seems this might corr=
upt
the formatting of subsequent augmented arguments in multi-argument syscalls
(like link), displaying them as raw pointers because the pointer is left at
the wrong offset.

Should the header be consumed even when the size is empty or invalid to
maintain parser synchronization?

> +
> +	printed =3D scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmen=
ted_arg->value);
>  	/*
>  	 * So that the next arg with a payload can consume its augmented arg, i=
.e. for rename* syscalls
>  	 * we would have two strings, each prefixed by its size.
>  	 */
> -	int consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
> +	consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
> =20
>  	arg->augmented.args =3D ((void *)arg->augmented.args) + consumed;
>  	arg->augmented.size -=3D consumed;
> =20
>  	return printed;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919005530.7286=
15-1-atomlin@atomlin.com?part=3D2
