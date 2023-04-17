Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02ACC77B76
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Apr 2023 18:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDQSyp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Apr 2023 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjDQSyo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Apr 2023 14:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D14B97
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Apr 2023 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681757636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YunkTEAGlh+/jXszudVUlMXCZrcBZh4SjjTldlTI43U=;
        b=NX8n527c7LNWvNf+K+o3/CQooATHYvRXPp6b0XAJ+UXRB6w9lNM9sZNbWs+54qmsgztKBQ
        5n0ON4fbB6Q+ZNxDNxs6mP/d8hXwAAJMCfP7aNnfULRmb/aIh5FZpuWrQxmeghK5VxAEoF
        a5zCsyEnzbPelaOSNTvlepoq5vzEKb0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-6Zw7jsvEMK-OVxvVaG2OBw-1; Mon, 17 Apr 2023 14:53:49 -0400
X-MC-Unique: 6Zw7jsvEMK-OVxvVaG2OBw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE81538145BD;
        Mon, 17 Apr 2023 18:53:47 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB13B492B0F;
        Mon, 17 Apr 2023 18:53:46 +0000 (UTC)
Message-ID: <e0c81460-5b52-3f1b-9f6a-53f38179285b@redhat.com>
Date:   Mon, 17 Apr 2023 14:53:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 3/3] treewide: replace put_task_struct() witht the
 atomic safe version
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>
References: <20230414125532.14958-1-wander@redhat.com>
 <20230414125532.14958-4-wander@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230414125532.14958-4-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 4/14/23 08:55, Wander Lairson Costa wrote:
> In places where put_task_struct() is called in a non-sleepable context,
> we replace those calls by put_task_struct_atomic_safe().
>
> These call sites were found by running internal regression tests and
> looking for warnings generated by put_task_might_resched().
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
>   kernel/events/core.c     |  6 +++---
>   kernel/locking/rtmutex.c | 10 +++++-----
>   kernel/sched/core.c      |  6 +++---
>   kernel/sched/deadline.c  | 16 ++++++++--------
>   kernel/sched/rt.c        |  4 ++--
>   5 files changed, 21 insertions(+), 21 deletions(-)

Typo "witht" in your patch title.

Cheers,
Longman

