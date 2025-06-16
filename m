Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6701205ABF
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089896; cv=none; b=QMR0aje9/weUFJnyu0Cr8N63CTRfYsFvKJFm14vJthZkyg5zgTmpr2y8nBmp4qs4sNOa3wqGZwBQ13OQ6/jF2HNjX/O0aeQybwpe7KSfSAuaEDQTfvuoIyNkHzuQl9fo8nJnHN90iikBO2958mQOTgcWk4ZjlGXDtlAma/ktdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089896; c=relaxed/simple;
	bh=CTXOaQxjF5s8cpOyCgodMvW5akYuAc8hUy1j3ISoOi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XTOcqOV1B8xgyPGFAM8rV0/53Txq/8hSj3A4e45gGi0xokysbcPMc0PduDeawEZgxzxCgpLqcwoUVnEJS8DFHNQY8G0ZEzl5AuD4ds+rG7wRre97zelTpRRBiIWorp49oqgOcG/Yv9FQ4j6z5YcRs+v1eWvQH2TVfRcxSwsk+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wdTGek4m; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wdTGek4m"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3de210e6076so13745ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750089894; x=1750694694; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZRZa1Ua98kJCyhFA7LJvzcy8GOGnWbcpi55ofKuebY=;
        b=wdTGek4m+HXIx4GeEUOq/DUtaSpqLaBzrtKTSVGpB/PPRoE5WFiM/kaDllxZivkCsf
         RkmxHJrdJqqEpTlX8FFm/9xOs4XOizeZZ2sJ6IJIHZfQRuA/xaakOlkB0Tm+hhu6ICIc
         0cfbnabhDP4uj6mQtZSVTmjZMFsZlPNMlJwHWZNz41DTke46t+Uxin7dldg7WVwIQJzA
         0vn0wQSGHqEf0KvvfxJXkOzNZ52QO0yuu50vbhqu6vZd2TDQeBaoKirA9DMiiDZb7aYG
         TjpYKR84+P0tZpC0bNL/vCyFN5nqJXzoluaPfyWCui5fSpN3SESYupnumFo2gdeY9ozV
         SxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750089894; x=1750694694;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZRZa1Ua98kJCyhFA7LJvzcy8GOGnWbcpi55ofKuebY=;
        b=VUJRcvgRbf6v2OoOroYTtzwS6CORXAmoLlLTmLXMlYPgy/DtX+Q4rql9/npAr2Gg+Y
         oB7dDxjk43dEckaTdsPCV7/DY4LzoYEsd7hO8lt5KIoo7hSe5KJB7PiXjfb5uAiDqWUO
         8ZnNaFAUoACtyKZhJX2JZcSsC8k9H+XA+kEpSP00c81bI1ev+cOmINj9IEb0wGShKJP2
         cpJXdXQi5kVbwoi9X6iIZo9FImdCdGMPm7vPaS9EeIBuNzGZH0A1sMlwbAdkD++oJS/R
         GrNs/RYcjbVva2mqb8HxminY0Q2bWdUUUl/wTLrk96JOYwgCUho0teavARvDuatiJw41
         xKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6KpZ8Cp1IocYqk6kginTBvWQYoCmGAU9PBdsYSdNwnFOPB5bFMFmWYJ0B9wOvPGgtXYnWjcBnbgH3fj87nSUC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+boBzeKL6vMabLkQDCVmiUXMUec9ZL1LVHY8oiUregvGMQXD+
	NH/bx3FK9+7VS4TouQsWtqbzVnY7/WaBUYGNX+/uaniOtaN6nlnKu1PXYquxBMu9zxvW7vxmV51
	IBJIKqtxGKN0djN934rAlG2gOlnSSPMn21gQGl9JB
X-Gm-Gg: ASbGncv2H4OolX8N5SJGqWXHaJIQNZTsNuuFu4JTjxv46rPor4RAHYl502MG31FvGVY
	34svcknrfu4j4Nwsh+lU69jWoMQOlpKOq72zaKdjsmSzJ7pFiGctQOIxU08JQ86DPI3QCQhNaiq
	1eRoWtuCpl2f7UTGmRETrGPqsvr9xq8V3tSINj4Puan2oqEg3+qgYVOBNTG5P7V+MizrjQWg==
X-Google-Smtp-Source: AGHT+IG3s4dWQu5k75FFg5Yy95b2Uob76LNgIUsDXZ3AvKrlpHPFiygRDTyyDD1PQcX6Hb/G0QbUrYNCfpz1yIUcwM4=
X-Received: by 2002:a05:6e02:3786:b0:3dd:c526:434f with SMTP id
 e9e14a558f8ab-3de09fa7707mr5386615ab.9.1750089893690; Mon, 16 Jun 2025
 09:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614004108.1650988-1-irogers@google.com> <20250614004108.1650988-2-irogers@google.com>
In-Reply-To: <20250614004108.1650988-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Jun 2025 09:04:41 -0700
X-Gm-Features: AX0GCFuZNNCRbeo7C9EMdLxcNcUJ_Vg7ND5sifhQ9SMwnI_SNioYAxkmOzjkhH4
Message-ID: <CAP-5=fUz6ViPHDdS9GCAEYUN39L4MpAnRR4CzJWggg0S8vn39A@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf evsel: Missed close when probing hybrid core PMUs
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Andi Kleen <ak@linux.intel.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 5:41=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Add missing close to avoid leaking perf events. In past perfs this
> mattered little as the function was just used by perf list. As the
> function is now used to detect hybrid PMUs leaking the perf event is
> somewhat more painful.

Given this leads to leaking perf events on hybrid systems it would be
nice to land this 1 liner in the next v6.15 rc pull request fixes if
possible.

Thanks,
Ian

> Fixes: b41f1cec91c3 ("perf list: Skip unsupported events")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/print-events.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index a786cbfb0ff5..83aaf7cda635 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -268,6 +268,7 @@ bool is_event_supported(u8 type, u64 config)
>                         ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
>                 }
>
> +               evsel__close(evsel);
>                 evsel__delete(evsel);
>         }
>
> --
> 2.50.0.rc1.591.g9c95f17f64-goog
>
