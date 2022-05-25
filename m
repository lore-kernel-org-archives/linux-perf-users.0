Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A3C43217
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 14:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbiEYOHG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiEYOHE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 10:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7C8D6BD;
        Wed, 25 May 2022 07:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAD326194D;
        Wed, 25 May 2022 14:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6DDC385B8;
        Wed, 25 May 2022 14:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653487622;
        bh=RgiR9Ce9ArVW3S3ZN6uRtn/r+jgQvDF3aziT/UtAWIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+CGMZEy7km5nHUeszhvjzBdwLcKs1gXYrev5uk9bWRbelFW2rjqQUYCyU4N523cM
         pFvS2lUqFxKH2y7o1UT26f8ILVibpRSvAhrmNdt/uH0vAfk4AR8O7oTy1uqNDd1//y
         TlmYyNLa8s40kewMqH8JP+rMcObq27ceUvnaIfIKMLcNUNpQB2y3f4a+F/3l58Z2+K
         SijzzIN1u530ELvnyL3SDTIn59BtyzLtBGuXuJq0v1wTDlxLTyPTlL8+JeS0rmnWw7
         pywPG9MZLIUnyBQhX34wxvUcoPe8J5G9ZoHYUGgqliD15H2lr2zcKy9SeQueH6sdXm
         Es/Z7VZ6uLYIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7EEF4007E; Wed, 25 May 2022 11:06:58 -0300 (-03)
Date:   Wed, 25 May 2022 11:06:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 3/6] perf record: Implement basic filtering for off-cpu
Message-ID: <Yo44AppGsPKvf7Al@kernel.org>
References: <20220518224725.742882-1-namhyung@kernel.org>
 <20220518224725.742882-4-namhyung@kernel.org>
 <CAP-5=fWfZ_MqiAUx-tdO1C=Dyyzno6FbBp+KGAb_MweXs+N7Jw@mail.gmail.com>
 <CAM9d7cgxdFJJQOg6ivuy4+nh=WME2fgjvM-kSWLv9zd49yxR4A@mail.gmail.com>
 <Yo4SqnEqzo2Rt+PF@kernel.org>
 <Yo4Wpqzwp+XmfkMV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo4Wpqzwp+XmfkMV@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 25, 2022 at 08:44:38AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 25, 2022 at 08:27:38AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, May 19, 2022 at 02:02:28PM -0700, Namhyung Kim escreveu:
> > > On Wed, May 18, 2022 at 9:02 PM Ian Rogers <irogers@google.com> wrote:
> > > > Perhaps more concise with a for_each:

> > > > perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.user_requested_cpus)
> > > >   bpf_map_update_elem(fd, &cpu.cpu, &val, BPF_ANY);

> > So I'll wait for a new version of this patchset.

> I take that back, will apply and this can be a follow up patch, right?

I tested it and added some committer notes, everything is now at my
tmp.perf/core branch and will transition to perf/core on its way to 5.19
later today, after tests finish.

- Arnaldo
