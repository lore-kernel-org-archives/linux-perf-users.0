Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283E3246F0
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678145; cv=pass; b=lEghQEKu7BCtYqNQPp3GJgIvg6w2IwJHV2Re2L6sgccj8dbnd05YwcWzyVKBOALvwptd3dOuNS6Pd6bXg0goDji8bL2+UTGfm/CsKlG6V6D23hzehIU0rglz4NwrJ6HDLvdY9ektmOo3CyVyoNz+jU9nvoJ/aHv2AS8hXssxNMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678145; c=relaxed/simple;
	bh=w3G92AsQpWZPXKhjIk3CiUMHEufH5dZcwjv0ZuA0gSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvNojcGOORFQc/+L8fKwdvwt94pCzXFaV0uVaBAoW6yRIdzOi7NhooSmgQkBl35mF24R6Vjoc6z+ge46r7Cp8sSqGBp3JPhlE1o9L1+uKMAucFEXYMLfSyzpbGCD+3a/A4NuMMUPMwVYalgdvrLh5C3xZ/0JTkAwHoCNnSKbhoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M03rJXhr; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M03rJXhr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a964077671so15965ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 15:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770678143; cv=none;
        d=google.com; s=arc-20240605;
        b=g+JydmKolw/C3CcIJILroKI2+9nSOoLE4o3aw6UTdZj64mwkNgyBD1vdEQIjjdr8My
         ZyuA6055Al+bYVTVjVS/fL/P2tzj7Er6gQQC4JH54z40Dcp26QIsugDNlMyrNEyJkPol
         l4qUFyyLgs6jRQH8XJl+CEiTQNE46vp8Y/5tJyUusu7waac9Rz79ovbY2BL6pQNalyzI
         LiiGhTutTxV+Rc3Wn0xuZKrfplf2KtDK+w3B1zgPqvldcETTSnAHI4bI00qVhnZJLg9E
         zF2kDz3ojkmWF7e+RljBkLU50OSfIOxx1zYDTr1gwG/aCgutrnzEhny6aGT9iz4+UNWJ
         Ndhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3YIE/HZYjq+2/ATs8FPAZIx1NVbORRx0pHSpYW9mJ10=;
        fh=UEDxWUBTp+w5Q2A2RB+Wy2NIq12bIc9BcTwCBugFvTo=;
        b=JZZIRpg6xU91eC8kdJS2MFhWrVeVib9BuU7ADfYl87KK9dFGva9hPi2YET8WYDZUCT
         J6UvdDv8ae3Ej5VyijjOwPsFgKNC5ZCznIIefkSv20rizxJknR4vsK03RAoBDEbyVv1H
         S0uKcs5//qhKoKyiRcx7gS324CN/JW3Pi17P7UIC9t8JaiGPVBXTk3OjtNVCBr7tUNQj
         cZdmfLULsnLSuB52w7e5fWEFs32vIJO9VUd80NkpQef26FpVkECvNn7ysBRWTHbMHjSr
         G0ea6X1P2f0sBem7VPtL0njvbBkXGKRD9mEshbSsFEK+pCVvRkllhA5eqJmdSDLu7+3Y
         8w5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770678143; x=1771282943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YIE/HZYjq+2/ATs8FPAZIx1NVbORRx0pHSpYW9mJ10=;
        b=M03rJXhraMuolVPsTr7QAbXR03z5Ea/Nk1lAkIecvkZxMETUi0lv5uZnl6iglG7Wsi
         jCHk+u/WrsUudbVFAPoExqreRPTv/tEVKg7u/9Cx1/PNDerO9X3mTeWbKG8D08rtu6Ee
         ZxxcgIy8DKMEFd/3b2X7AJg0ME4YTvvwuIATwhgWFW8i0Q4sgxR9jIh2wWUA5aHj1aX5
         aRqcN35tYZHLhrgT2NnteESDpjbH07kHlFPCwq5rJfNEtr1tjQRSDqe4HHA2k5qhWDXq
         T1AUWA2w1XbF80HX6ugfFfClfLu35EE+jv2cJLw9MnBs+Y0XGrG4arimL7dkBRchXt9K
         ileg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770678143; x=1771282943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3YIE/HZYjq+2/ATs8FPAZIx1NVbORRx0pHSpYW9mJ10=;
        b=C1zDhZboGQRgXuZ/qRsqrnUiHqGZzM+BpTauB5o15N2kUsc+kobmtZeDnaMl4FHgHX
         ekUlX76xMLQ35Kgxoyx6uAXg2N6G4yUXxpgrbQGAIstbxrTpDTBJMKn8dtMdOvuQ2msO
         OYWq7HJdneZWOLKixE6eTR49YPeZ4SQ97omejQ1arVm94knvhsyWwwyiCTWBmTsX4CbW
         zB0C5NcAkKv7QO9DxOxr3+3tfcOkzQxYpymHYY1DQJvubCVa16XDlMEtI7+tnB2ADec3
         KP27uzsnVncQZs1ZZX/YHb0F0XTeiZSbUYHPsQopcl9M/IkSpPB4dHYVi/FadCwc+8cQ
         kwlw==
