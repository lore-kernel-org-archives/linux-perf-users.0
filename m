Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3634191F94
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213830; cv=none; b=mDlZ6zHs/Fkl9LmbN2QN+MSAJXlDM0eSJYdX/6GbSoaP6C46qlQKsgjJ+Sjnl0pyLFe5XcfWIc304sjGjFztZazIvnA1Fu4oOJrDCCzTP7AkrUr+Elxnj5SKambDJHOYuQNthke4atS+m0jz4n/tBJxetCAKZcbbBqFIqCvS/Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213830; c=relaxed/simple;
	bh=pPilg+us5+irgzMz6/xUfyiVf9QxVlVTPj2Yir/8oT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JZHEJBwdkS1ml6nHHjvIit8FwDLbCXRksXQYwN9E9Kx6VdEjyxUob3yRNC8y6Knuqd8kjMKuxKt/d5N9SlGIFW8dU+IZ0NkHJGljaOvDQw0oTFrHMRaXPtaS0O0V4wcE5d2Ide2+7V5f4i9ld5sDLRwy4tTnwX7edOH65BjpDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVNfeprw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVNfeprw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA865C2BCB3;
	Tue, 19 May 2026 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779213830;
	bh=pPilg+us5+irgzMz6/xUfyiVf9QxVlVTPj2Yir/8oT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RVNfeprwjuvpDXpjfDn8a7tVGvyxNqkIHKnfQp0V5+/bOqkksBqP7Pjrcvk3w0Exo
	 SbpXPslhiYjohJO7/laLuy51JXwhMFPFVmfrJMSmONe5kxYTWK5LE8UukTQGvWZ+j1
	 lSgb5H0n6XljhqqpgpExSyK0q0vgwdyY55dEJAxoGV8HXdSdRcYd9lWwc0JRFL9/cX
	 daWeBj9vAOtKSYL9jVfcLkXzzA3DF8z63sreckGkBSfdm7EUgjDFZr1g4h2no0bbF+
	 yqGEz/OlMdaI8qzBgcQA2ueZhjlBFaFHXeQzjIC2McJOGdh6dXybONNPy+6nY4BN4b
	 djVP0K25XmBlg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH 1/2 v2] perf script: Fix missing '+' indicator
 when branch counter reaches upper limit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519175043.1490261-2-thomas.falcon@intel.com>
References: <20260519175043.1490261-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 18:03:49 +0000
Message-Id: <20260519180349.CA865C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Spurious saturation indicator (`+`) when branch counter width is=
 zero.
--

commit 8180cd9e4a96461a6318e3ba1cd4601080696d71
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
perf script: Fix missing '+' indicator when branch counter reaches upper li=
mit

This commit restores the "+" suffix in perf script to indicate when branch
counter events may have been lost due to counter saturation.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c8ac9f01a36bc..f865c8b2f95f1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
[ ... ]
> @@ -1287,8 +1287,12 @@ static int ip__fprintf_jump(uint64_t ip, struct br=
anch_entry *en,
>  			if (!verbose) {
>  				for (j =3D 0; j < num; j++)
>  					printed +=3D fprintf(fp, "%s", pos->abbr_name);
> -			} else
> -				printed +=3D fprintf(fp, "%s %d ", pos->name, num);
> +				if (num =3D=3D mask)
> +					printed +=3D fprintf(fp, "+");

[Severity: Medium]
Could this print a spurious '+' if the branch counter width is zero?

If perf_env__find_br_cntr_info() sets width to 0 (for example, if PMU
capabilities are missing or not supported in the perf.data file), the
calculated mask will be 0. Consequently, num will also be 0, making the
condition (num =3D=3D mask) trivially evaluate to true (0 =3D=3D 0).

This would incorrectly print a '+' for every branch counter event. Because
num is 0, numprinted would also remain 0, causing the subsequent code to
append '-', resulting in contradictory output like '+++-'.

> +			} else {
> +				printed +=3D fprintf(fp, "%s %d%s", pos->name,
> +						   num, num =3D=3D mask ? "+ " : " ");
> +			}
>  		}
>  		if (numprinted =3D=3D 0 && !verbose)
>  			printed +=3D fprintf(fp, "-");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519175043.1490=
261-1-thomas.falcon@intel.com?part=3D1
