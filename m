Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF06C47094
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A4A613D0
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 15:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhFJPy0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFJPyZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 11:54:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987B1C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jun 2021 08:52:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ei4so3916278pjb.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jun 2021 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KX8l2w0IMtRC5c6qHNvl0KgU7tvOhrSsL7RNXq9bR+4=;
        b=xlK80h3lCnAZasvGDJUY/22RvUNUYrnQIILihwWn1jtnVzkFjdirmA1C2IX0aBZUur
         QYzyZ6sahO6KYHSSVu5oUKyGhNxIDm11Xkcmtd+RHYFQmbw+Su+q/fFbP61HigCus8GR
         aGV2g125VmsYTBRXgqwHMdUOs2AtnSZlq8QWMc7hDweLvEDBRCWouCbot+Pd6/4Kg5Zq
         OgaWas7x7iPk/N3sK/U9so2cgt0mY5eAjW2+HqaYpnKms9NerMwg9xD/dl+iRyOJs6/g
         3+k+0b1elDas4zCXZjg0VWsXyPFU9ExIfkiOYhYmFOMMWzZj9seZvFT9i5nr4T+teElt
         Q3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KX8l2w0IMtRC5c6qHNvl0KgU7tvOhrSsL7RNXq9bR+4=;
        b=sf/CrOsvH3UPrpMEK9+AxGK6SS/NkiTAkT0y0qPksr+mSsCKzEAgAvmvslNxVVFIRc
         pe+zT4ZlE2lIbfi5onWwB6JlLR+ArVVy0yMnVWZ483IEvgW7HWdcR9UsKuf6iFYPIkEH
         hQhPJxWr26PxZCni+jGPXth1xsnYP+gdUmc4Y3YIrwwYMFg8a6B5uhaiM04vGlFWQEIj
         CiITFTKwJPdSuYQ7hWbZPc4TIBJgiqLVq1lIjyofT78jj/W5/p3I87gC8SJIQFZmQzL9
         VuVMLrd7e7pLR93524VWn0b66AsS7GW+6N72FyG8CdLRVkhCBu5i2RuTl0Hqf5M6/s7r
         MkZw==
X-Gm-Message-State: AOAM531nJ8cN4loX/Mczxhv0aL2yBTU7WkJDMp5eakKNiLNNuyTcjulx
        TzGX9S57o9RIud0Yai+++mes0w==
X-Google-Smtp-Source: ABdhPJyYXLEX++QpbNBN6pTxAJDenevuet6zyqh/LlCGRu22lr5FnmL6Dy8Mn7kk/ZRFzA+tId9r7g==
X-Received: by 2002:a17:902:db0b:b029:111:7dac:2789 with SMTP id m11-20020a170902db0bb02901117dac2789mr5373146plx.45.1623340349069;
        Thu, 10 Jun 2021 08:52:29 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q2sm3038962pje.50.2021.06.10.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:52:28 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:52:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] perf cs-etm: Split Coresight decode by aux records
Message-ID: <20210610155225.GA34238@p14s>
References: <20210610103647.7038-1-james.clark@arm.com>
 <20210610103647.7038-2-james.clark@arm.com>
 <f92553c4-fe72-1a95-3f7c-f7a8481a0538@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92553c4-fe72-1a95-3f7c-f7a8481a0538@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 10, 2021 at 04:55:27PM +0300, James Clark wrote:
> 
> 
> On 10/06/2021 13:36, James Clark wrote:
> > +		return auxtrace_queues__add_event(&etm->queues,
> > +					       session,
> > +					       &auxtrace_fragment,
> > +					       file_offset,
> > +					       NULL);
> 
> There's one more indentation error here that I will fix in the next set.

Yes, this one needs fixing and while at it you probably want to fix the stacking
as well:

                return auxtrace_queues__add_event(&etm->queues, session,
                                                  &auxtrace_fragment,
                                                  file_offset, NULL);

Also look for "deccoding" at the end of the second paragraph in the changelog.

Thanks,
Mathieu
