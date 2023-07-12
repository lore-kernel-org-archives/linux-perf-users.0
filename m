Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998D6EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 17:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGLRBY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjGLRBW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 13:01:22 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111112E
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 10:01:21 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4036bd4fff1so12611cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689181281; x=1691773281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do8WCqThbZfqwQjMvP5MGRLXecaFpfNRAFM5GCHsjdo=;
        b=G+kohK0xIgMPHQ3+5ncibyhuTwK6hxATxDANqz12TOSvN0edR3aq0H2AK/C1mm64/j
         eE6nAjp0TMl4AyeJbNffIsUnLB5yNlQHXm/8EqH2TcxRLRyFIKzqYYGQ3zKcS0lH6MuY
         PoznUsARm2aJGffc2UtKRQIzEnZNvV7lIJzRXxxu2tY8ROsOdshaYBaqfdgTr8MVSGL4
         doslZ0IKqW9j2ni0skHG80apYw5V4tZPBEtLptV3C0/p4n8n5M18nhf4KDTQzQGCrla6
         k4SY6UGSuJga2MV0TI5AXEpEqJJzFYYaIJkASzfJX+gcTq8rKW+FSXLA+K1wWX0Y13SP
         HPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181281; x=1691773281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do8WCqThbZfqwQjMvP5MGRLXecaFpfNRAFM5GCHsjdo=;
        b=TXn2a8gT8s6zYQbxHtQMBmpRTuxLdONnxfU8QhnKCjnyT8vwb2+ak6ned63izuGGk5
         tYCzn2zf77OU5BnKe4abCSiX+NAdwZ2Uz+dfgmBriIW4GJn5vsvibehlVIuZo+XVmy0D
         q5/XVyugy2kdlvngHkxPRNiyOUMz0Z6QbeHvnQiDCPvO1gKK9Xm5hkh7djgp1rWxpYzH
         lcHHdCXBQB/rzuNhgg30jOWs4qnwekDNpf8/9N+qldeCC+WugOdswk794GsK9Lfwll03
         gBIAPtJJuWtISeb7U5EsBPN6JuSCLSnBzCrrUfRHLHYXtKVtUfj8DrHHoD3PrbgOXcF/
         RHbQ==
X-Gm-Message-State: ABy/qLZOq+HF81Cr7VebiDIfNPXUF7QAr+TMILGjuDHo/obx7aR7T/1L
        6FGHqFLk/dwHTrtx+vC1G3YklAf1JaTD1Y1W/29odQ==
X-Google-Smtp-Source: APBJJlHjptCdg/MHrJtHqTVPJJ5f0n/BrCuENF8jJ6KVPMtOWPHMp+Tj+JC+fFU89bd66LbJ+CNT4N5ukOw36jw+tpU=
X-Received: by 2002:ac8:59ce:0:b0:3f8:8c06:c53b with SMTP id
 f14-20020ac859ce000000b003f88c06c53bmr360570qtf.0.1689181280722; Wed, 12 Jul
 2023 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <ba55bf712cc27494635ca0bb23a21b42529c9327.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <ba55bf712cc27494635ca0bb23a21b42529c9327.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:01:09 -0700
Message-ID: <CAP-5=fUqKZkuODXTez+Dk+RqTmh+NaeRBun65onG-yByUJOnVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] scripts: python: Extact necessary information from
 process event
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 10, 2023 at 4:10=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> The script takes in a sample event dictionary(param_dict) and retrieves
> relevant data such as time stamp, PID, TID, thread name. Also start time
> is defined.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../perf/scripts/python/firefox-gecko-converter.py  | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> index 5b342641925c..765f1775cee5 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -21,8 +21,19 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
>  from perf_trace_context import *
>  from Core import *
>

It'd be nice to have a comment here, perhaps:
# The time stamp from the first of the time ordered events.

> +start_time =3D None
> +
>  def trace_end():
>         pass
>
>  def process_event(param_dict):
> -       pass
> +       global start_time
> +       # Extract relevant information from the event parameters. The eve=
nt parameters
> +       # are in a dictionary:
> +       time_stamp =3D (param_dict['sample']['time'] // 1000) / 1000
> +       pid =3D param_dict['sample']['pid']
> +       tid =3D param_dict['sample']['tid']
> +       thread_name =3D param_dict['comm']
> +
> +       # Assume that start time is the time of the first event.
> +       start_time =3D time_stamp if not start_time else start_time

I appreciate that this is one line, but it takes some getting your
head around that start_time is being assigned to itself in the common
case. I think this would be more readable as:

if not start_time:
  start_time =3D time_stamp

Thanks,
Ian

> --
> 2.34.1
>
