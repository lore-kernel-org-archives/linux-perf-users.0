Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC794C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841F861057
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhICLSA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 07:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235054AbhICLR7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Sep 2021 07:17:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 361776108E;
        Fri,  3 Sep 2021 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630667819;
        bh=Cjn7X7A3BpFfVL6dP/OzgR8L7zue/gSjphoKmihKcyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJYqO6APl2Irus+PJhaKIo8uDvnMM3fTJR77mxpXLPzhFfX4Ma4DdJdcUYuGmdg9z
         n21b5TFqLeAyYrM7L8tDBj5DOas+hM8OtJZkeryAtaADmJXeES/flV/IIQfEGV1XCU
         qiSQk2OJTGafE6yaVuf2CO/7ag+KECkjkBcs+LEdiocs8eqbtTYv0ploNuaXhR3O5w
         gFTyLLTB+o/cH8jtHU5YAJh2B9iQlhyUjUkTxs5z/UHE6H/4Re1XEGfgfsRgevnhRp
         oALTBt1QQXQnGmRNlx0zW+ZuPOifiSEz+QvdFNy/ebF5iqQtGqoAWlFygkgeUC7SCB
         CXtOSrWH7AEsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD28B4034A; Fri,  3 Sep 2021 08:16:56 -0300 (-03)
Date:   Fri, 3 Sep 2021 08:16:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] perf cs-etm: Create ETE decoder
Message-ID: <YTIEKG6Qv6YQwiw3@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-8-james.clark@arm.com>
 <4da533c0-8da6-00d4-1849-e210e163d326@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da533c0-8da6-00d4-1849-e210e163d326@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 03, 2021 at 10:15:07AM +0100, Suzuki K Poulose escreveu:
> On 06/08/2021 14:41, James Clark wrote:
> > If the magic number indicates ETE instantiate a OCSD_BUILTIN_DCD_ETE
> > decoder instead of OCSD_BUILTIN_DCD_ETMV4I. ETE is the new trace feature
> > for Armv9.
> > 
> > Testing performed
> > =================
> > 
> > * Old files with v0 and v1 headers for ETMv4 still open correctly
> > * New files with new magic number open on new versions of perf
> > * New files with new magic number fail to open on old versions of perf
> > * Decoding with the ETE decoder results in the same output as the ETMv4
> >    decoder as long as there are no new ETE packet types
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Changes look good to me with my limited knowledge about the decoder
> facing code.
> 
> FWIW,
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks, collected the Acked-by.

- Arnaldo
