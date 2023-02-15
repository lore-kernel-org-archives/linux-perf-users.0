Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5FDC636D4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Feb 2023 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBOQ00 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBOQ0Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Feb 2023 11:26:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706F32E69;
        Wed, 15 Feb 2023 08:26:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFAC0B8227C;
        Wed, 15 Feb 2023 16:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3C2C433D2;
        Wed, 15 Feb 2023 16:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676478381;
        bh=9VX3svrOzPw+rXncQ3Bv54ZK8lAuEuYMMAhfyldbWvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAEGTyfEeAn+aLr7x1OWy/OOqqEbD0ofNfuj2tTjINboGLOmRftJpDro6Od+uYREK
         pHz6P8BF7wx3/bNqZzh3QgWUOAZ6RLduvnsPsQGhpBXvH8JgNVbj8dO1Sp1PcVZ4q6
         mI5Lg5arSGlAYy/1mryt8Ulg3WjsJhiHdBM7GpbYGv/ZEg8etdANbdsNrQBhmWH1vI
         0isuHNe0B+C2LcWqdLn30EoHSjNA1U1AO6fOmaqEO17mLMze0fpO/gSyubyRT9ApoP
         OmJacgg1QrwjLlAEnOgfwy7JsHxq5eU2Gxs6wjOC/kWY/4Gus9Zrbmu5ovP7EsGchH
         z2ys6F4S1xAAA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A763A40025; Wed, 15 Feb 2023 13:26:18 -0300 (-03)
Date:   Wed, 15 Feb 2023 13:26:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ian Rogers <irogers@google.com>, linux-kernel-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, hca@linux.ibm.com,
        egorenar@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        sumanthk@linux.ibm.com
Subject: Re: PING Re: [PATCH] tools/perf: Fix perf tool build error in
 util/pfm.c
Message-ID: <Y+0Hqgb4fFTx9XlX@kernel.org>
References: <20230207140447.1827741-1-tmricht@linux.ibm.com>
 <Y+JoGRdML/Ckkwvb@kernel.org>
 <CAP-5=fU6vHFp1YeY9RyAUE_rS5PMECcUWdnMhR-QsMnAN0wy7g@mail.gmail.com>
 <Y+OmaXOdMEM4II57@kernel.org>
 <Y+OnKl9wYcbFvHLY@kernel.org>
 <Y+Osp+SY+1WTHvwR@kernel.org>
 <283ace48-0e69-08a4-cfd2-7bee5779c45c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <283ace48-0e69-08a4-cfd2-7bee5779c45c@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Feb 15, 2023 at 03:17:44PM +0100, Thomas Richter escreveu:
> Friendly ping, is this already in linux-next?

To answer that, next time, please:

$ git remote add linux-next git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
$ git checkout -b linux-next-master linux-next/master
$ git log -10 --no-merges --oneline tools/perf
8f46f36d81a6b4f5 mm: discard __GFP_ATOMIC
14292a4ae1a37a7c perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1
f00eccb447762c99 perf build: Fix build error when NO_LIBBPF=1
213b760fbc69f2d6 perf tools: Don't install libtraceevent plugins as its not anymore in the kernel sources
dce088ab0d51ae3b perf kmem: Support field "node" in evsel__process_alloc_event() coping with recent tracepoint restructuring
b3719108ae60169e perf kmem: Support legacy tracepoints
d891f2b724b39a2a perf build: Properly guard libbpf includes
6f9aba7f0d74e8dd perf tests bpf prologue: Fix bpf-script-test-prologue test compile issue with clang
481028dbf1daa280 (tag: perf-tools-fixes-for-v6.2-1-2023-01-06, tag: perf-tools-fixes-for-v6.1-1-2023-01-06) perf tools: Fix build on uClibc systems by adding missing sys/types.h include
54b353a20c7e8be9 perf stat: Fix handling of --for-each-cgroup with --bpf-counters to match non BPF mode
$

So it isn't there, then:

⬢[acme@toolbox perf]$ git log --oneline -5
91621be65d6812cd (HEAD -> perf/core) perf record: Fix segfault with --overwrite and --max-size
37f322cd58d81a9d (quaco/perf/core, acme/tmp.perf/core) perf stat: Avoid merging/aggregating metric counts twice
6a5558f1166473f7 (seventh/perf/core, acme/perf/core) perf tools: Fix perf tool build error in util/pfm.c
ffd1240e8f081426 perf tools: Fix auto-complete on aarch64
1bece1351c653c3d perf lock contention: Support old rw_semaphore type
⬢[acme@toolbox perf]$

It is in my perf/core branch for some time, so should've been in
linux-next by now:

⬢[acme@toolbox perf]$ git show --pretty=fuller acme/perf/core | head
commit 6a5558f1166473f741de33c32ffb161d7f7732cb
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Tue Feb 7 15:04:47 2023 +0100
Commit:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed Feb 8 11:07:47 2023 -0300

    perf tools: Fix perf tool build error in util/pfm.c

    I have downloaded linux-next and build the perf tool using

⬢[acme@toolbox perf]$

In such cases please CC the linux-next maintainer:

Stephen, can you please merge acme/perf/core into linux-next?

- Arnaldo
