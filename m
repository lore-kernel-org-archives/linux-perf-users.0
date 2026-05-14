Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CA824A3;
	Thu, 14 May 2026 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723709; cv=none; b=suy8R6183ePxV/bfSG5XQ1r3+FrOWSYkRQpp3zhym0jQm2yB7NKZjLVkP3ULUsvj3SeikUQGoaWjVL2bXN76T/rs85kalEoFaz3ixlLce5xWomUTM7PzoEhrZPJ3PzS77x3WgQ7Hj6K1jKt2esIBX9NFMIxTgfkxQ2RyXA3s1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723709; c=relaxed/simple;
	bh=LcNQ99OMkwCl+SeLj818sRc6L7Zfg4+AM0WSBv9W5ME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=do7aDKk+UZIE7xyPSyAv4M8An1+d8WD8B3lFRbNeuyoAMgB31XgtWuCWoBmyuzCEZw2b30v2Gi/tV1iz6+qguiFai6RY104Oi0iiKYdotzbkPRHBpNJt2j2/l9X1/CzVMSCPN03cDUXV3fwfxnt+KbYTLZunGjus5/obkxsX0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ3LEoQP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ3LEoQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E30C19425;
	Thu, 14 May 2026 01:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723709;
	bh=LcNQ99OMkwCl+SeLj818sRc6L7Zfg4+AM0WSBv9W5ME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GZ3LEoQPMbBYTZKVG7l5Xlu6m+gbtGx/dnWqxJTE5aeJmos1INNv9b8QZ/rieAx3x
	 /fNMC7+uNZEssIImKaNV+sp6OkJIOG0Neprs0Pxd9DQMmaYl9sGLeHoO+9FbIqRtvH
	 1f3q9RCN8N34NDzX4BUOVoauLvXrilE2nYVuvFHAY08T7rb12SffXwxF1q3pPpc89Y
	 MXkeimVMtruvtaxzvdyEB070D1w9kyUxA+O1ZfAMnddJ/GdthKTFu2pFrkMP7AYsuw
	 xH3k7wYcwy/nhct81SjuR5OTyq+KXaROdh8mqDWfBG7ce+fU3JCfOx7P3Ljm5+xtAM
	 arQyirGd9AdQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/18] perf build: Move BPF skeleton generation out
 of Makefile.perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260512174638.120445-9-irogers@google.com>
References: <20260512174638.120445-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:55:08 +0000
Message-Id: <20260514015508.E1E30C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `bpf-skel-clean` target does not clean intermediate `.bpf.o` fi=
les generated for benchmark skeletons.
- [Low] The `bpf_skel_deps` variable is defined but never utilized.
--

commit 82e063c8cb877e030e9f5ae7b0984031f34bbb1e
Author: Ian Rogers <irogers@google.com>

perf build: Move BPF skeleton generation out of Makefile.perf

This refactors the BPF skeleton generation to better achieve directory
isolation. It moves the generation infrastructure out of Makefile.perf into=
 a
shared bpf_skel.mak, and adjusts local prerequisites.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 24581941e912e..d4fc10f36781f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf

[ ... ]

>  bpf-skel-clean:
> -	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(S=
KEL_OUT)/vmlinux.h
> +	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKEL_OUT)/*.sk=
el.h $(SKEL_OUT)/vmlinux.h $(OUTPUT)bench/bpf_skel/*.skel.h

Does the bpf-skel-clean target leave behind intermediate .bpf.o files
for the benchmark skeletons?

Since bench_uprobe.bpf.c compilation was moved out of util/bpf_skel/.tmp/
and directly into bench/bpf_skel/.tmp/, it seems the updated clean target
only removes $(SKEL_TMP_OUT) (which resolves to util/bpf_skel/.tmp) and
the .skel.h files. It appears to miss the new .tmp directory in the bench/
tree where Kbuild outputs the intermediate .bpf.o artifacts, which could
leave files on disk after a clean.

I noticed this was addressed in a later commit ("perf build: Encapsulate
vmlinux.h and bpftool in bpf_skel.mak").

[ ... ]

> diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
> new file mode 100644
> index 0000000000000..bcb704d5af32f
> --- /dev/null
> +++ b/tools/perf/bpf_skel.mak

[ ... ]

> +ifeq ($(CONFIG_PERF_BPF_SKEL),y)
> +BPFTOOL :=3D $(SKEL_TOOL_TMP_OUT)/bootstrap/bpftool
> +VMLINUX_H :=3D $(SKEL_TOOL_OUT)/vmlinux.h
> +bpf_skel_deps :=3D $(BPFTOOL) $(VMLINUX_H)

Is bpf_skel_deps used anywhere after being defined?

It looks like the pattern rules duplicate $(BPFTOOL) and $(VMLINUX_H) as
explicit prerequisites instead, leaving bpf_skel_deps unused.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512174638.1204=
45-1-irogers@google.com?part=3D8
