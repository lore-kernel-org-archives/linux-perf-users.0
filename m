Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEA2D780A
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Jan 2026 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356332; cv=pass; b=MFsNf/CmcA+OmbORZscfCnX+nb1KTtX7GiP76ERON79bUhGJkI1ky3cb0cX8ZDKHipBg09Qm/5a5M1WT6KL5ww7rx0Cq4I/gUSe/WZLjHI9CAQ4wfyTTwnC78mKaF8z4/bQ558mUZwN7p8s3h08Tj4CoyLFgT/DI0wmQUPn/H1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356332; c=relaxed/simple;
	bh=gaV2E54jvXAqv59CZRqKiFlooAa98YUH8nVsGvascMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXbMaCKsUx/ZZxGxjpw/UvpYHsn9/Oy0zXiNlJoi/tIa7QqAsQdSoo3TPj1WrlQ4eR7NDlqrTmPVIgeYCcez6j1zkSkpX5GSew9AJQmUgkQx/O+5x6eCKWV0ujrVTlrtlZ0x84grNcivCTUqc6dZwrJfAlCognlP90AdXI6AAkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwyteiZW; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwyteiZW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a1462573caso309535ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jan 2026 04:18:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767356330; cv=none;
        d=google.com; s=arc-20240605;
        b=Tj0YWhfFIJGXjY7nzaf9D3sykTeoAotL3OlLgsjyHG1ZjTrAaow99wIgGtO3do3E8a
         QDR4r5pMHswm3E+imAe7vhPkAYe1+pstZE4gj06vWf12NS3cpC97TvT1llmxkbOeiZbU
         T6QA0bz50hPQ88jxCYDMLplP3H8MyFKErUeEcq/99UQTpscJNELOtDtLKy07tMmFlbzd
         wsHXwbIJoSyiNezfVi8uQ5LEX8jeIdzMvPs38fdVCVpt2MWVul0NivjCn5CK1ZP2/FM7
         gwXSynR4G4FhQUgU39Z1KhTTeQqjEB4nMVKLbWCCG1WycJFZ2mywbjwHo1P6eM/08UAv
         GP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/vYezMfgmz8SYHACJvkjmERa2rsVqk3TpP5VA6dIFLo=;
        fh=34BDsmx6u5lYfpljazxqNMK9VBQor/H2DgbvwL4gyNs=;
        b=kKV0vcqvUqhLR44Qm8YQUIJn4+QgdxGmih7aIA8kW7a3cw4HO5hPC33gLZmz7vZKjp
         uxEdN6QbChN2CH98TkA+xsAYLjjtkcjUiRwPEeutzJx+wAUpYwGbh2PWJhjF5RFO0fvG
         OujeyOiOTZdAiYk3i8us5m7ESTZnLy/Yodt9RKm42q2k3prQRv8wCyIl+MCYEMEg6Tk4
         F5abLFrzgHxdnjJ6U4snLiIaNwAhW2cTZhdOgLx6CSCA3JbNp/tDOIa4wrd8YeNbIxlM
         1UXIa9RWnGwW6v7Q+lrz4VxPd53ilLU/O6Lh1JSlNaBhKkh/7xMnumeYcIFsqk2dAiwd
         ffbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767356330; x=1767961130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vYezMfgmz8SYHACJvkjmERa2rsVqk3TpP5VA6dIFLo=;
        b=RwyteiZW0J1P1L4ihdFMc4BcXDg6bHU6he3ZyO382UuhwPctkmXOjxCF0iHjXNUh9m
         lSJL4HsDij6QyGLrp2+QEJ6UbGUIiXl57nz3/hpdekGdD5xlV/MiOam4W171wrsosxy3
         6A6/bljzySXA6xcFdwlZrtH4FbkRNsK2CbyyA7FyUkkkBP0854+Mgz1z1/8JScHBQmyx
         lJ3Vxcv8kBS7W3WyS3gvUWKk/YpPepdH+YBxkQw8sAsEU/qp6CvKffBWF8eKvZXm4yc/
         trkt4DU30PZqDQ0XHljA7wknlXsuY3zz8U1LMg9Xxw2wOhn4eq7CrKtwkI0p8aLuQ5S3
         bEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767356330; x=1767961130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vYezMfgmz8SYHACJvkjmERa2rsVqk3TpP5VA6dIFLo=;
        b=sApPeabZTbvcLHmuZZ7zkV7yGjgyKPibAWVKF2aH/zzUIGfevT5YRTLUC//miDskII
         r3SoSPkl8NzaOeHjby8xVgeKEltvtyKbt632HjIuY+YEjuTeKmDualAxwbfkE+Pixh4q
         0yh9LP2d+lsrCvSil+xyNs6Hw0r21SqdgiE3Dd9PMKix2FWtOb3HWTYsNPYWgslAf73h
         pzhmCgJg8tewwtdWuiExloHpwgRDTsXBqKJ0dX7nrzCU5rEg38ILKMeTCOQYkqerwzXk
         d22u6geWmRk45S6bV50EbhuLHd1+20MvsHoYn3HknDoC9ObxQde6SrCDOO5PbY8nZfnq
         6deg==
