Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326D142E77
	for <linux-perf-users@vger.kernel.org>; Wed,  7 May 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611906; cv=none; b=bpFwpri4LigpUH/ARoLpq1tcA7aGwOnEAYqrwURQ3D6V8/jaEHgiglz/FWnwF/ziWazVTk/PMvy4CE9CM+3gnqaapgbYze5y2bGXi69486tFGayBucg7mkEoag/dMGM8HFh6uHC7XNAKWeZlx0D7D5XSEIVefPcaPalDTJRSVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611906; c=relaxed/simple;
	bh=XFgZtcoLkhyNUROFBBsfK3A6oxSGmK9k5IgnGXbA59o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKImxvOpTTgmO/28kbxwwkqA4IEYka8cIm3Y9xCMYpV8u0krIGI5xxJjIM5VSLkR5MzYThXiwLTBQLqsT4tsI/RAe+qNeopnHmXNf3AXtAxvpfLKzPrwK2AejMbCLXkV/xJfLouxgLksWscRKjV5N7qDKhwQrerXF91NkzWWysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLNwEBxp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLNwEBxp"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db1bc464dso60396631fa.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 May 2025 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746611902; x=1747216702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nXwWfv9Y6m7fKiVmRbaKc0nnBUxgLNgKEyyeKygDRoo=;
        b=aLNwEBxpoz12lpsTIJR5TfwkYuPys7TWoEPRfq5jDZy0bDC/BLqtMMvezs6usxwNiS
         EhxrL98iagXvEEc5eZolPJ8WBbOnrUaoHaKsGN9wGhatpm+NXzZWcDGLlz5t03zAo8mG
         yuzlHFbzjlLTxZl5UCBX32jOq+bIm4d0TL4be9gmi0u36dynpHUF8UBGetVDKZ8PqwPA
         +fv/vJXIjc/YwgVykkuxQyNRWInhUjvbbtFfi6Jjqm/cPWdMxSCd4TI1PeQeqYriBR+n
         zlMhAq2McJGmPsx29JF2p2mvHzZ8Zhi5B3y4J8vVqaXCEyiXMAPLptZkbQwuxS2AngYi
         v91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746611902; x=1747216702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXwWfv9Y6m7fKiVmRbaKc0nnBUxgLNgKEyyeKygDRoo=;
        b=N7CWJuWvlarh3FJn1kzXmmqb8h0+Bpd938O/g8v4hTQO4lFv8JlZZqfFGJnCShWIwj
         KkbWmRmhjDVM6yz8KRGkbC7MpPNfax0nFCGTEseoLAhXAyjJpVhlkezUiREEIQpDBey7
         g2SlPboSAwM4os86YVy1LlGDD0tawxmxBfEh8vyB835BzqI+LmJu3uWGeQ4cxTb9WE9h
         CconlnUfEoDb0rpRsMCiL5QNuUnkaTv7VXRv7Xs87NoEC0ce5OWXWiUn1mFeCA4eQM/U
         rkYaghB7NnhXsLmXFgBBzwWjPAh9622o1fW9wzwzqzrXkS6MfN8NFXpbXov0aWnrxYYP
         Mv/w==
X-Forwarded-Encrypted: i=1; AJvYcCXVYy5C5D1kjJ1ORmfZcoaeJS6ClLxXfsy6YbWJh06biu1FcTZE+SzGBO3rZb8OlddF01H6TfmHI+ZKDHhWkLpu@vger.kernel.org
X-Gm-Message-State: AOJu0YwP53FO8hM5hqt1dds2tTLBXafGtEJsCsm6DldjJH26u4dMC2MR
	K4EZ+u6jxH5QfgX4TceI1xhe2NCewGLwOG5VsAy4R3pq5aBbjNFZG8FknvRzpw19zNU34IZEz4O
	12EVHU9MjWI4pHIveLsm2Y6ZMR1vZ8pm0IyNm
X-Gm-Gg: ASbGncsH6T37LYBf3BzbccNmPlnjF4RX7IoRLYsd2ALXMs3OVNtLOaulVZVUgnmD9Lq
	OC4VCjb9TSke7Z/2qer5Cm1rPEab0HJUnI5GNyMthqP2MeTPWZD8JuZh0EYwBbDcRaq99RDscaz
	cX7lOTS1KLK1bMsTyKBUmo6DLXdqGnb5URb0jU7fPi+0+j4B98C69Gwdo=
X-Google-Smtp-Source: AGHT+IH0nmguA5kmGfa+Jl62Im4bswR065WDLtDiHTlXIIynmZg5V0baBKOHGZ6yFCYiOEEqBKRsxwDBltscNuJZEKg=
X-Received: by 2002:a05:651c:2221:b0:310:856b:6862 with SMTP id
 38308e7fff4ca-326ad18b8cbmr7187081fa.12.1746611901682; Wed, 07 May 2025
 02:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503003620.45072-1-namhyung@kernel.org> <aBcjwoINtWRWKMIJ@gmail.com>
 <aBfFlT0l05yBbZBj@google.com> <CACT4Y+YvWYFBkZ9jQ2kuTOHb6pZQwWXc9sOJ5Km0Wr1fLi-94A@mail.gmail.com>
 <aBojTzsa5mSAGziP@x1> <aBo_z8Q87gflYyuX@x1>
