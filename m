Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5652C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Dec 2020 22:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A357522283
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Dec 2020 22:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLWWTV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Dec 2020 17:19:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbgLWWTU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Dec 2020 17:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608761873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Ck1I5IrcfRnzD5SQ2UFbqmp5MXdOKhjN9/IxJ3cG8s=;
        b=jH/iQIaKW6DwCdcMroULe4RtSmlzPgg+ic8n1YHCBkyU0m75K1n6JpOKggaUdMS66VMAH9
        42Ur3DJCACc85vya2Mr4JP8VuwlgzFMka7IVrxXOtoCKUzjWu6kLsHWvn23ikUgPdVbjw4
        IaK0eW8DmxknWpz17EAMiFdKxEd2T8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-5aHaB8T0OqWGAb0lOIsWTw-1; Wed, 23 Dec 2020 17:17:51 -0500
X-MC-Unique: 5aHaB8T0OqWGAb0lOIsWTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3716801AB3;
        Wed, 23 Dec 2020 22:17:49 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id DFF662BFE3;
        Wed, 23 Dec 2020 22:17:47 +0000 (UTC)
Date:   Wed, 23 Dec 2020 23:17:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v6 00/12] perf tools: fix perf stat with large socket IDs
Message-ID: <20201223221747.GB236568@krava>
References: <20201126141328.6509-1-james.clark@arm.com>
 <20201203153923.GA3613481@krava>
 <30c4426d-b314-98ff-e6d5-6d5152f316e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c4426d-b314-98ff-e6d5-6d5152f316e8@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Dec 04, 2020 at 11:48:36AM +0000, John Garry wrote:
> On 03/12/2020 15:39, Jiri Olsa wrote:
> 
> +
> 
> > On Thu, Nov 26, 2020 at 04:13:16PM +0200, James Clark wrote:
> > > Changes since v5:
> > >    * Fix test for cpu_map__get_die() by shifting id before testing.
> > >    * Fix test for cpu_map__get_socket() by not using cpu_map__id_to_socket()
> > >      which is only valid in CPU aggregation mode.
> > > 
> > > James Clark (12):
> > >    perf tools: Improve topology test
> > >    perf tools: Use allocator for perf_cpu_map
> > >    perf tools: Add new struct for cpu aggregation
> > >    perf tools: Replace aggregation ID with a struct
> > >    perf tools: add new map type for aggregation
> > >    perf tools: drop in cpu_aggr_map struct
> > >    perf tools: Start using cpu_aggr_id in map
> > >    perf tools: Add separate node member
> > >    perf tools: Add separate socket member
> > >    perf tools: Add separate die member
> > >    perf tools: Add separate core member
> > >    perf tools: Add separate thread member
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> 
> Tested-by: John Garry <john.garry@huawei.com>

hi,
I was wondering where this went, and noticed that
Arnaldo was not CC-ed on the cover letter ;-)

jirka

> 
> I still think that vendors (like us) need to fix/improve their firmware
> tables so that we don't get silly big numbers for socket/package IDs, like
> S5418-D0, below:
> 
> $./perf stat -a --per-die
> 
>  Performance counter stats for 'system wide':
> 
> S36-D0   48   72,216.31 msec cpu-clock      #   47.933 CPUs utilized
> S36-D0   48        174     context-switches #   0.002 K/sec
> S36-D0   48         48     cpu-migrations   #   0.001 K/sec
> S36-D0   48         0     page-faults    #   0.000 K/sec
> S36-D0   48   7,991,698     cycles    #   0.000 GHz
> S36-D0   48   4,750,040     instructions   #   0.59  insn per cycle
> S36-D0    1   <not supported>     branches
> S36-D0   48      32,928     branch-misses    #   0.00% of all branches
> S5418-D0   48   72,189.54 msec cpu-clock     #   47.915 CPUs utilized
> S5418-D0   48        176     context-switches  #   0.002 K/sec
> S5418-D0   48         48     cpu-migrations   #   0.001 K/sec
> S5418-D0   48         0     page-faults     #   0.000 K/sec
> S5418-D0   48   5,677,218     cycles    #    0.000 GHz
> S5418-D0   48   3,872,285     instructions   #  0.68  insn per cycle
> S5418-D0    1   <not supported>     branches
> S5418-D0   48      29,208     branch-misses   #  0.00% of all branches
> 
>       1.506615297 seconds time elapsed
> 
> but at least it works now. Thanks.
> 
> > 
> > > 
> > >   tools/perf/builtin-stat.c      | 128 ++++++++++++------------
> > >   tools/perf/tests/topology.c    |  64 ++++++++++--
> > >   tools/perf/util/cpumap.c       | 171 ++++++++++++++++++++++-----------
> > >   tools/perf/util/cpumap.h       |  55 ++++++-----
> > >   tools/perf/util/stat-display.c | 102 ++++++++++++--------
> > >   tools/perf/util/stat.c         |   2 +-
> > >   tools/perf/util/stat.h         |   9 +-
> > >   7 files changed, 337 insertions(+), 194 deletions(-)
> > > 
> > > -- 
> > > 2.28.0
> > > 
> > 
> > .
> > 
> 