X-Forwarded-Encrypted: i=1; AJvYcCWERZchF86gRDNVheT+3Xmm3lcpioYwpA2dbz0Us+hEgFFckBOWGJkvOVRy+o6RCg/QDLoZCPUO2trGaLaqYp87@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXYWHJqP0gWXtLKRgbkMuc2xa1ScC1tvCTEDRflL7O1hz1Xcd
	lZnXSY0aJ/kRMkkcGd4YzcQU4+5V5U00XLLY8FLWOUht1hYzmxTv0Y73L/IYePMIvH3mEmnRtWO
	eAW8R2uNCDXr9PwiNhn8325orUrOjMcyMWAx3DbkI
X-Gm-Gg: AZuq6aKeurdwuSSNIsGv7O824EHEcTiNhWto3Wr3RBYIhFIL2fPD0xvzfUdlJyP9FBH
	wcmgiH3yLkgPeRfnx8uaipjC6LByktwXsFja6+WqpBFckrkioPQRLvOIFprLeH+hH2RQ1ENfz7G
	h9VRX/344oUKAakN8JjSWNSYgkxYvMSs1qbofMa9dwZSO3C6objfaQvT+1D3Y3PdQJto8b60U31
	5670F3RGcZpkkmge94Za0k8OE6Y2V/sA2i978ZWyAc/y2a0VeRBdNvYVHTdMHENsuNpFBypqVuU
	CqFjL5nClAmZlmb6c0smTQstNbxf+W6x+wwJ
X-Received: by 2002:a17:902:f78f:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-2ab100b1a77mr520035ad.7.1770678142311; Mon, 09 Feb 2026
 15:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209083514.2225115-1-dapeng1.mi@linux.intel.com> <20260209083514.2225115-5-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260209083514.2225115-5-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 15:02:11 -0800
X-Gm-Features: AZwV_QiRphFuk-pXiNX66H6lCMfI389uBbhfrXdwGUprfZAynVuWWfK5kLgzXZ8
Message-ID: <CAP-5=fUvqHOopAkXgbmPjdjUKuAkJ1NFQoArQvoyW0YKYB_y3w@mail.gmail.com>
Subject: Re: [Patch v6 4/4] perf regs: Enable dumping of SIMD registers
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 12:39=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> This patch adds support for dumping SIMD registers using the new
> PERF_SAMPLE_REGS_ABI_SIMD ABI.

The parsing support is also added, so I think it should be "parsing
and dumping" here and in the message subject.

