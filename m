Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21966C07E9D
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100A060E0C
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 17:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhGSQUU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352781AbhGSQOl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 12:14:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BF5C069A5A
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 09:10:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d12so16965491pfj.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jul 2021 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o4i922N5SDDsYvh6TuHE/Y23vxIVmH2yUEAQuG2pCpE=;
        b=hgDtj98JFI7Uz5/o2YUanStRm2pgcmFJm9RqwEPCvbw2aM+Q7aSMp7yYigxQLxLrzH
         WNufFHdOpsrEeWEMk14EzulrQrKVeKMqiawwkWlOy9p3p4o6bzsyvJMizvYqVx68p/Wn
         ULZo05dvfacQM7L+0gDIHSUcsxwbDVvdEMH/SGJIWpO0kaOoLZtFWWJ721B1R8cRY8JC
         LknEn894OJbOJbPp7UeYwkUfk6UbSjWUyserq0H/3TbOq1jybBTUIntbBKihgBSTR+Z8
         /6LWc2I0wa9wt3wLPo7CFnGXHNs6oq/aYDDJehLcati9Mqs2LOBk57XXuGoVDGOFUkPc
         DEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o4i922N5SDDsYvh6TuHE/Y23vxIVmH2yUEAQuG2pCpE=;
        b=TjjcKFIfiWKujaU0/9cINj8DWDUVtawCRy1o7xYv0nGadYFpZ/vQ9kjAKgZA5ibaVK
         xje0gcbOzCoSO7oqgm1kJsDF3alHuoLRPGbrhaxWeorzYF9o/Npdxi5Lyn1+oWRslePR
         EED+tb6QkDPv+XhoWnkN6RjgSayUKcyiMkI7TrjHhZ4vpFOclwJowSuCD4sY/PPkMDkw
         yBvuFV20Gn/3s83/tXoBvlTtl9HmxUbQHyRj//dyLqdqPPQzhpiaJkCYk9aHoQiPn9OR
         azvZHo4cc8WT52iduF2vf3iZgO5QKev8iIpt4Aspkd24JvQCpY1AHPQWVvyMex9wsu1H
         1iWg==
X-Gm-Message-State: AOAM532e1SpD9YKyXfuWLVGmypp/17at/IFpSluLwm3wDpYG3Hb2PDuW
        NWILgBLKnnwEI8wsYxiyzWSUbQ==
X-Google-Smtp-Source: ABdhPJy2jGcpXSz3/n0yGq6EvR3KsN/25stQN4X0pzpZtImNNpTvcohu0e6B44HVvELefA3SZ45ehQ==
X-Received: by 2002:a63:ef45:: with SMTP id c5mr26810707pgk.78.1626712421192;
        Mon, 19 Jul 2021 09:33:41 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y82sm21001336pfb.121.2021.07.19.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 09:33:39 -0700 (PDT)
Date:   Mon, 19 Jul 2021 10:33:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        leo.yan@linaro.org, al.grant@arm.com, branislav.rankov@arm.com,
        denik@chromium.org, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
Message-ID: <20210719163336.GA2255168@p14s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
 <20210705193338.GB1493103@p14s>
 <YO8ivntow2JfdQWW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO8ivntow2JfdQWW@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Wed, Jul 14, 2021 at 02:45:34PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 05, 2021 at 01:33:38PM -0600, Mathieu Poirier escreveu:
> > On Thu, Jun 24, 2021 at 05:43:03PM +0100, James Clark wrote:
> > > for example:
> > > 
> > >         Idx:808; ID:1c; I_BAD_SEQUENCE : Invalid Sequence in packet.[I_ASYNC]
> > >         ...
> > >         PKTP_ETMV4I_0016 : 0x0014 (OCSD_ERR_INVALID_PCKT_HDR) [Invalid packet header]; TrcIdx=822
> > > 
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >  tools/perf/util/cs-etm.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> 
> 
> Thanks, applied.

This patch is the second of a two patch series[1][2].  The first one was applied and
is in Linus' current master branch.  But I can't find the second one in
either your core branch or Linus', and that despite your reply above that it has been
applied.  As such I am guessing something went wrong with the process.  

How do you want to proceed - should we resend the second patch[2] or you still
have it somewhere in your Inbox?

Thanks,
Mathieu

[1]. https://lists.linaro.org/pipermail/coresight/2021-June/006575.html
[2]. https://lists.linaro.org/pipermail/coresight/2021-June/006576.html

> 
> - Arnaldo
> 
