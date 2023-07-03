Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F0FEB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 12:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjGCMqh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 08:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGCMqg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 08:46:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2DCA
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 05:46:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-314172bb818so5071578f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jul 2023 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688388393; x=1690980393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c/79rfMRjpcwLCOmyx92ptoqeCBOS3BP6XcahjrCSAk=;
        b=hSCpnp9yUnzVAFZ4O8bs/QvQ5pUMK17iyGi99r2c/pe1HrbY2+ej9D2V1XR/fYvbIV
         A/yN3jsqX4ROVNjPL2H+0QTv8UcpMh3/en2zcjYN85JMoX7IJ8rIrCd9tc93MfKtHwdY
         8OPFTz6J4gPWX7Av3gcxFoJoi/2DXjaZIN/2TJY7M4DfoMlcx0OpN1POtAH75tksA7Yb
         xIl9fekIJa4BNC/sA6OBlFwQ3o+4XquAnDxYP8VHOKqyEiJ5rHgbTnHVUisc3xJ+1uBL
         t3cxiglooe9WX2yTxqXkncBug5Kw9+rgR+ccWZKIDuYz+KomMuJJL84eYPTMOIdF67Is
         Exkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388393; x=1690980393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/79rfMRjpcwLCOmyx92ptoqeCBOS3BP6XcahjrCSAk=;
        b=DPpQUn08LxBsUKCAk12dmXTnGtxyzAKxWCtKmIGHptOOO4GuW8Ow4f42F4NTZ6JfNQ
         dfNhp38atjGzx247XmUkvK7S3vnm5bCcBvrDp6IibSQpkMhFf01FA2bXNJoIQD8qiisu
         6LnyyW6gpkUByj3anOLXD5gRBJXMt0hV7K1RsUhKMvZezAL2MWEc7Kz5VjK7ij4THMxg
         JjQejN8ndIL4iisZOsq11Uu7CgS1K80mANvVJg8M5PGku7TTAeBiZ1jv1waVYIvIppXj
         MgPVmtTLIaNwrSIRxZDbr5inP6OE0zb/c8FBMvXuHGt8cws5bOS/BkNSeuov7b0DbnKM
         Jx4Q==
X-Gm-Message-State: ABy/qLYYLFqBqnQ2hegfocfBQyOEi3BAnHz+B33Q6/4ddg0BDt8hCCwh
        x3L8uzxFGJFmRNG319QyeqXxXA==
X-Google-Smtp-Source: APBJJlFKvCGlRhkpK4us53cBFtT4zZ/fnBK9/a4aEGOPnNXkNQ8FNrgDBBOqv4bnTejmfq33R8m9/Q==
X-Received: by 2002:adf:f60c:0:b0:313:e741:1caa with SMTP id t12-20020adff60c000000b00313e7411caamr9199998wrp.25.1688388393212;
        Mon, 03 Jul 2023 05:46:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b3-20020a056000054300b002c70ce264bfsm25687679wrf.76.2023.07.03.05.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:46:31 -0700 (PDT)
Date:   Mon, 3 Jul 2023 15:46:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/13] perf parse-events: Remove unused
 PE_PMU_EVENT_FAKE token
Message-ID: <4eba81ec-14e8-4204-8429-4b686881a9df@kadam.mountain>
References: <20230627181030.95608-2-irogers@google.com>
 <8dab7522-31de-2137-7474-991885932308@web.de>
 <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 10:05:22AM -0700, Ian Rogers wrote:
> On Fri, Jun 30, 2023 at 9:35 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> > > PMUs before parsing").
> >
> > Will the chances ever grow to add another imperative change suggestion?
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4#n94
> 
> 
> Sorry, I can't parse this.

Markus is banned from vger.  Just ignore him.

regards,
dan carpenter

