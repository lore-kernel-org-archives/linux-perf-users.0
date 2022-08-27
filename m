Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39030ECAAD2
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 Aug 2022 14:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiH0Oj7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 Aug 2022 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH0Oj6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 Aug 2022 10:39:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC98F65;
        Sat, 27 Aug 2022 07:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8949CB801B9;
        Sat, 27 Aug 2022 14:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F6AC433C1;
        Sat, 27 Aug 2022 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661611194;
        bh=0Zin8pbPbVGewOKe02wxwlWXtVF69Xv0Y2NqAFzB/JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpWIDOTbfNA/CQeH7hE5+hIh5sN8GpIxgyIyAc3SUmqjk+GOo90HCqgJH7wIR3Qou
         Qz8O/tNRMYcA6LnbqqajLrEs16vejmbgpQS0vQ9BlVzFCTXpuWiE9EKZXfzhwqSvp1
         1eVoTVudso4L7UuDPx2HnSaBvhTPwdua/eXmcT5mwLPUK4b0/G+tgP9EiuUZSe2M1D
         qhbCi3MOVPzqna1iWDCKK22jSuWb5re7+7vSd7s9gg0QwTmZG8e07/OykzLpI5AkWd
         153wH21+k3zix88iNlqBBOuJ/ui+ZERaTTaHl+ojV9sswP+EsvzoCUCwXOcJRRGZP/
         sa1W/3UXtNmvw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 94D38404A1; Sat, 27 Aug 2022 11:39:50 -0300 (-03)
Date:   Sat, 27 Aug 2022 11:39:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH] perf stat: Capitalize topdown metrics' names
Message-ID: <YwostqgMmcP563MD@kernel.org>
References: <20220825015458.3252239-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fXzeqd3kS15_+9fEFERJtxkJLvP5sEj597D-BMmAwSheA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXzeqd3kS15_+9fEFERJtxkJLvP5sEj597D-BMmAwSheA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 26, 2022 at 01:54:09PM -0700, Ian Rogers escreveu:
> On Wed, Aug 24, 2022 at 6:53 PM <zhengjun.xing@linux.intel.com> wrote:
> > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

