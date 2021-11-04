Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325A8C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 12:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EFF611C3
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 12:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKDMoO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 08:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhKDMoN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 08:44:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9155661076;
        Thu,  4 Nov 2021 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636029695;
        bh=tm1jxyM2CruVcvCN1+NzNrnNVK1F1pL507EKiIPEzIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYJ4oniK6iE1s8+hO6DmN+xJm6fDga/eERAcDPf5cm/OOsfEYG5wkdR/LYzGUDoEu
         +m8Ysf7lUJamQGPNZTb3OlgJ3zKaeib19dPwosjO1cOao8Y7WOg6Z4wcJz8jvah3c+
         zf0P+NCSjlWu2d0T9KoGZpRLvGLwOjjqqQqgb6MDUmYqMkzjPLrfkc36j7OZ2hWJ7i
         UeQNeeGZmand9iG8RUB4JiIQYE2u20zcQ3wRwJfhyVxav+w8ROa76tgD2nlkPdnOiD
         mE8rG2ecYlae/aK/PTSuYYvyZze/VaK1nPQNxxqGfFaNskZG7KkE5yVmgUgq8eu3Pw
         4CVMPfuqwjdkA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35BD2410A1; Thu,  4 Nov 2021 09:41:33 -0300 (-03)
Date:   Thu, 4 Nov 2021 09:41:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v2 1/2] tools: Bump minimum LLVM C++ std to GNU++14
Message-ID: <YYPU/Yol/KlVvDH6@kernel.org>
References: <20211012021321.291635-1-irogers@google.com>
 <CAFP8O3L_Oi916yOAuPB7MFpa3QoDQtreRbV7oNt2Yh6h1Coq9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3L_Oi916yOAuPB7MFpa3QoDQtreRbV7oNt2Yh6h1Coq9A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Oct 11, 2021 at 08:09:01PM -0700, Fāng-ruì Sòng escreveu:
> On Mon, Oct 11, 2021 at 7:13 PM Ian Rogers <irogers@google.com> wrote:
> >
> > LLVM 9 (current release is LLVM 13) moved the minimum C++ version to
> > GNU++14. Bump the version numbers in the feature test and perf build.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> 
> Reviewed-by: Fangrui Song <maskray@google.com>

Thanks, applied both patches.

- Arnaldo
