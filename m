Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE017BD8;
	Sat, 18 May 2024 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715995530; cv=none; b=rze+DYYa4F+VyxzE89PMuVwWvcf680BixtuqhgR8C74LgMVY3Zew1qPYdfRewy/1AjRI/3gFqDl1OzH1qUfPN/2MqhOwHk81a/aBClYlmi5wRv0+aK4c9Oi7IRCbT0ZOC4mA8YyYc6AcbkTB5iZIEv2sSJ6W9vgHbpJ3n6zNzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715995530; c=relaxed/simple;
	bh=gGNCAEgaGSxKyK0M3Wz3dzLTm+3bFkC1PBZmGZGNEuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW1UIdRH7YU9qqORUZGT+msWlh+bp3YTBiwsCdsO2EHyP7loQy0HSnbHJHupR4ZDINNBF84oZzLfXMFzj95Shc/YkS5Z9FAJlo9SPTR9N/V1Z4Hc7bUIal+Ln4aWvMopzoKpGxKr2xa7QJpovBwfrQhFfmjOhA2CkMYJN0FfHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee5235f5c9so26365325ad.2;
        Fri, 17 May 2024 18:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715995528; x=1716600328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDQUikeYfqwULYL/qwCY+3xaT+gF8SPJCPZumyWDdUk=;
        b=FCAiDC5hgfp3+eS6Kb5ODRkvwFOCmYOdyneAe3CiGWUh3e/vC7QGP+m3blZg+BAQnO
         ksiYVZr/Fh4OxjlQ/5cOCYcR+eiikhDiCgZswvjSie83OV7ThZ7n8zfp1jIQZG31ft7F
         oAc6w+W9M4QuEDQwTLVqqN1Q+cFK9pbLNKR1lvwZkNTUieHQePTWkDUz9oXH3jjVThRl
         hEGqL3pzaDrMzEiVDYGoQUn61gxjs6QZ++jmxU8hvPFpfuDxKfiuNMd3CtIRp0AbQ82X
         Szga1dhxbp9wCxzmydvcoKm/8bgtv+Y5/ROjmZnhP6s91QRF4BQ0Gse0BeXjTC9FHzki
         WWgg==
X-Forwarded-Encrypted: i=1; AJvYcCVkVBUpOku+RVuqwYNMah7hVQZAjgDmt8grMu2TaMu8MHWavpG5YxeGfqDP5saN4G5wVUT4pwn4SJ8bImGoVhkXEhswjhtmJErgGYq6FB/K5v9eD9WsosFZWv57fVQ12wpJHWwg76f8TDx3YeswIA==
X-Gm-Message-State: AOJu0YxV46NglVEhprIojIqmYHxl7XZIob2wJ9bn6I17m3Ih3Sqh58oP
	bpaDNu7YXaVj14ttB4fNeG2ktzcvnXxPKgtgOpOaEc5VClwnpnf2rcmI1zgzHQaPzs9ugp34I3W
	cQNCL4Y9PE0hOQUN9nDdUrs//DG4=
X-Google-Smtp-Source: AGHT+IFwOVd1uEMDUiybxFimYcY2r3+FQ7f1CvTi3jQ9aJ4dJZpzWLBu91Wi32U5zPg1qEEqYE7ple4CezomiKO17bc=
X-Received: by 2002:a05:6a21:18c:b0:1af:8a3a:35d7 with SMTP id
 adf61e73a8af0-1afde1b6ec5mr22884415637.39.1715995527739; Fri, 17 May 2024
 18:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516222159.3710131-1-irogers@google.com>
In-Reply-To: <20240516222159.3710131-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 17 May 2024 18:25:16 -0700
Message-ID: <CAM9d7chsZ3EDRYW=YEJBd7wCYRLWNqMOFt33C=ghaY_UqZvGKA@mail.gmail.com>
Subject: Re: [PATCH v1] perf top: Make zeroing histogram on refresh the default
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 3:22=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Instead of decaying histograms over time change it so that they are
> zero-ed on each perf top refresh. Previously the option '-z', or
> pressing 'z' in tui mode, would enable this behavior. Decaying samples
> is non-intuitive as it isn't how "top" works. Make zeroing on refresh
> the default and rename the command line options from 'z' to 'Z' and
> 'zero' to 'decay'.

While it may make more sense, I'm afraid of changing the default
behavior.  I think we can add a config option for this.

Also instead of adding a new option, it should be able to use the
existing --no-zero option.

