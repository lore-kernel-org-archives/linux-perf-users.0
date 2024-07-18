Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCD13D2BB
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309127; cv=none; b=mYh7cLjiDOAiwwPj81QG7Q6SZWaFQHtYMsk83y0Oxo59vcgpJ13Qikvd11Ah5MmZdMvFzMiYmLtP4H6jOKxO3cgdf529XDe2tF9HU+FD6Oc0Lc1nIpITI9rtXk41RFqKRifMtJwNfZyKV/8Flojkk7LZ6HlZnxtnxdM9s0ul3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309127; c=relaxed/simple;
	bh=S5dkrZMYBtJRxu8uD8VPJpkEyyYra5z4jh+F0jFEWbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPiLBeHrUsyv338caOzDu410OsaZ3lghItEt37bki0sSBJos1hKNPPD/ChS4GLIB4nSOpm4XrzvM9NP0F/veA194Tt7Er4OTKk2hD5oUkxFKvWf46uVgu1I1Ve+s7Wdx5rYemhZhavPl2ke1ter23Vp+D2nrEQEd7p6muaZtktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQjBDo4s; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQjBDo4s"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25e400d78b0so323245fac.2
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309124; x=1721913924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vir5nuwGazUP8EA8QzwI5PQf4dQjth2jy2roymqp4Nw=;
        b=CQjBDo4syy8HqtaJiqdYfD7P6xrvfO8f+R07qRTedRr3Zfr7rHUs6FHaraCwncDzup
         09ynVjXBSg/H3D8lmdRMbISYqDH7dsANnAQ+mWHnQnSERqKKPuHZq/dTOH9ShLZsILWI
         bS6bBMIwOenwmH7UZ/UtXycc3u8NmdPwCV2dm9eRU5uQsdSzqMqUDtRItcbCU/6SZD1a
         gpXNrjmpScWH81LdCR/s894EP4kJVL+i6boTK7sVuXC+rwEEwKrGipmYayxpcGfAnErM
         Iv03BOuw+d0nDwL42kneSNbq39lbUnKx82gcjyczoJSNh55Q2A68fr4D8I6Zk2WwrleB
         E3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309124; x=1721913924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vir5nuwGazUP8EA8QzwI5PQf4dQjth2jy2roymqp4Nw=;
        b=unIAjTtppf42iSMRgOY+H6zmx8WrK/SymWGK27K2E3AV8FkRNdjmguoOkWwqr2Q8PT
         +paEIWj2/vSzoqbtUAG24D3JDZr47F80KA5fMy6YYZCHyf2YuIZSE9QpD50PTDejAoCa
         lmcYC15H9/Tc3RFrmy7LUwN279iApqKopagigdKdWyGCyCQCEIvYuPkmPIEiFF1r/jvE
         QP5ZJBWJNrdU4fxMrYNRKQHViqjgLqEurSh6QQI13X02Pt4jqvS+8HEqWB2hYNMiK6i/
         hc5MRuPmSCojtDxSIW1LtAgAlBlt4CTRjRLC72oJyJD11C3/YTWhM8Rdg73nquR/xAUJ
         7hBA==
X-Forwarded-Encrypted: i=1; AJvYcCXGdhXzi4J2c2Qk3gFAqqiZfSGrEt+hMl/8gS8st/eYFoxsR+crEQAoOeUQNOt/ypZryHcISG9PY0ehPY4uG+gSJkBKyEWC7i3rme+p9SgYaQ==
X-Gm-Message-State: AOJu0Yz025CEJQB70ysJocoZj93k7T4iIrTnoyf/9Dm6wY8cWIP24+I2
	8AXDZBFdPQ7WBJqXADJzT1RWjnm9Tt3WbWa41NlrwH7Xqi+5QQ2SN+58i+9qFY2ccbzsAw8H+2V
	YVbm0q8fG4YOv+lBquC86FiIvkYHRRFxH9N/jiA==
X-Google-Smtp-Source: AGHT+IEPkgjGJn18JYE974ykVld89iuuCfjj4jWKBJklPyYHI5h+O2RZ3oJBBiisTG2ZSOhOgPHN1XUGr6CrzMpV6u8=
X-Received: by 2002:a05:6870:2308:b0:25d:e3d:b441 with SMTP id
 586e51a60fabf-260d921d6f1mr4069222fac.40.1721309123785; Thu, 18 Jul 2024
 06:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-8-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-8-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:25:12 +0100
Message-ID: <CAJ9a7VjH+3LFJvSHkKUD_hJjxnpk3zyJ3ohFL6J6rgyquqyj=Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] perf: cs-etm: Print queue number in raw trace dump
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

Hi James

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> Now that we have overlapping trace IDs it's also useful to know what the
> queue number is to be able to distinguish the source of the trace so
> print it inline.
>

Not sure queue number is meaningful to anyone other than someone
debugging the etm decode in perf. Perhaps cpu number?

Moreover - other additional debugging in the trace output is
controlled with build options.
See:-
Makefile.config ->  ifdef CSTRACE_RAW,
thence:-
#ifdef CS_DEBUG_RAW in cs-etm-decoder.c

which adds in the raw byte data from the trace dump.

Could we make this addtional info dependent on either the standard
DEBUG macro, or an additional build macro.



> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 2 +-
>  tools/perf/util/cs-etm.c                        | 7 ++++---
>  3 files changed, 7 insertions(+), 6 deletions(-)
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
> index 87e983da19be..49fadf46f42b 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -762,15 +762,16 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>         }
>  }
>
> -static void cs_etm__packet_dump(const char *pkt_string)
> +static void cs_etm__packet_dump(const char *pkt_string, void *data)
>  {
>         const char *color = PERF_COLOR_BLUE;
>         int len = strlen(pkt_string);
> +       struct cs_etm_queue *etmq = data;
>
>         if (len && (pkt_string[len-1] == '\n'))
> -               color_fprintf(stdout, color, "  %s", pkt_string);
> +               color_fprintf(stdout, color, "  Qnr:%d; %s", etmq->queue_nr, pkt_string);
>         else
> -               color_fprintf(stdout, color, "  %s\n", pkt_string);
> +               color_fprintf(stdout, color, "  Qnr:%d; %s\n", etmq->queue_nr, pkt_string);
>
>         fflush(stdout);
>  }
> --
> 2.34.1
>

Mike
--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