In-Reply-To: <aBo_z8Q87gflYyuX@x1>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 7 May 2025 11:58:10 +0200
X-Gm-Features: ATxdqUE2PC2As493JjnQWWXVxL49H-woPEJSwzDPASz1ZQ5sZV00TE2_CZ9jlO0
Message-ID: <CACT4Y+YG61CUPG1WRSGWgv00eP9aPYLELvDVmjK9ULJwNiiMgw@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 18:58, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> On Tue, May 06, 2025 at 11:57:19AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 05, 2025 at 10:03:05AM +0200, Dmitry Vyukov wrote:
> > > On Sun, 4 May 2025 at 21:52, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > On Sun, May 04, 2025 at 10:22:26AM +0200, Ingo Molnar wrote:
> > > > > > Here's an example:
> >
> > > > > >   # perf record -a -- perf bench sched messaging
> >
> > > > > > This basically forks each sender and receiver tasks for the run.
> >
> > > > > >   # perf report --latency -s comm --stdio
> > > > > >   ...
> > > > > >   #
> > > > > >   #  Latency  Overhead  Command
> > > > > >   # ........  ........  ...............
> > > > > >   #
> > > > > >       98.14%    95.97%  sched-messaging
> > > > > >        0.78%     0.93%  gnome-shell
> > > > > >        0.36%     0.34%  ptyxis
> > > > > >        0.23%     0.23%  kworker/u112:0-
> > > > > >        0.23%     0.44%  perf
> > > > > >        0.08%     0.10%  KMS thread
> > > > > >        0.05%     0.05%  rcu_preempt
> > > > > >        0.05%     0.05%  kworker/u113:2-
> > > > > >        ...
> >
> > > > > Just a generic user-interface comment: I had to look up what 'latency'
> > > > > means in this context, and went about 3 hops deep into various pieces
> > > > > of description until I found Documentation/cpu-and-latency-overheads.txt,
> > > > > where after a bit of head-scratching I realized that 'latency' is a
> > > > > weird alias for 'wall-clock time'...
> >
> > > > > This is *highly* confusing terminology IMHO.
> >
> > > > Sorry for the confusion.  I know I'm terrible at naming things. :)
> >
> > > > Actually Dmitry used the term 'wall-clock' profiling at first when he
> > > > implemented this feature but I thought it was not clear how it meant
> > > > for non-cycle events.  As 'overhead' is also a generic term, we ended
> > > > up with 'latency'.
> >
> > > Exactly :)
> >
> > So, the 'cycles' event is the most commonly used, its the default if one
> > does 'perf record' and don't ask for a specific event.
> >
> > When we notice that 'cycles' and 'instructions' are counted, we provide
> > an IPC, as that is a well known metric for that combo:
> >
> >   root@number:~# perf stat -e cycles,instructions sleep 1
> >
> >    Performance counter stats for 'sleep 1':
> >
> >            1,149,493      cycles
> >            1,197,279      instructions                     #    1.04  insn per cycle
> >
> >          1.000645408 seconds time elapsed
> >
> >          0.000599000 seconds user
> >          0.000000000 seconds sys
> >
> >
> >   root@number:~#
> >
> > So maybe when we notice that cycles was used 'perf report/top' should
> > use the term 'wall-clock' for the column name?
> >
> > So instead of having a --latency we could have a hint that would tell
> > the user that if this knob was set:
> >
> >   $ perf config report.wall-clock=true


I am not sure it can be as simple as a single global knob.

First, record needs to collect additional info and that may be
somewhat expensive.

Second, report now has several modes:
 - it can show latency, but order by the current overhead
 - it can also show latency, and order by latency
A user wants one or another depending on what they are optimizing
(possibly looking at both).

I also feel that global config switches are even less discoverable by
median users (read -- ~nobody will know about that). If these things
are normal flags with a help description, then some users may
eventually discover them.



> > Then if 'cycles' is present we would have:
>
> Something along the lines of the patch below, but there are several
> details to take into account with what is in the current codebase, only
> if what is needed for doing the latency/wall-clock time is present in
> the perf.data being used is present that knob would be used or suggested
> to the user, so some refactorings are needed, I'll try to folow on it.
>
> But just for reference:
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index f0299c7ee0254a37..20874800d967ffb5 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -51,6 +51,7 @@
>  #include "util/util.h" // perf_tip()
>  #include "ui/ui.h"
>  #include "ui/progress.h"
> +#include "ui/util.h"
>  #include "util/block-info.h"
>
>  #include <dlfcn.h>
> @@ -127,6 +128,11 @@ static int report__config(const char *var, const char *value, void *cb)
>  {
>         struct report *rep = cb;
>
> +       if (!strcmp(var, "report.prefer_latency")) {
> +               symbol_conf.prefer_latency = perf_config_bool(var, value);
> +               symbol_conf.prefer_latency_set = true;
> +               return 0;
> +       }
>         if (!strcmp(var, "report.group")) {
>                 symbol_conf.event_group = perf_config_bool(var, value);
>                 return 0;
> @@ -1734,6 +1740,15 @@ int cmd_report(int argc, const char **argv)
>                 symbol_conf.annotate_data_sample = true;
>         }
>
> +       if (!symbol_conf.prefer_latency) {
> +               if (ui__dialog_yesno("Do you want to use latency mode?\n"
> +                                    "That will add a 'Latency' column that would mean\n"
> +                                    "'wall-clock' time when used with cycles, for instance\n")) {
> +                       symbol_conf.prefer_latency = symbol_conf.prefer_latency_set = true;
> +                       perf_config__set_variable("report.prefer_latency", "yes");
> +               }
> +       }
> +
>         symbol_conf.enable_latency = true;
>         if (report.disable_order || !perf_session__has_switch_events(session)) {
>                 if (symbol_conf.parallelism_list_str ||
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index cd9aa82c7d5ad941..f87071f5dedd94ca 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -51,6 +51,7 @@ struct symbol_conf {
>                         annotate_data_sample,
>                         skip_empty,
>                         enable_latency,
> +                       prefer_latency_set,
>                         prefer_latency;
>         const char      *vmlinux_name,
>                         *kallsyms_name,
