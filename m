Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250471EE7C6
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199019; cv=none; b=L5IXZT3qVSrggn27090mE7D7tLUUh4FUPn2MobOLGWq3b829c3YpHye1kU1xCnJlqVBgCG3UDi/bHziY/9aw7AGo6b8JzN0+P+uUAcrVj6C/enUBYemQcB9xIz9zw/m4XVpYHASOoHJQ5kNsiaRUOjTNW3rVHvIqjXBM/92tQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199019; c=relaxed/simple;
	bh=JUowKJPCYPOlzIfrrE9sxTx8RrHqGpkv+leHWiNFalA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rNYGqLnoogacTxlgEc6bDUtONXIAdkPEp11GxvK3lZ52yBl3FCJh/v+iwFPZfoMyprMtVC8cnTwAJdABD6OCu2P+cz1BGb9KnPObK0Q586RohQNa8Jb3tXgqEJbz810xzybLGz3RN42Msk7P7bgVVbgGRBEU1IkyiOTbTGM1pwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqKs029c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqKs029c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2E61F00A3A;
	Tue, 23 Jun 2026 07:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782199017;
	bh=ljLcNlycxuzbu7PJszwsLpLsLlbFXW+rhJA/GixqKf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QqKs029cFXNiFhL0YPDgCaWppm9b9MqoeYHrWj458kWJMw6/RBMKtKNVRNFVwL/dK
	 dVUiklR5HgV823hFHlW3I2cBpt0jzfP9AewRL1XEB+wFcajHr0SoC4A7CNseVE4P/V
	 dwAZFVRD6c7tXw5pzMuvCCaoKtGO0ZOiwUt0um/ddn2bG9apootl2hLA0IcqxUROCf
	 PNHFnqNGWkCziY1o6iep3c0Xw2Diy/S8tHD/LWUk8mRtVXT1DOGvG9fFgMIG205nxc
	 O54T7cnc3zlt0KGTeY/wCE4Z+3YgkLq5oEZXID8O5MAuLlh1fmJBZ7ZRm8S7e+DTR9
	 Um4LiFOZv4Iuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf kvm: Check kvm_need_default_arch_event() early
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623070313.55225-3-namhyung@kernel.org>
References: <20260623070313.55225-1-namhyung@kernel.org>
 <20260623070313.55225-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:16:57 +0000
Message-Id: <20260623071657.7D2E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] BUG_ON() unconditionally triggers and crashes `perf kvm record` on=
 architectures where default arch events are not added (e.g., ARM64, RISC-V=
, s390).
--

commit e180ad0afcd0778bb15a60785a0b08bfd2f76a50
Author: Namhyung Kim <namhyung@kernel.org>

perf kvm: Check kvm_need_default_arch_event() early

This commit modifies perf kvm record to check if default options are needed
before allocating arguments and passing the extra command line, preventing
the default event from being incorrectly passed to the external command.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index c236093eac473..acc6f2a706b35 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1996,13 +1996,14 @@ static int __cmd_record(const char *file_name, in=
t argc, const char **argv)
>  {
>  	int rec_argc, i =3D 0, j, ret;
>  	const char **rec_argv;
> +	int need_arch_event =3D !!kvm_need_default_arch_event(argc, argv);
> =20
>  	/*
>  	 * Besides the 2 more options "-o" and "filename",
>  	 * kvm_add_default_arch_event() may add 2 extra options,
> -	 * so allocate 4 more items.
> +	 * so allocate more items conditionally.
>  	 */
> -	rec_argc =3D argc + 2 + 2;
> +	rec_argc =3D argc + 2 + (2 * need_arch_event);

[ ... ]

> -	if (kvm_need_default_arch_event(argc, argv)) {
> +	if (need_arch_event) {
>  		ret =3D kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
>  		if (ret)
>  			goto EXIT;
>  	}
> =20
> +	for (j =3D 1; j < argc; j++, i++)
> +		rec_argv[i] =3D STRDUP_FAIL_EXIT(argv[j]);
> +
> -	BUG_ON(i + 2 !=3D rec_argc);
> +	BUG_ON(i !=3D rec_argc);

[Severity: High]
Could this BUG_ON() cause a regression for perf kvm record on architectures
that do not add default events?

If kvm_need_default_arch_event() returns true, rec_argc is set to argc + 4.

However, on architectures like ARM64, RISC-V, or s390, it appears
kvm_add_default_arch_event() can return 0 without actually appending any
events or incrementing i.

If that happens, i will only equal argc + 2 after the loop, causing this
assertion to unconditionally fail and abort the process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623070313.5522=
5-1-namhyung@kernel.org?part=3D2
