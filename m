Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9D242D88
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020910; cv=none; b=P5+L0MXgx75qJqrWGI1gqdWhTmhkWCpAJgkXDUEW08D/anR3FRoGoFAF0Iy5w31g4x6x41LFN2mW+guCELELmb8q/YFeZO95h9sJ8eDAFeBOBZKf6EJWFM1pLeEUHdrn4oJwiSUqVLkXEOS2Xsw14KIRBdNWto5s9RF/hon/+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020910; c=relaxed/simple;
	bh=W2u6r+OP20V+PEwnJkfkOUgSEfO/OpPcunBESUxkvCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CwQBMjzKWc5i+vsF1Sc7pOfos3OdyLVjsGBHA1+sGVZFYWQWUvJqvikZ4P8QX52qAap1J8UW7wuueObe3QJf1BaxwgjdxaO/whw/T/JDuwTBam263mTAvXUFbcMmP1t++I5dxp/6xN3M2NEWOhORpIbK/NWz8T/bMKocsXc6KPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpVzDv+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpVzDv+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4894C1F000E9;
	Thu,  6 Aug 2026 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020909;
	bh=F46nYk5cIqjdpktDw11IQXb6y+ltSHFzLt4kUvz4c+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpVzDv+57RfWuSKr95b6DKy3QBjCJCzMA1DcCZiBGaRInpGNe+6ACwWt9IrkomEzq
	 uGSShdvL6BFc38iGSTGA0orUFpVV2+3rsxmUs8zPk4/VQ9PJFYR17pG/fdKYU7wWq+
	 nYX1lRebW+ztGbTD0zLksoHKkhxD2Z0IABoZ3UBvWqOmaQnjnHRq1chAHAmv7DJ9sS
	 aehhiuuOJksk6TeC5TOn9zazoQxGDu5z0lnkL7lX9wP6xhg/8Aupul/E3rsAjD5PHF
	 nLYFqxFTpeewU6+WXhGtEZBs6kBkV0ZCu8TvYfz88dGQN0UME69jbZ0mbiQzd1ykTH
	 FSihaI8pJZ3TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] perf jitdump: Prevent integer underflow in debug
 info size calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-5-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:55:08 +0000
Message-Id: <20260806125509.4894C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unclamped `snprintf` return values when formatting filenames cause=
 integer underflow, inflating event size and leading to out-of-bounds heap =
writes.
- [High] Cross-endian byte-swapping of debug info entries uses incorrect fi=
xed-size array indexing on a variable-length structure, causing severe heap=
 corruption.
- [High] Unvalidated structural sizes for unwinding info lead to massive ou=
t-of-bounds heap reads and information disclosure during ELF generation.
- [High] Missing validation of `nr_entry` against the payload size in `jit_=
repipe_debug_info()` leads to heap out-of-bounds accesses during debug info=
 processing.
--

--- Patch [4]: [PATCH 04/12] perf jitdump: Prevent integer underflow in deb=
ug info size calculation ---
commit 279da6780ef70ba142d7c4f7db07000972f0e035
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Prevent integer underflow in debug info size calculation

jit_repipe_debug_info() and jit_repipe_unwinding_info() compute payload
sizes by subtracting the fixed header size from total_size. This prevents
an underflow when total_size is smaller than the header struct.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 14bd23c8d1963..f79e9420c6bd7 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -671,6 +671,10 @@ static int jit_repipe_debug_info(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>  	if (!(jd && jr))
>  		return -1;
> =20
> +	/* total_size must cover at least the fixed header */
> +	if (jr->prefix.total_size < sizeof(jr->info))
> +		return -1;
> +
>  	sz  =3D jr->prefix.total_size - sizeof(jr->info);
>  	data =3D malloc(sz);
>  	if (!data)

[Severity: High]
This is a pre-existing issue, but does this function also need to validate
jr->info.nr_entry against the payload size?

It appears the unvalidated count is saved to jd->nr_debug_entries. Later,
in jit_process_debug_info(), a loop iterates nr_debug_entries times:

tools/perf/util/genelf_debug.c:jit_process_debug_info() {
[ ... ]
    for (i =3D 0; i < nr_debug_entries; i++) {
        ent->addr =3D ent->addr - code_addr;
        ent =3D debug_entry_next(ent);
    }
[ ... ]
}

Since debug_entry_next() computes pointer offsets by reading variable-length
strings, could an artificially inflated nr_entry force the loop to iterate
past the allocated debug_data buffer and cause an out-of-bounds heap write?

[ ... ]

> @@ -699,6 +703,10 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, u=
nion jr_entry *jr)
>  	if (!(jd && jr))
>  		return -1;
> =20
> +	/* total_size must cover at least the fixed header */
> +	if (jr->prefix.total_size < sizeof(jr->unwinding))
> +		return -1;
> +
>  	unwinding_data_size  =3D jr->prefix.total_size - sizeof(jr->unwinding);
>  	unwinding_data =3D malloc(unwinding_data_size);
>  	if (!unwinding_data)

