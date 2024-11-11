Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7721AB6CD
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346849; cv=none; b=QP8Po2g82LIK8chPM1H1p8lyBciJN0KatFfo7zfeyJ63LgW2jLwrSCu/cJgmnmRWd+BbMgKpkqrwxT/7EhIzKGLeyqNRzKyIGbxu17HigsuAMj45cxvFQrc2kb3ZgY2Ekgk0Ar61y6cM5ZFcEjG/GEA//lvixlderDLy1nbvImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346849; c=relaxed/simple;
	bh=9mFrNoW93/rX0XAeqSLwO5oHi/lHzq36cxBpxa6J2JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZC3B/QqXvNLJj1o41ceuQ+JFGh0efpEOo8y9V90JY1iYgo25rYNMmD1/ZS/CGGNUtr5JlH1Eup9PYGgIm78k4ZCmLPsjbsfMVFzljB/YYA+VtYIukFYJN+LPlsg99gLLkp0nf2WocW9iBJMKIk4O//TLwDNpy9JCABg5J+F+H1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZZcG0L9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZZcG0L9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8ac50b79so2085ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731346846; x=1731951646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HXhfLBhO3coI1dHk269DsGEIZcTKNlot53AmZg4T9M=;
        b=GZZcG0L9euxbtZOpSQ7EOi0tbFL5YEV58cpicx2HtSNqNrrzccH1fZ+JfHwen6CdOB
         YpPoVQSKRTWvOt3lqo7hfUf1tBZbKm4K0HFMPNubUtzgwq5MeY0046l5ILcbh0k/vyGg
         lzoQg2p4kZRKUuCSRju7+cwltniXty0mAnuUDdeWplY6Be1kIrWHGBGZ+okRAZ/z9Zxn
         SnBWaGyEmYTbAeCFDdC17mbfLKDpuZ+hBAEyN8yg1/8ppNbBxCzkEGeK2Lj4deI6kRkw
         D5/KeXbVU7VARjVTh/10aeI1sZoUQuckn7N7zk65y2QDwn+DOWZwJes1illnKnQyqZ+W
         DTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346846; x=1731951646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HXhfLBhO3coI1dHk269DsGEIZcTKNlot53AmZg4T9M=;
        b=qaKjZdYmfzqFq9gPh/dccW8J3PG96ZAHMsiE8fFfaSPrvi27vFk0CixCbD35y9izWS
         bXIQRgF/V2jvuE3aTXUmb5dVyjTJ+3K4URzZuqd4MKAzvWridimBeNLCpJgVG8US8Z+N
         Kf+R5mec19QSeoQ17lY2xX7d3Rn8gHQwVoDJhjK8v1+Sn0+ZR0l8e6ZLCzmTEuPsX7vq
         Gszsnt5Ie79JzRcPZNyg9BbqC57Z1rT7P3l4Akm5StMMlsTLH/jaXZLiGT4+znq3fyZj
         nyD7SrOVQRMBKVtpMm9ScoZ3f1K85lCQKSDaTSwiC0gloSyaPA/DEFKqN/z0+18fdASJ
         cpgw==
X-Forwarded-Encrypted: i=1; AJvYcCWwMC3ozajAQ+iKnEiFEiqijqYdLFLoX0dB6oLreoJFAVaspnMnEaGq/tEHltVuZXL4cYd8IVoggnWpF2F/einB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsz6E5qqVFi01JkU5Hqy54FHnNdVZrxx1TsWxC2kNwFd1RtBT5
	U1hJIpKssIJJDBR6a1t8zgHmGI5nI31F+OKKsCDmXwag8iJn1tVsVgDMt8wFgpApk6b4HlZu2b7
	f3K9dmp3+P9l+AB90Vs6v4TmJJ31boS9e/9OS
