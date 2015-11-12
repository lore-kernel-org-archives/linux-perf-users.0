From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: /tmp/perf-PID.map ownership
Date: Thu, 12 Nov 2015 12:01:46 -0800
Message-ID: <CAE40pddkF4ADzMGn-YezTU+ejkwAzF0FSd3wiyyije5bXRc1+Q@mail.gmail.com>
References: <CAE40pdctG6CUcmangzqSKmd7GkSv1oz7jP5hR-=GFSTTeQ-2sQ@mail.gmail.com>
 <20151112185205.GA7160@kernel.org> <CAE40pdcfdBV_xwJtuBvVe3Fjqxa69W7XT_LN6r9UH94wcfEQeQ@mail.gmail.com>
 <20151112190444.GB7160@kernel.org> <20151112194947.GC7160@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38499 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbbKLUCQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 15:02:16 -0500
Received: by igbxm8 with SMTP id xm8so1164088igb.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 12:02:16 -0800 (PST)
In-Reply-To: <20151112194947.GC7160@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Thu, Nov 12, 2015 at 11:49 AM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Thu, Nov 12, 2015 at 04:04:44PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Nov 12, 2015 at 10:59:36AM -0800, Brendan Gregg escreveu:
>> > On Thu, Nov 12, 2015 at 10:52 AM, Arnaldo Carvalho de Melo
>> > <arnaldo.melo@gmail.com> wrote:
>> > > Em Thu, Nov 12, 2015 at 10:27:26AM -0800, Brendan Gregg escreveu:
>> > >> G'Day,
>> > >>
>> > >> # perf record -F 99 -a -g -- sleep 30
>> > >> [...]
>> > >> # perf report -n --stdio
>> > >> File /tmp/perf-25958.map not owned by current user or root, ignoring it.
>> > >>
>> > >> Can root bypass this test? I'm root, and profiling apps from different
>> > >
>> > > In other places such tests are overridable via '-f' (force), this one
>> > > should too, I think.
>> > >
>> > > # perf report
>> > > File perf.data not owned by current user or root (use -f to override)
>> > > [root@zoo linux]# ls -la perf.data
>> > > -rw-------. 1 acme acme 20032 Nov 12 15:50 perf.data
>> >
>> > Yes, a -f option would work too...
>>
>> Cooking up a patch right now.
>
> This way it gets consistent with the other checks, please let me know if
> I can have your Tested-by, checking other places where this check is
> done to make it follow this rule too.

Tested, it works, thanks!

Brendan

>
> - Arnaldo
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2853ad2bd435..f256fac1e722 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -44,7 +44,7 @@
>  struct report {
>         struct perf_tool        tool;
>         struct perf_session     *session;
> -       bool                    force, use_tui, use_gtk, use_stdio;
> +       bool                    use_tui, use_gtk, use_stdio;
>         bool                    hide_unresolved;
>         bool                    dont_use_callchains;
>         bool                    show_full_info;
> @@ -678,7 +678,7 @@ int cmd_report(int argc, const char **argv, const char *prefix __maybe_unused)
>                    "file", "vmlinux pathname"),
>         OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>                    "file", "kallsyms pathname"),
> -       OPT_BOOLEAN('f', "force", &report.force, "don't complain, do it"),
> +       OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>         OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
>                     "load module symbols - WARNING: use only with -k and LIVE kernel"),
>         OPT_BOOLEAN('n', "show-nr-samples", &symbol_conf.show_nr_samples,
> @@ -832,7 +832,7 @@ int cmd_report(int argc, const char **argv, const char *prefix __maybe_unused)
>         }
>
>         file.path  = input_name;
> -       file.force = report.force;
> +       file.force = symbol_conf.force;
>
>  repeat:
>         session = perf_session__new(&file, false, &report.tool);
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 09343a880c0b..cd08027a6d2c 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1436,9 +1436,9 @@ int dso__load(struct dso *dso, struct map *map, symbol_filter_t filter)
>                 if (lstat(dso->name, &st) < 0)
>                         goto out;
>
> -               if (st.st_uid && (st.st_uid != geteuid())) {
> +               if (!symbol_conf.force && st.st_uid && (st.st_uid != geteuid())) {
>                         pr_warning("File %s not owned by current user or root, "
> -                               "ignoring it.\n", dso->name);
> +                                  "ignoring it (use -f to override).\n", dso->name);
>                         goto out;
>                 }
>
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 40073c60b83d..dcd786e364f2 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -84,6 +84,7 @@ struct symbol_conf {
>         unsigned short  priv_size;
>         unsigned short  nr_events;
>         bool            try_vmlinux_path,
> +                       force,
>                         ignore_vmlinux,
>                         ignore_vmlinux_buildid,
>                         show_kernel_path,
