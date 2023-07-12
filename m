Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED4EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 17:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjGLREM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGLREL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 13:04:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048BB1BD5
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 10:04:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so13651cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689181449; x=1691773449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqtCYATG8ChMapzp5kNLa9Py9zbnEsVcqTU7Ga9LoGc=;
        b=OqdAti8OKkViVwVuE8lSLXuosWAZC4YxyaEzBVjKFo6TVWyxahb0+Hswoyt1XV482L
         w8pxK2aWUUBMLj4T7NywMW3+OpubE1uliG+eQFEjzQaG7QRN5ky835S29FcwAb1EmI1R
         6/afyR0w9CQSJqZyqvndjhAf0bKkxSE2SvMpHkGqk5kCCfDdtwo38tUKxCMyWj/kitw7
         UA8WIl+e7xIjlqIOZho234gBXDEtuVYh4CKKHOMINX5G0LotYdDP5yqvVXXSrFXaqsyA
         fvbCwzAqPGDVL4GrHTSHm8+Wf+sMcvW27MR5zixM2vThLjHJBDhAsxgpRPlKtxyd90pX
         QcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181449; x=1691773449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqtCYATG8ChMapzp5kNLa9Py9zbnEsVcqTU7Ga9LoGc=;
        b=OkSvztM0AjQFYNrQvOKx1EkYGAYhOWisVPYcsbgQbXJpltck9Q2AODbY/YBAca/v8e
         t+wiognFTy2LKBHiwShWGByxFJSkzo8+DcrR3DBMe975B/xEGSurOTsItiULMJMU1NwW
         lsypq4bFXS7O2JSy8k5L9clIBatZeea88q599M/pDETaOncMN+37kpJcuwtQN59sFUxT
         PDUH58UVNyhu4zu3rrU78be4hR5VJVzTp9S5yzMfZ40ZsjtAoA0C1dnKIzJgnctXU0RG
         xIRw9ZZ/9xpQXruWIeQpYfse3sneLGB2ZL3oRCEpPOd/ZiywpNrhvKECKRctHsIADRrk
         Kjsg==
X-Gm-Message-State: ABy/qLad46AvxOH6rPCD/cgZMq+tDeV2bind/+ErFHHbK7JY6JwrSv+O
        /TgA2xbLwTGkL+/Lx0ZupnhFJVbYvU18tLFp9815Ag==
X-Google-Smtp-Source: APBJJlFi8FpP+M9rLTGg/d93Gu+4o83eJViGV5QjH1U0xG4l7m9dxCrVG8t2hJhKXb2BrrEQEjKHZx9hSpIhKmCwRik=
X-Received: by 2002:a05:622a:1805:b0:3ef:3361:75d5 with SMTP id
 t5-20020a05622a180500b003ef336175d5mr281741qtc.11.1689181449011; Wed, 12 Jul
 2023 10:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <ba55bf712cc27494635ca0bb23a21b42529c9327.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fUqKZkuODXTez+Dk+RqTmh+NaeRBun65onG-yByUJOnVA@mail.gmail.com>
In-Reply-To: <CAP-5=fUqKZkuODXTez+Dk+RqTmh+NaeRBun65onG-yByUJOnVA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:03:57 -0700
Message-ID: <CAP-5=fW0DT+JkU07K8brv2O_T6=hTM3SQMoji0o2rnsF6w+Y_Q@mail.gmail.com>
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

On Wed, Jul 12, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Jul 10, 2023 at 4:10=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.c=
om> wrote:
> >
> > The script takes in a sample event dictionary(param_dict) and retrieves
> > relevant data such as time stamp, PID, TID, thread name. Also start tim=
e
> > is defined.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../perf/scripts/python/firefox-gecko-converter.py  | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/too=
ls/perf/scripts/python/firefox-gecko-converter.py
> > index 5b342641925c..765f1775cee5 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -21,8 +21,19 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> >  from perf_trace_context import *
> >  from Core import *
> >
>
> It'd be nice to have a comment here, perhaps:
> # The time stamp from the first of the time ordered events.
>
> > +start_time =3D None
> > +
> >  def trace_end():
> >         pass
> >
> >  def process_event(param_dict):
> > -       pass
> > +       global start_time
> > +       # Extract relevant information from the event parameters. The e=
vent parameters
> > +       # are in a dictionary:
> > +       time_stamp =3D (param_dict['sample']['time'] // 1000) / 1000
> > +       pid =3D param_dict['sample']['pid']
> > +       tid =3D param_dict['sample']['tid']
> > +       thread_name =3D param_dict['comm']
> > +
> > +       # Assume that start time is the time of the first event.
> > +       start_time =3D time_stamp if not start_time else start_time
>
> I appreciate that this is one line, but it takes some getting your
> head around that start_time is being assigned to itself in the common
> case. I think this would be more readable as:
>
> if not start_time:
>   start_time =3D time_stamp

I believe the events are guaranteed time ordered in perf script. The
ordered_event logic handles this, but I likely haven't got a full
grasp on all the corners of it. You can always assert the behavior
(comments with guarantees :-) ):

assert start_time <=3D time_stamp, "Events aren't time ordered"

Thanks,
Ian

> Thanks,
> Ian
>
> > --
> > 2.34.1
> >
