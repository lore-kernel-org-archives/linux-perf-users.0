Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB6363C48
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232848; cv=none; b=UN8OC11NKBiD8tyi/0YHSX/iEV5wuSLHlpaUlBbw+aK46qYfG3t6m6eqEDl1kU0zQ7wZechNlqakG1HreOuYiFj1wLyugxF9ML/1n9DuNiXTHGPKpt4bH2tgJsEyj9Jvu/WTzGNhUYteUa+x2nPqaQ3b65yEleJWe3toeOHcgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232848; c=relaxed/simple;
	bh=4Yc+S4ofwOoIReEnoh3DbYfKIRwS45suhYF4Xi3kxM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IcTJOWnkdk2FsfElv9ITbhlhPOjXI7nEufb9TRQqmKPu1jmq6jPHBxWORFZ0Dxn5FTczpQ5izRrYoRXXL25T8XFme6nFPm9/En+PGiqoy7qFojPnfBw+G9SrPFckRLN/um1m8iLe5lfX2vSZJDOL3Zn7c+bq97XIWEcW6qIoysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKHpwKIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKHpwKIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FF01F000E9;
	Fri, 12 Jun 2026 02:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781232846;
	bh=ToSOFOZN9veCx63dJEDkZBMNTpPpMIzMnm8sJDejCT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RKHpwKImG4gyTn/8iXRpRmNe6RrErXqDDkoKMyyC8H3NHvIPFLMT7ufTDhRhbtd+9
	 BB/89/R/Q2VVsM1mwnCbneGUEMTrXLMo7p3AZl4a7rXXcf2TYAqgTRZTplnTpcW2jt
	 y58mOXJXXBt5SAkGqJRKrLd0Zxve8uVwjNnFQ6mCZbMOaRJ0Ulu0qDwxQ5vwafz98k
	 377bnjdqH2hFKD6Anbdk+h02/P2InfSyGtfy7OflXNLWWS0vJ79k4dLBPN5vchkpxY
	 CHk73fD+5Tp9YopfsVOOEXqrrjac6M+AnWnJb7oPZDwAnR0LqQW/vaRxTp+zRmq+nO
	 oYTH3OGTOkWPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] perf tools: Use snprintf() for root_dir path
 construction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612003444.50723-8-acme@kernel.org>
References: <20260612003444.50723-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 02:54:06 +0000
Message-Id: <20260612025406.91FF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for stack buffer overflows caused by unbounded `--g=
uestmount` arguments.
--

commit 7a512f0d1037b835700ec0c14aab087dcaf3e840
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use snprintf() for root_dir path construction

This patch mitigates stack buffer overflows in get_kernel_version() and
dso__load_guest_kernel_sym() by replacing sprintf() with snprintf(). It=20
prevents unbounded root_dir inputs (from KVM configurations or=20
--guestmount) from overflowing the PATH_MAX stack buffers.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index da1ad58758afd..58fa57e3d1a15 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1336,7 +1336,7 @@ static char *get_kernel_version(const char *root_di=
r)
>  	char *name, *tmp;
>  	const char *prefix =3D "Linux version ";
> =20
> -	sprintf(version, "%s/proc/version", root_dir);
> +	snprintf(version, sizeof(version), "%s/proc/version", root_dir);

[Severity: High]
This isn't a bug introduced by this patch, but does the same overflow
vulnerability remain in other places that use symbol_conf.guestmount?

For example, in tools/perf/util/machine.c:machines__findnew(), the unbounded
path is formatted into a stack-allocated buffer:

	if ((pid !=3D HOST_KERNEL_ID) &&
	    (pid !=3D DEFAULT_GUEST_KERNEL_ID) &&
	    (symbol_conf.guestmount)) {
		sprintf(path, "%s/%d", symbol_conf.guestmount, pid);

And in machines__create_guest_kernel_maps():

			sprintf(path, "%s/%s/proc/kallsyms",
				symbol_conf.guestmount,
				namelist[i]->d_name);

Both format unbounded user input into a stack-allocated path buffer using
sprintf(). Should these also be converted to snprintf() to fully prevent
stack buffer overflows?

>  	file =3D fopen(version, "r");
>  	if (!file)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612003444.5072=
3-1-acme@kernel.org?part=3D7
