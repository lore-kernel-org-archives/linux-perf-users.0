Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993BF38330E;
	Fri,  7 Aug 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088578; cv=none; b=oW/jbCs8jY/lBU4YTgjCeT1kDoiUMVRPEb4qbAhRGx1Gz737VEcq/ouz12GTxYudDvMvop2mJ/NV9fQGXYoaHQpLniUllbRCNbXer2OTmTdSfgC7YbSZjUEfz1RY73qlQ3qydIcOqYFaSRDE7ru/Xy8FhvRpJmjN515sNDpo1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088578; c=relaxed/simple;
	bh=kQiyEbz25opNFa9xnKfM8afvDpL3nlbYuUWDxOK4Bf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nL//Eymidkn8zuaHe7kqdLJZhZfFCv8/o+2cPgpHIx7WayArkkdyooXtuj7+m16tms+nMaxowU41VUqeKZrV3Is1HvxLobIcwncbt+HsUGWWAPCBMDUczzyeROl0Ofk6achUyh0UypHoExL7lV+kMraolFhxAV4VNvp8PY1pz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USecdGiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USecdGiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0305E1F000E9;
	Fri,  7 Aug 2026 07:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786088577;
	bh=3noUCEdt0fMbRMdVz1vqYmD9qSvLKWilfSiqXDPE/Mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USecdGiIgxTt4XpziDyYY6m1H4pLBVO/8Y506AHav+qxQC9VZ/d3F16wRbpu8dyQu
	 QwKqtZlC+JyWk9h0obTfx0iR9BeSht5d93ynGljoOVxrQAA/5OLEH7CKNzoZeAol6O
	 gg1rMsj187vKMClhRHXbgz+2FwqmjtWEMN0QCgm2oM0wErn4cS+QaielSYgQbJ7NKH
	 PwKP3aaVB1XNwKGJnoFPPHZlNCf3VvstXQRjLB91b6YAF5+qEeQH5WW4aAsBZarAZg
	 78MQ943eM4SFLhJOIvgSUAFod8BN4JtP1Uy0g0N2gYej8NmtWaVma9fQOJdhDbdeR/
	 AOSA9uuMVI/GQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 2/8] perf/core: Add BUILD_ID_OFFSET to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807071818.718751-3-irogers@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807071818.718751-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 07:42:56 +0000
Message-Id: <20260807074257.0305E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The commit introduces `PERF_SAMPLE_BUILD_ID_OFFSET` and `PERF_SAMP=
LE_CALLCHAIN_BUILD_ID_OFFSET` to the UAPI and bumps `PERF_SAMPLE_MAX`, but =
fails to implement the corresponding sample generation logic in the core ke=
rnel.
- [Medium] The UAPI header update is applied inconsistently between `includ=
e/` and `tools/include/`, causing divergence and leaving the canonical kern=
el header undocumented.
- [Medium] The ABI documentation comment references `struct build_id`, an u=
ndeclared structure in the canonical UAPI headers, resulting in an opaque a=
nd confusing binary layout.
--

--- Patch [2]: [RFC PATCH v1 2/8] perf/core: Add BUILD_ID_OFFSET to UAPI ---
commit 16454ab98fa038eb527938712933e7e488db3d27
Author: Ian Rogers <irogers@google.com>

perf/core: Add BUILD_ID_OFFSET to UAPI
   =20
This commit introduces PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET to the UAPI and bumps the internal
validation limit.

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_ev=
ent.h
> index fd10aa8d697f2..f0712c1471d3d 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -165,8 +165,10 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_DATA_PAGE_SIZE		=3D 1U << 22,
>  	PERF_SAMPLE_CODE_PAGE_SIZE		=3D 1U << 23,
>  	PERF_SAMPLE_WEIGHT_STRUCT		=3D 1U << 24,
> +	PERF_SAMPLE_BUILD_ID_OFFSET		=3D 1U << 25,
> +	PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET	=3D 1U << 26,
> =20
> -	PERF_SAMPLE_MAX =3D 1U << 25,		/* non-ABI */
> +	PERF_SAMPLE_MAX =3D 1U << 27,		/* non-ABI */
>  };

[Severity: High]
Since PERF_SAMPLE_MAX is increased, perf_copy_attr() will now accept these
new sample types from userspace. However, is there missing core kernel logic
to actually process these bits?

Looking at the core kernel code, perf_output_sample() and
__perf_event_header_size() appear to lack handlers for the new bits. If a
userspace application requests these fields, it seems the kernel will not
allocate space for them or write them to the ring buffer.

When the userspace parser subsequently decodes the stream based on the
attr.sample_type bitmask, won't it read past the end of the truncated sample
and misinterpret the next event header as data?

> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index 2479a38883d00..d5660e2d6b603 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h

[ ... ]

> @@ -1054,6 +1056,13 @@ enum perf_event_type {
>  	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
>  	 *	{ u64			size;
>  	 *	  char			data[size]; } && PERF_SAMPLE_AUX
> +	 *	{ struct build_id	bid;
> +	 *	  u64			offset; } && PERF_SAMPLE_BUILD_ID_OFFSET

[Severity: Medium]
It looks like this payload documentation block was only added to the tools
side header (tools/include/uapi/linux/perf_event.h). Was it intended to be
added to the canonical include/uapi/linux/perf_event.h as well?

Missing the canonical header causes divergence between the kernel and tools
headers, which might trigger check-headers.sh warnings and leave users rely=
ing
on the kernel headers without documentation for the new ABI.

[Severity: Medium]
Also, regarding the struct build_id payload documentation here, this struct=
ure
appears to be undeclared in the canonical kernel UAPI header.

Does the use of struct build_id here collide with the internal tools struct=
ure
of the same name? The internal tools/perf/util/build-id.h structure has a
layout of:

  u8 data[20];
  u8 size;

Whereas the ABI typically uses a different layout (e.g., u8 size; u8 res1;
u16 res2; u8 data[20];). Could this cause layout confusion for tool develop=
ers
attempting to parse the ABI?

> +	 *	{ u64			nr;
> +	 *	  struct {
> +	 *		struct build_id	bid;
> +	 *		u64 offset;
> +	 *	  }[nr]; } && PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			=3D 9,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807071818.7187=
51-1-irogers@google.com?part=3D2
