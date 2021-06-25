Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023AC48BC2
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 11:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD56D6161F
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 11:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFYL4b (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 07:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhFYL4a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 07:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624622049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DuhrZWYgsHGEDzFkorHdrzg1wXdLu2i4a836EtfS2mY=;
        b=gyXpaPoMo4WA2WDU1xAhDZny4ZzsqZQxiibOA9kj5UCGHEtsHUUmbe/SfWieEtMsaAF5qJ
        0qx1IH8R35OIk3uJIgtbmUUmuET0BRVuOdYJobwYMAbx6pNRIRTtpgVAYDp2fuHfxdyYue
        1gKB2oSUwMmGTxUF6cS/03ZZ7mdllxc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-urpBELCvNvuW7lr1kAvNWw-1; Fri, 25 Jun 2021 07:54:08 -0400
X-MC-Unique: urpBELCvNvuW7lr1kAvNWw-1
Received: by mail-ej1-f70.google.com with SMTP id ci22-20020a170906c356b0290492ca430d87so3010742ejb.14
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jun 2021 04:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DuhrZWYgsHGEDzFkorHdrzg1wXdLu2i4a836EtfS2mY=;
        b=I7f9nAilzGg0uCsrTlMvyE1p0kY2Z7dC35UAWx2XOMfcSL695h8Qz3iqKEkKewSQ+R
         /NEUmX1NseqF1eoYif2Gu8rBGYr8l2uWePoSdCuOBFcH+uE4LfpOTe9i/nplXop8G8Jp
         PI79TKnKZMTBRIAUWR6d6PJWRQhEC4hu0sJSXhmSijf11GOKkG1Lu8cyjrgNy4NIerlg
         dpgYD/PQ8fVm56tpCRelhqr3P+6oRsyvM6YI/abLV2mrUlgKDPSke+2L5YXJx4hv0j9p
         FESFuZxqVMZ7boSmUpvJKV6iX/FUYLIFNIcxwZpucBHeWarqlKy47tAVd5sq/l7trZYS
         tdWg==
X-Gm-Message-State: AOAM533hMYNCdz3957qpmxIGCZSq3ucK3my0zlQ2lrupkPNlUYSyJG6k
        kOw4mirYY80iPLmev15u41990aGQQ9kyfmCkjBEht/tTznWIOBceG4EHqHP+NODPuZ21zMCSQvL
        1gP6R8O+XdEMIQEjxMpQbgglKM+j/RQ==
X-Received: by 2002:a17:906:9bd5:: with SMTP id de21mr10234125ejc.554.1624622046964;
        Fri, 25 Jun 2021 04:54:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF9XnW4/tmgAqs4EjmvNpAiZqVLOokVqJ8Ax/ECJWRnDscvPiygYW2Y2pB9HNMmkM+gNHEIg==
X-Received: by 2002:a17:906:9bd5:: with SMTP id de21mr10234102ejc.554.1624622046705;
        Fri, 25 Jun 2021 04:54:06 -0700 (PDT)
Received: from krava ([5.170.249.192])
        by smtp.gmail.com with ESMTPSA id i6sm2600777ejr.68.2021.06.25.04.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:54:06 -0700 (PDT)
Date:   Fri, 25 Jun 2021 13:54:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf session: add missing evlist__delete when
 deleting a session
Message-ID: <YNXD2xN2wrZgdbwO@krava>
References: <20210624231926.212208-1-rickyman7@gmail.com>
 <CAP-5=fVbGZbV3qp27DPD_7r0z-v9hr2m34H294angaEsssKB0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVbGZbV3qp27DPD_7r0z-v9hr2m34H294angaEsssKB0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 24, 2021 at 10:39:34PM -0700, Ian Rogers wrote:
> On Thu, Jun 24, 2021 at 4:20 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> >
> > ASan reports a memory leak caused by evlist not being deleted on exit in
> > perf-report, perf-script and perf-data.
> > The problem is caused by evlist->session not being deleted, which is
> > allocated in perf_session__read_header, called in perf_session__new if
> > perf_data is in read mode.
> > In case of write mode, the session->evlist is filled by the caller.
> > This patch solves the problem by calling evlist__delete in
> > perf_session__delete if perf_data is in read mode.

ugh, I'm surprised we did not free that.. and can't find
in git log we ever did ;-) I briefly check commands using
sessions and looks like it's correct

Acked-by: Jiri Olsa <jolsa@redhat.com>

> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> It is messy that in read mode the session owns the evlist, but
> otherwise not. Imo, it'd be nice to make the ownership unconditional.

yep, would be nice

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > Changes in v2:
> >  - call evlist__delete from within perf_session__delete
> >
> > v1: https://lore.kernel.org/lkml/20210621234317.235545-1-rickyman7@gmail.com/
> >
> > ASan report follows:
> >
> > $ ./perf script report flamegraph
> > =================================================================
> > ==227640==ERROR: LeakSanitizer: detected memory leaks
> >
> > <SNIP unrelated>
> >
> > Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
> >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> >     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> >     #2 0x7f999e in evlist__new /home/user/linux/tools/perf/util/evlist.c:77:26
> >     #3 0x8ad938 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3797:20
> >     #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > Indirect leak of 568 byte(s) in 1 object(s) allocated from:
> >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> >     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> >     #2 0x80ce88 in evsel__new_idx /home/user/linux/tools/perf/util/evsel.c:268:24
> >     #3 0x8aed93 in evsel__new /home/user/linux/tools/perf/util/evsel.h:210:9
> >     #4 0x8ae07e in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3853:11
> >     #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > Indirect leak of 264 byte(s) in 1 object(s) allocated from:
> >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> >     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> >     #2 0xbe3e70 in xyarray__new /home/user/linux/tools/lib/perf/xyarray.c:10:23
> >     #3 0xbd7754 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:361:21
> >     #4 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
> >     #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > Indirect leak of 32 byte(s) in 1 object(s) allocated from:
> >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> >     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> >     #2 0xbd77e0 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:365:14
> >     #3 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
> >     #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > Indirect leak of 7 byte(s) in 1 object(s) allocated from:
> >     #0 0x4b8207 in strdup (/home/user/linux/tools/perf/perf+0x4b8207)
> >     #1 0x8b4459 in evlist__set_event_name /home/user/linux/tools/perf/util/header.c:2292:16
> >     #2 0x89d862 in process_event_desc /home/user/linux/tools/perf/util/header.c:2313:3
> >     #3 0x8af319 in perf_file_section__process /home/user/linux/tools/perf/util/header.c:3651:9
> >     #4 0x8aa6e9 in perf_header__process_sections /home/user/linux/tools/perf/util/header.c:3427:9
> >     #5 0x8ae3e7 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3886:2
> >     #6 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #7 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #8 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #9 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #10 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #11 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #12 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #13 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > SUMMARY: AddressSanitizer: 3728 byte(s) leaked in 7 allocation(s).
> >
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/util/session.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index e59242c361ce..c36464d94387 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -301,8 +301,11 @@ void perf_session__delete(struct perf_session *session)
> >         perf_session__release_decomp_events(session);
> >         perf_env__exit(&session->header.env);
> >         machines__exit(&session->machines);
> > -       if (session->data)
> > +       if (session->data) {
> > +               if (perf_data__is_read(session->data))
> > +                       evlist__delete(session->evlist);
> >                 perf_data__close(session->data);
> > +       }
> >         free(session);
> >  }
> >
> > --
> > 2.31.1
> >
> 

