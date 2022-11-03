Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D380EC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 16:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiKCQPz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiKCQPy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 12:15:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95511154
        for <linux-perf-users@vger.kernel.org>; Thu,  3 Nov 2022 09:15:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k8so3560406wrh.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Nov 2022 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PIA3GBeXOfRhXEjRCDEwyUNKkrK8wlI75UwFpO43d88=;
        b=ByazuTSmWWuXJkPK6GFWUlorHo3+SwvoeOlBaVRszTLGLJnV1sjESVtie558CjO1Mk
         BmMu9XqRllW3tVM8CnoWbCfVPRjvWvE3vpWRgG+3dlu19UC27kD4FI48Pn4aZ/4JqVT2
         mgCkhxPHtXomrO7/4N1wisI7SLn6GMXgWGDoThYHmkiLbXs10BJHVwFnH6J8V2gID/XS
         q0JaKyR2NTQkdrHpgCj3vWkWVfMh9yxO7yVGNcv1yC8eWnG0PDx6dzvPO/n7XJT+7vEx
         d7lFvKuOAZ7m1mSjgUT9ZFYX/VHSfoYaLZjPsUY6tHpnksWRkrur9192SaLjvQQX+y2F
         b7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIA3GBeXOfRhXEjRCDEwyUNKkrK8wlI75UwFpO43d88=;
        b=Io3OMyL7VbYAqy8inU7Q7ShvlxVbdfhfDRWYsqAFnIh0DY2SoiQCzUmheKdWJxckWH
         X4LNstQU7Lvf3kTUyk5EnGskiTkZCb3TjqhxxyvwshqY1KQnQLdIpnhSrtUbgaxek9rI
         n7xYBMRYX+cQ7VtUXlWqwvPUIBxM2dqL2WH8lxxP5PykrvGkCwa/tudv08WKx3xvhhjd
         OO/OEbI2phjaGv68QdygM+W89zfCkba0L09uMPUlp0A9S0I9N9DLMhl7zruh6ISyYtv7
         wrFamZv8tsmurgjUUgc+Cj7KQehWF5IPCNSN+fG8f/RpqzTKrGT9RAkJrA+UeAmLMuFQ
         H8Vw==
X-Gm-Message-State: ACrzQf1iXQrnlN1cEWDdp/o+5U1wpdB0rGHnS82FyAJ82t+3GG4BW2rX
        vH6uihM0IhTStrS/pRpHuTZ+UBu4PRPDeQRsPrp0Yg==
X-Google-Smtp-Source: AMsMyM74xNT8KKrwvdpYNSaCNP0OJJDK9ogT5tFmLzsIQzW5O1a8m6DxkHcwTnHLMC3GNIriNc0h7wNhU4UWN8WacGc=
X-Received: by 2002:a05:6000:1817:b0:236:77f0:ef60 with SMTP id
 m23-20020a056000181700b0023677f0ef60mr18894921wrh.343.1667492151162; Thu, 03
 Nov 2022 09:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221018085605.63834-1-atrajeev@linux.vnet.ibm.com> <0B7A4A12-2528-439A-BB83-BBC5606A27B0@linux.vnet.ibm.com>
In-Reply-To: <0B7A4A12-2528-439A-BB83-BBC5606A27B0@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Nov 2022 09:15:38 -0700
Message-ID: <CAP-5=fVdsaNPptvgQ0NaqhXYELFY8HwwhjAaem0B_HrL2GUkUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/perf: Fix printing os->prefix in CSV metrics output
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, james.clark@arm.com,
        kjain@linux.ibm.com, namhyung@kernel.org, disgoel@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 2, 2022 at 1:36 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 18-Oct-2022, at 2:26 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> >
