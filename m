Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF58AC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A2E61952
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 15:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFYPsX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFYPsX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 11:48:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2EC061574;
        Fri, 25 Jun 2021 08:46:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k30-20020a05600c1c9eb02901d4d33c5ca0so704069wms.3;
        Fri, 25 Jun 2021 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Bt0GH77YvJgxDEQ3LYptimTUrtT4TxN/6nOUNNLlwL4=;
        b=pmYj/7r6VbnenZNC1Vm8i12QS/yIo/ebAKy0SjElknve9AhbfvNVROVUhJ4nk/QZ25
         v7MQey+/5YQSewt5k7e8YBULfq8m01Kj19DqLaZmyGPyIjEEMTpGx34vpeI7x3tYya5c
         60wpkUjP0Sc+WEP2jxVdy3ONN2BJw0ACyBcKbxJIkXc8Wmlfw0xA6gfD44H1X8vQuOBd
         By8uJWAAIZSt1f25+w7gonS5yMPYyLbOL/0PMGQzAAlrY6uhe/uSyqOTXtLj7L5aYuHt
         h40DHK3WGwoLTS1WDiVNtt7odtObtSUdQNYqyTsMLGzyCXKjYfBTbWqESjHSzKQfGWUj
         riUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Bt0GH77YvJgxDEQ3LYptimTUrtT4TxN/6nOUNNLlwL4=;
        b=S7o77FExXZ+PMohAKcHIygTGvaeVhz8tWdpGVUnPTNwE7zId/iKyXyEl/HM+rS5BJe
         +P9rYcZtHJ966jW8RqSRX2jE+qEAUvCIQBHabiw2Kp5jV2JM900GXioUy08zuwdd+O++
         vnF9pABTL0Y7GDSF5WS9yKsiPMMhGTXNLlf7BmdLjAHFxYzT8ZIpSo1gnwxzrla5oZJr
         RN0a6nFlFY2oLN0FjOt0H2jUU+4AkHvpsgitTNndT2q9NmmZrHicP4jBvDqPEeLxnF8+
         mVcs78S5FVtyOu04GeUD2Kt3jrgqLTCGkhCpneYLoCG7xJHhOaXAasOGap3KddwhTreJ
         B8ow==
X-Gm-Message-State: AOAM530Jf1ZwOqccl+NgmDk0Dax036Ei+STX/m2n5LpEarx3mCR8bx0M
        bk/5eDZzMvU1DbJ21JAcm8c=
X-Google-Smtp-Source: ABdhPJwAKzCaMyhwOVI+edXxgfgdCwlTo3W9jxZvNDGYFwMBszdsogrLaPwnqwQ0fh71pdZ61WSWvA==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr11451064wmi.50.1624635960655;
        Fri, 25 Jun 2021 08:46:00 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.44.148])
        by smtp.gmail.com with ESMTPSA id o3sm6368625wrj.94.2021.06.25.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:46:00 -0700 (PDT)
Message-ID: <4725ef2249540b6876daea3714a38a6be59223e6.camel@gmail.com>
Subject: Re: [PATCH v2] perf session: add missing evlist__delete when
 deleting a session
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Jun 2021 17:45:59 +0200
In-Reply-To: <YNXD2xN2wrZgdbwO@krava>
References: <20210624231926.212208-1-rickyman7@gmail.com>
         <CAP-5=fVbGZbV3qp27DPD_7r0z-v9hr2m34H294angaEsssKB0Q@mail.gmail.com>
         <YNXD2xN2wrZgdbwO@krava>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

thank you both for your comments.

