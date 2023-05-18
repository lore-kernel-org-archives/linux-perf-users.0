Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944E5C77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 May 2023 04:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjEREGD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 May 2023 00:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEREGB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2023 00:06:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1FB199F
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 21:06:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2534d7abe1bso799284a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684382760; x=1686974760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XBwk/aRbKTuV6j+TKCUk1Xx6KdzibhK7F3fWMpwG1Qo=;
        b=P66CkZWTfL1R7mhQjxFOQgulUchkFTUoPcKfUT5/Cz2KFELfTltrCqBYMn51UQGsj0
         3IVpbR5Y4o4IIJ5zHCSy7vX+XvRsvKTmOS8jr6cYOR7852rfFfndq94R2bZ1TZG/7OGI
         xDy/Ucq9e6r0qDnRCRshi2TTzERE+NS0MA+O34U83OuRvFmbDXyywl3z/R3KmVviTw40
         NJ5TKUbDa3MFEA8WcV3hiFq6j7jcMzkuOOMU6LNyMwBqS+HU8jLqKfwPLwWQyPfxFxc2
         Zi8BYmcz6o2jF0KumuBYM7hQkY4o2/ItkbKFHaMN6RSC1cHMBh2TcsDSExONBf6QYWJT
         2NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684382760; x=1686974760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBwk/aRbKTuV6j+TKCUk1Xx6KdzibhK7F3fWMpwG1Qo=;
        b=eVnYU1uRYFKvd/5PSZqV8NIvxdTsvkcjkJIPs58cVKKE7ONguBje2xAsrLi6wEFHIi
         EGpc3AfIxCtXC4k35MRIsmJEs3hXAzdsUJU4/j/pD2DosrClkqrO4pytioKBaosXv8js
         et4CLNpbn/++f2WJ/AeBKi6nOTCucA016gGzW7kvR7qV1jki8yY+N4r22Y5RpbvKYyNH
         v4Zf1qWu5xHe17HT/UU9TZJO4WlcEpPGONw9k+0KRqSk3c7McLExJ58gvcWEZ8q49d1Q
         VQALxy67a+Dq8KaROz/fyy0NKbDVzF4UxrNvMDidZyO1gixUFCBL5I8N/xQRJ+ZuqdYT
         +mGA==
X-Gm-Message-State: AC+VfDxlkqNRmak7hgn1QqHq/UgcbBbsMaXZ3QWLwxW+lkUOtcB1dcRj
        XQ7ryP1fTaifE4B7kgFOJufGaQ==
X-Google-Smtp-Source: ACHHUZ4kUlWKUIOZBXER/JPPz6JM9GTjl6mCIlThAFgi8+JsiTOlfiN60V9ksfqPOYPSz8t6gSE66g==
X-Received: by 2002:a17:90a:5802:b0:24e:1a7:eee6 with SMTP id h2-20020a17090a580200b0024e01a7eee6mr1093793pji.45.1684382760150;
        Wed, 17 May 2023 21:06:00 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.115])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a088500b0024e268985b1sm355334pjc.9.2023.05.17.21.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 21:05:59 -0700 (PDT)
Date:   Thu, 18 May 2023 12:05:53 +0800
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
Message-ID: <20230518040553.GE1068119@leoy-yangtze.lan>
References: <1683615352-10794-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
 <20230518030618.GB1068119@leoy-yangtze.lan>
 <CAAhV-H6L9kNyGU2UrX7jyN_6O_pafSVSamP7DYHkzfMgmCxVXA@mail.gmail.com>
 <20230518032129.GC1068119@leoy-yangtze.lan>
 <CAAhV-H6_=qwheWvNozop2+9MexnOZQcva28xaeikCc49_DqABA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6_=qwheWvNozop2+9MexnOZQcva28xaeikCc49_DqABA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 18, 2023 at 11:57:29AM +0800, Huacai Chen wrote:
> On Thu, May 18, 2023 at 11:21 AM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > On Thu, May 18, 2023 at 11:12:26AM +0800, Huacai Chen wrote:
> > > On Thu, May 18, 2023 at 11:06 AM Leo Yan <leo.yan@linaro.org> wrote:
> > > >
> > > > On Thu, May 18, 2023 at 10:11:27AM +0800, Huacai Chen wrote:
> > > > > Queued, thanks.
> > > >
> > > > The patch is fine for me.
> > > >
> > > > Should not perf patches are to be merged via Arnaldo's tree?
> > >
> > > I think both are OK, if Arnaldo takes this patch, I will drop it.
> >
> > A good practice is to firstly inquiry the maintainers.
> >
> > AFAIK, Arnaldo will test perf patches before sending out pull request;
> > if perf patches are scattered out, it might be out of the testing
> > radar.
> OK, I know, thank you very much.

You are welcome!

I found the code base for bfd:
https://github.com/bminor/binutils-gdb/blob/master/bfd/elfnn-loongarch.c

And this patch is consistent with above link, FWIW:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
