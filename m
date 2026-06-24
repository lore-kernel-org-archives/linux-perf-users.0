Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98283E1682
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782332783; cv=none; b=ULuTTFSPC5QLU63u1KCcNasFoRKx9qScOMGmWop5wMqRXQQSBSL8yvIRipt7zzW/hNfTI0ZDcSVTdTA2yJRL1KP37/q50AxJOBs0KnmLxD5tSQU8sEuzxg2eMWnImVk37q+AR338qXJMUdYYvwTTEqUQt9dylSHP7RdXD3ZYqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782332783; c=relaxed/simple;
	bh=Zp5rLvdnw0Wcu14pBMZ2CZwppuE3wGhUBhu6LbFOlJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aMQtre8yKkVw8lU1c2zVoS7JFCigen4V2ayHEnpjEiR8qK/Uit1ymGhc805W1+pOqOAOY3EYL5N6npDvR85E8j1PRbFeTB9e1iytIOVC8B1b2M/M7FRl7D/Y65QvQEDFqpYxU61LpmHe2VEhWUT7KfytPGjcgf1rBzlIhnjZcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZdLg7kg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZdLg7kg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3301F000E9;
	Wed, 24 Jun 2026 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782332780;
	bh=qRrcEkn2OPkjIZTomLtOGevxpucKpmcDAFXBRQPiOjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZdLg7kgGullspxCNKfjJ5ma8eIHtTJQCoiseHmRDpfrhaOi3VCrPmNDfcFmjeCIv
	 qhvHE/vU4F4si8NQk/2EEgA6Wc02sLwTtBdC3MSBhOtPWxx0GXQk/Y97vSCSrAL3p3
	 mi+D2ndmQl4HcW23rJmRmsjM6ty7bwbewSmBiWCob3S82RfUviKja7IY9QMjNxm5ws
	 yCtxxwPM9H6Pzahje7+fKVQRp/niK8W7N7YbBIygs8F29p/yVZLdyMo8HOuSe0pMEB
	 pZuz/FOzJkPVq7Q+/4IBKsTxNzD1e80Lh0OLEJo7sXGsTZI0z/oJuGHlODeosFWMTT
	 qysG0cTtzpCIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf symbols: ignore livepatch symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joe Lawrence" <joe.lawrence@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624201254.472576-1-joe.lawrence@redhat.com>
References: <20260624201254.472576-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 20:26:19 +0000
Message-Id: <20260624202620.2C3301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds write of a null terminator in kallsyms__parse() =
stack array.
- [High] Livepatch symbols (.klp.sym.*) corrupt module boundaries in kcore_=
copy, leading to silently omitted module memory and bogus mappings.
--

commit 2ebd0b4f62f44ca82022b5aeb4aaa75ac016e938
Author: Joe Lawrence <joe.lawrence@redhat.com>

    perf symbols: ignore livepatch symbols
   =20
    Livepatch modules contain special symbols (prefixed by ".klp.sym.") that
    act as relocation placeholders. Once resolved, they point to the same
    addresses as the original kernel symbols they reference. These special
    symbols confuse the 'vmlinux symtab matches kallsyms' perf test as
    kallsyms may report multiple symbols sharing a single kernel address.
   =20
    Link: https://docs.kernel.org/livepatch/module-elf-format.html#livepatc=
h-symbols [1]

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fcaeeddbbb6b9..eeaed3f5cf50d 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -774,6 +774,10 @@ static int map__process_kallsym_symbol(void *arg, co=
nst char *name,
>  	if (name[0] =3D=3D '$')
>  		return 0;
> =20
> +	/* Ignore livepatch symbols */
> +	if (strstarts(name, ".klp.sym."))
> +		return 0;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does kcore_copy__process_kal=
lsyms()
need a similar filter for livepatch symbols?

Livepatch symbols contain a module name bracket (e.g., "[kpatch...]") but
their address points to the core kernel space. In symbol-elf.c, this appears
to trick the module boundary tracking:

tools/perf/util/symbol-elf.c:kcore_copy__process_kallsyms() {
    ...
	if (strchr(name, '[')) {
		if (!kci->first_module_symbol || start < kci->first_module_symbol)
			kci->first_module_symbol =3D start;
		if (start > kci->last_module_symbol)
			kci->last_module_symbol =3D start;
		return 0;
	}
    ...
}

Because the livepatch symbol address is in the core kernel range, does this
incorrectly lower kci->first_module_symbol to the core kernel address space
instead of the module vmalloc space, omitting module memory and creating a
bogus mapping?


[Severity: Critical]
This is a pre-existing issue, but while reviewing the kallsyms parsing I
noticed a potential out-of-bounds write when reading symbol names:

tools/lib/symbol/kallsyms.c:kallsyms__parse() {
    ...
		char symbol_name[KSYM_NAME_LEN + 1];

		[ ... ]

		for (i =3D 0; i < sizeof(symbol_name); i++) {
			ch =3D io__get_char(&io);
			if (ch < 0 || ch =3D=3D '\n')
				break;
			symbol_name[i]  =3D ch;
		}
		symbol_name[i]  =3D '\0';
    ...
}

If a symbol name in kallsyms is longer than KSYM_NAME_LEN characters and
doesn't have a newline or EOF, the loop increments i up to sizeof(symbol_na=
me)
(which is KSYM_NAME_LEN + 1). When the loop terminates without breaking, it
writes '\0' at symbol_name[sizeof(symbol_name)], which is one byte past the
end of the array.

Can this corrupt the stack if an untrusted user provides a crafted --kallsy=
ms
file to perf?

>  	/*
>  	 * module symbols are not sorted so we add all
>  	 * symbols, setting length to 0, and rely on

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624201254.4725=
76-1-joe.lawrence@redhat.com?part=3D1
