Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0C5FDDB;
	Tue,  7 May 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115886; cv=none; b=Nz/N8KbiQZQNxSBP4ex7tuG+6hTOmvsvcr37f1WOZevKUe+O3u8OW72dYujQApsz11gB8pob0T1xjgxkZk7QxNaSu+PmMI0j2tUlhwdGWPcGm0lIYh7I7xObW2UIDDV2oiHW+rAQr+YsKIOR9uftBo2hjeSlUaBraSNheZXTkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115886; c=relaxed/simple;
	bh=tEhMYN8iSO5xd390JBFyRRwfWCDHKQ76/l1oEa+Gk6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAP6Jy7v246MkqDJv8spyNLhvE4sYe+L0u9yovOIfRskuAMB1Z/CfqC7nMqHNOqj+vMJtQdbR+HreYWyBi4+ExMIBZUCoLK1dPp7VoIFRbZA90g7hL1PzlRcV1oMkQaVb26rRsy+NhQjX4K2umPB29eWU8Cqwp0fDi+w35KCFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrijNEh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrijNEh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB757C4AF67;
	Tue,  7 May 2024 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715115886;
	bh=tEhMYN8iSO5xd390JBFyRRwfWCDHKQ76/l1oEa+Gk6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrijNEh1yk9Zow4I+g9VIJ0jb/0CAQFNofXu0tYGC3GhTa5gZRFKBczJyEFuE9tnT
	 AAifD5DC9unsBjT6f7hu9asyOEbMKp8VN9ToS2WdmhjIixSCKfoLaWSnzsCswIis13
	 Pez9JzwMlY2mO5MFNXannJJj2RhdjTYGNQukaLI77FS7wZTElPepvwGgHJqRc4fx3E
	 w4iJ0tmgIz57+Cxv2H5vj8aqUuHF8ytHFHpyuMocdocTYrrBGWBK/n/leuGkjCDdoi
	 IB5U0iKBlhjLyfXuYXjWDxf3WXMcjwKzWtK1KUQ22H77YD2vYI/eeZ0X/K8vdRtKST
	 4QrRLQSmfUTOQ==
Date: Tue, 7 May 2024 18:04:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Clark <james.clark@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>,
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack
 memory
Message-ID: <ZjqXa25BnFncJmw-@x1>
References: <20240507183545.1236093-1-irogers@google.com>
 <20240507183545.1236093-2-irogers@google.com>
 <ZjqNKPgWR7mBFaV4@x1>
 <ZjqNjrJ2ElrT11iB@x1>
 <CAP-5=fUsQwKsCi3us+dp-Tj+PayNPrYTqTQeo-YLbvSuOt1=9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUsQwKsCi3us+dp-Tj+PayNPrYTqTQeo-YLbvSuOt1=9w@mail.gmail.com>

