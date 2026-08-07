Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ABF327C13;
	Fri,  7 Aug 2026 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089287; cv=none; b=bYqYc57fqBicRFPQ9oyQH6KTp2uJQSPUVF2hKq6w4u3sCIqW6vSe8KK1i2mqfJX7OZU5XJ0dous9Hf1t8zay+hxazK2ThuKac0H+QPh2MF8gvucsjOlUa4pmpo/sop5jLLKh87n0jwNYTHhVWXWR+7bASywMNzjTOwD8t92ZU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089287; c=relaxed/simple;
	bh=dZK4z4Gt2TRACv5UEsJyYetx15YwZYdHkT4mSvRKVw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=indC1ixmWzuwctW8JuF92vLzKIsAbyVQE35lpCoXvmzNUz6cbMtRQK8qzF4CaWJvT16uKQXBREAr+aSECibRhcn9vfLzx1q0PDOu8prFFmw0NnipPEEAIlLDwQu56praTbghYdYZBKVUBl8wmJpSVG3LTMNmofZ46Lyi2/EftC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYibS/xZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYibS/xZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4555C1F000E9;
	Fri,  7 Aug 2026 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786089277;
	bh=rei/MiHlXSp/B9OjKNuhQMgRBvV1vW7vmxKFUoPQKGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYibS/xZjPkcaxXwEZYsr5HcxFijePMN1ppdPKYqAT9qhh1Z7Ri8lWBus4y/jcGB+
	 kqxvMvb0/fTbSF6NzdWUDSwadcvGpQ4eperF1ip+zEKiE9MAys39hqL/3H9bGPs3Q8
	 jMyy/yKZHKpQHP3nfgLhRJd6wLnAx8L/KmxcVro0of6jcJ3JGFT2XGHwIXbNnI4Nl0
	 5vQ7yFqqKwA/HRe1CZV1eyZiZjTqzNF1GI3bt2oWyA/qMt08ZSRWxgCC19OG4NuH5J
	 bCuiw7aRwg4VpgO5uHj8fLPQ05S6dJKroeIzkRTfky+YPmGxGqcvZH0tHuP+PSIxKB
	 Dss9BQOVb3foA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 3/8] perf/core: Implement BUILD_ID_OFFSET sample
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260807071818.718751-4-irogers@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807071818.718751-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 07:54:36 +0000
Message-Id: <20260807075437.4555C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] New perf sample fields are inserted into the middle of the sam=
ple output, violating ABI append-only structure expectations.
- [High] Kernel IPs are incorrectly classified as user IPs in callchains, r=
esulting in severe lock contention and expensive VMA tree lookups in NMI co=
ntext.
- [High] Iterating `stack_map_get_build_id_offset` across callchain IPs in =
a loop breaks its `irq_work` mechanism, preventing resolution of all but th=
e first IP.
- [High] The fallback stub for `stack_map_get_build_id_offset` incorrectly =
sets the status to `BPF_STACK_BUILD_ID_VALID`, causing perf to output zeroe=
d build IDs.
- [Low] Conflicting definitions of `stack_map_get_build_id_offset` cause a =
build failure when `CONFIG_BPF_SYSCALL` is enabled but `CONFIG_PERF_EVENTS`=
 is disabled.
--

--- Patch [3]: [RFC PATCH v1 3/8] perf/core: Implement BUILD_ID_OFFSET samp=
le type ---
commit 230345e68f9a75e56416ae7796d505b712c39458
Author: Ian Rogers <irogers@google.com>

perf/core: Implement BUILD_ID_OFFSET sample type

Expose stack_map_get_build_id_offset for perf_events to use when generating
these samples, and implement the payload writing in the perf event core.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f65284456..fd76900a8e476 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4209,4 +4209,17 @@ static inline int bpf_map_check_op_flags(struct bp=
f_map *map, u64 flags, u64 all
>  	return 0;
>  }
> =20
> +struct bpf_stack_build_id;
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PERF_EVENTS)
> +void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> +				    u32 trace_nr, bool user, bool may_fault);
> +#else
> +static inline void stack_map_get_build_id_offset(struct bpf_stack_build_=
id *id_offs,
> +						  u32 trace_nr, bool user, bool may_fault)

[Severity: Low]
Can this conditionally defined static inline stub cause a build failure?

When the kernel is compiled with CONFIG_BPF_SYSCALL=3Dy but
CONFIG_PERF_EVENTS=3Dn, this header provides a static inline stub. However,
kernel/bpf/stackmap.c unconditionally defines the non-static version of
stack_map_get_build_id_offset() when CONFIG_BPF_SYSCALL=3Dy, leading to a
redefinition error.

