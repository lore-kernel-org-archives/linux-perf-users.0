Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88907C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Feb 2022 20:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiBNU5B (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:57:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBNU4y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Feb 2022 15:56:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2919010783E
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 12:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D0546117B
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 19:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2E6C340E9;
        Mon, 14 Feb 2022 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644868303;
        bh=ZRGpjhDee77zeXixyyI14bo9gbHLwZJvAU0JEbzzZpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APkoQm3XKjiRzvP9WOj3+oB8PFggb3P3gQx/6FSl6WYolw27nskZCm9EcU9OBkRWd
         qWdiTekvQBPVY3LX44tXuZ5uOgQenyITkoKc3108mhQjxcsy88wSnNW+9EV+6mRYgw
         SRTWGSvVpX0ALdmHbWtdglhQL3KFVce9liW5LmzzY8qGkgA7rzyAISWNcOrQbU3xC4
         r2glMT+G7jaU6y8JFjOkSfpB9slyyHB5/Xc+my4CrVJiQKKV410X0twxmpCV2OZBFh
         zdXtM0ERZcxwrtkcw8G9WvC+tg9oiN06gtcB+i3oDJK++j7v1BnNhGml3qLsOS+a5o
         pCMQahAk+cbdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3EC1C400FE; Mon, 14 Feb 2022 16:51:41 -0300 (-03)
Date:   Mon, 14 Feb 2022 16:51:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: libperf: CPU map question
Message-ID: <Ygqyze02nC5eaEBt@kernel.org>
References: <CAPpZLN6+BPu=Y_iCXBV_Uqg_mcY2LEBtg+_7r+oJqWkG8pNSGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpZLN6+BPu=Y_iCXBV_Uqg_mcY2LEBtg+_7r+oJqWkG8pNSGA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Feb 14, 2022 at 06:54:38PM +0200, Tzvetomir Stoyanov escreveu:
> Hello,
> I'm trying to use libperf as an interface to perf from an application,
> but I face some difficulties.  I cannot understand how perf_cpu_map_
> APIs should be used. My use case is:
>  I want to iterate over the CPUs from the map. I'm using
> perf_evsel__cpus() API to get the map and perf_cpu_map__for_each_cpu()
> macros to iterate over the map. However, using that logic I get a
> struct perf_cpu for each CPU from the map. That structure seems to be
> private and I cannot access the actual .cpu id. Am I missing something
> ?
> Will be glad for any help and clarification.

Jiri, can you help?

- Arnaldo
