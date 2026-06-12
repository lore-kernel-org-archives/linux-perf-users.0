Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAE3D4101
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304268; cv=none; b=YkqMhWvJST1Mit3yzJ9NrI67z4h6fsaQWNRDvKSLU9hcR53cic7xylVR68KNWw4qB4z8jlYN/B2kVUzdaCPIk4Q628OTxPLKNJA075qD7nJsrALOJTYa8iDQCFEGSvN46+bW+Y52uXn0wwTkpEcYO/XLp6AhpYOS7urpb7xboEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304268; c=relaxed/simple;
	bh=ti1/ih6K14ALZjyE/LgNyktQ46hglO+ZBDqJPglIvK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eDgf+KOETCu24k2NYi2+0/0YYVXg9kMtzKG5NxR8M88vqXxZaZ2jbEJRdm9oNicSYMyMVXTg8MNzpymb9BZr+vWdZMgSfcPcEzayR2+tykQzPn/aP3zqP+Kdoq9CcXatUgqrog8wAYOBJbYAbEDp3GXJEfgpiALA9fJCCVb5vks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0k6ODd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0k6ODd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845D81F000E9;
	Fri, 12 Jun 2026 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304266;
	bh=nslnHXJTKOTQ1JS3q9Um1+tFikyaOf3JVoyHsaZ8cAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E0k6ODd5PPtc7Su8no2YUSMJDqmZZspX5p8hAum355o9y8QdTygVTbVeWB5YhRMHx
	 Aj516/aTgDWfE/D+puf2URoS1C03RkAvT3i+/XNqZPCPg49NpsbmzKoVce+Lqccquo
	 3/Z3KUpTar98F2xxlBBVaPYryk7w7vsfcbJo1nXuh1NlUvoFAgX1mraB3R8VA9Cofg
	 5k/0p+E12apuJwuCXD67jw5hsPOLiYTJg7/S8EYllda3M71jJwCaKsj4JarMoRuRnL
	 3ezqVae6J0Tdv+m0bD8NKXSUynbuWl3wVuG7oV981PvctTxZY2JGUm6WMBLUhbNYQo
	 WHUEgUXoHmQ5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] perf bpf: Validate func_info_rec_size and sub_id
 in synthesize_bpf_prog_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612222413.40791-10-acme@kernel.org>
References: <20260612222413.40791-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:44:25 +0000
Message-Id: <20260612224426.845D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] `prog_tags[sub_id]` is unconditionally accessed, allowing NULL o=
r arbitrary pointer dereferences due to `perf.data` bitmask manipulation.
--

commit 78ed4be2586d28e75e2bc2be14dcd1813163bc05
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Validate func_info_rec_size and sub_id in synthesize_bpf_prog_nam=
e()

This commit adds bounds checking for func_info_rec_size and sub_id in
synthesize_bpf_prog_name() to prevent out-of-bounds reads when parsing
untrusted data from perf.data files.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index c4594969d7677..fe6fbca508c51 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -143,7 +143,9 @@ static int synthesize_bpf_prog_name(char *buf, int si=
ze,
>  	name_len =3D scnprintf(buf, size, "bpf_prog_");
>  	name_len +=3D snprintf_hex(buf + name_len, size - name_len,
>  				 prog_tags[sub_id], BPF_TAG_SIZE);

[Severity: Medium]
This is a pre-existing issue, but since we are actively hardening this
function against untrusted perf.data input, should we also validate prog_ta=
gs
before dereferencing it here?

If an attacker crafts a perf.data file that clears the PERF_BPIL_PROG_TAGS
bit in info_linear->arrays but leaves info->prog_tags set to an arbitrary
64-bit value, the offset translation and bounds checking in
bpil_offs_to_addr() are skipped.

Because the translation is skipped, synthesize_bpf_prog_name() retains the
untrusted value, blindly casts info->prog_tags to a pointer, and dereferenc=
es
it unconditionally via prog_tags[sub_id].

Could this lead to an arbitrary memory read or a NULL pointer dereference
crash during parsing?

> -	if (btf) {
> +	if (btf &&
> +	    info->func_info_rec_size >=3D sizeof(*finfo) &&
> +	    sub_id < info->nr_func_info) {
>  		finfo =3D func_infos + sub_id * info->func_info_rec_size;
>  		t =3D btf__type_by_id(btf, finfo->type_id);
>  		if (t)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612222413.4079=
1-1-acme@kernel.org?part=3D9
