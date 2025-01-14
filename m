Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5B1FAC5D;
	Tue, 14 Jan 2025 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877183; cv=none; b=i7MhAfZJU+NHob/pYg5v0DQEc2bkLtp94UldWBtZCno9TmDgVkqCag0XX5jFSqCVDa3H9uyUdC7Dm6Lx9BSgXCGpcYXk5s8GLR54K1cn2YUO2v+/Q962RZCzosAy7tMZZ0Ku5cxO0w00kNnCh95RyIhOwpr4d4tRfqT2nL2pRzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877183; c=relaxed/simple;
	bh=UmyDMCIBlDbXeJ4AwTy+f4YgJo3t/KvwozdKaaE/URc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk0diIdvUegFcfRH6ZcriEpsEPCn2tJlqIEVbwIYQESTbwVGBOOsvFZqMUH1VvYsR01cQ7mJcd/AfjUlhh6Eg1GvQE1zc3z4/YyZtuF3EfaeyphpTN0EXL2gGnMjq2nk5O2l+BiHIo0amwdGo1Kl0trKLjR1L04dThU+hcQkzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTKDh3gC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTKDh3gC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F31C4CEED;
	Tue, 14 Jan 2025 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877182;
	bh=UmyDMCIBlDbXeJ4AwTy+f4YgJo3t/KvwozdKaaE/URc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTKDh3gC0GpaRMDMm1qsbZ+hJJ7X0K1IiTNs3GAXj4CUue38X7j0An3TKVgLHEIi9
	 sslCsbM7vh5RlNkhLnN2GSYMK014OJQdxXbyDBIgu3EWyjtrOa95Ocovw074dv/RsM
	 jmVqpA3xMFb9JqLd1/ITk0YMIGYyugzJ/D6tE8+IoeRCihAbRIUtmboHjxspHDepOM
	 +kVVCGHLSq5gmoqijUNqVKIdyXSQmmx9gJdCW8YBwNQMW4Bty8j0CQn8aNJKAoboeV
	 D6IdW07+eBQBBxjbJV+r627rEjiRmF0KfzBZSXGR6BpSmesZ7WL8TbUNhh6DeJAdNk
	 xq8JfqnM3BNBQ==
Date: Tue, 14 Jan 2025 14:52:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
Message-ID: <Z4akewi7UPXpagce@x1>
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com>
 <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
 <Z4aJSde5KXO-rqWM@x1>
 <CACT4Y+b6nbqNHt1MwT_KfWjNrMA_1qvMD=Gkk9gfZNXLL79xdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+b6nbqNHt1MwT_KfWjNrMA_1qvMD=Gkk9gfZNXLL79xdQ@mail.gmail.com>

On Tue, Jan 14, 2025 at 05:07:14PM +0100, Dmitry Vyukov wrote:
> On Tue, 14 Jan 2025 at 16:57, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Tue, Jan 14, 2025 at 09:26:57AM +0100, Dmitry Vyukov wrote:
> > > On Tue, 14 Jan 2025 at 02:51, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > I understand your point but I think it has some limitation so maybe it's
> > > > better to put in a separate mode with special flags.

> > > I hate all options.

> > > The 3rd option is to add a _mandary_ flag to perf record to ask for
> > > profiling mode. Then the old "perf record" will say "nope, you need to
> > > choose, here are your options and explanation of the options".

> > Well, we have a line for tips about perf usage at the botton, for
> > instance, when I ran 'perf report' to check it it showed:

> > Tip: Add -I to perf record to sample register values, which will be visible in perf report sample context.

> > We could add a line with:

> > Tip: Use '-s wallclock' to get wallclock/latency profiling
 
> Thanks for the review!
 
> This is an option too.
> I am not very strong about the exact option we choose, I understand
> what I proposed has downsides too.
> I am ready to go with a solution we will agree on here.
 
> > And when using it we could have another tip:
> >
> > Tip: Use 'perf config report.mode=wallclock' to change the default
> >
> > ⬢ [acme@toolbox pahole]$ perf config report.mode=wallclock
> > ⬢ [acme@toolbox pahole]$ perf config report.mode
> > report.mode=wallclock
> > ⬢ [acme@toolbox pahole]$
> >
> > Or something along these lines.

