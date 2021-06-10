Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC9BC48BDF
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 19:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4B761403
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 19:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFJTKm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 15:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhFJTKl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 15:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623352124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VLobxehRoyA6A0RuCeGVQ1FkoxfAMrcpvrRVgnHIRDg=;
        b=MFBIBRC95wUHC15HdAjpNgz91tLsGuIM8V97WFd0Jwvup93Y2D1xf4GqTYEMizfMpoiGU7
        sor70bUujRxAofPMrnEP3vQEd7oH7BcgSlw2Ycxv2zEh4rVC91gWYigL+KHpo/5f2KuFe2
        eBYUSh9Jcs8IHs/Tm8kbtvP/PkFn/uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-9ZHx0YGBO1G9cSfOXhjNzg-1; Thu, 10 Jun 2021 15:08:41 -0400
X-MC-Unique: 9ZHx0YGBO1G9cSfOXhjNzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A48D57229;
        Thu, 10 Jun 2021 19:08:37 +0000 (UTC)
Received: from krava (unknown [10.40.195.165])
        by smtp.corp.redhat.com (Postfix) with SMTP id 466BE7DBD4;
        Thu, 10 Jun 2021 19:08:33 +0000 (UTC)
Date:   Thu, 10 Jun 2021 21:08:32 +0200
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
Message-ID: <YMJjMPDKo2IdCC6G@krava>
References: <20210610060643.595673-1-irogers@google.com>
 <20210610103927.44462e35@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610103927.44462e35@oasis.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 10, 2021 at 10:39:27AM -0400, Steven Rostedt wrote:
> On Wed,  9 Jun 2021 23:06:43 -0700
> Ian Rogers <irogers@google.com> wrote:
> 
> > libtraceevent has added more levels of debug printout and with changes
> > like:
> > https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
> > previously generated output like "registering plugin" is no longer
> > displayed. This change makes it so that if perf's verbose debug output
> > is enabled then the debug and info libtraceevent messages can be
> > displayed.
> > As this API isn't present in the deprecated tools version of
> > libtracevent I'm uploading this as an RFC.
> 
> Thanks Ian,
> 
> We need to start porting perf to using the upstream libtraceevent
> library. I think the best way to do that is what we did with trace-cmd.
> That is to have the make files check if the minimum version of
> libtraceevent is installed, and if so, use that instead of the local
> version. If it is not installed, produce a message encouraging the
> developer to install the upstream libtraceevent and warn that it will
> be using a deprecated older versino, then build the deprecated local
> version. After some time, we could simply remove it and make it a
> dependency, but I want to do that when all the main distros being used
> have it.

Michael did the libtraceevent detection and dynamic linking support:
  https://lore.kernel.org/linux-perf-users/20210428092023.4009-1-mpetlan@redhat.com/

I think we should have that in Fedora/RHEL rpms already, or it's on the way.

The detection code could be change to contain things we need.

jirka

> 
> Currently its in the latest Debian, Ubuntu, and Fedora. I also believe
> its in SUSE but have not checked. It's in Fedora 34, but it doesn't
> appear to be in Fedora 33. As that's not too old, I don't think we
> should make it a dependency as of yet.
> 
> -- Steve
> 

