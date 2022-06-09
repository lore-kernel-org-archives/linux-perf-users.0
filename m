Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCCCC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 12:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiFIMxP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiFIMxO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 08:53:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CA12E32B
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 05:53:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u8so27956213wrm.13
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xsbD60qIHanlKuWKt+8TLbFkRT3oM/UNVHEodPGa7yk=;
        b=ogxQx9/A77IYQ/hkeDboJ31yIL2cjqX5j2tbjDpVF4T49J/STcN+TRwFrbHQjaoMLW
         ltWumxcgf2zS7G8Iw/ewsvUxc82h2ycTigV0zuzXwhTU2elDIsRMAkDYai2dVUqTJUfc
         V1l9p6AukaGvIR5nKfcLtG14Z2ISv9bBnT1QGsjiRphpW/rB5Dbc4XiC83J+5uvQ0D60
         RmKk/IUExDhpBPums6vI4w70UYQV+ou+WFx8y5AKBEPLkAOR/Y+pxn+FKKmg43coSSP0
         G9KpfHlnEJXtzStO/xypwKyMezq47b0UB6XNhOwP6YtMg59SqonDYWpPvpaI2WNG2HUq
         kqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xsbD60qIHanlKuWKt+8TLbFkRT3oM/UNVHEodPGa7yk=;
        b=xohra1gHs54oewdE8RaGF8ImArWce4sMqE48PZMj9gRxlJbJcH0INRTHKvcHSKs936
         QNg8Z65RQ4iTOk79gqiFc30pS/fyTInYDsCCD+aE8WUy8muOIPJq0cIjo03p+pHxJ1rs
         pt3BIqX1JZywB2h8b++3V8+myOqecw/g1WlZ4QCrTFBR2SY5iXoUBk8hPkb1HrYRzrcV
         kiu7LPkVhxKaEmaNwcNs1c2e0wJ9l2NLX+AX0to83+a9nDB0yTb+Ny4zJmvaUoYXw5jJ
         l1t/S/wjvcn1mRK4V7Pjktp4ARIUaqDZu5nXkGbT9oHlQRZp0/7OULfieYl/89vJ980r
         T0Iw==
X-Gm-Message-State: AOAM531aIyLv3WYJ1Os5MWPESr4QKW0oiQvsSdiOqOhHvinAThMlxRUB
        QVisVu3Ah80cFRxkhj8irwB2N2095xwDZQ==
X-Google-Smtp-Source: ABdhPJyJUVWiu56wlkL1GRUdrN5r0Z2qCI6oeCaAM64dh4ZzAFCXGHnDJ6WcKQ7t2Jmgwe09MkROHA==
X-Received: by 2002:a5d:6c62:0:b0:218:3e13:4b17 with SMTP id r2-20020a5d6c62000000b002183e134b17mr20790347wrz.673.1654779189454;
        Thu, 09 Jun 2022 05:53:09 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
        by smtp.gmail.com with ESMTPSA id v190-20020a1cacc7000000b003975c7058bfsm27801688wme.12.2022.06.09.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 05:53:08 -0700 (PDT)
Date:   Thu, 9 Jun 2022 14:53:02 +0200
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] perf/hw_breakpoint: Optimize list of per-task
 breakpoints
Message-ID: <YqHtLvdLvdM5Lmdh@elver.google.com>
References: <20220609113046.780504-1-elver@google.com>
 <20220609113046.780504-2-elver@google.com>
 <CACT4Y+ZfjLCj=wvPFhyUQLwxmcOXuK9G_a53SB=-niySExQdew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZfjLCj=wvPFhyUQLwxmcOXuK9G_a53SB=-niySExQdew@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 09, 2022 at 02:30PM +0200, Dmitry Vyukov wrote:
[...]
> > +       rcu_read_lock();
> 
> Why do we need rcu_read_lock() here?
> The patch does not change anything with respect to locking, so all
> accesses to the container should still be protected by nr_bp_mutex.
> Similarly for the rcu variant of for_each below.
[...]
> > +       head = rhltable_lookup(&task_bps_ht, &bp->hw.target, task_bps_ht_params);
> > +       if (!head)
> > +               goto out;
> > +
> > +       rhl_for_each_entry_rcu(iter, pos, head, hw.bp_list) {

It's part of rhashtable's interface requirements:

	/**
	 * rhltable_lookup - search hash list table
	 * @hlt:	hash table
	 * @key:	the pointer to the key
	 * @params:	hash table parameters
	 *
	 * Computes the hash value for the key and traverses the bucket chain looking
	 * for a entry with an identical key.  All matching entries are returned
	 * in a list.
	 *
	 * This must only be called under the RCU read lock.
	 *
	 * Returns the list of entries that match the given key.
	 */

Beyond that, even though there might not appear to be any concurrent
rhashtable modifications, it'll be allowed in patch 6/8. Furthermore,
rhashtable actually does concurrent background compactions since I
selected 'automatic_shrinking = true' (so we don't leak tons of memory
after starting and killing those 1000s of tasks) -- there's this
call_rcu() in lib/rhashtable.c that looks like that's when it's used.
This work is done in a deferred work by rht_deferred_worker().