> > Or we could have a popup that would appear with a "Important notice",
> > explaining the wallclock mode and asking the user to opt-in to having
> > both, just one or keep the old mode, that would be a quick, temporary
> > "annoyance" for people used with the current mode while bringing this
> > cool new mode to the attention of users.
 
> Is there an example of doing something similar in the code?

Sure, for the config part look at "report.children", that is processed
in tools/perf/builtin-report.c report__config() function:

        if (!strcmp(var, "report.children")) {
                symbol_conf.cumulate_callchain = perf_config_bool(var, value);
                return 0;
        }

To test, capture with callchains:

root@number:~# perf record -g -a -e cpu_core/cycles/P sleep 5
[ perf record: Woken up 97 times to write data ]
[ perf record: Captured and wrote 28.084 MB perf.data (194988 samples) ]
root@number:~#
root@number:~# perf evlist
cpu_core/cycles/P
dummy:u
root@number:~#

The default ends up being:

root@number:~# perf report
Samples: 194K of event 'cpu_core/cycles/P', Event count (approx.): 242759929168
  Children      Self  Command   Shared Object       Symbol
+    9.25%     0.00%  cc1       [unknown]           [.] 0000000000000000
+    7.23%     0.05%  cc1       [kernel.kallsyms]   [k] entry_SYSCALL_64
+    7.09%     0.02%  cc1       [kernel.kallsyms]   [k] do_syscall_64
+    4.43%     0.02%  cc1       [kernel.kallsyms]   [k] asm_exc_page_fault
+    3.89%     0.06%  cc1       libc.so.6           [.] __GI___getcwd

The other mode:

root@number:~# perf report --no-children
Samples: 194K of event 'cpu_core/cycles/P', Event count (approx.): 242759929168
  Overhead  Command   Shared Object   Symbol
+    2.43%  cc1       cc1             [.] ht_lookup_with_hash(ht*, unsigned char const*, unsigned long, unsigned int, ht_lookup_option)
+    1.62%  cc1       cc1             [.] _cpp_lex_direct
+    1.34%  cc1       cc1             [.] iterative_hash
+    1.09%  cc1       cc1             [.] bitmap_set_bit(bitmap_head*, int)
+    0.98%  cc1       libc.so.6       [.] sysmalloc
+    0.97%  cc1       libc.so.6       [.] _int_malloc

So people not liking the default do:

root@number:~# perf config report.children=no
root@number:~# perf config report.children
report.children=no
root@number:~# 

To avoid having to use --no-children.

See tools/perf/Documentation/perf-config.txt for more of these config
options.

We don't have the popup that sets the ~/.perfconfig variable, but I
think it is easily possible using ui_browser__dialog_yesno()... ok, look
at the patch below, with it:

root@x1:~# rm -f ~/.perfconfig 
root@x1:~# perf config annotate.disassemblers=objdump,llvm
root@x1:~# cat ~/.perfconfig 
# this file is auto-generated.
[annotate]
	disassemblers = objdump,llvm
root@x1:~# perf report
root@x1:~# cat ~/.perfconfig 
# this file is auto-generated.
[annotate]
	disassemblers = objdump,llvm
[report]
	wallclock = yes
root@x1:~# 

So with it when the user doesn't have that "report.wallclock=yes" (or
"no") set, i.e. everybody, the question will be made, once answered it
will not be made again.

> > Another idea, more general, is to be able to press some hotkey that
> > would toggle available sort keys, like we have, for instance, 'k' to
> > toggle the 'Shared object' column in the default 'perf report/top'
> > TUI while filtering out non-kernel samples.
> >
> > But my initial feeling is that you're right and we want this wallclock
> > column on by default, its just a matter of finding a convenient/easy way
> > for users to opt-in.
> >
> > Being able to quickly toggle ordering by the Overhead/Wallclock columns
> > also looks useful.
> 
> I've tried to do something similar, e.g. filtering by parallelism
> level on-the-fly, thus this patch:
> https://lore.kernel.org/linux-perf-users/CACT4Y+b8X7PnUwQtuU2QXSqumNDbN8pWDm8EX+wnvgNAKbW0xw@mail.gmail.com/T/#t
> But it turned out the reload functionality is more broken than working.
> 
> I agree it would be nice to have these usability improvements.

