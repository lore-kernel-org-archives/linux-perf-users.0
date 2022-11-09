Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA9C43219
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 10:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKIKhH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiKIKhF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Nov 2022 05:37:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F31A23B
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Nov 2022 02:37:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y16so25024570wrt.12
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Nov 2022 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qN910yz4n+KoHHfl89Eyw3Yj7RJD/D4SSBWe9fqZjvw=;
        b=DzfKIdie3lRM+yNLHFdXvzEzMhdt/R6KOS4gmFQQ4aNrqSkYKF92I9LKwArZ3UiTJ9
         ZNHMEngjiTy3ajB3j4E3HmvwMDrPNyfSCzUjmKo66tKIDp4KRGEgUGaMIoOjstRoCVRk
         L2P7rPE+/C0HWrLHb2zmyiyurF1rfGUL38jkk1NkHNqbpkek4j7F2tV2JRzaM5a9eYYE
         D//nl//uWo0eY2jDVtQYlh+xcPkOabEczwqD3SJyK1GdxX7+tuTzEeKWUlpQSJnQM7uC
         Vhc9YtSUNQHDIR+56/TZr45P0qmClEdbEVv3xv0fwLQ22uX7zTExZaUTdi3oJMBM6c+F
         bL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN910yz4n+KoHHfl89Eyw3Yj7RJD/D4SSBWe9fqZjvw=;
        b=GEAwtjW1+haq/80PQ8K6jrb2B/W3qE3sAunQJsJpQo7+2qTZS+1sVYvaE/nyDyFEnH
         Q2BCIn8m1zz/TBBrK76+jZGEBxTqTISrCiPM6y4bps/eZwyTD/308teCy890hs/bKNQ9
         +Ld4xCMz0FxQcnpXNyrCECbN5mz6qoCUx/uyisMDkjOoTXxAPFaNoZGVqkgWuVbswG16
         6wGJ4Rpf0UXTccz0MEl/tuhcCvLxINUJQoM6j8PQq1TjVF8sF4turEyqG9GayJN/viCk
         MFvnaXn+Sv3S06JQTJ1/qzXQY/VGLUY6mWvXaRBb5q2I9Jtn4bMNvCAtDL8I4hY8Bccr
         YqVg==
X-Gm-Message-State: ACrzQf0HCSClCP35W3TUJAUo6TsFQ6VG2sfVyS2uz9kCnLJ9MSp9Ljlq
        xrQHPg2m6VbnjenVwFu/+T0=
X-Google-Smtp-Source: AMsMyM5DAnKP508bFR/PDIbRjAakZBgVsBf8ZQnKPeVjqtttdezBKwYx1DKEScWwmGvkpwnkjN+Vjg==
X-Received: by 2002:a5d:6ac6:0:b0:236:84b5:6660 with SMTP id u6-20020a5d6ac6000000b0023684b56660mr38068981wrw.555.1667990223338;
        Wed, 09 Nov 2022 02:37:03 -0800 (PST)
Received: from ddolgov.remote.csb (dslb-094-222-001-087.094.222.pools.vodafone-ip.de. [94.222.1.87])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c3b8f00b003c6c3fb3cf6sm1397956wms.18.2022.11.09.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:37:03 -0800 (PST)
Date:   Wed, 9 Nov 2022 11:37:02 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, jolsa@kernel.org
Subject: Re: [RFC PATCH v1] perf data: Add fields when converting to json
Message-ID: <20221109103702.2q4pjggi3li2z6vt@ddolgov.remote.csb>
References: <20221108190019.19265-1-9erthalion6@gmail.com>
 <CAP-5=fXgO4ai5EvsYHw+_F2FUYqBRkBzXuBOZg_wHK0=_ymgFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXgO4ai5EvsYHw+_F2FUYqBRkBzXuBOZg_wHK0=_ymgFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> On Tue, Nov 08, 2022 at 05:35:28PM -0800, Ian Rogers wrote:
> On Tue, Nov 8, 2022 at 11:00 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> > ---
> >  tools/perf/util/data-convert-json.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> > index 613d6ae82663..d30816eafb2f 100644
> > --- a/tools/perf/util/data-convert-json.c
> > +++ b/tools/perf/util/data-convert-json.c
> > @@ -217,6 +217,26 @@ static int process_sample_event(struct perf_tool *tool,
> >         }
> >         output_json_format(out, false, 3, "]");
> >
> > +       if (sample->raw_data) {
> > +               int i;
> > +               struct tep_format_field **fields;
> > +
> > +               fields = tep_event_fields(evsel->tp_format);
> > +               if (fields != NULL) {
>
> nit: just "if(fields) {" as you did above with sample->raw_data

Thanks for looking into it, will send a new one shortly.
