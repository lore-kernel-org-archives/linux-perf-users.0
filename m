Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A134750B;
	Wed, 17 Jun 2026 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735639; cv=none; b=Ctz6+61QTFinZzQSbJaw1Ny+VTmDjGyYuyYMTDenmpay6/nAVMWRd5nCYzNtOxxXdhce8pbxnSTKlkJgbxRPjx80EdBMzZRlce0v2cK1R18iiNSzA/8CacXiuZpn3T616SS77fqc3nBlnJfgP6a3pDDPRge281dYdUW1t/XAhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735639; c=relaxed/simple;
	bh=N9R67wAvyrnZDFPuodqKWwQaS9r5dRs7nwJsp4h3K/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahrnRcqLexFBSe4vLyS+RaRuXDYpp9aReM6N6F2fBmvKKLQQd9szkz7C1RNbhWESIot4aBcFrdsLblt68YTVzVs25MG7WY2/xfv5XamQ0eBKuromzQ0uCNgLvat95PMBwxVM3m9WZ4DZaH0kc0Arkh06k8bYQbLPgIn7AZLfhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEBwlFJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEBwlFJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298101F000E9;
	Wed, 17 Jun 2026 22:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781735638;
	bh=8dgmk/zNaeMLkNr17F6VGZ+ofuDthFLDde/aCANiDYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mEBwlFJ9j+aHzErCvzT1kS2rS2244qSZ1k3XVw9TZJ5a+IRy6twNf/IRt9tTYk7KI
	 RZ0FusSgywm/xQWQiZZtasYWNdZbiic4nCKlhV8MEU8RS66CfwKYoXFT1wnH24ZKWS
	 aHpYc1eHtl5NiVnMgh20bvoadnb9Gy66UIXLU4VhNNoEst1zv9BnitegnSElcgoxjy
	 8B1t3cYLxvX3s1vSPrpPnCpTXN3/gQFgIbS53CUWw7OA4q8L4vHv5TgrIzI1WaOBkA
	 rMhTI5TGwyqGBCEeMEBYfz+FcOx5gloxraSy7vfbJhj2CpiW768AasPtOlsoioXMDM
	 0/HHoyTgIpjEg==
Date: Wed, 17 Jun 2026 15:33:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, thomas.falcon@intel.com,
	tmricht@linux.ibm.com
Subject: Re: [PATCH v3 02/13] perf test: Truncate test description to fit
 terminal width
Message-ID: <ajMg1JQBlnMxhNfl@google.com>
References: <20260616061404.41929-1-irogers@google.com>
 <20260616164819.370939-1-irogers@google.com>
 <20260616164819.370939-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616164819.370939-3-irogers@google.com>