[Severity: High]
This isn't a bug introduced by this patch, but could the structural sizes
extracted from the untrusted record cause out-of-bounds reads later?

In jit_repipe_unwinding_info(), these sizes are blindly extracted:

tools/perf/util/jitdump.c:jit_repipe_unwinding_info() {
[ ... ]
    jd->eh_frame_hdr_size =3D jr->unwinding.eh_frame_hdr_size;
    jd->unwinding_size =3D jr->unwinding.unwinding_size;
[ ... ]
}

Then they are used to configure libelf data sections:

tools/perf/util/genelf.c:jit_add_eh_frame_info() {
[ ... ]
    uint64_t unwinding_table_size =3D unwinding_size - unwinding_header_siz=
e;
[ ... ]
    d->d_buf =3D unwinding;
    d->d_size =3D unwinding_table_size;
[ ... ]
}

If jr->unwinding.unwinding_size is inflated beyond the actual payload size,
could libelf read past the end of the unwinding_data allocation and leak
arbitrary heap memory to the generated ELF file?


[Severity: High]
This is a pre-existing issue, but I also noticed a potential integer underf=
low
when formatting filenames in jit_repipe_code_move() and
jit_repipe_code_load().

tools/perf/util/jitdump.c:jit_repipe_code_move() {
[ ... ]
    size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so", ..=
.);
    size++; /* for \0 */
[ ... ]
    event->mmap2.header.size =3D (sizeof(event->mmap2) -
                                (sizeof(event->mmap2.filename) - size) +
                                idr_size);
[ ... ]
}

If an untrusted jitdump file causes snprintf to truncate the filename (for
example by providing a long nspid or code_index), size will exceed PATH_MAX.
Would the subsequent calculation for event->mmap2.header.size undergo a dou=
ble
integer underflow since both operands are unsigned size_t?

This mathematically reduces to sizeof(event->mmap2) - PATH_MAX + size + idr=
_size.
Because size > PATH_MAX, header.size strictly exceeds the size of the event
structure.

The id pointer is then calculated as event + header.size - idr_size, placing
it past the end of the dynamically allocated event buffer, which could lead=
 to
an out-of-bounds heap write on id->pid and id->tid.


[Severity: High]
This isn't a bug introduced by this patch, but does cross-endian byte-swapp=
ing
of debug info entries incorrectly use fixed-size array indexing?

tools/perf/util/jitdump.c:jit_get_next_entry() {
[ ... ]
    for (n =3D 0 ; n < jr->info.nr_entry; n++) {
        jr->info.entries[n].addr    =3D bswap_64(jr->info.entries[n].addr);
        jr->info.entries[n].lineno  =3D bswap_32(jr->info.entries[n].lineno=
);
        jr->info.entries[n].discrim =3D bswap_32(jr->info.entries[n].discri=
m);
    }
[ ... ]
}

Since struct debug_entry contains a flexible array member for the name, each
entry is variable in length. Will using standard array indexing ignore the
interleaved variable-length strings and cause the byte-swap operations to
stride incorrectly across the buffer, potentially writing out-of-bounds on
the heap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D4
