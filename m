From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Support sample context in perf report
Date: Thu, 7 Mar 2019 11:57:43 +0100
Message-ID: <20190307105743.GA8979@krava>
References: <20190305144758.12397-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190305144758.12397-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 05, 2019 at 06:47:43AM -0800, Andi Kleen wrote:
> [Changes: 
> v4:
> Address review comments. 
> Fix --cpu filtering.
> Fix a sampling bug.
> Add support for configuring custom script menu entries in perfconfig.
> Fix display of more samples than fit on screen.
> Fix some buffer overruns in legacy code.
> Add more tips

hi,
getting gcc error on your branch, similar like last time:

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

jirka