On Tue, Jun 16, 2026 at 09:48:07AM -0700, Ian Rogers wrote:
> The parallel test harness uses the carriage return delete escape sequence
> `PERF_COLOR_DELETE_LINE` ("\033[A\33[2K\r") to erase and update the
> "Running (X active)" progress lines.
> 
> However, if a test description is longer than the terminal width, the line
> wraps around. When this happens, the cursor up escape sequence `\033[A`
> only moves the cursor to the last wrapped row, leaving the top half of the
> description printed on the previous line. This leads to name duplication
> and output corruption spilling over multiple rows on consoles narrower
> than the maximum description length (e.g., 101 columns wide).
> 
> Fix this by dynamically querying the terminal width using
> `get_term_dimensions` and truncating the printed test descriptions using
> the `%-*.*s` printf format. We reserve 35 characters for prefix, status,
> and spacing metrics to guarantee the progress line never wraps.
> 
> Fixes: 0e036dcad4e6 ("perf test: Display number of active running tests")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 130 ++++++++++++++++++++++++--------
>  1 file changed, 98 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index afc06cec4954..1dcaeb8505b7 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -10,35 +10,39 @@
>  #ifdef HAVE_BACKTRACE_SUPPORT
>  #include <execinfo.h>
>  #endif
> -#include <poll.h>
> -#include <unistd.h>
>  #include <setjmp.h>
> -#include <string.h>
>  #include <stdlib.h>
> -#include <sys/types.h>
> +#include <string.h>
> +
>  #include <dirent.h>
> -#include <sys/wait.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/zalloc.h>
> +#include <poll.h>
> +#include <sys/ioctl.h>
>  #include <sys/stat.h>
>  #include <sys/time.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include <subcmd/exec-cmd.h>
> +#include <subcmd/parse-options.h>
> +#include <subcmd/run-command.h>
> +
>  #include "builtin.h"
> +#include "color.h"
>  #include "config.h"
> +#include "debug.h"
>  #include "hist.h"
>  #include "intlist.h"
> -#include "tests.h"
> -#include "debug.h"
> -#include "color.h"
> -#include <subcmd/parse-options.h>
> -#include <subcmd/run-command.h>
>  #include "string2.h"
>  #include "symbol.h"
> +#include "tests-scripts.h"
> +#include "tests.h"
>  #include "util/rlimit.h"
>  #include "util/strbuf.h"
> -#include <linux/kernel.h>
> -#include <linux/string.h>
> -#include <subcmd/exec-cmd.h>
> -#include <linux/zalloc.h>
> -
> -#include "tests-scripts.h"
> +#include "util/term.h"
>  
>  static const char *junit_filename;
>  static struct strbuf junit_xml_buf = STRBUF_INIT;
> @@ -413,23 +417,73 @@ static char *xml_escape(const char *str)
>  	return res ? res : strdup("");
>  }
>  
> +static int get_term_width(void)
> +{
> +	struct winsize ws;
> +	int cols = 80;
> +	int term_width;
> +
> +	/*
> +	 * If output is redirected to a file or piped, we don't need to wrap
> +	 * or truncate at all. Use a massive virtually infinite terminal width
> +	 * so descriptions are printed in full.
> +	 */
> +	if (!isatty(fileno(debug_file())))
> +		return 10000;
> +
> +	get_term_dimensions(&ws);
> +	if (ws.ws_col > 0)
> +		cols = ws.ws_col;
> +
> +	/*
> +	 * Limit description width to fit on a single line. We subtract 35
> +	 * columns of headroom to allocate space for:
> +	 * - The suite index prefix: e.g. " 10.100:" (9 characters).
> +	 * - The colon separator and spaces: " : " (3 characters).
> +	 * - The longest status results: e.g. "Skip (some metrics failed)" (26 characters)
> +	 *   or "Running (XX active)" (20 characters).

I don't understand how it can be 35.  The suite index prefix pattern
looks like "%3d.%1d:" which is 6.  Also it seems we don't have a space
before the colon (for the test result).


> +	 *
> +	 * A minimum description width of 10 is enforced to ensure names are
> +	 * legible even on very narrow consoles.
> +	 */
> +	term_width = cols - 35;
> +	if (term_width < 10)
> +		term_width = 10;
> +
> +	return term_width;
> +}
> +
> +static int get_max_desc_width(int width)
> +{
> +	int term_width = get_term_width();
> +
> +	return width > term_width ? term_width : width;
> +}
> +
>  static int print_test_result(struct test_suite *t, int curr_suite, int curr_test_case,
>  			     int result, int width, int running,
>  			     const char *err_output, double elapsed)
>  {
> +	int pad_width = get_max_desc_width(width);
> +	int term_width = get_term_width();
> +
>  	if (test_suite__num_test_cases(t) > 1) {
>  		char prefix[32];
>  		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:",
>  				   curr_suite + 1, curr_test_case + 1);
> -		int subw = len >= 4 ? width + 4 - len : width;
> +		int pad = len >= 4 ? pad_width + 4 - len : pad_width;
> +		int trunc = len >= 4 ? term_width + 4 - len : term_width;

Can 'len' be less than 4?  I don't think so..

Anyway, do you know why do we care?

thanks,
Namhyung

>  
> -		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
> -	} else
> -		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
> +		pr_info("%s %-*.*s:", prefix, pad, trunc,
> +			test_description(t, curr_test_case));
> +	} else {
> +		pr_info("%3d: %-*.*s:", curr_suite + 1, pad_width, term_width,
> +			test_description(t, curr_test_case));
> +	}
>  
>  	switch (result) {
>  	case TEST_RUNNING:
> -		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d active)\n", running);
> +		color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Running (%d active)\n", running);
>  		break;
>  	case TEST_OK:
>  		if (test_suite__num_test_cases(t) > 1)
