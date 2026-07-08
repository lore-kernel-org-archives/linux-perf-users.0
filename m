Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542034F26F
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533621; cv=pass; b=LutKLbl4vapBfRywjfjkG0jPxxH7ulOdZjr2ddornju30ldIgulGr0FRcirDuafqw9pBFSqtntYmJjOZjhyNxJAUn5bLttYYPVXZ0FTk7EkGYstKFpQ38DP3KBzNvIOSFaOLJs/WMVHlMvBJtmr2qdf4YDfuVCpzqSsEpgt4e5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533621; c=relaxed/simple;
	bh=tvkDtoBeUZbtEAYyr3gKpp7noJ29rlfQEsn38Hwt+Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpE6w6J9isA1xKG7QCwN88ShyZycFDwfal1p4n4IyhXiukxZR2r4PIJn05rjj2Bse8BsG/MBX/wsZ3WdwSiulIgb23nTTvXVKzAqFyKj/XsaiXn/4H5TJ+8ygoT7eo4f2XrhQVChyuQ2vh4il0sMj0HkSLAPZV3oFM9lY/d/8wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSTnkNBF; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSTnkNBF"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdf36f63dso12085ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 11:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783533619; cv=none;
        d=google.com; s=arc-20260327;
        b=HfwlB/4/GheDZ2LQlfMlK6ZgY74Xv5c7I8Ji57M57QSX8XJdtRiR1fD7OFiiVSdvrS
         VbWy5ye2VFqL7tJQDyMAARjMSnk/ZOG3v8RNScUjC4SZe7zsKhKwsDW/PAMMpxkvutnW
         vs+Ncn2/hODKy8pAyXiao68T5LoK/GK3CLY2cbbQSNtUDNjK4RT3TyDjAKEjVPTUAjVq
         BFHB6TbPCqUvAmVbalpfJrLJ/WLBpXW9dVNjW/E2cabj1+I3ZZ3YBbHrUOZesPklZRtK
         bQH3Ly+YozNlm+EGN+M3Dk2OKDoeDc767Tf6Lhvcvs33e1PNHNMYGG5r4Y0zRnLilxb/
         adOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dq7WtVVWThNZPegBrYBGEjXYSNuYHn9IlB/6vwvSCuU=;
        fh=BUXYNYcqz53siR8XyFuqfoDkY3onrkaY9gbDrXE+R+w=;
        b=FxonW+KNtac7hdV62QVm2phM15dB2xUG7xh4taViDr8k3jY2Q7cesZjYflNayRu7Zt
         ke03SV3JVyAR/ZXKTnOVaMNqCIJtjSKZrW5Uf67VEjOsehCT0gm0yT3m7WhdwzoGkNDO
         igdJBX3Qvjq/t3qntCgGLgmUa7iHVcj6bT2ER0X5HTQHZlMfRjWn758wB0iFfhaYUJVZ
         j1K+u883O54otQ8rCrbwLFRZt4XQ/yRrvutqTZHFavfolHTx+7XjpjzTGE+48LvmnAJk
         yXO5gDHYa8E+PimIR/1/YTSGymaH8X1fTKLGv6RM3TugCnYUaWD77uJismp/0xuS3QjB
         gKxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783533619; x=1784138419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dq7WtVVWThNZPegBrYBGEjXYSNuYHn9IlB/6vwvSCuU=;
        b=CSTnkNBFYcE9G5Bft1mbj5rZ7gHqSZk0dWYW5k/FN6vP/kBhnYCcmMH2dvZR2Zl9dW
         ZIwPzcEtDKCz+p5DEP4WiB4FGwzJbWOlYRxVFTWBbQVJb9staxU7nI/ivQWNfQBZZ8g1
         bgNhqqnjVbsyOVs4nhVasivxJNHyLNiA/o/f2J0vK93djCH5en69MXXIn+hDBPkMKt/3
         LndjRxlNkkcZZQexkDCmYgePBALmNl7C+8vWqsaOu36I+/RAzpp6fCG6MsAP8/WtbNpz
         t2kA5xcdOEd/c+0x2yfZRRb4v5qN74vBd8v+5IS23s0QXYYpHxhuA2wYpwySOBoQDr2r
         jVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533619; x=1784138419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dq7WtVVWThNZPegBrYBGEjXYSNuYHn9IlB/6vwvSCuU=;
        b=D8zhSMncLhZmA0ZQEU/eEVqyByzSSEXpHrVCXhDSzGxrebndo7gXnk+w16IIaQyQ6+
         Pv+cVvMA/jP7cHo2bluvF4s69zUVWQ+RG8YvXPCwxl5msF2pzYS7NOdlI2BS04E+/van
         ULOR5nTgb0tIk6yqk+zfe6KDZfT5yabbc9teHoGPoPXj0PmREIKQAMZ49IlLPbozH9xG
         SViHeK0VdfJoVSQcscX0a2h4wQSy0hLr3Lr1e1aNTdR4eZ+6LpYmiiMAeS0+ne+KJul8
         1Knqu0b6lmRXV6fHofOs45TsJlZa+fZ5b+jhZn57U6nw84ybFAbWFv8tblVkNNoyRom+
         YhXQ==
X-Gm-Message-State: AOJu0YyUDp0w5ARmE2vrjB5fSI06868hNnA3QWnpsRF7IcR5FlUjgyH+
	k6fRMOPENNuNE47Hu1LELTkReva7zHqWE2iQWls9LwtKYKBgIhauLUS6XXUkeqB8xZiZ271oT60
	q4fnJleDJhgTWu/H8jXAvDQWFj63hPDB/KLhaFMu91PlFvzQMWHfh05gT
