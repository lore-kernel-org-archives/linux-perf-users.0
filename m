Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434528C2DE;
	Wed,  7 May 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632849; cv=none; b=puXLaPgSwenB3TfbjeqgVkz8YrfYwkg5X1Fb6VMRnDT57kX5k4U5oIjuCH5jm6KYCuCTfz9eD84HDw9fgaU0IwxSWgOy+iA9SdYZeX+6AFo70/UUirq4cDQrm5U2aVg/gtc6s6s2ieDtWFtJbY94q8u5nwYzngYDvAZDDpzJ6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632849; c=relaxed/simple;
	bh=WXI0SNppGx3CN4e/YPICg3MD2GaSica0+CejvhbhP2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaIwj4k/mpNpn/9SHsRYGxXky695bslCfhRuwUbWS0VR+hiA9hI4O6df7iksFqroF9vw1/NUMXXaJd84nrHZaHU8Z+xh/D/zunXXd1W/SRqjTRML8cr1JqP3r6pxX3BeScT87F86jWWJLOYtNZPQYWoc2QUc4KJ6czTu69bI0CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPufcLux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPufcLux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACFCC4CEEE;
	Wed,  7 May 2025 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632849;
	bh=WXI0SNppGx3CN4e/YPICg3MD2GaSica0+CejvhbhP2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPufcLuxU3+y1KrclByxH5uRimPfKnvmCtCerOUp//wSrfgIbRRX9jyST0BaPFjfa
	 7+5JXzvJkxZ4NpPGN5gZ4n2mEv7l9GE4edcei366kxKtgx7541zcWPc0fJv2SJQAxm
	 p09QOqEx/nC8ypCsaRHpD7JOeTD5mV21YnK21A9Cb1I2nYSEuJoPh6ieR9PAt0U85t
	 J1tw/uvDzgOO1TQqMHmEb6N7v8Unip5nLetXcpOgOnWF7tmQKdWGJlbGPzsp9A8JlM
	 NFX89P89ibVD61ZWzJT4mhbavu+k2RufZbQyPkHO4L1hB5p0qa9nYlNbwaRDYvNwrJ
	 gsif6mc5mUgsw==
Date: Wed, 7 May 2025 12:47:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aBuAjt5PyBsN65R9@x1>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <aBcjwoINtWRWKMIJ@gmail.com>
 <aBfFlT0l05yBbZBj@google.com>
 <CACT4Y+YvWYFBkZ9jQ2kuTOHb6pZQwWXc9sOJ5Km0Wr1fLi-94A@mail.gmail.com>
 <aBojTzsa5mSAGziP@x1>
 <aBo_z8Q87gflYyuX@x1>
 <CACT4Y+YG61CUPG1WRSGWgv00eP9aPYLELvDVmjK9ULJwNiiMgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+YG61CUPG1WRSGWgv00eP9aPYLELvDVmjK9ULJwNiiMgw@mail.gmail.com>

On Wed, May 07, 2025 at 11:58:10AM +0200, Dmitry Vyukov wrote:
> On Tue, 6 May 2025 at 18:58, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > So maybe when we notice that cycles was used 'perf report/top' should
> > > use the term 'wall-clock' for the column name?

> > > So instead of having a --latency we could have a hint that would tell
> > > the user that if this knob was set:

> > >   $ perf config report.wall-clock=true
 
> I am not sure it can be as simple as a single global knob.

> First, record needs to collect additional info and that may be
> somewhat expensive.
 
> Second, report now has several modes:
>  - it can show latency, but order by the current overhead
>  - it can also show latency, and order by latency
> A user wants one or another depending on what they are optimizing
> (possibly looking at both).
 
> I also feel that global config switches are even less discoverable by
> median users (read -- ~nobody will know about that). If these things
> are normal flags with a help description, then some users may
> eventually discover them.

So, the addition of:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9cbc854d8b148e3491291fb615e94261970fb54

  perf config: Add a function to set one variable in .perfconfig

  To allow for setting a variable from some other tool, like with the
  "wallclock" patchset needs to allow the user to opt-in to having
  that key in the sort order for 'perf report'.

  Cc: Dmitriy Vyukov <dvyukov@google.com>


Was to tell the user about the new possibilities of profiling, once,
with something like:

root@number:~# perf report
             ┌─────────────────────────────────────────────────────┐
             │Do you want to use latency mode?                     │
             │That will add a 'Latency' column that would mean     │
             │'wall-clock' time when used with cycles, for instance│
             │                                                     │
             │                                                     │
             │Enter: Yes, ESC: No                                  │
             └─────────────────────────────────────────────────────┘
 
