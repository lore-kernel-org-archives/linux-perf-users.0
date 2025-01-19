Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA551ACECE
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Jan 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737282184; cv=none; b=TkLt+URmVM2upMhjZbp+Q+heHxNLOxFbycWmqH/buHaZAzB8tFDtvojehVdPdehzFv/OWZWX5rBS7TLgMP5wmXFCknoyAqh0AJjqOdSwPNR03zApNFC92UIh9K77KmkjvZNGNcg6atGOpyT8D0/iQ+InsA1vll0FkAbqHMfWeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737282184; c=relaxed/simple;
	bh=n7RnwxApVfwtH9d9V/9HqmUm7snQqNEs4jEaZ2MAPhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfPUOCd5pcJ4O0DHfpVQObz86AwzeeCo5lwjwumhb5E2SNvXsxiEC4SxW4YAE3Dsj/ovlVobNIX4mqd1J12XtKaQAu7+8QCYpNOHc+TtAqKnKEOSSDG0jawOJJdRozOWc5AqFq5RY/ruIHqiUYp5fPUrmymjuPlpXV2nXKoSjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKkK8o4f; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKkK8o4f"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30737db1ab1so8726331fa.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Jan 2025 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737282179; x=1737886979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMOPzGsB4wHLKLXh9BFJQVKCSlJQ7gbAMOVRHCuJ248=;
        b=GKkK8o4f+Ah3vFhBLRrzd52AHHbL+dFHkbZjbwmJHpKjwLwPLxlUUc+wO1PDRD7LzY
         mSlgzVu/S6avcEEx2I/zOT/L5re3x10HtN7NvZ7MyhEiTt7lap7ZBGo1ffpfcakNo8tG
         avlg+96pKFyoVsKsdVQdqnJE/4XwmXVxmSwFd/eMfZNsUoIgHaCXbvn1QHzM0qo7bbos
         zEJUjW1ZWzcONNVRH+a1xdGaBUpcqNAkELTq1XY7AIFMgvkXIPx4CKYQM98XgC9WEuIL
         AgDKT54qT1D4aTouJFwNmCFyRyyEnm9Pv8McmKzdCK7yVvsB/hohYfxTlbBE20ckDWFx
         9lRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737282179; x=1737886979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMOPzGsB4wHLKLXh9BFJQVKCSlJQ7gbAMOVRHCuJ248=;
        b=rmuzryeBArY/xABupVaHEQu9cA2I+Gi3sSNuj0zGpINq/sVg/yU31e7l59IqBOwpUN
         Jg4YPCSMf5HNw0V2Qp+mSANYehhWn2ELV5SHBdBa6aHHsFhZo95fETJKyA4JdslymPjC
         Td1uD6A6VeiYoH4uP9PMUSx3ZvUgHmAa0ETzK6PNJhKa89tGZGBulhieX9GoQ2svmhJj
         d+xsUylhRaikqN6U8416gWwCQ6LlUwaQuTP/eqkJrJlYm87CiPG2kKj1cGDi107H0K+w
         u1MML+gSaQUF5IBY9bU4tpIH+ymLMQgVUI9ozASoxc3guIftpORHQh0XQ6R5zb6LBD2/
         0Msg==
X-Forwarded-Encrypted: i=1; AJvYcCWIXHOU6KJdsmF/8dpnyr7XwxkYp0TeeNW8Pv+oYKHgYIuUy3q0hSyBSilpyx5kacLrM+7FdJXjayt2JEMmL33P@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKM1J8G18rm6cvvT6s4VTC8suWlXPeLbST+iEFvBwMj7rqysb
	7vQPSUV2GaJedNyhaiX0Udv1uZ7mh5fgObKOvKpxjFeWVxnQFyX1kjracyeQlliKWYH2N/SNNMa
	uvbDhdqwUzrF6AoU63zvMnMU/GUTHARTwfGwD
X-Gm-Gg: ASbGncs/DIi3/ea+jSNTlQ7u3uFObLGSCK2tiCpYAevF7mTRhFN93tbz0XUuFjOAKZh
	ox4ERsnSLvdD1Sue7wnoGBOPgP9YM+f6al0vNtjirCeYiVfsIZKxDDPAeLBdhuE/j1ldLFiyydL
	CxbQd+tQ8g