> +{
> +	if (id_offs)
> +		id_offs->status =3D 1; /* BPF_STACK_BUILD_ID_EMPTY */

[Severity: High]
Does this fallback stub incorrectly set the status to
BPF_STACK_BUILD_ID_VALID?

The value 1 corresponds to BPF_STACK_BUILD_ID_VALID, not
BPF_STACK_BUILD_ID_EMPTY (which is 0).

Because the status is marked as valid, when CONFIG_PERF_EVENTS is
disabled or in other fallback scenarios, perf_output_sample() will copy
the zero-initialized build_id buffer into the perf event instead of
properly reporting the raw IP.

> +}
> +#endif
> +
>  #endif /* _LINUX_BPF_H */

[ ... ]

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7b..97ac70441602d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8287,6 +8301,62 @@ void perf_output_sample(struct perf_output_handle =
*handle,
>  	if (sample_type & PERF_SAMPLE_READ)
>  		perf_output_read(handle, event);
> =20
> +	if (sample_type & PERF_SAMPLE_BUILD_ID_OFFSET) {

[Severity: Critical]
Does placing this output logic before PERF_SAMPLE_CALLCHAIN violate the ABI
append-only structure expectations?

The Linux perf sample ABI relies on fields being ordered exactly
corresponding to the bit-order of the PERF_SAMPLE_* flags. New flags with
higher bit indices must have their payloads appended to the end of the
sample structure.

By inserting the payload for PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET here in perf_output_sample() before
PERF_SAMPLE_CALLCHAIN, parsers reading sequentially will misalign their
offsets. They may treat build ID data as callchain metadata, causing memory
corruption or crashes in user space.

> +		struct bpf_stack_build_id bpf_bid =3D { .ip =3D data->ip };
> +		struct perf_sample_build_id_offset bid_offset =3D { 0 };

[ ... ]

> +	if (sample_type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
> +		u64 nr =3D data->callchain ? data->callchain->nr : 0;
> +		struct perf_sample_build_id_offset bid_offset;
> +		struct bpf_stack_build_id bpf_bid;
> +		u64 i;
> +
> +		perf_output_put(handle, nr);
> +
> +		for (i =3D 0; i < nr; i++) {
> +			memset(&bid_offset, /*c=3D*/0, sizeof(bid_offset));
> +			memset(&bpf_bid, /*c=3D*/0, sizeof(bpf_bid));
> +			bpf_bid.ip =3D data->callchain->ip[i];
> +
> +			if (data->callchain->ip[i] =3D=3D PERF_CONTEXT_USER) {
> +				bpf_bid.status =3D BPF_STACK_BUILD_ID_EMPTY;
> +			} else {
> +				bool is_user =3D data->callchain->ip[i] < PERF_CONTEXT_MAX;

[Severity: High]
Does this logic incorrectly classify standard kernel IPs as user IPs?

In perf_output_sample(), when processing
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET, this checks if the IP is less than
PERF_CONTEXT_MAX. Since standard kernel instruction pointers are less than
the PERF_CONTEXT_MAX marker (which is used for context boundary markers
like PERF_CONTEXT_USER), this evaluates to true for all kernel IPs.

Calling stack_map_get_build_id_offset() with user=3Dtrue for kernel IPs
forces an mmap_read_trylock(current->mm) and a VMA tree traversal inside an
NMI for every kernel IP. Can this cause severe lock contention and
expensive VMA tree lookups?

> +
> +				stack_map_get_build_id_offset(&bpf_bid, /*trace_nr=3D*/1,
> +					      is_user, /*may_fault=3D*/false);

[Severity: High]
Does iterating stack_map_get_build_id_offset() across callchain IPs in a
loop break its irq_work mechanism?

Inside perf_output_sample() running in NMI context,
stack_map_get_build_id_offset() acquires a per-CPU irq_work to defer
mmap_read_unlock(). On the first iteration, the lock is acquired and the
irq_work is queued.

On the second iteration, bpf_mmap_unlock_get_irq_work() detects that the
per-CPU irq_work is already busy (since the NMI has not exited to process
it). This prevents resolution of all but the first user IP in a callchain,
silently falling back to raw IPs for the rest.

> +			}
> +
> +			if (bpf_bid.status =3D=3D BPF_STACK_BUILD_ID_VALID) {
> +				bid_offset.size =3D BPF_BUILD_ID_SIZE;
> +				memcpy(bid_offset.build_id, bpf_bid.build_id,
> +			       BPF_BUILD_ID_SIZE);
> +				bid_offset.offset =3D bpf_bid.offset;
> +			} else {
> +				bid_offset.offset =3D bpf_bid.ip;
> +			}
> +			perf_output_put(handle, bid_offset);
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807071818.7187=
51-1-irogers@google.com?part=3D3
