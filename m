Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB38C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 17:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF806140A
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 17:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGARSB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhGARSA (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 13:18:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E714361405;
        Thu,  1 Jul 2021 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625159730;
        bh=zq344pJx1WuJMIhJczkrq3swqybb852HF++5glo+ZRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3JVuo5ulCIkd80LX25X37wj5Vh0dedZXdyxFMJtjMX7VCpQbv/NslEPQdR9vbbGP
         jCgjzKNNh2EgSQiBXE1BMncM4x014aJvEsDE50rhDwkqP82kNXXfkRbU4idyyGy+jL
         B4gUt2oWlBRjklHpR7+cUYAHpBJZhM6hBj233U7lDJgx8caF8qmoYZo55/LS6S+LYK
         oHzyHd/Ok6OKm8HLj2MX8g64K3FrMYIRRh5007y0loFp4nsGLTks1wsuiXlCyDqdgT
         1XbH1cpTOsKIWxnHXI2ieyZomoxh13Pgj9IKAayfy3AQYgvVEixYzwg7xZI7MbOORm
         zlMqrggv/QuAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02C1340B1A; Thu,  1 Jul 2021 14:15:26 -0300 (-03)
Date:   Thu, 1 Jul 2021 14:15:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        leo.yan@linaro.org, al.grant@arm.com, branislav.rankov@arm.com,
        denik@chromium.org, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Delay decode of non-timeless data until
 cs_etm__flush_events()
Message-ID: <YN34LlxuaNo60CGu@kernel.org>
References: <20210609130421.13934-1-james.clark@arm.com>
 <20210614155442.GA396617@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614155442.GA396617@p14s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jun 14, 2021 at 09:54:42AM -0600, Mathieu Poirier escreveu:
> On Wed, Jun 09, 2021 at 04:04:20PM +0300, James Clark wrote:
> > Currently, timeless mode starts the decode on PERF_RECORD_EXIT, and
> > non-timeless mode starts decoding on the fist PERF_RECORD_AUX record.
> > 
> > This can cause the "data has no samples!" error if the first
> > PERF_RECORD_AUX record comes before the first (or any relevant)
> > PERF_RECORD_MMAP2 record because the mmaps are required by the decoder
> > to access the binary data.
> > 
> > This change pushes the start of non-timeless decoding to the very end of
> > parsing the file. The PERF_RECORD_EXIT event can't be used because it
> > might not exist in system-wide or snapshot modes.

<SNIP>

> This looks good to me but I'd like to have other people testing it.

So Leo reviewed and tested this, I'm taking your "looks good to me" as
an Acked-by, as per Documentation/process/submitting-patches.rst.

- Arnaldo
 
> Thanks,
> Mathieu