> > Perf stat with CSV output option prints an extra empty
> > string as first field in metrics output line.
> > Sample output below:
> >
> >       # ./perf stat -x, --per-socket -a -C 1 ls
> >       S0,1,1.78,msec,cpu-clock,1785146,100.00,0.973,CPUs utilized
> >       S0,1,26,,context-switches,1781750,100.00,0.015,M/sec
> >       S0,1,1,,cpu-migrations,1780526,100.00,0.561,K/sec
> >       S0,1,1,,page-faults,1779060,100.00,0.561,K/sec
> >       S0,1,875807,,cycles,1769826,100.00,0.491,GHz
> >       S0,1,85281,,stalled-cycles-frontend,1767512,100.00,9.74,frontend cycles idle
> >       S0,1,576839,,stalled-cycles-backend,1766260,100.00,65.86,backend cycles idle
> >       S0,1,288430,,instructions,1762246,100.00,0.33,insn per cycle
> > ====> ,S0,1,,,,,,,2.00,stalled cycles per insn
> >
> > The above command line uses field separator as ","
> > via "-x," option and per-socket option displays
> > socket value as first field. But here the last line
> > for "stalled cycles per insn" has "," in the
> > beginning.
> >
> > Sample output using interval mode:
> >       # ./perf stat -I 1000 -x, --per-socket -a -C 1 ls
> >       0.001813453,S0,1,1.87,msec,cpu-clock,1872052,100.00,0.002,CPUs utilized
> >       0.001813453,S0,1,2,,context-switches,1868028,100.00,1.070,K/sec
> >       ------
> >       0.001813453,S0,1,85379,,instructions,1856754,100.00,0.32,insn per cycle
> > ====> 0.001813453,,S0,1,,,,,,,1.34,stalled cycles per insn
> >
> > Above result also has an extra csv separator after
> > the timestamp. Patch addresses extra field separator
> > in the beginning of the metric output line.
> >
> > The counter stats are displayed by function
> > "perf_stat__print_shadow_stats" in code
> > "util/stat-shadow.c". While printing the stats info
> > for "stalled cycles per insn", function "new_line_csv"
> > is used as new_line callback.
> >
> > The new_line_csv function has check for "os->prefix"
> > and if prefix is not null, it will be printed along
> > with cvs separator.
> > Snippet from "new_line_csv":
> >       if (os->prefix)
> >               fprintf(os->fh, "%s%s", os->prefix, config->csv_sep);
> >
> > Here os->prefix gets printed followed by ","
> > which is the cvs separator. The os->prefix is
> > used in interval mode option ( -I ), to print
> > time stamp on every new line. But prefix is
> > already set to contain csv separator when used
> > in interval mode for csv option.
> >
> > Reference: Function "static void print_interval"
> > Snippet:
> >       sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
> >
> > Also if prefix is not assigned (if not used with
> > -I option), it gets set to empty string.
> > Reference: function printout() in util/stat-display.c
> > Snippet:
> >       .prefix = prefix ? prefix : "",
> >
> > Since prefix already set to contain cvs_sep in interval
> > option, patch removes printing config->csv_sep in
> > new_line_csv function to avoid printing extra field.
> >
> > After the patch:
> >
> >       # ./perf stat -x, --per-socket -a -C 1 ls
> >       S0,1,2.04,msec,cpu-clock,2045202,100.00,1.013,CPUs utilized
> >       S0,1,2,,context-switches,2041444,100.00,979.289,/sec
> >       S0,1,0,,cpu-migrations,2040820,100.00,0.000,/sec
> >       S0,1,2,,page-faults,2040288,100.00,979.289,/sec
> >       S0,1,254589,,cycles,2036066,100.00,0.125,GHz
> >       S0,1,82481,,stalled-cycles-frontend,2032420,100.00,32.40,frontend cycles idle
> >       S0,1,113170,,stalled-cycles-backend,2031722,100.00,44.45,backend cycles idle
> >       S0,1,88766,,instructions,2030942,100.00,0.35,insn per cycle
> >       S0,1,,,,,,,1.27,stalled cycles per insn
> >
> > Fixes: 92a61f6412d3 ("perf stat: Implement CSV metrics output")
> > Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>
> Hi All,
>
> Looking for review comments for this change.

Hi,

Thanks for addressing issues in this code. What is the status of the
CSV output test following these changes?

I think going forward we need to move away from CSV and columns, to
something with structure like json. We also need to refactor this
code, trying to add meaning to a newline character is a bad strategy
and creates some unnatural things. To some extent this overlaps with
Namhyung's aggregation cleanup. There are also weirdnesses in
jevents/pmu-events, like the same ScaleUnit applying to a metric and
an event - why are metrics even parts of events?

Given the current code is wac-a-mole, and this is another whack, if
the testing is okay I think we should move forward with this change.

Thanks,
Ian




> Thanks
> Athira
>
> > ---
> > tools/perf/util/stat-display.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 5c47ee9963a7..879874a4bc07 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -273,7 +273,7 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
> >
> >       fputc('\n', os->fh);
> >       if (os->prefix)
> > -             fprintf(os->fh, "%s%s", os->prefix, config->csv_sep);
> > +             fprintf(os->fh, "%s", os->prefix);
> >       aggr_printout(config, os->evsel, os->id, os->nr);
> >       for (i = 0; i < os->nfields; i++)
> >               fputs(config->csv_sep, os->fh);
> > --
> > 2.31.1
> >
>
