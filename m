Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD2C433DB
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Feb 2021 20:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D89D64DEC
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Feb 2021 20:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBLUo1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Feb 2021 15:44:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhBLUoZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Feb 2021 15:44:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC9FE64DE7;
        Fri, 12 Feb 2021 20:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613162625;
        bh=KpknHpr5gDLXNYlbiJVgaDa0evxxJhmnCVM/zWlllJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g45O5iKqFCFjyahJISQFoTxHDwHjt8uL/162vS9FaMm4iku6/H6Jk1I1goFuT5M3s
         kaICpCf1Z3D/sj4EbkEkgNpEJgvVpSnZXBbQ8gFHntiN5eB72icRXc2clk+DBzYam2
         rHCiftxFCU7dEXK2Fju3XrV2BmuQzrWA664cBALp7i24BSz5IASJmcGvVZCH8fgUnb
         DZD9ZV0nOscm7JWvOhXP/6/tTggiVwZZGR3l1GfqQitaCAWdcUxB8pSkhgft+1e59W
         iVBnYOs1ol+Hm92aocfjH9cZEd8ERL1JVCdXaFROksW8EGTsC+F6JfnL8rro001gfL
         NG2iMAXxd+DVg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8782340513; Fri, 12 Feb 2021 17:43:40 -0300 (-03)
Date:   Fri, 12 Feb 2021 17:43:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/6] perf arm-spe: Enable sample type
 PERF_SAMPLE_DATA_SRC
Message-ID: <20210212204340.GJ1398414@kernel.org>
References: <20210211133856.2137-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211133856.2137-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Feb 11, 2021 at 03:38:51PM +0200, James Clark escreveu:
> From: Leo Yan <leo.yan@linaro.org>
> 
> This patch is to enable sample type PERF_SAMPLE_DATA_SRC for Arm SPE in
> the perf data, when output the tracing data, it tells tools that it
> contains data source in the memory event.

Thanks, series applied.

- Arnaldo
