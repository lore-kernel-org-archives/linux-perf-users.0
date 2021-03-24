Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A895C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Mar 2021 13:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED54361A0E
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Mar 2021 13:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhCXNdo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235239AbhCXNdW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Mar 2021 09:33:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 969D9619B4;
        Wed, 24 Mar 2021 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616592801;
        bh=Z8x7kZATULqfD+iGYkBLhh3UA9FKueZ/wpwb494vW78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1vwctBKxuTQp1RH3A6JHp+l4hAAc90SpPPQEFlr/Cin9l6y6ZGiwVuO9xe/Hdiqq
         W6VbXXGodHNJgCCGTixOAsYCamxbqUhTAQBOb/joWrfLy3e9/y3Wat67uF8Pqb/KGS
         3nNetsp1vQk+uZCpd8XNUZsfQGVabIBweqlY7dBFVpy0fRIoZZrtAeQtn/6RbqkESP
         7u9EIs3Jhjm5StK9bugeFdjIUJkla1YmVX25edK+mz7rnJGtchh/vOkTn0bYo9RXmw
         zWSU0M/ltpx5oTZwrGUC5z5u+S9FqMx2KsBWWFkoJKmrh1TQVdlBkjlVI+D4aUT1/6
         5lHogJRV1FT8Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8249A40647; Wed, 24 Mar 2021 10:33:19 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:33:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf test: Remove perf sub test 42.4 BPF relocation
 checker
Message-ID: <YFs/n7y2YFhzuZ40@kernel.org>
References: <20210324083734.1953123-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324083734.1953123-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Mar 24, 2021 at 09:37:34AM +0100, Thomas Richter escreveu:
> For some time now the perf test 42: BPF filter returns an error
> on bpf relocation subtest, at least on x86 and s390. This is caused by
> 
> commit d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")
> 
> which introduces support for global variables in eBPF programs.
> 
> Perf test 42.4 checks that the eBPF relocation fails when the eBPF program
> contains a global variable. It returns OK when the eBPF program
> could not be loaded and FAILED otherwise.
> 
> With above commit the test logic for the eBPF relocation is obsolete.
> The loading of the eBPF now succeeds and the test always shows FAILED.
> 
> This patch removes the sub test completely.
> Also a lot of eBPF program testing is done in the eBPF test suite,
> it also contains tests for global variables.

Thanks, applied.

- Arnaldo

