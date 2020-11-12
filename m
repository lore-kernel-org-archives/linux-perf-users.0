Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5F8C388F7
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Nov 2020 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67FD22227
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Nov 2020 21:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gv4ZyMIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKLV2c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Nov 2020 16:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726960AbgKLV2b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Nov 2020 16:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605216509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31V0kyw/NhyHSO/KjODwhVAGkINQtFRjV2lgoBeJ2/k=;
        b=Gv4ZyMIwHlaa5vBe/zfrxopO/TNNQ1D37dXMFi1sHFvkytWJg2B/bBnefrFiqlWPtZWX+1
        l1K51TQSU+yxYw/2l6O3Bk3dcuYhaBWG+jOleQS8S43vf9PerkctNPWwGFvU7wwEyBNHfl
        HabC0jjk3/fnU46UIkcslBSQAFy1cig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-3nghB2AhPby-mYvSNYV2BQ-1; Thu, 12 Nov 2020 16:28:26 -0500
X-MC-Unique: 3nghB2AhPby-mYvSNYV2BQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35A981882FCA;
        Thu, 12 Nov 2020 21:28:24 +0000 (UTC)
Received: from krava (unknown [10.40.194.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id DCA2A55763;
        Thu, 12 Nov 2020 21:28:20 +0000 (UTC)
Date:   Thu, 12 Nov 2020 22:28:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH V2 3/3] perf tools: fix perf stat with large socket IDs
Message-ID: <20201112212819.GB753418@krava>
References: <20201004203545.GB217601@krava>
 <20201028094311.8563-1-james.clark@arm.com>
 <20201028094311.8563-4-james.clark@arm.com>
 <20201108124412.GA196289@krava>
 <ec3e153b-f5b9-dc70-a012-d180d1f32932@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec3e153b-f5b9-dc70-a012-d180d1f32932@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 12, 2020 at 09:42:42PM +0200, James Clark wrote:
> 
> 
> On 08/11/2020 14:44, Jiri Olsa wrote:
> > On Wed, Oct 28, 2020 at 09:43:11AM +0000, James Clark wrote:
> > 
> > SNIP
> > 
> >> -		 * Encode socket in bit range 31:24
> >> -		 * encode die id in bit range 23:16
> >>  		 * core_id is relative to socket and die,
> >>  		 * we need a global id. So we combine
> >>  		 * socket + die id + core id
> >>  		 */
> >> -		if (WARN_ONCE(env->cpu[cpu].socket_id >> 8, "The socket id number is too big.\n"))
> >> -			return cpu_map__empty_aggr_cpu_id();
> >> -
> >> -		if (WARN_ONCE(env->cpu[cpu].die_id >> 8, "The die id number is too big.\n"))
> >> -			return cpu_map__empty_aggr_cpu_id();
> >> -
> >> -		if (WARN_ONCE(env->cpu[cpu].core_id >> 16, "The core id number is too big.\n"))
> >> -			return cpu_map__empty_aggr_cpu_id();
> >> -
> >> -		core.id = (env->cpu[cpu].socket_id << 24) |
> >> -		       (env->cpu[cpu].die_id << 16) |
> >> -		       (env->cpu[cpu].core_id & 0xffff);
> >> +		core.socket_id = env->cpu[cpu].socket_id;
> >> +		core.die_id = env->cpu[cpu].die_id;
> >> +		core.core_id = env->cpu[cpu].core_id;
> > 
> > all 3 functions above look like they could be united just
> > to single one, because they are no longer steping on ech
> > other data
> > 
> > perhaps best as separate patch, so the change is clean
> > 
> > there are also the 'system retrieval counter' functions,
> > where it's possible better to keep it separated from
> > performance reasons, but here it's just value assigment
> 
> Hi Jiri,
> 
> I have a new patchset ready without this change, and I started working on this, but I came
> across some issues:
> 
> For example if all of the members are filled in regardless of the aggregation type,
> then the comparison function that actually decides whether cores should be aggregated or
> not will need to be modified to accept the current aggregation mode.

ah, because we compare all the values regardless and normaly there'd be -1

> 
> This would be possible, but would have a knock on effect when the values are read
> from the system if the code is to be shared.
> 
> Also there is a second issue where some of the current functions have different failure
> conditions. For example if socket can't be read, then that mode will fail, but other
> aggregation modes will still work. If we make the change to unify all the functions then
> that could get a bit more complicated.
> 
> I just wanted to get your opinion whether to submit the broken up set without this extra
> change or carry on trying to work out a solution?

ok forget it then, seems like possible follow up changes if it's even worthy

thanks for checking on that

jirka

