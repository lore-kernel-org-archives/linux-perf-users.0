Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49DDC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98D561130
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhJFJxX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJFJxX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 05:53:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F666C061749
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Oct 2021 02:51:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h3so1996720pgb.7
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Oct 2021 02:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xY1wsjX3U9J+vby4z0tgc9K9/jXmFxDsS0cLl5E86uY=;
        b=ANb47Ig3qYsLdrRAHPmoVR7LSbJ5LeLfmpO6W2110v5rUWkXmo+MW53cdnzNPyLkQx
         7vexeBQlLHwD3vmxquJZCVwpkcICKDhUSHNNbblbTdeLhZcZg1GWTTo+JAEPVPCtfyD+
         pXq+tRjitdrJpnVDboG9Y4NcHSBwXYLKm03/RkFoEKkuEb/220+HpkR5RnJzeEg351FS
         aezW3H7otz3MwMh20B6I0y3wZd9t+F4fzbWe74yMNMUKDLUXFtPHAr33GM+YoF1XMErx
         4eYKcARMFcwIPYKMYTz6jvtO7zmgbktB2JGKX/wbekbfGmyQwNIq167TiLYIZuCt42Sc
         GdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xY1wsjX3U9J+vby4z0tgc9K9/jXmFxDsS0cLl5E86uY=;
        b=pWz24dtaryIY6tZ5rsENSyEqh+EP/tTvDUHfm4gPDt6vRw5inHWx7IZMHCjdy2SNmC
         jTEcLPUWpZ6YJr+fpA2s8Z+CrbxV41a5GQv9nK40DZi/cFZlknpUhIf5MMxn7fwEPKfR
         RAX9xgt3P5Dkv0ibxvoiPbTasId1m7NjLo4w98Xx1U3MqI+IDsOTexuyJB+qMCwnpjDp
         jyDzxhOevM/4lcTirhJXQQJQmV4TmVBNyEeO6iOblvwCbaLjbW9FhJLmC35iMfGjiEmP
         S5WFn0AT5ylwWo5oSB6l5C0dCWgoBbfHvI/2+49YScLwWb4ZAnch6Ui3q5m+Bh0LqzTC
         X0OA==
X-Gm-Message-State: AOAM532q2ikBohcZa3gCUAfGf0FaCPuKL2kTD5m9to/IdlAwqhFrpIPs
        b6McEXdoLXPNBu4+NoFpPZ4cDQ==
X-Google-Smtp-Source: ABdhPJyGC3VxxHFgXMt8iQ5UX29PMW144cZFgpYFwARgshb7Sw0gJxoVOb8zQ4xK6RRx+3NI55Eqsg==
X-Received: by 2002:a65:6107:: with SMTP id z7mr19756459pgu.43.1633513890524;
        Wed, 06 Oct 2021 02:51:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.210])
        by smtp.gmail.com with ESMTPSA id t3sm20529834pgo.51.2021.10.06.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:51:30 -0700 (PDT)
Date:   Wed, 6 Oct 2021 17:51:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211006095124.GC14400@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 06, 2021 at 10:35:20AM +0100, German Gomez wrote:

[...]

> > So simply say, I think the head pointer monotonically increasing is
> > the right thing to do in Arm SPE driver.
> 
> I will talk to James about how we can proceed on this.

Thanks!

> >> (note that the patch will skip the wrap-around detection if this is the
> >> case,
> >> in order to handle both cases in the userspace perf tool).
> > Almost agree, I read multiple times but have no idea what's the
> > "both cases" in the last sentence.
> 
> Apologies for the later part was not clear. What I meant to say was that
> in the original patch for cs-etm, it seemed to handle both cases where
> AUX head might be monotonically and non-monotonically increasing, so we
> applied the same for the Arm SPE patch.

No worries, thanks for explanation.

Leo
