Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD0C4708E
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Dec 2022 14:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiLGObs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLGObq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Dec 2022 09:31:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0212C1;
        Wed,  7 Dec 2022 06:31:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2460B81DF0;
        Wed,  7 Dec 2022 14:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AE2C433C1;
        Wed,  7 Dec 2022 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670423502;
        bh=KVfcvDlD3IO2U7m6quAXFXfzOT9u5lXFudJ+EHlKt0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kK+XLFqqqQCCq1VEmL8/AT17UmPsS1uAcgpuhgvTdwaxdLh9eaNprF8PWzhj0uRur
         V4gGIpHY2kQKFwZZakP9bsLrEWs3ZhaQSlHx0rQEW1qKmcI+7YEfpeTHhsi8mhDvJg
         diG5oB72feKka7Iydat/CjX6Sji7fOwA4L3gjBabYNGMybPQomcrZsqXnMzYmo8+E3
         3/OAEWsUfa3QzjTF3BuAJgR6QnnitORoizNn1JuviPGRQT7quzNTSYSTw+ru61uuZt
         690/VWw1dfmF8DL9Vum/wZw4tAxqtlvws1qsdVEle2bFg4oH+1StN0IzzjhR0v1w0G
         NC+nDqQJV+cTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8652140404; Wed,  7 Dec 2022 11:31:38 -0300 (-03)
Date:   Wed, 7 Dec 2022 11:31:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [ALMOST ready] Re: [PATCH 2/3] perf build: Use libtraceevent
 from the system
Message-ID: <Y5Cjylv9dJh796dw@kernel.org>
References: <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <CAP-5=fW2Fdfo9njgXxCVDP0dF3gTsUtaPMh88uSC5bRVjp+1Uw@mail.gmail.com>
 <Y5ChXjt0uv/yDNwV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ChXjt0uv/yDNwV@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Dec 07, 2022 at 11:21:18AM -0300, Arnaldo Carvalho de Melo escreveu:
> One thing I'm doing now is testing with the container builds, and I'm
> afraid we have to delay deleting the in-kernel old copy of
> tools/lib/traceevent till distros that don't ship libtraceevent as a
> separate package are EOLed.
> 
> We need in those cases to fallback to tools/lib/traceevent/, with a
> warning probably.
> 
> I'm now updating my container build recipes to install
> libtraceevent-devel, when available, which isn't the case, for instance,
> for almalinux:8, the first I tried updating.

No distro I tested so far has a package for libtracevent in is default
repositories:

almalinux 8 and 9 and the recently released Alpine Linux 3.17 (at least
I hadn't a recipe for that one, will try with edge).

- Arnaldo
