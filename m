Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ECAC433ED
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Apr 2021 13:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195AA6147F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Apr 2021 13:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhD3NyR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Apr 2021 09:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhD3NyQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Apr 2021 09:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619790808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8ly7qQwy/5n3qSgrVVo5Kip/nOatMjzGboAbDo2OtM=;
        b=Tk2kqqTbb2On0TO/TXmIgaYIp4XnSVXoMl9uSY7DCCNTF1z86kl9JH4R45UCulk95fRyb5
        ILzpnA8tBNYh1GMudcr8l1b5qkZY4oqn01z4pVOR76YnSrHSWTzGJYcW//JCDuU0t2b2EC
        B9MD/LlG3ewoxaoZo9Y5bUNT6cFTiGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-dMUFcrlrO4GulQeO9oTrlg-1; Fri, 30 Apr 2021 09:53:26 -0400
X-MC-Unique: dMUFcrlrO4GulQeO9oTrlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554E19F92E;
        Fri, 30 Apr 2021 13:53:25 +0000 (UTC)
Received: from Diego (unknown [10.40.208.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12B875C1A3;
        Fri, 30 Apr 2021 13:53:23 +0000 (UTC)
Date:   Fri, 30 Apr 2021 15:53:21 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     Jiri Olsa <jolsa@redhat.com>, acme@redhat.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: enable libtraceevent dynamic linking
In-Reply-To: <YIwGDanvkoovICay@kernel.org>
Message-ID: <alpine.LRH.2.20.2104301552330.10640@Diego>
References: <20210428092023.4009-1-mpetlan@redhat.com> <YImNh9SFs+Vr2EFc@krava> <alpine.LRH.2.20.2104301450540.10640@Diego> <YIwGDanvkoovICay@kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 30 Apr 2021, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 30, 2021 at 02:59:00PM +0200, Michael Petlan escreveu:
> > On Wed, 28 Apr 2021, Jiri Olsa wrote:
> > > On Wed, Apr 28, 2021 at 11:20:23AM +0200, Michael Petlan wrote:
> > > 
> > > SNIP
> > > 
> > > >  unexport LC_ALL
> > > > @@ -309,7 +311,6 @@ endif
> > > >  
> > > >  LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
> > > >  export LIBTRACEEVENT
> > > > -
> > > >  LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
> > > >  
> > > >  #
> > > > @@ -374,12 +375,15 @@ endif
> > > >  
> > > >  export PERL_PATH
> > > >  
> > > > -PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
> > > > +PERFLIBS = $(LIBAPI) $(LIBSUBCMD) $(LIBPERF)
> > > >  ifndef NO_LIBBPF
> > > >    ifndef LIBBPF_DYNAMIC
> > > >      PERFLIBS += $(LIBBPF)
> > > >    endif
> > > >  endif
> > > > +ifndef LIBTRACEEVENT_DYNAMIC
> > > > +  PERFLIBS += $(LIBTRACEEVENT)
> > > > +endif
> > > 
> > > there's also install-traceevent-plugins target called during install,
> > > which should be skipped for LIBTRACEEVENT_DYNAMIC 
> > 
> > Oh, didn't notice that. Thanks.
> > 
> > However, it seems that's not all what we miss in the patch.
> > Seems that libtraceevent-dynamic-list should be also taken
> > from external libtraceevent, when linked dynamically, shouldn't
> > it.
> 
> Please send patches on top of what you already sent, that I have already
> merged and sent upstream, since it is opt-in.

OK, this is great. I can already use the patch downstream, and polish it
later.
Thank you!

> 
> - Arnaldo
> 
> 

