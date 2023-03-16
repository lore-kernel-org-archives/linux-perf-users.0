Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223ADC6FD19
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Mar 2023 09:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCPJEd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Mar 2023 05:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCPJEb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Mar 2023 05:04:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20146A6BF3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Mar 2023 02:04:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ix20so1009677plb.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Mar 2023 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678957466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gA9ngMsK2QqV6GNOg3N1OVWrm+Y5H6myCF2XWViZh0c=;
        b=iXswbYyx/yXV3+loFLDtC3IM7JWQPBjZEBjlcb/KL7WkFet28j6LFlERymBzJoF3Cg
         66uDMQsIvgkZR0AIjpThl/fWCcNgJ2XMbyiVPcocJ/bn67QT4JSFtqR2tiUtBWvLFSQD
         cTL4Pk6ZaWDTpWgrY6OJH9xh8Z1498HDqdMNg8dbkqKraMrSSBxBibuMbtR5q3I2vn8Z
         nBn1Z+sncBLTheDLwfzrWSkG7kDB1Z+Gh8Xi9x/cbe5jFaK0+ylqkn++PYD890zS/xs7
         FKr4qbYTOcTgPD2qWPPZ8TTkHrgKveaQ8oSg7EMGpaX+lcjazHLsrolWupuYLTsMSHv0
         2R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678957466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA9ngMsK2QqV6GNOg3N1OVWrm+Y5H6myCF2XWViZh0c=;
        b=rS8ft73x5dSEGHpMQ8B9vOQGqPOOGrhPQ4+0IJeutwtjmtGks5P7XVhaM098UQMpvU
         upPvJQonlHaafsDJBnIZQkYmUr9sOkJWjSvvI6eAP6og10l0cguWJ7JaiPGhj4lIyPIy
         psGKbxPAq4Qh+V6gbdRWUiv0hhvyfPFtpBQuo1FRAgmJwWA30Xt91DRww8CQAE3ZEWCr
         QakEeLhanfPr8mTvQRsRFmRj7pvfI8IqyiV2ddAmHQ79B5GG0Wf1Z4CoLCQcVBIxmQP4
         w9jj74wgS23m0/mYZMZnLNukXmN+Kvi7hOfGfTPYzwJAuqqWebHJBJQ5f226HYvSnWkp
         gSYA==
X-Gm-Message-State: AO0yUKWPF1oq9Aa5tKiMV+KFj6d+z9QfuJHzz6GwKgbO8ulM8O2qSzfd
        4n5frwokGW3UFD+Ehec2KkUCzg==
X-Google-Smtp-Source: AK7set/PDD0TXwqIJ52TLM2li8kD/FsPw4ErOFGFac4bLFRuFCzASzlwsE+vgoY0DIpnSQE4/9Wulg==
X-Received: by 2002:a17:902:f109:b0:19e:8bfe:7d68 with SMTP id e9-20020a170902f10900b0019e8bfe7d68mr2110652plb.11.1678957466436;
        Thu, 16 Mar 2023 02:04:26 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001a04027e0e0sm5037394plr.258.2023.03.16.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 02:04:26 -0700 (PDT)
Date:   Thu, 16 Mar 2023 17:04:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 11/16] perf kvm: Use histograms list to replace cached
 list
Message-ID: <20230316090418.GA2665235@leoy-yangtze.lan>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <20230315145112.186603-12-leo.yan@linaro.org>
 <CAM9d7chSKPxMHzpKZ92xGZ+XmLpd2q2EJwMuszosXu_FO4_dgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chSKPxMHzpKZ92xGZ+XmLpd2q2EJwMuszosXu_FO4_dgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 16, 2023 at 12:42:53AM -0700, Namhyung Kim wrote:

[...]

> >  static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
> >                                                struct event_key *key,
> >                                                struct perf_sample *sample)
> >  {
> >         struct kvm_event *event;
> > -       struct list_head *head;
> > +       struct hist_entry *he;
> > +       struct kvm_info *ki;
> >
> >         BUG_ON(key->key == INVALID_KEY);
> >
> > -       head = &kvm->kvm_events_cache[kvm_events_hash_fn(key->key)];
> > -       list_for_each_entry(event, head, hash_entry) {
> > -               if (event->key.key == key->key && event->key.info == key->info)
> > -                       return event;
> > +       ki = zalloc(sizeof(*ki));
> > +       if (!ki) {
> > +               pr_err("Failed to allocate kvm info\n");
> > +               return NULL;
> >         }
> >
> > -       event = kvm_alloc_init_event(kvm, key, sample);
> > -       if (!event)
> > +       kvm->events_ops->decode_key(kvm, key, ki->name);
> > +       he = hists__add_entry_ops(&kvm_hists.hists, &kvm_ev_entry_ops,
> > +                                 &kvm->al, NULL, NULL, NULL, ki, sample, true);
> 
> The hists__add_entry{,_ops} can return either a new entry
> or an existing one.  I think it'd leak the 'ki' when it returns
> the existing one.  You may deep-copy it in hist_entry__init()
> and always free the 'ki' here.

Thanks for pointing out this, Namhyung.  I will fix it.

@Arnaldo, do you want me to send an appending patch, or will you drop
this patch series from your branch so I send a new patch set?

> Another thought on this.  Lots of fields in the hist_entry are
> not used for kvm.  We might split the hist_entry somehow
> so that we can use unnecessary parts only.  But that could
> be a future project. :)

Yeah, I found now hist_entry contains many fields
(branch_info/mem_info/kvm_info/block_info); we can consider to
refactor the struct hist_entry to use an abstract pointer to refer
tool's specific data, this could be easily extend hist_entry to
support more tools.

Thanks,
Leo
