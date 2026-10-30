Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389907;
	b=wuzXlm7dDt1rm1+spwQ4lSQcZcn2MDjmQK93Ds93aUChROKXfDyzi2MAuIT4aiupX8hD
	 1QjTXqnhARO0qw8kabq/0NDdKm9JZfCRL8rH/m3673zBRdVLH2rpq861w1yTC84zULHBS
	 TVAtTglAJE70KJDhD5wmxIQtVzDvETEOgvL8Bvm8GlNxlSEn/RMx/dlO/y6b6MOO3G3pi
	 KorwC/5eAjH6qXs445PrR7kMaSimVk/I23Pfi/KSkFYbJXwLoV3x0acYwYlAKqaiQ+F0x
	 N6UxjtpVLhsFoE3VPv7KaGjcaYDOi4rHc8bHT7xDAvwMKtaW6VThbuhCSPaARkvKBmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DIbBsHiD9yCwFbHOdK0w5iGfOJaFpUEarhPeNdJkWtU=;
	b=Pz8DmJMD1c34FISFF/Stis/z6/1J5qB9nB0FcS1NAPWh+DxCSPM5ItpsNAd9lVQnnz50
	 1j5ImVBMtxJDB3V8KKunUOjmfdav+Ij5FksD8fxjrFMC+zV/u+7c6Fpu8sZENQ9fQ86/6
	 p1YtlFxnDVYSDXKNIg/U0xOuMvKLW0u5Ndfa970qOX22l0rcpvRCcgitj46vaX2/xGzcM
	 VW/lerIK7sF4UYyvVH+GEfpKYkubgQNLlGO2He5UAOdjdcU49byygnh4lW29lLDcrVhCl
	 lQ+AEdk5XVKH4JaMC1ZXTPe4/Qnbc899zyCro3oEKwDfkcl9RF2JuS/nckAFvoCCkTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCPecVVP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5543606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCPecVVP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BCF1F000C1;
	Fri, 30 Oct 2026 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793389906;
	bh=DIbBsHiD9yCwFbHOdK0w5iGfOJaFpUEarhPeNdJkWtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCPecVVPDIJEB+1LNJ4LohyfcZ9qWDiMUoaBlKEOpCU/r+Tgr1qGrI/cnsKrsQrfZ
	 ZkAYrEHX5Tq8VMGZRzeaPTxzIAHHC6P+gVW8N+rrWBLld/pVG4h8fw375J8C+MjnSv
	 bJX6kClrBUnf2WYaAWN/aV+c4NlCBrQzN6+be8KIrAEhhk5pYRDYuq9upnnjy7inI6
	 4i5rP3trnJPDmeqPgVxRd6OiweXcJ0BRqR64P5aJdVFb2mXuP32vKzN3JVBSLJJ+98
	 U5L8OjpdMjjVOEzswpSxClod+Nnm2dDM6CKAyCudmVcjPL+8YQymxh/t3qpljkknF6
	 /Uzf7WkEagbVw==
Message-ID: <sashiko-outbox-191456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf unwind: Don't look up symbols when the
 caller doesn't want them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030193237.1440673-3-thepacketgeek@gmail.com>
References: <20261030193237.1440673-1-thepacketgeek@gmail.com>
 <20261030193237.1440673-3-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 19:51:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf unwind: dso__load_symsrc() in entry() runs after libunwind =
stepping
--

commit a0b5e533925de51fda6cc2ade28ec95e77a4ee79
Author: Matthew Wood <thepacketgeek@gmail.com>

perf unwind: Don't look up symbols when the caller doesn't want them

This commit passes a symbols flag down to the DWARF unwinders (libdw and
libunwind) so callers that only need maps can unwind callchains without
loading and demangling DSO symbol tables. When symbols is false, the
unwinders call dso__load_symsrc() to locate build-ids and separate
debuginfo without loading symbols.

> diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-=
libunwind.c
> index 73d191ce51a55..3c5acc052715a 100644
> --- a/tools/perf/util/unwind-libunwind.c
> +++ b/tools/perf/util/unwind-libunwind.c
> @@ -589,14 +589,26 @@ void unwind__finish_access(struct maps *maps)
>  	libunwind_arch__finish_access(maps);
>  }
> =20
> -static int entry(uint64_t ip, struct thread *thread, unwind_entry_cb_t c=
b, void *arg)
> +static int entry(uint64_t ip, struct thread *thread, bool symbols,
> +		 unwind_entry_cb_t cb, void *arg)
>  {
>  	struct unwind_entry e;
>  	struct addr_location al;
>  	int ret;
> =20
>  	addr_location__init(&al);
> -	e.ms.sym =3D thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al=
);
> +	if (symbols) {
> +		thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
> +	} else {
> +		/*
> +		 * Still find the DSO's separate debuginfo, which loading
> +		 * the symbols would have, for read_unwind_spec_debug_frame().
> +		 */
> +		thread__find_map(thread, PERF_RECORD_MISC_USER, ip, &al);
> +		if (al.map)
> +			dso__load_symsrc(map__dso(al.map));
> +	}
> +	e.ms.sym =3D al.sym;
>  	e.ip     =3D ip;
>  	e.ms.map =3D al.map;
>  	e.ms.thread =3D thread__get(al.thread);
> @@ -614,7 +626,7 @@ static int entry(uint64_t ip, struct thread *thread, =
unwind_entry_cb_t cb, void
>  int libunwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  			 struct thread *thread,
>  			 struct perf_sample *sample, int max_stack,
> -			 bool best_effort)
> +			 bool symbols, bool best_effort)
>  {
>  	struct unwind_info *ui;
>  	uint64_t first_ip;
> @@ -640,7 +652,7 @@ int libunwind__get_entries(unwind_entry_cb_t cb, void=
 *arg,
> =20
>  	if (max_stack =3D=3D 1) {
>  		/* Special case for a single entry. */
> -		ret =3D entry(first_ip, thread, cb, arg);
> +		ret =3D entry(first_ip, thread, symbols, cb, arg);
>  		return ret ? (ret =3D=3D -ENOMEM ? -ENOMEM : 0) : 1;
>  	}
> =20
> @@ -662,7 +674,7 @@ int libunwind__get_entries(unwind_entry_cb_t cb, void=
 *arg,
>  		int j =3D callchain_param.order =3D=3D ORDER_CALLEE ? i : ui->cur_ip -=
 i - 1;
> =20
>  		if (ui->ips[j]) {
> -			ret =3D entry(ui->ips[j], thread, cb, arg);
> +			ret =3D entry(ui->ips[j], thread, symbols, cb, arg);

[Severity: Medium]
Does calling dso__load_symsrc() inside entry() happen too late for
read_unwind_spec_debug_frame() during unwinding?

In libunwind__get_entries(), all stack stepping runs to completion before
entry() is called on the collected IPs:

tools/perf/util/unwind-libunwind.c:libunwind__get_entries() {
	do {
		ret =3D libunwind_arch__unwind_step(ui);
		if (ret < 0)
			goto out;

	} while (ret);

	/*
	 * Display what we got based on the order setup.
	 */
	for (i =3D 0; i < ui->cur_ip; i++) {
		int j =3D callchain_param.order =3D=3D ORDER_CALLEE ? i : ui->cur_ip - i =
- 1;

		if (ui->ips[j]) {
			ret =3D entry(ui->ips[j], thread, symbols, cb, arg);
			if (ret)
				break;
			entries++;
		}
	}
}

While libunwind_arch__unwind_step() is stepping the stack,
__libunwind__find_proc_info() looks up the map via find_map() (which only
calls thread__find_map()) and then invokes read_unwind_spec_debug_frame():

tools/perf/util/unwind-libunwind.c:__libunwind__find_proc_info() {
	if (ret < 0 && !read_unwind_spec_debug_frame(dso, ui->machine, &segbase)) {
		...
		symfile =3D dso__symsrc_filename(dso) ?: dso__name(dso);
}

Inside read_unwind_spec_debug_frame(), it attempts to open
dso__symsrc_filename(dso):

tools/perf/util/unwind-libunwind.c:read_unwind_spec_debug_frame() {
		if (ofs <=3D 0) {
			fd =3D open(dso__symsrc_filename(dso), O_RDONLY);
			if (fd >=3D 0) {
				ofs =3D elf_section_offset(fd, ".debug_frame");
				close(fd);
			}
		}
}

When callers pass symbols=3Dfalse (such as build_id__mark_dso_hit(),
perf_event__inject_buildid(), get_leaf_frame_caller_aarch64(), or
test_dwarf_unwind__thread()), neither dso__load() nor dso__load_symsrc()
has been called before libunwind_arch__unwind_step() runs. As a result,
dso__symsrc_filename(dso) is still NULL when read_unwind_spec_debug_frame()
and __libunwind__find_proc_info() check it, so unwinding fails for frames
that rely on .debug_frame in separate debuginfo discovered by
dso__load_symsrc() (and if libunwind_arch__unwind_step() returns a negative
error, the goto out path skips the entry() loop entirely).

Should dso__load_symsrc(dso) be called in __libunwind__find_proc_info() or
read_unwind_spec_debug_frame() before reading dso__symsrc_filename(dso)
instead of in entry()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030193237.1440=
673-1-thepacketgeek@gmail.com?part=3D2
