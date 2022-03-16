Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDADC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Mar 2022 12:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350597AbiCPNA0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Mar 2022 09:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348633AbiCPNAZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Mar 2022 09:00:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812302251D
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Mar 2022 05:59:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so2882454wrp.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Mar 2022 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jzYXuFw6t1GGQ3e3ytY3BE4kwazLUF9JZA0pvkZu3z4=;
        b=iQaN/Sbaut6GOISotqqPoNkJFQ+MWqEf1XyixuSqzk0zUegChILr9hjzs4eQAEcGFf
         5CbZdnbhqzW5BGerIU7MGk1y+KdFteT4OozVaSQLCxXaEeOmOjeR9jdrk6skw6iDuE/M
         55uSOsAv6jbfabjZ0U8qoS+KtLcxO/ASaH91YcQsEyFPANKaNZiO16GPjBajaO1gDQXo
         FLH8y76ix2FlS7eAoA2QgLdQYhLJqaZ3jdEKhdZ5bKTQhsQswFwt0dHS4EoFIQ3LqftF
         x3cYxP5ysX1NdyRaRYKew9ixCkmyjfNbrhDhMPXoL44gIVES779zI9pOcwo6O4NSejw5
         AxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jzYXuFw6t1GGQ3e3ytY3BE4kwazLUF9JZA0pvkZu3z4=;
        b=bD7GmzeIkWCL5vZxrYwfBER4m6bNmtXSRWuFaKiWPVTZiQxS0LKQFJB7NDc4nEMJXW
         16xy6nMX75r4NkIsQSdGnQ3BACXNNJaglBIR+CNfWyfiFp+3mqZb717bMaZ4DfdZmjgT
         N9w4MG3ThCy9Xb0+8oihad3FV1z7o9+QfXcBNIdKWtFg/Y1RxbyhuMsaN04g9cQzoD3H
         Kf030DqFfObk+q3FJd2wR2v0OhBf5not13FRMC6YxC3amqQIJPxO1hKWEZZtAPmK4ZiD
         09wAmlKFf+xXe/lUImUOZ7bIC5TMgq/LiY4m4LFS8DsvWKJHyYviqk2Yu1CQtHSbMA3I
         IDYQ==
X-Gm-Message-State: AOAM533p43ZkQOk5Wol2PUvsx9hy9RGJ23MuG9PC9RTkm/PU5ykkRXEJ
        iiJcDkFRAomwoW+Ae7Ue4lx+yA==
X-Google-Smtp-Source: ABdhPJy4Hy20R7yN9hagwqQupnDiBP8RLHhFW5oKMad0+kO9NjMwJuHWi2WWa16dNvC0YERmuq+J0Q==
X-Received: by 2002:a5d:6344:0:b0:1f0:21ee:9705 with SMTP id b4-20020a5d6344000000b001f021ee9705mr23929753wrw.93.1647435549892;
        Wed, 16 Mar 2022 05:59:09 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm1681873wmh.33.2022.03.16.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 05:59:09 -0700 (PDT)
Date:   Wed, 16 Mar 2022 13:59:06 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Synthesize cycle events
Message-ID: <YjHfGrZovk3N/H0f@google.com>
References: <20220310093844.982656-1-sesse@google.com>
 <586de5fc-858b-2693-1986-5c77e8c0e3d0@intel.com>
 <YiuKAk7SaXP7B7Ee@google.com>
 <ba2c49da-22c5-06ea-e953-82211b953ca8@intel.com>
 <YjBnet2813sEGjZY@google.com>
 <c50bb87d-9fee-c4f9-a350-8729e503e43a@intel.com>
 <YjDUO6bbyfGw/u0C@google.com>
 <52903e58-e74c-5ea0-36b4-277ea3610af4@intel.com>
 <YjGdoGy4Z2UUG9S9@google.com>
 <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef780335-7dc6-3a23-54a8-b6fc9c8a2ed3@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 16, 2022 at 01:19:46PM +0200, Adrian Hunter wrote:
>> I guess the good news is that the perf report coming out of your version
>> looks more likely to me; I have some functions that are around 1% that
>> shouldn't intuitively be that much (and, if I write some Perl to sum up
>> the cycles from the IPC lines in perf script, are more around 0.1%).
>> So perhaps we should stop chasing the difference? I don't know.
> That doesn't sound right.  I will look at it more closely in the next few days.

If you need, I can supply the perf.data and binaries, but we're talking
a couple of gigabytes of data (and I don't know immediately if there's
an easy way I can package up everything perf.data references) :-)

/* Steinar */
