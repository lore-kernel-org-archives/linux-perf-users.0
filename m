Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AD5C54EBD
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Jan 2023 01:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjAJBpT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 20:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAJBpT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 20:45:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D82195
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2023 17:45:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so14799205pjj.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2023 17:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drQcN15jA9pCSZSjt4qzMvYyUPllGCNymcmpFqlpOWU=;
        b=OsmyZtaBm9t84mXKy0SMMBIOeY51LPl623bAGY3fyEkQSwdm7pJEqRsgiJTRjnnPOh
         2ZJ/BAeQQxb5dSY1ZpYlJ/kFq4xMCNxah8ouM1L8xgMT4wIQj2dUEqIf8SqG8uFpgcYt
         moVZUk+YJ7ClvTkYdMn5ftVpxqW5kqdZbKaUAmDl8EJ36ECt0gUfIUzgqPzYdydOWVeF
         DoZ5uQKkuDeqhl0buonNmY2mHSjFe7LzV+MauszDd9XLM8MgzB/3fXLRWKnzkoI2aeYA
         P2QwDo5oHQepa/THerf1wxDw6Ij6n9Huc7LCEQZ5RYpWSiy7WvoOXoiGJmIkUtNpc3ex
         5kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drQcN15jA9pCSZSjt4qzMvYyUPllGCNymcmpFqlpOWU=;
        b=a+0P8EDZyV+2WqFHM5FEmw4R9L58PpppPpobMllOdcLN93qnRGmp7qCYg96nLiwH1X
         4pl6rEOv/WR1h4LCAWdzCCQ2Lsm5P0kqEQAmED2Vq0xu+e2o96Q1rg3XNI8sCQsgTJr0
         833Vh3zGSCVeZpbcjbM3qXWPj00zZHN7B4sjsFJ0Om5yJp8X9pSaW3vVE7bnBUQd5dBe
         mkOVQTBq67WFcOzbzUD4nD+o+t4NtzMVwyMsOna5rQ7nsuLJ+4PCNC4zFfVpMLgCnKQx
         /KJNRH4ChYVcw5IRc6z2ZVC1aD9XYwBEwH0W8sULdli5MFRBtDpZc5DwWJxaQiboYjHd
         xCZA==
X-Gm-Message-State: AFqh2kpdGB0rgs3j1EN60i9keYMu/EyNKZltEBZP4C79y7OevrOv61q+
        E0qmMB28lwvcqMrDWw2gdAQJPQ==
X-Google-Smtp-Source: AMrXdXuTX+q+bW/i9WBa80Mwm7w6MPhe2XnTu2YVzKgz1hvOTH6uBJ3UX7fE+0DPJUSjdDnFigkZWA==
X-Received: by 2002:a17:903:26cf:b0:193:236:3a2b with SMTP id jg15-20020a17090326cf00b0019302363a2bmr16154130plb.3.1673315117422;
        Mon, 09 Jan 2023 17:45:17 -0800 (PST)
Received: from leoy-yangtze.lan (211-23-48-221.hinet-ip.hinet.net. [211.23.48.221])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b0019101215f63sm6797214plh.93.2023.01.09.17.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 17:45:16 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:45:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf kmem: Support legacy tracepoints
Message-ID: <Y7zC5imskN9tvtBn@leoy-yangtze.lan>
References: <20230108062400.250690-1-leo.yan@linaro.org>
 <14dd06c2-39f8-ccb5-ce59-f3a1e45c94d0@arm.com>
 <Y7w03A7f2zUWwihm@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7w03A7f2zUWwihm@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 09, 2023 at 12:38:04PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > +	const char * const slab_legacy_events[] = {
> > > +	"-e", "kmem:kmalloc_node",
> > > +	"-e", "kmem:kmem_cache_alloc_node",
> > > +	};
> > 
> > Reviewed-by: James Clark <james.clark@arm.com>
> > 
> > This fixes the error with mem:kmalloc_node for me.

Thanks for reviewing and testing!

> > I was thinking that it might be best to add all events to the list
> > conditionally instead of just the legacy ones. That way, the same error
> > won't happen in the future. But maybe it's best to have an explicit
> > error again in case the breaking change was unintentional so it's fine
> > as it is I think.

Yeah, this is a good idea for refactoring.

James, do you mind to send patches for this?

> Just applied this, the changes you brains stormed may come as later
> patches, thanks,

Thanks, Arnaldo.

Leo
