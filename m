Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A9285066
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782175925; cv=pass; b=BiCOPwB+lFgbuSmRiJ6DN2YHOJz/918MVfufz4f8gGZH2AJGNwzVhQEMuQ/2MpvFmZXXWQaegqZ8gWhEDO+VYOZBpJPrdWD6nS73GH6BzKcXrH5Dvdq/lVGzALwhqRJh6BNe2OxbEeBRkbzYdau3jvhA6xkXstmMXMZ9nx3B0xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782175925; c=relaxed/simple;
	bh=uHUV9aJt3qmeqRpKSvYEGi1cQdNEJmWLA/blzr9jpwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGdCFDXIll9KtttASDlOXbHmvJKJcQCv41F6gdEYiCPU+CkEGx19n6uvvN3JrfGoebVJwUUze1gngvcuefnlozneC8xIF/CYl4M0Fy7eI5RVrcqE53lRUHLR5Ie0JiPzXJEkTvhtNPAPN27DiXHduivIq5csvIy/3RWnXmkNPio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vp2KxqLz; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vp2KxqLz"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139a251a6ceso5802c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 17:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782175921; cv=none;
        d=google.com; s=arc-20260327;
        b=RER+3XwSeoJkk8P9/cbCvmDq9TaqtPzxF80ZOkM9aY8sI4Iijy48XpYjytezMu1Ura
         3pyGJybI1vKq9rfOfvGTK2OLujBQ+NVx2lh7nL6M3O2nMY2UOvmmAFigeIePKpjfDIK0
         3wNs4Vlw7vHjo74fgqgpf+VrUGt4eHvuiWBdHzfHHsbJQVzGLKmPTzMSuNA9W4wXzDq3
         cI6NFfAqEHLBNXYV56eowP61zNdI9J1/QijQgCJg0RZElAbOH8Nx9P/xRDVV6JNdjct/
         G9IfBLJHn3Ia5ciHo38vhzBT3ZulaX/xgj77m6HqJjBZqa/equmeSz+KBcrRp3bhxs3G
         oShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FamSot50PBYVTL6MJiapknBP3Rx+ecY9WSssddKwWks=;
        fh=nb+Mtnr3JuzcMbhqm1qpf5iRLW2/oDo1IUeTCRdToxY=;
        b=L+Edm5Q8qeXe7Oz+sz+UC46NJ6biuUj21HLkt0QnJ4earAmynmFOmI+DtN58uxfHfl
         kbRK5H+DiAgCFCzngSkVBgJ0VXA6y7q+fdknaHEMWH5iNt3InMhK20YyIenzMzn/SoTY
         fe9oBgjpOkkoL/3eupedcGMdM3vZIsSElaMMfKwP7S8gwv5HKtyr1+KwJCYS5ltOwO82
         7pk+Rc5bsVphuCldhJhlWySnTx8TCbbKpFhE8SvMZUaUA6XOHBl1vixutt1Bn3NrVHxA
         ADUpnnjvGDNBnGthckbF5xBWpAA0xPW9inSP6fBvzATlvZ/2ragABetUmHtSblqSbyHn
         nIcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782175921; x=1782780721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FamSot50PBYVTL6MJiapknBP3Rx+ecY9WSssddKwWks=;
        b=vp2KxqLzXdXfbuBTCHf78EejEgZxcp9+KesqH2DTLQ/AyuVt2RdaYzE+mH1Hbsx3Qu
         FAml0A336lxp5wDH58X62sMDmpT/l6BccIpv+K3z3udvhxQWzhCAfVDSVX9aS30c5kFe
         DByNHKDs33fTkBOhZ215m28Wq+ti/lbAn9IkM61IBgpoO/6h1p7JoZyGd0LulcyDOLi8
         jxjgESrPZBhhZA4muWOr6mdDBMvIRcQUuTrPkeycX6fL6dZO/f0jpiyYlRi+Uac/s0ev
         JdZisjM5pLmdVkguWcG4mB3CD+dqqNkPJA0rLz9ncSa+XfT2i3gdrMoKyWHb5Gm1vmDe
         nZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782175921; x=1782780721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FamSot50PBYVTL6MJiapknBP3Rx+ecY9WSssddKwWks=;
        b=GNj+AiCxgNM1B+D46kMnT0nyzCEOxhb6Bv/3KUf0nE09xZvv82KZmPfxmE0gHzvGhK
         RmMj9CRSZcdjXgLmtJuVwAU9dfZ22Ce2xDpkzHaICmuGTJGSdPIddevP8K1NPuRlrklP
         Zbq+cmwH0Mw0L/rueHAzgujEpMeVhRxP6Xlmi3/KI8dqfYq4Djk2lWreDQuasv+n9Rtc
         WiQpQ5Sh9kWILMIqsxu+VKF3aCfyG0FzqRIJEqhndzXT2Sp0Smp4+N4Hh303su26mNX8
         TYfLaEcn5bCk3Hozb3+MW0aWtHCbIuZAdJis9yTHYzN7s+Pfu7oez9gUEAEeduoBbG6a
         DBoQ==
