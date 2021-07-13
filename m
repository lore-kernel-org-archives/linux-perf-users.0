Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243F2C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 13:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B696115B
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 13:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhGMNNP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbhGMNNP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 09:13:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D93C0613DD
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jul 2021 06:10:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 17so19573098pfz.4
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jul 2021 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VUU1Kwvq4GBakNNijA9o5ryuRCyw2WYxhJlpoTQmeDM=;
        b=F+19KqtKCMQP1/ZSGE0pKtTbAbaCy4Gy7dSnmcaKh6mlDPZcmZADNKNXMBl1BLmlgg
         fZEIrUhlTvD7ckmpRogdtNLrBgnsfug/fOz+izrAXCsBuGI0/sPaY1OJSok69hUjj9lv
         rVa5k8mLIVa4jvPEJ/12PMQYklfYqi7MASgtBYjPMYm9G1Evcn8hc8ckbGazly6vZYrR
         KwSrAj6hX0hr10iW7gIiUYzTx0HPlx4pYE0rPAQEtcRdax8KMDMXvkJD7TZ5c0qThQhg
         ehU1tXHaV5gJ7HbpAbO+ZJBWKRlgnzFrhikl7SigIricfVFBHxVVlvXoZZdzM1zalEFs
         QzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VUU1Kwvq4GBakNNijA9o5ryuRCyw2WYxhJlpoTQmeDM=;
        b=jo8Q8T3qt/wXAok3raGuUX3zzdOqyEGl0AmzBxagqkE/Tc30BBzy50PT/Rc9+Dxz9N
         lLdBpO67LggXiF5dAU7uRAir7gtWDwxsIhRN/TCnqI84OxtQak0RAopN7s7cEag+hXxu
         UadbDoy9eEexWfaYOEwwiyTEge3m0eEDEkbPpVNJ3TnCzEa5pFe4q5Tg6GraNpkPOv3X
         z4/j5Cs2D+wJnwb35JqsgE5kQRfVvsOvRYVXU/6heIVNBOvaTXLUfIjsY7XtA4+mbtcP
         yaPYUbmik0UfKfnITEzO92uzkHKpLMvaAzLUGhm+ec02Zf93tZ4uwU9vNpOuKy3zoY8z
         Okfw==
X-Gm-Message-State: AOAM531im4Z9eq7ZNI7p68zFJ+8tdMU0elA5DVACRsRJgqoDkqTdyyGh
        5yZhB/aCqDJjuRlp2gu3CP5jGA==
X-Google-Smtp-Source: ABdhPJwPLGUmEVAkt/uYOyw07UUtKM7cvXZoj28ALl+IDI3I8DSEq4m+ESyjcRWzcjoCA9/lSdUCog==
X-Received: by 2002:a63:d709:: with SMTP id d9mr4258879pgg.337.1626181825205;
        Tue, 13 Jul 2021 06:10:25 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id z13sm4449296pfn.94.2021.07.13.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 06:10:24 -0700 (PDT)
Date:   Tue, 13 Jul 2021 21:10:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 07/11] perf auxtrace: Remove
 auxtrace_mmap__read_snapshot_head()
Message-ID: <20210713131018.GB748506@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-8-leo.yan@linaro.org>
 <4c65b6ba-2258-ff36-2ecc-92219e61e578@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c65b6ba-2258-ff36-2ecc-92219e61e578@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 12, 2021 at 05:32:11PM +0300, Adrian Hunter wrote:

[...]

> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -1686,13 +1686,12 @@ static int __auxtrace_mmap__read(struct mmap *map,
> >  	union perf_event ev;
> >  	void *data1, *data2;
> >  
> > +	head = auxtrace_mmap__read_head(mm);
> > +
> >  	if (snapshot) {
> > -		head = auxtrace_mmap__read_snapshot_head(mm);
> >  		if (auxtrace_record__find_snapshot(itr, mm->idx, mm, data,
> >  						   &head, &old))
> 
> That leaves a nested 'if' which is not kernel style i.e. could be
> 
> 	if (snapshot &&
> 	    auxtrace_record__find_snapshot(itr, mm->idx, mm, data, &head, &old))

Will refine in next spin, thanks for suggestion!

> >  			return -1;
> > -	} else {
> > -		head = auxtrace_mmap__read_head(mm);
> >  	}
> >  
> >  	if (old == head)
