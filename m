Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00AA13A86C
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358110; cv=pass; b=sa1Xa11bP2EsaEwB/QrxETbyF0SYpjYXD6yAIU3U/a5IsLUxNKRJbEntU49JuA0P8OhucASlveoeEnEG2XfdHjzwHKWvrqSrIU6Rw0WQCxmiFiykzepP0Zkhj+ajQdPCC7lEZQcnOOn6J6ZDLskFw+1aRRlvQ/xrI6m/KhbnuSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358110; c=relaxed/simple;
	bh=GHLBAhgVkbMqfVDRUQMKhX3xfMn2w8iUBDL3cksRB/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5H8CM/bhKbSfzlShrNLNIDO1lRvd98fD2a2Zw/4tsFnE3i/i4C5oUCMdLEo3MBbaiy6Vi5dEIsbqKqrgNA8FjOwW6mOtgQ0aARpHmhSK3ms/ykzhgIJqFeEFbKM3dCgpSz9RXvZkpULXKHljIRUutkHdKD929C0iCUMIn+aQPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEBDeRNK; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEBDeRNK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacef7d299so13635ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 10:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783358108; cv=none;
        d=google.com; s=arc-20260327;
        b=D2uYg0Lr8F7+cVVYwf4O4//BGtPxfgi03Eik4XOfbLYXJHnSM1up0s/F2zr8nVMVI2
         W1vwWE2mK2xcttWAiv++KTTn2QxGo1Eu2fy2IWwGx13/HCk38FQ8B7GGzYpxIc8T+jt9
         YLESKbBXKGlPE3vTJaOU4HK6E8d2tywmb9L7c22DXBQ7o15/zwT0MTcDO7urzgDKyJTt
         Kka2jtwbDOoO1/g0f+mJxssj7v7+QObdyXD+bJMWt115kvC0DM06wPa00OtSMstupzBX
         7x7XI0lmXJXiDSk7g1IJkYp1vUdbImKvDmATQoz+xn8rXxKTCctVH/QSfuHpmTGatel2
         +XHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yk8CLQzAoBsqycrXH4mDE2fYNz+0AVKKJ1saVJqjqVI=;
        fh=kIeyJsaM9fkRF76QCYKIeNGSS1/shsKEHJO0YeZZ+54=;
        b=VhZTrLCk5aDuT7sTGP05pH/QNgXsHmQojnK653icFjaDH1G1fRHmtBo+WbgN5Wn2sl
         FMyaHuSjAwDgRPjt1ucv+EUfMZBeTXQB5MqQo5oKr6qAxwoeoPmoF2snP5etNOmUBc8D
         CxNe8YvyRVaNoIATYEtmZMtueUI9yEsPr356QuEtq6F1DFX6B5w592C1jm17jIYlztsz
         tg6nJbElQnNMSMGwWSnOfHBjyMKsVEdmbKh5PfssxiGeBYuRevPmzQRc1qqGBT1st1gt
         zS/MBWzz9GcfuFtQAxa8nRMTTWMgXQXfItPbXEMO4XIVHHSn8XVjdRxcpV7A8mpv/Tyt
         KEWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783358108; x=1783962908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yk8CLQzAoBsqycrXH4mDE2fYNz+0AVKKJ1saVJqjqVI=;
        b=QEBDeRNK3NAs/TZdV+zJ9V2hvaqE9ZAyaalERY2ipypOW769Ifgqy2khxllPQplo4/
         CE8JoY2OMlH/SCk2Qpp0aCF1xC0rHI/s68vp3pxCjoS2JHRrcF9xvnfWWc6bGqjIKf+M
         1T/rrVgYJIMGWU5/4tR7ZOZs56Asp1WGQR9IDiADI3AZYvKJrmEShehVAgmd1zKNW3t2
         v1IM9LhToBIGibhdxgPCUx60Y7mpuwo3jY+ygAg4W/HVEpapS+aUgRUYcIixsupHgD9J
         FctXG9FbJRZNeXnUpXG/nyqwytbWRJcclJHxzskvlTx7S3RECEtbo8GgGCV9yBVocZnC
         w0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358108; x=1783962908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yk8CLQzAoBsqycrXH4mDE2fYNz+0AVKKJ1saVJqjqVI=;
        b=VTLPy/oGJ6gQsj3MPa5tzZQl9IqSBRF67o7Ji/BeTLVwdC4k2AsOgEQrHYdqNvF9Fs
         JSZB7PGM427mBoFKPUWBVY1K7uKOEK3v3K580N99OY6J1INVAEkDJ4DDS+kuulGXmSq1
         QhnAN3VkilHE3YZT5u7VRNDTBRMPg4OgZcdY2VXS9zF4t3NT6lEJhuOIxqayhdyTMSzC
         XGK5UxJNYu0hZTk9MnpJwPC9JmnTS6RIplKXwR0I/Cvu3TFrb33Qbgj+0u0oaH/8RwZF
         FSfgPFMitCaj966BaZYrnhQjWuvRa830U50AJAFHj3USvhdcYvIXOfvwxd50j/qYU2HM
         k3eA==
