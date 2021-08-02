Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA40C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 12:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8678160F4B
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 12:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhHBM6R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhHBM6Q (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 08:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C29560E09;
        Mon,  2 Aug 2021 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627909087;
        bh=3nRIOCHIQMck4hhnlunp2JWBMRr1XL9Ld88U9Zvw+GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FddZZEUgEbQKH54AgrclVRRzOyILA9eXNtvrijWuCejs1dB83JHSlCAaF4VZDLH7s
         T0cZ2qVZ+ch2rBC+gHJpH3s/Iu1hQs1eWXcchhHrCMdI5YJSerQJyZl7ja1Js2LXIF
         NuPGtPklfSn1rfDpdRNs08OZoZ4q40+TPuGtEQV9GZQ2rD1OuHgXQ+ccx4gUTz58hZ
         binyT9JrX/TLBBtntG/Fe2TVV1bbD8ndEXvipjYu2CV1swfeeSuSgNlmr55W7A3xe9
         YazVJ3ToheKvomPMRvUBangf1GBlUu9v30fIdX4XRpg9D6JA0ehTU8YsgacUyQFgwU
         mnE5OwRG74cng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB71D403F2; Mon,  2 Aug 2021 09:58:04 -0300 (-03)
Date:   Mon, 2 Aug 2021 09:58:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 0/2] perf vendor events intel: Add core events and
 metrics for Elkhartlake
Message-ID: <YQfr3NFtOH3tu5ZV@kernel.org>
References: <20210802053440.21035-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802053440.21035-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 02, 2021 at 01:34:38PM +0800, Jin Yao escreveu:
> Add JSON events and metrics for Elkhartlake to perf.
> 
> Based on JSON list v1.02:
> 
> https://download.01.org/perfmon/EHL/

Thanks, applied.

- Arnaldo

 
> v2:
> ---
> Based on JSON list v1.02.
> Patchset is based on tmp.perf/core branch.
> 
> v1:
> ---
> Based on JSON list v1.01
> 
> Jin Yao (2):
>   perf vendor events intel: Add core event list for Elkhartlake
>   perf vendor events intel: Add basic metrics for Elkhartlake
> 
>  .../arch/x86/elkhartlake/cache.json           | 226 ++++++++++
>  .../arch/x86/elkhartlake/ehl-metrics.json     |  57 +++
>  .../arch/x86/elkhartlake/floating-point.json  |  24 +
>  .../arch/x86/elkhartlake/frontend.json        |  93 ++++
>  .../arch/x86/elkhartlake/memory.json          |  86 ++++
>  .../arch/x86/elkhartlake/other.json           | 424 ++++++++++++++++++
>  .../arch/x86/elkhartlake/pipeline.json        | 278 ++++++++++++
>  .../arch/x86/elkhartlake/virtual-memory.json  | 273 +++++++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
>  9 files changed, 1462 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