X-Forwarded-Encrypted: i=1; AFNElJ977MNRolgE5P3jEGd1H6JaZ/uNl6P+fFjwlLj5Z6CC/FShlMp2HUc6iAafJCidRtiuvRRAZS+2oC+8T9d/58ES@vger.kernel.org
X-Gm-Message-State: AOJu0YxzpZ+Q3jsI0uNJ3XyPji9SnkXffWmxBBRGc5vR/J6QyIKdwAPc
	f3+z27JXbyzt7u7pYi0r+pkeBM0hrpNnHtwirHJUrYzZGy+pYAkPVvOMxlR71Cj2jv1tAdCiae4
	qsiWmiH+JlhvPru9wQsYTPdn/PE7q/EaN+PqUa6gY
X-Gm-Gg: AfdE7cnNLNLwWr6kB9pZIf/u1d08PYrpvC3dP4MFfFDR3mHZN0cEeGzObUgTsr99+1X
	sR1WX3PfajHEKlSr9C7NncEloakJQCZHrKyW1qZzMzugZXHHWJZEXN6F27EJZQzZCMPqrv4eiQF
	gKM6M7XmDRrDaPQ9fLzl4ygiFEUCtFpDYczeE5YQyD0Gp7Nx69Hl+dqzkTRXIabIX2kKbNmuWB6
	AxUGuiCJaFJ+GySfTdDSDdgTc8n0JiGxXEsfZSHmQ9CxlUM32PAxCfKsgdeOHqezSsEiLbEXA==
X-Received: by 2002:a05:7022:7a4:b0:139:b0fc:f84 with SMTP id
 a92af1059eb24-139c55ed220mr57524c88.11.1782175920530; Mon, 22 Jun 2026
 17:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
 <20260616164819.370939-3-irogers@google.com> <ajMg1JQBlnMxhNfl@google.com>
