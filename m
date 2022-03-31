Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C6FC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Mar 2022 08:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiCaIQE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Mar 2022 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiCaIQD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Mar 2022 04:16:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A21A818;
        Thu, 31 Mar 2022 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QsP+IlSxkL6NqvmArcUcnZSFybZOrqNvIwp1wgxlJIk=; b=bMyiaHaMN75EELHxtOPozcytje
        4mR6+DKXg5nGbvJz+LCHWyRTSQj5FtRPk+9fPKTRB/YWeXnT7ELAMnzzKqEZ+vdYlsjCe/2jaMUBx
        u9+oLraRrNsLGR+VbTmGpdtHrVVa+oOcIpDj20PBKajoAcuJV32ZPAQ6R5yMLjd/oieN2Jph2nPC/
        /idfbV9iJI8w547jEKWLeqfGRr7fhb3755KXKnsmwsdvolNbv90nJf7E2j6yj4uvxaU7C60sjXm4P
        WxqjADp849Kof3CgS28laWtVcWxQZQn/aBvZfgz9yc7hr4ysOZziw3bBPjSKHcgk2bTACUT07NHXG
        ZRNb4Z3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZpwS-006PsI-JO; Thu, 31 Mar 2022 08:14:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BC9D98695C; Thu, 31 Mar 2022 10:14:01 +0200 (CEST)
Date:   Thu, 31 Mar 2022 10:14:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v4 0/4] perf/core: Fixes for cgroup events
Message-ID: <20220331081401.GR8939@worktop.programming.kicks-ass.net>
References: <20220329154523.86438-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329154523.86438-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 29, 2022 at 11:45:19PM +0800, Chengming Zhou wrote:
> Chengming Zhou (4):
>   perf/core: Don't pass task around when ctx sched in
>   perf/core: Use perf_cgroup_info->active to check if cgroup is active
>   perf/core: Fix perf_cgroup_switch()
>   perf/core: Always set cpuctx cgrp when enable cgroup event

Thanks, queued for post -rc1