X-Gm-Message-State: AOJu0Yw3ui8kCZkAfw8Z1Hp5zKuh1FfCOFr9mNtfsL/OR/u78jBRuKJB
	ve01s4bzLTAo7ufU7n0U7oJQivarDDzPFPgCnmzvMsa99bwyxbkYwdjCGXwpZSAuU2gWQW/xbXN
	qmPHj83txBu7W1wRS1Z9h22kbyD8zczm+92zxFYax
X-Gm-Gg: AfdE7cnEMp5YL8XOluR2RpTIlipFwyyNOqVUjlxvZDx/MCoUZT9dAV89/S30cT4HyJR
	lsB0HJ9NHwTNhTh/7MPDkFIAGWEHe95ufiDQ8TmF6Gc/eoeTC5GvwB+L2SmJ1KJSRWGGiGWMRIc
	83TaSjT2RGA8Djo6ppOuHdKAs2HSXGrvKzkrhR5YvB2hudolkbx5/bePfQUZ+X+tHfgvOeA6Z00
	xEru3+C+a5xUequ8TTk3TqyDhvtXV81JmHF109BU0ULGzd99RhVow5c7QZAaLv61zfxUgDu+uQ6
	1YmOU1eu+lB5foM5LvaKzPvvcBg=
X-Received: by 2002:a17:902:ce8e:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2ccc4671ee5mr318125ad.7.1783358107381; Mon, 06 Jul 2026
 10:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