X-Gm-Gg: AfdE7clxP94dtUaGZ9nj7bTy2yfs8Csp4663VbcFg4mW2tyblycwMkL34mvsJ8ywM2o
	iiz9Pr6p4G4BCLzpIq7EuUKMEqvRYn6/wNgXfkVDw8LBvcQnHpNfS//dsioB7cckzA0XMc32x+3
	z1pre7KS2b6r7eSVl35AniHH9Cfni/Nyn9jQGdAU906Z7eUg4iZQkt5oQ2Op9YHjWMBE1Gx6pKR
	2GwSVqJI9V5/ThGCPPjWkiHNbQK0uPhyKTYZyJ3fPZpgRnZkE2CA5Tgmqypu7pqSNku0ACvYeO8
	vggRlvXdduc12KW2vBSI6+ZBQos=
X-Received: by 2002:a17:903:228e:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2ccff76a36fmr509705ad.6.1783533618576; Wed, 08 Jul 2026
 11:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707190401.1427329-1-sandipan.das@amd.com>
In-Reply-To: <20260707190401.1427329-1-sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Jul 2026 11:00:06 -0700
X-Gm-Features: AVVi8Cc4Gpk9CVJv36Zg1MXffJcnBsZk6A6BpRZJ7AR13Fqj4B4SoDAdME4ze8c
Message-ID: <CAP-5=fUPt=DO6bY8zO81kaWObp_A7ozU5W2nGR-Jbi3qs9uqZg@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events amd: Reintroduce deprecated Zen 5 core events
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 12:04=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> Maintain backward compatibility by reintroducing the events that were
> previously removed by commit 047979af3bf6 ("perf vendor events amd:
> Update Zen 5 core events"). Also set the deprecated flag and update
> the descriptions to point users to the correct alternative.
>
> Reported-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/all/CAP-5=3DfV_czvd-z4N7K+_SabxuOm9UUHRyB=
xNuchrtAgJL3OqOw@mail.gmail.com/
> Fixes: 047979af3bf6 ("perf vendor events amd: Update Zen 5 core events")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  .../arch/x86/amdzen5/floating-point.json      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b=
/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> index 569975b53cc3..50d38434f8d3 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
> @@ -383,6 +383,13 @@
>      "BriefDescription": "Retired MMX integer VNNI ops.",
>      "UMask": "0x0c"
>    },
> +  {
> +    "EventName": "sse_avx_ops_retired.mmx_pack",
> +    "EventCode": "0x0b",
> +    "BriefDescription": "This event is deprecated. Refer to new event ss=
e_avx_ops_retired.mmx_vnni",
> +    "Deprecated": "1",
> +    "UMask": "0x0c"
> +  },
>    {
>      "EventName": "sse_avx_ops_retired.mmx_logical",
>      "EventCode": "0x0b",
> @@ -449,6 +456,13 @@
>      "BriefDescription": "Retired SSE and AVX integer convert or pack ops=
.",
>      "UMask": "0x80"
>    },
> +  {
> +    "EventName": "sse_avx_ops_retired.sse_avx_clm",
> +    "EventCode": "0x0b",
> +    "BriefDescription": "This event is deprecated. Refer to new event ss=
e_avx_ops_retired.sse_avx_cvt",
> +    "Deprecated": "1",
> +    "UMask": "0x80"
> +  },
>    {
>      "EventName": "sse_avx_ops_retired.sse_avx_shift",
>      "EventCode": "0x0b",
> @@ -473,6 +487,13 @@
>      "BriefDescription": "Retired SSE and AVX integer VNNI ops.",
>      "UMask": "0xc0"
>    },
> +  {
> +    "EventName": "sse_avx_ops_retired.sse_avx_pack",
> +    "EventCode": "0x0b",
> +    "BriefDescription": "This event is deprecated. Refer to new event ss=
e_avx_ops_retired.sse_avx_vnni",
> +    "Deprecated": "1",
> +    "UMask": "0xc0"
> +  },
>    {
>      "EventName": "sse_avx_ops_retired.sse_avx_logical",
>      "EventCode": "0x0b",
> @@ -731,6 +752,13 @@
>      "BriefDescription": "Retired 128-bit packed integer convert or pack =
ops.",
>      "UMask": "0x08"
>    },
> +  {
> +    "EventName": "packed_int_op_type.int128_clm",
> +    "EventCode": "0x0d",
> +    "BriefDescription": "This event is deprecated. Refer to new event pa=
cked_int_op_type.int128_cvt",
> +    "Deprecated": "1",
> +    "UMask": "0x08"
> +  },
>    {
>      "EventName": "packed_int_op_type.int128_shift",
>      "EventCode": "0x0d",
> @@ -755,6 +783,13 @@
>      "BriefDescription": "Retired 128-bit packed integer VNNI ops.",
>      "UMask": "0x0c"
>    },
> +  {
> +    "EventName": "packed_int_op_type.int128_pack",
> +    "EventCode": "0x0d",
> +    "BriefDescription": "This event is deprecated. Refer to new event pa=
cked_int_op_type.int128_vnni",
> +    "Deprecated": "1",
> +    "UMask": "0x0c"
> +  },
>    {
>      "EventName": "packed_int_op_type.int128_logical",
>      "EventCode": "0x0d",
> @@ -845,6 +880,13 @@
>      "BriefDescription": "Retired 256-bit packed integer VNNI ops.",
>      "UMask": "0xc0"
>    },
> +  {
> +    "EventName": "packed_int_op_type.int256_pack",
> +    "EventCode": "0x0d",
> +    "BriefDescription": "This event is deprecated. Refer to new event pa=
cked_int_op_type.int256_vnni",
> +    "Deprecated": "1",
> +    "UMask": "0xc0"
> +  },
>    {
>      "EventName": "packed_int_op_type.int256_logical",
>      "EventCode": "0x0d",
> --
> 2.53.0
>
