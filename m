From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 07/11] perf tools report: Support running scripts for
 current time range
Date: Mon, 25 Feb 2019 13:55:55 +0100
Message-ID: <20190225125555.GF19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-8-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-8-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:18AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When using the time sort key, add new context menus to run
> scripts for only the currently selected time range. Compute
> the correct range for the selection add pass it as the --time option to
> perf script.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

getting compilation error:

  CC       ui/browsers/hists.o
ui/browsers/hists.c: In function ‘perf_evsel__hists_browse’:
ui/browsers/hists.c:2565:8: error: ‘%s’ directive output may be truncated writing up to 63 bytes into a region of size between 28 and 91 [-Werror=format-truncation=]
   n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862,
                 from ui/browsers/hists.c:5:
/usr/include/bits/stdio2.h:64:10: note: ‘__builtin___snprintf_chk’ output between 10 and 136 bytes into a destination of size 100
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[jolsa@krava perf]$ gcc --version
gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)

jirka
