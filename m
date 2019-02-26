From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Support sample context in perf report
Date: Tue, 26 Feb 2019 23:33:19 +0100
Message-ID: <20190226223319.GA2393@krava>
References: <20190226030412.23485-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190226030412.23485-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 25, 2019 at 07:04:01PM -0800, Andi Kleen wrote:
> [Changes: 
> Removed already merged patches.
> Address review feedback, see individual patches.
> Now compiles with gcc 8.
> Some minor bug fixes and improvements.]
> 
> We currently have two ways to look at sample data in perf:
> either use perf report to aggregate everything, or use
> perf script to look at all individual samples.
> 
> Both ways are useful. Of course aggregation is useful
> to quickly find the most expensive part of the code.
> 
> But sometimes a single sample is not good enough to
> determine the problem and we need to look at context, either
> through branch contexts, or other previous samples (e.g. for
> correlating different micro architecture events or computing
> metrics)
> 
> This can be done through perf script today, but it can
> be rather cumbersome to find the right samples to look
> at.
> 
> Another problem with perf report is that it aggregates
> the whole measurement period. But many real workloads
> have phases where they behave quite differently, and it is
> often not useful to combine them into a single histogram.
> 
> While this can be worked around with the --time option
> to report, it can be quite cumbersome.
> 
> This patch kit attempts to address some of these
> problems in perf report by making it time aware.
> 
> - It adds a new time sort key that allows perf report
> to separate samples from different regions. The time
> regions can be defined with a new --time-quantum option.
> 
> - Then it extends the perf script support in the
> tui record browser to allow browsing samples for 
> different time regions from within a perf report
> session.
> 
> - Extends the report browser script display
> to automatically select sensible defaults
> based on what was recorded. For example it will
> automatically show branch contexts with -b.
> 
> - Support browsing the context of individual samples.
> perf report can save a limited number of random samples
> per histogram entry with the new --samples option.
> Then the browser allows directly jumping to any
> of the saved samples and browsing the context on the current
> thread or CPU.
> 
> There could be probably be done more to make
> perf report even better for such use cases (e.g. a real
> time line display), but this basic support is good
> enough for many useful usages.
> 
> Also available in
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2

im still getting compile error the new branch:

  CC       ui/browsers/hists.o
ui/browsers/hists.c: In function ‘perf_evsel__hists_browse’:
ui/browsers/hists.c:2567:8: error: ‘%s’ directive output may be truncated writing up to 63 bytes into a region of size between 28 and 91 [-Werror=format-truncation=]
   n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862,
                 from ui/browsers/hists.c:5:
/usr/include/bits/stdio2.h:64:10: note: ‘__builtin___snprintf_chk’ output between 10 and 136 bytes into a destination of size 100
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
mv: cannot stat 'ui/browsers/.hists.o.tmp': No such file or directory


jirka
