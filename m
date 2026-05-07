Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922134F275;
	Thu,  7 May 2026 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197800; cv=none; b=cOEb1sJjJYJZACoscpuxd5XU/ka3FnhUctMIkSdfsSKXbYCz/kvk4JUlPfsJHWNpYCiGaBnZqTbk9Boc2jUR7X3TZyexNrCeUEWXf19G689qmnScvVqlbxd3gtyI/o+49wbp+af42yoswqRdfpqtAtaL2Lpji7/0WlK7bSSCuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197800; c=relaxed/simple;
	bh=Fo2mtxWghoqbvmGtAeT3pH7OJ/vZ/XHupeJLM776+LE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ox6IhVetDKinZXflI5xKB8f/xd3ilHXYDvp91I3mTp3/AAhk2owVVq2HFgqpNdKqflVFGt8IiJR2dQS66RHQ8qmURLrzzDLSVuzixudz7ZDKYC50nbR7hjEdhi9YEtwTL+ix+V8t74Hc3cTz7xqscs6qiS4BofI7goP0o/vzQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B69885Lw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B69885Lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC5BC2BCB8;
	Thu,  7 May 2026 23:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197800;
	bh=Fo2mtxWghoqbvmGtAeT3pH7OJ/vZ/XHupeJLM776+LE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B69885Lwm5xzxpL5dkF9v82AShV4NPxfDjbcJGLANOSfLQgCFoth83PfoK7soFMDz
	 hpqrSQ6sXNXInBaxvz186DW0aOCTc+wzDqLTvYhUL3zXLomr//tyWQ8F6NVwOdnBLl
	 IIZGMVDqge80jSG7KbEmomOWFLCZCfNTnrmuUqq6VA+3w41bZoHyIuKXIQj/Bs/wfk
	 kxsvk2a5gomSnCVnwX4RFPp3J6by/Ovfw6zxIQ1CvPyB1CW7vF9ybiqaFEgNFtPrBl
	 JjqKP5qlTu1IDDrxra74sj1980estT1EgA6MkTv5Q5W6jHErsyTRTKYFe+s397uHbr
	 Kkd/02PzHeD5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
Reply-To: sashiko@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
References: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:49:59 +0000
Message-Id: <20260507234959.EEC5BC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Adding `-mcpu=3Dv3` to `CLANG_OPTIONS` forces all BPF skeletons to=
 use the BPF v3 ISA, breaking backward compatibility for perf tools designe=
d to run on older kernels.
--

commit 2e8791aeccf694e1ae9ed9fda46e3a6f73332838
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

perf build: compile BPF skeletons with -mcpu=3Dv3

This commit adds -mcpu=3Dv3 to CLANG_OPTIONS to support the atomic
cmpxchg instruction required by the lock_contention BPF program.
This forces Clang to emit BPF ISA v3 instructions during skeleton
compilation.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index cee19c923c060..a9a8c84b6b006 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf

[ ... ]

> @@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
>  CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
>  endif
> =20
> -CLANG_OPTIONS =3D -Wall
> +CLANG_OPTIONS =3D -Wall -mcpu=3Dv3

Does this change break backward compatibility for other perf tools running
on older kernels?

Since CLANG_OPTIONS is used in the pattern rule for compiling all BPF
skeletons, this forces every BPF program in perf (such as
augmented_raw_syscalls.bpf.c and off_cpu.bpf.c) to target the BPF ISA v3.

Kernels older than 5.1 do not support v3 instructions and will reject
these programs during the verifier load phase.

Should the -mcpu=3Dv3 flag be restricted exclusively to the target that
needs it, perhaps using a target-specific append for lock_contention.bpf.o?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507184238.6528=
0-1-suchitkarunakaran@gmail.com?part=3D2
