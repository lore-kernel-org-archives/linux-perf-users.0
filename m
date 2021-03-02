Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC899C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909C864E90
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbhCCFAG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444897AbhCBMl3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Mar 2021 07:41:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA92564F3B;
        Tue,  2 Mar 2021 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614688414;
        bh=otT9ilRgJ+9mGh21GcAZ6n5UE98pPEtu7abLZ/Fzx5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6KMTuoGqEq1rlzZ5nNj89M34p4Xq4ho0U/p+h6davxggxE90ucneTi7zjhkfF2w+
         EFHKorkPKonms8nXzVq5EiwJUhx4TcKPjfA8bkXf689rSRdt05cwg5dV+Wr46rS1mB
         7sLvZmnux35JgIAdibTe8OyiJKZ54fcDKbXeDScvW1RMKZnsVF1pTXXAPXWYlgk4CH
         CIQ8bdMMmWAYXAH9s8Z5bgJ7D9xzBURVqX3x0JKrfdNgP+TL2BkGn6OwFZkEKzLSSC
         VjZ0Ak7nJFVUeKXHnhdYTzNFwL+84JYdVzwIMJ5R1YNnI17wgKcWj7Ebo07tBQffeZ
         sCIlisr+Jz8jg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A97ED40CD9; Tue,  2 Mar 2021 09:33:31 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:33:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mpe@ellerman.id.au,
        jolsa@kernel.org, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        peterz@infradead.org
Subject: Re: [PATCH] perf bench numa: Fix the condition checks for max number
 of numa nodes
Message-ID: <YD4wm2I48rXUM/1D@kernel.org>
References: <1614271802-1503-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <20210226085827.GF2028034@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226085827.GF2028034@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Feb 26, 2021 at 02:28:27PM +0530, Srikar Dronamraju escreveu:
> * Athira Rajeev <atrajeev@linux.vnet.ibm.com> [2021-02-25 11:50:02]:
> 
> > In systems having higher node numbers available like node
> > 255, perf numa bench will fail with SIGABORT.
> > 
> > <<>>
> > perf: bench/numa.c:1416: init: Assertion `!(g->p.nr_nodes > 64 || g->p.nr_nodes < 0)' failed.
> > Aborted (core dumped)
> > <<>>
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo

