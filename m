From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Support sample context in perf report
Date: Tue, 26 Feb 2019 14:55:20 -0800
Message-ID: <87pnrerwh3.fsf@linux.intel.com>
References: <20190226030412.23485-1-andi@firstfloor.org>
        <20190226223319.GA2393@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226223319.GA2393@krava> (Jiri Olsa's message of "Tue, 26
        Feb 2019 23:33:19 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:
>
> im still getting compile error the new branch:
>
>   CC       ui/browsers/hists.o
> ui/browsers/hists.c: In function ‘perf_evsel__hists_browse’:
> ui/browsers/hists.c:2567:8: error: ‘%s’ directive output may be truncated writing up to 63 bytes into a region of size between 28 and 91 [-Werror=format-truncation=]
>    n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/stdio.h:862,
>                  from ui/browsers/hists.c:5:
> /usr/include/bits/stdio2.h:64:10: note: ‘__builtin___snprintf_chk’ output between 10 and 136 bytes into a destination of size 100
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __bos (__s), __fmt, __va_arg_pack ());
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> mv: cannot stat 'ui/browsers/.hists.o.tmp': No such file or directory

I tested with gcc 8 and it built on a opensuse leap system.

Of course you never know where you end up with the gcc -Werror
russian roulette. I don't think any of those can really overflow,
it's all false positives. This one is particularly annoying
because the compiler seems to assume that every char[] variable
is filled up to the maximum, which is flat out wrong.

Anyways this patch should help.

-Andi

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index e35b274ee863..8ca988506388 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2554,7 +2554,7 @@ do_run_script(struct hist_browser *browser __maybe_unused,
 	}
 
 	if (act->time) {
-		char start[64], end[64];
+		char start[22], end[22];
 		unsigned long starttime = act->time;
 		unsigned long endtime = act->time + symbol_conf.time_quantum;
 
