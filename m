Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C505CC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 03:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73EC60EE5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 03:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJLDLO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 23:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhJLDLO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 23:11:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F9C061570
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 20:09:13 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q189so43528708ybq.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Oct 2021 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTVshl9Jefo2BzQxtGM9kFLryo0edF9MOJ5E+vVxA44=;
        b=efFH465LIdLBSe6pxeyXd6rpuBwhMRC7O641rjKon+zYzEi5zbCl6aXlyPw/kzRD2e
         hxvl04IAP8Lu0xmEIuQ1Y28asASEfpDySl+jvc7b+sXSYgSIxyN3/50TvP50fjOYDyby
         VQpu6oRd5fS7xFjzsN9pB0qHjFoZixL6UN3Dro8F0prUKfJUku4cuuPpEMV4Y5tsvhTJ
         Yb0Uw6u4NXyR9qD8lSLLvqFk5Dz4TqSZQPR//vgcu3rf69JusHZmsVHWLln1Cj7+r9x0
         wHDrZfrg5nQWhQ6Q6OTKuA66jB8rYEhjj7KXv0FW+8d3CyhCxSTmxFV5VWpUlYcTABEc
         sBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTVshl9Jefo2BzQxtGM9kFLryo0edF9MOJ5E+vVxA44=;
        b=EmI6iWdyNO5K9JnMr5K14HWYOra2Ofd//xBNf+pr2DokMKKt/a0xHPKhEpY8VPxN4h
         7PR7xzHIkUtaC4quTZQAp+ys7+ZDdIRiTAJRAx2o4NQZ2qUiWQSFG24ywfRjHi9M9615
         vzox6X4hf4XMAWnBjivpZVMoEoFMyIg27ySIVKs3mufjYIaAp+WJuFAvTtFJgxvC4Q77
         hv1JQR0q75jbmHVDl9Y2+g7aVD6ASd72Y+7wo31Rtb6XT8V8LBJJhqOcyVlN8uJwgBEm
         gUj5hdsDDOI6GwRN9XuSp3r8v2sheL5KTiLFp+Ueq1b1r4GgoLOIywi0i+q9IPumifWY
         9Z5w==
X-Gm-Message-State: AOAM532Rb32ECK26cETAaB6o1GictIm7nyIcBtKIXFMRQfzhOcofqMa1
        TLAlQIsewM2Meine+HOE7qVg10FGGMMWL1iRJ63YxA==
X-Google-Smtp-Source: ABdhPJzJS9y19I8QsN2CIc+h2Q+qEVwU2WZQBTowP4Q1pR7aazPCRPw2H9xNl2hUVLv6e/ATtWp904GkhyIGzEVaBg4=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr27043351ybg.111.1634008152410;
 Mon, 11 Oct 2021 20:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211012021321.291635-1-irogers@google.com>
In-Reply-To: <20211012021321.291635-1-irogers@google.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 11 Oct 2021 20:09:01 -0700
Message-ID: <CAFP8O3L_Oi916yOAuPB7MFpa3QoDQtreRbV7oNt2Yh6h1Coq9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools: Bump minimum LLVM C++ std to GNU++14
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 11, 2021 at 7:13 PM Ian Rogers <irogers@google.com> wrote:
>
> LLVM 9 (current release is LLVM 13) moved the minimum C++ version to
> GNU++14. Bump the version numbers in the feature test and perf build.
>
> Signed-off-by: Ian Rogers <irogers@google.com>


Reviewed-by: Fangrui Song <maskray@google.com>
