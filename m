Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459933;
	b=vdG1dStyFmuk8Nrbx2ax35L5CpXycmUbRWOeUwksS/ZhBXzp1xRVafxLtyayx41VeXEx
	 ciNJj1kfpc2uN4x4Cud9mFUiZvEn9YB4CGXPc7obPW07aLiuiq7UFLGAFxOXUNmJCIh+C
	 apvSdM+P4Bo5OxBBg9bwQzHzC5UCxSZapw/rs1CUe3ApQfPzv/K+XGLEqeMmeTv1hp0Sl
	 PIbsTEh8le+2ySkTHhe7AqaJltMXqJjVDE+EN5YN8apkqud5dZCpMXR5XJab4UhpvBjQL
	 KXo19QlWLN75x1PL3HJUyC4yt3nski083aTlmf7Ov6ts+7E/5nDpfVDgdfE4R3VH7Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pWROUaQbGzutORUjoHU2j5EievY+f7Xwsbb9sewJ+VE=;
	b=Y2lpxH82plsA2cIMSFSex8Ah62B80NnD/n/88v4OqnJ9GZ0t49EE8tuOfv8CsTZGCKGe
	 99t0RuU9hgfm7EZOw04Ac13pYDyosFbD0tyF1vAxXbUc14Wd2hIKMpUo+84haJyGjshi5
	 VnKzwtcD/lflhD5vGcfg2Vsff3nNBmrAVS5gGGXqcHC/VffxH2IdSoweLS/kWQwDnDYKl
	 Z7dzaMu1ba18TOJrzkZREiv9OOQJwWt5XQi45CEVGY66NlGY536E7gC+Dmo8F8GDJxVLx
	 kuUJs9NYAUbtomjaz4iv8UupVSGr9NJNB2/AYITJjiE1bnbNlptFGG1BA1bojuULhqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jRC70ElT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA9606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 15:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ABA9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jRC70ElT
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so2074736a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 08:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793459931; cv=none;
        d=google.com; s=arc-20260327;
        b=b0dMdb9OHdDoJHBrrSJ1q1f6e7xzeUshcwy+wK8LEhXxFZgxDAiDBtvGSQV0HI5v9q
         G2qTucGs2u6C16ycmMnax6QSq2TAoBUa0Ew5JxRvdCc9JGq39zdiwqGNQZQ+l/JpuWKL
         OsBPewXZvpVctyWpNMaEx14UdFMaUrqwlanzPdR+khg3tl6VjzGElQezBZjZan3PYGOt
         iSgoiJxW6l6FD1DTHu0BHx+QVnz1J3Pf+xdOwQTNUz+movbQGNcBdMln/X5Em7IOqxjg
         nhCPybSnxrT7f56gfvTWvTq16awKPq+BRvYfvobzYoCCO+ZK7R4pJuN6O5/C3qwZ4bCh
         FJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pWROUaQbGzutORUjoHU2j5EievY+f7Xwsbb9sewJ+VE=;
        fh=/3fGc7gn8rnd3YJBOzVDED7SoQRTBsqPnTo0vW2bdLU=;
        b=l9gv4gsg9Xm0wBlA8m4F4DtqzbQH4T/MFkkgKJGR366X3li8yH7HHCYMHN11UvrzsW
         I8qAqtSCkkaa9HX3jvt6LF0kWbWNeQyCYzVfFcy+slMeRThuohnfwHbv4pU0svdGeyO6
         vJSdBvb3Zlp6Ra7WjYnB6k9z4PZLB9SyQr44buaejdyXH0jyO4hz/G50cfMNDhVejnhW
         tRdVJE+0jKGRNx4QiqLAHgFCOqmLWdttvZ4zKk8LmQpao5obhbtKWYSDLXlC3gOeJHB8
         s6ntaC/r4SYTFX7CIMqLKXccnvzdKGZrH+73zKuULypj0Dk+HV9l2NnO4dsKpHRC57O9
         q/zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793459931; x=1794064731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pWROUaQbGzutORUjoHU2j5EievY+f7Xwsbb9sewJ+VE=;
        b=jRC70ElTjpZC4Vg1gVotImxyxtgyoZo7aRDc6o2t5nSg7r6QLeG8hrjb68LTY8c2p5
         q1wiBjkSw+VolE4LuiszzBip9EitT9gwcWiSv/klhcYKzL+XEA/l8+Mq1K1bp2hwU7a3
         jPPpC2o9NDLj9FMw/ZpwckA56sROEr8lo3UeNvgucN+InNzR3dtxrlwgmYhN+fHXRh1g
         d/6usaK76WvnxqQGGUYobWBDTlwYQbhLPTpvrqozTTyaZb6ifGS12KojgI4KEgCQoddM
         4A2RRBOoRyI541uPo6G1XP6z1GBnkq+oGLwH4FnfhUJu9C9RrC0p8if91GlwfOklu9Qk
         6XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793459931; x=1794064731;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWROUaQbGzutORUjoHU2j5EievY+f7Xwsbb9sewJ+VE=;
        b=fT5He2ym4EjYOET50AttZduOWUxtn8gRmzNxtZV8pXPF2O09g1k5mNXeM4o///8zKE
         gubXNhHsjqNY2+MDTEWSSGyvYcKqfca4k5awj8CO4KotoZZi3Fdy5IjERYBrbxxO3Ifo
         D+lgTNPgKxUD0BCAXLzT/t8k63B3Ifzk7s+b8anoQXPJik/pbaJtCjipLULbfYtUZbcf
         pxiqLfHp8W8rVQaqRE0/R/WBN4KsgzuzLl5AUgJ2vqgWOIGdCWtGWBS04ir2zusDki5S
         gbSCPhV10kjb+a5fKd9cRb1gfw7TfYTQwpW2XWS2DoaFBNxkPXwiJsu0cU+xwnhfyt2e
         8vjA==
