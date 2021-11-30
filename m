Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684FAC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Nov 2021 18:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbhK3SSp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Nov 2021 13:18:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245371AbhK3SSn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Nov 2021 13:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638296124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y0D83E+cNuncrGmthDykUEYreLlJf9PXpFpFy6oL8G4=;
        b=Zp8A0njKRoJfpairmBeIKBqiUzoNjKBwgJRMZ2Li/D4zKlbOQQsTbsMYF4f55nSzxOzhyc
        yZH81KIQ4t2xZyb72sWWbuzRpCMshxcFocWAJlZDAtN+PLNFpHcN3271pbzSAtHQpciE+s
        8B4cY4SyTlDXKPAf6+WGSnYOeK1LJgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-X2rDXp03MbSJNlMC8U7PWw-1; Tue, 30 Nov 2021 13:15:22 -0500
X-MC-Unique: X2rDXp03MbSJNlMC8U7PWw-1
Received: by mail-wm1-f69.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso10846713wmc.2
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Nov 2021 10:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0D83E+cNuncrGmthDykUEYreLlJf9PXpFpFy6oL8G4=;
        b=InRgiHWs2cJLacGZ0nt31w59SbuLXy+W3WnlBMCZDD1z4McJ+cDFvnfl6BXDrsmDEC
         YnCsvz6IzDphQn/hI4vRj+9bLjtRtw4WH0z/FblMLmNjrt9WmUPHZxn4NccD7iERf3Lr
         chwTUsk6AXYZ+emmEOIGBLIz72LiVTkC/871Ti/93JrgFh99O65ryYjZtXb2kGyX4Qnk
         GABpVArz9zZiD5xDRNDxCLQbQmHTuzCfhzMRHOGfYk3YIwfUJ7aTHq4+UD85y54Kzp/I
         0x14WEL5uYCFefq7wL78TTeZ0rTBmW/wN68oarVmxBRJX7gACmAhm0FQSTki7ALLgtGc
         D8Ow==
X-Gm-Message-State: AOAM531K98S0Mx06WRNe6KhE7hq8XkMgYJZC2ASKVZGzyWaYmQzmsdMD
        9qIR1rszeefx6eBU0iSgOMfcToeoI71K7TEZ5kwYGEkRcg1DQnduSFJ9CWbPvy8prf9K5zUSNbD
        uV+hII3Vgy5UOQhX9JRKZPx8tb565lw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr379464wmk.92.1638296121324;
        Tue, 30 Nov 2021 10:15:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJOfgIgumC5g74zQIlaoVNpamCUEIoCBerSrxJ7TK28QsNQXxRyH3lzwA87n0HLFsyC3Og3Q==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr379437wmk.92.1638296121134;
        Tue, 30 Nov 2021 10:15:21 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g16sm3959688wmq.20.2021.11.30.10.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 10:15:20 -0800 (PST)
Date:   Tue, 30 Nov 2021 19:15:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf header: Fix memory leaks
Message-ID: <YaZqN5UQfhBmgznT@krava>
References: <20211118201730.2302927-1-irogers@google.com>
 <YaOkbojVb2gZtfCk@krava>
 <CAP-5=fVRE8dcDtivYaAm=DQze4d2966X7oWTWVzstzWeC-xeSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVRE8dcDtivYaAm=DQze4d2966X7oWTWVzstzWeC-xeSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 29, 2021 at 03:38:28PM -0800, Ian Rogers wrote:
> On Sun, Nov 28, 2021 at 7:47 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Nov 18, 2021 at 12:17:30PM -0800, Ian Rogers wrote:
> > > These leaks were found with leak sanitizer running "perf pipe recording
> > > and injection test". In pipe mode feat_fd may hold onto an events struct
> > > that needs freeing. When string features are processed they may
> > > overwrite an already created string, so free this before the overwrite.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/header.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index 79cce216727e..e3c1a532d059 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -2321,6 +2321,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
> > >  #define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
> > >  static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
> > >  {\
> > > +     free(ff->ph->env.__feat_env);                \
> >
> > hm, how is this set before this callback is triggered?
> 
> I see it for cpuid which is initially set in:
> #0  perf_env__read_cpuid (env=0x62b000007240) at util/env.c:363
> #1  0x0000555556325153 in perf_env__cpuid (env=0x62b000007240) at util/env.c:456
> #2  0x00005555564002ff in evlist__init_trace_event_sample_raw

ok, I forgot we do this one, thanks for explanation

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka


> (evlist=0x61e000000080) at util/sample-raw.c:17
> #3  0x00005555563f01f4 in __perf_session__new (data=0x7fffffffb8b0,
> repipe=false, repipe_fd=-1, tool=0x7fffffffbaa0)
>     at util/session.c:228
> #4  0x000055555615f26b in perf_session__new (data=0x7fffffffb8b0,
> tool=0x7fffffffbaa0) at util/session.h:70
> #5  0x000055555616d991 in cmd_report (argc=0, argv=0x7fffffffe468) at
> builtin-report.c:1408
> #6  0x00005555562f36b8 in run_builtin (p=0x5555586bacd0
> <commands+240>, argc=5, argv=0x7fffffffe468) at perf.c:313
> #7  0x00005555562f3c11 in handle_internal_command (argc=5,
> argv=0x7fffffffe468) at perf.c:365
> #8  0x00005555562f3fce in run_argv (argcp=0x7fffffffe240,
> argv=0x7fffffffe250) at perf.c:409
> #9  0x00005555562f47bd in main (argc=5, argv=0x7fffffffe468) at perf.c:539
> 
> And then overwritten causing the leak:
> #0  0x00005555563b965a in process_cpuid (ff=0x7fffffffad50, data=0x0)
> at util/header.c:2333
> #1  0x00005555563c53d2 in perf_event__process_feature
> (session=0x62b000007200, event=0x621000006500) at util/header.c:4144
> #2  0x000055555615fdef in process_feature_event
> (session=0x62b000007200, event=0x621000006500) at builtin-report.c:230
> #3  0x00005555563fa033 in perf_session__process_user_event
> (session=0x62b000007200, event=0x621000006500, file_offset=868)
>     at util/session.c:1668
> #4  0x00005555563fae08 in perf_session__process_event
> (session=0x62b000007200, event=0x621000006500, file_offset=868)
>     at util/session.c:1803
> #5  0x00005555563fc4e6 in __perf_session__process_pipe_events
> (session=0x62b000007200) at util/session.c:2044
> #6  0x00005555563ff005 in perf_session__process_events
> (session=0x62b000007200) at util/session.c:2418
> #7  0x000055555616508a in __cmd_report (rep=0x7fffffffbaa0) at
> builtin-report.c:940
> #8  0x000055555616f5c9 in cmd_report (argc=0, argv=0x7fffffffe468) at
> builtin-report.c:1629
> #9  0x00005555562f36b8 in run_builtin (p=0x5555586bacd0
> <commands+240>, argc=5, argv=0x7fffffffe468) at perf.c:313
> #10 0x00005555562f3c11 in handle_internal_command (argc=5,
> argv=0x7fffffffe468) at perf.c:365
> #11 0x00005555562f3fce in run_argv (argcp=0x7fffffffe240,
> argv=0x7fffffffe250) at perf.c:409
> #12 0x00005555562f47bd in main (argc=5, argv=0x7fffffffe468) at perf.c:539
> 
> Thanks,
> Ian
> 
> > jirka
> >
> > >       ff->ph->env.__feat_env = do_read_string(ff); \
> > >       return ff->ph->env.__feat_env ? 0 : -ENOMEM; \
> > >  }
> > > @@ -4124,6 +4125,7 @@ int perf_event__process_feature(struct perf_session *session,
> > >       struct perf_record_header_feature *fe = (struct perf_record_header_feature *)event;
> > >       int type = fe->header.type;
> > >       u64 feat = fe->feat_id;
> > > +     int ret = 0;
> > >
> > >       if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
> > >               pr_warning("invalid record type %d in pipe-mode\n", type);
> > > @@ -4141,11 +4143,13 @@ int perf_event__process_feature(struct perf_session *session,
> > >       ff.size = event->header.size - sizeof(*fe);
> > >       ff.ph = &session->header;
> > >
> > > -     if (feat_ops[feat].process(&ff, NULL))
> > > -             return -1;
> > > +     if (feat_ops[feat].process(&ff, NULL)) {
> > > +             ret = -1;
> > > +             goto out;
> > > +     }
> > >
> > >       if (!feat_ops[feat].print || !tool->show_feat_hdr)
> > > -             return 0;
> > > +             goto out;
> > >
> > >       if (!feat_ops[feat].full_only ||
> > >           tool->show_feat_hdr >= SHOW_FEAT_HEADER_FULL_INFO) {
> > > @@ -4154,8 +4158,9 @@ int perf_event__process_feature(struct perf_session *session,
> > >               fprintf(stdout, "# %s info available, use -I to display\n",
> > >                       feat_ops[feat].name);
> > >       }
> > > -
> > > -     return 0;
> > > +out:
> > > +     free_event_desc(ff.events);
> > > +     return ret;
> > >  }
> > >
> > >  size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
> > > --
> > > 2.34.0.rc2.393.gf8c9666880-goog
> > >
> >
> 

