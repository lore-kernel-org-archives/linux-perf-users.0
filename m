Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0633BBAF
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376726; cv=none; b=oKdt2fEYj2omcO3TUMBXuyU0FJ/JrlWKBdOXaeamr2ZrJZZznNvlwI1biPhh9hz+fZO6Yrn8LMviyVIPjimlJgHFNAJx5DaMZ79sK+Nd+CZCK8QHSjnL/oCnpsGW+h0eyX/PVdMvY/6Oba5nPW87M8L98jMWezoROkJ6eEQE3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376726; c=relaxed/simple;
	bh=4WuUfTAAO6unFgqNSdtCrmv5a8N0DmIqH34297zNqmY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ak5UpW9pFjWcDKobV6OJiDzgMTuYLe0h/Gl3wuSARj/0s9sF8VWdX7Qd3osd3ohLw2YWX+j4aLZQoo30CukZ2q9Czw4LH38iMFUCsXSGdDQOwnnWFHwy2Kzxj2JAU3kXNT6kTWxixrP5yYhdyV4k2ZblCfxIul16u8vfKGcQfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avW3Yfl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avW3Yfl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CBB1F000E9;
	Thu, 21 May 2026 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376724;
	bh=ziJOSZ/A7lfn6XyK8REJfVDPt3I2fS15sXbeAmi9MFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avW3Yfl7SpAScqAaR+W6GJ8guENeLftQkWdmX1nEfYlIvACVJ5m2VeDV+5FV27x++
	 iHF4WljdMkbzGNvXBXb9TruaDzXMBXq0advhXNNaTJe80DAE+fvhed+V4jFgJh9Xpr
	 DOa5g6lYa2i0CCN7/oZMigyX84Qs+L0Y0PtOWTfp985ezbFzVdUAX5/TIZfoOe3v3w
	 En4cpR5H1lhiZelhH8LTFTfKca9Qze4nsqTjGRBcVPcfSxJe3/sczxBX7KNpn4VTpZ
	 SmdQPM1vPLEbO5cJmRKg4AIP/thYOJdWEovaRWYjbe37tKfLyL89D20od52idY2DYk
	 zNCHIjECf3oXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf tools: Put Python bytecode in output directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Hutchings" <benh@debian.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ag8YQmHiaFc8Hpb-@decadent.org.uk>
References: <ag8YQmHiaFc8Hpb-@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:18:44 +0000
Message-Id: <20260521151844.B5CBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The use of `PYTHONPYCACHEPREFIX` fails to resolve out-of-tree bu=
ild pollution for Python 3.6 and 3.7.
- [Low] The newly configured relocated Python bytecode cache directory (`$(=
OUTPUT)/__pycache__`) is not removed during `make clean` or `make python-cl=
ean`.
--

commit 7f6b9146d44a693c3114eaae7826841344f49ebd
Author: Ben Hutchings <benh@debian.org>

perf tools: Put Python bytecode in output directory

This commit sets PYTHONPYCACHEPREFIX during perf tool builds when an output
directory is specified. This aims to prevent Python from writing bytecode
into the source tree during out-of-tree builds.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -399,6 +399,11 @@ PYTHON_EXTBUILD_LIB :=3D $(PYTHON_EXTBUILD)lib/
>  PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
>  export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> =20
> +# Put Python bytecode in output directory
> +ifdef OUTPUT
> +export PYTHONPYCACHEPREFIX :=3D $(OUTPUT)/__pycache__

[Severity: Medium]
Since the perf build system explicitly supports Python 3.6 and 3.7, does
setting PYTHONPYCACHEPREFIX resolve the out-of-tree build pollution for
those versions?

This environment variable was introduced in Python 3.8 and is silently
ignored in earlier versions. Would exporting PYTHONDONTWRITEBYTECODE=3D1 be=
 a
more universally supported alternative?

> +endif
> +
>  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so

[Severity: Low]
Does the newly configured relocated Python bytecode cache directory need to
be explicitly removed in the python-clean target?

The existing clean rules do not match the deep absolute paths created by
PYTHONPYCACHEPREFIX, which leaves the entire __pycache__ directory hierarchy
orphaned in the build output after a make clean.

>  # Use the detected configuration

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ag8X7gcDw6jpJsLq@de=
cadent.org.uk?part=3D3
