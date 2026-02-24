Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB24265621
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955235; cv=pass; b=tY5P5v/ap3y/wv0IxqeCGBHBDjC/GEpI+X3lZoVuRBLDX2oWnBS/8X4+WZdbLq96Eag0SsEk7FtyEYyG5SEhWsvZJ6/HgWJHlvrgmYxNn4rBV6fHpdSP6Qf+szM3d8eEWqA9ddoe01uz9b2ohOHB2cyrdihOwa5S/Jxg5fgDyZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955235; c=relaxed/simple;
	bh=ONPne8W40FE4rsb7cx9k+TbouxVtnjZolpfm5w/Zlj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgA4i4uYWGZluD3AQNOoZPBPsP1bv1ABBfrwmUC+Gn4vPz3TKyNw3KEhlR9YSW/09w9Jp6BgAXu4zFdBfcwiF1AYJRuQOxdBRksjPd/3KAZSTOnKIEc3gjlpDHu4Ji+XQz3TFX0VHQklEkp9TttuvYHbT7cBTaWVYbeeJcm+dkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVaigk/2; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVaigk/2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so2865ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 09:47:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771955233; cv=none;
        d=google.com; s=arc-20240605;
        b=h4DH34Df0soQlSrp0aEwEhd66PnR6Vqe8BXUaw/0HDRc061fdvbADpEuCdXMau6M7F
         j7rUn0U4XjPR5+BCDDFy7xnszxX66HD9Cz1XOikmdDMZBVZMfBP/czJeR5rYYpeqvPdo
         9PH+03jBvLO+FSSDNPh7QybPGihKKhp42YcZNfyz2HxQuopBN9qw58Y8A+sduRGwnEM6
         GDSWRdtiMjTfibnHdrQwKEtVvwU1+AIRI/1K7L25H/G17MncdKgo+L9u3aqRgFNzdRqA
         lU0VUi93XesKvgc1vJ40a9NxDaAXgJQcQWvylftSzezBlPmZYNgjPIwRSYAdMdKmnrSI
         JejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fwd0vU5ekMzT21eTPIferFTFfjL294IFYMaSZtrtMMM=;
        fh=OlKW1mknJB9/hvAYQqdoIw+3TqraDeZYDDaRAaABAuA=;
        b=aJVTlkAsvNq7ggwrlM0cZtXXYf0Doh11JtL5WL0dNp2rQfMDiw95VWuMDH7VoFGx9r
         403o4mHbHSS10eUkAj9Bzzgidslcxgghi3HubFE7MJDGHwBa8x9H3/frtwC60JQrEPjV
         LD7W1zsRW7V/8E5OzhNFgb/I5n+WZ85ox3qf0UBiYpEaXafx8cVf8hgrjqeFtMk08IQW
         qoH6aqCsux4NebKq+1VmWuVXeWWXJHBVEm3hFBrTAlK/RKMxY3VeuC9H0zW1vIbkMmYI
         vHusrIWIgG+f0wh3m6f/9GyQPQaz+/ixFUEedp7GEZvBzjqZ1iWriqBk+yVgONxuhyIV
         K6fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771955233; x=1772560033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwd0vU5ekMzT21eTPIferFTFfjL294IFYMaSZtrtMMM=;
        b=gVaigk/2LPapgcZn9cYVwMNzRJ4QG9vfcV7e9bQ85SnxB1m7wbBC1Do0W9npNB2V1P
         WnWVgs0ctomHe06lRJ4mJ5WPD5Y/dYzEA0z7dMoSCj9vvyixSnYrdMi5dQ+/EMgnMbAW
         lkUCwadrixpRB7YW6xC+Ii73n4IbvuBlDV5hfd2VKsCl9+EIx8wTBAvY/6p3+atE1IiK
         cGkr64SKXoSYEMQD5OAG7cXg7i1DCFvtVbLkO8ABQNaKTXNK596cw0dodut9/Zb7wSPh
         5EvmyaEzHl5vFM7enAiQqG+pzaDvwS5x6fmj1FG8dPf2mE9SfqjxFxuUNg+Y3CBQf241
         +QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955233; x=1772560033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fwd0vU5ekMzT21eTPIferFTFfjL294IFYMaSZtrtMMM=;
        b=VvVflv22KkRzTJWpqyIipuERc8S/DNQj2F0WVX1lspqDQEws8k2P9rZ3S00931CRyk
         eD9hM+S6WuVLsWV2PK/yiIUiuXUwUYaDTXgJOOKhAWOwTGUEtLLPlioVQOI4fEPBrw6S
         M/oUaTjymsDxzlxIrKh0kiESv0MDbYsUKVj99JFgaOZYWI+XG1q6gRnlo4adk9zf6fE7
         pvUbjiJP+xnU01Y0VSuX58AxOYTSxlOgMbGN373P/apiLXsHFORfKAfkjtrNmSuq9Hh/
         upG60Aa46qsGq46fPB1F3Qe+pSWgfLxoeGx3fUBcRKSB3MlAPoLEB6ZRpBCBvB9MaZcl
         68hA==
