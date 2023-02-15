Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF4C05027
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Feb 2023 00:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjBOAHB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Feb 2023 19:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBOAHA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Feb 2023 19:07:00 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE12412C
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 16:06:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a2so17461770wrd.6
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Feb 2023 16:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7dA0r51t3W0VjAaGdomblMdzwKvRvyd6Mp513WnfTQ=;
        b=m6M+yhQ+RhuTXnSZZmdzgqj38yLI1yJ/J8lkjPzLSOJ9yVZuAjuNabwuFuRfNbFuiU
         MqRxyZVmQzLg9PmWD7i2nDoGWNBfH34ufYaQ3TWYi6Wzv6DDbXwUHLZ5599nBE3ihVGM
         4VtHgBMfnjSlE0xZrTsbzuLx7McB7FzYYsrqVnA83sAjS74ZgPAQu3FMuMaUvcczAvB3
         Ix8znm1RKePcPEzgu19NL8swrfVjfpRKhH6g5drVGfHAvMk2l5LwAXpZy3u5Z/bpjGeV
         4eG9iGuJAMZ7ezTvO0Shw8xL+XHgdr4GQ2bXSyWN7M2/zdVjwHDHvQAAnzo/4Ag9iaWQ
         2KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7dA0r51t3W0VjAaGdomblMdzwKvRvyd6Mp513WnfTQ=;
        b=baXaQP5JCd1an4nVyDC+fDZRNbK4fgGMQ8SmL4WBYQe0o4CRV58v5P7XVZ5AODD6vs
         Fii6o82tVKWaH34TVGucC32pXk0HafZzocO7rzyPagt6QWB5eMuxZg3j9ZNjLbvBF5bX
         f90k0HBiOEBIgKHEQbTMjqPxH0ZLtDIzmrWe9Iz5r6ImiO8lLhkdEIlBZPqnKkGs1s9r
         td0II3gPBXIU2MVOOSGUBfRYV9WNDCN7fQEsDthmPHb1vmEXu1EB3UYIxGx8gfsyr7KL
         eZPRGz24222CcTUDNgPKNH6e0uk1Ntz9dxDx6wkE9czVTu52G3qDBwj0kAwHPwkzmObE
         1HpA==
X-Gm-Message-State: AO0yUKUmwGflF9r0D5vuAGD+6Z2h6Fs/Sn4jn5KRV5c/rdgL6n2W397j
        Bttp4e1BOEBpDgB+EYtGCSEqVQtYieyVuqenuSAaraaS6RVFt7fvwSg=
X-Google-Smtp-Source: AK7set803HZbzeXaa6CXTvbRQ6wWO9571c6fo7NHFXNUBRBjIPb/2Wg+Rjg82SIUSz+iiwRqLlNSkBua90P1EcPy9iY=
X-Received: by 2002:a5d:6b8b:0:b0:2c5:4d9c:d208 with SMTP id
 n11-20020a5d6b8b000000b002c54d9cd208mr163835wrx.735.1676419617996; Tue, 14
 Feb 2023 16:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20230202164413.56743-1-kjain@linux.ibm.com> <3BB099AB-5FB4-40FF-A281-C06A42FBEBC7@linux.vnet.ibm.com>
 <157932b6-be9b-dc92-be91-ba070ebddc75@linux.ibm.com>
In-Reply-To: <157932b6-be9b-dc92-be91-ba070ebddc75@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Feb 2023 16:06:45 -0800
Message-ID: <CAP-5=fX+My97QeH-fMTRp0tZZ6=Ke7+b057G33Dok=p27cs+eA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Add system wide check for perf bench
 workload in all metric test
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 7, 2023 at 7:45 PM kajoljain <kjain@linux.ibm.com> wrote:
>
>
>
> On 2/6/23 10:10, Athira Rajeev wrote:
> >
> >
> >> On 02-Feb-2023, at 10:14 PM, Kajol Jain <kjain@linux.ibm.com> wrote:
> >>
> >> Testcase stat_all_metrics.sh fails in powerpc:
> >>
> >> 92: perf all metrics test : FAILED!
> >>
> >> Logs with verbose:
> >>
> >> [command]# ./perf test 92 -vv
> >> 92: perf all metrics test                                           :
> >> --- start ---
> >> test child forked, pid 13262
> >> Testing BRU_STALL_CPI
> >> Testing COMPLETION_STALL_CPI
> >> ----
> >> Testing TOTAL_LOCAL_NODE_PUMPS_P23
> >> Metric 'TOTAL_LOCAL_NODE_PUMPS_P23' not printed in:
> >> Error:
> >> Invalid event (hv_24x7/PM_PB_LNS_PUMP23,chip=3/) in per-thread mode, enable system wide with '-a'.
> >> Testing TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01
> >> Metric 'TOTAL_LOCAL_NODE_PUMPS_RETRIES_P01' not printed in:
> >> Error:
> >> Invalid event (hv_24x7/PM_PB_RTY_LNS_PUMP01,chip=3/) in per-thread mode, enable system wide with '-a'.
> >> ----
> >>
> >> Based on above logs, we could see some of the hv-24x7 metric events fails,
> >> and logs suggest to run the metric event with -a option.
> >> This change happened after the commit a4b8cfcabb1d ("perf stat: Delay metric
> >> parsing"), which delayed the metric parsing phase and now before metric parsing
> >> phase perf tool identifies, whether target is system-wide or not. With this
> >> change, perf_event_open will fails with workload monitoring for uncore events
> >> as expected.
> >>
> >> The perf all metric test case fails as some of the hv-24x7 metric events
> >> may need bigger workload to get the data. And the added perf bench
> >> workload in 'perf all metric test case' will not run for hv-24x7 without
> >> -a option.
> >>
> >> Fix this issue by adding system wide check for perf bench workload.
> >>
> >> Result with the patch changes in powerpc:
> >>
> >> 92: perf all metrics test : Ok
> >>
> >> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> >
> > Looks good to me
> >
> > Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>
> Hi Arnaldo,
>    Let me know if patch looks fine to you.
>
> Thanks,
> Kajol Jain

I ran into a similar issue but worked around it with:

```
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -11,7 +11,7 @@ for m in $(perf list --raw-dump metrics); do
    continue
  fi
  # Failed so try system wide.
-  result=$(perf stat -M "$m" -a true 2>&1)
+  result=$(perf stat -M "$m" -a sleep 0.01 2>&1)
  if [[ "$result" =~ "${m:0:50}" ]]
  then
    continue
```

Running the synthesize benchmark is potentially slow, wdyt of the change above?

Thanks,
Ian


> >
> >> ---
> >> tools/perf/tests/shell/stat_all_metrics.sh | 7 +++++++
> >> 1 file changed, 7 insertions(+)
> >>
> >> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> >> index 6e79349e42be..d49832a316d9 100755
> >> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> >> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> >> @@ -23,6 +23,13 @@ for m in $(perf list --raw-dump metrics); do
> >>   then
> >>     continue
> >>   fi
> >> +  # Failed again, possibly the event is uncore pmu event which will need
> >> +  # system wide monitoring with workload, so retry with -a option
> >> +  result=$(perf stat -M "$m" -a perf bench internals synthesize 2>&1)
> >> +  if [[ "$result" =~ "${m:0:50}" ]]
> >> +  then
> >> +    continue
> >> +  fi
> >>   echo "Metric '$m' not printed in:"
> >>   echo "$result"
> >>   if [[ "$err" != "1" ]]
> >> --
> >> 2.39.0
> >>
> >
