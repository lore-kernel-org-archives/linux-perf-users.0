Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8857C433B4
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Apr 2021 12:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CD761477
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Apr 2021 12:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhD3M7z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Apr 2021 08:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232202AbhD3M7y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Apr 2021 08:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619787546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/Uqvr137CeLhMatwkfmWdESiwpWr00nLNx9A1ld2wk=;
        b=XuuA4XMTzojeKjDUxlr914odhIy8M4qUCJ4V0c/23oo6kFyPdjZhDmKj+EN1c3LD93HTvZ
        JW4i91obApB0gpC9g4Lili5oMVYQwP+ebVfHo/to01/wsz4ItnCpOI5LBpHApgg5jqN73y
        Mg/JjbQY8PvNvvunUmqwEmWKdgWfx4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-5CFUi7F6OYKejFbZDQWb1w-1; Fri, 30 Apr 2021 08:59:04 -0400
X-MC-Unique: 5CFUi7F6OYKejFbZDQWb1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B678800C7A
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Apr 2021 12:59:03 +0000 (UTC)
Received: from Diego (unknown [10.40.208.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 368A55D767;
        Fri, 30 Apr 2021 12:59:02 +0000 (UTC)
Date:   Fri, 30 Apr 2021 14:59:00 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Jiri Olsa <jolsa@redhat.com>
cc:     acme@redhat.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: enable libtraceevent dynamic linking
In-Reply-To: <YImNh9SFs+Vr2EFc@krava>
Message-ID: <alpine.LRH.2.20.2104301450540.10640@Diego>
References: <20210428092023.4009-1-mpetlan@redhat.com> <YImNh9SFs+Vr2EFc@krava>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 28 Apr 2021, Jiri Olsa wrote:
> On Wed, Apr 28, 2021 at 11:20:23AM +0200, Michael Petlan wrote:
> 
> SNIP
> 
> >  unexport LC_ALL
> > @@ -309,7 +311,6 @@ endif
> >  
> >  LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
> >  export LIBTRACEEVENT
> > -
> >  LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
> >  
> >  #
> > @@ -374,12 +375,15 @@ endif
> >  
> >  export PERL_PATH
> >  
> > -PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
> > +PERFLIBS = $(LIBAPI) $(LIBSUBCMD) $(LIBPERF)
> >  ifndef NO_LIBBPF
> >    ifndef LIBBPF_DYNAMIC
> >      PERFLIBS += $(LIBBPF)
> >    endif
> >  endif
> > +ifndef LIBTRACEEVENT_DYNAMIC
> > +  PERFLIBS += $(LIBTRACEEVENT)
> > +endif
> 
> there's also install-traceevent-plugins target called during install,
> which should be skipped for LIBTRACEEVENT_DYNAMIC 

Oh, didn't notice that. Thanks.

However, it seems that's not all what we miss in the patch.
Seems that libtraceevent-dynamic-list should be also taken
from external libtraceevent, when linked dynamically, shouldn't
it.



> 
> jirka
> 
> >  
> >  # We choose to avoid "if .. else if .. else .. endif endif"
> >  # because maintaining the nesting to match is a pain.  If
> > -- 
> > 2.18.4
> > 
> 

