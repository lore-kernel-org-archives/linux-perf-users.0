Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18D5C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Nov 2022 12:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiKOMrI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Nov 2022 07:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiKOMrG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Nov 2022 07:47:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B19C27CF9
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 04:47:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w14so24053814wru.8
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 04:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1SLk2IKOU4p5u1yLi59lJwNiPvqFLA1WCxKL3c6ObnU=;
        b=OrfEksdNBMA2j/YJGIxsFjjKPVk/DeFSBAmNrhUH2m7Clg6Y9XCzMz1ElVCMslLNb0
         UkyZn6yCM/CrRGaxRr2m3116ddTA1HpnHh/DVPrWj3HXNs02gMOeEa4W+x+apWiirqIy
         vtvhqHfE4mQ3Wyje5CZdBHlbQAiYmy1s2LIDzOT4H5wF/fcUWyRpeST3V+rqoeh6nAnG
         cGcX9WRMgW7Kx7a27BxeRaNNbrErIGZx1ksH8We+lvyQfkRpTyi2f96B/ZiFH6gKYUsZ
         4ZH5CoEYxsxAQ0gRYaUKyx8ep8IGER6VUV1UN1oyFxRVd5meZFv8S+n9XvDm6ql8itGF
         WsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SLk2IKOU4p5u1yLi59lJwNiPvqFLA1WCxKL3c6ObnU=;
        b=h7qerK5lIm7ibXAHg4Xw0qbjvUi+/70UB6letNe/Hzp8zuOnvnVgGRC18V2sNtWuXN
         61/q5A+7imP9FUvCbAuQLVvCGh9hcV6ZD7kaOfBIKsehRwBlPzr9sgD1YFhTErECSofK
         uJCfKwmRmsEcuuWPPpixCYbAkVHY5FaBwJrvSO7Qm2Bub8dlDk45T/Zn6b6vUO8Ba3J6
         FRcslUdZDBfiZvsaPXWAkfRy22/OyNEyS9i8BWv18u0F5fo4l9vMrXGx7yi29hc2F4sZ
         R/el7KTNvw1TNOsYCbsms2V7c8tTA7u5LD7y6+DlNJ2nc7/uf1nmO+5KB9eZc3+8s2b5
         /Q3w==
X-Gm-Message-State: ANoB5plhsEEVqSLKS29caMyBtdRWRegDOVY85hcADeOjdYaZjW7WMJyd
        NyMQPjDq4/M0WmqScGFYNvCUvoy5oR0=
X-Google-Smtp-Source: AA0mqf4nzQmtGTg3wnZ4vvQjYPcFHKmGQJt4QU++Ieik4yZjBQmQrFp5km2lYKSl1PF13tLFCVdF6w==
X-Received: by 2002:adf:fa42:0:b0:22e:3e09:ffdd with SMTP id y2-20020adffa42000000b0022e3e09ffddmr10323594wrr.423.1668516423881;
        Tue, 15 Nov 2022 04:47:03 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t5-20020adfe445000000b00236740c6e6fsm12250346wrm.100.2022.11.15.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:47:03 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:46:59 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     peterz@infradead.org
Cc:     linux-perf-users@vger.kernel.org
Subject: [bug report] perf: Rewrite core context handling
Message-ID: <Y3OKQ/Rwm6qVyG3I@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

[ Resending two weeks of email.  Crap.  -dan ]

Hello Peter Zijlstra,

The patch bd2756811766: "perf: Rewrite core context handling" from
Oct 8, 2022, leads to the following Smatch static checker warning:

kernel/events/core.c:13190 inherit_event() warn: 'pmu_ctx' is an error pointer or valid

