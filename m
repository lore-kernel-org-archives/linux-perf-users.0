Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26810388375
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153907; cv=none; b=S71ad9CwgqWjcAiFvyjUA0kaUo92OSBPvL0X3fqDo8VmNTMoaNW3cKhexzV2EgDSOvegldj0Qhf3RMFdn8i0mA2Qaa08amZmH1B8ssR9DLZA98Iqz1YYI89QslW4xH3SNQ4i/2jUfCfMwdoMj20VkG1hH6XiKQTekHy2yisp0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153907; c=relaxed/simple;
	bh=rOMflVy9w+8tVthcS9SZxV8fKeRlWpTIpaplVw5GGdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHNZRxPOSuixMVpJU80C2WOHZjPhqJISp1ftT2JloWbbl1HphU/6+xd1NyLXlrdfPltz/y/zBt+X02RY+/b7F4cDmPruv1A7ACsVb9GnnAaGuGcFHpRxlLPHhBUb2YU8W4qwB+8uBhyMXg+81zb+Gz8VM3FvtmYPUXkQCHr/MLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPU5OUlI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPU5OUlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA33C19425;
	Tue, 14 Apr 2026 08:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776153906;
	bh=rOMflVy9w+8tVthcS9SZxV8fKeRlWpTIpaplVw5GGdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SPU5OUlIstncUVV2XyizN1Pv2kN4vWhmyvGnUkM+syrkquFvlyH66qwHtNYLD1Kb7
	 CAyXVKYycZgNR+8lsRRtRQ7tkHwYT+hJSFKxDKRUON0D97yXv3W5wrcHJX6Z72M6eq
	 Tg+TWxEnBNgqC+xO7oiIiMJdFCatY6iFZxSkFlvRc9wpOBabC6v15xP06vG/1HnXot
	 3AgKjsnXNgJZG3hu+ynEsEtIzOv2sMQ26esjZAsXQk/MR0HPiG4hhNbCSmm/wmA4aG
	 3rkf/m/QSHQVB5BA+f+CNetq6v7Gr4lmja2ZM/MZOrzu+d8zg2xO9i4p/MNz8keD8h
	 31Mh8ipPMH1gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libperf: fix parallel build race with header install
Reply-To: sashiko@lists.linux.dev
To: "Gaurav Sharma" <sgaurav00719@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414071242.95637-1-mgsharm@amazon.com>
References: <20260414071242.95637-1-mgsharm@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 08:05:06 +0000
Message-Id: <20260414080506.9CA33C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The patch breaks standalone compilation of `libperf` for unprivi=
leged users and improperly pollutes the host filesystem for root users.
--

commit 208fe5b88e547b876734f4625a046aecb0847770
Author: Gaurav Sharma <sgaurav00719@gmail.com>

libperf: fix parallel build race with header install

This commit attempts to fix a race condition between the install_headers
and libperf.a targets when building with high parallelism. It does this
by making the libperf compilation target depend on install_headers.

> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
[ ... ]
> @@ -99,7 +99,7 @@ $(LIBAPI)-clean:
>  	$(call QUIET_CLEAN, libapi)
>  	$(Q)$(MAKE) -C $(LIB_DIR) O=3D$(OUTPUT) clean >/dev/null
> =20
> -$(LIBPERF_IN): FORCE
> +$(LIBPERF_IN): install_headers FORCE
>  	$(Q)$(MAKE) $(build)=3Dlibperf

Does this break standalone compilation of libperf for unprivileged users?

In a standalone build (e.g., make -C tools/lib/perf), variables like DESTDIR
and prefix default to empty strings. Because of this, it appears that
INSTALL_HDRS_PFX will evaluate to the absolute path /include/perf.

Won't forcing a standard compilation to execute system-level installation
steps abort the build with a 'Permission denied' error for unprivileged
users? For root users, will this unexpectedly write to /include/perf and
pollute the host's root filesystem outside of an explicit make install phas=
e?

Would it be better to serialize the install_headers and compilation targets
in the caller (tools/perf/Makefile.perf) rather than within the library's
local build rules?

Serializing these targets in Makefile.perf would also resolve identical
pre-existing parallel build races in libapi, libbpf, libsubcmd, and
libsymbol which are not covered by this change.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414071242.9563=
7-1-mgsharm@amazon.com?part=3D1
