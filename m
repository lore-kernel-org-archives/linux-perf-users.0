Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AB3AFAFF
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759066; cv=none; b=BwKMKILStSbWeXojhe0anmO7KCFu+Fz83PF2hkLxaeSpUfwCBtCJCBg46kBJCobKV06y5cx/esCXocI1sxvE8IcpcXfjrFNp/wxw06xvJzAzBl9LslqSA5EkHEIL90K2yhOuk6KmsCwrf8uXDfuccU1EW7MbC0Yq+6x7xxZwwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759066; c=relaxed/simple;
	bh=QV42CCGdo48j5TZNTixvMSFQOS9+1QjWZOV/6PazU2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rThDW5Kd2GpGB4Sr3cKK2sLLXEawdv5nD2MtPlPa/TFH8hB6elgBSa7mj23UMbKRsGw/Qa0eOlo/fX1m/YLcpcQklRSZrWyIp7pJMfPQOEUV0JK0V9fjRSos55YZ4v0kGpKg66uS0J6nB3lWulribVwx/dG0hhfDnT2vJi5x7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTXhLFI+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTXhLFI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33919C2BCB3;
	Thu, 14 May 2026 11:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778759066;
	bh=QV42CCGdo48j5TZNTixvMSFQOS9+1QjWZOV/6PazU2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WTXhLFI+cnYKULgTB2K7Y0PGr+fc9VieOCaGpwRJntfZs1bkVoQKMmg4UCa2qblYF
	 mph/xu51Kl81OTtNbt4k77U+vgtGABHEIJyKm7dJM59KeV7w7DdwnQ6dvJPR0/d/Dm
	 jGh39wG/rvvHAV/bOW7gVDA4mwgtxOdxcb9N7Yunz9axjxyrQqsZOJva7quykXVF24
	 /fdIy0Qu2QPqEO27wl4Y+VXZxeSpyMhjMdxo3M34mEtP+4gDoG8W3JlCQDi9d2yYnZ
	 4G9MSg528GR7UzxWpi2eCoBPe9KEQpveYNenYcdSKCRLSPF9z5F+L0xm6InUTD/uvP
	 0mD4nDcGr0UdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 7.0] perf build: fix "argument list too long" in
 second location
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513234639.128528-1-florian.fainelli@broadcom.com>
References: <20260513234639.128528-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:44:25 +0000
Message-Id: <20260514114426.33919C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The fix for the 'Argument list too long' build error is incomplete.=
 It reduces the shell command length by removing the file list from the 'RM=
' output, but still embeds the full file list via `echo "$^"` within the sh=
ell command executed by Make. This means the build will still fail with the=
 exact same E2BIG error if the number of files increases further or if the =
build directory has a long absolute path.
--

commit 3997e5cf292c966edf5b226f773ec398849158ff
Author: Markus Mayer <mmayer@broadcom.com>

perf build: fix "argument list too long" in second location

This commit addresses an "argument list too long" build error by replacing
the explicit file list in quiet_cmd_rm with a file count. It also moves a
comment about xargs above the rule.

> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index dc5f94862a3bc..dc1df2d57ddc1 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -211,10 +211,10 @@ ifneq ($(strip $(ORPHAN_FILES)),)
> =20
>  # Message for $(call echo-cmd,rm). Generally cleaning files isn't part
>  # of a build step.
> -quiet_cmd_rm  =3D RM      $^
> +quiet_cmd_rm =3D RM      ...$(words $^) orphan file(s)...
> =20
> +# The list of files can be long. Use xargs to prevent issues.
>  prune_orphans: $(ORPHAN_FILES)
> -	# The list of files can be long. Use xargs to prevent issues.
>  	$(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f

Is the fix for the argument list too long error complete here?

When Make executes a recipe containing shell operators (like |), it spawns
/bin/sh -c "<recipe>". The entire recipe string is passed as argv[2] to
the shell, which is subject to the Linux MAX_ARG_STRLEN limit.

By removing $^ from quiet_cmd_rm, this change reduces the size of the
recipe string, which might temporarily drop it below the limit for the
current number of files.

However, echo "$^" | xargs rm -f still embeds the full file list directly
into the shell argument. If the path lengths or file count grow further,
couldn't this still exceed MAX_ARG_STRLEN and break the build?

Would it be more robust to bypass the shell argument limits entirely, for
instance by using Make's $(file ...) function to write the list directly
to a file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513234639.1285=
28-1-florian.fainelli@broadcom.com?part=3D1