On Fri, 2021-06-25 at 13:54 +0200, Jiri Olsa wrote:
> On Thu, Jun 24, 2021 at 10:39:34PM -0700, Ian Rogers wrote:
> > On Thu, Jun 24, 2021 at 4:20 PM Riccardo Mancini <rickyman7@gmail.com>
> > wrote:
> > > 
> > > ASan reports a memory leak caused by evlist not being deleted on exit in
> > > perf-report, perf-script and perf-data.
> > > The problem is caused by evlist->session not being deleted, which is
> > > allocated in perf_session__read_header, called in perf_session__new if
> > > perf_data is in read mode.
> > > In case of write mode, the session->evlist is filled by the caller.
> > > This patch solves the problem by calling evlist__delete in
> > > perf_session__delete if perf_data is in read mode.
> 
> ugh, I'm surprised we did not free that.. and can't find
> in git log we ever did ;-) I briefly check commands using
> sessions and looks like it's correct
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > It is messy that in read mode the session owns the evlist, but
> > otherwise not. Imo, it'd be nice to make the ownership unconditional.
> 
> yep, would be nice

I think the root problem is that perf_session__new has different behaviours
depending on perf_data and perf_tool and that it probably does too many things
for a __new function.
If we split it into multiple functions and then, say, we create two helpers
perf_session__init_read and perf_session__init_write, with the corresponding
perf_session__fini_read and perf_session__fini_write, then the conditional
ownership won't be a big problem due to having these two cases clearly
separated.
What do you think?

Thanks,
Riccardo

