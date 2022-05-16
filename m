Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9FAC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 May 2022 12:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiEPMxI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiEPMxI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 08:53:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177B838BD7;
        Mon, 16 May 2022 05:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A928561234;
        Mon, 16 May 2022 12:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD947C34115;
        Mon, 16 May 2022 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705586;
        bh=d0V/0ZiraPuikLUZIARcVrTTk104Z792nf2cQhVOy4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R459vo/A9TSusKVWDf9u1xbODjoNrhhRZCQWOmf0nYpof2ADJiDmP20+4a/BVpWID
         0X+AXe4cNRd0L1+GTSHCj9Ssj2SBQvaO1WGXDbUJ4Ytg66Y549mdDQM63haY0KygBA
         heiZkL8JObByASP4CnDc16sT7iCEOBxufLbAgZ93ennwJ8zDZM/oxEJe3OVrYLzXLH
         hDIzNM2oJ1JaBEFY5ZhYsX6+BdxAagbFXmjyYTvBd/M5M4iT4PR6Mtk0X6hDXErklP
         CW5xlXBbesGkr/tBW7MIDM8FPmxDNOm/TQXgHHUqRCOZ//e0GxEr27eW6JaLuVobzC
         CsdukcnIAbALg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B4778400B1; Mon, 16 May 2022 09:53:03 -0300 (-03)
Date:   Mon, 16 May 2022 09:53:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, namhyung@kernel.org,
        tglx@linutronix.de, bp@alien8.de, irogers@google.com,
        yao.jin@linux.intel.com, james.clark@arm.com, leo.yan@linaro.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, eranian@google.com,
        like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2 6/8] perf header: Parse non-cpu pmu capabilities
Message-ID: <YoJJL4Z5ICamRjYO@kernel.org>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
 <20220509044914.1473-7-ravi.bangoria@amd.com>
 <3e3c1d82-581e-5a44-deed-05b5f880746c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3c1d82-581e-5a44-deed-05b5f880746c@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, May 16, 2022 at 09:45:44AM +0530, Ravi Bangoria escreveu:
> 
> On 09-May-22 10:19 AM, Ravi Bangoria wrote:
> > Pmus advertise their capabilities via sysfs attribute files but
> > perf tool currently parses only core(cpu) pmu capabilities. Add
> > support for parsing non-cpu pmu capabilities.
> 
> Arnaldo, Jiri,
> 
> Does tool side patches looks good to you? Please consider pulling them.

So the kernel part was merged, ok, will look into it.

- Arnaldo
