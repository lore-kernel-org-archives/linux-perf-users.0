Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1914D2AB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738233; cv=none; b=u3B3EVwoLFqTUPySWl6EPILppZWvquKCfzs+GmETET7APtYAomVwDUkbUGzuEX18nWiGgwQ/aj/xvdWwQTOW+CQUhwlmfMVITjJnTzbRqEv1p93jp1ZGl2jmkDZbvXVBofg540hVuqh7ZWQAyFkiXrSdC7IeyLjpU0me24fHCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738233; c=relaxed/simple;
	bh=QTQImLo9rFpB1tHfY+kDtBW/jVdWzRo2shcpC9Oegsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcfFv0gl1a63pljLSVmOkZrtgPIHfVKLF8lcTrcrm7uxdVPWOhhMd7LqGBVUMS9KOG+HaUAfxY5jQqfh/H0P4KDlPA+T5cLII/prbc1rUwRNFz2OpP90tB9mNqGhPreNA8FIB+vPtAK4uWLruf9W5HJlEvQOznzdEJ45xAzwkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n76fygKG; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n76fygKG"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2610623f445so2629712fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721738231; x=1722343031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1PK/7EFDuzvwfgAoJnV5Sv6CmA0hzzCT8PA3TVv11TQ=;
        b=n76fygKGFEH7OK5HYp152fHil/DtQXLX7AWKl+oYc0znpOx69XRral59LbuxOKUvxG
         h+q0Om8t2E8wrPNwEprfYTa08olk4LED4xZ+/XK3aVraFFC0pZOhA3e8iyUMol8NDAsB
         P1AQkIreyiHmjbq4qJGeuFcz0lZk0QpEhV6MI1Qbi+tiNd2q3x+n8Fo2o91u0VmbmxNd
         U0pia2iM1stMpSzRE/Ge6rIqAaAPB3aOZ3ODRsHEW4XOUfEOcaFoGfq5SQn4MOFXCM9T
         nEmEu10aUKCxzP3b7cpRakvS6FejYUL5UIoreVjDccptDMwNKnBgG4GE1Qf4wUJ5SGXu
         FgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721738231; x=1722343031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PK/7EFDuzvwfgAoJnV5Sv6CmA0hzzCT8PA3TVv11TQ=;
        b=cypRQheeMzq72JV256ylVCJ2EDnWKEPez/vfSK8eu63lRNXQ73PkWKpFIBdMscuXXX
         dPjNW2nw3d2izIr3zogO33VAVZ5ic7q91W+cNkIRca6KKjXMSeQ/PcgV8dpPJlnu8Rvg
         qWoKDSVodJx0JoKqhLLrmDF+sdWCDpCDOtX9HpaSPakjqMww2T53pDcARcv/KGqXfMnR
         JUYlqWkd/LuGOmpTUj4qUU2iAL+vjSQsGFpTWY/PyrPgP8YwIeC0OG4fxD4m8jm2e5NS
         jQRGppQy6u+fNt0UEvT1+FADrZvT++aGHvSOnH87/pUKB0p9PJMUWCYyOusZ0ZQNirlQ
         DEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGPc7NfMIr0+GE+fHBbCvtBOwgRPamRRljhh10n0tL1BaH+4jP26S7ZKzIR8mCopx41RjknUX5VC0dhcsE0s29MchISLGOrnfxIe6MogK8fw==
X-Gm-Message-State: AOJu0YyaXNlvF1lM11sJAPTTczgZXb25jOgDrpvTlB4hZUAG+yAE3aOO
	n7cClZg0PJnkqOOw69nXS2i2M1Spi1ue2KbFiFlASs02zUo31lRyA3xCgn9hqLIsEbr8Y7NHJ92
	KWogTwrBaT6yj8/heXO8kbCSiEvNxGFtLJ99o9Q==
X-Google-Smtp-Source: AGHT+IGnQkB4dy1+XaxZaGC5cn9k/k/gqgs8XKEYWBSg3ze2AGNRxBxtP0Z90SRSbaXxF6TSdzpnrlfaIXPF8JuG5cY=
X-Received: by 2002:a05:6870:fb8e:b0:260:e83b:cc13 with SMTP id
 586e51a60fabf-261214e4a6cmr10019744fac.28.1721738230798; Tue, 23 Jul 2024
 05:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722101202.26915-1-james.clark@linaro.org> <20240722101202.26915-8-james.clark@linaro.org>
In-Reply-To: <20240722101202.26915-8-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 23 Jul 2024 13:36:59 +0100
Message-ID: <CAJ9a7VgPLpx3K9GVydDWhWSxLfsmeXEXntqA60S6ot12Kcefjw@mail.gmail.com>
Subject: Re: [PATCH v6 07/17] perf: cs-etm: Print queue number in raw trace dump
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 11:13, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> Now that we have overlapping trace IDs it's also useful to know what the
> queue number is to be able to distinguish the source of the trace so
> print it inline. Hide it behind the -v option because it might not be
> obvious to users what the queue number is.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  2 +-
>  tools/perf/util/cs-etm.c                        | 13 ++++++++++---
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index d49c3e9c7c21..b78ef0262135 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -41,7 +41,7 @@ const u32 INSTR_PER_NS = 10;
>
>  struct cs_etm_decoder {
>         void *data;
> -       void (*packet_printer)(const char *msg);
> +       void (*packet_printer)(const char *msg, void *data);
>         bool suppress_printing;
>         dcd_tree_handle_t dcd_tree;
>         cs_etm_mem_cb_type mem_access;
> @@ -202,7 +202,7 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
>         const struct cs_etm_decoder *decoder = p_context;
>
>         if (p_context && str_len && !decoder->suppress_printing)
> -               decoder->packet_printer(msg);
> +               decoder->packet_printer(msg, decoder->data);
>  }
>
>  static int
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 272c2efe78ee..12c782fa6db2 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -60,7 +60,7 @@ struct cs_etm_trace_params {
>
>  struct cs_etm_decoder_params {
>         int operation;
> -       void (*packet_printer)(const char *msg);
> +       void (*packet_printer)(const char *msg, void *data);
>         cs_etm_mem_cb_type mem_acc_cb;
>         bool formatted;
>         bool fsyncs;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index b11b0cae608e..6298a5c7a651 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -762,15 +762,22 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>         }
>  }
>
> -static void cs_etm__packet_dump(const char *pkt_string)
> +static void cs_etm__packet_dump(const char *pkt_string, void *data)
>  {
>         const char *color = PERF_COLOR_BLUE;
>         int len = strlen(pkt_string);
> +       struct cs_etm_queue *etmq = data;
> +       char queue_nr[64];
> +
> +       if (verbose)
> +               snprintf(queue_nr, sizeof(queue_nr), "Qnr:%d; ", etmq->queue_nr);
> +       else
> +               queue_nr[0] = '\0';
>
>         if (len && (pkt_string[len-1] == '\n'))
> -               color_fprintf(stdout, color, "  %s", pkt_string);
> +               color_fprintf(stdout, color, "  %s%s", queue_nr, pkt_string);
>         else
> -               color_fprintf(stdout, color, "  %s\n", pkt_string);
> +               color_fprintf(stdout, color, "  %s%s\n", queue_nr, pkt_string);
>
>         fflush(stdout);
>  }
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
