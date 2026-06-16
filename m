Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7F22D7A1
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577636; cv=none; b=pwS8ISmqDwzgfyjGbg8r3+yw2oRZ3s6zT3pj1/4Zy8P5hzGpNHE0+BZrwcHic9x0eAqiIXianmXwHwe21+dUi/T0vm5vMIx9B/FDCBqpM9HzNYK1clVmYmWbxWyGLNnp7ubeu14AtihQoZEpuaBL3zy30gYN7uTo/qFF6DpCmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577636; c=relaxed/simple;
	bh=d+sxnwOo9qigbtJOAFqaUtSczxlVozul+3fXiSEv85s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5GtOjYEb2C7D2gVMC4l18h8Pr2Xa/F9ws306B97reKHINc3WbRz4t0hIieSnywd/uHWFRNjhHREy+EQJ5YThYz45DqfcrIa8fKuVa2LAaeRISAfY6aVOj1u/Luq1/jM9Y/MpK3C7M8K4RJvXNzWt69AWEcY6+Hj2BAIXmCWvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brUo1Sll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brUo1Sll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28831F000E9;
	Tue, 16 Jun 2026 02:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577635;
	bh=TH6jigPB6/0fpNfCEzcftrwMSptKpqFe1c1QijP6HeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brUo1SllsjrtE5aKFDlYnRHuRTuuLoZLXzwY2BCae3A3E2EKKsLux94XY5C6J1eCb
	 WBtazyxMj/MCbBpTk5wyS7BBx0Ja7sa5e3o2g2EHkMnTuQb1jPOhedsAPrI5q25jW/
	 md5rbamWXVsL7cQ2OLG8+A98/BqwFUhsDg9KVAPENwfxCMBXEmz1WI4msmozrcQJh0
	 cm1h5bZQhFmMappEt23Garl7VaHozGPP7fXkylhUzRKm8ulxOLz1oe7H+6JYc8fegt
	 917iACvNPtus3AGIHcrIJ5Wd7L34MoZktVfdJAN2wR1SDJ2qTFrUQ+hT8ZK6X2vgfK
	 NSBav5nsStNng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf machine: Use snprintf() for guestmount path
 construction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616022715.5739-3-acme@kernel.org>
References: <20260616022715.5739-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:40:34 +0000
Message-Id: <20260616024034.F28831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Aborting processing of all remaining guest maps when a single dire=
ctory lacks proc/kallsyms.
- [High] Uninitialized errno checked against ERANGE after strtol() causes v=
alid directory names to be erroneously skipped.
--

commit 33df4f15ea6c660ee8ff4b243d151622bd2d9271
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Use snprintf() for guestmount path construction

This commit prevents a potential stack buffer overflow by replacing
sprintf() with snprintf() when building paths using the user-provided
guestmount configuration.

Fixes: a1645ce12adb6c9c ("perf: 'perf kvm' tool for monitoring guest perfor=
mance from host")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Zhang, Yanmin <yanmin_zhang@linux.intel.com>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 9329d319bd033..0d2ebf6a84bcf 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c

[ ... ]

> @@ -1260,9 +1260,9 @@ int machines__create_guest_kernel_maps(struct machi=
nes *machines)
>  					 namelist[i]->d_name);
>  				continue;
>  			}

[Severity: High]
This isn't a bug introduced by this patch, but does the strtol() parsing in
machines__create_guest_kernel_maps() handle errno correctly?

Since errno is not explicitly cleared to 0 before the strtol() call right
above this continue statement, if a previous directory name caused an
overflow, errno will remain set to ERANGE.

This would cause the (errno =3D=3D ERANGE) check to evaluate to true for all
subsequent valid directory PIDs, erroneously skipping them. Could we set
errno =3D 0 before parsing?

> -			sprintf(path, "%s/%s/proc/kallsyms",
> -				symbol_conf.guestmount,
> -				namelist[i]->d_name);
> +			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
> +				 symbol_conf.guestmount,
> +				 namelist[i]->d_name);
>  			ret =3D access(path, R_OK);
>  			if (ret) {
>  				pr_debug("Can't access file %s\n", path);

[Severity: High]
This is also a pre-existing issue, but does this access failure in
machines__create_guest_kernel_maps() intend to abort the entire
initialization loop?

If access() fails here, the code executes a goto failure. This means one
inaccessible guest directory or missing proc/kallsyms will abort the loop
and skip all subsequent valid guest map directories.

Earlier in the loop, invalid directory names use continue to safely skip
just that entry. Would it be better to continue instead of aborting the
processing of all remaining maps?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022715.5739=
-1-acme@kernel.org?part=3D2
