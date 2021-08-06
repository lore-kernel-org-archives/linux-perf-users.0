Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE2CC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 11:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C5A610C7
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 11:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245722AbhHFLwZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245704AbhHFLwY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 07:52:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF58C061799
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Aug 2021 04:52:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so22378958pjr.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Aug 2021 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=asA0Ub0/xhYqLYHlNNxTcENpmvj49OeKJZ/JEYJFvM8=;
        b=q5BdQhFDmEyv26B/H0n63ZK+Rh4G56toYP/AgcY0rIGb7YNTEBvTtlBbPPY4YL435M
         uDmaeNThxx82CNOVC7yCNskVuOWKS3thkxWhtt0IiCvcelIpuzCsT8sj5NOc+n9WR7Lu
         28KhvZQBAG1VKQMS60AonYBFj9xUvAB3Z8q++0I+m7GqKQbNXq1dVkGgesNK4dXFk6Z1
         UWH7VX9D1BW/mxSSR4XOn+d1UxnU1G3ubBwhx+RYlePTH9hToSc5MYgtp7eONJ07HNCA
         ODs124Bw3SnnGLPEg5o7LFkNzlIMD7wmC2iljqLroSya7nRCQ/Lmk8e3ta1QhBmxrst1
         ypJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=asA0Ub0/xhYqLYHlNNxTcENpmvj49OeKJZ/JEYJFvM8=;
        b=QXRxqWL1yAKYv2qKAz5sekrIdz3+eGhhdHb98EPC5XHQCLJzpFdfcbWrZmAXqIxATQ
         7QUaM5L86Vcurn7iSBnZvtmkNSPEnH7sQ2+iZ1tsNgPvn8PjwAP0z0597zamhLJXwn13
         KMARqopBEl3xag08Y6153PlFip2cWxePTMqV0y0ucUwP3SIqbJ4gvyzHtH1/RNHMGXAa
         2g8KXJGfUXqviFXTD9VajiMI7enKOZcBdpliwBQz99V8N2R+Z4ogKrfVF42kZpDO2+97
         DRmHVC0qs8i3E8NmPzencOf1nDIDME22nM9e2k2V2p+xNFsV59ZS0Nz6aQAGRMVB27xw
         lWpA==
X-Gm-Message-State: AOAM531XUBg4zclKLsHO9q+7aK7OL6B6gBRKitxZ5dy5BieUHbxTkaba
        bfzWcRwVVziASQlDHAmjENxDbw==
X-Google-Smtp-Source: ABdhPJyNuw9EDtxDCBskyq1NRyT0OJ02HnLnshfcel7lcpgJY4HHIVXVd9fMs6F7JIEw59fFFQDS6A==
X-Received: by 2002:a17:90a:404a:: with SMTP id k10mr10147405pjg.145.1628250727264;
        Fri, 06 Aug 2021 04:52:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id o8sm12735737pjh.20.2021.08.06.04.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:52:06 -0700 (PDT)
Date:   Fri, 6 Aug 2021 19:52:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 6/6] perf cs-etm: Print the decoder name
Message-ID: <20210806115200.GD68808@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-7-james.clark@arm.com>
 <20210731073037.GF7437@leoy-ThinkPad-X240s>
 <077ebe58-f692-9adb-9cb5-ed35a9b508c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077ebe58-f692-9adb-9cb5-ed35a9b508c1@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 06, 2021 at 10:43:25AM +0100, James Clark wrote:
> On 31/07/2021 08:30, Leo Yan wrote:
> >> @@ -658,7 +658,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
> >>  
> >>  		return 0;
> >>  	} else if (d_params->operation == CS_ETM_OPERATION_PRINT) {
> >> -		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
> >> +		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder->decoder_name,
> >>  					   OCSD_CREATE_FLG_PACKET_PROC,
> >>  					   trace_config, &csid))
> >>  			return -1;
> >> @@ -790,3 +790,8 @@ void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
> >>  	decoder->dcd_tree = NULL;
> >>  	free(decoder);
> >>  }
> >> +
> >> +const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
> >> +{
> >> +	return decoder->decoder_name;
> >> +}
> > Maybe can consider to place this function into the header file with
> > "static inline" specifier.
> 
> I tried this, but because the struct is defined in the .c file it can't
> be done without moving the struct to the header. It's also only used
> for the --dump-raw-trace path so performance isn't critical anyway.

It's fine to keep current patch, and thanks for trying.
