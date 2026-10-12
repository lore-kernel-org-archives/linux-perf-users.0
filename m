Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997863403E7
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783610; cv=none; b=SvuFIwty8InN3ELs/fIIIZpf7/WxVLIpI0324P6dYAgLR0jz6B5KevodiqzTfV3gZT3NS75yeYEQJdAS0dTFDJA49oty18AXqjZZrSa69zh4h1IL9KF202f5Cfi4Ut2iiMCB10Z8UOFkYBnUfeUWn8kZ+jY6Kkfya5mMRYDrKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783610; c=relaxed/simple;
	bh=RLitzP3Htm3v6mor6i6Bg+0e5DojeBqE8N4JHRuTB2A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=inekKVcZOHzcNW+WhNzfatYihV/p47DrOy1BUnxhpFYK+ZqJUA+sM8nV2hqXakpUotypB1JGxmOaA/HQU2TkZE7PPRTeJ67h8ahohb2JuQtMzTbpz2QM4hSYEW1Qk5YD9aaui+WLE97Uh5KlnSPxzX2PbwZQ0aCLXV/mffjVrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZgPsKeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZgPsKeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF711F0089B;
	Mon, 12 Oct 2026 05:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783609;
	bh=9h8EVjrqtSM0p4w6XfruH6jVLm+jwyMz9gYlaImMbE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZgPsKeYsULCe90l0JQjjZn1Z5WSDZ0FOe5T9AmhpOws0jwYPnxVpvETR0ibkcjzA
	 HPd4Os8eYxjsYd0OMqN/nk7mWDTd/6r30YQyNLM1VIy+fyucwi/jwDCUOw7T+UtfwK
	 E783zfcW4g72gr+WWW7C84qgsPoxombn1czkAOwfcQyLhU4PPqlCBWMiXzHWgSaCuR
	 xnDhy8hB+r0LVKIaZ7b/PKBHmsNBkdALQIPUS+Y93dl0eRCJjVKBqv5uUHrjjpHxD6
	 PoWCcF9rjdOTaEgrug9PxvJSIbeNdPhXCYo9G3Qjss2OnrJVygRTwoGjSY7P5VG//4
	 6sQnfHbwrIxRQ==
Message-ID: <sashiko-outbox-167684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf symbol: Set dso symtab type for libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012053013.14378-3-namhyung@kernel.org>
References: <20261012053013.14378-1-namhyung@kernel.org>
 <20261012053013.14378-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:40:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf symbol: incomplete dso state initialization for libbfd caus=
ing annotate/unwind failure
--

commit 5475c2801d673496a1fee31f44ca921eca39f20c
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Set dso symtab type for libbfd

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4878d4292eb85..a90ce714b174b 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1925,6 +1925,7 @@ int dso__load(struct dso *dso, struct map *map)
>  			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> =20
>  		if (bfdrc > 0) {
> +			dso__set_symtab_type(dso, symtab_type);

[Severity: Medium]
When dso__load() takes this early exit to out_destroy, it bypasses the rest
of the loop which normally initializes symsrc_filename and binary_type:

		if (!syms_ss && symsrc__has_symtab(ss)) {
			syms_ss =3D ss;
			next_slot =3D true;
			if (!dso__symsrc_filename(dso))
				dso__set_symsrc_filename(dso, strdup(name));
		}
...
		if (next_slot) {
...
			if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND || ... )
				dso__set_binary_type(dso, symtab_type);

Does skipping these initializations leave the DSO's binary_type as
DSO_BINARY_TYPE__NOT_FOUND?

If so, could this cause perf annotate to fail later on, since
symbol__disassemble() checks for this exact condition and returns an error?

tools/perf/util/disasm.c:symbol__disassemble()
...
	if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
	}
...

>  			ret =3D 1;
>  			goto out_destroy;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012053013.1437=
8-1-namhyung@kernel.org?part=3D3