In-Reply-To: <ajMg1JQBlnMxhNfl@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jun 2026 17:51:48 -0700
X-Gm-Features: AVVi8CeW0zJv9nFqrIoIbYSW48rSyyUzkQ2f9zBk88GsavGq9xAqt8PzHdiRhYs
Message-ID: <CAP-5=fXU_7Hgo=6N8gQOFuwr3=Jf7tz70GTxXEKmNsE5vHqPSw@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] perf test: Truncate test description to fit
 terminal width
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 3:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jun 16, 2026 at 09:48:07AM -0700, Ian Rogers wrote:
> > The parallel test harness uses the carriage return delete escape sequen=
ce
> > `PERF_COLOR_DELETE_LINE` ("\033[A\33[2K\r") to erase and update the
> > "Running (X active)" progress lines.
> >
> > However, if a test description is longer than the terminal width, the l=
ine
> > wraps around. When this happens, the cursor up escape sequence `\033[A`
> > only moves the cursor to the last wrapped row, leaving the top half of =
the
> > description printed on the previous line. This leads to name duplicatio=
n
> > and output corruption spilling over multiple rows on consoles narrower
> > than the maximum description length (e.g., 101 columns wide).
> >
> > Fix this by dynamically querying the terminal width using
> > `get_term_dimensions` and truncating the printed test descriptions usin=
g
> > the `%-*.*s` printf format. We reserve 35 characters for prefix, status=
,
> > and spacing metrics to guarantee the progress line never wraps.
> >
> > Fixes: 0e036dcad4e6 ("perf test: Display number of active running tests=
")
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/builtin-test.c | 130 ++++++++++++++++++++++++--------
> >  1 file changed, 98 insertions(+), 32 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index afc06cec4954..1dcaeb8505b7 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -10,35 +10,39 @@
> >  #ifdef HAVE_BACKTRACE_SUPPORT
> >  #include <execinfo.h>
> >  #endif
> > -#include <poll.h>
> > -#include <unistd.h>
> >  #include <setjmp.h>
> > -#include <string.h>
> >  #include <stdlib.h>
> > -#include <sys/types.h>
> > +#include <string.h>
> > +
> >  #include <dirent.h>
> > -#include <sys/wait.h>
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +#include <linux/zalloc.h>
> > +#include <poll.h>
> > +#include <sys/ioctl.h>
> >  #include <sys/stat.h>
> >  #include <sys/time.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +
> > +#include <subcmd/exec-cmd.h>
> > +#include <subcmd/parse-options.h>
> > +#include <subcmd/run-command.h>
> > +
> >  #include "builtin.h"
> > +#include "color.h"
> >  #include "config.h"
> > +#include "debug.h"
> >  #include "hist.h"
> >  #include "intlist.h"
> > -#include "tests.h"
> > -#include "debug.h"
> > -#include "color.h"
> > -#include <subcmd/parse-options.h>
> > -#include <subcmd/run-command.h>
> >  #include "string2.h"
> >  #include "symbol.h"
> > +#include "tests-scripts.h"
> > +#include "tests.h"
> >  #include "util/rlimit.h"
> >  #include "util/strbuf.h"
> > -#include <linux/kernel.h>
> > -#include <linux/string.h>
> > -#include <subcmd/exec-cmd.h>
> > -#include <linux/zalloc.h>
> > -
> > -#include "tests-scripts.h"
> > +#include "util/term.h"
> >
> >  static const char *junit_filename;
> >  static struct strbuf junit_xml_buf =3D STRBUF_INIT;
> > @@ -413,23 +417,73 @@ static char *xml_escape(const char *str)
> >       return res ? res : strdup("");
> >  }
> >
> > +static int get_term_width(void)
> > +{
> > +     struct winsize ws;
> > +     int cols =3D 80;
> > +     int term_width;
> > +
> > +     /*
> > +      * If output is redirected to a file or piped, we don't need to w=
rap
> > +      * or truncate at all. Use a massive virtually infinite terminal =
width
> > +      * so descriptions are printed in full.
> > +      */
> > +     if (!isatty(fileno(debug_file())))
> > +             return 10000;
> > +
> > +     get_term_dimensions(&ws);
> > +     if (ws.ws_col > 0)
> > +             cols =3D ws.ws_col;
> > +
> > +     /*
> > +      * Limit description width to fit on a single line. We subtract 3=
5
> > +      * columns of headroom to allocate space for:
> > +      * - The suite index prefix: e.g. " 10.100:" (9 characters).
> > +      * - The colon separator and spaces: " : " (3 characters).
> > +      * - The longest status results: e.g. "Skip (some metrics failed)=
" (26 characters)
> > +      *   or "Running (XX active)" (20 characters).
>
> I don't understand how it can be 35.  The suite index prefix pattern
> looks like "%3d.%1d:" which is 6.  Also it seems we don't have a space
> before the colon (for the test result).

There are 2 colons, one after the test.subtest and one before the
result. I'll tweakt the comments.

>
> > +      *
> > +      * A minimum description width of 10 is enforced to ensure names =
are
> > +      * legible even on very narrow consoles.
> > +      */
> > +     term_width =3D cols - 35;
> > +     if (term_width < 10)
> > +             term_width =3D 10;
> > +
> > +     return term_width;
> > +}
> > +
> > +static int get_max_desc_width(int width)
> > +{
> > +     int term_width =3D get_term_width();
> > +
> > +     return width > term_width ? term_width : width;
> > +}
> > +
> >  static int print_test_result(struct test_suite *t, int curr_suite, int=
 curr_test_case,
> >                            int result, int width, int running,
> >                            const char *err_output, double elapsed)
> >  {
> > +     int pad_width =3D get_max_desc_width(width);
> > +     int term_width =3D get_term_width();
> > +
> >       if (test_suite__num_test_cases(t) > 1) {
> >               char prefix[32];
> >               int len =3D snprintf(prefix, sizeof(prefix), "%3d.%1d:",
> >                                  curr_suite + 1, curr_test_case + 1);
> > -             int subw =3D len >=3D 4 ? width + 4 - len : width;
> > +             int pad =3D len >=3D 4 ? pad_width + 4 - len : pad_width;
> > +             int trunc =3D len >=3D 4 ? term_width + 4 - len : term_wi=
dth;
>
> Can 'len' be less than 4?  I don't think so..
>
> Anyway, do you know why do we care?

It was a safety measure carried forward, maybe due to Sashiko originally.

Thanks,
Ian

> thanks,
> Namhyung
>
> >
> > -             pr_info("%s %-*s:", prefix, subw, test_description(t, cur=
r_test_case));
> > -     } else
> > -             pr_info("%3d: %-*s:", curr_suite + 1, width, test_descrip=
tion(t, curr_test_case));
> > +             pr_info("%s %-*.*s:", prefix, pad, trunc,
> > +                     test_description(t, curr_test_case));
> > +     } else {
> > +             pr_info("%3d: %-*.*s:", curr_suite + 1, pad_width, term_w=
idth,
> > +                     test_description(t, curr_test_case));
> > +     }
> >
> >       switch (result) {
> >       case TEST_RUNNING:
> > -             color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d ac=
tive)\n", running);
> > +             color_fprintf(debug_file(), PERF_COLOR_YELLOW, " Running =
(%d active)\n", running);
> >               break;
> >       case TEST_OK:
> >               if (test_suite__num_test_cases(t) > 1)
