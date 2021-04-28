Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BBBC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 16:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF4C613F8
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 16:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbhD1Qau (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhD1Qau (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 12:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619627405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1dgssnOw+10OAwIm9EomlB/ChOvKbMR2t3+KJa6sKv8=;
        b=D2S+ko1KNvrIKO2XIZHH7fsOQf55L+HTOBN5PUboq01QPDg6sFHUpe+71DvuWweHUTIMPt
        3hfI5Yfcg+i1qkxPID4riY26gmVAKGXFdJaW3fJEYNslAdKWNWSQuwPvegBgputCaT8XHx
        3Vo1Sk5JcmtCgjC4ory+Wjs6x+rm764=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-31Ow8Y4cORK5FDYCvMfbNQ-1; Wed, 28 Apr 2021 12:30:02 -0400
X-MC-Unique: 31Ow8Y4cORK5FDYCvMfbNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78DCD8049C5
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 16:30:01 +0000 (UTC)
Received: from krava (unknown [10.40.193.167])
        by smtp.corp.redhat.com (Postfix) with SMTP id 92AEF5F729;
        Wed, 28 Apr 2021 16:30:00 +0000 (UTC)
Date:   Wed, 28 Apr 2021 18:29:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     acme@redhat.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: enable libtraceevent dynamic linking
Message-ID: <YImNh9SFs+Vr2EFc@krava>
References: <20210428092023.4009-1-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428092023.4009-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 28, 2021 at 11:20:23AM +0200, Michael Petlan wrote:

SNIP

>  unexport LC_ALL
> @@ -309,7 +311,6 @@ endif
>  
>  LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
>  export LIBTRACEEVENT
> -
>  LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
>  
>  #
> @@ -374,12 +375,15 @@ endif
>  
>  export PERL_PATH
>  
> -PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
> +PERFLIBS = $(LIBAPI) $(LIBSUBCMD) $(LIBPERF)
>  ifndef NO_LIBBPF
>    ifndef LIBBPF_DYNAMIC
>      PERFLIBS += $(LIBBPF)
>    endif
>  endif
> +ifndef LIBTRACEEVENT_DYNAMIC
> +  PERFLIBS += $(LIBTRACEEVENT)
> +endif

there's also install-traceevent-plugins target called during install,
which should be skipped for LIBTRACEEVENT_DYNAMIC 

jirka

>  
>  # We choose to avoid "if .. else if .. else .. endif endif"
>  # because maintaining the nesting to match is a pain.  If
> -- 
> 2.18.4
> 

