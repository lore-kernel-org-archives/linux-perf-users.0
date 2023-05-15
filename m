Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E01CC77B7D
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 21:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbjEOVgL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 17:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244828AbjEOVgK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 17:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A2193E1;
        Mon, 15 May 2023 14:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B3D62F5C;
        Mon, 15 May 2023 21:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1DFC433EF;
        Mon, 15 May 2023 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684186568;
        bh=yVMfigRqbwuLd0lKbQ225cAOSjz+f1SaBJpA8GhslDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfT5fgvyUTEzq1Xdjt4TEMqcP3UVAMR7kiRY7YRHlbae1GSI5jHr9NyBy9JHXHOw0
         sK2Vbp3gNbROVX28M7hBoemhARKnXCnO92IX15YPOgkdjL//xmUjUcNCP2IodgZWwq
         xLbtHJmgQE0aJgSVeEDZl3joO2ZH1VbSk8dj2PWVYh5wIHsRv22CLkvwj617pmdTpv
         5TbRY/ExxEd+t/zXoflQI6sIjOLZvTCOaSxTgewlfkYyvYyh/P2PwH/Vzgq6z0Kc+c
         vP4X6zK9FSzc/BaOv35EU3MGch03MaX16kVypv8z+M/sj72Nb5UcbzLzmxHSrxBJlB
         JRX2zFlGqG+cQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D62C9403B5; Mon, 15 May 2023 18:36:05 -0300 (-03)
Date:   Mon, 15 May 2023 18:36:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ian Rogers <irogers@google.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf vendor events arm64: Add AmpereOne core pmu events
Message-ID: <ZGKlxfNQ7NP/9+ZZ@kernel.org>
References: <20230427223220.1068356-1-ilkka@os.amperecomputing.com>
 <CAP-5=fV-CwUgbKfCndJvMcnWpB7H3Z03sqiAjiFa1DsoOqNn4g@mail.gmail.com>
 <509f8dde-4e93-b2b4-c960-d1ea7f8f9cef@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <509f8dde-4e93-b2b4-c960-d1ea7f8f9cef@oracle.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, May 01, 2023 at 01:20:01PM +0100, John Garry escreveu:
> On 29/04/2023 22:13, Ian Rogers wrote:
> > On Thu, Apr 27, 2023 at 3:33 PM Ilkka Koskinen
> > <ilkka@os.amperecomputing.com>  wrote:
> > > Add JSON files for AmpereOne core PMU events.
> > > 
> > > Signed-off-by: Doug Rady<dcrady@os.amperecomputing.com>
> > > Signed-off-by: Ilkka Koskinen<ilkka@os.amperecomputing.com>
> > This looks good to me, but if John Garry has input I'll defer to that.
> > Acked-by: Ian Rogers<irogers@google.com>
> This all looks fine, thanks
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks, applied to perf-tools-next.

- Arnaldo

