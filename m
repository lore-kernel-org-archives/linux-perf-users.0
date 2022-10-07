Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE051C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 Oct 2022 16:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJGQOk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 Oct 2022 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJGQOj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 Oct 2022 12:14:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6CFBA4
        for <linux-perf-users@vger.kernel.org>; Fri,  7 Oct 2022 09:14:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so12393967ejn.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Oct 2022 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwCgcEFb6EqweOCGJwFjwMplx0cMo00I0pQaRZheEns=;
        b=FLiXrIyCWCwIh4B7g6oOtQeS0K8OpzpCsj7kykdMijQaKSo6U6qLpZLv5183N831/Z
         o97aNMbep3GAWS0wQMhtu2BI/UprI8Vo9qxwerSYZzjU+70Vg+E+zm2cGRFWfJnCT1MQ
         5aZEVehO6KOzH2QLEs7DtmeWin72GDMaiqITZ/pYKvXswY5SDAFGcVvEW70xMD2HW0ES
         HGR6yqzTiZ2lIUSeizd2EAi08tYXTfHsd8SNe5IuUnBjLOzW8aWDOvIlbLTTx96M3KSq
         i8IH+LHnTANkheqM77lFKwPCgkuaD7wLDkZmrfuFw1oiGoNPcFNCd+r230YSNMSIYyP8
         Astw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwCgcEFb6EqweOCGJwFjwMplx0cMo00I0pQaRZheEns=;
        b=IspeT1dz3rKydvyUHArTlrUAYGbIc/0kgStSJ4N/p+uRZGlhwJ9IIsejLPv47oJ+FK
         iXVMjYmOr23lT3Ff/QUs1WRolanPDfHB2pJ6ZGY0ami+kn1OXZPZ+eo1PGEWMdEIgcRN
         wEotRX7AKiIKo255fHS+v0BjxayzUeqM/h4TsgNFuofNQyCAyz8UO7yeBuwLw0HT2shC
         fabMKfdbQnijNhwDQs6aJuTTtA9H5rhJBmViuLXyjY8R7FoSHqt7QsKSsuVFaTDnKqcn
         qqmx3tXJRjfgC+oD4Ea1RIsUPdwsiH0MlmzC0Bjj7iFtg48GyixLmv8P4bjPObp9vu38
         bqLw==
X-Gm-Message-State: ACrzQf3qs4TTi9Cqrx6FCRXOAtNNT4uEXuWRIJYk67GOM1xkPydt7M+W
        nG74NlAnglX+kkq4a/ZuWGLFBQ==
X-Google-Smtp-Source: AMsMyM4okfVRbMsO3Ymv4vwJs9wuatFTCbhTbraksBWWxhhaFX9/mcQHd/2T30xj00lGBinhZSBhTw==
X-Received: by 2002:a17:906:da86:b0:77a:52b3:da48 with SMTP id xh6-20020a170906da8600b0077a52b3da48mr4502878ejb.373.1665159274119;
        Fri, 07 Oct 2022 09:14:34 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:4e4:454c:b135:33f2])
        by smtp.gmail.com with ESMTPSA id pk18-20020a170906d7b200b00741383c1c5bsm1379772ejb.196.2022.10.07.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 09:14:33 -0700 (PDT)
Date:   Fri, 7 Oct 2022 18:14:27 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Y0BQYxewPB/6KWLz@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
 <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
 <Y0AwaxcJNOWhMKXP@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0AwaxcJNOWhMKXP@elver.google.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Oct 07, 2022 at 03:58PM +0200, Marco Elver wrote:
> On Fri, Oct 07, 2022 at 03:09PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 07, 2022 at 11:37:34AM +0200, Marco Elver wrote:
> > 
> > > That worked. In addition I had to disable the ctx->task != current check
> > > if we're in task_work, because presumably the event might have already
> > > been disabled/moved??
> > 
> > Uhmmm... uhhh... damn. (wall-time was significantly longer)
> > 
> > Does this help?
> 
> No unfortunately - still see:
> 
> [   82.300827] ------------[ cut here ]------------
> [   82.301680] WARNING: CPU: 0 PID: 976 at kernel/events/core.c:6466 perf_sigtrap+0x60/0x70

Whenever the warning fires, I see that event->state is OFF.
