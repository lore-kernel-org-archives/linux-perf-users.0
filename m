Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8D41D204
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938403; cv=none; b=KKywd1yJvlMUEfmp2fLR6heS4SiJdmwaCL1P3kTe7fvh24e1tvKQmXBoEUPxNEMzjJ/xIZLdOxWT4haUxHsdxqdJt5+m9vvfeQ0k2up2xM1RDJJvQUxL7Ruzvc3VkJG9YL8SjacNtiToLuv3gcTvu0Ut+kDEWeS2xbdtowj0Zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938403; c=relaxed/simple;
	bh=B5suiB4E2JLWkcMRMohzg0OEcKMYui+3cVLUJSJBMiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bU8XCGNsbkxE0fueYeWZfFRPUFLJjC0Tnbb6wJyMv1AW0PZtIXWNJmFsNFySlwmklISQ86gCoxbgGY1jGnmhZs+qTQlNog9JJKZMmzq0F+FSgG5J2c6hkSrADmtRBNQlbtMDFbYXTWWa2SZYewzZ+9tV3C1GE/IZ3tKSNyjsuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUmBLsv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUmBLsv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA041F000E9;
	Wed,  5 Aug 2026 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785938401;
	bh=JZnWB+GXOtG58fUNWfmNujm6I3lphlOOW2AfXi+OO+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUmBLsv9/pl0rGEdeIc++Thv/mhlTl7AG32Fwf2dvTcxtbzPDhidt9O4ipeKy+q40
	 cce640jnzmitgXYO0T4v2Dmp9MkDd8J89Hz9+iKFCoK1jpWePuiTqfaZODhG1v1e0n
	 QmygdXpNyWviTIer+4gkjXLYUtS1GcS33fA4JAbdT7nseoaW3k5qXi8O1cRNJrTW/8
	 jh5wD/nr8y4po9WGJjSxslGkBd3vwHbvlAuk/SkQh6a/RKfN8pqa3Xt3YoO3C9RAV/
	 BbGxoTBgJULJ1ZmKRauS2XWfvHYWW3Qqt40sF2eVkNVntPGNmgB4PfuDQejNNq+Ds4
	 3feSYs+Cu1e/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] perf jitdump: Validate code_size against
 total_size in code load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-3-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 13:59:59 +0000
Message-Id: <20260805140001.4EA041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `jit_repipe_code_move()` contains a memory leak and a heap buffer =
overflow due to `snprintf` truncation.
- [Medium] Missing cleanup of `jd->debug_data` and `jd->unwinding_data` cau=
ses memory leaks.
- [Medium] Missing bounds check in `jit_repipe_code_move()` allows reading =
uninitialized heap memory and injecting it into the output `perf.data`.
- [Medium] Integer underflow when parsing `JIT_CODE_UNWINDING_INFO` size ca=
uses a massive out-of-bounds heap read and SIGSEGV.
- [Medium] Callback errors are silently swallowed in the `jit_process_dump(=
)` loop, masking data validation failures.
--

--- Patch [2]: [PATCH 02/12] perf jitdump: Validate code_size against total=
_size in code load ---
commit 386282de6b8b07ac74f2456d302053e3738822ce
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate code_size against total_size in code load

This commit adds bounds checking for code_size in the jitdump record to
prevent out-of-bounds heap reads when processing code load entries.

> --- tools/perf/util/jitdump.c
> +++ tools/perf/util/jitdump.c
[ ... ]
> @@ -450,6 +451,16 @@ static int jit_repipe_code_load(struct jit_buf_desc =
*jd, union jr_entry *jr)
>  	csize =3D jr->load.code_size;
>  	usize =3D jd->unwinding_mapped_size;
>  	addr  =3D jr->load.code_addr;
> +
> +	/* code blob lives at the end of the record, validate it fits */
> +	if (jr->load.p.total_size < sizeof(jr->load) ||
> +	    jr->load.code_size > jr->load.p.total_size - sizeof(jr->load) ||
> +	    jr->load.code_size > INT_MAX) {
> +		pr_warning("jitdump: invalid code_size %" PRIu64 " (total_size=3D%u) i=
n code_load record\n",
> +			   (uint64_t)jr->load.code_size, jr->load.p.total_size);
> +		return -1;
> +	}
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but does this early return skip
the cleanup for jd->debug_data and jd->unwinding_data?

When parsing consecutive debug info records, the previous state allocations
are unconditionally overwritten without being freed. If the bounds check
fails here or the stream ends, the buffers appear to leak since neither
the processing loop nor jit_close() cleans them up.

[Severity: Medium]
This is a pre-existing issue, but will the caller actually abort when we
return -1 here?

Looking at jit_process_dump(), the loop assigns the return value but doesn't
seem to check it before continuing:

jit_process_dump() {
    ...
    while ((jr =3D jit_get_next_entry(jd))) {
        switch(jr->prefix.id) {
        case JIT_CODE_LOAD:
            ret =3D jit_repipe_code_load(jd, jr);
            break;
    ...
}

Does this mean errors are silently swallowed and parsing proceeds on
corrupted state, masking the data validation failures?

>  	sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));

[Severity: Medium]
This is a pre-existing issue, but does jit_repipe_code_move() lack a
similar bounds check?

The generic parser only guarantees a minimum size of 16 bytes for a record,
but the move function accesses fields unconditionally:

jit_repipe_code_move() {
    ...
    event->mmap2.start =3D jr->move.new_code_addr;
    event->mmap2.len   =3D usize ? ALIGN_8(jr->move.code_size) + usize
                               : jr->move.code_size;
    ...
}

Could this allow reading uninitialized heap memory and injecting it into
the output perf.data if the record is truncated?

[Severity: High]
This is a pre-existing issue, but is there a memory leak and potential
heap buffer overflow in jit_repipe_code_move()?

Unlike jit_repipe_code_load(), the move function fails to clamp the snprintf
return value for the size:

jit_repipe_code_move() {
    ...
    size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
                    jd->dir,
                    nspid,
                    jr->move.code_index);
    size++; /* for \0 */
    ...
}

If the parsed path exceeds PATH_MAX, snprintf returns the would-be length,
which inflates event->mmap2.header.size. Does this corrupt the subsequent
id pointer offset and lead to an out-of-bounds write?

Also, the dynamically allocated event buffer appears to be leaked entirely
on both success and error paths before the function returns:

jit_repipe_code_move() {
    ...
out:
    perf_sample__exit(&sample);
    return ret;
}

[Severity: Medium]
This is a pre-existing issue, but could jit_repipe_unwinding_info()
suffer from integer underflow?

If a malformed file supplies a total_size less than sizeof(jr->unwinding),
the unwinding_data_size calculation underflows into a very large positive
integer:

jit_repipe_unwinding_info() {
    ...
    unwinding_data_size  =3D jr->prefix.total_size - sizeof(jr->unwinding);
    unwinding_data =3D malloc(unwinding_data_size);
    ...
    memcpy(unwinding_data, &jr->unwinding.unwinding_data,
           unwinding_data_size);
    ...
}

Could this lead to an immediate out-of-bounds read crash if the subsequent
malloc succeeds overcommitting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D2
