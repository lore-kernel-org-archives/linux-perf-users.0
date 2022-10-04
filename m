Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4342BC43219
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 18:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJDS0f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJDS0e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2022 14:26:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC51C1D0F7;
        Tue,  4 Oct 2022 11:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80470B81B5D;
        Tue,  4 Oct 2022 18:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CE0C433D6;
        Tue,  4 Oct 2022 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664907991;
        bh=waS3Fg+xLWzPvDGMWzQ2iD97+UXSRdhWK/dG1mh7HEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXeE/D9+IG7gCScWXs69obZGNgwqVCC6EVP03kH+g2WTFAog2+whuAMkvKs9Z7gWc
         cuPbEj6cdERyC6LZ6kOFpgZUzrMoEubqLdZWj9zKVyvSz3dv4oz5xw8gSZGR90/aum
         QMJrczNXH55wcFFDZy5eP9LaRs1VUdpazqGRX/L2BOhzGa7eg9+jDwUgSj7+4It7TY
         4wa1WtzrxbCbj+VGdMOuv3tuGR2Fp7GAz6CHmvIJFoArwEQNis+5x35m/4rAkmR4Mf
         VB21Rk80rPyKF9wuERptnDqshjLbOgHxWNahNSCzgNwFnMtmuYEiyyLEXJUs+DeSNV
         1AALGEkXfVS7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99A2F4062C; Tue,  4 Oct 2022 15:26:28 -0300 (-03)
Date:   Tue, 4 Oct 2022 15:26:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 00/23] Improvements to Intel perf metrics
Message-ID: <Yzx61MIusuHbS6FK@kernel.org>
References: <20221004021612.325521-1-irogers@google.com>
 <CAP-5=fXk6sLhZsEs72G4pOuZNzDJLc2Vkkvf+Jv=LXQDHPy8-w@mail.gmail.com>
 <677c6ec7-2e01-635b-dbfb-fbb9280e5b7c@linux.intel.com>
 <CAP-5=fUFuw-WYj7xVm3WrnggN2NW7pJkznUQ-j3U4fwMB5PdnA@mail.gmail.com>
 <Yzx25psp6o4XDaVs@kernel.org>
 <5710d85a-e1ab-1533-cda7-185b9234c580@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5710d85a-e1ab-1533-cda7-185b9234c580@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Oct 04, 2022 at 11:15:34AM -0700, Andi Kleen escreveu:
> 
> > > So I think you've not got Arnaldo's branch with the changes applied.
> > > Unfortunately the instructions around '_group' are only going to apply
> > > to Linux 6.1.
> > I just pushed perf/core with Ian's v3 series, please check with that
> > one.
> 
> 
> Yes works with the latest branch thanks.

Thanks for checking,

- Arnaldo
