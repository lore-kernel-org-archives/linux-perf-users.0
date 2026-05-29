Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB33BE621
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046630; cv=none; b=FvJ6VqhmkaE9mAGBXkddKtJfRkr1jx7OTcfQLcnCVhgiMCW2NHHW2WIpk4WGodq/9gTS+aBdiU2Uq9btmUEPP9lfo8/L0rNJhg97kgZoptdxEzCaFWJ/iNtwlCLEcVT9mCdUG0SWpIeE3yCe8Hx485CyoLTMpib+T5x8/pXg6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046630; c=relaxed/simple;
	bh=h8ZqSSl8CcDMyjJZTVDvRz2aEbZ8si6qha6AqfAYc7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CY+F970KzSu98VtjiG3cvspqYZCc+NucP8GbW4H6gfEdIfdFegSAGy2/MNEG0Tfhng3JNyQOhIZKNrooxfxUFv/EAslOPBf85MfUYehK6fUmh6tkbUcip0FscupDIUDGTw0AXINeBLwsc2W72DXvEj8bUgSup6pgFVdL9kKQ5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njNGODKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njNGODKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A8F1F00893;
	Fri, 29 May 2026 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780046625;
	bh=D218JOQulLEj7Xl6Hxojj1daELoqWvQfIlY7+WVCV8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=njNGODKYdI2kT6ICgMIQP0Gq9WNRhD4l06EeYrxkFwQcX9EmrQ1d6lsQUstKuoHKr
	 1FUwebLV8dBc2abGHLmAvJmhfBnqxKFXCq2KI860blrbIearDzSy6PCRyZhTa2tE6R
	 Yg2etZnG4ymSCydZrBnjWBLnZTEvbuGZXN7iVfiCIuy60mnjkpp5hWlrarB8hWN3Ob
	 U0dLLSGHEFM+465jkII+8NboLnxXTMALaLcRM+6oKf7h3SHD+izdlDvsodEE9sixid
	 u0JkrZ0yRMlaipazgR5ZC3ZtsmdsBRzSUzwdnYRR++IZD+GSqwvTsy1ssis3R4bRlU
	 Ikbt1g6VMTzgg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 1/5] perf headers: Sync perf_event.h/perf_regs.h with
 the kernel headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529082451.591783-2-dapeng1.mi@linux.intel.com>
References: <20260529082451.591783-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:23:45 +0000
Message-Id: <20260529092345.A3A8F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced variable-length SIMD payload in `PERF_SAMPLE_=
REGS_USER` and `PERF_SAMPLE_REGS_INTR` breaks sample parsing, leading to se=
vere data corruption for subsequent fields.
- [High] The newly added SIMD configuration and reserved fields in `struct =
perf_event_attr` are not byte-swapped in `perf_event__attr_swap()`.

Pre-existing issues:
- [Critical] An integer underflow in `read_attr` when processing the `size`=
 field of a `perf_event_attr` structure leads to a massive stack-based buff=
er overflow.
- [Critical] In `read_event_desc`, a lack of minimum size validation on the=
 `sz` variable leads to out-of-bounds heap memory corruption during byte-sw=
apping.
--

commit 40d194b08491e7774620de12bd78192095f031fd
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf headers: Sync perf_event.h/perf_regs.h with the kernel headers

This patch syncs the UAPI header changes to support SIMD, eGPRs, and SSP
sampling into the corresponding perf tool UAPI headers. It also adds a
sanity check for the newly introduced __reserved_4 field in
perf_attr_check().

> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index fd10aa8d697f2..c49fc76292f79 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
[ ... ]
> @@ -547,6 +549,29 @@ struct perf_event_attr {
> =20
>  	__u64	config3; /* extension of config2 */
>  	__u64	config4; /* extension of config3 */
> +
> +	/*
> +	 * Defines the sampling SIMD/PRED(predicate) registers bitmap and
> +	 * qwords (8 bytes) length.
> +	 *
> +	 * sample_simd_regs_enabled !=3D 0 indicates there are SIMD/PRED
> +	 * registers to be sampled, the SIMD/PRED registers bitmap and
> +	 * qwords length are represented in
> +	 * sample_simd_{vec|pred}_reg_{intr|user} and
> +	 * sample_simd_{vec|pred}_reg_qwords fields separately.
> +	 *
> +	 * sample_simd_regs_enabled =3D=3D 0 indicates no SIMD/PRED registers
> +	 * are sampled.
> +	 */
> +	__u16	sample_simd_regs_enabled;
> +	__u16	sample_simd_pred_reg_qwords;
> +	__u16	sample_simd_vec_reg_qwords;
> +	__u16	__reserved_4;
> +
> +	__u32	sample_simd_pred_reg_intr;
> +	__u32	sample_simd_pred_reg_user;
> +	__u64	sample_simd_vec_reg_intr;
> +	__u64	sample_simd_vec_reg_user;
>  };