X-Google-Smtp-Source: AGHT+IHf4aL0acwWqR8+8T2PCSikfIZ2/n/rxC150QknOV9revME4rlNUTihWShHlyCT99fttaf6urpXYdff7KG6NGQ=
X-Received: by 2002:a2e:a994:0:b0:302:26ae:7bcd with SMTP id
 38308e7fff4ca-3072cb0d887mr34589461fa.23.1737282178707; Sun, 19 Jan 2025
 02:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com> <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
 <Z4aJSde5KXO-rqWM@x1> <CACT4Y+b6nbqNHt1MwT_KfWjNrMA_1qvMD=Gkk9gfZNXLL79xdQ@mail.gmail.com>
 <Z4akewi7UPXpagce@x1>
In-Reply-To: <Z4akewi7UPXpagce@x1>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 19 Jan 2025 11:22:47 +0100
X-Gm-Features: AbW1kvZgUY5A3I5dSbWcTW5dh7qYm3oOmorFzidFGDh-8_i8QsL8E9SIloi9yJw
Message-ID: <CACT4Y+aqVq4+EOtztp2tdr-6Ppfnymg2qUjKP+VJdk4V7d+wfA@mail.gmail.com>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, irogers@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eranian@google.com, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jan 2025 at 18:53, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>
> On Tue, Jan 14, 2025 at 05:07:14PM +0100, Dmitry Vyukov wrote:
> > On Tue, 14 Jan 2025 at 16:57, Arnaldo Carvalho de Melo <acme@kernel.org=
> wrote:
> > > On Tue, Jan 14, 2025 at 09:26:57AM +0100, Dmitry Vyukov wrote:
> > > > On Tue, 14 Jan 2025 at 02:51, Namhyung Kim <namhyung@kernel.org> wr=
ote:
> > > > > I understand your point but I think it has some limitation so may=
be it's
> > > > > better to put in a separate mode with special flags.
>
> > > > I hate all options.
>
> > > > The 3rd option is to add a _mandary_ flag to perf record to ask for
> > > > profiling mode. Then the old "perf record" will say "nope, you need=
 to
> > > > choose, here are your options and explanation of the options".
>
> > > Well, we have a line for tips about perf usage at the botton, for
> > > instance, when I ran 'perf report' to check it it showed:
>
> > > Tip: Add -I to perf record to sample register values, which will be v=
isible in perf report sample context.
>
> > > We could add a line with:
>
> > > Tip: Use '-s wallclock' to get wallclock/latency profiling
>
> > Thanks for the review!
>
> > This is an option too.
> > I am not very strong about the exact option we choose, I understand
> > what I proposed has downsides too.
> > I am ready to go with a solution we will agree on here.
>
> > > And when using it we could have another tip:
> > >
> > > Tip: Use 'perf config report.mode=3Dwallclock' to change the default
> > >
> > > =E2=AC=A2 [acme@toolbox pahole]$ perf config report.mode=3Dwallclock
> > > =E2=AC=A2 [acme@toolbox pahole]$ perf config report.mode
> > > report.mode=3Dwallclock
> > > =E2=AC=A2 [acme@toolbox pahole]$
> > >
> > > Or something along these lines.
>
> > > Or we could have a popup that would appear with a "Important notice",
> > > explaining the wallclock mode and asking the user to opt-in to having
> > > both, just one or keep the old mode, that would be a quick, temporary
> > > "annoyance" for people used with the current mode while bringing this
> > > cool new mode to the attention of users.
>
> > Is there an example of doing something similar in the code?
>
> Sure, for the config part look at "report.children", that is processed
> in tools/perf/builtin-report.c report__config() function:
>
>         if (!strcmp(var, "report.children")) {
>                 symbol_conf.cumulate_callchain =3D perf_config_bool(var, =
value);
>                 return 0;
>         }
>
> To test, capture with callchains:
>
> root@number:~# perf record -g -a -e cpu_core/cycles/P sleep 5
> [ perf record: Woken up 97 times to write data ]
> [ perf record: Captured and wrote 28.084 MB perf.data (194988 samples) ]
> root@number:~#
> root@number:~# perf evlist
> cpu_core/cycles/P
> dummy:u
> root@number:~#
>
> The default ends up being:
>
> root@number:~# perf report
> Samples: 194K of event 'cpu_core/cycles/P', Event count (approx.): 242759=
929168
>   Children      Self  Command   Shared Object       Symbol
> +    9.25%     0.00%  cc1       [unknown]           [.] 0000000000000000
> +    7.23%     0.05%  cc1       [kernel.kallsyms]   [k] entry_SYSCALL_64
> +    7.09%     0.02%  cc1       [kernel.kallsyms]   [k] do_syscall_64
> +    4.43%     0.02%  cc1       [kernel.kallsyms]   [k] asm_exc_page_faul=
t
> +    3.89%     0.06%  cc1       libc.so.6           [.] __GI___getcwd
>
> The other mode:
>
> root@number:~# perf report --no-children
> Samples: 194K of event 'cpu_core/cycles/P', Event count (approx.): 242759=
929168
>   Overhead  Command   Shared Object   Symbol
> +    2.43%  cc1       cc1             [.] ht_lookup_with_hash(ht*, unsign=
ed char const*, unsigned long, unsigned int, ht_lookup_option)
> +    1.62%  cc1       cc1             [.] _cpp_lex_direct
> +    1.34%  cc1       cc1             [.] iterative_hash
> +    1.09%  cc1       cc1             [.] bitmap_set_bit(bitmap_head*, in=
t)
> +    0.98%  cc1       libc.so.6       [.] sysmalloc
> +    0.97%  cc1       libc.so.6       [.] _int_malloc
>
> So people not liking the default do:
>
> root@number:~# perf config report.children=3Dno
> root@number:~# perf config report.children
> report.children=3Dno
> root@number:~#
>
> To avoid having to use --no-children.
>
> See tools/perf/Documentation/perf-config.txt for more of these config
> options.

