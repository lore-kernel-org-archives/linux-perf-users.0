Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6F34753F;
	Mon,  4 May 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915418; cv=none; b=mv4U4W0N6uXSJRC/7lFAzudE0m1XXh6FMU5BwxjJeL+nWoC285XIF/13omO/P+LElrkngzAFoACnThLt29OgtAg8yutovQtihregGgFPHmJuJFnz0Swr4AdjgCBldK3WNurN7nC1C6kxRXwunNs0vPKZs1WPUcnX8MwMXQGEkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915418; c=relaxed/simple;
	bh=mH1LVGA0VfUcQfpruNHDILRsuMFRJp/gfCTx6B1B92o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MS3SEFrE22PxvFACbfnH5V0h0nUI8bWL+e05Lr4RkbzoctKHLu0v6rw/Hm41eeHFuupa/IgWJVeirYHIVqL+M0wZ09R8ovwJ44GjAn31nG7ygeGzg4gh0bZRuTKPFuC9R0rwhFKlk2y0H9vkcN0aQpbA79evi/jH0og7/bLZiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUtUinFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUtUinFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA50C2BCB8;
	Mon,  4 May 2026 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777915418;
	bh=mH1LVGA0VfUcQfpruNHDILRsuMFRJp/gfCTx6B1B92o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pUtUinFpGKfedtm1AvUPYRZ1f5I0aCMNb/DBBSe67Cud0ZtnWuWJj0fwDAZ1oMcLr
	 /hNFnWuWF5WWZcD+vUv5oucqbTDqIhnrusoS3gcykQ4yRwK1k+PxcSCF5B+AFlG2jR
	 uZL/uxHNUBuILTn2iVlxW8HWH4aVZ/iCBz8VzKYDLpAKl173bNOWbkfqulDMrVEDb3
	 ta1ok0dwDlxrkXFvS4ls93GQM0D3cqvHqSL5nOpp9XZ/gRYn66EFDob2+WHarV50dS
	 brBsg3MFNmWl1vs+4PxX8Y9a+GrXbpogIj1l6kUQ+lmSD+0BdSOtSoo1Nb6ZMQaeSj
	 Ci2nY7weTvyoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] perf/lock: Fix non-atomic max/time and min_time
 updates in contention_data
Reply-To: sashiko@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260504135138.17050-1-suchitkarunakaran@gmail.com>
References: <20260504135138.17050-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 17:23:37 +0000
Message-Id: <20260504172338.6FA50C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The use of `__sync_val_compare_and_swap` introduces a compiler depe=
ndency on BPF ISA v3, breaking the `perf` tool build on older toolchains.
--

commit 30820839a2cfcfa987fbc2e0f79fa0e2f2cf0dc3
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

perf/lock: Fix non-atomic max/time and min_time updates in contention_data

This commit replaces bare conditional assignments with a bpf_loop()-based C=
AS
retry loop to fix non-atomic updates of max_time and min_time.

> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 96e7d853b9edf..5c8431be674ac 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
[ ... ]
> @@ -486,16 +493,49 @@ static inline s32 get_owner_stack_id(u64 *stacktrac=
e)
>  	return -1;
>  }
> =20
> +static long cas_min_max_cb(u64 idx, void *arg)
> +{
> +	struct cas_ctx *ctx =3D arg;
> +
> +	if (!ctx->max_done) {
> +		u64 old_max =3D ctx->data->max_time;
> +		if (old_max >=3D ctx->duration) {
> +			ctx->max_done =3D 1;
> +		} else {
> +			u64 r =3D __sync_val_compare_and_swap(
> +				&ctx->data->max_time, old_max, ctx->duration);

Does this cause build failures on older toolchains?

The built-in __sync_val_compare_and_swap lowers to the BPF_CMPXCHG
instruction, which requires BPF CPU v3 (-mcpu=3Dv3).

The perf build system compiles BPF skeletons using the host compiler's defa=
ult
target features, without explicitly passing an -mcpu flag. On toolchains
where the default BPF target is v1 or v2 (such as Clang < 18), the compiler
may fail to generate the instruction and throw a fatal error (e.g.,
'hardware compare and swap not supported' or an unresolved libcall to
__sync_val_compare_and_swap_8).

> +			if (r =3D=3D old_max)
> +				ctx->max_done =3D 1;
> +		}
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504135138.1705=
0-1-suchitkarunakaran@gmail.com?part=3D1
