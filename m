Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB6C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Dec 2021 09:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhLUJgD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234794AbhLUJgC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Dec 2021 04:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640079362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2FSzsZgNLWGLz0XhMjKaJvgHqsF7frzjYDf7l6DD9o=;
        b=izAWx/U1hN6/q/GG0TiOUyOgSkluzzk34CgSIxyihshn8Oi4bPHu1B6pUXC0S66ygPfw6n
        RgRIMRvEbfrjlzMAOpoK6ij655oIWKfnGdp0LaiqKJZIYp277LrE8ZijM4vxE5giqQLzRM
        7tE81zpQ5lm8YcC4O1/R7m44e7JPO6M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-xuBhrOLnPACtKcHcsc30YQ-1; Tue, 21 Dec 2021 04:36:01 -0500
X-MC-Unique: xuBhrOLnPACtKcHcsc30YQ-1
Received: by mail-wm1-f69.google.com with SMTP id n31-20020a05600c501f00b00345b15f5e15so615217wmr.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Dec 2021 01:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+2FSzsZgNLWGLz0XhMjKaJvgHqsF7frzjYDf7l6DD9o=;
        b=QnbvOMoIdoDqjIJ4T5BRSV7QQJX/jnqk2ZAzjM9Jv+Uy3w31luYa849XR1Qq5nsuOr
         gcYNJapHcj3XzzlhfuDnEti5Z4doGMec/TyfKCQf4eP6Vvp3a2LdStNKtQDGttzlyUml
         ceICzsoA94+Ve2eFryNgkxRCdyI+hJ7du08MbKvQvH48ZTseGRjXrjelpVwQF/8OblPs
         jwFzBJJgUebG8GNUXBR1M1wViLPuQOVR4pjP/ORz7x+Yj7oh4YXkj9TBHPKJrKT4Qqh4
         J4I5cbT2zf7XjRm3VEz7DuGbnri7ilffdV0b8JFOS4g5rso0rhSJxP57YtpQBpjTllcN
         /oHA==
X-Gm-Message-State: AOAM5317itLxms8cetc0aBseODpidy6gc7ym09+lWROvBkQn2mdwGOvV
        loJYnxYwy2HMyq/cjl252bUxIUqusAJ6h4EL8wqRs6lP1ak5TWahT6HmRGVAvL3vlehuZMUBXvK
        LLYM3fNlrYhN+H09WR1afNgokQyLKUA==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr1833668wri.197.1640079359335;
        Tue, 21 Dec 2021 01:35:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/1aAdXtJSPl2esQ9FVWb9gI7srtciCVYmg1Xivyel9J/heXzg+Wlcav85MQtWHeLh0gkclg==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr1833656wri.197.1640079359208;
        Tue, 21 Dec 2021 01:35:59 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id r11sm17559494wrw.5.2021.12.21.01.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:35:58 -0800 (PST)
Date:   Tue, 21 Dec 2021 10:35:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
Message-ID: <YcGf/d5PPqqyXxUW@krava>
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
 <YcGJJ2g+i5qWea7d@krava>
 <bbf9c0b4-c048-3adf-5282-2355aa648acf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf9c0b4-c048-3adf-5282-2355aa648acf@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 21, 2021 at 09:10:37AM +0000, John Garry wrote:
> On 21/12/2021 07:58, Jiri Olsa wrote:
> > > +	/* Different names -> never duplicates */
> > > +	if (strcmp(alias_a->name, alias_b->name))
> > > +		return false;
> > > +	if (!alias_a->pmu)
> > > +		return true;
> > > +	if (!alias_b->pmu)
> > > +		return true;
> > nit could be:
> > 
> > 	if (!alias_a->pmu || !alias_b->pmu)
> > 		return true;
> > 
> > would be great to have more comments explaining the check
> > 
> 
> This is just a sanity check that both strings are non-NULL as we do a
> strcmp() next. So would this be better:
> 
> if (!alias_a->pmu || !alias_b->pmu || !strcmp(alias_a->pmu, alias_b->pmu))
> 	return true
> 
> ?
> 
> It will spill a line.

sure, it cought my eye because the is_cpu check later is done on
the same line, so I started wondering what's the difference ;-)

jirka

> 
> Thanks,
> John
> 
> > thanks,
> > jirka
> > 
> > > +	if (!strcmp(alias_a->pmu, alias_b->pmu))
> > > +		return true;
> > > +	/* uncore PMUs */
> 
> 