Oh, interesting. Didn't know about this.
Yes, we probably can use this for wallclock profiling.

> We don't have the popup that sets the ~/.perfconfig variable, but I
> think it is easily possible using ui_browser__dialog_yesno()... ok, look
> at the patch below, with it:
>
> root@x1:~# rm -f ~/.perfconfig
> root@x1:~# perf config annotate.disassemblers=3Dobjdump,llvm
> root@x1:~# cat ~/.perfconfig
> # this file is auto-generated.
> [annotate]
>         disassemblers =3D objdump,llvm
> root@x1:~# perf report
> root@x1:~# cat ~/.perfconfig
> # this file is auto-generated.
> [annotate]
>         disassemblers =3D objdump,llvm
> [report]
>         wallclock =3D yes
> root@x1:~#
>
> So with it when the user doesn't have that "report.wallclock=3Dyes" (or
> "no") set, i.e. everybody, the question will be made, once answered it
> will not be made again.
>
> > > Another idea, more general, is to be able to press some hotkey that
> > > would toggle available sort keys, like we have, for instance, 'k' to
> > > toggle the 'Shared object' column in the default 'perf report/top'
> > > TUI while filtering out non-kernel samples.
> > >
> > > But my initial feeling is that you're right and we want this wallcloc=
k
> > > column on by default, its just a matter of finding a convenient/easy =
way
> > > for users to opt-in.
> > >
> > > Being able to quickly toggle ordering by the Overhead/Wallclock colum=
ns
> > > also looks useful.
> >
> > I've tried to do something similar, e.g. filtering by parallelism
> > level on-the-fly, thus this patch:
> > https://lore.kernel.org/linux-perf-users/CACT4Y+b8X7PnUwQtuU2QXSqumNDbN=
8pWDm8EX+wnvgNAKbW0xw@mail.gmail.com/T/#t
> > But it turned out the reload functionality is more broken than working.
> >
> > I agree it would be nice to have these usability improvements.
>
> Right, and I'm not talking about those as a requirement for your patch
> to get accepted.
>
> > But this is also a large change, so I would prefer to merge the basic
> > functionality, and then we can do some improvements on top. This is
> > also the first time I am touching perf code, there are too many new
> > things to learn for me.
>
> I'm happy you made the effort and will try to help you as much as I can.
>
> I agree that, with the patch below, that I'll try to split and merge
> before travelling, we'll have a good starting point.
>
> Here is the patch, I'll split the perf_config__set_variable into a
> separate patch and merge, so that you can continue from there. The
> "<LONGER EXPLANATION>" part should tell the user that 'perf config
> report.workload=3Dyes|no' can be done later, to switch the mode, if one
> doesn't want to continue with it as default.
>
> Thanks,
>
> - Arnaldo
>
> diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
> index 2e8363778935e8d5..45b5312fbe8370e8 100644
> --- a/tools/perf/builtin-config.c
> +++ b/tools/perf/builtin-config.c
> @@ -154,6 +154,44 @@ static int parse_config_arg(char *arg, char **var, c=
har **value)
>         return 0;
>  }
>
> +int perf_config__set_variable(const char *var, const char *value)
> +{
> +       char path[PATH_MAX];
> +       char *user_config =3D mkpath(path, sizeof(path), "%s/.perfconfig"=
, getenv("HOME"));
> +       const char *config_filename;
> +       struct perf_config_set *set;
> +       int ret =3D -1;
> +
> +       if (use_system_config)
> +               config_exclusive_filename =3D perf_etc_perfconfig();
> +       else if (use_user_config)
> +               config_exclusive_filename =3D user_config;
> +
> +       if (!config_exclusive_filename)
> +               config_filename =3D user_config;
> +       else
> +               config_filename =3D config_exclusive_filename;
> +
> +       set =3D perf_config_set__new();
> +       if (!set)
> +               goto out_err;
> +
> +       if (perf_config_set__collect(set, config_filename, var, value) < =
0) {
> +               pr_err("Failed to add '%s=3D%s'\n", var, value);
> +               goto out_err;
> +       }
> +
> +       if (set_config(set, config_filename) < 0) {
> +               pr_err("Failed to set the configs on %s\n", config_filena=
me);
> +               goto out_err;
> +       }
> +
> +       ret =3D 0;
> +out_err:
> +       perf_config_set__delete(set);
> +       return ret;
> +}
> +
>  int cmd_config(int argc, const char **argv)
>  {
>         int i, ret =3D -1;
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index f5fbd670d619a32a..ccd6eef8ece6e238 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -50,6 +50,7 @@
>  #include "util/units.h"
>  #include "util/util.h" // perf_tip()
>  #include "ui/ui.h"
> +#include "ui/util.h"
>  #include "ui/progress.h"
>  #include "util/block-info.h"
>
> @@ -99,6 +100,8 @@ struct report {
>         bool                    disable_order;
>         bool                    skip_empty;
>         bool                    data_type;
> +       bool                    wallclock_config_set;
> +       bool                    use_wallclock;
>         int                     max_stack;
>         struct perf_read_values show_threads_values;
>         const char              *pretty_printing_style;
> @@ -151,6 +154,11 @@ static int report__config(const char *var, const cha=
r *value, void *cb)
>                 }
>                 return 0;
>         }
> +       if (!strcmp(var, "report.wallclock")) {
> +               rep->use_wallclock =3D perf_config_bool(var, value);
> +               rep->wallclock_config_set =3D true;
> +               return 0;
> +       }
>
>         if (!strcmp(var, "report.skip-empty")) {
>                 rep->skip_empty =3D perf_config_bool(var, value);
> @@ -1089,6 +1097,15 @@ static int __cmd_report(struct report *rep)
>
>         report__warn_kptr_restrict(rep);
>
> +       if (!rep->wallclock_config_set) {
> +               if (ui__dialog_yesno("Do you want to use wallclock/latenc=
y mode?\n"
> +                                    "<LONGER EXPLANATION>\n")) {
> +                       rep->use_wallclock =3D true;
> +                       // do other prep to add the "wallclock" key to th=
e sort order, etc
> +                       perf_config__set_variable("report.wallclock", "ye=
s");
> +               }
> +       }
> +
>         evlist__for_each_entry(session->evlist, pos)
>                 rep->nr_entries +=3D evsel__hists(pos)->nr_entries;
>
> diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
> index 9971313d61c1e5c6..a727c95cb1195e06 100644
> --- a/tools/perf/util/config.h
> +++ b/tools/perf/util/config.h
> @@ -50,6 +50,7 @@ int perf_config_set__collect(struct perf_config_set *se=
t, const char *file_name,
>                              const char *var, const char *value);
>  void perf_config__exit(void);
>  void perf_config__refresh(void);
> +int perf_config__set_variable(const char *var, const char *value);
>
>  /**
>   * perf_config_sections__for_each - iterate thru all the sections
