Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500918AE2;
	Thu, 14 May 2026 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778729978; cv=none; b=SBPYnQ4rr2TJPQv0VXPO+KAVaiz7+imwvZqLMJa2++XtZ9ATVSm+GMFRWcmSy/eepN1x1e9QCJTSbmO9mtl/fULv05YZxRxJPRZ6W0kcw/ysLCl6t4FJTv1ge6SAAzpZNjkz0l5Hm0sUMGZPWpXS4iXz3bELR4/FmBmku+fRTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778729978; c=relaxed/simple;
	bh=ZnXemmqxp6zju2OGSU5Syb/Vo+jYqVFulldkYMNbx+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EZ4wgl6I52nLUnr9/M0OJsAsn9TgrmtGFz9acl93ZJ9ejdOx2rCCUbbsO0IrB4HrAJNhy4G4vw1a6JKZAdCre2qfHx1Tuw/hIH2e3iJ9DPC7vMVGgMuPV31YIlMU5MvDFuq500d/49fhLum/IzWmYw6FhpHMavekrRGQSsVpx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEKn5gwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEKn5gwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16024C19425;
	Thu, 14 May 2026 03:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778729978;
	bh=ZnXemmqxp6zju2OGSU5Syb/Vo+jYqVFulldkYMNbx+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HEKn5gwNpYfa8gI83EzqEjubRMtM4h4ydW157iPDEn613+YNMkk1Hd53jAn5dbNM8
	 CE3W1dUQUIcpx0/QKb2VrjmwHXrjjWIf7vbChJKo9xcIg8zfyigCtJ1sCivdE8XMsh
	 1RJlldqB0ykMdSlzvBAbu4r4lJ0XOg6vukf72EEaMpbw9e4KPl7exSJ1lLZ+qabTjY
	 BCHWUhn0PMAh1tmuUJUpUS8SJMu3duVxJ/t5UthHHE+O9F8sckXuoc4AXM0L+9eXas
	 qUdxBp+54yQwIxgmNSENZPNjD4miYim/bAijuA9iaPhWmEdl5HUOedbBAHfnulkP+e
	 gSQHo6rsRAM8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/18] perf build: Pre-generate BPF skeleton tooling
 during umbrella prepare phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512174638.120445-12-irogers@google.com>
References: <20260512174638.120445-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 03:39:37 +0000
Message-Id: <20260514033938.16024C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new `bpf-skel-prepare` target in `Makefile.perf` is a pseudo-ta=
rget but is missing a `.PHONY` declaration.
--

commit 13c9711193709348ce5b064c3bbf8b66453f9cb5
Author: Ian Rogers <irogers@google.com>

perf build: Pre-generate BPF skeleton tooling during umbrella prepare phase

This commit decouples early skeleton tooling generation by attaching a
bpf-skel-prepare target to the umbrella prepare phase. This allows Make to
compile bpftool and dump vmlinux.h in the background at build startup.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5af767415c113..df68d29ecab73 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
[ ... ]
> @@ -629,8 +629,12 @@ endif
>  __build-dir =3D $(subst $(OUTPUT),,$(dir $@))
>  build-dir   =3D $(or $(__build-dir),.)
> =20
> +bpf-skel-prepare:
> +	$(Q)$(MAKE) -f bpf_skel.mak bpf-skel-prepare

Should bpf-skel-prepare be marked as .PHONY in Makefile.perf?

Without a .PHONY declaration, if a file or directory named bpf-skel-prepare
accidentally exists in the build directory, Make will consider the target
up-to-date and silently skip it.

While bpf-skel-prepare is marked .PHONY inside bpf_skel.mak, the top-level
Makefile.perf evaluates the target first before the child make is invoked.

> +
>  prepare: $(OUTPUT)PERF-VERSION-FILE \
>  	arm64-sysreg-defs \
> +	bpf-skel-prepare \
>  	$(LIBAPI) \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512174638.1204=
45-1-irogers@google.com?part=3D11