On Tue, May 07, 2024 at 01:48:28PM -0700, Ian Rogers wrote:
> On Tue, May 7, 2024 at 1:22 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Tue, May 07, 2024 at 05:20:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, May 07, 2024 at 11:35:38AM -0700, Ian Rogers wrote:
> > > > ui_browser__show is capturing the input title that is stack allocated
> > > > memory in hist_browser__run. Avoid a use after return by strdup-ing
> > > > the string.
> > >
> > > But everything happens in that context, i.e. hist_brower__run() will
> > > call ui_browser__ methods and then exit.
> > >
> > > We end up having browser->title pointing to returned stack memory
> > > (invalid) but there will be no references to it, no?
> > >
> > > If we return to hist_browser__run() we then call ui_browser__show
> > > passing a new title, for "live" stack memory, rinse repeat. Or have you
> > > noticed an actual use-after-"free"?
> >
> > And I'll take the patch, I'm just trying to figure it out if it fixed a
> > real bug or if it just makes the code more future proof, i.e. to avoid
> > us adding code that actually uses invalid stack memory.
> 
> My command line using tui is:
> $ sudo bash -c 'rm /tmp/asan.log*; export
> ASAN_OPTIONS="log_path=/tmp/asan.log"; /tmp/perf/perf mem record -a
> sleep 1; /tmp/perf/perf mem report'
> I then go to the perf annotate view and quit. This triggers the asan
> error (from the log file):
> ```

Thanks, it is indeed a bug, I'll keep that Fixes tag, people interested
in the full details can hopefully find this message going from the Link:
tag.

- Arnaldo

> ==1254591==ERROR: AddressSanitizer: stack-use-after-return on address
> 0x7f2813331920 at pc 0x7f28180
> 65991 bp 0x7fff0a21c750 sp 0x7fff0a21bf10
> READ of size 80 at 0x7f2813331920 thread T0
>     #0 0x7f2818065990 in __interceptor_strlen
> ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:461
>     #1 0x7f2817698251 in SLsmg_write_wrapped_string
> (/lib/x86_64-linux-gnu/libslang.so.2+0x98251)
>     #2 0x7f28176984b9 in SLsmg_write_nstring
> (/lib/x86_64-linux-gnu/libslang.so.2+0x984b9)
>     #3 0x55c94045b365 in ui_browser__write_nstring ui/browser.c:60
>     #4 0x55c94045c558 in __ui_browser__show_title ui/browser.c:266
>     #5 0x55c94045c776 in ui_browser__show ui/browser.c:288
>     #6 0x55c94045c06d in ui_browser__handle_resize ui/browser.c:206
>     #7 0x55c94047979b in do_annotate ui/browsers/hists.c:2458
>     #8 0x55c94047fb17 in evsel__hists_browse ui/browsers/hists.c:3412
>     #9 0x55c940480a0c in perf_evsel_menu__run ui/browsers/hists.c:3527
>     #10 0x55c940481108 in __evlist__tui_browse_hists ui/browsers/hists.c:3613
>     #11 0x55c9404813f7 in evlist__tui_browse_hists ui/browsers/hists.c:3661
>     #12 0x55c93ffa253f in report__browse_hists tools/perf/builtin-report.c:671
>     #13 0x55c93ffa58ca in __cmd_report tools/perf/builtin-report.c:1141
>     #14 0x55c93ffaf159 in cmd_report tools/perf/builtin-report.c:1805
>     #15 0x55c94000c05c in report_events tools/perf/builtin-mem.c:374
>     #16 0x55c94000d96d in cmd_mem tools/perf/builtin-mem.c:516
>     #17 0x55c9400e44ee in run_builtin tools/perf/perf.c:350
>     #18 0x55c9400e4a5a in handle_internal_command tools/perf/perf.c:403
>     #19 0x55c9400e4e22 in run_argv tools/perf/perf.c:447
>     #20 0x55c9400e53ad in main tools/perf/perf.c:561
>     #21 0x7f28170456c9 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>     #22 0x7f2817045784 in __libc_start_main_impl ../csu/libc-start.c:360
>     #23 0x55c93ff544c0 in _start (/tmp/perf/perf+0x19a4c0) (BuildId:
> 84899b0e8c7d3a3eaa67b2eb35e3d8b2f8cd4c93)
> 
> Address 0x7f2813331920 is located in stack of thread T0 at offset 32 in frame
>     #0 0x55c94046e85e in hist_browser__run ui/browsers/hists.c:746
> 
>   This frame has 1 object(s):
>     [32, 192) 'title' (line 747) <== Memory access at offset 32 is
> inside this variable
> HINT: this may be a false positive if your program uses some custom
> stack unwind mechanism, swapcontext or vfork
> ```
> hist_browser__run isn't on the stack so the asan error looks legit.
> There's no clean init/exit on struct ui_browser so I may be trading a
> use-after-return for a memory leak, but that seems look a good trade
> anyway.
> 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > - Arnaldo
> > >
> > > > Fixes: 05e8b0804ec4 ("perf ui browser: Stop using 'self'")
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/ui/browser.c | 4 +++-
> > > >  tools/perf/ui/browser.h | 2 +-
> > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> > > > index 603d11283cbd..c4cdf2ea69b7 100644
> > > > --- a/tools/perf/ui/browser.c
> > > > +++ b/tools/perf/ui/browser.c
> > > > @@ -287,7 +287,8 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
> > > >     mutex_lock(&ui__lock);
> > > >     __ui_browser__show_title(browser, title);
> > > >
> > > > -   browser->title = title;
> > > > +   free(browser->title);
> > > > +   browser->title = strdup(title);
> > > >     zfree(&browser->helpline);
> > > >
> > > >     va_start(ap, helpline);
> > > > @@ -304,6 +305,7 @@ void ui_browser__hide(struct ui_browser *browser)
> > > >     mutex_lock(&ui__lock);
> > > >     ui_helpline__pop();
> > > >     zfree(&browser->helpline);
> > > > +   zfree(&browser->title);
> > > >     mutex_unlock(&ui__lock);
> > > >  }
> > > >
> > > > diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
> > > > index 510ce4554050..6e98d5f8f71c 100644
> > > > --- a/tools/perf/ui/browser.h
> > > > +++ b/tools/perf/ui/browser.h
> > > > @@ -21,7 +21,7 @@ struct ui_browser {
> > > >     u8            extra_title_lines;
> > > >     int           current_color;
> > > >     void          *priv;
> > > > -   const char    *title;
> > > > +   char          *title;
> > > >     char          *helpline;
> > > >     const char    *no_samples_msg;
> > > >     void          (*refresh_dimensions)(struct ui_browser *browser);
> > > > --
> > > > 2.45.0.rc1.225.g2a3ae87e7f-goog