X-Forwarded-Encrypted: i=1; AJvYcCVD8j2zM6fRPVeBexv+ya5acCey4hWibmkeFfnxXKiPbU73hWbYEfurN2jO+5CZtrmFDY0cIo+1GkiatfNaZWtE@vger.kernel.org
X-Gm-Message-State: AOJu0YwmM8iK4PmQV5qAx7itp8MbTt9D1dl2yiq/gWwpCvADHKL99ATM
	AtQaHp2lEXOeVJPfW2efhlBFgHg4q3C5EBAQCURHfF/Wb5iHhufb7tF6qmhtbdxiLWEEokYcjsK
	DQ+N23xc9G9SgN2drr7oRexOK8+gWBwvfwAoSco8b
X-Gm-Gg: ATEYQzw9hABZxwsWPyYN/wB+kV5rzMaqcpA6gN8rFizerQ1KjWrpdJ8msYXgNsdrN4H
	F7+7O6bbIr3DWGfcOKzWnIoutficbeapg2MErNVU5iUMyGgxjVO89t5QH3ZorKx47ldboDYIvwz
	9Gc/XWmJEuvitye8t3WZjeyO/CBdOqgIrBV4OvjODe1VxQdDHgV3TKhhx7Lqbzt9fuqNVNwlD7v
	Ua1YE7uCSLA1tXQpbBUHVzJIu3a4MJoWql788J3DCUGHKtZDdcZMQvCNT+iGNPaHMLd9o1Vgnsg
	Wwxn0m79sFa7dzb5hKsWBEHEous46B6zRhVk2Q==
X-Received: by 2002:a17:902:fc87:b0:2aa:d604:62f3 with SMTP id
 d9443c01a7336-2ad993a4f3bmr2140085ad.10.1771955232465; Tue, 24 Feb 2026
 09:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216042530.1546-1-ravi.bangoria@amd.com> <20260216042530.1546-6-ravi.bangoria@amd.com>
In-Reply-To: <20260216042530.1546-6-ravi.bangoria@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Feb 2026 09:47:01 -0800
X-Gm-Features: AaiRm52oALG0Pg_FzHKOKJbX-XaJybM69NyiUWVjg0_BwykpQ0QGO6_xB6xK5XM
Message-ID: <CAP-5=fV_cJskvLRZhQQXMGAcPUb_Rg_b30PDJNXzxL49JK4B5g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] perf/amd/ibs: Enable RIP bit63 hardware filtering
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Sadasivan Shaiju <sadasivan.shaiju2@amd.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manali Shukla <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 8:26=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> IBS on future hardware adds the ability to filter IBS events by examining
> RIP bit 63. Because Linux kernel addresses always have bit 63 set while
> user-space addresses never do, this capability can be used as a privilege
> filter.

Since x86's top-byte-ignore/linear-address-masking leaves bit 63 could
this break in the future if the kernel later ignores all bits,
including bit 63, and user space wants to use bit 63 of the pointer
for metadata? Does the bit 63 assumption hold for guest operating
systems?

Thanks,
Ian

