Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/nxXtBZ"
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12114D1
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 09:05:50 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-58a7d13b00bso476224eaf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701968749; x=1702573549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/gQwCYDHPBBWnGreQGj5kMmktVS56VhncbMZUIjTkxA=;
        b=N/nxXtBZdALdkfa05rASSt+SKtNvnIxvZ9lp2fYxAANLa2BIwY3Uy5QkBvcimzBTjS
         2+ukcvhC6xj0NLeLo7Ae2/MiIiIVs8lttDZK3rTY7nTSwCXvAY0Oa9dWfuxgnhJgRUoN
         rPNpCOnFwDgw16ZpMxxQL3/8P93M3A+DgBuLAS7aKY7NTx7dgMBODbwkx9BRlQvEYoch
         l/vTd9SCrh/30LFxRA8KZo4vembEIafl63CEWfjKG+9X2Iyg2M/g8ONleNv39jtZ0N3+
         5q3wZtzRYEe/y/7DVLc3lt4r5IgrHTrWtyWU1s0otBK75Ckbl6Qtvdwktk00wBBBnSh+
         4p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701968749; x=1702573549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gQwCYDHPBBWnGreQGj5kMmktVS56VhncbMZUIjTkxA=;
        b=aw4QTicHhIKfIPtiZ/mf1tw667VaZ+mxaWRcVxSKqp+L8/4Fyt+z08Zvh5kDjhSkwY
         5elWvAbO4vY6wqnyL4IHlwqTooxoJ6dnzibebRuHZ0ObbjFEWXal3l0rF280mlTn6voP
         hjj+IPYM3EOya0BwrdlcIzx1uBmLfNAVDxgSnR1h9kozxiE/LCHJPGbQ6FC/CaUiceWw
         hPd7IwLePlB/r9QCsXwSy1rRGyEeT9JQLryym8o4HhxfSuGHM/AzZZffhQU8xag+CY+2
         Yg1Nv0psVBW9y0hJhPA2RrKBlZy71NNZNA/R5CCyHPAiwVho5NFyA6gxZTrpbCZGSQrq
         yIqQ==
X-Gm-Message-State: AOJu0YxQoPmUNiqWgY1FuEVM6h5rYNYEtTjPZmxGDfkEcQCgAVGUsLWZ
	mAdDT69iDnEgIxpvAUaQNB+uCr2GWrqBq1MnfLXXGg==
X-Google-Smtp-Source: AGHT+IF4nJjAccTc+VF4SuAKFW4kIPR8iNtdeRIf4Ey84+2bpA53GJ5Bnp23SGyiRFLX1R/TpK0sBvk/IlcMGvxka3U=
X-Received: by 2002:a05:6358:5e14:b0:16d:f743:4107 with SMTP id
 q20-20020a0563585e1400b0016df7434107mr2967267rwn.3.1701968748863; Thu, 07 Dec
 2023 09:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-2-khuey@kylehuey.com>
In-Reply-To: <20231207163458.5554-2-khuey@kylehuey.com>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Dec 2023 18:05:10 +0100
Message-ID: <CANpmjNNi1WoE0gsq5TSv8ys68YcF2o+LtWiDj+=bZ3Y46oP7Jw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf: Reorder overflow handler ahead of event_limit/sigtrap
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Dec 2023 at 17:35, Kyle Huey <me@kylehuey.com> wrote:
>
> The perf subsystem already allows an overflow handler to clear pending_kill
> to suppress a fasync signal (although nobody currently does this). Allow an
> overflow handler to suppress the other visible side effects of an overflow,
> namely event_limit accounting and SIGTRAP generation.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  kernel/events/core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b704d83a28b2..19fddfc27a4a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9541,6 +9541,12 @@ static int __perf_event_overflow(struct perf_event *event,
>          */
>
>         event->pending_kill = POLL_IN;
> +
> +       READ_ONCE(event->overflow_handler)(event, data, regs);
> +
> +       if (!event->pending_kill)
> +               return ret;

It's not at all intuitive that resetting pending_kill to 0 will
suppress everything else, too. There is no relationship between the
fasync signals and SIGTRAP. pending_kill is for the former and
pending_sigtrap is for the latter. One should not affect the other.

A nicer solution would be to properly undo the various pending_*
states (in the case of pending_sigtrap being set it should be enough
to reset pending_sigtrap to 0, and also decrement
event->ctx->nr_pending).

Although I can see why this solution is simpler. Perhaps with enough
comments it might be clearer.

Preferences?