X-Forwarded-Encrypted: i=1; AJvYcCXoNl7oAmKsXcjCblEGhOBYzVSJ1sf0wVmKEcyBu+Y/dtILJicZeBW7rHyA83kQCOiiRgETl1h/Uaylg+QU6fzs@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4XQI+d3n1btiri6ox0BCLUNrIdpeI6RC4/YO5qi/JmOwmVxv
	9ON+py593YzlAoq7EAmYYYR4ZeskV6Sghd9NEBTPvT0V7JHB5SHw9tD2p3E7InjXAT83E0W863B
	Vm9DyQuQvT+BS289s0If/aROFrhR6YNQ4KThDeGsb
X-Gm-Gg: AY/fxX7flgEzb5XZgttMOwzxNVT3feNO5Xp7ECIaKjLX5GRQeYST+ygzNBchEE2PFTO
	PdrEN34YK/bIAj1+d+AXq4khBWP8OXFRTETcQwdWYoUtyc8f+Qt1MMt8t5t32xEIpT1QKQ5EwFw
	1MXFqp6uDG0Dw9D4la9RafgxUcp1d+zc++azVDNv0ZXz3luvyRccS23dDvXv+lqWJDiC8yTuTGq
	0Vy7hD1I+/bP4dvlssB+bITmIgwZfOjQfwOzUSPotYGZ3fc0KJAzu3Y4RtD7m86AMoUa2NP
X-Google-Smtp-Source: AGHT+IFoZ8B1qDvnQCmI0XVq2vhw1PrHKxvfv6Cxy5czSMngQW+2Ftg7KMTM0PF1bbALNVsRMasGkB8UAAU6HlMiVYc=
X-Received: by 2002:a17:903:1c1:b0:29f:2f83:16d3 with SMTP id
 d9443c01a7336-2a3a3af7fc1mr3531165ad.16.1767356329375; Fri, 02 Jan 2026
 04:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102-james-perf-dump-callchain-markers-v1-1-3a9bdec20c58@linaro.org>
In-Reply-To: <20260102-james-perf-dump-callchain-markers-v1-1-3a9bdec20c58@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Jan 2026 04:18:37 -0800
X-Gm-Features: AQt7F2rCSBYzVybmZSADwN7ss4nCpoqBKI7IjH_hBQJbrD9pwm1zZTt4PoOqe48
Message-ID: <CAP-5=fUmbpDb0S33qb82Wvh2PjSGOWYYFi-70FZSWD6L7TuwLw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Dump callchain context marker names
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 4:16=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> These are hard to interpret in the raw output because they are printed
> as hex but are defined in perf_event.h as decimal. Make it much easier
> to read the raw callchains by just printing their names.
>
> For example:
>
>   $ perf report -D
>
>   1798195372321 0x4638 [0xb0]: PERF_RECORD_SAMPLE(IP, 0x4002): 44922/4492=
2: 0x7c8046dd3400 period: 120218 addr: 0
>   ... FP chain: nr:12
>   .....  0: fffffffffffffe00 (PERF_CONTEXT_USER)
>   .....  1: 00007c8046dd3400
>   .....  2: 00007c8046db86d3
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/session.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4236503c8f6c..e812f8954075 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -841,6 +841,26 @@ static void callchain__lbr_callstack_printf(struct p=
erf_sample *sample)
>         }
>  }
>
> +static const char *callchain_context_str(u64 ip)
> +{
> +       switch (ip) {
> +       case PERF_CONTEXT_HV:
> +               return " (PERF_CONTEXT_HV)";
> +       case PERF_CONTEXT_KERNEL:
> +               return " (PERF_CONTEXT_KERNEL)";
> +       case PERF_CONTEXT_USER:
> +               return " (PERF_CONTEXT_USER)";
> +       case PERF_CONTEXT_GUEST:
> +               return " (PERF_CONTEXT_GUEST)";
> +       case PERF_CONTEXT_GUEST_KERNEL:
> +               return " (PERF_CONTEXT_GUEST_KERNEL)";
> +       case PERF_CONTEXT_GUEST_USER:
> +               return " (PERF_CONTEXT_GUEST_USER)";
> +       default:
> +               return "";
> +       }
> +}
> +
>  static void callchain__printf(struct evsel *evsel,
>                               struct perf_sample *sample)
>  {
> @@ -853,8 +873,9 @@ static void callchain__printf(struct evsel *evsel,
>         printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
>
>         for (i =3D 0; i < callchain->nr; i++)
> -               printf("..... %2d: %016" PRIx64 "\n",
> -                      i, callchain->ips[i]);
> +               printf("..... %2d: %016" PRIx64 "%s\n",
> +                      i, callchain->ips[i],
> +                      callchain_context_str(callchain->ips[i]));
>
>         if (sample->deferred_callchain)
>                 printf("...... (deferred)\n");
>
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20260102-james-perf-dump-callchain-markers-64d175b108c8
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
