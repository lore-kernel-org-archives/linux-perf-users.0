Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375262;
	b=hdXbw/eZBAvF7en6xMmX7peWcVlcGMQ/SI9JVpn/dmuPkHhnOcXwF/VKXagwgdt1Rk0Y
	 qu3jlYy8Yege2Hk5GXYH3b+8rToSvVQgEkbkVtTb16z0IfB2/WNLuyrjvZ9sYLn8J3lXB
	 4YSQ7fzLhzZpmSx0ICAqhWu3Hzm9y8J1VZAEk7eaTu+xapIepFe504mB2h7uGq1eC+Uy8
	 0n4VSgUdty2/xhL3jGv9D+0/nw90K2tOgtmdemC4kFiDX0+bzs/n2qorGK52cXwh7RqhB
	 h91J9CLZXjlt4k8U4iMmI45XMnzEhP2AkWJldiUV3aFNJMeibDa/Dvy/a2jqPB0b+dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VOdI1cIDOpssrjReh7Iae+sNBfqegHNeSJ+RYvwTx7Y=;
	b=G452D0dDGXCuxGK4+flNxNg+N8h1DQo1OLLIuGB7YlJwUfeakVfvb/EYXi0VUsHn2GiS
	 UJbJJqqpakkH1FPjTl4eKo48JqiNGgFVNc/cNYWgnEMn5BVTbLo1hDul2Z9fFlXCbO/mC
	 Jf7/Gpth04CcJuBcgt9svVtFFvRY5OacBnMb00RcA33X5r4QFuDziIqJFTaLvvcf6TwHr
	 WRU0oF+E7REyaUnbw7dKb1Dw/U/I3x5YffppqDSM3PVOOmPX0hoKVW3UCpV1H4cWvg7h9
	 G7AwOcUzK0Dp7dJfhlmeT7U21F+n86BZwLC2PYY5L01m63DGSww27QA6SAK6OhcEcew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPhNS3Tw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C28606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPhNS3Tw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318011F000C1;
	Fri, 30 Oct 2026 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793375261;
	bh=VOdI1cIDOpssrjReh7Iae+sNBfqegHNeSJ+RYvwTx7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPhNS3Twu39Cs9o7Vi1aH66NsH/kIKQDGdpT0KikeCa2vUxXoqLse428LuCe0Ukp+
	 WzZuEacPN9TcRNEI3Q6trED90YpWJ74RY9V++bzlAlGgrsA/1ROdVqXjj0L23/s3x8
	 viGlmyGUQ9BcPDuhTywnpbz23fNSkXDVg2HZg+Uxq8iTZJcYtD0l69Bz1JTFHEgTnS
	 j6pVkuqEp1Cx4X5YEqacOAEP2yl31qrNI5DRsqn0sRyPtWqbYW7cBi6jGKpbmEOZr+
	 FS/VOl+Ys6OHJqEItofa7F517mNhqmSh5PwhY/PuHPMVCQmvb6NEyJp9EJNev12Xt/
	 WslM5Du3B3VqQ==
Message-ID: <sashiko-outbox-191190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf docs: Correct JIT_CODE_UNWINDING_INFO
 specification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Letian Jiang" <letian.jiang@outlook.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
References: <CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:47:39 +0000
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
- [Medium] perf docs: jitdump spec wrongly drops mapped_size=3D0 unwinding =
limitation
--

commit fce68361b6cd7f448891e65b30a518cba3f31f05
Author: Letian Jiang <letian.jiang@outlook.com>

perf docs: Correct JIT_CODE_UNWINDING_INFO specification

This commit updates the JIT_CODE_UNWINDING_INFO documentation in
tools/perf/Documentation/jitdump-specification.txt to fix the ordering of t=
he
EH Frame and EH Frame Header, document record ordering relative to
JIT_CODE_LOAD, and remove the second sentence of the mapped_size note.

> diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/p=
erf/Documentation/jitdump-specification.txt
> index 79936355d819a..c813c6ebbcf2d 100644
> --- a/tools/perf/Documentation/jitdump-specification.txt
> +++ b/tools/perf/Documentation/jitdump-specification.txt
> @@ -153,12 +153,15 @@ The record type is optional.

[ ... ]

> @@ -167,4 +170,4 @@ The EH Frame header follows the Linux Standard Base (=
LSB) specification as descr
>  The EH Frame follows the LSB specification as described in the document =
at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.html
> =20
> =20
> -NOTE: The mapped_size is generally either the same as unwind_data_size (=
if the unwinding data was mapped in memory by the running process) or zero =
(if the unwinding data is not mapped by the process). If the unwinding data=
 was not mapped, then only the EH Frame Header will be read, which can be u=
sed to specify FP based unwinding for a function which does not have unwind=
ing information.
> +NOTE: The mapped_size is generally either the same as unwind_data_size (=
if the unwinding data was mapped in memory by the running process) or zero =
(if the unwinding data is not mapped by the process).

[Severity: Medium]
Is it accurate to drop the second sentence of this note on the basis that
mapped_size does not affect which unwinding data is read?

While jit_repipe_unwinding_info() and jit_write_elf() copy the full unwindi=
ng
payload into the synthesized ELF file, jit_repipe_code_load() in
tools/perf/util/jitdump.c uses mapped_size (usize) to set the length of the
synthesized PERF_RECORD_MMAP2 event:

    event->mmap2.pgoff =3D GEN_ELF_TEXT_OFFSET;
    event->mmap2.start =3D addr;
    event->mmap2.len   =3D usize ? ALIGN_8(csize) + usize : csize;

During DWARF unwinding in tools/perf/util/unwind-libunwind.c,
read_unwind_spec_eh_frame() -> unwind_spec_ehframe() reads the fixed header
of .eh_frame_hdr (up to fde_count) directly by file offset:

    r =3D dso__data_read_offset(dso, machine, offset, (u8 *) &hdr, sizeof(h=
dr));
    if (r !=3D sizeof(hdr))
        return -EINVAL;

However, libunwind reads the .eh_frame_hdr binary search table (table_data)
and the .eh_frame FDE/CIE entries by target virtual address via
__libunwind__access_mem() -> access_dso_mem():

    map =3D find_map(addr, ui);
    if (!map) {
        pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
        return -1;
    }

When mapped_size is zero, the MMAP2 event only covers [addr, addr + csize)
and excludes the .eh_frame and .eh_frame_hdr sections placed at
addr + ALIGN_8(csize), so find_map() returns NULL for any table_data or
.eh_frame access.

As described in commit 0284fecd13b6 ("perf jit: Add unwinding support"), wh=
en
mapped_size is zero, only the .eh_frame_hdr header (with fde_count =3D=3D 0=
 and
an empty lookup table) can be read to trigger frame-pointer unwinding
fallback, whereas reading .eh_frame FDEs requires a non-zero mapped_size.
Should this limitation remain documented in the specification?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CYXPR84MB347620A9EC=
3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM?part=3D1
