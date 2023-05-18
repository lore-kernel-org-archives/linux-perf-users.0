Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F29C77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 May 2023 03:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjERDVi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 23:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjERDVh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 23:21:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B549BD
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 20:21:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaea43def7so12177075ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 20:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684380096; x=1686972096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kW4QnyXVR0PAqTI0tb+JjZUYnzKTdDvya2HZzdF9cZA=;
        b=lT/82HHToFF6i9J1TGW1VuOMpeaecywIiegNEnhXiGL//GKrl3LRWNg3MxXq4rtiYt
         IYFD+h6WWJnqM8hqu7/AD/f8Rn+fSWEvNgp1PjUGGammL5UnQHOG2F2rDW6XTXqopy57
         n5vVeU1j8Y84+cwysfWj2oMq3QOzJEZsmrwDjlGcH6vDNQU+6dXNYlmvdFDWiqQPV7k8
         /nKVCsjZ/1uFPBmUUxhLhk5fltlp6cFp0Gs1/EanL9ZlEIAWvUjaSIr6tOpPQafX6NzD
         61vBIoTbbQu4N4z9PGghPSJtXOpXE6LxBscS+aDfKsHqq8/i7j15C1fALreLrTZ/moKR
         Uv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684380096; x=1686972096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kW4QnyXVR0PAqTI0tb+JjZUYnzKTdDvya2HZzdF9cZA=;
        b=hRCJO6AQPw+xzu0JWAmX2qxsrS8o87pK1jEfA//NRc2grYhNGWRlspP4XTWb/cjxkw
         VKTVxCZKu1ugQsh3niOmVJAWTWYCpDg6zJ8BArngsHPU1C/Led7AyDz3q6xwd58b9uu+
         oDMI2vgNZBw5Il7nma/k1McY4PfIUXhIrKsSwHFifAs7ZI2jtZZ1p0m5d1tALCa/jurH
         jHzEkkSZ45JQslscnfuUAP8dxbL5EgdRf9waHtXIR0aOp6rol4YgemdfN279Bu5Zes3M
         WYL3/RyoxDje+OQSl76D8B6h6JTFsa8pP5R80zDopHIPhqtlbECU4IhQIQxcreLrQU3a
         R4jQ==
X-Gm-Message-State: AC+VfDwv0QT7eDEufyvZz4A9LIn9/OGKE5PZqgZebHRPwcf6uzqwIb8J
        HIFzNsALVZWotbUFf02/VwgvxQ==
X-Google-Smtp-Source: ACHHUZ7dBO33//hj1KquTj0+7Cckot/ZIOzPbIzo18s6Ed0oTywkwDAM61+6jJ93Is3tSOOQUp3FaA==
X-Received: by 2002:a17:903:25c4:b0:1ae:2e08:bacb with SMTP id jc4-20020a17090325c400b001ae2e08bacbmr1095873plb.10.1684380095901;
        Wed, 17 May 2023 20:21:35 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.115])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001a64a2b790fsm133585plz.164.2023.05.17.20.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:21:35 -0700 (PDT)
Date:   Thu, 18 May 2023 11:21:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] perf symbol: Add LoongArch case in get_plt_sizes()
Message-ID: <20230518032129.GC1068119@leoy-yangtze.lan>
References: <1683615352-10794-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
 <20230518030618.GB1068119@leoy-yangtze.lan>
 <CAAhV-H6L9kNyGU2UrX7jyN_6O_pafSVSamP7DYHkzfMgmCxVXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6L9kNyGU2UrX7jyN_6O_pafSVSamP7DYHkzfMgmCxVXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 18, 2023 at 11:12:26AM +0800, Huacai Chen wrote:
> On Thu, May 18, 2023 at 11:06 AM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > On Thu, May 18, 2023 at 10:11:27AM +0800, Huacai Chen wrote:
> > > Queued, thanks.
> >
> > The patch is fine for me.
> >
> > Should not perf patches are to be merged via Arnaldo's tree?
>
> I think both are OK, if Arnaldo takes this patch, I will drop it.

A good practice is to firstly inquiry the maintainers.

AFAIK, Arnaldo will test perf patches before sending out pull request;
if perf patches are scattered out, it might be out of the testing
radar.

Thanks,
Leo
