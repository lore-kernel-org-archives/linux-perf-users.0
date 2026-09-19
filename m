Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025E3AE6F7
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780149; cv=none; b=FLpqTRmZdF2EapPaaJjdPD8CwIZYaQgRU6dxuGThQIWTZd9djlm+IanpW+JuQm9p3gXPESnIgneb+9vBFdOzGbnsHjteVM0McA0De9FcRmPJruX48iYYKanyZKLmkXmMXDpHzW3abTgqAVRqDT66TDWjk/Tbw9ASRlffiuVYCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780149; c=relaxed/simple;
	bh=DeWh3H6t7QMW1PoxFD7YZDrmqyurUCHKsuMmDRU9QRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E0lgSIX39tVGdsDy3DSxIyQk6o+Yl4Z/4IrxaVJs+ZGYuWZ8t//T0V0ZMlbo+7iwE13b7gPrLAC9blJm0DRozGNoGF6N2COBf1rzffI3C44oIXejZrRrOPXHM5vleCJL+YTsAOBSGo3xEaKvo/Rgt16NPgXWiivZ+aQfIQcy4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFs0r6Cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFs0r6Cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6829D1F00898;
	Sat, 19 Sep 2026 01:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780136;
	bh=vsjIUboonk46jQW9cWuh0bSLdolJ7s8PvbvmVje8krQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SFs0r6Cl4HRu1dC5ZC18Kh65xdib+rNvJ3NwsSAYibEyh7Nqak/W+ZPFTe36syPjk
	 1vUPfPW0uAIlU0mssiFHFRKyDnbDy5xq6nzyZ6tUYJ19jypVtgVe/g/RY6rpF2wUc9
	 YdpTK6GBVRBvn0vQA/UDMZJ4xidmWxTvoKAYdZoVKuTqOMCxe9/ePz4ZsGV5pDORFZ
	 nOEwMUkbS7QtroQs+Ek+6lReNLImcJ5DIbMpabP3rNnAT7TpRJVTnpspq27n7t3RP5
	 xaTBoHZYRXCvLOozCgFy3me5k1ZW7bdXqk8KddV59DR/ScnYwKu6tKGFmnQCIBtfFx
	 FFmXk8olK0big==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 perf-tools-next 5/7] perf trace beauty: Validate
 payload size in augmented timespec beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919005530.728615-6-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
 <20260919005530.728615-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:08:55 +0000
Message-Id: <20260919010856.6829D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: Silently disables nanosleep augmentation on 64-bit due to BP=
F size mismatch
--

commit d5a8c844e701a29578b91e18d924a25e7e3167e6
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace beauty: Validate payload size in augmented timespec beautifier

This commit introduces bounds checking in the timespec beautifier to prevent
reading past the end of the available buffer if a malformed or truncated
perf.data record is provided.

> diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty=
/timespec.c
> index b14ab72a2738e..84755d8d2c87f 100644
> --- a/tools/perf/trace/beauty/timespec.c
> +++ b/tools/perf/trace/beauty/timespec.c
> @@ -7,15 +7,24 @@
> =20
>  static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_a=
rg *arg, char *bf, size_t size)
>  {
> -	struct timespec *ts =3D (struct timespec *)arg->augmented.args->value;
> +	struct augmented_arg *augmented_arg =3D arg->augmented.args;
> +	struct timespec *ts;
> =20
> +	if (arg->augmented.size < (int)(sizeof(*augmented_arg) + sizeof(*ts)))
> +		return 0;

[Severity: High]
Does this bounds check deterministically fail for the nanosleep syscall on
64-bit platforms?

When tracing the nanosleep syscall using perf trace, the BPF script
sys_enter_nanosleep incorrectly calculates its output length by omitting
sizeof(u64) for the augmented_arg header, outputting exactly 16 bytes.

The bounds check introduced here requires sizeof(*augmented_arg) + sizeof(*=
ts),
which is 24 bytes on 64-bit systems. Since 16 < 24, the check deterministic=
ally
fails and silently returns 0.

This disables the nanosleep augmentation feature on 64-bit systems, falling
back to raw pointer printing instead of showing the timespec structure.

> +
> +	ts =3D (struct timespec *)augmented_arg->value;
>  	return scnprintf(bf, size, "{ .tv_sec: %" PRIu64 ", .tv_nsec: %" PRIu64=
 " }", ts->tv_sec, ts->tv_nsec);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919005530.7286=
15-1-atomlin@atomlin.com?part=3D5
