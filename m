Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF8C07E9B
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6EE360FE9
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbhGSWhX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358191AbhGSTVR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 15:21:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95B6D610FB;
        Mon, 19 Jul 2021 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626724891;
        bh=AtilYTYAIi/v289g3hvYA7Xnfh/9TR5jTuUQdlcooaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmwQBagM86Zvha3FDzTeqpfHrhaaF8hafQyEBNKW+VVwgTm4955iNjsAzQGGQnmsh
         c/iSIyg0GLURQG0X4bBHYbqeGkpc1S3VbB/RnhU/QlCt8RNdhm+o2tMJvXuucbMZdl
         OCHMDUl0aXj93gj1uJpqrpP730D6VO0BVcovn5TVXYuc+CtCI78AvJdO+oJAKOY4k6
         ZPFWzkGaJmmdcc0BJBV2hi1UWwIGGTNfLofgeHP+6hCvbnsCt2nxIP9v8U8E/ekE1y
         c+CIdEnXoPOwtERWOSb0N4ryQ9YtPEEhHCUB51N8CyacvRy5LYLEUlhzzlsnjPzmRU
         /wvrE+1rD7/TQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D5E3403F2; Mon, 19 Jul 2021 17:01:29 -0300 (-03)
Date:   Mon, 19 Jul 2021 17:01:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "liuqi (BA)" <liuqi115@huawei.com>
Subject: Re: [bug report] Patch "perf tools: Fix pattern matching for same
 substring in different pmu type" broken
Message-ID: <YPXaGPfofvrUGBLa@kernel.org>
References: <44e25825-5f23-c641-9f1c-72268d895f75@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e25825-5f23-c641-9f1c-72268d895f75@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 19, 2021 at 03:13:06PM +0100, John Garry escreveu:
> Hi guys,
> 
> The named patch has broken PMU alias matching on my arm64 system.

Hi Jin, can you please address this report? Otherwise I'll have to
revert the patch in my next pull req to Linus :-\

- Arnaldo
 
> Specifically it is broken for when multiple tokens are used in the alias.
> For example, alias "hisi_sccl,l3c" would previously match for PMU
> "hisi_sccl3_l3c7", but that no longer works.
> 
> In my example, in looking at the code, the callchain
> pmu_uncore_alias_match("hisi_sccl,l3c", "hisi_sccl3_l3c7") ->
> per_pmu__valid_suffix("hisi_sccl3_l3c7", "hisi_sccl") fails in the following
> check:
> 
> static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
> {
> 	char *p;
> 	...
> 	p = pmu_name + strlen(tok);
> 	...
> 	if (*p != '_') //here
> 		return false;
> }
> 
> This check assumes the first token must be followed by a '_', but it is
> possibly a numeric.
> 
> Please let me know how this should work. Previously it would match on the
> tokens, ignoring numerics and '_'.
> 
> As an aside, I'll look at why our testcases don't cover this scenario and
> look to add a test if necessary.
> 
> Thanks,
> john
> 
> Ps, please cc linux-perf-users@vger.kernel.org as in the MAINTAINERS file in
> future, as not all subscribe to the open kernel list (and so cannot easily
> reply directly).
> 

-- 

- Arnaldo
