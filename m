Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8654AA407
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442702; cv=none; b=CV3O5YJznyQnVoF52VcMMJroOc9zlvFGx3eH+yhLB+edErc6U53MiBeLMwCFj1I/4Y5nVi1MZfeNAwFyeUq6Ahb2faIfZ9O35KL+Z7iSroO1Pb2frODCUDuCc8t4M8eiNDX2DW4ylsdWpkQEW2rnTdqca+8b1BYFelsKDwpp0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442702; c=relaxed/simple;
	bh=WQVGBko4GWC3KZYOY3U5RhL7urJEx39h/Wtn5wseM9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nkztYAB1aUEbceP73ZFNVrGQFbglY1LOKbqRsT9eWxWEVyOyeh2OH/bMZfXf4SCoMG1UVHqKFbzsnlJF+Pdy4eTHCdkxoJH5ASMsUWDvqUzCNKMup8J0/5zgBeyc8W4wQQGxlfPJLkY7OmSzP+t8pUd4uU+TMs5qe6OdZUz0KkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/cXSyId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/cXSyId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D077F1F00A3A;
	Thu,  3 Sep 2026 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442687;
	bh=BmlfsfZ2zU4qQ4WmqebcmIL612LdatZAGJ0477+eaqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/cXSyIdWFpklaqmOSUdMnid2yNvhq4wFOOgtEClpjQEWDng6hHFd72rRXe7YLiJy
	 lctH+ctx+Gom1jjBeNQMx3nyYyyUj19s3RK1WHamoYV1N8F8yWin8TZV5kjqbK06Xp
	 kBEn7jguoo9b3fzqh0+W98mwf8nfD1eaTByt5h5qhJwjQt5+d05vcuT8tU+whNHnhU
	 Imu45DHIZchd2P5JwSr8c15IwfmxtBm9TgMAKiT+6GzezsX7tskxnozGUk0KUtAOJr
	 hcXzu1XD/HxKFXR68UtCcrgNyi9lxftSa4bsf0f0HMldZhFs3GGOnSf8/DK6Be5BaJ
	 +nIuS7FJtuchA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf genelf: Use unaligned-safe accessors for debug
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903132251.237029-3-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
 <20260903132251.237029-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:38:06 +0000
Message-Id: <20260903133806.D077F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Changing `last_line` and `lineno` to `unsigned int` causes negat=
ive line number advances to be incorrectly zero-extended to large positive =
values on 64-bit architectures, corrupting the DWARF line number program.

Pre-existing issues:
- [High] Unchecked realloc failure in buffer_ext_add() leads to exploitable=
 out-of-bounds heap writes.
--

commit 4a5e45a87437dd59a172031050c168bbb7f8ce78
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf genelf: Use unaligned-safe accessors for debug entries

This patch modifies the perf genelf utility to use unaligned-safe accessors
for debug entry address and line number fields. This prevents undefined
behavior on strict-alignment architectures, as debug_entry records pack
a variable-length string field, leaving subsequent entries unaligned.

> diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debu=
g.c
> index 8588b3e35e008..8244d3c64103b 100644
> --- a/tools/perf/util/genelf_debug.c
> +++ b/tools/perf/util/genelf_debug.c
> @@ -355,13 +359,15 @@ static void emit_lineno_info(struct buffer_ext *be,
>  	unsigned long last_vma =3D 0;
>  	char const  *cur_filename =3D NULL;
>  	unsigned long cur_file_idx =3D 0;
> -	int last_line =3D 1;
> +	unsigned int last_line =3D 1;
> =20
>  	emit_lne_set_address(be, (void *)code_addr);
> =20
>  	for (i =3D 0; i < nr_entry; i++, ent =3D debug_entry_next(ent)) {
>  		int need_copy =3D 0;
>  		ubyte special_opcode;
> +		unsigned int lineno =3D get_unaligned(&ent->lineno);
> +		uint64_t addr =3D get_unaligned(&ent->addr);
> =20
>  		/*
>  		 * check if filename changed, if so add it

[ ... ]

> @@ -376,24 +382,24 @@ static void emit_lineno_info(struct buffer_ext *be,
> =20
>  		special_opcode =3D get_special_opcode(ent, last_line, last_vma);
>  		if (special_opcode !=3D 0) {
> -			last_line =3D ent->lineno;
> -			last_vma  =3D ent->addr;
> +			last_line =3D lineno;
> +			last_vma  =3D addr;
>  			emit_opcode(be, special_opcode);
>  		} else {
>  			/*
>  			 * lines differ, emit line delta
>  			 */
> -			if (last_line !=3D ent->lineno) {
> -				emit_advance_lineno(be, ent->lineno - last_line);
> -				last_line =3D ent->lineno;
> +			if (last_line !=3D lineno) {
> +				emit_advance_lineno(be, lineno - last_line);
> +				last_line =3D lineno;

[Severity: Medium]
Will this zero-extend instead of sign-extend on backward line jumps?

Because lineno and last_line were changed from int to unsigned int,
their subtraction will wrap around to a large 32-bit unsigned value (e.g.,
0xFFFFFFEC for -20).

When this large unsigned value is passed to emit_advance_lineno, which
expects a 64-bit signed long, it implicitly zero-extends on 64-bit
architectures instead of sign-extending. This results in encoding a massive
forward line jump rather than a backward jump, potentially corrupting DWARF
line number mapping.


I also noticed a potential out-of-bounds write during buffer operations her=
e:

tools/perf/util/genelf_debug.c:add_debug_line() {
    ...
	buffer_ext_add(be, (void *)&default_debug_line_header,
		 sizeof(default_debug_line_header));

	buffer_ext_add(be, &standard_opcode_length,  sizeof(standard_opcode_length=
));

	// empty directory entry
	buffer_ext_add(be, (void *)"", 1);

	// empty filename directory
	buffer_ext_add(be, (void *)"", 1);

	dbg_header =3D buffer_ext_addr(be) + old_size;
	dbg_header->prolog_length =3D (buffer_ext_size(be) - old_size) -
		offsetof(struct debug_line_header, minimum_instruction_length);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code handle
buffer_ext_add() allocation failures correctly?

If realloc fails inside buffer_ext_add(), it returns -1 without expanding
the buffer. The caller ignores this return value and proceeds to dereference
the computed pointer dbg_header.

If the buffer was completely full when realloc failed, this points exactly
to the end of the heap chunk, leading to unconditionally writing beyond the
allocated bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903132251.2370=
29-1-acme@kernel.org?part=3D2
