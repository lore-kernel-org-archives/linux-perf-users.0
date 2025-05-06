Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0C284688;
	Tue,  6 May 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550739; cv=none; b=OFiEqrkZDBokLd/PjrROlHMJ4E6NMQv4jDT7cCca2yDJgjF18l1qLQTDzSqSKpInK+UtGVlns+lmmCP7q1zqIm+zoCv5Wa5IGJAZ7Gja7I7sD7RwNaSfAo4j1cO5lMf6djz7AJjgMU2AEBkosrcVoqJKmDzXB1ZL/4tmlSSNeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550739; c=relaxed/simple;
	bh=dKg9HkN/4e7J1Rp1/A/3ppR1wGgOJ6pXEfz4krha9AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdbMcSm+Aa5Cm6WU5AsBUBg2LA0gYn/yi7cZpxmKwvjczpeyYo0dY8ha25+fC6C7QOuOLb6JuQVts4GGoUQ3kqYa3fKSpDVO5ykoM6HOqRcIegjph1QS68WedImG45rzCDEHpjkoeZ/MEUuCUGfo2gqcsfxo3gmjt88v4MTuOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrIdO0LO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrIdO0LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181FCC4CEE4;
	Tue,  6 May 2025 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746550738;
	bh=dKg9HkN/4e7J1Rp1/A/3ppR1wGgOJ6pXEfz4krha9AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrIdO0LOAPCGc6l2KCTjtbYZ9e1A3kaQdVkcHhMb1ibUvKuS/ihXNFBDl799tEyKP
	 Mfhi5fKRv+5g2FGbeAFS6jvi/1SLWDAXCKHF7Ai1dxcA3tde3nHFUM9fGxUsJNuZHK
	 DtlDze3lXXo5lHxjoNf5ksSHwpEWmcuM3ywyI0HoaanVH2hEZ6FkZoJlrHFOU43b9X
	 gP1vbPEYMXWl56vys81mgbaMysS73XHn4csQMcQd962b0pPnvWpQWQbaxAuu0XDu+I
	 9XlqAk5BXlqw0rpMdx4jWTrjKxaTyKvbJrvViThv54S0ADWDAWbI+s0AxcDxyxABr5
	 sr2mJ/sHOXGvA==
Date: Tue, 6 May 2025 13:58:55 -0300
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
Message-ID: <aBo_z8Q87gflYyuX@x1>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <aBcjwoINtWRWKMIJ@gmail.com>
 <aBfFlT0l05yBbZBj@google.com>
 <CACT4Y+YvWYFBkZ9jQ2kuTOHb6pZQwWXc9sOJ5Km0Wr1fLi-94A@mail.gmail.com>
 <aBojTzsa5mSAGziP@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBojTzsa5mSAGziP@x1>

