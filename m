Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726DAC678D4
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 06:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCBGok (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 01:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBGoj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 01:44:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C8265B4
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Mar 2023 22:44:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso2942150pjv.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Mar 2023 22:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmKdVP+gBRY7jyuOkUCQuGrF6aVQncpQvrWF4mkTONM=;
        b=kIw0O9Rpu5fRp/DKA/iL/stqYgDiTaXVyfVqz53BoCh9yHZ0BpZbW3/imowLQQdUj9
         Y2LsSGZGbR5m5vrucN3JabUjJ0EKVQPuPmSwdwrCnL9bC/xLv+MqqJ7N4HuEIi5Sm+cf
         SAlG5CYVzeq5kHokVcoGHAmaAM44e+0CRPVBFI7aq5lC1hwOJioSVGgVIN6K+iq28LD6
         XVfJTRFiBgZibJZI2gGOlRLiBfDdwvrQxgeM/2GPV4h5nip41kxMGodf5lrr1cB6fr6X
         7z9UTKlvWqnvQAIiKmqDwkhQCw9h3P5dMd7UsjEghe3Gmx1ZZ2TKsB6qQ0RT7EZBej3h
         sacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmKdVP+gBRY7jyuOkUCQuGrF6aVQncpQvrWF4mkTONM=;
        b=P0LJocbRzb8KOxnqTWBgtJZBlYEmcTRV+sZVWznAtAfFuldlqbxp5hGyvt/nrqBln4
         86Kzx/LKB23s8exrl+eZ9jkC5g1NzYXoArhtYD2jlrGTYcfwQIm3XoeJyITcbAdXN0VO
         8avjMLn1xzri8GDvtqX9ejwLE46JIBiZzBcsUSms9qm6cTRA4ZIgSAWxgzufqORxlNDi
         Px7F7UK7lcqqj80UsR9KPMWL23NF3pNIgjMKqBjG25n0SVfufhSBYj3yGvJdmPz4Y6IK
         3vXsWkd8dMhTHgCqUyITEbCeVv9L2ul7lI8htqaUAh0HZKW8tqZeY7GPo96E6XtJ4YJf
         v1Mw==
X-Gm-Message-State: AO0yUKUvwgGmf1uGiz3u4a3urtp7LqSZx9E+27iLWAbPA8vmB6ck8Zva
        ZI8XpWnlQGO2v2Y3QAt9YDitzQ==
X-Google-Smtp-Source: AK7set/lHIGLOBWIeAJ51iuslCRJ+hOzIpWs/P6ZSkrtEZvY6H8UhnRL8ZPEmRGMH0DA+J1HOjB1qg==
X-Received: by 2002:a05:6a20:4c1f:b0:9d:efbe:52ae with SMTP id fm31-20020a056a204c1f00b0009defbe52aemr7271338pzb.30.1677739476121;
        Wed, 01 Mar 2023 22:44:36 -0800 (PST)
Received: from leoy-huanghe ([156.146.45.203])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78c58000000b005a87d636c70sm8913003pfd.130.2023.03.01.22.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 22:44:35 -0800 (PST)
Date:   Thu, 2 Mar 2023 14:44:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] perf kvm: Use histograms list to replace cached
 list
Message-ID: <ZABFzPbfEarV0G5N@leoy-huanghe>
References: <20230228115125.144172-1-leo.yan@linaro.org>
 <20230228115125.144172-10-leo.yan@linaro.org>
 <CAM9d7cgXkPw_op7tj7eZE4xP68reO8cDmwpHOa+13C1CSeOOjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgXkPw_op7tj7eZE4xP68reO8cDmwpHOa+13C1CSeOOjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 28, 2023 at 04:03:27PM -0800, Namhyung Kim wrote:

[...]

> > @@ -507,22 +530,26 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
> >                                                struct perf_sample *sample)
> >  {
> >         struct kvm_event *event;
> > -       struct list_head *head;
> > +       struct rb_root_cached *root;
> > +       struct rb_node *nd;
> >
> >         BUG_ON(key->key == INVALID_KEY);
> >
> > -       head = &kvm->kvm_events_cache[kvm_events_hash_fn(key->key)];
> > -       list_for_each_entry(event, head, hash_entry) {
> > +       if (hists__has(&kvm_hists.hists, need_collapse))
> > +               root = &kvm_hists.hists.entries_collapsed;
> > +       else
> > +               root = kvm_hists.hists.entries_in;
> > +
> > +       for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
> > +               struct hist_entry *he = rb_entry(nd, struct hist_entry,
> > +                                                rb_node_in);
> > +
> > +               event = container_of(he, struct kvm_event, he);
> >                 if (event->key.key == key->key && event->key.info == key->info)
> >                         return event;
> 
> This seems inefficient and even unnecessary.  You should find
> the event based on the return value of hist_entry__cmp() from
> the root and go down.
> 
> But I think that's what hists__add_entry_ops() does.  Maybe
> you may need to move the init logic (like init_stats) to the
> kvm_he_zalloc().

Indeed.  I will drop above code and rely on hists__add_entry_ops()
to check if have existed event entry.

Thanks a lot for suggestion!

Leo
