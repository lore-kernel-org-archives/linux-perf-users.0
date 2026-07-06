Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D242384CFD
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306561; cv=none; b=pb0p1pZiww3nYRG1iSB3BOLJnggnKmmXe0Qglt+Yzt6WchleZH4dbNFBOHBesAocVSNYOn7QvrpCkgP8jwA3rdV0dQCXaiUJJd2KGhixM7j8stpHkt77wXf69c7sBwosmD9EdGY7ZN0LYFf2jLuTNVa2e+zPrE9ZtSW7UaKsotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306561; c=relaxed/simple;
	bh=VhydX7Qgs3lmxFRUm0MEc/MsD8PqBXpndSNdjQyM/EI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M7I9sfjNSoXwQc3ZhvI8aCEsfoV0mnuH8L4d89oY/V0HipbFqapwgcx4yEclZYBpxOHcSVZdhDf82WLtyBsMp25eJItpG8+74OBGJubEGk/yz7uVgO22+BVGwZzndIjQXz5AUEkRVOdEg8VCKc+y7itdCLcW49cHbvNdQ2PURHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fILWDORS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fILWDORS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8384B1F000E9;
	Mon,  6 Jul 2026 02:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783306560;
	bh=OMBvlQVTegh0HUOQXBfoiPsn0X7k8M959/p/dJ1+uaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fILWDORSBhsgSkahNzcMkGmQcFTIsRQdq0o6Jc0Am/OJA+FGGHBhNwiYFsAUqAwuT
	 xJzjSjX7uIcCI2sQIqgUNPCFKwl0GtD9+xJgsw/d2d6CWuY9NrkjOcn5pGZW12+8Um
	 v29Pr1ePO5rnS97OmDRRWL2wfeVZgcpSPQq4krEXqqLJEYLdpngtf6Q9A/JARjfcsB
	 EokqrNB/um0N4LezL2gbYsQTa2P8HeHYq8amvhuzkX1laGGoX/9msMp9Lqu1Dw66zj
	 PFM2I4y0P9dYq6/YxKwdJh7UNUYzlOaG99DDImdGQNmX8aaLCa/BDRpxvUODO9EWqr
	 mQMWinfwjOWXA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 07/10] perf regs: Enable dumping of SIMD registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706023444.3067660-8-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
 <20260706023444.3067660-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:55:58 +0000
Message-Id: <20260706025559.8384B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] SIMD register decoding logic dynamically probes the host kernel,=
 breaking cross-platform and offline analysis of perf.data files.
--

commit 2e9a4421bef9edf42fbc7bb3efd49ba82ff3a75d
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf regs: Enable dumping of SIMD registers

Support dumping of SIMD registers with the new PERF_SAMPLE_REGS_ABI_SIMD
ABI.

Currently, the XMM, YMM, ZMM, OPMASK, eGPRs, and SSP registers on x86
platforms are supported with the PERF_SAMPLE_REGS_ABI_SIMD ABI.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 23f694c3f0c98..5768682dc95fc 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
[ ... ]
> @@ -719,23 +719,96 @@ static int perf_session__check_output_opt(struct pe=
rf_session *session)
[ ... ]
> +	for (reg_c =3D 0; reg_c < 64; reg_c++) {
> +		if (!regs->nr_vectors)
> +			break;
> +		if (intr) {
> +			perf_intr_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> +							       &qwords, /*pred=3D*/false);
> +		} else {
> +			perf_user_simd_reg_class_bitmap_qwords(e_machine, reg_c,
> +							       &qwords, /*pred=3D*/false);
> +		}

[Severity: Medium]
Could this break offline and cross-platform analysis of perf.data files?

The perf_intr_simd_reg_class_bitmap_qwords() function dynamically probes the
host kernel via sys_perf_event_open() to determine the SIMD register length=
s.

If a user analyzes a perf.data file on a different machine lacking support =
for
that specific SIMD ABI (such as a non-x86 architecture or an older kernel),
would the probe fail and return a length of 0, causing the register names to
be printed as "unknown"?

This same pattern appears in tools/perf/util/scripting-engines/trace-event-=
python.c
and tools/perf/util/session.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706023444.3067=
660-1-dapeng1.mi@linux.intel.com?part=3D7