Thanks,
Namhyung

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-top.txt |  6 +++---
>  tools/perf/builtin-top.c              | 23 +++++++++++++----------
>  tools/perf/ui/browsers/hists.c        |  7 ++++---
>  tools/perf/util/top.h                 |  2 +-
>  4 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documenta=
tion/perf-top.txt
> index 667e5102075e..f1524cc0d409 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -124,9 +124,9 @@ Default is to monitor all CPUS.
>  --verbose::
>         Be more verbose (show counter open errors, etc).
>
> --z::
> ---zero::
> -       Zero history across display updates.
> +-Z::
> +--decay::
> +       Decay rather than zero history across display updates.
>
>  -s::
>  --sort::
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index e8cbbf10d361..8f06635cb7cd 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -266,10 +266,10 @@ static void perf_top__show_details(struct perf_top =
*top)
>         more =3D symbol__annotate_printf(&he->ms, top->sym_evsel);
>
>         if (top->evlist->enabled) {
> -               if (top->zero)
> -                       symbol__annotate_zero_histogram(symbol, top->sym_=
evsel->core.idx);
> -               else
> +               if (top->decay_samples)
>                         symbol__annotate_decay_histogram(symbol, top->sym=
_evsel->core.idx);
> +               else
> +                       symbol__annotate_zero_histogram(symbol, top->sym_=
evsel->core.idx);
>         }
>         if (more !=3D 0)
>                 printf("%d lines not displayed, maybe increase display en=
tries [e]\n", more);
> @@ -292,11 +292,11 @@ static void perf_top__resort_hists(struct perf_top =
*t)
>                 hists__unlink(hists);
>
>                 if (evlist->enabled) {
> -                       if (t->zero) {
> -                               hists__delete_entries(hists);
> -                       } else {
> +                       if (t->decay_samples) {
>                                 hists__decay_entries(hists, t->hide_user_=
symbols,
>                                                      t->hide_kernel_symbo=
ls);
> +                       } else {
> +                               hists__delete_entries(hists);
>                         }
>                 }
>
> @@ -460,7 +460,9 @@ static void perf_top__print_mapped_keys(struct perf_t=
op *top)
>         fprintf(stdout,
>                 "\t[U]     hide user symbols.               \t(%s)\n",
>                 top->hide_user_symbols ? "yes" : "no");
> -       fprintf(stdout, "\t[z]     toggle sample zeroing.             \t(=
%d)\n", top->zero ? 1 : 0);
> +       fprintf(stdout,
> +               "\t[z]     toggle sample zeroing/decaying.  \t(%s)\n",
> +               top->decay_samples ? "decay" : "zero");
>         fprintf(stdout, "\t[qQ]    quit.\n");
>  }
>
> @@ -583,7 +585,7 @@ static bool perf_top__handle_keypress(struct perf_top=
 *top, int c)
>                         top->hide_user_symbols =3D !top->hide_user_symbol=
s;
>                         break;
>                 case 'z':
> -                       top->zero =3D !top->zero;
> +                       top->decay_samples =3D !top->decay_samples;
>                         break;
>                 default:
>                         break;
> @@ -648,7 +650,7 @@ static void *display_thread_tui(void *arg)
>         ret =3D evlist__tui_browse_hists(top->evlist, help, &hbt, top->mi=
n_percent,
>                                        &top->session->header.env, !top->r=
ecord_opts.overwrite);
>         if (ret =3D=3D K_RELOAD) {
> -               top->zero =3D true;
> +               top->decay_samples =3D false;
>                 goto repeat;
>         } else
>                 stop_top();
> @@ -1502,7 +1504,8 @@ int cmd_top(int argc, const char **argv)
>                     "child tasks do not inherit counters"),
>         OPT_STRING(0, "sym-annotate", &top.sym_filter, "symbol name",
>                     "symbol to annotate"),
> -       OPT_BOOLEAN('z', "zero", &top.zero, "zero history across updates"=
),
> +       OPT_BOOLEAN('Z', "decay", &top.decay_samples,
> +                   "decay rather than zero history across updates"),
>         OPT_CALLBACK('F', "freq", &top.record_opts, "freq or 'max'",
>                      "profile at this frequency",
>                       record__parse_freq),
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hist=
s.c
> index b7219df51236..bcc4720f8198 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2305,8 +2305,8 @@ static int hists_browser__scnprintf_title(struct hi=
st_browser *browser, char *bf
>                                      " drop: %" PRIu64 "/%" PRIu64,
>                                      top->drop, top->drop_total);
>
> -               if (top->zero)
> -                       printed +=3D scnprintf(bf + printed, size - print=
ed, " [z]");
> +               if (top->decay_samples)
> +                       printed +=3D scnprintf(bf + printed, size - print=
ed, " [decay]");
>
>                 perf_top__reset_sample_counters(top);
>         }
> @@ -3209,9 +3209,10 @@ static int evsel__hists_browse(struct evsel *evsel=
, int nr_events, const char *h
>                         continue;
>                 case 'z':
>                         if (!is_report_browser(hbt)) {
> +                               /* Toggle between zeroing and decaying sa=
mples. */
>                                 struct perf_top *top =3D hbt->arg;
>
> -                               top->zero =3D !top->zero;
> +                               top->decay_samples =3D !top->decay_sample=
s;
>                         }
>                         continue;
>                 case 'L':
> diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
> index 4c5588dbb131..b2c199925b36 100644
> --- a/tools/perf/util/top.h
> +++ b/tools/perf/util/top.h
> @@ -32,7 +32,7 @@ struct perf_top {
>         u64                guest_us_samples, guest_kernel_samples;
>         int                print_entries, count_filter, delay_secs;
>         int                max_stack;
> -       bool               hide_kernel_symbols, hide_user_symbols, zero;
> +       bool               hide_kernel_symbols, hide_user_symbols, decay_=
samples;
>  #ifdef HAVE_SLANG_SUPPORT
>         bool               use_tui;
>  #endif
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
