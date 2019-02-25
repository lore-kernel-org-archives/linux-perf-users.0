From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 09/11] perf tools report: Support builtin perf script in
 scripts menu
Date: Mon, 25 Feb 2019 13:57:32 +0100
Message-ID: <20190225125732.GA29870@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-10-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-10-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:20AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The scripts menu traditionally only showed custom perf scripts.
> 
> Allow to run standard perf script with useful default options too.
> 
> - Normal perf script
> - perf script with assembler (needs xed installed)
> - perf script with source code output (needs debuginfo)
> - perf script with custom arguments
> 
> Then we automatically select the right options to
> display the information in the perf.data file.
> 
> For example with -b display branch contexts.
> 
> It's not easily possible to check for xed's existence
> in advance.  perf script usually gives sensible error messages when
> it's not available.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>


cannot compile this one:

ui/browsers/scripts.c: In function ‘script_browse’:
ui/browsers/scripts.c:118:35: error: ‘%s’ directive writing up to 1023 bytes into a region of size 248 [-Werror=format-overflow=]
   sprintf(script_name, "%s script %s", perf, script_args);
                                   ^~         ~~~~~~~~~~~
In file included from /usr/include/stdio.h:862,
                 from ui/browsers/../../util/color.h:5,
                 from ui/browsers/../../util/sort.h:8,
                 from ui/browsers/scripts.c:6:
/usr/include/bits/stdio2.h:33:10: note: ‘__builtin___sprintf_chk’ output 9 or more bytes (assuming 1032) into a destination of size 256
   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       __bos (__s), __fmt, __va_arg_pack ());

[jolsa@krava perf]$ gcc --version
gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)


jirka