X-Gm-Gg: ASbGncujeH6sH8KOPxI2++0foHHDsmW+UaYoIdaWQl2tiU57K86/lx7V31y1joiFsHS
	M4rDN+Pr7aQCVdaoU0VSbvJ5YQkAH1xsVynmNQqI+54MgXVX9NGUHtGmZTMVC4VI=
X-Google-Smtp-Source: AGHT+IFMpzgDfvNQa5JrCz2VZmXgBLmq/P+th3f1MUkeCqgKU1qfRAQ2N1x7WN3i/oVzWilxwXlZCxrnO6Q6cY80vW0=
X-Received: by 2002:a17:902:d4cb:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-2118dea0992mr4437325ad.6.1731346845810; Mon, 11 Nov 2024
 09:40:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-2-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-2-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:40:34 -0800
Message-ID: <CAP-5=fUpm9Y86qvxGs4p6nG9QPW4FKbzRh_Oot4dEUXWdLGQ4g@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] perf record --off-cpu: Add --off-cpu-thresh option
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> the unit is us (microsecond). Default value is 500000us (500ms, 0.5s).
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-record.c | 26 ++++++++++++++++++++++++++
>  tools/perf/util/off_cpu.h   |  1 +
>  tools/perf/util/record.h    |  1 +
>  3 files changed, 28 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f83252472921..ee04fdd7f2ca 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3149,6 +3149,28 @@ static int record__parse_mmap_pages(const struct o=
ption *opt,
>         return ret;
>  }
>
> +static int record__parse_off_cpu_thresh(const struct option *opt,
> +                                       const char *str,
> +                                       int unset __maybe_unused)
> +{
> +       struct record_opts *opts =3D opt->value;
> +       char *endptr;
> +       u64 off_cpu_thresh;
> +
> +       if (!str)
> +               return -EINVAL;
> +
> +       off_cpu_thresh =3D strtoull(str, &endptr, 10);
> +
> +       /* threshold isn't string "0", yet strtoull() returns 0, parsing =
failed */
> +       if (*endptr || (off_cpu_thresh =3D=3D 0 && strcmp(str, "0")))
> +               return -EINVAL;
> +       else
> +               opts->off_cpu_thresh =3D off_cpu_thresh;
> +
> +       return 0;
> +}
> +
>  void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __=
maybe_unused)
>  {
>  }
> @@ -3342,6 +3364,7 @@ static struct record record =3D {
>                 .ctl_fd              =3D -1,
>                 .ctl_fd_ack          =3D -1,
>                 .synth               =3D PERF_SYNTH_ALL,
> +               .off_cpu_thresh      =3D OFFCPU_THRESH,
>         },
>  };
>
> @@ -3564,6 +3587,9 @@ static struct option __record_options[] =3D {
>         OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analys=
is"),
>         OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
>                    "BPF filter action"),
> +       OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
> +                    "Dump off-cpu samples if off-cpu time reaches this t=
hreshold. The unit is microsecond (default: 500000)",
> +                    record__parse_off_cpu_thresh),
>         OPT_END()
>  };
>
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index 2dd67c60f211..c6edc0f7c40d 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -16,6 +16,7 @@ struct record_opts;
>                               PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN =
| \
>                               PERF_SAMPLE_CGROUP)
>
> +#define OFFCPU_THRESH 500000ull
>
>  #ifdef HAVE_BPF_SKEL
>  int off_cpu_prepare(struct evlist *evlist, struct target *target,
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index a6566134e09e..3c11416e6627 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -79,6 +79,7 @@ struct record_opts {
>         int           synth;
>         int           threads_spec;
>         const char    *threads_user_spec;
> +       u64           off_cpu_thresh;

nit: I know existing style doesn't do this but it would be nice if
this were off_cpu_thresh_us (ie the unit is at the end of the variable
name). Most programming languages have gone for having explicit
time/duration types to remove ambiguity. We're peasants so it'd be
nice if the variable name were hinting me in the write direction.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  };
>
>  extern const char * const *record_usage;
> --
> 2.43.0
>
