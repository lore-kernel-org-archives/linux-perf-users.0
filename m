Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B85C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 May 2022 01:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiEPBVe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 May 2022 21:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiEPBVd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 May 2022 21:21:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5C22FFD5
        for <linux-perf-users@vger.kernel.org>; Sun, 15 May 2022 18:21:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so15928992pjv.4
        for <linux-perf-users@vger.kernel.org>; Sun, 15 May 2022 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DnZUEuoro7vADmaPy0ctVU/6juHiWDe559Ju8L33O3w=;
        b=c0996tba1uBLb2uOkYSNKritvSTe4uCArCuyafC6mKmW43WVbEXu7fVJ7Mq9E+qa/R
         HQdVrYao0vp3KWB3xCqdRUyASqssrS/pGBBu8NxQ+xghxCuvDBFzI/fiz+fPQV5/P2MI
         3mmtu6c+7AJ9Mj8Rs+nrtVCVo/8o68QOW74uSqbuffWI/i/QFCvirGYFnHmgj05g6yjY
         Mk2J0mpP9+m0Xhnd5q9nDaIsQyHKLBeUlYKvq6hkIu0FsXc0XFDOdJyn23HWgZolWlPT
         wwpurQi8TQH5GfyFp3PQhrAH4jiU8VWwBYkIvb7Vr/St2KUUkqaX4gZfENKKWnjZWTWL
         azJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnZUEuoro7vADmaPy0ctVU/6juHiWDe559Ju8L33O3w=;
        b=zOd/enwttD1KWfASdrTXo/wwfSRJqOa0FFNW2W9sEzyLZNzUViyl/tIG5JOMoAjgG5
         tNAf2EuJv0nXdrL6vTv7BN4rMsxu3RsqJ/RNxNVSYpCmPg9ROPMarlx0yNdbujXCFJBq
         7EZhBnDA/6QT56UokkIIV3lUJFFdl32mrOIuEaZG2xmjnpFBFEyXnjGpzvp7tHjhc9ml
         ntLTVGAV2zN5tdVsoRhchHFDIWa2GRopGp8O6LDAcX+wICvnfYudo0kZleRllldSnb1u
         X8/Mi7XYKxFG75gGBoQS+VfDtwo5Bu4K0nMxv+C6m48Y1aJYb+rxW9/075eZRwYoxkm0
         jdXg==
X-Gm-Message-State: AOAM531/XydMcZXBx8VgcWQ1Vf1VCUK57bbDkjojkxxEg6qRSalZcF+C
        4JNv7g5niJE6xiyihI9GPjOi6Q==
X-Google-Smtp-Source: ABdhPJw5cq4PFCQoQ7M8kRFGpY0I8hMjldG1jZAYNRa1AfHZ9GnZekWC6gAMrm52Fvlq7s/fMVdLwQ==
X-Received: by 2002:a17:902:f78d:b0:14d:522e:deb3 with SMTP id q13-20020a170902f78d00b0014d522edeb3mr15476981pln.173.1652664091969;
        Sun, 15 May 2022 18:21:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id n23-20020a63ee57000000b003db8f00aba0sm5555882pgk.0.2022.05.15.18.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 18:21:31 -0700 (PDT)
Date:   Mon, 16 May 2022 09:21:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "zengshun . wu" <zengshun.wu@outlook.com>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tor Jeremiassen <tor@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 2/2] perf scripts python: Support Arm CoreSight trace
 data disassembly
Message-ID: <20220516012121.GA56920@leoy-ThinkPad-X240s>
References: <20220515071838.3077178-1-leo.yan@linaro.org>
 <20220515071838.3077178-3-leo.yan@linaro.org>
 <CAP-5=fWx1ODacj2H--uH53j-jvcrTUJF2KwAyD65uU34kHYQfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWx1ODacj2H--uH53j-jvcrTUJF2KwAyD65uU34kHYQfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, May 15, 2022 at 02:18:53PM -0700, Ian Rogers wrote:

[...]

> This looks good to me and will run on python 2. The code would be more
> idiomatic in python3 using f-strings. I'd rather the code was
> idiomatic from the beginning, but others may disagree and prefer
> python 2 compatibility (python 2 is now end of life). f-strings are
> python 3.6+ and so have been supported for 5 years.

Using f-string is the right thing for me, will update.

Thanks for reviewing and suggestion!

Leo