> Currently, the XMM, YMM, ZMM, OPMASK, eGPRs, and SSP registers on x86
> platforms are supported with the PERF_SAMPLE_REGS_ABI_SIMD ABI.
>
> An example of the output is displayed below.
>
> Example:
>
>  $perf record -e cycles:p -IXMM,YMM,OPMASK,SSP ./test
>  $perf report -D
>  ... ...
>  237538985992962 0x454d0 [0x480]: PERF_RECORD_SAMPLE(IP, 0x1):
>  179370/179370: 0xffffffff969627fc period: 124999 addr: 0
>  ... intr regs: mask 0x20000000000 ABI 64-bit
>  .... SSP   0x0000000000000000
>  ... SIMD ABI nr_vectors 32 vector_qwords 4 nr_pred 8 pred_qwords 1
>  .... YMM  [0] 0x0000000000004000
>  .... YMM  [0] 0x000055e828695270
>  .... YMM  [0] 0x0000000000000000
>  .... YMM  [0] 0x0000000000000000
>  .... YMM  [1] 0x000055e8286990e0
>  .... YMM  [1] 0x000055e828698dd0
>  .... YMM  [1] 0x0000000000000000
>  .... YMM  [1] 0x0000000000000000
>  ... ...
>  .... YMM  [31] 0x0000000000000000
>  .... YMM  [31] 0x0000000000000000
>  .... YMM  [31] 0x0000000000000000
>  .... YMM  [31] 0x0000000000000000
>  .... OPMASK[0] 0x0000000000100221
>  .... OPMASK[1] 0x0000000000000020
>  .... OPMASK[2] 0x000000007fffffff
>  .... OPMASK[3] 0x0000000000000000
>  .... OPMASK[4] 0x0000000000000000
>  .... OPMASK[5] 0x0000000000000000
>  .... OPMASK[6] 0x0000000000000000
>  .... OPMASK[7] 0x0000000000000000
>  ... ...
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/util/evsel.c   | 20 ++++++++++
>  tools/perf/util/sample.h  | 10 +++++
>  tools/perf/util/session.c | 77 +++++++++++++++++++++++++++++++++++----
>  3 files changed, 99 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a86d2434a4ad..2e1d50a72762 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3514,6 +3514,16 @@ int evsel__parse_sample(struct evsel *evsel, union=
 perf_event *event,
>                         regs->mask =3D mask;
>                         regs->regs =3D (u64 *)array;
>                         array =3D (void *)array + sz;
> +
> +                       if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
> +                               regs->config =3D *(u64 *)array;
> +                               array =3D (void *)array + sizeof(u64);
> +                               regs->data =3D (u64 *)array;

It could be nice to add asserts for the comments:
```
        *              u16 nr_vectors;         # 0 ...
weight(sample_simd_vec_reg_user)
        *              u16 vector_qwords;      # 0 ...
sample_simd_vec_reg_qwords
        *              u16 nr_pred;            # 0 ...
weight(sample_simd_pred_reg_user)
        *              u16 pred_qwords;        # 0 ...
sample_simd_pred_reg_qwords
        *              u64 data[nr_vectors * vector_qwords + nr_pred *
pred_qwords];
```
ie:
```
assert(regs->nr_vectors <=3D hweight64(
evsel->core.attr.sample_simd_vec_reg_user));
assert(regs->vector_qwords <=3D evsel->core.attr.sample_simd_vec_reg_qwords=
);
assert(regs->nr_vectors <=3D hweight64(
evsel->core.attr.sample_simd_pred_reg_user));
assert(regs->vector_qwords <=3D evsel->core.attr.sample_simd_pred_reg_qword=
s);
```

> +                               sz =3D (regs->nr_vectors * regs->vector_q=
words +
> +                                     regs->nr_pred * regs->pred_qwords) =
* sizeof(u64);
> +                               OVERFLOW_CHECK(array, sz, max_size);
> +                               array =3D (void *)array + sz;
> +                       }
>                 }
>         }
>
> @@ -3571,6 +3581,16 @@ int evsel__parse_sample(struct evsel *evsel, union=
 perf_event *event,
>                         regs->mask =3D mask;
>                         regs->regs =3D (u64 *)array;
>                         array =3D (void *)array + sz;
> +
> +                       if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
> +                               regs->config =3D *(u64 *)array;
> +                               array =3D (void *)array + sizeof(u64);
> +                               regs->data =3D (u64 *)array;

As above but for intr:
```
assert(regs->nr_vectors <=3D hweight64(
evsel->core.attr.sample_simd_vec_reg_intr));
assert(regs->vector_qwords <=3D evsel->core.attr.sample_simd_vec_reg_qwords=
);
assert(regs->nr_vectors <=3D hweight64(
evsel->core.attr.sample_simd_pred_reg_intr));
assert(regs->vector_qwords <=3D evsel->core.attr.sample_simd_pred_reg_qword=
s);
```

> +                               sz =3D (regs->nr_vectors * regs->vector_q=
words +
> +                                     regs->nr_pred * regs->pred_qwords) =
* sizeof(u64);
> +                               OVERFLOW_CHECK(array, sz, max_size);
> +                               array =3D (void *)array + sz;
> +                       }
>                 }
>         }
>
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index 3cce8dd202aa..b98bc58d365e 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -15,6 +15,16 @@ struct regs_dump {
>         u64 abi;
>         u64 mask;
>         u64 *regs;
> +       union {
> +               u64 config;
> +               struct {
> +                       u16 nr_vectors;
> +                       u16 vector_qwords;
> +                       u16 nr_pred;
> +                       u16 pred_qwords;
> +               };
> +       };
> +       u64 *data;

I think "data" is a bit generic here and could be confused with regs,
perhaps "simd_data" for clarity.

>
>         /* Cached values/mask filled by first register access. */
>         u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7cf7bf86205d..fba8ef52f0a1 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -972,18 +972,77 @@ static void regs_dump__printf(u64 mask, struct regs=
_dump *regs,
>         }
>  }
>
> -static const char *regs_abi[] =3D {
> -       [PERF_SAMPLE_REGS_ABI_NONE] =3D "none",
> -       [PERF_SAMPLE_REGS_ABI_32] =3D "32-bit",
> -       [PERF_SAMPLE_REGS_ABI_64] =3D "64-bit",
> -};
> +static void simd_regs_dump__printf(struct regs_dump *regs, bool intr)
> +{
> +       const char *name =3D "unknown";
> +       int i, idx =3D 0;
> +       uint16_t qwords;
> +       int reg_c;
> +
> +       if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
> +               return;
> +
> +       printf("... SIMD ABI nr_vectors %d vector_qwords %d nr_pred %d pr=
ed_qwords %d\n",
> +              regs->nr_vectors, regs->vector_qwords,
> +              regs->nr_pred, regs->pred_qwords);
> +
> +       for (reg_c =3D 0; reg_c < 64; reg_c++) {
> +               if (intr) {
> +                       perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, r=
eg_c,

Rather than EM_HOST here, can e_machine be an argument to the
function? That way we can x86 SIMD registers on a non-x86 machine.

> +                                                              &qwords, /=
*pred=3D*/false);
> +               } else {
> +                       perf_user_simd_reg_class_bitmap_qwords(EM_HOST, r=
eg_c,
> +                                                              &qwords, /=
*pred=3D*/false);
> +               }
> +               if (regs->vector_qwords =3D=3D qwords) {
> +                       name =3D perf_simd_reg_class_name(EM_HOST, reg_c,=
 /*pred=3D*/false);
> +                       break;
> +               }
> +       }
> +
> +       for (i =3D 0; i < regs->nr_vectors; i++) {
> +               printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs-=
>data[idx++]);
> +               printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs-=
>data[idx++]);

