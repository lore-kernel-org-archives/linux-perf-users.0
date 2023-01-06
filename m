Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF81BC3DA7A
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 17:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAFRQM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 12:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjAFRQC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 12:16:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF727CBEB;
        Fri,  6 Jan 2023 09:15:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 365CFB81E25;
        Fri,  6 Jan 2023 17:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F4CC433EF;
        Fri,  6 Jan 2023 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673025355;
        bh=A3es4EbINe4olkLWZ9/Udxl+akAjsizJ3K6RxnoPaQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKtht+MDiqyWAsBNQ3e3qS4imfYWFjPnZECMQJtN144Arlo+mFOE+Sz9ehnbYjMf1
         etL8Xij2TWAlXN3oBUxYh+a3eIeWNApa6QYsB4sR3DZ1lTArx+YYhtUFwOw8ZdCoaK
         Yq6FzeZe9r2ooB9Y5N2pCpYDszokS6dj3yLxyrTI1Eec3Jf3YE/7Tq7CxTWfSkT67C
         rvIyTHFac7KkCAZzZ1Qhrao07+RfmEstOEJKyycjbT279m2c7zi90UsR7cgI3n7fSV
         GTePZ0w0D+xMuLOR/FImqgTCQrVRTYX7S4rlfWM4C3Yv1bhdqtGjqXkUT7IIIteJdM
         /cgXmiMDiSiQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6049A40468; Fri,  6 Jan 2023 14:15:53 -0300 (-03)
Date:   Fri, 6 Jan 2023 14:15:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Eric Lin <eric.lin@sifive.com>,
        Ian Rogers <irogers@google.com>,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.2: 1st batch
Message-ID: <Y7hXSQcsAHfG4/yN@kernel.org>
References: <20230106142256.763489-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106142256.763489-1-acme@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jan 06, 2023 at 11:22:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Linus,
 
> 	Please consider pulling, there are some more being tested but
> that should sit in linux-next/pending-fixes for a while.
> 
>         Please let me know if you think anything should be reworked,
 
> The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:
 
>   Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)
 
> are available in the Git repository at:
 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-1-2023-01-06

Argh, I made a shell history reuse mistake just on the tag name, it
should be, and is available now:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.2-1-2023-01-06

- Arnaldo