X-Forwarded-Encrypted: i=1; AKwUvBxtdyyM3gc/7+R4xV0hp6Lt8Bcf4ikQe66t1R44zcG5y5UvSGQrRvIJdvxaBAks+pkV7dSTu2d+adyZQ9MOV3zw@vger.kernel.org
X-Gm-Message-State: AFq9FYJPyDCngqQ3uE7+3Kg7KCTnhBHEbsYP1UuG+WstY57dE7XvpGw5
	59n7vT7kOHj3nMUhatU9Ya/0Pe3sMddZXiGBSXmr/bR7RvCyRdoaL1TygtdFvXOkhrnrkANA5VC
	gc4DSAM99EhVv1A0doyu0IdKPIOq3B0vMaf8FZXSaNA==
X-Gm-Gg: AYBFou1ZfpcSuU6xU76A05A99EINFKcRPqkKmyCZHR+G0Yro7jWCwUFUNNYofCYof55
	S7OgrnVRJU07D2kmkXkaBUVQlOzALv+7lxu1v7QhLLKn4fpAug2KRT2YhLAXCBpQx7zPCRBu5yX
	q/OgIAVi9uN0TVfb9jQvO3o1cwBa1VoL5sVlS0DS6wdIKuaty5oqpE47sI1SKVlXBz0ZDtQGzcv
	YV64CgEPAQ90TnngYpEz7mTAaIrss6Xa6xUIHjCbmhiEvFxdFBCgYTPL16Zn++Rvva5DKOGyQpJ
	MIwNvA0C3sCCfFZzz8ry6J285WtCNF8SpCl1JCk+X/wQvi4MY6MPAzoEcQD8EYhetRIp4tfPhx/
	rLforcoatrYRmVDDeKS3e9Y6IaJqIrang8p7+Uh4ecFsDHAqjV+2V2946KUGY7t9JLhLu6j/LHG
	rv0n0NEfY0y+ENanWlWWUyS/Y=
X-Received: by 2002:aa7:d7da:0:b0:6b4:a136:8788 with SMTP id
 4fb4d7f45d1cf-6b4d438bba8mr2984206a12.7.1793459930510; Sat, 31 Oct 2026
 08:18:50 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com> <20261030-alpha-profileme-v2-2-c702f1c65272@gmail.com>
In-Reply-To: <20261030-alpha-profileme-v2-2-c702f1c65272@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 31 Oct 2026 16:18:39 +0100
X-Gm-Features: AclHuK-fcn4Vq_6bW1E8x2uH1VVvD4ohFBO2dvy4BaT3WU-s5Ewn8vz03NCGQRw
Message-ID: <CA+=Fv5TZQ4O89gd9PU6HOaM6i+ZdpE=8jEN66o3_qSe4r2HCvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] alpha/perf: add sysfs format and event attributes
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Oct 30, 2026 at 5:04=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> The Alpha PMU registers with no attribute groups, so the perf tool has no
> way to learn the raw config layout, and the PMU's own events can only be
> named as raw hex numbers.
>
> Describe the event field in format/event and export aliases for the four
> EV67 event types. mbox-replay has no generic hardware event, and can now
> be named as cpu/mbox-replay/.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/perf_event.c | 39 ++++++++++++++++++++++++++++++++++++=
+++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 2d9383425357..70840c05d39b 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -212,6 +212,44 @@ static int ev67_raw_event_valid(u64 config)
>  };
>
>
> +PMU_FORMAT_ATTR(event, "config:0-7");
> +
> +static struct attribute *ev67_format_attrs[] =3D {
> +       &format_attr_event.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group ev67_format_group =3D {
> +       .name =3D "format",
> +       .attrs =3D ev67_format_attrs,
> +};
> +
> +/* Values must match enum ev67_pmc_event_type. */
> +PMU_EVENT_ATTR_STRING(cycles, ev67_event_cycles, "event=3D0x01");
> +PMU_EVENT_ATTR_STRING(instructions, ev67_event_instructions, "event=3D0x=
02");
> +PMU_EVENT_ATTR_STRING(bcache-misses, ev67_event_bcache_misses, "event=3D=
0x03");
> +PMU_EVENT_ATTR_STRING(mbox-replay, ev67_event_mbox_replay, "event=3D0x04=
");
> +
> +static struct attribute *ev67_event_attrs[] =3D {
> +       &ev67_event_cycles.attr.attr,
> +       &ev67_event_instructions.attr.attr,
> +       &ev67_event_bcache_misses.attr.attr,
> +       &ev67_event_mbox_replay.attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group ev67_events_group =3D {
> +       .name =3D "events",
> +       .attrs =3D ev67_event_attrs,
> +};
> +
> +static const struct attribute_group *ev67_attr_groups[] =3D {
> +       &ev67_format_group,
> +       &ev67_events_group,
> +       NULL,
> +};
> +
> +
>  static const struct alpha_pmu_t ev67_pmu =3D {
>         .event_map =3D ev67_perfmon_event_map,
>         .max_events =3D ARRAY_SIZE(ev67_perfmon_event_map),
> @@ -761,6 +799,7 @@ static struct pmu pmu =3D {
>         .start          =3D alpha_pmu_start,
>         .stop           =3D alpha_pmu_stop,
>         .read           =3D alpha_pmu_read,
> +       .attr_groups    =3D ev67_attr_groups,
>         .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
>  };
>
>
> --
> 2.55.0
>

Tested the PMU event/config interface on my AlphaServer ES40.
The four ProfileMe event selections recorded successfully, with
the expected selectors in the captured status.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
