From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Support sample context in perf report
Date: Thu, 7 Mar 2019 08:57:45 -0800
Message-ID: <20190307165745.wtrhawl3mh2glyxu@two.firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190307105743.GA8979@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307105743.GA8979@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thu, Mar 07, 2019 at 11:57:43AM +0100, Jiri Olsa wrote:
> On Tue, Mar 05, 2019 at 06:47:43AM -0800, Andi Kleen wrote:
> > [Changes: 
> > v4:
> > Address review comments. 
> > Fix --cpu filtering.
> > Fix a sampling bug.
> > Add support for configuring custom script menu entries in perfconfig.
> > Fix display of more samples than fit on screen.
> > Fix some buffer overruns in legacy code.
> > Add more tips
> 
> hi,
> getting gcc error on your branch, similar like last time:

Okay I figured out now why I'm not seeing this. It's because my perf
builds are with DEBUG=1, and Makefile.config has this insanity:

ifeq ($(DEBUG),0)
  ifeq ($(feature-fortify-source), 1)
      CFLAGS += -D_FORTIFY_SOURCE=2
  endif
endif

Anyways the warnings are false positives because the strings can never
be that big. In fact I think they're harmful because it discourages
adding safety margins to stack buffers.

Anyways you can use this patch as a workaround.

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 364f5c577d00..3e795bd1279d 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2554,7 +2554,7 @@ do_run_script(struct hist_browser *browser __maybe_unused,
 	}
 
 	if (act->time) {
-		char start[64], end[64];
+		char start[32], end[32];
 		unsigned long starttime = act->time;
 		unsigned long endtime = act->time + symbol_conf.time_quantum;
 
