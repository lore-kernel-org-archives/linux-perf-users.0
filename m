Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D182BC48BD1
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 20:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBF0613E9
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 20:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFJUtt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 16:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhFJUts (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 16:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623358071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sm+EodhIsFN4o5SQoatoiFjJ9gwBumKEi+RXKBSe9pk=;
        b=THiAFxlLvynb3ipz3ceIi+J9keGs87p2ez78xVn7cgFb/boqQVSSxhJVILTxfaX3D7vrl4
        8hBjtzNU8PWoVTblLHg3f9c/cP3gTY3F5vvGXcdv93Nugj8wBrNO8cLHrg6Ehll8MfMbb/
        P94Xf0stx9QvmJD+yx/2pGl2dgTu5zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-MiyXG1o_NDOV8iQ_ILlPXA-1; Thu, 10 Jun 2021 16:47:50 -0400
X-MC-Unique: MiyXG1o_NDOV8iQ_ILlPXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED2511084F44;
        Thu, 10 Jun 2021 20:47:48 +0000 (UTC)
Received: from krava (unknown [10.40.195.165])
        by smtp.corp.redhat.com (Postfix) with SMTP id B05B95D9C6;
        Thu, 10 Jun 2021 20:47:42 +0000 (UTC)
Date:   Thu, 10 Jun 2021 22:47:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, eranian@google.com,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC PATCH] libtraceevent: Increase libtraceevent logging when
 verbose
Message-ID: <YMJ6bUQ8yXT+uMAF@krava>
References: <20210610060643.595673-1-irogers@google.com>
 <20210610103927.44462e35@oasis.local.home>
 <YMJjMPDKo2IdCC6G@krava>
 <20210610155915.20a252d3@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610155915.20a252d3@oasis.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 10, 2021 at 03:59:15PM -0400, Steven Rostedt wrote:
> On Thu, 10 Jun 2021 21:08:32 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > Michael did the libtraceevent detection and dynamic linking support:
> >   https://lore.kernel.org/linux-perf-users/20210428092023.4009-1-mpetlan@redhat.com/
> > 
> > I think we should have that in Fedora/RHEL rpms already, or it's on the way.
> > 
> > The detection code could be change to contain things we need.
> 
> Or it can also be changed to export the version too?
> 
> LIBTRACEEVENT_VERSION = $(shell pkg-config --modversion libtraceevent | perl -e '$ver=<>; @v=split /,/,$ver; printf "%d\n", $v[0] * 255 * 255 | $v[1] * 255 | $v[2];')
> 
> -DLIBTRACEFS_VERSION=$(LIBTRACEEVENT_VERSION)

so the feature detection just gives out on/off answers,
but we can easily put above to perf's makefile

jirka

> 
> Then in C have:
> 
> #define VERSION(a,b,c) ((a)*255*255|(b)*255|(c))
> 
> #if LIBTRACEEVENT_VERSION >= VERSION(1,2,3)
> 
> To test if the libtraceevent feature is available?
> 
> -- Steve
> 

