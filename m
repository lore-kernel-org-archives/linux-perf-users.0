Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A1C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB6860231
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhHJSVc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236534AbhHJSV3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 14:21:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 941AF60724;
        Tue, 10 Aug 2021 18:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628619666;
        bh=eY5Cf4toWrA1zQVY1KB4wnEL5WdhJvdEvei+Bwdkfkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6bDmRr3HI0xuxXiZhqqEdYYPYMQzzegelRP+BQKWJrGYjtUHpb584VSPf2tZ0Ri4
         rqdC1AbdjXCkZJ8InkxHtjowdj/trjfw3gtYedwLeF/G73Lr6DLy0wF4FDMebj19TB
         tiMBpYlljmEBj4CeO1dsclC8HaxcwFkPKgu6Rdl+buWi5PqyiQ4sRzyvahJZuv9rif
         71WQT6LyE3PJCvSJ7SZp+KYq9PH+Vhjm09f9mziu3AA40uS2eMBinyg+eOL5LL7OSg
         d3wSXnTQaMIxbhWVuuG9uDJKnmMHk1fuq5sUO6XR5dIr4ykpF+EPaJ0kzb6np0yFgA
         tzuzEufifqrUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6AC0A403F2; Tue, 10 Aug 2021 15:21:03 -0300 (-03)
Date:   Tue, 10 Aug 2021 15:21:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com
Subject: Re: [PATCH 0/6] perf events update for CascadeLake server and
 SkyLake server
Message-ID: <YRLDj4ur6dmSxisZ@kernel.org>
References: <20210810020508.31261-1-yao.jin@linux.intel.com>
 <YRLAWhHWX3oa0iyt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRLAWhHWX3oa0iyt@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Aug 10, 2021 at 03:07:22PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Aug 10, 2021 at 10:05:02AM +0800, Jin Yao escreveu:
> > - Update JSON core/uncore events and metrics for CascadeLake Server.
> > - Update JSON core/uncore events and metrics for SkyLake Server.
> > 
> > The patch series can be found at (in case broken by mailing system potentially):
> > https://github.com/yaoj/perf-clx-events.git
> > branch: perf/core
> 
> Hey, can you keep just one repository and then create branches?
> 
> $ git remote -v
> 
> yaoj	https://github.com/yaoj/icx-events.git (fetch)
> yaoj	https://github.com/yaoj/icx-events.git (push)
> yaoj-perf	https://github.com/yaoj/perf-intel-events.git (fetch)
> yaoj-perf	https://github.com/yaoj/perf-intel-events.git (push)
> 
> And now:
> 
> ⬢[acme@toolbox perf]$ https://github.com/yaoj/perf-clx-events.git
> 
> :-)
> 
> Applying from the git tree now.

Thanks, applied.

- Arnaldo

