Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA59ECAAD5
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Sep 2022 12:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbiIFMyP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Sep 2022 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240211AbiIFMyA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Sep 2022 08:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD07D74E26;
        Tue,  6 Sep 2022 05:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6B661500;
        Tue,  6 Sep 2022 12:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12C3C433C1;
        Tue,  6 Sep 2022 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662468809;
        bh=fldsy+P2Q7PF4mFLFUGFtLZ/KojrACP13eE47+4QOLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucylPzXrD7R0fNl3OILAPn6lz+kQHL5B9dok/3TaEJwy3KnlDGitr9hTyiSekDiQh
         5VuZvSYD6NEPcREhkN07Xkfvw0HQbuaPgKeDhKCHwiQjh8UuoDiSnESGR2yAe1FJVS
         o4oFsHDScad7GIEe0i0F57qOvna5Np7Yvr+4xSyVQYQJ5boQQ4bmqHWeRdkC8OCVu0
         JooftswuuOGi01wdQBIrLio2pKEOvLixctayUf8XiiJ6sggHG8NICrHgPnPU7kSNNb
         K+9EKGKsWrcJ0KIDTw4F2umkPmJJQBjRygFfWt0yOIAdsMqw1OUG616hGKMu++Bu6m
         /OuUEKVFxY6sA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8253D404A1; Tue,  6 Sep 2022 09:53:27 -0300 (-03)
Date:   Tue, 6 Sep 2022 09:53:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
Message-ID: <YxdCx6UPU6wI95kc@kernel.org>
References: <20220905114209.8389-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905114209.8389-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Sep 05, 2022 at 02:42:09PM +0300, Adrian Hunter escreveu:
> The offending commit removed mmap_per_thread(), which did not consider
> the different set-output rules for per-thread mmaps i.e. in the per-thread
> case set-output is used for file descriptors of the same thread not the
> same cpu.
> 
> Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

I added these:

Reported-by: Tomáš Trnka <trnka@scm.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216441

Jiri made a comment, can you please reply?

Applied locally for further tests,

Thanks,

- Arnaldo
