Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7428CC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Apr 2022 12:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiDOMFc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiDOMFc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Apr 2022 08:05:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64665BC849;
        Fri, 15 Apr 2022 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXz8h1scW9TaC95RrqC3BatEUPCpcyZHs+jeJJAB5lU=; b=gFOAcBhkj7dshNd/gESsgNytg4
        +wU3qhVLguQMpX1gII8uGaCrIRVUdkQkAfLkT3dwLNwbnwuTisMgHOySrtixLlprqyVfkFiAUsORH
        43AdiJFu1Ai8Sj5bW8xCX2MqmldYa1XgaLVw3ttgKBhJ91Sie2BTohqEt4ILH0OmXiXDsZmkGcv8I
        h/5dVm+qBnH/miBdd9JQc1bWykYjsLqBmf6k7tkNHUJxH3OiT6Ili5cQ6FzcWHIY57PKvn4azoK4M
        u5pqrj1WycrHDjjMq582HbDlTY5KWsTYk/ogus3h/OMZ/PnftoW5z2Nz5X1swJOJu2mm550vvBeyA
        dYRI5J5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKf2-005ND4-Tv; Fri, 15 Apr 2022 12:02:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 306643001AD;
        Fri, 15 Apr 2022 14:02:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21D7330A3B95B; Fri, 15 Apr 2022 14:02:48 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:02:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        artem.bityutskiy@linux.intel.com
Subject: Re: [PATCH] perf/x86/cstate: Add SAPPHIRERAPIDS_X CPU support
Message-ID: <Ylle6DyUaPRnwfvQ@hirez.programming.kicks-ass.net>
References: <20220415104520.2737004-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415104520.2737004-1-rui.zhang@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Apr 15, 2022 at 06:45:20PM +0800, Zhang Rui wrote:
> From the perspective of Intel cstate residency counters,
> SAPPHIRERAPIDS_X is the same as ICELAKE_X.
> 
> Share the code with it. And update the comments for SAPPHIRERAPIDS_X.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!