In-Reply-To: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Jul 2026 10:14:56 -0700
X-Gm-Features: AVVi8CecaUU5yFtrOu9tij45-2tn-ybZK1hKj13BQyRP0XD7a38wgEkc71Fnf4Y
Message-ID: <CAP-5=fV_czvd-z4N7K+_SabxuOm9UUHRyBxNuchrtAgJL3OqOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf vendor events amd: Update Zen 5 core events
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:28=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> Update definitions for the following events.
>   * PMCx00A - Add missing unit masks
>   * PMCx00B - Add missing unit masks and fix descriptions
>   * PMCx00C - Add missing unit masks
>   * PMCx00D - Add missing unit masks
>   * PMCx025 - Add missing unit masks and fix descriptions
>
> Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>
> Previous versions can be found at:
> v1: https://lore.kernel.org/all/f16d1391366762dee0d49f00697f5e6ea913e2c1.=
1780330378.git.sandipan.das@amd.com/
>
> Changes in v2:
>   * Fix event description pointed out by sashiko.
>
> ---
>  .../arch/x86/amdzen5/floating-point.json      | 130 +++++++++++++++---
>  .../arch/x86/amdzen5/load-store.json          |   8 +-
>  2 files changed, 120 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b=
/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> index 9204bfb1d69e..569975b53cc3 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> @@ -179,6 +179,30 @@
>      "BriefDescription": "Retired scalar floating-point blend ops.",
>      "UMask": "0x09"
>    },
> +  {
> +    "EventName": "fp_ops_retired_by_type.scalar_mov",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired scalar floating-point MOV ops.",
> +    "UMask": "0x0a"
> +  },
> +  {
> +    "EventName": "fp_ops_retired_by_type.scalar_shuffle",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired scalar floating-point shuffle ops (may =
include instructions not necessarily thought of as including shuffles e.g. =
horizontal add, dot product, and certain MOV instructions).",
> +    "UMask": "0x0b"
> +  },
> +  {
> +    "EventName": "fp_ops_retired_by_type.scalar_bfloat",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired scalar floating-point bfloat ops.",
> +    "UMask": "0x0c"
> +  },
> +  {
> +    "EventName": "fp_ops_retired_by_type.scalar_logical",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired scalar floating-point logical ops.",
> +    "UMask": "0x0d"
> +  },
>    {
>      "EventName": "fp_ops_retired_by_type.scalar_other",
>      "EventCode": "0x0a",
> @@ -245,12 +269,24 @@
>      "BriefDescription": "Retired vector floating-point blend ops.",
>      "UMask": "0x90"
>    },
> +  {
> +    "EventName": "fp_ops_retired_by_type.vector_mov",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired vector floating-point MOV ops.",
> +    "UMask": "0xa0"
> +  },
>    {
>      "EventName": "fp_ops_retired_by_type.vector_shuffle",
>      "EventCode": "0x0a",
>      "BriefDescription": "Retired vector floating-point shuffle ops (may =
include instructions not necessarily thought of as including shuffles e.g. =
horizontal add, dot product, and certain MOV instructions).",
>      "UMask": "0xb0"
>    },
> +  {
> +    "EventName": "fp_ops_retired_by_type.vector_bfloat",
> +    "EventCode": "0x0a",
> +    "BriefDescription": "Retired vector floating-point bfloat ops.",
> +    "UMask": "0xc0"
> +  },
>    {
>      "EventName": "fp_ops_retired_by_type.vector_logical",
>      "EventCode": "0x0a",
> @@ -278,7 +314,7 @@
>    {
>      "EventName": "sse_avx_ops_retired.mmx_add",
>      "EventCode": "0x0b",
> -    "BriefDescription": "Retired MMX integer add.",
> +    "BriefDescription": "Retired MMX integer add ops.",
>      "UMask": "0x01"
>    },
>    {
> @@ -299,16 +335,34 @@
>      "BriefDescription": "Retired MMX integer multiply-accumulate ops.",
>      "UMask": "0x04"
>    },
> +  {
> +    "EventName": "sse_avx_ops_retired.mmx_aes",
> +    "EventCode": "0x0b",
> +    "BriefDescription": "Retired MMX integer AES ops.",
> +    "UMask": "0x05"
> +  },
> +  {
> +    "EventName": "sse_avx_ops_retired.mmx_sha",
> +    "EventCode": "0x0b",
> +    "BriefDescription": "Retired MMX integer SHA ops.",
> +    "UMask": "0x06"
> +  },
>    {
>      "EventName": "sse_avx_ops_retired.mmx_cmp",
>      "EventCode": "0x0b",
>      "BriefDescription": "Retired MMX integer compare ops.",
>      "UMask": "0x07"
>    },
> +  {
> +    "EventName": "sse_avx_ops_retired.mmx_cvt",
> +    "EventCode": "0x0b",
> +    "BriefDescription": "Retired MMX integer convert or pack ops.",
> +    "UMask": "0x08"
> +  },
>    {
>      "EventName": "sse_avx_ops_retired.mmx_shift",
>      "EventCode": "0x0b",
> -    "BriefDescription": "Retired MMX integer shift ops.",
> +    "BriefDescription": "Retired MMX integer shift or rotate ops.",
>      "UMask": "0x09"
>    },
>    {
> @@ -324,9 +378,9 @@
>      "UMask": "0x0b"
>    },
>    {
> -    "EventName": "sse_avx_ops_retired.mmx_pack",
> +    "EventName": "sse_avx_ops_retired.mmx_vnni",

Just a heads up, when renaming events it may be a good idea to keep
the old name and mark the event as deprecated, then add the event
again with the new name. This avoids events breaking when the perf
tool is updated. Personally I feel vendors should get to decide about
this kind of thing, but there have been some strong sensitivities
around event names in the past.

Thanks,
Ian

>      "EventCode": "0x0b",
> -    "BriefDescription": "Retired MMX integer pack ops.",
> +    "BriefDescription": "Retired MMX integer VNNI ops.",
>      "UMask": "0x0c"
>    },
>    {
> @@ -390,15 +444,15 @@
>      "UMask": "0x70"
>    },
>    {
> -    "EventName": "sse_avx_ops_retired.sse_avx_clm",
> +    "EventName": "sse_avx_ops_retired.sse_avx_cvt",
>      "EventCode": "0x0b",
> -    "BriefDescription": "Retired SSE and AVX integer CLM ops.",
> +    "BriefDescription": "Retired SSE and AVX integer convert or pack ops=
.",
>      "UMask": "0x80"
>    },
>    {
>      "EventName": "sse_avx_ops_retired.sse_avx_shift",
>      "EventCode": "0x0b",
> -    "BriefDescription": "Retired SSE and AVX integer shift ops.",
> +    "BriefDescription": "Retired SSE and AVX integer shift or rotate ops=
.",
>      "UMask": "0x90"
>    },
>    {
> @@ -414,9 +468,9 @@
>      "UMask": "0xb0"
>    },
>    {
> -    "EventName": "sse_avx_ops_retired.sse_avx_pack",
> +    "EventName": "sse_avx_ops_retired.sse_avx_vnni",
>      "EventCode": "0x0b",
> -    "BriefDescription": "Retired SSE and AVX integer pack ops.",
> +    "BriefDescription": "Retired SSE and AVX integer VNNI ops.",
>      "UMask": "0xc0"
>    },
>    {
> @@ -497,12 +551,24 @@
>      "BriefDescription": "Retired 128-bit packed floating-point blend ops=
.",
>      "UMask": "0x09"
>    },
> +  {
> +    "EventName": "fp_pack_ops_retired.fp128_mov",
> +    "EventCode": "0x0c",
> +    "BriefDescription": "Retired 128-bit packed floating-point MOV ops."=
,
> +    "UMask": "0x0a"
> +  },
>    {
>      "EventName": "fp_pack_ops_retired.fp128_shuffle",
>      "EventCode": "0x0c",
>      "BriefDescription": "Retired 128-bit packed floating-point shuffle o=
ps (may include instructions not necessarily thought of as including shuffl=
es e.g. horizontal add, dot product, and certain MOV instructions).",
>      "UMask": "0x0b"
>    },
> +  {
> +    "EventName": "fp_pack_ops_retired.fp128_bfloat",
> +    "EventCode": "0x0c",
> +    "BriefDescription": "Retired 128-bit packed floating-point bfloat op=
s.",
> +    "UMask": "0x0c"
> +  },
>    {
>      "EventName": "fp_pack_ops_retired.fp128_logical",
>      "EventCode": "0x0c",
> @@ -575,12 +641,24 @@
>      "BriefDescription": "Retired 256-bit packed floating-point blend ops=
.",
>      "UMask": "0x90"
>    },
> +  {
> +    "EventName": "fp_pack_ops_retired.fp256_mov",
> +    "EventCode": "0x0c",
> +    "BriefDescription": "Retired 256-bit packed floating-point MOV ops."=
,
> +    "UMask": "0xa0"
> +  },
>    {
>      "EventName": "fp_pack_ops_retired.fp256_shuffle",
>      "EventCode": "0x0c",
>      "BriefDescription": "Retired 256-bit packed floating-point shuffle o=
ps (may include instructions not necessarily thought of as including shuffl=
es e.g. horizontal add, dot product, and certain MOV instructions).",
>      "UMask": "0xb0"
>    },
> +  {
> +    "EventName": "fp_pack_ops_retired.fp256_bfloat",
> +    "EventCode": "0x0c",
> +    "BriefDescription": "Retired 256-bit packed floating-point bfloat op=
s.",
> +    "UMask": "0xc0"
> +  },
>    {
>      "EventName": "fp_pack_ops_retired.fp256_logical",
>      "EventCode": "0x0c",
> @@ -648,15 +726,15 @@
>      "UMask": "0x07"
>    },
>    {
> -    "EventName": "packed_int_op_type.int128_clm",
> +    "EventName": "packed_int_op_type.int128_cvt",
>      "EventCode": "0x0d",
> -    "BriefDescription": "Retired 128-bit packed integer CLM ops.",
> +    "BriefDescription": "Retired 128-bit packed integer convert or pack =
ops.",
>      "UMask": "0x08"
>    },
>    {
>      "EventName": "packed_int_op_type.int128_shift",
>      "EventCode": "0x0d",
> -    "BriefDescription": "Retired 128-bit packed integer shift ops.",
> +    "BriefDescription": "Retired 128-bit packed integer shift or rotate =
ops.",
>      "UMask": "0x09"
>    },
>    {
> @@ -672,9 +750,9 @@
>      "UMask": "0x0b"
>    },
>    {
> -    "EventName": "packed_int_op_type.int128_pack",
> +    "EventName": "packed_int_op_type.int128_vnni",
>      "EventCode": "0x0d",
> -    "BriefDescription": "Retired 128-bit packed integer pack ops.",
> +    "BriefDescription": "Retired 128-bit packed integer VNNI ops.",
>      "UMask": "0x0c"
>    },
>    {
> @@ -719,16 +797,34 @@
>      "BriefDescription": "Retired 256-bit packed integer multiply-accumul=
ate ops.",
>      "UMask": "0x40"
>    },
> +  {
> +    "EventName": "packed_int_op_type.int256_aes",
> +    "EventCode": "0x0d",
> +    "BriefDescription": "Retired 256-bit packed integer AES ops.",
> +    "UMask": "0x50"
> +  },
> +  {
> +    "EventName": "packed_int_op_type.int256_sha",
> +    "EventCode": "0x0d",
> +    "BriefDescription": "Retired 256-bit packed integer SHA ops.",
> +    "UMask": "0x60"
> +  },
>    {
>      "EventName": "packed_int_op_type.int256_cmp",
>      "EventCode": "0x0d",
>      "BriefDescription": "Retired 256-bit packed integer compare ops.",
>      "UMask": "0x70"
>    },
> +  {
> +    "EventName": "packed_int_op_type.int256_cvt",
> +    "EventCode": "0x0d",
> +    "BriefDescription": "Retired 256-bit packed integer convert or pack =
ops.",
> +    "UMask": "0x80"
> +  },
>    {
>      "EventName": "packed_int_op_type.int256_shift",
>      "EventCode": "0x0d",
> -    "BriefDescription": "Retired 256-bit packed integer shift ops.",
> +    "BriefDescription": "Retired 256-bit packed integer shift or rotate =
ops.",
>      "UMask": "0x90"
>    },
>    {
> @@ -744,9 +840,9 @@
>      "UMask": "0xb0"
>    },
>    {
> -    "EventName": "packed_int_op_type.int256_pack",
> +    "EventName": "packed_int_op_type.int256_vnni",
>      "EventCode": "0x0d",
> -    "BriefDescription": "Retired 256-bit packed integer pack ops.",
> +    "BriefDescription": "Retired 256-bit packed integer VNNI ops.",
>      "UMask": "0xc0"
>    },
>    {
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/too=
ls/perf/pmu-events/arch/x86/amdzen5/load-store.json
> index 06bbaea15925..b1994539ece8 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
> @@ -8,9 +8,15 @@
>    {
>      "EventName": "ls_locks.bus_lock",
>      "EventCode": "0x25",
> -    "BriefDescription": "Retired Lock instructions which caused a bus lo=
ck.",
> +    "BriefDescription": "Retired lock instructions which caused a bus lo=
ck.",
>      "UMask": "0x01"
>    },
> +  {
> +    "EventName": "ls_locks.all",
> +    "EventCode": "0x25",
> +    "BriefDescription": "Retired lock instructions of all types.",
> +    "UMask": "0x1f"
> +  },
>    {
>      "EventName": "ls_ret_cl_flush",
>      "EventCode": "0x26",
> --
> 2.53.0
>
