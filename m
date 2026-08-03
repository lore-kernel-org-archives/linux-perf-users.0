Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427130DEA6
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753829; cv=none; b=VTDM+XmuNpo3R8V/3TjXvJSgl1aPDsmWGLyPtaI5R9iwRgKSEvTrT88LcTVG0WZQK74twE++68zaQrmaaEaQBAprCIAY00MdXr3GA4xzPa9HWrE1zWIohycio9Pvc+P0Ck3HmsG7IZ0xGuWrsJaanhsZdganLu6gxhgK0jQCcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753829; c=relaxed/simple;
	bh=2tiKSHqXWN+ytEJyswuvILJWMfbvNXY+FcW1aguSSuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fVoyP73a/62DP56uoR4RFfHs6yZIjohuUaEDtfr7Yk28V1mr2RpDjMjL2TGIjUQsDcmtzuHzZRtUpqJbobgz3UFnVoyF/Mts6zhoYKAOCzpYgmyQrEm+yc6t3Vxk4jFlNUB9gQaYle+XLEXtez+GjbbQJYfsbMM/t5KIOVMxT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU/doZ88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU/doZ88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED751F00A3A;
	Mon,  3 Aug 2026 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785753828;
	bh=OjjZJko+JaRaWkfjimIAURK7Tsmgt1OSAFCxV7ejtqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PU/doZ884+MNL8zDTRndTDxF3HKYSftQ8HUWTsCDTL1r0QoD+PLYxB2akQTTL+hh1
	 YpnLkjzHjjgM2vY35OtiDwY8pzYHo/JFP16mrcmTcG/GtkFOiED46m9aLWScaX8trd
	 AMTUpXlD25DI+HgwkNnpWA5cnCc3ZFjod3EGapIO1I++LMiQ/WoYOsx+AAZmwrwCOB
	 ODl16QYSWtA0bw0ohkt6WDeaKqkq9EcKM0iKVyhfipADfmqrHXYHPyLfPlIoVQ9ArC
	 K8KIu589/GZH4+iFEhbd3uic37RZ+gA2C2ItGSzKv3C+Fvh5VtpI+EBmMKT4N/ed9m
	 +oXyWxPAd2ctA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf tools: Fix memory leak in kvm_events_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michalis Niarchos" <michael.niarchos@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803-perf-kvm-fixes-v1-2-a5db849ac973@gmail.com>
References: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
 <20260803-perf-kvm-fixes-v1-2-a5db849ac973@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:43:47 +0000
Message-Id: <20260803104348.7ED751F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Invalid free of a string literal causes a segmentation fault.
--

--- Patch [2]: [PATCH 2/4] perf tools: Fix memory leak in kvm_events_report=
() ---
commit b736af0d386356e57597151f619466500011da0a
Author: Michalis Niarchos <michael.niarchos@gmail.com>

perf tools: Fix memory leak in kvm_events_report()

This commit attempts to fix a memory leak in kvm_events_report() by freeing
the usage string after parse_options() completes.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1755,6 +1755,9 @@ kvm_events_report(struct perf_kvm_stat *kvm, int ar=
gc, const char **argv)
>  		if (argc)
>  			usage_with_options(kvm_events_report_usage,
>  					   kvm_events_report_options);
> +
> +		/* free usage string allocated by parse_options */
> +		free((void *)kvm_events_report_usage[0]);

[Severity: Medium]
Will this result in an invalid free and a segmentation fault?

Looking at the definition of kvm_events_report_usage in builtin-kvm.c:

const char * const kvm_events_report_usage[] =3D {
        "perf kvm stat report [<options>]",
        NULL
};

Since parse_options() bypasses allocation when subcommands is NULL, it
appears kvm_events_report_usage[0] remains pointing to the statically
allocated string literal rather than dynamically allocated memory. Freeing a
read-only string literal will crash the perf tool unconditionally on every
successful invocation.

>  	}
> =20
>  #ifndef HAVE_SLANG_SUPPORT

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-perf-kvm-f=
ixes-v1-0-a5db849ac973@gmail.com?part=3D2