kernel/events/core.c
    13146 static struct perf_event *
    13147 inherit_event(struct perf_event *parent_event,
    13148               struct task_struct *parent,
    13149               struct perf_event_context *parent_ctx,
    13150               struct task_struct *child,
    13151               struct perf_event *group_leader,
    13152               struct perf_event_context *child_ctx)
    13153 {
    13154         enum perf_event_state parent_state = parent_event->state;
    13155         struct perf_event_pmu_context *pmu_ctx;
    13156         struct perf_event *child_event;
    13157         unsigned long flags;
    13158 
    13159         /*
    13160          * Instead of creating recursive hierarchies of events,
    13161          * we link inherited events back to the original parent,
    13162          * which has a filp for sure, which we use as the reference
    13163          * count:
    13164          */
    13165         if (parent_event->parent)
    13166                 parent_event = parent_event->parent;
    13167 
    13168         child_event = perf_event_alloc(&parent_event->attr,
    13169                                            parent_event->cpu,
    13170                                            child,
    13171                                            group_leader, parent_event,
    13172                                            NULL, NULL, -1);
    13173         if (IS_ERR(child_event))
    13174                 return child_event;
                          ^^^^^^^^^^^^^^^^^^^
inherit_event() has historically returned a mix of error pointers and
NULL.  I am not clear on the rules.

    13175 
    13176         pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
--> 13177         if (!pmu_ctx) {

The find_get_pmu_context() function only returns error pointers so this
is straight forward, but I don't know if this path should return an
error pointer or NULL or what.  Probably easiest to just report it to
you.  :)

    13178                 free_event(child_event);
    13179                 return NULL;
    13180         }
    13181         child_event->pmu_ctx = pmu_ctx;
    13182 
    13183         /*
    13184          * is_orphaned_event() and list_add_tail(&parent_event->child_list)
    13185          * must be under the same lock in order to serialize against
    13186          * perf_event_release_kernel(), such that either we must observe
    13187          * is_orphaned_event() or they will observe us on the child_list.
    13188          */
    13189         mutex_lock(&parent_event->child_mutex);
    13190         if (is_orphaned_event(parent_event) ||
    13191             !atomic_long_inc_not_zero(&parent_event->refcount)) {
    13192                 mutex_unlock(&parent_event->child_mutex);
    13193                 /* task_ctx_data is freed with child_ctx */
    13194                 free_event(child_event);
    13195                 return NULL;
    13196         }
    13197 
    13198         get_ctx(child_ctx);
    13199 
    13200         /*
    13201          * Make the child state follow the state of the parent event,
    13202          * not its attr.disabled bit.  We hold the parent's mutex,
    13203          * so we won't race with perf_event_{en, dis}able_family.
    13204          */
    13205         if (parent_state >= PERF_EVENT_STATE_INACTIVE)
    13206                 child_event->state = PERF_EVENT_STATE_INACTIVE;
    13207         else
    13208                 child_event->state = PERF_EVENT_STATE_OFF;
    13209 
    13210         if (parent_event->attr.freq) {
    13211                 u64 sample_period = parent_event->hw.sample_period;
    13212                 struct hw_perf_event *hwc = &child_event->hw;
    13213 
    13214                 hwc->sample_period = sample_period;
    13215                 hwc->last_period   = sample_period;
    13216 
    13217                 local64_set(&hwc->period_left, sample_period);
    13218         }
    13219 
    13220         child_event->ctx = child_ctx;
    13221         child_event->overflow_handler = parent_event->overflow_handler;
    13222         child_event->overflow_handler_context
    13223                 = parent_event->overflow_handler_context;
    13224 
    13225         /*
    13226          * Precalculate sample_data sizes
    13227          */
    13228         perf_event__header_size(child_event);
    13229         perf_event__id_header_size(child_event);
    13230 
    13231         /*
    13232          * Link it up in the child's context:
    13233          */
    13234         raw_spin_lock_irqsave(&child_ctx->lock, flags);
    13235         add_event_to_ctx(child_event, child_ctx);
    13236         child_event->attach_state |= PERF_ATTACH_CHILD;
    13237         raw_spin_unlock_irqrestore(&child_ctx->lock, flags);
    13238 
    13239         /*
    13240          * Link this into the parent event's child list
    13241          */
    13242         list_add_tail(&child_event->child_list, &parent_event->child_list);
    13243         mutex_unlock(&parent_event->child_mutex);
    13244 
    13245         return child_event;
    13246 }

regards,
dan carpenter
