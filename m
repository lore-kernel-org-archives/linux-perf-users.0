Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD0399CF0
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564457; cv=none; b=gqBKAq/zLRSJhxSYSxlyqmWEK5FMDRGvdPF4qB3cuIITpVpS8XtcW4trHlQ3ExElpnI6E0eVui57+NIK518ab0kmUf327RzATHNuGG69PPyUo1QKmwsMXoZfa/1nmyMK1rCk+zttORnejq6IR8Qmgg1T6DawavtuuAHiACLubb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564457; c=relaxed/simple;
	bh=NB96gqq+7ru35/cJ8df+WCEZIbJfb0c4d+tAAYzeJMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lnlV6zJxeQcTCKp6WkkHLl702N3dW9X1ZJMTuVMxY1BiHIT5NzwglKuwUH3n2QhwNozbiqhDe0PUQIldHOZGJervWNv7tKD86eIo9LxJ5H4rcvgIn+l6M4Io4G2fuP3HF/vQzptQoK/q2pWzKf3+TunSqDaH3EUdnkic6K25FDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqnoOoHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqnoOoHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5347E1F000E9;
	Mon, 24 Aug 2026 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787564452;
	bh=sZo0Hz9PSqUpyU55BiDMY1DIT4+a18qfsi14R3nCSng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UqnoOoHNcpr/2JgSd5WsFeUjwBZJXTKiGiBpgBqD9NOp3J5soC/6owU2wLNvr5P1r
	 G/HVxwx0dHIYBW1Oe24S/gibWDW+FX1JQEQsfxURPMvsrTrfXhobLwH/5lY8e6Rl/g
	 hsfPFi4CvYltRtKDkMdQYahB4bwH7rajDa4CwmUUpN2DAeksKu/7uZbAJ7DbmnB1Sk
	 jI6TVNdVfc58FCylVJ8xJ8J/5PMT0OQJqr5r8g47aaQDVYUde2dlvFWJbmungcyPEj
	 WjdD1h0s6gApkP0m+QmTLvA12LGO1UpHM7IxGpHcjL6m8Cq2S9LT6Q/zAiJUHP3h8m
	 M9RcCRSBepi4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf powerpc-vpadtl: Validate dispatch/preempt reason
 indices before array access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yan" <wangyan01@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824092513.1149554-1-wangyan01@kylinos.cn>
References: <20260824092513.1149554-1-wangyan01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:40:51 +0000
Message-Id: <20260824094052.5347E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing array bounds validation in `perf_sample__fprintf_synth_vpa=
dtl()` allows out-of-bounds reads.
- [High] Truncated synthetic event payload in `powerpc_vpadtl_sample()` cau=
ses out-of-bounds reads.
- [High] Missing `data->raw_size` validation before casting synthetic event=
 payload.
- [High] Malformed auxtrace payload causes an infinite loop and Denial of S=
ervice in `powerpc_vpadtl_decode_all()`.
- [High] Integer underflow in `vpaq->buf_len` leads to sequential out-of-bo=
unds heap reads.
--

--- Patch [1]: [PATCH] perf powerpc-vpadtl: Validate dispatch/preempt reaso=
n indices before array access ---
commit 37f4363a27347aafccca23e130fa06b67b99b785
Author: Wang Yan <wangyan01@kylinos.cn>

perf powerpc-vpadtl: Validate dispatch/preempt reason indices before array =
access

This commit addresses an out-of-bounds read vulnerability in the=20
powerpc_vpadtl_dump() function. It correctly bounds the dispatch_reason and=
=20
preempt_reason indices against ARRAY_SIZE() when parsing untrusted auxtrace=
=20
payloads, falling back to "unknown" for out-of-range values.

> diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-v=
padtl.c
> index 710f3093f3f90..6be04fbcd6b77 100644
> --- a/tools/perf/util/powerpc-vpadtl.c
> +++ b/tools/perf/util/powerpc-vpadtl.c
> @@ -113,8 +113,10 @@ static void powerpc_vpadtl_dump(struct powerpc_vpadt=
l *vpa __maybe_unused,
>  			printf("dispatch_reason:%s, preempt_reason:%s, "
>  					"enqueue_to_dispatch_time:%d, ready_to_enqueue_time:%d, "
>  					"waiting_to_ready_time:%d\n",
> -					dispatch_reasons[dtl->dispatch_reason],
> -					preempt_reasons[dtl->preempt_reason],
> +					dtl->dispatch_reason < ARRAY_SIZE(dispatch_reasons)
> +						? dispatch_reasons[dtl->dispatch_reason] : "unknown",
> +					dtl->preempt_reason < ARRAY_SIZE(preempt_reasons)
> +						? preempt_reasons[dtl->preempt_reason] : "unknown",
>  					be32_to_cpu(dtl->enqueue_to_dispatch_time),
>  					be32_to_cpu(dtl->ready_to_enqueue_time),
>  					be32_to_cpu(dtl->waiting_to_ready_time));

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the exact same
missing bounds check exists in perf_sample__fprintf_synth_vpadtl() in
tools/perf/builtin-script.c.

tools/perf/builtin-script.c:perf_sample__fprintf_synth_vpadtl()
    len =3D fprintf(fp, "timebase: %" PRIu64 " dispatch_reason:%s, preempt_=
reason:%s,\n"
            "enqueue_to_dispatch_time:%d, ready_to_enqueue_time:%d,"
            "waiting_to_ready_time:%d, processor_id: %d",
            get_unaligned_be64(&dtl->timebase),
            dispatch_reasons[dtl->dispatch_reason],
            preempt_reasons[dtl->preempt_reason],

Is it possible to apply the same ARRAY_SIZE() validation there as well to
prevent an out-of-bounds read when parsing the synthetic event payload?


[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with how
the synthetic event payload is sized in powerpc_vpadtl_sample():

tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_sample()
    sample.raw_data =3D record;
    sample.raw_size =3D sizeof(record);

Since record is a pointer (struct powerpc_vpadtl_entry *), wouldn't
sizeof(record) evaluate to 8 bytes instead of the actual structure size?

When perf_sample__fprintf_synth_vpadtl() accesses fields like timebase,
could this truncated payload cause out-of-bounds heap reads?


[Severity: High]
This is a pre-existing issue, but could the unconditional cast in
perf_sample__fprintf_synth_vpadtl() lead to out-of-bounds memory accesses?

tools/perf/builtin-script.c:perf_sample__fprintf_synth_vpadtl()
    struct powerpc_vpadtl_entry *dtl =3D (struct powerpc_vpadtl_entry *)dat=
a->raw_data;

If a truncated or malformed event is read from an untrusted perf.data file,
data->raw_size isn't verified. Should this function call
perf_sample__bad_synth_size() to validate the payload size before accessing
its fields?


[Severity: High]
This isn't a bug introduced by this patch, but could a malformed auxtrace
payload cause an infinite loop in powerpc_vpadtl_decode_all()?

tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_decode_all()
        if ((long long)be64_to_cpu(vpaq->dtl->timebase) <=3D 0) {
            if (vpaq->pkt_len !=3D dtl_entry_size && vpaq->buf_len) {
                vpaq->pkt_len +=3D dtl_entry_size;
                vpaq->buf_len -=3D dtl_entry_size;
            }
            return -1;
        }

If timebase is <=3D 0 and pkt_len is exactly dtl_entry_size, the pointers a=
re
not advanced before returning -1. Since the caller
powerpc_vpadtl_run_decoder() loops continuously on error, does this repeate=
dly
parse the exact same buffer state and cause a denial of service?


[Severity: High]
This is a pre-existing issue, but I noticed a potential unsigned integer
underflow in powerpc_vpadtl_decode_all():

tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_decode_all()
        vpaq->pkt_len +=3D dtl_entry_size;
        vpaq->buf_len -=3D dtl_entry_size;

If the auxtrace buffer is smaller than dtl_entry_size,
powerpc_vpadtl_get_buffer() calculates vpaq->buf_len as 0. Because buf_len =
is
unsigned, wouldn't 0 - dtl_entry_size underflow to a huge value? Could this
cause subsequent iterations to bypass buffer fetching logic and sequentially
read out-of-bounds heap memory in 48-byte chunks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824092513.1149=
554-1-wangyan01@kylinos.cn?part=3D1
