Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16521C433ED
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40696143A
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 14:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhEGOKq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 May 2021 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbhEGOKq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 May 2021 10:10:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4822EC061761
        for <linux-perf-users@vger.kernel.org>; Fri,  7 May 2021 07:09:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l14so9413270wrx.5
        for <linux-perf-users@vger.kernel.org>; Fri, 07 May 2021 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyBhc6rBUidk9fckB921cawm6COrrhDw9yptYBXeB08=;
        b=yhyDuMajOEp+/jLFqX3mTf3rRlJQj2lzuJ9WDv/H6r5U6M3XTK1T5KlxnD7zpI2QM0
         Ymqhw5B0gON6035WLc0pJBhVXLXtd1efUZcWI1eiJQfYMWWthN9ICGdKTR6HBTKp4gAO
         oLl8FA61SsFRICKsdZBHU6QQpHLUlm/w3grwvObuhXFEzUqh6nSFxtvBbAL5GBNhn8AC
         WV0RDmcgQJamU7PPRSta4MuN6wZs+RiQx1WqZIVjW1WzFde6GA2QgD0Gppx1zLT9OxwD
         90CwCxhy+S3FSx2ky5WlYo3efmtLx4DKXPYa54AHkcpoB8xI8QgJaMUDsB9xmJyOktic
         IdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyBhc6rBUidk9fckB921cawm6COrrhDw9yptYBXeB08=;
        b=SCtzbrSceZPja9rX4W2RpRTfGq7W6m9vlI8pYqUCUQffymZojOCFeKfbBcWK58YzPh
         zb0fGP+mK8hVfV1N0AwyzzlXb0eqvmFwtZx3QGPagCLgLbjs+6JLl3v77k9AzWjLAJRn
         j0TLcXLqxGlEZlyGJW6GmYe6GcpH35Jnt3ik9SpTUh3jfx4pEPixcXHved0Vp+MZhRJk
         5eqSAzGefr/zlPJpychNn2eqCod4BVpbdbbEZmoTcztJS7huDXiW8Y1NlbH5uMCIjuLW
         dkoC8Ob1Xis6Rd9AFWsGXt3jShK5FZJ83Fo6Ll2FyKKZIkcedZGA7gjSe992args9IT+
         Pq6Q==
X-Gm-Message-State: AOAM530sX32Z9OZF2QvwW4y1+Hv0xkWvFTJ9rKKGIKfkQYYOvI9PnbYN
        1Mdp+qkrR4g6uC8dEtFsGzxGewqk9/truoTVzW5vDQ==
X-Google-Smtp-Source: ABdhPJx4DxQvj+MD3yhpWJIP/lYv+aGZTWECzDz68o4y4h51eutREcAAY+RS4S4Qptinpm4w9BycaQxX9V32etrPEiM=
X-Received: by 2002:a05:6000:188b:: with SMTP id a11mr12155927wri.275.1620396584978;
 Fri, 07 May 2021 07:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210507095814.17933-1-james.clark@arm.com> <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
In-Reply-To: <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 7 May 2021 15:09:34 +0100
Message-ID: <CAJ9a7VjAvr9uKYqo9VJhFRB74vt6Jxf0G+Fm2OFm-dxAVdbpsw@mail.gmail.com>
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
To:     James Clark <james.clark@arm.com>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>, branislav.rankov@arm.com,
        Denis Nikitin <denik@chromium.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

1) Not sure about this particular target - but previously all 0
timestamps have been the result of not enabling a clock or the
coresight timestamp generator.

2) Given that you can synthesise timestamps when all the values are
all 0 - does this not imply that they could be synthesised when they
are not present at all?

Cheers

Mike

