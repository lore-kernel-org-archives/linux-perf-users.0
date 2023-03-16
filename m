Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3A2C6FD19
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Mar 2023 10:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCPKOA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Mar 2023 06:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCPKNf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Mar 2023 06:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB9BBB0D;
        Thu, 16 Mar 2023 03:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A27561EFB;
        Thu, 16 Mar 2023 10:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39F2C433D2;
        Thu, 16 Mar 2023 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678961585;
        bh=4hBFXp7kq5jpTGTR3V2fVBamGY+6l1AyRs1M+Mn24L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7poubKxLaDvDEpQTohrR5kCeYHrEk8MrplJL43zaqPKRg+mAKueLfLvSpfxXGKD7
         CpMtf6rSK1nOTmL4DXxh3P8lOBbCAM0HrGCetye4OhA+VIfSj8BHXpDTc236h24Eg8
         NzNgMa8E3goacCWVdPfyxIRsbHiwWwKaD3te4kAyzowQf7/6+tH70YB5tjafpdK6HE
         vf+7EF+wWCrvDtZAmpc58IY7xjYXn7G+K+fPUu67nOvkDRpfYp/YpVhmcPau8n71xl
         K/Wm5KcJTHWsbYa5NAgSkA78eV+8Tuamt2Aw+NlqfvP5sG7hmuAu/mNN1IcK7B21Js
         LFb/lAaSfp6Fw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CDB34049F; Thu, 16 Mar 2023 07:13:02 -0300 (-03)
Date:   Thu, 16 Mar 2023 07:13:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
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
Message-ID: <ZBLrruagawAbxqoz@kernel.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <20230315145112.186603-12-leo.yan@linaro.org>
 <CAM9d7chSKPxMHzpKZ92xGZ+XmLpd2q2EJwMuszosXu_FO4_dgA@mail.gmail.com>
 <20230316090418.GA2665235@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316090418.GA2665235@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Mar 16, 2023 at 05:04:18PM +0800, Leo Yan escreveu:
> On Thu, Mar 16, 2023 at 12:42:53AM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > >  static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
> > >                                                struct event_key *key,
> > >                                                struct perf_sample *sample)
> > >  {
> > >         struct kvm_event *event;
> > > -       struct list_head *head;
> > > +       struct hist_entry *he;
> > > +       struct kvm_info *ki;
> > >
> > >         BUG_ON(key->key == INVALID_KEY);
> > >
> > > -       head = &kvm->kvm_events_cache[kvm_events_hash_fn(key->key)];
> > > -       list_for_each_entry(event, head, hash_entry) {
> > > -               if (event->key.key == key->key && event->key.info == key->info)
> > > -                       return event;
> > > +       ki = zalloc(sizeof(*ki));
> > > +       if (!ki) {
> > > +               pr_err("Failed to allocate kvm info\n");
> > > +               return NULL;
> > >         }
> > >
> > > -       event = kvm_alloc_init_event(kvm, key, sample);
> > > -       if (!event)
> > > +       kvm->events_ops->decode_key(kvm, key, ki->name);
> > > +       he = hists__add_entry_ops(&kvm_hists.hists, &kvm_ev_entry_ops,
> > > +                                 &kvm->al, NULL, NULL, NULL, ki, sample, true);
> > 
> > The hists__add_entry{,_ops} can return either a new entry
> > or an existing one.  I think it'd leak the 'ki' when it returns
> > the existing one.  You may deep-copy it in hist_entry__init()
> > and always free the 'ki' here.
> 
> Thanks for pointing out this, Namhyung.  I will fix it.
> 
> @Arnaldo, do you want me to send an appending patch, or will you drop
> this patch series from your branch so I send a new patch set?
> 
> > Another thought on this.  Lots of fields in the hist_entry are
> > not used for kvm.  We might split the hist_entry somehow
> > so that we can use unnecessary parts only.  But that could
> > be a future project. :)
> 
> Yeah, I found now hist_entry contains many fields
> (branch_info/mem_info/kvm_info/block_info); we can consider to
> refactor the struct hist_entry to use an abstract pointer to refer
> tool's specific data, this could be easily extend hist_entry to
> support more tools.

Since I build tested this already and had the other fixes, I'm pushing
this out to perf-tools-next (and perf/core for a while, for people not
knowing about the new nbranch names) and you can continue from there,
ok?

- Arnaldo
