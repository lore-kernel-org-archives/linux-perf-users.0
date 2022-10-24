Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EF4FA3741
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 11:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiJXLlz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiJXLky (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 07:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CF54A13A;
        Mon, 24 Oct 2022 04:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2474E6122D;
        Mon, 24 Oct 2022 11:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AD8C433D6;
        Mon, 24 Oct 2022 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611441;
        bh=Sg7RXm6gaNLBY3hXnDTCoheg+w3EZUt8S3uWmJ5qWcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ly7aPXct+oC2rDalw7JI8/35mFbH3FCRTes8nSXENb8o9F8hc4Fi/44e3veZDAV8L
         eOfMBrKVNtuMmIgSRDucvghtEMc2cGhYFctJr1uxEEOdqOMlTeiG8eVnuuirnbLj17
         NgsVOGsoT7QwMvRvzB3U9rYu1juqjSgTxq2IDk8SM+Ficb2+OZL47ZVugGjjtFb0FD
         liPMaK1R794cze2jlHY3jojT4r5aOmBRvmuYACbZIa4b4IExQzteF1gSuDpE5xNJPw
         rBkYDdZSwCArwYsxMvP6rQi74U4GPATSl+O32RizilrTCnSQD5Fsitt64Gpf4TIaSw
         pp/c72Rt1XLTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DA2F9404BE; Mon, 24 Oct 2022 08:37:18 -0300 (-03)
Date:   Mon, 24 Oct 2022 08:37:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf list: Fix PMU name pai_crypto in perf list on s390
Message-ID: <Y1Z47jk7411ZFtJQ@kernel.org>
References: <20221021082557.2695382-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021082557.2695382-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Oct 21, 2022 at 10:25:57AM +0200, Thomas Richter escreveu:
> commit e0b23af82d6f4 ("perf list: Add PMU pai_crypto event description for IBM z16")
> introduced the Processor Activity Instrumentation for cryptographic
> counters for z16. The PMU device driver exports the counters via sysfs
> files listed in directory /sys/devices/pai_crypto.

Thanks, applied.

- Arnaldo