The working should inform if the current perf.data has what is needed
and thus this would take immediate effect, and if not, inform that as
well and what is needed to be able to use that, things like you
described above:

> First, record needs to collect additional info and that may be
> somewhat expensive.

If the user says that the feature is desired by pressing Enter, follow
up questions can be asked as well, like you described:

> Second, report now has several modes:

>  - it can show latency, but order by the current overhead
>  - it can also show latency, and order by latency

> A user wants one or another depending on what they are optimizing
> (possibly looking at both).

Once these are answered, the questions goes away, as they are now
recorded in the user's ~/.perfconfig file and will be used when what is
needed is present in perf.data file.

The user should also be informed that to change that knob, 'perf config'
is your friend.

Additionally some hotkey could be made available to change that
behaviour, on the fly, with the option of turning the new mode the new
default, again writing to ~/.perfconfig.

Sometimes this "on the fly" needs reprocessing of the whole perf.data
file, sometimes it may be a matter of just showing extra available
fields, like the 'V' key now, that goes on bumping the verbosity in the
'perf report' and 'perf top' browsers (they share the hists browser), or
'j' that toogles showing the lines from jump sources to jump targets in
the annotate browser, 'J' to show how many jumps target a particular
jump target, also in the annotate browser, etc.

This could help experimenting with the various modes of doing profiling,
interactively, to see the problem from different angles, without having
to restart the whole process by exiting the 'perf report' to add new
command line options, then restart, etc, reusing computation sometimes
when switching views, etc.

To get default behaviour its just a matter of renaming ~/.perfconfig to
~/.perfconfig.some_suitabe_name_for_later_use.

This way interesting new features like this don't get buried behind
either command line options nor man pages, giving the user at least an
opportunity to be informed about it.

That is what the patch below barely starts sketching, not doing all I
just described.

- Arnaldo

> > > Then if 'cycles' is present we would have:

> > Something along the lines of the patch below, but there are several
> > details to take into account with what is in the current codebase, only
> > if what is needed for doing the latency/wall-clock time is present in
> > the perf.data being used is present that knob would be used or suggested
> > to the user, so some refactorings are needed, I'll try to folow on it.

> > But just for reference:

> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index f0299c7ee0254a37..20874800d967ffb5 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -51,6 +51,7 @@
> >  #include "util/util.h" // perf_tip()
> >  #include "ui/ui.h"
> >  #include "ui/progress.h"
> > +#include "ui/util.h"
> >  #include "util/block-info.h"
> >
> >  #include <dlfcn.h>
> > @@ -127,6 +128,11 @@ static int report__config(const char *var, const char *value, void *cb)
> >  {
> >         struct report *rep = cb;
> >
> > +       if (!strcmp(var, "report.prefer_latency")) {
> > +               symbol_conf.prefer_latency = perf_config_bool(var, value);
> > +               symbol_conf.prefer_latency_set = true;
> > +               return 0;
> > +       }
> >         if (!strcmp(var, "report.group")) {
> >                 symbol_conf.event_group = perf_config_bool(var, value);
> >                 return 0;
> > @@ -1734,6 +1740,15 @@ int cmd_report(int argc, const char **argv)
> >                 symbol_conf.annotate_data_sample = true;
> >         }
> >
> > +       if (!symbol_conf.prefer_latency) {
> > +               if (ui__dialog_yesno("Do you want to use latency mode?\n"
> > +                                    "That will add a 'Latency' column that would mean\n"
> > +                                    "'wall-clock' time when used with cycles, for instance\n")) {
> > +                       symbol_conf.prefer_latency = symbol_conf.prefer_latency_set = true;
> > +                       perf_config__set_variable("report.prefer_latency", "yes");
> > +               }
> > +       }
> > +
> >         symbol_conf.enable_latency = true;
> >         if (report.disable_order || !perf_session__has_switch_events(session)) {
> >                 if (symbol_conf.parallelism_list_str ||
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> > index cd9aa82c7d5ad941..f87071f5dedd94ca 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -51,6 +51,7 @@ struct symbol_conf {
> >                         annotate_data_sample,
> >                         skip_empty,
> >                         enable_latency,
> > +                       prefer_latency_set,
> >                         prefer_latency;
> >         const char      *vmlinux_name,
> >                         *kallsyms_name,
