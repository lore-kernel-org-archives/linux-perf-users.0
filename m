Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4778C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  6 Feb 2022 12:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiBFMUQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 6 Feb 2022 07:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiBFMUQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 6 Feb 2022 07:20:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40622C06173B;
        Sun,  6 Feb 2022 04:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED31DB80E00;
        Sun,  6 Feb 2022 12:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FFCC340E9;
        Sun,  6 Feb 2022 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644150012;
        bh=rmS39PQQpVrNEsbKn3Wq8YX2ZQ7yX5dpukjLYRMbEjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNG22MA/R4d469cz8AZnRjAXiOLMoQKvH6EKTCb644Wsdm0wznj+B2A/gwJ+e01MD
         0wQFHLHWtF4DbLBC/mhfYNN1GUr9U7yVaAGTgDLZfhjKGN0b1uRm7IqbVCGdBgPCIn
         9j9O/Om4t+KiUjlmGndvj+p9HwmBmx8D92q3RztIbknEIDnqvfUwZ7Ez9GuiF4NpCB
         c++dSO3jt0ezuPF7Oa74fdFi+4B7qrzsR+DP+48jST3QlYPeygb9s1Z92UZh7FIwRr
         4EXqeKcNX4sykwn4fFQqvDJvzqGOl4fIplM+qOZ1pzezIzg/Dwr+1PueEgg8TxtgsX
         8ehDsP8MPGn9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A402F404A6; Sun,  6 Feb 2022 09:20:10 -0300 (-03)
Date:   Sun, 6 Feb 2022 09:20:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf/ftrace: system_wide collection is not effective
 by default
Message-ID: <Yf+8+uFpKyjdppOq@kernel.org>
References: <20220127132010.4836-1-changbin.du@gmail.com>
 <CAM9d7cgPhL9roWuJ=ktKRCGQTM824JEvi+Ar5mibCnK9LWku6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgPhL9roWuJ=ktKRCGQTM824JEvi+Ar5mibCnK9LWku6A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Feb 01, 2022 at 08:47:49PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> On Thu, Jan 27, 2022 at 5:20 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > The ftrace.target.system_wide must be set before invoking
> > evlist__create_maps(), otherwise it has no effect.
> >
> > Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> Acked-by: Namhyung Kim <namhyung@gmail.com>

Thanks, applied.

- Arnaldo