[Severity: High]
Are these newly added fields missing byte-swapping logic in
perf_event__attr_swap()?

When perf reads a cross-endian perf.data file, if these fields are not added
to perf_event__attr_swap() in tools/perf/util/session.c, they will remain in
their original byte order.=20

Later, when evsel__parse_sample() relies on fields like attr_nr_vectors and
attr_vec_qwords to validate SIMD data bounds, could incorrect values bypass
validation or cause out-of-bounds read faults?

[ ... ]
> @@ -1020,7 +1045,15 @@ enum perf_event_type {
>  	 *      } && PERF_SAMPLE_BRANCH_STACK
>  	 *
>  	 *	{ u64			abi; # enum perf_sample_regs_abi
> -	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
> +	 *	  u64			regs[weight(mask)];
> +	 *	  struct {
> +	 *		u64 nr_vectors;		# 0 ... weight(sample_simd_vec_reg_user)
> +	 *		u64 vector_qwords;	# 0 ... sample_simd_vec_reg_qwords
> +	 *		u64 nr_pred;		# 0 ... weight(sample_simd_pred_reg_user)
> +	 *		u64 pred_qwords;	# 0 ... sample_simd_pred_reg_qwords
> +	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
> +	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +	 *	} && PERF_SAMPLE_REGS_USER

[Severity: High]
Does appending this dynamic-length SIMD structure to PERF_SAMPLE_REGS_USER
break sample parsing for older perf tools?

Older parsers do not know about the PERF_SAMPLE_REGS_ABI_SIMD bit. When
parsing the sample payload, they will only advance the array pointer by
hweight64(attr.sample_regs_user) * sizeof(u64) bytes, failing to skip the n=
ew
SIMD header and data.=20

Could this cause subsequent fields like PERF_SAMPLE_STACK_USER to read the
SIMD data as their own, resulting in parsing desynchronization and data
corruption?

Should a new bit be added to enum perf_event_sample_format instead?

[ ... ]
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc32..e8e4e00d6b4d0 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[Severity: Critical]
This isn't a bug introduced by this patch, but is there an integer underflow
in read_attr() when processing the size field of the perf_event_attr struct=
ure?

The function reads the first 64 bytes and extracts attr->size into sz. It
checks if sz =3D=3D 0 or sz > our_sz, but fails to verify if sz < PERF_ATTR=
_SIZE_VER0.
If a perf.data file supplies a size between 1 and 63, could the calculation
left =3D sz - PERF_ATTR_SIZE_VER0 underflow the unsigned size_t variable le=
ft,
producing a huge positive value?

The subsequent readn(fd, ptr, left) attempts to read this massive amount of
data into f_attr, which is allocated on the stack in
perf_session__read_header(), potentially resulting in a stack buffer overfl=
ow.

[Severity: Critical]
This is a pre-existing issue, but does read_event_desc() lack minimum size
validation on the sz variable before byte-swapping?

The function reads a 32-bit sz from the file, allocates a heap buffer, and
calls perf_event__attr_swap(buf). Inside this function, the code
unconditionally reads and byte-swaps the first 8 bytes.

If sz is between 1 and 7, attr->size reads out-of-bounds heap memory. Becau=
se
bswap_safe() uses this uncontrolled attr->size to determine which subsequent
fields to swap, could it proceed to byte-swap up to 176 bytes of heap memory
past the small allocation, leading to heap memory corruption?

> @@ -2091,7 +2091,8 @@ static void free_event_desc(struct evsel *events)
> =20
>  static bool perf_attr_check(struct perf_event_attr *attr)
>  {
> -	if (attr->__reserved_1 || attr->__reserved_2 || attr->__reserved_3) {
> +	if (attr->__reserved_1 || attr->__reserved_2 ||
> +	    attr->__reserved_3 || attr->__reserved_4) {
>  		pr_warning("Reserved bits are set unexpectedly. "
>  			   "Please update perf tool.\n");
>  		return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529082451.5917=
83-1-dapeng1.mi@linux.intel.com?part=3D1