> 
> thanks,
> jirka
> 
> > 
> > Thanks,
> > Ian
> > 
> > > Changes in v2:
> > >  - call evlist__delete from within perf_session__delete
> > > 
> > > v1:
> > > https://lore.kernel.org/lkml/20210621234317.235545-1-rickyman7@gmail.com/
> > > 
> > > ASan report follows:
> > > 
> > > $ ./perf script report flamegraph
> > > =================================================================
> > > ==227640==ERROR: LeakSanitizer: detected memory leaks
> > > 
> > > <SNIP unrelated>
> > > 
> > > Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
> > >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> > >     #1 0xbe3d56 in zalloc
> > > /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> > >     #2 0x7f999e in evlist__new
> > > /home/user/linux/tools/perf/util/evlist.c:77:26
> > >     #3 0x8ad938 in perf_session__read_header
> > > /home/user/linux/tools/perf/util/header.c:3797:20
> > >     #4 0x8ec714 in perf_session__open
> > > /home/user/linux/tools/perf/util/session.c:109:6
> > >     #5 0x8ebe83 in perf_session__new
> > > /home/user/linux/tools/perf/util/session.c:213:10
> > >     #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-
> > > script.c:3856:12
> > >     #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> > >     #8 0x7b120f in handle_internal_command
> > > /home/user/linux/tools/perf/perf.c:365:8
> > >     #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> > >     #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> > >     #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> > > 
> > > Indirect leak of 568 byte(s) in 1 object(s) allocated from:
> > >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> > >     #1 0xbe3d56 in zalloc
> > > /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> > >     #2 0x80ce88 in evsel__new_idx
> > > /home/user/linux/tools/perf/util/evsel.c:268:24
> > >     #3 0x8aed93 in evsel__new /home/user/linux/tools/perf/util/evsel.h:210:9
> > >     #4 0x8ae07e in perf_session__read_header
> > > /home/user/linux/tools/perf/util/header.c:3853:11
> > >     #5 0x8ec714 in perf_session__open
> > > /home/user/linux/tools/perf/util/session.c:109:6
> > >     #6 0x8ebe83 in perf_session__new
> > > /home/user/linux/tools/perf/util/session.c:213:10
> > >     #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-
> > > script.c:3856:12
> > >     #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> > >     #9 0x7b120f in handle_internal_command
> > > /home/user/linux/tools/perf/perf.c:365:8
> > >     #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> > >     #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> > >     #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> > > 
> > > Indirect leak of 264 byte(s) in 1 object(s) allocated from:
> > >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> > >     #1 0xbe3d56 in zalloc
> > > /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> > >     #2 0xbe3e70 in xyarray__new
> > > /home/user/linux/tools/lib/perf/xyarray.c:10:23
> > >     #3 0xbd7754 in perf_evsel__alloc_id
> > > /home/user/linux/tools/lib/perf/evsel.c:361:21
> > >     #4 0x8ae201 in perf_session__read_header
> > > /home/user/linux/tools/perf/util/header.c:3871:7
> > >     #5 0x8ec714 in perf_session__open
> > > /home/user/linux/tools/perf/util/session.c:109:6
> > >     #6 0x8ebe83 in perf_session__new
> > > /home/user/linux/tools/perf/util/session.c:213:10
> > >     #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-
> > > script.c:3856:12
> > >     #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> > >     #9 0x7b120f in handle_internal_command
> > > /home/user/linux/tools/perf/perf.c:365:8
> > >     #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> > >     #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> > >     #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> > > 
> > > Indirect leak of 32 byte(s) in 1 object(s) allocated from:
> > >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> > >     #1 0xbe3d56 in zalloc
> > > /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> > >     #2 0xbd77e0 in perf_evsel__alloc_id
> > > /home/user/linux/tools/lib/perf/evsel.c:365:14
> > >     #3 0x8ae201 in perf_session__read_header
> > > /home/user/linux/tools/perf/util/header.c:3871:7
> > >     #4 0x8ec714 in perf_session__open
> > > /home/user/linux/tools/perf/util/session.c:109:6
> > >     #5 0x8ebe83 in perf_session__new
> > > /home/user/linux/tools/perf/util/session.c:213:10
> > >     #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-
> > > script.c:3856:12
> > >     #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> > >     #8 0x7b120f in handle_internal_command
> > > /home/user/linux/tools/perf/perf.c:365:8
> > >     #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> > >     #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> > >     #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> > > 
> > > Indirect leak of 7 byte(s) in 1 object(s) allocated from:
> > >     #0 0x4b8207 in strdup (/home/user/linux/tools/perf/perf+0x4b8207)
> > >     #1 0x8b4459 in evlist__set_event_name
> > > /home/user/linux/tools/perf/util/header.c:2292:16
> > >     #2 0x89d862 in process_event_desc
> > > /home/user/linux/tools/perf/util/header.c:2313:3
> > >     #3 0x8af319 in perf_file_section__process
> > > /home/user/linux/tools/perf/util/header.c:3651:9
> > >     #4 0x8aa6e9 in perf_header__process_sections
> > > /home/user/linux/tools/perf/util/header.c:3427:9
> > >     #5 0x8ae3e7 in perf_session__read_header
> > > /home/user/linux/tools/perf/util/header.c:3886:2
> > >     #6 0x8ec714 in perf_session__open
> > > /home/user/linux/tools/perf/util/session.c:109:6
> > >     #7 0x8ebe83 in perf_session__new
> > > /home/user/linux/tools/perf/util/session.c:213:10
> > >     #8 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-
> > > script.c:3856:12
> > >     #9 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> > >     #10 0x7b120f in handle_internal_command
> > > /home/user/linux/tools/perf/perf.c:365:8
> > >     #11 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> > >     #12 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> > >     #13 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> > > 
> > > SUMMARY: AddressSanitizer: 3728 byte(s) leaked in 7 allocation(s).
> > > 
> > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > > ---
> > >  tools/perf/util/session.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > > index e59242c361ce..c36464d94387 100644
> > > --- a/tools/perf/util/session.c
> > > +++ b/tools/perf/util/session.c
> > > @@ -301,8 +301,11 @@ void perf_session__delete(struct perf_session *session)
> > >         perf_session__release_decomp_events(session);
> > >         perf_env__exit(&session->header.env);
> > >         machines__exit(&session->machines);
> > > -       if (session->data)
> > > +       if (session->data) {
> > > +               if (perf_data__is_read(session->data))
> > > +                       evlist__delete(session->evlist);
> > >                 perf_data__close(session->data);
> > > +       }
> > >         free(session);
> > >  }
> > > 
> > > --
> > > 2.31.1
> > > 
> > 
> 


