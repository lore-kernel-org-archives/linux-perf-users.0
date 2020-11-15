Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80164C6369E
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 Nov 2020 21:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A5D2242E
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 Nov 2020 21:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXLV9bbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgKOVSL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 Nov 2020 16:18:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728017AbgKOVSL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 Nov 2020 16:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605475089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAsJ/vHwUufjthY49pyRmBioJW4SQk95ciC/9TJRffQ=;
        b=EXLV9bbT31Z8l2JuZBoIAgvqhX0QeVcpUMlTvH7MlgQ3F1hiqWEGo6Zt4Qv1UGrSeRb858
        g8dJ5Ra7k1huTI/cZAn2u1vFqN1rHllblFzqkGsO2Qr/wau6TDHuOsWOVu+Tt39mYSK7jE
        LjeLfySZ42qcz7uF0sI4Tt/wHw5LTv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-PWGMV7AvP4ycSrs23W3emQ-1; Sun, 15 Nov 2020 16:18:08 -0500
X-MC-Unique: PWGMV7AvP4ycSrs23W3emQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46ABF1007464;
        Sun, 15 Nov 2020 21:18:06 +0000 (UTC)
Received: from krava (unknown [10.40.192.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6CD1A55769;
        Sun, 15 Nov 2020 21:18:03 +0000 (UTC)
Date:   Sun, 15 Nov 2020 22:18:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <andi@firstfloor.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 00/13 v4] perf tools: fix perf stat with large socket IDs
Message-ID: <20201115211802.GE1081385@krava>
References: <20201113172654.989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113172654.989-1-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 13, 2020 at 07:26:41PM +0200, James Clark wrote:
> v3 had a mistake in a couple of my signed off lines so I have fixed them
> in v4.
> 
> v3 breaks up the previous v2 patchset into smaller atomic commits.
> The end result is the same as the previous patchset apart from
> some minor refactoring, asserting on an empty header and
> calling cpu__setup_cpunode_map() in the topology self test.
> 
> Testing done:
> 
> Tested --per-core, --per-thread, --per-die, --per-node 'perf
> stat' outputs on Arm ThunderX2 and Intel KNL.
> 
> Also tested 'perf stat record' and 'perf stat report --input'
> with recordings from a version of perf before this patchset
> to confirm that the output was the same.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> 
> James Clark (13):
>   perf tools: Improve topology test
>   perf tools: Use allocator for perf_cpu_map
>   perf tools: Add new struct for cpu aggregation
>   perf tools: Replace aggregation ID with a struct
>   perf tools: add new map type for aggregation
>   perf tools: drop in cpu_aggr_map struct
>   perf tools: restrict visibility of functions
>   perf tools: Start using cpu_aggr_id in map
>   perf tools: Add separate node member
>   perf tools: Add separate socket member
>   perf tools: Add separate die member
>   perf tools: Add separate core member
>   perf tools: add thread field

I sent few comments but overall looks good

Stephane, Andi, could you take a look, please?

thanks,
jirka

> 
>  tools/perf/builtin-stat.c      | 128 +++++++++++++------------
>  tools/perf/tests/topology.c    |  58 +++++++++--
>  tools/perf/util/cpumap.c       | 170 ++++++++++++++++++++++-----------
>  tools/perf/util/cpumap.h       |  55 ++++++-----
>  tools/perf/util/stat-display.c | 106 +++++++++++---------
>  tools/perf/util/stat.c         |   2 +-
>  tools/perf/util/stat.h         |   9 +-
>  7 files changed, 332 insertions(+), 196 deletions(-)
> 
> -- 
> 2.28.0
> 

