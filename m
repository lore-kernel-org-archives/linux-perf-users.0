Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8A4C4332F
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C5560F5E
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhIEV0K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 17:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbhIEVZ6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F4C0613D9
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 14:24:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i6so6822601wrv.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1e0hbv3ZsiJNNAHKyqEnrPS9MqX6cUig82FuR1+yU4=;
        b=wVGZAh4ytWMN/R/wB6lATwcSZgUDP8NwEYQyuIHXnQXXF4mGYHBthshCs0RCobdwtF
         i0bPxTtRbONrs85UFIYny393EZRpCEDxNspp3Ic7TcBlRz9xmDJByXi5CpcVL7alE39u
         NjzZaZ9AMafDLj9U0+XeGIJdjxQ5koq47chWwA9CZBzQPU9po8ik129DrMVqaRco76d7
         hGAq95+PCjOyFJDGb5e9BhLdd+S9/ZBUN9AXsxRWb5KkB5kedUs/9QMSCLEmksHe5fPL
         2cYx7YBQGmm+Sqz3MItdKjRYJ9LcDN+FKXMP9XUDtDUefIIVNY+UY/UzTToKU2Z/UEHl
         d+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1e0hbv3ZsiJNNAHKyqEnrPS9MqX6cUig82FuR1+yU4=;
        b=j31YRO0eLQfhAI72MqrBExpKS6lJRIEERhoC9yuu90NxeFNmUOGz0rVTdLJl7O3Drg
         vZMphGovCipidhj5PAV/arUrKgTZ2v9D6S3nAZ66rPtyczdFAIRQGvWJ2IVtSzItCqlz
         1reUB0qUOutFm6Q7Zt7EO8f5/+lCxyqXoztaI0fimKHlDNJOsLr+XL2rQagJ/SdtIJrl
         1JAuS9tHVbC7MywRWtJn6Er4Itb9cTsTWoJPNJ4T9PzI0gI1nZDByWlqIPlwQJDFM+GW
         ZpPiqa3vaIh8At+9a2cvDoCNrm1G3l7+OM/UFLucTg8MG9YJKrdIOE95Ex/+2YxT1MTy
         PFBw==
X-Gm-Message-State: AOAM532xSAX7KWlomlApoj3//GIQ3t+8xQFxK/Yw99XvqHpQVkyXpa6K
        Yc3CnW1qOEMBKfNcRKP55oYptEpzINuCx7MzQd0qgw==
X-Google-Smtp-Source: ABdhPJzZ8iRqYHJstJBoyH7sckuZt82cSSeCX+52p0ngldq9SUEOXAYxUMBGzcCj0RPX02xBkR3mXtNJE06Jo1I1G1k=
X-Received: by 2002:adf:e449:: with SMTP id t9mr9880840wrm.135.1630877090158;
 Sun, 05 Sep 2021 14:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-8-james.clark@arm.com>
 <4da533c0-8da6-00d4-1849-e210e163d326@arm.com> <YTIEKG6Qv6YQwiw3@kernel.org>
In-Reply-To: <YTIEKG6Qv6YQwiw3@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:39 +0100
Message-ID: <CAJ9a7VhF2xPC70GG_66Q-jduYuit3YUBVUKLE=gNp2JXj_9jVg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] perf cs-etm: Create ETE decoder
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Fri, 3 Sept 2021 at 12:16, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Sep 03, 2021 at 10:15:07AM +0100, Suzuki K Poulose escreveu:
> > On 06/08/2021 14:41, James Clark wrote:
> > > If the magic number indicates ETE instantiate a OCSD_BUILTIN_DCD_ETE
> > > decoder instead of OCSD_BUILTIN_DCD_ETMV4I. ETE is the new trace feature
> > > for Armv9.
> > >
> > > Testing performed
> > > =================
> > >
> > > * Old files with v0 and v1 headers for ETMv4 still open correctly
> > > * New files with new magic number open on new versions of perf
> > > * New files with new magic number fail to open on old versions of perf
> > > * Decoding with the ETE decoder results in the same output as the ETMv4
> > >    decoder as long as there are no new ETE packet types
> > >
> > > Signed-off-by: James Clark <james.clark@arm.com>
> >
> > Changes look good to me with my limited knowledge about the decoder
> > facing code.
> >
> > FWIW,
> >
> > Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Thanks, collected the Acked-by.
>
> - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
