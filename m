Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF19C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 13:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AEC61076
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 13:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhKMNnS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Nov 2021 08:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhKMNnS (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Nov 2021 08:43:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F294361073;
        Sat, 13 Nov 2021 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636810826;
        bh=jQzRLt4dErQKFo4RaHfJ9zEivHlqGx2hhtKxApIRPNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQ7kEGbvm4+5vvhbK58uedwsYXlnBH68hRaa+YML0TdevwsnhjtVoAsM0cxHrU0F6
         iFwzkLWMziBPJuA1pBFwK078ElNCmiB03j134se+C7I8eId8I5X+PCdqcbM8aIF+wD
         qWNjqlpNQ0T9PD+3tU0YaSAbv/0za8xdnYNEwGuTii9VPTqTw80FtqAWVKcdPLer6k
         mkU/MC9JjQG5+HrC1Udq78i4sKbuF92H1urU1TSTiB39P1xEBLIAO4Osa/QzSOIOqm
         H+YV+MT+hO8ngvD33bPi9HcVctCTKJNXkeSSuhz7J8oNfn8zKUqCHwVjtbzHmevyF1
         RhuFPR8kIY8xA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 77563410A1; Sat, 13 Nov 2021 10:40:23 -0300 (-03)
Date:   Sat, 13 Nov 2021 10:40:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 1/2] perf tools: Add more weak libbpf functions
Message-ID: <YY/AR2Dcaws0BAE9@kernel.org>
References: <20211109140707.1689940-1-jolsa@kernel.org>
 <20211109140707.1689940-2-jolsa@kernel.org>
 <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 09, 2021 at 10:49:53AM -0800, Ian Rogers escreveu:
> On Tue, Nov 9, 2021 at 6:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > We hit the window where perf uses libbpf functions, that did not
> > make it to the official libbpf release yet and it's breaking perf
> > build with dynamicly linked libbpf.
> >
> > Fixing this by providing the new interface as weak functions which
> > calls the original libbpf functions. Fortunatelly the changes were
> > just renames.
> 
> Could we just provide these functions behind a libbpf version #if ?
> Weak symbols break things in subtle ways, under certain circumstances
> the weak symbol is preferred over the strong due to lazy object file
> resolution:
> https://maskray.me/blog/2021-06-20-symbol-processing#archive-processing
> This bit me last week, but in general you get away with it as the lazy
> object file will get processed in an archive exposing the strong
> symbol. With an #if you either get a linker error for 2 definitions or
> 0 definitions, and it's clear what is broken.
> 
> In the past we had problems due to constant propagation from weak
> const variables, where #if was the solution:
> https://lore.kernel.org/lkml/20191001003623.255186-1-irogers@google.com/
> 
> There was some recent conversation on libbpf version for pahole here:
> https://lore.kernel.org/bpf/CAP-5=fUc3LtU0WYg-Py9Jf+9picaWHJdSw=sdOMA54uY3p1pdw@mail.gmail.com/T/
> https://lore.kernel.org/bpf/20211021183330.460681-1-irogers@google.com/

Valid concerns and we should improve the situation, but I'm going with
Jiri's stopgap solution so as to have everything buildind for v5.16,
which window is closing.

We can improve this in followup patches.

Thanks,

- Arnaldo
