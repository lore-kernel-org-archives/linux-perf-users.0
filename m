Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B61C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCC0610CC
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Sep 2021 11:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhICLRe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Sep 2021 07:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348629AbhICLRc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Sep 2021 07:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D68B61056;
        Fri,  3 Sep 2021 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630667792;
        bh=a2pWmgaC0GhU0gn2xbkFW30i/dtYIjoR1yxiObFsLL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9AyhtGTzRcW31XBEPUmPOpIOosoJ6KLtuCuz5TVY/C1kjabtfjL1o2E9mPnHATC8
         sXu9n74iLCwIPRRUzZkBKtcThnTW7nmMuHkAbvCLRq/jfGm/3nyu4bmHwqfZ2XXX9a
         taSEk13QOY/+b6tZc/iFWdgfmT50BqVdpEkChZGnPiTmKCO7gSXjaf158rlq8s6f4s
         H9YhkIk/V6H4+k8aOkp3sfeX7mLetDObFnPJVc03FRixfT1KajrP9vP6G2dxZI7Qen
         Feeoc4QbobKAsQADGA89ZfGsHdy3Q0+MQViraX+RwZTPb9CWC9x47XtB/il6AbxHVz
         btXk2wtJQLOUw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E876400FE; Fri,  3 Sep 2021 08:16:30 -0300 (-03)
Date:   Fri, 3 Sep 2021 08:16:30 -0300
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
Subject: Re: [PATCH v2 6/9] perf cs-etm: Update OpenCSD decoder for ETE
Message-ID: <YTIEDp9hFNNi0cB1@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-7-james.clark@arm.com>
 <63c17023-7451-6445-2110-f1f92b06dd41@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c17023-7451-6445-2110-f1f92b06dd41@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 03, 2021 at 10:10:01AM +0100, Suzuki K Poulose escreveu:
> On 06/08/2021 14:41, James Clark wrote:
> > OpenCSD v1.1.1 has a bug fix for the installation of the ETE decoder
> > headers. This also means that including headers separately for each
> > decoder is unnecessary so remove these.
> > 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks, collected the Acked-by.

- Arnaldo