On Tue, May 06, 2025 at 11:57:19AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 05, 2025 at 10:03:05AM +0200, Dmitry Vyukov wrote:
> > On Sun, 4 May 2025 at 21:52, Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Sun, May 04, 2025 at 10:22:26AM +0200, Ingo Molnar wrote:
> > > > > Here's an example:
> 
> > > > >   # perf record -a -- perf bench sched messaging
> 
> > > > > This basically forks each sender and receiver tasks for the run.
> 
> > > > >   # perf report --latency -s comm --stdio
> > > > >   ...
> > > > >   #
> > > > >   #  Latency  Overhead  Command
> > > > >   # ........  ........  ...............
> > > > >   #
> > > > >       98.14%    95.97%  sched-messaging
> > > > >        0.78%     0.93%  gnome-shell
> > > > >        0.36%     0.34%  ptyxis
> > > > >        0.23%     0.23%  kworker/u112:0-
> > > > >        0.23%     0.44%  perf
> > > > >        0.08%     0.10%  KMS thread
> > > > >        0.05%     0.05%  rcu_preempt
> > > > >        0.05%     0.05%  kworker/u113:2-
> > > > >        ...
> 
> > > > Just a generic user-interface comment: I had to look up what 'latency'
> > > > means in this context, and went about 3 hops deep into various pieces
> > > > of description until I found Documentation/cpu-and-latency-overheads.txt,
> > > > where after a bit of head-scratching I realized that 'latency' is a
> > > > weird alias for 'wall-clock time'...
> 
> > > > This is *highly* confusing terminology IMHO.
> 
> > > Sorry for the confusion.  I know I'm terrible at naming things. :)
> 
> > > Actually Dmitry used the term 'wall-clock' profiling at first when he
> > > implemented this feature but I thought it was not clear how it meant
> > > for non-cycle events.  As 'overhead' is also a generic term, we ended
> > > up with 'latency'.
>  
> > Exactly :)
> 
> So, the 'cycles' event is the most commonly used, its the default if one
> does 'perf record' and don't ask for a specific event.
> 
> When we notice that 'cycles' and 'instructions' are counted, we provide
> an IPC, as that is a well known metric for that combo:
> 
>   root@number:~# perf stat -e cycles,instructions sleep 1
>   
>    Performance counter stats for 'sleep 1':
>   
>            1,149,493      cycles                                                                
>            1,197,279      instructions                     #    1.04  insn per cycle            
>   
>          1.000645408 seconds time elapsed
>   
>          0.000599000 seconds user
>          0.000000000 seconds sys
>   
>   
>   root@number:~#
> 
> So maybe when we notice that cycles was used 'perf report/top' should
> use the term 'wall-clock' for the column name?
> 
> So instead of having a --latency we could have a hint that would tell
> the user that if this knob was set:
> 
>   $ perf config report.wall-clock=true
> 
> Then if 'cycles' is present we would have:

Something along the lines of the patch below, but there are several
details to take into account with what is in the current codebase, only
if what is needed for doing the latency/wall-clock time is present in
the perf.data being used is present that knob would be used or suggested
to the user, so some refactorings are needed, I'll try to folow on it.

But just for reference:

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f0299c7ee0254a37..20874800d967ffb5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -51,6 +51,7 @@
 #include "util/util.h" // perf_tip()
 #include "ui/ui.h"
 #include "ui/progress.h"
+#include "ui/util.h"
 #include "util/block-info.h"
 
 #include <dlfcn.h>
@@ -127,6 +128,11 @@ static int report__config(const char *var, const char *value, void *cb)
 {
 	struct report *rep = cb;
 
+	if (!strcmp(var, "report.prefer_latency")) {
+		symbol_conf.prefer_latency = perf_config_bool(var, value);
+		symbol_conf.prefer_latency_set = true;
+		return 0;
+	}
 	if (!strcmp(var, "report.group")) {
 		symbol_conf.event_group = perf_config_bool(var, value);
 		return 0;
@@ -1734,6 +1740,15 @@ int cmd_report(int argc, const char **argv)
 		symbol_conf.annotate_data_sample = true;
 	}
 
+	if (!symbol_conf.prefer_latency) {
+		if (ui__dialog_yesno("Do you want to use latency mode?\n"
+				     "That will add a 'Latency' column that would mean\n"
+				     "'wall-clock' time when used with cycles, for instance\n")) {
+                       symbol_conf.prefer_latency = symbol_conf.prefer_latency_set = true;
+                       perf_config__set_variable("report.prefer_latency", "yes");
+               }
+       }
+
 	symbol_conf.enable_latency = true;
 	if (report.disable_order || !perf_session__has_switch_events(session)) {
 		if (symbol_conf.parallelism_list_str ||
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index cd9aa82c7d5ad941..f87071f5dedd94ca 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -51,6 +51,7 @@ struct symbol_conf {
 			annotate_data_sample,
 			skip_empty,
 			enable_latency,
+			prefer_latency_set,
 			prefer_latency;
 	const char	*vmlinux_name,
 			*kallsyms_name,
