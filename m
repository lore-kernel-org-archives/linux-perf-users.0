Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B3175A8B
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020717; cv=none; b=ILElXmRaZurcSPuIV/6RCjOap1RBkAHRkd2pyoo9YlOTzF3qGb3Qs+S4LwwqE6v25hBoYAdGG8m46KjNBxe68Q57wOTN5pJkFPde7xreou26I6kII6K3BmfCTNZ24ptL0wRwdAh9AhBThMf1HtT4xqWyIuUS23MzDrHQy78qA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020717; c=relaxed/simple;
	bh=6SRzwV+4wVHcfsxgfL7vX8rMP2BbPPNYDPU9E4dR3YM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kWlIsKbXB1Tbyx5wA7FfrnRrwPDrAdxX2w6voF3UMcc8AiLX+2qC+LgO9tvPBggJeIZjpgnOV/ZIR9xjKIqa68KpFJWK0p0yBY+XiRbMUqt4Yf7l5bADkBDI8wcrI3yQ5896ra+s3Lfr1g5u5lSCMD+fwdLh5FiiKMsyxiHp7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqZqUxem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqZqUxem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3331F000E9;
	Thu,  6 Aug 2026 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020716;
	bh=6P5Wa060EsRdML52JsE/WNZL/ohj6/peN3iNq1M2k0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqZqUxemHh4vh/O/Acg5gKJOm25LnaqjIangPyASEHlV9vuLo1T6IUpwSnEF2ZBrK
	 cxe6eFjMyv6NoVj01Cw8CsteU6GxnBXkK2maOThVb0uXHyr7AdundUNNKNJAG9/I81
	 4HkdEw8g+ZTLJoyYi8Isyz13v8/7JZMdEzrtHs/4L/1Pirrrhoo3QnBQYVaa686owi
	 MiCz+SNQ5WYy+pOBaXidh+W+WkWoKgV3/i0f5FjsNQi2V8HPgXIeO3bKjOUNTD2fEP
	 xKcDNL0kiu3dP4GGb4yri+ZsxmknmDIt229/GvpsA/xKropUX67kpAd7RQheiAK2Y4
	 sSviuUq3jDDqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] perf jitdump: Fix funlockfile on unlocked stream
 in jit_open() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-8-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:51:55 +0000
Message-Id: <20260806125156.0D3331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of `nr_entry` in `JIT_CODE_DEBUG_INFO` records =
leads to heap out-of-bounds read and write.
- [High] Unvalidated sizes in `JIT_CODE_UNWINDING_INFO` records lead to a h=
eap information leak.
--

--- Patch [7]: [PATCH 07/12] perf jitdump: Fix funlockfile on unlocked stre=
am in jit_open() error path ---
commit 8cca1c1db77a8a564c00747fab840f2d6744e3a9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
   =20
If the malloc() for the initial read buffer fails, jit_open() jumps to
the error label which calls funlockfile(jd->in).  However, flockfile()
is called later in the function, so at this point the stream was never
locked.  Calling funlockfile() on an unlocked stream is undefined
behavior per POSIX.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 45f0e21b0e780..ae63366b86c6d 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -157,7 +157,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
> =20
>  	buf =3D malloc(bsz);
>  	if (!buf)
> -		goto error;
> +		goto error_noflock;
> =20
>  	/*
>  	 * protect from writer modifying the file while we are reading it
> @@ -246,8 +246,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
> =20
>  	return 0;
>  error:
> -	free(buf);
>  	funlockfile(jd->in);
> +error_noflock:
> +	free(buf);
>  	fclose(jd->in);
>  	return retval;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing validation
of nr_entry in JIT_CODE_DEBUG_INFO records?

If jd->needs_bswap is false, nr_entry is not validated against the actual
record size in jit_get_next_entry():

tools/perf/util/jitdump.c:jit_get_next_entry() {
    ...
    if (jd->needs_bswap) {
        void *end =3D (void *)jr + jr->prefix.total_size;
    ...
}

jit_repipe_debug_info() then blindly copies this unvalidated count into
jd->nr_debug_entries. Finally, jit_process_debug_info() loops
nr_debug_entries times:

tools/perf/util/genelf_debug.c:jit_process_debug_info() {
    ...
    for (i =3D 0; i < nr_debug_entries; i++) {
        ent->addr =3D ent->addr - code_addr;
        ent =3D debug_entry_next(ent);
    }
    ...
}

Could an attacker provide a JIT dump with a small payload but a massive
nr_entry, causing an out-of-bounds strlen read followed by an out-of-bounds
write (ent->addr =3D ...), corrupting heap memory?

[Severity: High]
This is a pre-existing issue, but are there unvalidated sizes in
JIT_CODE_UNWINDING_INFO records?

When parsing a JIT_CODE_UNWINDING_INFO record, jit_repipe_unwinding_info()
blindly copies the attacker-controlled unwinding_size and eh_frame_hdr_size
fields without checking if they fit within the allocated heap buffer:

tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
    ...
    jd->eh_frame_hdr_size =3D jr->unwinding.eh_frame_hdr_size;
    jd->unwinding_size =3D jr->unwinding.unwinding_size;
    ...
}

These unvalidated sizes are later used by jit_add_eh_frame_info() to
configure libelf data sections:

tools/perf/util/genelf.c:jit_add_eh_frame_info() {
    ...
    uint64_t unwinding_table_size =3D unwinding_size - unwinding_header_siz=
e;
    ...
    d->d_buf =3D unwinding;
    d->d_size =3D unwinding_table_size;
    ...
}

Could an attacker craft a record with a small total_size but massive
unwinding sizes, forcing libelf to read past the end of the heap buffer and
write megabytes of the perf inject process's heap memory into the generated
ELF file, causing an information leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D7
