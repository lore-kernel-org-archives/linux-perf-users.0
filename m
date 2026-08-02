Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16042EACF2
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682469; cv=none; b=NSuXHVuC0EjSdxRNBUVQ6OxAEvNt5rd4wQUZRYP/UrCk97dZ+QbuaxdcqHPL+eJzUufrqfuGNLeUoyU1arvlupCBfeanjDv2+S0TeAwTSD/+fYOSW/4eIIfeV4UlJmYzdOBaTwuuDn/bx09Iy6NnrjjupK9Eu90XmClYRAd4ToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682469; c=relaxed/simple;
	bh=p8krSJwmMHywNzo1/MbVEROwNamIHPOcxFbQSKLzv5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lXgVGRoyWT1i2z98Uk84FQLsH3R7iiIVml1HWsoXAyFrFv8PNu5gzrB+72qlWQzQYmORPDWsX4aiJspT+ifqdEWlMe3pnowm0xGqkI5haadr2Au5USZKHD97NET5dJKhKB9sEysI3lBRn4Xs3elQEajHYIiBruvN8H4Gwj4yx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc0EzYxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc0EzYxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445311F000E9;
	Sun,  2 Aug 2026 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785682468;
	bh=4zLHuZI8YfKS97Kcri40qQIzptqD07hhZ6fuLClMzx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lc0EzYxpE1sOkZdpHav8w4DuMAdBlXhehrURD4CZAniBHFAtcgPKFNEhg1F4410Wb
	 vYMRQS4FTqtFD9wcObYWLxKDbm6UxzFWg9yLvWTyD96vCC4+CA40aRvfIK1ou5g4VZ
	 QbiLfJAiAxcVMvq2s6W6/lq8mwO+To13qLs/cID0gM8eK/McN/JUG3KmuNSr/iX/d9
	 qylnBVaT9pro+0oNm/A3t2nPVJPKhtmIcAYIeX6biYuhakO9dO9SMNiAueKiNtqtwQ
	 guKa87AsPTSnzIPcc5Y8+SP0jKqi4z2i2kusTN4Mu3CEAnMw6LklK6On6M8p7eH6LZ
	 g/bRKaSrwMOvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf dso: Replace assert with runtime check in
 dso__read_symbol()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260802142022.154219-6-acme@kernel.org>
References: <20260802142022.154219-1-acme@kernel.org>
 <20260802142022.154219-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 14:54:27 +0000
Message-Id: <20260802145428.445311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] dso__read_symbol() fails to offset into the concatenated BPF JIT=
 instruction buffer for subprograms, unconditionally returning the instruct=
ions for the first subprogram.
- [Medium] The `is_64bit` flag for BPF JIT disassembly is hardcoded to the =
host's `sizeof(void *)` instead of reflecting the target's architecture, br=
eaking cross-platform disassembly.
--

--- Patch [5]: [PATCH 5/5] perf dso: Replace assert with runtime check in d=
so__read_symbol() ---
commit 53ccbff8c0716057dbbc219812e142e5e96f1fe9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf dso: Replace assert with runtime check in dso__read_symbol()
   =20
    dso__read_symbol() asserts that len <=3D jited_prog_len, where both
    values originate from untrusted file input. With NDEBUG, the assert
    is compiled out, allowing an out-of-bounds heap read. This replaces
    the assert with a runtime bounds check that returns NULL.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index a0de56c93592a..f3209f285db76 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -2024,7 +2024,12 @@ const u8 *dso__read_symbol(struct dso *dso, const =
char *symfs_filename,

[Severity: Medium]
This is a pre-existing issue in dso__read_symbol(), but should the
is_64bit flag be based on the host's architecture?

Earlier in this function, it sets:

    *is_64bit =3D sizeof(void *) =3D=3D sizeof(u64);

If analyzing a perf.data file generated on a 32-bit target using a 64-bit
host, won't this cause cross-platform disassembly to break because downstre=
am
disassemblers receive the wrong bitness flag? Could we dynamically inspect
the target machine architecture from perf_env (e.g. e_machine) instead?

>  			errno =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
>  			return NULL;
>  		}
> -		assert(len <=3D info_linear->info.jited_prog_len);
> +		if (len > info_linear->info.jited_prog_len) {
> +			pr_debug("BPF symbol length %zu exceeds jited_prog_len %u\n",
> +				 len, info_linear->info.jited_prog_len);
> +			errno =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> +			return NULL;
> +		}
>  		*out_buf_len =3D len;
>  		return (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);

[Severity: Medium]
This isn't a bug introduced by this patch, but does returning the base of
the JITed instructions handle subprograms correctly?

If the perf.data file contains a multi-function BPF program (where
dso__bpf_prog(dso)->sub_id > 0), this appears to blindly return the
instructions for the first subprogram instead of the requested subprogram.

Should this calculate the byte offset for the target subprogram using
jited_func_lens?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802142022.1542=
19-1-acme@kernel.org?part=3D5
