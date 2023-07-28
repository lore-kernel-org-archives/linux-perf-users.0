Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE180C001DE
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjG1Qkr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjG1Qkn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 12:40:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883BA3C3B
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 09:40:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40631c5b9e9so81cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Jul 2023 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690562437; x=1691167237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCIwiRybbqPdL+GA2easp6/q5mEFWhkL8APip1GzAdM=;
        b=iUphQGDCq/P5HhC+B4wUCuShqcKB/O4cys8ksGxGvtLePX7+FMDl4tNiIlgooGBJDx
         U2WHRT0l4ZU8fSGyRypuXxpLDVMdNvQpm6CHSxbVorcJ8Sz3/CAKqRaSuavn0Z4VpxPR
         1LiYZL8Aw29mGThNJlIHO9zgRQr0g7JLfedKs+YgrLYNF8ETIn52a6zgcmjoNTP87VkT
         3kmTuM26TnV5neBSrxUqTCeVixR3g7N0svKUDbFNYKZHPJhYpbiYk3Q4ZvFYutNnkfo4
         Bib3hPVKzfNdI2PjgaWPCFx0rQkZJ2mg4D+cOw+c2fXYcSczcH4YJCG9F0woHQWJWSOc
         s6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562437; x=1691167237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCIwiRybbqPdL+GA2easp6/q5mEFWhkL8APip1GzAdM=;
        b=JX8bl6Zy2+ztwPy79i/J3V2MnUNUDfQ8QauGfjfZzVvX5JqfAlfXd8VIDPl4FivfT5
         9ogzGYk7cVi6xjKr+i8Fx637xTnzQXeWJzvgfFcMszU5x5hoFyuLs3IVAxXhuV5i23X4
         EP9Vvbx4su0Z67wEqOh+Mm3c8b+FmAgW6hPZ5hpUErNtc09v10kEf7hQH0hfxFZjhyma
         /OsF4qPIpMJGiWH9A+o4RCoGP3So0DNxbN8OSQxTXCZN0IShWxip4fjsLtfcjDccTBXp
         n41EL/YgTPCo5TYxK6tHXjRSrddDZk44yf+GKfKF/cdSGtUGIVaKWWNhH9/dVVjxQE+7
         UwwQ==
X-Gm-Message-State: ABy/qLaIJWB9+NZtLZQLbRdVzUlpI/sH2dRk0552Xlv7zZr9uIMRiGoD
        MULfOu10iSA4Sz+z0wy3hdlByeGNkGwaoLYmGLeExQ==
X-Google-Smtp-Source: APBJJlHgM67EtrkE4O/uKl+m1fTY3fGU+3E/kVtkUeSbuYgG0IcBcufA64tWxYrhYYykVVM758vi0LRGrXHA7crs93g=
X-Received: by 2002:a05:622a:15d0:b0:3f8:5b2:aef4 with SMTP id
 d16-20020a05622a15d000b003f805b2aef4mr7604qty.28.1690562437418; Fri, 28 Jul
 2023 09:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-3-yangjihong1@huawei.com> <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
 <993bd68c-c0ec-4960-d3b0-bd2dbda82402@huawei.com>
In-Reply-To: <993bd68c-c0ec-4960-d3b0-bd2dbda82402@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 09:40:25 -0700
Message-ID: <CAP-5=fXmpaKrVLifHh5H7Lf_nhNLGWFS0=CLRT2yHK5guReNGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] perf evlist: Add evlist__findnew_tracking_event() helper
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 20, 2023 at 12:24=E2=80=AFAM Yang Jihong <yangjihong1@huawei.co=
m> wrote:
>
> Hello,
>
> On 2023/7/20 0:44, Ian Rogers wrote:
> > On Fri, Jul 14, 2023 at 8:31=E2=80=AFPM Yang Jihong <yangjihong1@huawei=
.com> wrote:
> >>
> >> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
> >> tracking to the evlist. We may need to search for the dummy event for
> >> some settings. Therefore, add evlist__findnew_tracking_event() helper.
> >>
> >> evlist__findnew_tracking_event() also deal with system_wide maps if
> >> system_wide is true.
> >
> > I'm wondering if we can simplify the naming in the API, we have "dummy
> > event" which makes sense as we literally call the event "dummy",
> > "sideband" which refers to the kind of samples/events the dummy event
> > will record but "tracking" I think tends to get used as a verb rather
> > than a noun. So I think evlist__findnew_tracking_event should be
> > evlist__findnew_dummy_event.
> >
> Uh, from the discussion that followed, it seems that there is no
> consensus yet...
> If there is a clear consensus on whether to use "dummy event" or
> "tracking event", I will change the name of the API.
>
> I think sideband event is equivalent to tracking event (refer
> evsel__config(), tracking events include task, mmap, mmap2, and comm
> sideband events, which are all sideband).
>
> tracking event are instances of dummy event. For example, we create
> another dummy event to record the text poke event of ksymbol (refer perf
> record --kcore).
>
> An evlist contains only one tracking event, but can contain multiple
> dummy events.

Thanks for the feedback. So the tracking event is by definition the
first dummy event in the evlist? What is the purpose of the other
dummy events in this case? Perhaps we can get to an intention
revealing implementation something like:

/** The "tracking event" gathering sideband data is the first dummy
event in the list. */
struct evsel *evlist__findnew_tracking_event(struct evlist *evlist)
{
   struct evsel *dummy =3D evlist__find_first_dummy_event(evlist);

   if (!dummy) {
      dummy =3D evlist__add_dummy(evlist);
   }
   return dummy;
}

But I think the key thing for me is I'm still not sure what is going
on when there are multiple dummy events for you, what are the other
dummy events for other than tracking sideband data?

Thanks,
Ian

>
> Thanks,
> Yang