> So far, IBS supports privilege filtering in software (swfilt=3D1), where
> samples are dropped in the NMI handler. The RIP bit63 hardware filter
> enables IBS to be usable by unprivileged users without passing swfilt
> flag. So, swfilt flag will silently be ignored when the hardware
> filtering capability is present.
>
> Example (non-root user):
>   $ perf record -e ibs_op//u -- <workload>
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 46 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index cb3ae4e4744c..13ecc8d92b23 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -321,11 +321,6 @@ static int perf_ibs_init(struct perf_event *event)
>             event->attr.exclude_idle)
>                 return -EINVAL;
>
> -       if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
> -           (event->attr.exclude_kernel || event->attr.exclude_user ||
> -            event->attr.exclude_hv))
> -               return -EINVAL;
> -
>         ret =3D validate_group(event);
>         if (ret)
>                 return ret;
> @@ -338,6 +333,32 @@ static int perf_ibs_init(struct perf_event *event)
>                 hwc->extra_reg.reg =3D perf_ibs->msr2;
>         }
>
> +       if (ibs_caps & IBS_CAPS_BIT63_FILTER) {
> +               if (perf_ibs =3D=3D &perf_ibs_fetch) {
> +                       if (event->attr.exclude_kernel) {
> +                               hwc->extra_reg.config |=3D IBS_FETCH_2_EX=
CL_RIP_63_EQ_1;
> +                               hwc->extra_reg.reg =3D perf_ibs->msr2;
> +                       }
> +                       if (event->attr.exclude_user) {
> +                               hwc->extra_reg.config |=3D IBS_FETCH_2_EX=
CL_RIP_63_EQ_0;
> +                               hwc->extra_reg.reg =3D perf_ibs->msr2;
> +                       }
> +               } else {
> +                       if (event->attr.exclude_kernel) {
> +                               hwc->extra_reg.config |=3D IBS_OP_2_EXCL_=
RIP_63_EQ_1;
> +                               hwc->extra_reg.reg =3D perf_ibs->msr2;
> +                       }
> +                       if (event->attr.exclude_user) {
> +                               hwc->extra_reg.config |=3D IBS_OP_2_EXCL_=
RIP_63_EQ_0;
> +                               hwc->extra_reg.reg =3D perf_ibs->msr2;
> +                       }
> +               }
> +       } else if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
> +                  (event->attr.exclude_kernel || event->attr.exclude_use=
r ||
> +                   event->attr.exclude_hv)) {
> +               return -EINVAL;
> +       }
> +
>         if (hwc->sample_period) {
>                 if (config & perf_ibs->cnt_mask)
>                         /* raw max_cnt may not be set */
> @@ -1280,7 +1301,7 @@ static bool perf_ibs_is_kernel_br_target(struct per=
f_event *event,
>                         op_data.op_brn_ret && kernel_ip(br_target));
>  }
>
> -static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct pe=
rf_event *event,
> +static bool perf_ibs_discard_sample(struct perf_ibs *perf_ibs, struct pe=
rf_event *event,
>                                     struct pt_regs *regs, struct perf_ibs=
_data *ibs_data,
>                                     int br_target_idx)
>  {
> @@ -1435,8 +1456,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *per=
f_ibs, struct pt_regs *iregs)
>                 regs.flags |=3D PERF_EFLAGS_EXACT;
>         }
>
> -       if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> -           perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br=
_target_idx)) {
> +       if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
> +            (event->attr.config2 & IBS_SW_FILTER_MASK)) &&
> +           perf_ibs_discard_sample(perf_ibs, event, &regs, &ibs_data, br=
_target_idx)) {
>                 throttle =3D perf_event_account_interrupt(event);
>                 goto out;
>         }
> @@ -1899,6 +1921,14 @@ static __init int amd_ibs_init(void)
>
>         perf_ibs_pm_init();
>
> +#ifdef CONFIG_X86_32
> +       /*
> +        * IBS_CAPS_BIT63_FILTER is used for exclude_kernel/user filterin=
g,
> +        * which obviously won't work for 32 bit kernel.
> +        */
> +       caps &=3D ~IBS_CAPS_BIT63_FILTER;
> +#endif
> +
>         ibs_caps =3D caps;
>         /* make ibs_caps visible to other cpus: */
>         smp_mb();
> --
> 2.43.0
>
