Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C2C32771
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Sep 2022 16:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiIZQHW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiIZQGv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 12:06:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA122ED4F
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 07:54:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so12696596pjo.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=kKFISMF8y3UineE1SH2S8n91CZBFI7ucs7QvcNIP1eo=;
        b=ub/tjcofVKs8dZhq8NKKsRXUHATcafd3A6sc+Xf4tb5skXyA7ZN4Id9uToPQpx546/
         k7snccIY4Ghvz1ZfHfUHoRFZOfK+yGVyalHcrJc65DY3M/feAN6SJcp0NUieezE0Z/QQ
         f99fZwZPcyxsySurBO1kutJvaSTVzf7mkhQXKvQAHfF92o0C0ur9rGd7eWHNHrCrNVcV
         eDlooqsVPv990JymmDDW7ZGVcnQTMjwEzLSdFdYHugHLDjxsKuD+5ZpC+q4ZiZ0mlYBy
         TWIorBs27Gy7ECdqa7Nto7RTuY+nlhouyTwoCjjhrGSXNTDUv3+xyrETr6OiBP6rJ8KS
         4+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kKFISMF8y3UineE1SH2S8n91CZBFI7ucs7QvcNIP1eo=;
        b=jK+ePLJsR7KLvxqiJ1sROWXwui6kUHzO0GGVsPX7NcQ7+sTAfYz9ftGZCkDq0l8d0K
         V9HWwRtG0mgKktxDmm+s4LJUXJvn6SIyr6qZFI+X1+VqYSQKPBFXSe2nHu+y9MHXmjmv
         xYt/MeGh7R5MH0LXn4Cc9JaHGPyqR5mVMHawQ1lHQIU6QMhs5X1oGUxXTckXM/NeJLwo
         CKbOfc5hugS9Y3Hfw7x23KjJIM+eqcLBVnPY5DEcy5W0YDiKusz1SXcrP1/X3czLcpTm
         I2hxxRT9kIxIuv9U1r3eKeyUuHgr2ATDreVkN/M/lB7gPA9rLMeT63aJBhOy6VrWVGQe
         NpDA==
X-Gm-Message-State: ACrzQf3B6jN5/Nb9iTqUJ2sd2AgpYcHRU7a85KAVddJ4KElgv0aCvNXb
        sNxjvxphr2/oGQ+3+45PJrLmFg==
X-Google-Smtp-Source: AMsMyM6ipv9MuqOqf/u98HYXMaP1pTXWs7eWPOXMmYQPczfjPw+3vk7F6iQPuzMNWBgDKUi/WpGhVA==
X-Received: by 2002:a17:90b:388c:b0:202:a29d:6e6f with SMTP id mu12-20020a17090b388c00b00202a29d6e6fmr25587905pjb.231.1664204091215;
        Mon, 26 Sep 2022 07:54:51 -0700 (PDT)
Received: from leoy-huanghe.lan ([137.184.34.254])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00172e19c2fa9sm11413162plg.9.2022.09.26.07.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:54:50 -0700 (PDT)
Date:   Mon, 26 Sep 2022 22:54:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Fix segmentation fault in
 record__read_lost_samples()
Message-ID: <YzG9Mz8t6aNn1ZwX@leoy-huanghe.lan>
References: <20220924113346.1110909-1-leo.yan@linaro.org>
 <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
 <YzGiMdIRRE8ibCiD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzGiMdIRRE8ibCiD@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 26, 2022 at 01:59:29PM +0100, Arnaldo Carvalho de Melo wrote:

[...]

> > > Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Thanks for the fix and sorry for the inconvenience.
> > Actually I sent the same fix a few weeks ago.
> > 
> > https://lore.kernel.org/r/20220909235024.278281-1-namhyung@kernel.org
> 
> collecting it now, and adding that Fixes from Leo's patch, ok?

Yeah, I think it's good to add Fixes tag.  Just remind, actually
Namhyung has mentioned Fixed tag in above link:

"I didn't add a Fixes tag as it's not sent to Linus yet. But in case you want it.

  Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
"

Thanks,
Leo
