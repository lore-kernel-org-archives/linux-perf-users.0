Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24110C433B4
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Apr 2021 13:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7F26147E
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Apr 2021 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhD3N3h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Apr 2021 09:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhD3N3g (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Apr 2021 09:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1493261474;
        Fri, 30 Apr 2021 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619789328;
        bh=0khDCsU/c67fsU9slqaWC06eUs5aaUB6TNjAc0+y4FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekK3RRdrMz0CZiSUjLmxf4M5SxQj5LE/EBTYrzWhMU6YdWRzNcdKVo3l5XOMvX6Ni
         vkJwSiRV2tYTMM9PBj+K08Qd78CfSkOYFPIsw+q0yeonpZ9Is6uXePSHc3OSYQkGEf
         fiTwZWuO/LH4Iuoleoms8yhnkwwV+ZQ7B/P3R9UQ41/1Np1G7YHeHhNi/g1mOX/JyF
         288IneStJYL2cq3wLcweb5k2xItI6mBxQAhdK3g7SZzGqwz+KrCNHuGwUPkIzi8+wG
         +yxgAmShfNKVU+RU/It8mKh2HRuHR0UGKmga+c8cEBHWiltRiOm7gxZaJ2WP0CMaUw
         4fd9Ta1Ie5jVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 390954034C; Fri, 30 Apr 2021 10:28:45 -0300 (-03)
Date:   Fri, 30 Apr 2021 10:28:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, acme@redhat.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: enable libtraceevent dynamic linking
Message-ID: <YIwGDanvkoovICay@kernel.org>
References: <20210428092023.4009-1-mpetlan@redhat.com>
 <YImNh9SFs+Vr2EFc@krava>
 <alpine.LRH.2.20.2104301450540.10640@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2104301450540.10640@Diego>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Apr 30, 2021 at 02:59:00PM +0200, Michael Petlan escreveu:
> On Wed, 28 Apr 2021, Jiri Olsa wrote:
> > On Wed, Apr 28, 2021 at 11:20:23AM +0200, Michael Petlan wrote:
> > 
> > SNIP
> > 
> > >  unexport LC_ALL
> > > @@ -309,7 +311,6 @@ endif
> > >  
> > >  LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
> > >  export LIBTRACEEVENT
> > > -
> > >  LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
> > >  
> > >  #
> > > @@ -374,12 +375,15 @@ endif
> > >  
> > >  export PERL_PATH
> > >  
> > > -PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
> > > +PERFLIBS = $(LIBAPI) $(LIBSUBCMD) $(LIBPERF)
> > >  ifndef NO_LIBBPF
> > >    ifndef LIBBPF_DYNAMIC
> > >      PERFLIBS += $(LIBBPF)
> > >    endif
> > >  endif
> > > +ifndef LIBTRACEEVENT_DYNAMIC
> > > +  PERFLIBS += $(LIBTRACEEVENT)
> > > +endif
> > 
> > there's also install-traceevent-plugins target called during install,
> > which should be skipped for LIBTRACEEVENT_DYNAMIC 
> 
> Oh, didn't notice that. Thanks.
> 
> However, it seems that's not all what we miss in the patch.
> Seems that libtraceevent-dynamic-list should be also taken
> from external libtraceevent, when linked dynamically, shouldn't
> it.

Please send patches on top of what you already sent, that I have already
merged and sent upstream, since it is opt-in.

- Arnaldo
