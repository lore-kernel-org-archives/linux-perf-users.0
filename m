Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822539;
	b=yFEwS+58yUog/Aou+nZpHFaJ44pzq+nmxwnZoTDRNIOafqHC3JtNuzgczRE/ZvnPn1Y+
	 cMsMRgGNIPUE8nYNAZApZOk15oQcQxWho0wNT3vUu7Q6fhKsd6/V2+adnPmyp9OCaj3pP
	 DuD+HJmJ04HClDuxnR3F9l5qreY9/fQxke1r6Vu53cVO25Q5yUjyJkZ/SseFWs/9/lJqe
	 HukYnCTL/J7tUtceM4i0ZI45DusJE6Lj78yqtf9WQWv/egCcDHKlaICrScKEhHyWB2mKc
	 7saHe/E9Tmo/PdgnVJzhFQfw2Gjej/+xCrVBBMQqAkOnLuczNFxIpxNTtorFzdn0Caw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822539;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZxpDKOl/G+AtD/GcW8ror8whKXEyMxooooWhBhbV+H0=;
	b=dXjGtPwY1gOkOVb1QrxExkMH/ZBl8FO0M0ZLnL4voAlqupCDrfqmuGuH5kU/JZXoWW3f
	 lkCLO74YKH4jr3P1nLTA6IJmQxCErjXBV6D/7NKUgKvqXlOkhaCPFFZh9+Ix3ubObGrXu
	 DYxIkjSEAj0lGZye590zn4Rzs5RLzPXBCb1RNXOddQfkfBQoa4CnV9nEeMpSeQBani0Vi
	 pu0CQDOmfJJqqcSSZi6jdIQABwtojSZBcCjatv41Y+L59OWmFK1nHA0nCcIggbiN1Oqt9
	 SryxlEwgciv2KvmuLn/UahVBrs901dOYnZcoGIM1eIV4g3uxK1Y6QY2y5/1Cf+ADcFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsIhnOfY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBDB606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsIhnOfY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6E81F000C4;
	Mon, 16 Nov 2026 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822539;
	bh=ZxpDKOl/G+AtD/GcW8ror8whKXEyMxooooWhBhbV+H0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TsIhnOfYIxGZxhlxAuuQdTSewsDw9MzxIRRJyJjcsRnA3V+eTvQi13fNubR0B72FB
	 QzDWxeXVQi+XiCCK+OD/FYchNao0CPI6G0rcjq0KRUctSnoCvbUeVUGJT2fZp14TFq
	 03Y3UhCt9tb0wzkNnSDHz5Az/Ry2PvfdbUby6u1vOH4ftuhugohLsUdRXdd4FNDcVN
	 fEqMBHaetzU+VQ/onjXoyK29OKhPeBVpOIJZrfGQZMlo/8gwBAL4IfHNY6HIxPgFas
	 b2FCNiwQOjARcLf6B1m0G0T+y6pao/qX+Nn+lE+07c8OqL7FvVhJhPC/+47kF5jWjU
	 rvANyeAShxolw==
Message-ID: <sashiko-outbox-216640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf intel-pt: Save the reference window used to detect
 snapshot wraps
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261116092650.1714-1-lirongqing@baidu.com>
References: <20261116092650.1714-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:48:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf intel-pt: fixed tail window in intel_pt_wrapped()
  falsely detects wraps
--

commit db3c47adedfe1494edbb28fa120460d2030e1f73
Author: Li RongQing <lirongqing@baidu.com>

perf intel-pt: Save the reference window used to detect snapshot wraps

This commit changes intel_pt_wrapped() to copy the snapshot reference buffer
from ref->ref_offset + ptr->snapshot_ref_buf_size instead of head.

> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/ut=
il/intel-pt.c
> index 4c183ccf4e5b6..f034e3d55051a 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -1092,7 +1092,7 @@ static bool intel_pt_wrapped(struct intel_pt_record=
ing *ptr, int idx,
>  				       data, head);
> =20
>  	intel_pt_copy_ref(ref->ref_buf, ptr->snapshot_ref_buf_size, mm->len,
> -			  data, head);
> +			  data, ref->ref_offset + ptr->snapshot_ref_buf_size);
> =20
>  	return wrapped;
>  }

[Severity: Medium]
Does keeping ref->ref_offset fixed at the end of the AUX buffer cause
intel_pt_wrapped() to falsely report wraps?

intel_pt_alloc_snapshot_ref() initializes ref->ref_offset to
mm->len - ptr->snapshot_ref_buf_size (the window immediately preceding the
initial head at 0).  With ref->ref_offset never updated, ref_end in
intel_pt_compare_ref() is always mm->len:

tools/perf/arch/x86/util/intel-pt.c:intel_pt_compare_ref() {
	size_t ref_end =3D ref_offset + ref_size;

	if (ref_end > buf_size) {
		if (head > ref_offset || head < ref_end - buf_size)
			return true;
	} else if (head > ref_offset && head < ref_end) {
		return true;
	}

	return intel_pt_compare_buffers(ref_buf, ref_size, data, ref_offset,
					buf_size);
}

Whenever a snapshot is taken with head in (ref_offset, mm->len),
intel_pt_compare_ref() unconditionally returns true before comparing
ref_buf, even before the first wrap or when head has not moved at all.  In
addition, any later snapshot whose trace merely crosses the end of the AUX
buffer from *old <=3D ref_offset to *head < *old overwrites that fixed tail
window and triggers wrapped =3D true without having wrapped a full mm->len
around *old.

When wrapped is true, intel_pt_find_snapshot() sets *old =3D *head and
*head +=3D mm->len instead of advancing from the previous *old, so
__auxtrace_mmap__read() emits unwritten zero bytes before the first wrap or
re-emits stale trace bytes that were already recorded in earlier snapshots.

Instead of copying the fixed window at the end of the buffer,
intel_pt_wrapped() should keep copying the window preceding head and update
ref->ref_offset to match (head - ptr->snapshot_ref_buf_size, wrapped modulo
mm->len).  Note that with a sliding ref->ref_offset that can wrap across
mm->len, intel_pt_compare_buffers() also needs part_size =3D buf2_size - of=
fs2
rather than end2 - buf2_size to avoid reading past buf2 + buf2_size, and the
head < ref_size branch of intel_pt_copy_ref() needs to place the tail segme=
nt
data + buf_size - (ref_size - head) at the start of ref_buf followed by
data[0..head) so the two halves match the order expected by
intel_pt_compare_buffers().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116092650.1714=
-1-lirongqing@baidu.com?part=3D1
