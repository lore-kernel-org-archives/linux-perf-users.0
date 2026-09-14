Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45830ACE6
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351307; cv=none; b=DtnqE4/atY+Arx82mPzYrelfeAgkb6pA2uRTHzxJV4oPw8hwdYwd/O8VNtXOkrOhEd6Iyj0zmELmVCzV1tM0jqrMNoYuLvaRt1AxtzxTmN01xZanET6f57X2nSm8OJ6t2l9YqPwilFC5XqGkd1vahRL+seZ2gr2VSKQ+DpZD0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351307; c=relaxed/simple;
	bh=q/JoIO8fgrC0/7bzBkgTt0Uk9OGmTcU+nSx9yPcSEF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YGOcbRP4AR428OabjpWr3w6NRtBawyAcXF1xT4VDcgxB2J8nR8UuE1L537DTVv0i8ne6hzotH9UgXQOfh6HlftlUWSA2qeNaQe5aiffVBkImqOa3YzglSnztKRcOLmsEycL23hLlrX5XfzfRhdc/Z4zOmTjSIHfE2exVRNd5UMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZQo3rXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZQo3rXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEE91F000FF;
	Mon, 14 Sep 2026 02:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789351305;
	bh=5NKV7VLpJiV3S2SE31rSRJtlG/LilfsLEyTXtHdr04Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZQo3rXsUyC8TwGXS07WYc7g/5quftKg3wcYA9FusDPo4KNFTzGQWp7xa7DRQFRAZ
	 oAoUf2al0dN3GiCgBRO3LQaYYajH5CI2AU426KLtUfb+BLcOMndsGLI8ydTpzxIP2c
	 b3XwbdgKifWewpfvRx2mqq+E0guEXNwErCnRuLfmvgyVEtbNBZYd5geSz3wMnHFNXI
	 1p9E68xAYZETtX7avvyxwQ3YSFnV588mFoDD9Dn64LRaBqXJBgrzwUB1OGm0HQHBkc
	 b8rJ5vCofyPNuMxg9wTSmiBIBnURCXXAqNIBXp/7KIFSLy8k4RvOAeBKyqc+i9CBMV
	 SneVBzgiV0j0g==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 04/10] perf headers: Sync perf_event.h/perf_regs.h
 with the kernel headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-5-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:01:44 +0000
Message-Id: <20260914020145.4DEE91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Sample parser in ASLR tool fails to consume the new SIMD register =
payload when PERF_SAMPLE_REGS_ABI_SIMD is set, leading to stream desynchron=
ization.
- [Low] perf_event_attr__fprintf() prints the newly added SIMD fields out o=
f struct layout order.
--

commit 2a8ebff44960ffb0cedfa7b327d5de5cc826d750
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf headers: Sync perf_event.h/perf_regs.h with the kernel headers

Sync the UAPI header changes of supporting SIMD/eGPRs/SSP sampling into
corresponding tools UAPI headers. Additionally, support the newly introduced
perf_event_attr fields in the perf_event_attr__fprintf and
perf_event__attr_swap() helpers.

> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index fd10aa8d697f2..c49fc76292f79 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h

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
>  	 *

[Severity: High]
Does this new ABI payload cause stream desynchronization in
tools/perf/util/aslr.c?

When PERF_SAMPLE_REGS_ABI_SIMD is set, aslr_tool__process_sample() fails to=
=20
advance the payload pointer over the extended SIMD struct:

tools/perf/util/aslr.c:aslr_tool__process_sample() {
	...
	if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
		u64 abi;

		if (CHECK_BOUNDS(1, 0)) {
			ret =3D -EFAULT;
			goto out_put;
		}
		abi =3D in_array[i++];
		if (abi !=3D PERF_SAMPLE_REGS_ABI_NONE) {
			u64 nr =3D hweight64(orig_regs_user);

			if (nr > max_i - i) {
				ret =3D -EFAULT;
				goto out_put;
			}
			i +=3D nr;
		}
	}
	...
}

It appears the function skips standard registers by adding
hweight64(orig_regs_user) to the parser index, but misses parsing or skippi=
ng
the dynamically sized SIMD payload that follows. Can this leave unparsed
SIMD data in the stream, potentially corrupting subsequent fields?

A similar regression is present in the PERF_SAMPLE_REGS_INTR handling within
the same function.

Note that while other parsers like evsel.c were fixed in subsequent patches,
aslr.c appears to remain broken at the end of the series.

[ ... ]

> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index cc817294ad3d6..2e8be9a357dce 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -407,8 +407,17 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_e=
vent_attr *attr,
>  	}
>  	if (attr_size >=3D offsetof(struct perf_event_attr, config4))
>  		PRINT_ATTRf(config3, p_hex);
> -	if (attr_size > offsetof(struct perf_event_attr, config4))
> +	if (attr_size >=3D offsetof(struct perf_event_attr, sample_simd_regs_en=
abled))
>  		PRINT_ATTRf(config4, p_hex);
> +	if (attr_size > offsetof(struct perf_event_attr, sample_simd_vec_reg_us=
er)) {
> +		PRINT_ATTRf(sample_simd_regs_enabled, p_unsigned);
> +		PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
> +		PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
> +		PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
> +		PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
> +		PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
> +		PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
> +	}

[Severity: Low]
Does this print the newly added SIMD fields out of struct layout order?

The UAPI struct definition in tools/include/uapi/linux/perf_event.h places
sample_simd_vec_reg_qwords before sample_simd_pred_reg_intr:

tools/include/uapi/linux/perf_event.h:struct perf_event_attr {
	...
	__u16	sample_simd_regs_enabled;
	__u16	sample_simd_pred_reg_qwords;
	__u16	sample_simd_vec_reg_qwords;
	__u16	__reserved_4;

	__u32	sample_simd_pred_reg_intr;
	__u32	sample_simd_pred_reg_user;
	...
}

However, the fprintf code above prints sample_simd_vec_reg_qwords after both
sample_simd_pred_reg_intr and sample_simd_pred_reg_user. Could this cause
minor confusion when debugging raw perf_event_attr fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D4