Right, and I'm not talking about those as a requirement for your patch
to get accepted.

> But this is also a large change, so I would prefer to merge the basic
> functionality, and then we can do some improvements on top. This is
> also the first time I am touching perf code, there are too many new
> things to learn for me.

I'm happy you made the effort and will try to help you as much as I can.

I agree that, with the patch below, that I'll try to split and merge
before travelling, we'll have a good starting point.

Here is the patch, I'll split the perf_config__set_variable into a
separate patch and merge, so that you can continue from there. The
"<LONGER EXPLANATION>" part should tell the user that 'perf config
report.workload=yes|no' can be done later, to switch the mode, if one
doesn't want to continue with it as default.

Thanks,

- Arnaldo

diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 2e8363778935e8d5..45b5312fbe8370e8 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -154,6 +154,44 @@ static int parse_config_arg(char *arg, char **var, char **value)
 	return 0;
 }
 
+int perf_config__set_variable(const char *var, const char *value)
+{
+	char path[PATH_MAX];
+	char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
+	const char *config_filename;
+	struct perf_config_set *set;
+	int ret = -1;
+
+	if (use_system_config)
+		config_exclusive_filename = perf_etc_perfconfig();
+	else if (use_user_config)
+		config_exclusive_filename = user_config;
+
+	if (!config_exclusive_filename)
+		config_filename = user_config;
+	else
+		config_filename = config_exclusive_filename;
+
+	set = perf_config_set__new();
+	if (!set)
+		goto out_err;
+
+	if (perf_config_set__collect(set, config_filename, var, value) < 0) {
+		pr_err("Failed to add '%s=%s'\n", var, value);
+		goto out_err;
+	}
+
+	if (set_config(set, config_filename) < 0) {
+		pr_err("Failed to set the configs on %s\n", config_filename);
+		goto out_err;
+	}
+
+	ret = 0;
+out_err:
+	perf_config_set__delete(set);
+	return ret;
+}
+
 int cmd_config(int argc, const char **argv)
 {
 	int i, ret = -1;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f5fbd670d619a32a..ccd6eef8ece6e238 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -50,6 +50,7 @@
 #include "util/units.h"
 #include "util/util.h" // perf_tip()
 #include "ui/ui.h"
+#include "ui/util.h"
 #include "ui/progress.h"
 #include "util/block-info.h"
 
@@ -99,6 +100,8 @@ struct report {
 	bool			disable_order;
 	bool			skip_empty;
 	bool			data_type;
+	bool			wallclock_config_set;
+	bool			use_wallclock;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
 	const char		*pretty_printing_style;
@@ -151,6 +154,11 @@ static int report__config(const char *var, const char *value, void *cb)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "report.wallclock")) {
+		rep->use_wallclock = perf_config_bool(var, value);
+		rep->wallclock_config_set = true;
+		return 0;
+	}
 
 	if (!strcmp(var, "report.skip-empty")) {
 		rep->skip_empty = perf_config_bool(var, value);
@@ -1089,6 +1097,15 @@ static int __cmd_report(struct report *rep)
 
 	report__warn_kptr_restrict(rep);
 
+	if (!rep->wallclock_config_set) {
+		if (ui__dialog_yesno("Do you want to use wallclock/latency mode?\n"
+				     "<LONGER EXPLANATION>\n")) {
+			rep->use_wallclock = true;
+			// do other prep to add the "wallclock" key to the sort order, etc
+			perf_config__set_variable("report.wallclock", "yes");
+		}
+	}
+
 	evlist__for_each_entry(session->evlist, pos)
 		rep->nr_entries += evsel__hists(pos)->nr_entries;
 
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index 9971313d61c1e5c6..a727c95cb1195e06 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -50,6 +50,7 @@ int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 			     const char *var, const char *value);
 void perf_config__exit(void);
 void perf_config__refresh(void);
+int perf_config__set_variable(const char *var, const char *value);
 
 /**
  * perf_config_sections__for_each - iterate thru all the sections
