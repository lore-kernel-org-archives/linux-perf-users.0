Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C2C74A5B
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Mar 2023 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjC2Osj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Mar 2023 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC2OsY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Mar 2023 10:48:24 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6B127
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 07:47:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l184so313921pgd.11
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680101256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vkIx82vxHUxasJUQGPHlcad9JIpsq+cAvDr1GutREnU=;
        b=w2hGU03ndtZNATot+6jleng8JvxmnajdGyNHS6uO4tn7ZQ4LbqTAhwJ2fD4lzKHm52
         Vldv8QxUmibNgV6p+bxQmJ1vQK7GPBU6I/wIAmHawV7cf9zt7jRFcPKGr1t0IFi5dDX/
         SawxTalo5eCK/CGbx4g/m3WKDFK0GUwbeURuiok6t8Kk9cVBITXx3DB7i2/minjhGYVW
         gU4eSyRc0OJiJ44FoOVUhqbvqBwiumA67wNZCvA8fHpqCne6wChuajU3vPvth6YkP8V4
         jy5FC2fzuOMP/TX911Gpq+x/Zr5GUoAz1ZGtDzn6NHmyfoUeSwjisLWDwDYQUtf+u6yy
         j0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkIx82vxHUxasJUQGPHlcad9JIpsq+cAvDr1GutREnU=;
        b=QtpKSShgcgkUkMuiyasisZhyv8t2WUghC5nhbdQnfKCiUrSnza4JWur6dXC0Ocd5KC
         WRnJeP0TQGsrvHkimJ/3MUyYA/eyk6CEsWPGfLpiZXY5O7r6YF31dQnpcQOYIwTxpVef
         QLzvIyRzaIdOLXsqsRTPh1GdFSG5GPrZXYJUT5qoOOELUNVo+WobRYW0ouifJ5NHuNJC
         00KjtrQyWerB0cqCRIiu7YYJrQrCF3/TRfVHDbZzj9j1tX6EZbqct7k9nt8BIdgCAq7E
         TpJL64S815ZJiTe/1B+X+oHm/x4KqIxCJLyV+m5F/ppjM9i3dP625bia54OuXuuVENx9
         FIxQ==
X-Gm-Message-State: AAQBX9fcUgxgyq+7GMS8wsapSKd1C3sjQsNxf0ry5+AYDnk2PXOpSIwt
        XQKIVTWxVJeasuonPCWGJjmzrxdZm8qd7UL7W4mZiQ==
X-Google-Smtp-Source: AKy350b8EHJoKCyK8Zr0M23UFnC3QLJmNC+h7Va2BvOe0Y6c1aHg5e8SQUnYr7TFmbL5LW+oLTMvEctqsRKad18gX1o=
X-Received: by 2002:a63:d307:0:b0:50b:dda2:6140 with SMTP id
 b7-20020a63d307000000b0050bdda26140mr5521846pgg.11.1680101256089; Wed, 29 Mar
 2023 07:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230329111422.3693-1-mike.leach@linaro.org> <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org> <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com> <ZCQ7nhrISA+jCfnI@kernel.org>
In-Reply-To: <ZCQ7nhrISA+jCfnI@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 29 Mar 2023 15:47:25 +0100
Message-ID: <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 29 Mar 2023 at 14:22, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Mar 29, 2023 at 01:59:10PM +0100, Mike Leach escreveu:
> > Sorry - my error.
> >
> > The same change is made in patch 3/3 of this set.
> >
> > Looks like I didn't do a patch by patch build check when I was testing yesterday
>
> np, its fixed now and pushed to tmp.perf-tools-next, please check, will
> go to perf-tools-next later today after passing thru my set of container
> build tests.
>
> - Arnaldo

tmp.perf-tools-next - Builds and tests OK

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
