Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C195C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Mar 2022 17:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiCGRy6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbiCGRy6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Mar 2022 12:54:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3C70917;
        Mon,  7 Mar 2022 09:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61DA7B81654;
        Mon,  7 Mar 2022 17:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CEFC340EB;
        Mon,  7 Mar 2022 17:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646675641;
        bh=SYv38mIqyJ/kUbZba218Eg6gzm9gAmX2mF5NRxwBAu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uF3ao08msPIYvAyDOUwnmcq6PJqWBBRJcE4FTCDOAHBSSt4GFTMvgqXbQI34K3TzN
         /xpRo29FuAEzEzQZc9mU5lBM5PndqpCzr47nWgg4MIS92vlRKvsOzivGM44LlojJFz
         EzrTzAB4I3+KtqyYmu+vphiGFI4JSv/Jfsshu0hRSrmnT8GLIa54Or/C5p6QNC7eKK
         rIkIBn10pWLsTTBt3+GT9SbjDEQBGHaTTQkJs5JakGVxwnZwW3TlbyLYgT5DiiKQTf
         /3jqkQ4hvmP5TAzhxbHXrDzRjD+DwFbc638yywb6FM8QxSAG5Ugpix5lOYCUGbZ0cY
         Z8EPeFRiaz0xw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C746403C8; Mon,  7 Mar 2022 14:53:57 -0300 (-03)
Date:   Mon, 7 Mar 2022 14:53:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
        german.gomez@arm.com, leo.yan@linaro.com,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Branch stack improvements
Message-ID: <YiZGtCptGtphNasv@kernel.org>
References: <20220307171917.2555829-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307171917.2555829-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Mar 07, 2022 at 05:19:13PM +0000, James Clark escreveu:
> I came across a few generic non-Arm issues when reviewing Anshuman's new
> support for branch record buffers on Arm [1].
> 
> The first one is a fix to an error message which is misleading if the
> feature is unavailable and the remaining ones make the branch type field
> visible in perf report and perf script so that it can be debugged or used
> by other tools.
> 
> Applies to perf/core (56dce86819)

Thanks, applied to tmp.perf/core, locally, if someone spots some
problem, there is some time till I run tests and move it to perf/core.

- Arnaldo
 
> Thanks
> James
> 
> [1] https://lore.kernel.org/lkml/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/
> 
> James Clark (4):
>   perf: Add error message for unsupported branch stack cases
>   perf: Print branch stack entry type in --dump-raw-trace
>   perf: Refactor perf script branch stack printing
>   perf script: Output branch sample type
> 
>  tools/perf/builtin-script.c | 28 +++++++++++++---------------
>  tools/perf/util/evsel.c     |  4 ++++
>  tools/perf/util/session.c   |  5 +++--
>  3 files changed, 20 insertions(+), 17 deletions(-)
> 
> -- 
> 2.28.0

-- 

- Arnaldo
