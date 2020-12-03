Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FA0C4361A
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Dec 2020 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5BA20659
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Dec 2020 15:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgLCPkz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgLCPkz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Dec 2020 10:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607009969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oU00Ud7/lfbmIiqOUg1SzrfFDF4U7O3g4rFILJKmke8=;
        b=Ep02cpDuzrk4XlPyQ3s1Hu0V0MJeEmcoN9OA0P+OBMZ9CPq0OOuPrIPipVKkYhWSqK5+dR
        d3ikDm/W5s/2LwISxcAJLRTD3qawbyECGWCO2yxP0UagiYjUmua+d4e3DDCHBVRRUeGNuu
        e1rSjR33/Zn0MYi47rz4JNBdLm/euSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-fSyrZp2xMNqmq-Vh-LF7MA-1; Thu, 03 Dec 2020 10:39:27 -0500
X-MC-Unique: fSyrZp2xMNqmq-Vh-LF7MA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBAAC280;
        Thu,  3 Dec 2020 15:39:26 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id CEDEE18A9D;
        Thu,  3 Dec 2020 15:39:24 +0000 (UTC)
Date:   Thu, 3 Dec 2020 16:39:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, john.garry@huawei.com
Subject: Re: [PATCH v6 00/12] perf tools: fix perf stat with large socket IDs
Message-ID: <20201203153923.GA3613481@krava>
References: <20201126141328.6509-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126141328.6509-1-james.clark@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 26, 2020 at 04:13:16PM +0200, James Clark wrote:
> Changes since v5:
>   * Fix test for cpu_map__get_die() by shifting id before testing.
>   * Fix test for cpu_map__get_socket() by not using cpu_map__id_to_socket()
>     which is only valid in CPU aggregation mode.
> 
> James Clark (12):
>   perf tools: Improve topology test
>   perf tools: Use allocator for perf_cpu_map
>   perf tools: Add new struct for cpu aggregation
>   perf tools: Replace aggregation ID with a struct
>   perf tools: add new map type for aggregation
>   perf tools: drop in cpu_aggr_map struct
>   perf tools: Start using cpu_aggr_id in map
>   perf tools: Add separate node member
>   perf tools: Add separate socket member
>   perf tools: Add separate die member
>   perf tools: Add separate core member
>   perf tools: Add separate thread member

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/builtin-stat.c      | 128 ++++++++++++------------
>  tools/perf/tests/topology.c    |  64 ++++++++++--
>  tools/perf/util/cpumap.c       | 171 ++++++++++++++++++++++-----------
>  tools/perf/util/cpumap.h       |  55 ++++++-----
>  tools/perf/util/stat-display.c | 102 ++++++++++++--------
>  tools/perf/util/stat.c         |   2 +-
>  tools/perf/util/stat.h         |   9 +-
>  7 files changed, 337 insertions(+), 194 deletions(-)
> 
> -- 
> 2.28.0
> 

