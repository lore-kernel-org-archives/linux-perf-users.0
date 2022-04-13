Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF513C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 08:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiDMIwK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiDMIwJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 04:52:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC771E3F3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 01:49:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so2458507ejf.11
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=myQN5zwIxidXWuPBDvRUhHNH8sCmGtOuPJvRTtcxjNQ=;
        b=mvSxvuI2U1976SNykleLyoIWy6apoBOff8UxlQuOR8SuTjlt881VmEvixrfYHa/F2+
         bcfwlQ/n92LvSG1l/ZX4KQ0bmEU7izNdYXJLrRvG4wX/R+EF4WdJOgt0ozITqKIltPAG
         ChR46FzyZ/opZVIJcCSwe6Rn8SYyZcwKZ/1iiv1nTCh1HxLC20rVrOknAGhQvemKt/4Q
         QCVMz/iNnni61oXLpjCynZ5fB8OtRUVyn0OIE7nQusGFo84tb0OfGW9zNkHP8N/FscpG
         QPQOzw8Lxk1nxxOXaN/uOkHNn+gD1I9RAvQ0/W8pnP8eHJ3Hjow6oE/ysO9b+mAjSEFP
         rUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=myQN5zwIxidXWuPBDvRUhHNH8sCmGtOuPJvRTtcxjNQ=;
        b=QFZT0v1WnHMTISRL/0PXcFH9+jdaVLfaJpAT8G7Q8qPNNImUpVfd0C6P3MAT6n7dtW
         PC7k4CjAuTSwZS4/E4K+rsiJ0S3yX/Hx++XiAPxq5z9BEU4wfxP+9597KiZs2He2uPIm
         j+X10nlRUtf1W/zX0ygDvfiZt7+RcqXTlcvU47zVM3+uX9af+Hzmi5qTwQzaWbJ9Qlfe
         Tl2H0JpMwVwUBQGUsJL9XtBKr2VKbApgEZmKq8pZGKBohDrAGzOfpkOr7BqtBejsFgGH
         6SZvmnj5nEAvvLrKk4ohZ0i2sLZfrjh2GhhRA5nAo4yyV75P8gM56Dok6bPhDOafEUIH
         uXDQ==
X-Gm-Message-State: AOAM530bIjtg7I50g9VvYi6WtItYs9JvQnYpx6DXCaY66swEO+lJiGyR
        IWE1jFk0Q4vwVmTcQAtGejjBlA==
X-Google-Smtp-Source: ABdhPJyH84kGNwFVc8bERhuP9415E/89jgK5EBnGeEdVIHboafgslVnuVuXFSCxcAy8xqx+NIi/tPA==
X-Received: by 2002:a17:906:a2c5:b0:6e7:f44d:ed7d with SMTP id by5-20020a170906a2c500b006e7f44ded7dmr37860806ejb.329.1649839786956;
        Wed, 13 Apr 2022 01:49:46 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id d1-20020a170906174100b006e85e9903f2sm5659449eje.89.2022.04.13.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 01:49:46 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:49:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE
 event
Message-ID: <20220413084941.GB521036@leoy-ThinkPad-X240s>
References: <20220413075124.635589-1-leo.yan@linaro.org>
 <c21b3409-a8a0-aae7-7634-5e648f0a49b1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21b3409-a8a0-aae7-7634-5e648f0a49b1@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 13, 2022 at 09:15:40AM +0100, German Gomez wrote:

[...]

> >  	if (sort__mode == SORT_MODE__MEMORY) {
> > +		/*
> > +		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
> > +		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
> > +		 * compatibility, set the bit if it's an old perf data file.
> > +		 */
> > +		evlist__for_each_entry(session->evlist, evsel) {
> > +			if (strstr(evsel->name, "arm_spe_") &&
> 
> This didn't work for me when the file recorded "-e arm_spe//" instead of
> "-e arm_spe_0//". Could you remove the trailing _? With that:

Sure, will change to "arm_spe".  Just curious, if there any local
change at your side so we have the different event name?

> Tested-by: German Gomez <german.gomez@arm.com>

Thanks a lot, German!

Leo
