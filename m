Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE3CC47080
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 16:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26FC61042
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 16:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhEaQzO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 May 2021 12:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhEaQxJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 May 2021 12:53:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9647C08C5F6
        for <linux-perf-users@vger.kernel.org>; Mon, 31 May 2021 08:10:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g18so9228195pfr.2
        for <linux-perf-users@vger.kernel.org>; Mon, 31 May 2021 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ET6uFordsiWwX4MCNMKhRus+C3EuLNdh9eoANIik8+8=;
        b=uxQrV6jJGwTClKvYEfNPzMNvPtOF0xpt3MjLEvYdAfXOqfEmfb8IImhakUa3zkMp9w
         GoNx9HoqHI6R2jqa89T+r8zAz1WMhF1cjeYu/SzQvv52NEsCZXsdlEgdsdVhEDKSvfzd
         lzzdZhsik9wljdNu6FTmVNKsAiqEBi9rxNwaa/j24ifcxmMrqGJoA4eiL2ayWkfqaMl2
         4vLJffCJ1AvynhPt9UEgyPY07zqAZJ3je3GM62hZsgSY4FHwoMoab9p0un6t6U9WzoiC
         g8gXwT6xuXjQbdhZK+EPpPHSkxgl4ZexOL6IycLGCPK44Hc5+vdY2ZEBbOskzRjMy7Kt
         K1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ET6uFordsiWwX4MCNMKhRus+C3EuLNdh9eoANIik8+8=;
        b=gczmBJm6PikRv+vjt/np4db/shpE/hGG6SwKANgfJvTwrq72vojA5T8Jwtz4j/uvuf
         bkZJB0L00fdRVWUjwRQSWlAIHUcC2KFrXmpTS/Aa5eWZXcQMbl3dzAQ2p5escWwR8jCl
         8aUcYgK72IlhbLLWN7v20euln1vdnWfTVi/g7lY9RbJI1kmKyyPWYd1fftIgfEyXhcpv
         zL5bFfmhdyedb6DufmvZA6ozmvRvBV5CXiHsoI+Kg4nc1uLK/Ap9j5D775pVUDa9GuOO
         TtIS9l5wwcOpHIL+16F+zAXkVFOUbdzwi2Fzqe61mUDt4uMhFR3c4GeNOSlFNv/h/Z5B
         5rYw==
X-Gm-Message-State: AOAM530qM93LVAhX4KwWd/mKXcstaOWXsgr2uHq6EgbhkQmqZxVV8N2p
        Ik5FH7EHFcqwQR1B/pL6BA/GoQ==
X-Google-Smtp-Source: ABdhPJzMMkejZt3VKTL6ctQVH8j2oDFU1XAa2OsxjE1kMvD4VotB6aVDwnJd8mL3JHN/jChYu0s0fw==
X-Received: by 2002:aa7:8703:0:b029:2da:b87f:7d38 with SMTP id b3-20020aa787030000b02902dab87f7d38mr17753307pfo.20.1622473854083;
        Mon, 31 May 2021 08:10:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id md24sm1519907pjb.43.2021.05.31.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 08:10:53 -0700 (PDT)
Date:   Mon, 31 May 2021 23:10:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <20210531151049.GE9324@leoy-ThinkPad-X240s>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519140319.1673043-2-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Peter, Adrian,

On Wed, May 19, 2021 at 10:03:19PM +0800, Leo Yan wrote:
> Load-acquire and store-release are one-way permeable barriers, which can
> be used to guarantee the memory ordering between accessing the buffer
> data and the buffer's head / tail.
> 
> This patch optimizes the memory ordering with the load-acquire and
> store-release barriers.

Is this patch okay for you?

Besides this patch, I have an extra question.  You could see for
accessing the AUX buffer's head and tail, it also support to use
compiler build-in functions for atomicity accessing:

  __sync_val_compare_and_swap()
  __sync_bool_compare_and_swap()

Since now we have READ_ONCE()/WRITE_ONCE(), do you think we still need
to support __sync_xxx_compare_and_swap() atomicity?

I checked the code for updating head and tail for the perf ring buffer
(see ring_buffer_read_head() and ring_buffer_write_tail() in the file
tools/include/linux/ring_buffer.h), which doesn't support
__sync_xxx_compare_and_swap() anymore.  This is why I wander if should
drop __sync_xxx_compare_and_swap() atomicity for AUX ring buffer as
well.

Thanks,
Leo