Is 'i' the correct value to dump here? If the bitmap of pred or vec
registers has gaps in it then we may dump say "YMM0" and "YMM1" for a
bitmap of say "YMM0" and "YMM2". I think you may need to do something
like bitmap's for_each_set_bit.

> +               if (regs->vector_qwords > 2) {
> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, =
i, regs->data[idx++]);
> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, =
i, regs->data[idx++]);
> +               }
> +               if (regs->vector_qwords > 4) {
> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, =
i, regs->data[idx++]);
> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, =
i, regs->data[idx++]);
> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, =
i, regs->data[idx++]);
> +                       printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, =
i, regs->data[idx++]);
> +               }
> +       }
> +
> +       name =3D "unknown";
> +       for (reg_c =3D 0; reg_c < 64; reg_c++) {
> +               if (intr) {
> +                       perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, r=
eg_c,
> +                                                              &qwords, /=
*pred=3D*/true);
> +               } else {
> +                       perf_user_simd_reg_class_bitmap_qwords(EM_HOST, r=
eg_c,
> +                                                              &qwords, /=
*pred=3D*/true);
> +               }
> +               if (regs->pred_qwords =3D=3D qwords) {
> +                       name =3D perf_simd_reg_class_name(EM_HOST, reg_c,=
 /*pred=3D*/true);
> +                       break;
> +               }
> +       }
> +       for (i =3D 0; i < regs->nr_pred; i++)
> +               printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs-=
>data[idx++]);
> +}
>
>  static inline const char *regs_dump_abi(struct regs_dump *d)
>  {
> -       if (d->abi > PERF_SAMPLE_REGS_ABI_64)
> -               return "unknown";
> +       if (!d->abi)
> +               return "none";
> +       if (d->abi & PERF_SAMPLE_REGS_ABI_32)
> +               return "32-bit";
> +       else if (d->abi & PERF_SAMPLE_REGS_ABI_64)
> +               return "64-bit";

This isn't testing PERF_SAMPLE_REGS_ABI_SIMD and reports "32-bit" if
both ABI_32 and ABI_64 are set, which is a little surprising. Perhaps:
```
const char *regs_abi[] =3D {
[PERF_SAMPLE_REGS_ABI_32] =3D "32-bit",
[PERF_SAMPLE_REGS_ABI_64] =3D "64-bit",
[PERF_SAMPLE_REGS_ABI_SIMD | PERF_SAMPLE_REGS_ABI_64] =3D "SIMD",
}
if (d->abi >=3D ARRAY_SIZE(regs_abi) || !regs_abi[d->abi])
  return "unknown";
return regs_abi[d->abi];
```

Thanks,
Ian


>
> -       return regs_abi[d->abi];
> +       return "unknown";
>  }
>
>  static void regs__printf(const char *type, struct regs_dump *regs,
> @@ -1010,6 +1069,7 @@ static void regs_user__printf(struct perf_sample *s=
ample, uint16_t e_machine, ui
>
>         if (user_regs->regs)
>                 regs__printf("user", user_regs, e_machine, e_flags);
> +       simd_regs_dump__printf(user_regs, /*intr=3D*/false);
>  }
>
>  static void regs_intr__printf(struct perf_sample *sample, uint16_t e_mac=
hine, uint32_t e_flags)
> @@ -1023,6 +1083,7 @@ static void regs_intr__printf(struct perf_sample *s=
ample, uint16_t e_machine, ui
>
>         if (intr_regs->regs)
>                 regs__printf("intr", intr_regs, e_machine, e_flags);
> +       simd_regs_dump__printf(intr_regs, /*intr=3D*/true);
>  }
>
>  static void stack_user__printf(struct stack_dump *dump)
> --
> 2.34.1
>
