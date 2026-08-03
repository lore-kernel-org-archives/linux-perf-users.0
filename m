Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891F3B8BD1
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763157; cv=none; b=pDM5GYXoYhyNYXb+p+7oJiOh00FoaCw9YKmYZhu6/Q79sOY7C978EqxsiQ2TJeE1evGmgUozbAlf3mi+F1IoJNj52aD/mdH9nbYeRV4BGKrGwH17MhpwrL8USvOTm7tYnAAZAjJH6ASSAHvquu0Is+O7iuN6NbdHoAOpq1Cb6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763157; c=relaxed/simple;
	bh=/kLPByOizeXBgEHxfDhffGeap/+UPmszczh6Ub8hRs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tgcJAee9ZuvWj/K6yNkvlOGRsAYDFGUFwX34DqyJjQUznpuPBP5GiUJ+3q1SvgM7Ty9ZYk7qu6yik0xSg7xJLZxly1VViOgH+GSlHTlya9/wrcMiYct7BQBx6B3uQQUoODTMYGFUzXyMwTg/2jiGGxTShMm1Vw3IVxZ6gpRYxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIvmW06k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIvmW06k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7491F000E9;
	Mon,  3 Aug 2026 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785763147;
	bh=zzaovT6zIH7R3x4i4SCLVJr+n7UiymiTHM39+KwHTXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jIvmW06k81808BZIEuzh8tmYuMmkPKQIRyuFjoBVCjEhXdof8lOmTwAOKKEQ3t3Yj
	 tpIpI5OzezZ78N/NMb/n3tJpv+9l8qSO8O5cjkxkko2lHC/N4pGNmUvhMUi9I9zP7w
	 QT+ACjZXSG+tu4RCB/y1U0UtVe5bmJJuXHJI6MkvPaBX1dN88AEYC8FZdQf0UD+Esz
	 foYg7Y9YHr15jgpqmArw01FX3zyeZkfdctOJdu4b97jPOJwpnvpYuWpN+WWdNa/WdO
	 UyJmR00e7X1NsRlJTRJvX+FiZ4l/LRioTrdawWFEkofjcd058JgAcljjQBmypzFPdS
	 S06oWuk3lgo2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf tools: Fix memory leak in cmd_kvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michalis Niarchos" <michael.niarchos@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803-perf-kvm-fixes-v2-1-1b337189fffc@gmail.com>
References: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
 <20260803-perf-kvm-fixes-v2-1-1b337189fffc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:19:05 +0000
Message-Id: <20260803131906.CE7491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Obsolete dead code and misleading error message left behind after s=
witching to string literals.
--

--- Patch [1]: [PATCH v2 1/4] perf tools: Fix memory leak in cmd_kvm() ---
commit 86f226d29d0e3321d6c203d041f55a455eb36daf
Author: Michalis Niarchos <michael.niarchos@gmail.com>

perf tools: Fix memory leak in cmd_kvm()

filename may get allocated by get_filename_for_perf_kvm(), but is
never freed. Use string literals to remove the need for freeing.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 394302ebdb161..44c6998f2ee5d 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -606,11 +606,11 @@ static const char *get_filename_for_perf_kvm(void)
>  	const char *filename;
> =20
>  	if (perf_host && !perf_guest)
> -		filename =3D strdup("perf.data.host");
> +		filename =3D "perf.data.host";
>  	else if (!perf_host && perf_guest)
> -		filename =3D strdup("perf.data.guest");
> +		filename =3D "perf.data.guest";
>  	else
> -		filename =3D strdup("perf.data.kvm");
> +		filename =3D "perf.data.kvm";
> =20
>  	return filename;
>  }

[Severity: Low]
Since this function now returns string literals, it can never return NULL.

Should we also remove the unreachable error handling in cmd_kvm() where
get_filename_for_perf_kvm() is called?

tools/perf/builtin-kvm.c:cmd_kvm() {
    ...
	if (!file_name) {
		file_name =3D get_filename_for_perf_kvm();

		if (!file_name) {
			pr_err("Failed to allocate memory for filename\n");
			return -ENOMEM;
		}
	}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-perf-kvm-f=
ixes-v2-0-1b337189fffc@gmail.com?part=3D1
