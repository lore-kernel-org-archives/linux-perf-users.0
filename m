Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13099EB64DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 20:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjFMUa7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjFMUay (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 16:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B591BE8;
        Tue, 13 Jun 2023 13:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE3866124B;
        Tue, 13 Jun 2023 20:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF1AC433B7;
        Tue, 13 Jun 2023 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686688246;
        bh=krtMn/ptOU5M7jSt0Q+VlGwLfY4X8qDf28PoRTLFcHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saW9/RLgVebsN6+Azefx/Be6dICpagsT9k2SRXenZaQQAWwXG+ubuBw8jNyYS9EBc
         08/nVBFQUj8F9QxnAOsRaMKWPZ0JR28+Reyy58adVpn5KqPJTdWJU7u6FCpOmIJyIi
         bdyaRgOUzwRDZRYHvnl7uoZg6qqi0gCQyixybf7wA35pS9Hu5vdialvevxPTYi2Opq
         9kQ7Nl6YfnpJu0uio3k2zmU5ZTVZr2YiRi/LSFlkXNY5gW0M+rm5PCjDATU9RxezUS
         xhPjgox1rn3Gcny91R8jP8CXA8ZdVKMZOpNiXxNgWY4hApafG3N3c+4LGs5zDkNVd/
         PCiB/ZHDaIw1g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8620540692; Tue, 13 Jun 2023 17:30:43 -0300 (-03)
Date:   Tue, 13 Jun 2023 17:30:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
Subject: Re: [PATCH 7/8] pert tests: Support metricgroup perf stat JSON output
Message-ID: <ZIjR87AnexiHvGNX@kernel.org>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-8-kan.liang@linux.intel.com>
 <CAP-5=fX9E0g28spjC2k_YUKz6Vm2AKe_1VLJoapStHY6juDX1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX9E0g28spjC2k_YUKz6Vm2AKe_1VLJoapStHY6juDX1A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 13, 2023 at 01:17:41PM -0700, Ian Rogers escreveu:
> On Wed, Jun 7, 2023 at 9:27 AM <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > A new field metricgroup has been added in the perf stat JSON output.
> > Support it in the test case.
> >
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
