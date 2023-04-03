Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D28C76196
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Apr 2023 20:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjDCU0w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjDCU0B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Apr 2023 16:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB94687;
        Mon,  3 Apr 2023 13:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 951AC62A7A;
        Mon,  3 Apr 2023 20:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC006C433A0;
        Mon,  3 Apr 2023 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680553503;
        bh=dRX05bqC+b/gPVRZPnCE6TBdgcL3wnJnZIX1Z+syodI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJOLT8iKtHB/vEuVrSJ0Xg0JMA6dc1geO6bNdaaPhmwQto614HtT7wBGXCt7mTKDs
         cOseonfo8v94fFzqY73EsTO8OpG7OdIfMKpP5s1IrQUtB+jpB9heHDIVLTTlDxWu1N
         kaNSdqEy9eeQBluDsfaac0xzJhfCvGQ6JbH8E0B1e81Ua2q9dF1BwQlRlwcKGDSQuV
         YUNVp8d3ipoR9pYk1SIsBU5NDhgnT88XsS9t2kibMuqauWxWwG9NiX/rqPao0WJZ1v
         Mf+/VEyob1h66VXSfvk+ZzcWT7/V1L3NXBjSp2PePTbqwO+O7KRggYYI1EXSbSR1Ds
         LJRPDW8DollgA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 718224052D; Mon,  3 Apr 2023 17:25:00 -0300 (-03)
Date:   Mon, 3 Apr 2023 17:25:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCHSET 0/9] perf tools: Update pmu scan using openat() (v1)
Message-ID: <ZCs2HO0m8lPjyGgH@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
 <CAP-5=fWC1v+vsi-qmYXy8VMKXOsscYobucwS3GZw=gycdnAc3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWC1v+vsi-qmYXy8VMKXOsscYobucwS3GZw=gycdnAc3w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Apr 03, 2023 at 10:28:28AM -0700, Ian Rogers escreveu:
> On Fri, Mar 31, 2023 at 1:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
> 
> Some nice stack size savings too. The reentrant fix was pre-existing. Series:
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