On Fri, 7 May 2021 at 11:02, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 07/05/2021 12:58, James Clark wrote:
> > There is an intermittent issue on Trogdor devices that
> > results in all Coresight timestamps having a value of zero.
>
> I've attached a file here that has the issue. From the dump you
> can see the zero timestamps:
>
>         Idx:69; ID:10;  I_TIMESTAMP : Timestamp.; Updated val = 0x0
>         Idx:71; ID:10;  I_ATOM_F1 : Atom format 1.; E
>         Idx:72; ID:10;  I_ADDR_S_IS0 : Address, Short, IS0.; Addr=0xFFFFFFE723C65824 ~[0x5824]
>
> This doesn't have an impact on decoding as they end up being
> decoded in file order as in with timeless mode.
>
> James
>
> > Because zero is currently treated as "not found" rather
> > than "found but zero", this breaks the decoding flow
> > when it would otherwise work.
> >
> > This patch adds an out parameter and return code so
> > the difference between zero and non-existent timestamps
> > can be determined.
> >
> > There is also a change to fix an underflow.
> >
> > Although this is a workaround, the change is technically
> > a valid way of writing the cs_etm__etmq_get_timestamp()
> > function. It could have been written similarly to this
> > without trying to work around this issue, so it's no less
> > correct. But, because it's a workaround to a problem
> > elsewhere, I will submit this as an RFC for feedback.
> >
> > This patch applies on top of the "[PATCH v2 0/2] perf
> > cs-etm: Set time on synthesised samples to preserve ordering"
> > patchset.
> >
> > Co-developed-by: Denis Nikitin <denik@chromium.org>
> > Signed-off-by: Denis Nikitin <denik@chromium.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  5 ++++-
> >  tools/perf/util/cs-etm.c                      | 22 +++++++++----------
> >  2 files changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index b01d363b9301..947e44413c6e 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -320,7 +320,10 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
> >        * which instructions started by subtracting the number of instructions
> >        * executed to the timestamp.
> >        */
> > -     packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> > +     if (packet_queue->instr_count >= elem->timestamp)
> > +             packet_queue->cs_timestamp = 0;
> > +     else
> > +             packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> >       packet_queue->next_cs_timestamp = elem->timestamp;
> >       packet_queue->instr_count = 0;
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index e5c1a1b22a2a..1969921c406a 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -210,13 +210,14 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
> >       etmq->pending_timestamp_chan_id = trace_chan_id;
> >  }
> >
> > -static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
> > +static int cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
> > +                                   u64 *timestamp,
> >                                     u8 *trace_chan_id)
> >  {
> >       struct cs_etm_packet_queue *packet_queue;
> >
> >       if (!etmq->pending_timestamp_chan_id)
> > -             return 0;
> > +             return -ENODATA;
> >
> >       if (trace_chan_id)
> >               *trace_chan_id = etmq->pending_timestamp_chan_id;
> > @@ -224,13 +225,15 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
> >       packet_queue = cs_etm__etmq_get_packet_queue(etmq,
> >                                                    etmq->pending_timestamp_chan_id);
> >       if (!packet_queue)
> > -             return 0;
> > +             return -ENODATA;
> >
> >       /* Acknowledge pending status */
> >       etmq->pending_timestamp_chan_id = 0;
> >
> >       /* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
> > -     return packet_queue->cs_timestamp;
> > +     if (timestamp)
> > +             *timestamp = packet_queue->cs_timestamp;
> > +     return 0;
> >  }
> >
> >  static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
> > @@ -864,11 +867,10 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
> >                * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
> >                * the timestamp calculation for us.
> >                */
> > -             cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
> > -
> > -             /* We found a timestamp, no need to continue. */
> > -             if (cs_timestamp)
> > +             if (!cs_etm__etmq_get_timestamp(etmq, &cs_timestamp, &trace_chan_id)) {
> > +                     /* We found a timestamp, no need to continue. */
> >                       break;
> > +             }
> >
> >               /*
> >                * We didn't find a timestamp so empty all the traceid packet
> > @@ -2286,9 +2288,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
> >               if (ret)
> >                       goto out;
> >
> > -             cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
> > -
> > -             if (!cs_timestamp) {
> > +             if (cs_etm__etmq_get_timestamp(etmq, &cs_timestamp, &trace_chan_id)) {
> >                       /*
> >                        * Function cs_etm__decode_data_block() returns when
> >                        * there is no more traces to decode in the current
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
