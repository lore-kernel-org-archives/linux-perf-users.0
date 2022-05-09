Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4841BC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 May 2022 11:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiEIL3D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 May 2022 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiEIL3A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 May 2022 07:29:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41015E4BE;
        Mon,  9 May 2022 04:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YScxnhzRdQqU14J732VLJGoeR3Q/aXXM1aphQ5BtTvI=; b=DssNIyVuIMhVqhrbRGDR+oyERD
        0tq/XMLiYsz03mESHyRDm3HM8pS0SBrERLUGmxCYE+kKMeBrjzmL3piRpWWicSiNHIlrHuebll2Ar
        /ZEfYOFsUqL6p6L1Ne1SpbJjA1emvZhx89pX+3nnWjR+/EnMDa2KKOeqVljkOyaAxg+U59DXRE57M
        YFpaBEaBqPa7inO6W2rDD7UfBNvPmu3Z4F+5n4lazwBbIe7ybEvSLB/xAeOftNwcsQOdYg6Igqu7R
        dCyZyMiECzJqF9lo2iQdCOfaelhu7XtLUPyS9vvvMYXwreU7GL9WDQ72jxN7cwk0KdkDszs2VykgI
        22xJN1Fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no1VH-00CXHC-5f; Mon, 09 May 2022 11:24:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1DF64300459;
        Mon,  9 May 2022 13:24:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F08692026963D; Mon,  9 May 2022 13:24:37 +0200 (CEST)
Date:   Mon, 9 May 2022 13:24:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Like Xu <like.xu.linux@gmail.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Message-ID: <Ynj59beTAl1KAkSD@hirez.programming.kicks-ass.net>
References: <cover.1651058600.git.sandipan.das@amd.com>
 <5c30d99af03fff90e2fc3165755d18d14bdb229f.1651058600.git.sandipan.das@amd.com>
 <c313e9c9-97eb-8273-5bb7-553692e8e2f5@gmail.com>
 <0b9dced9-a080-1b00-3315-5ba22537558f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b9dced9-a080-1b00-3315-5ba22537558f@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 09, 2022 at 03:28:07PM +0530, Sandipan Das wrote:
> 
> Since these patches are now in perf/core, should I send out a separate
> fix for this?

Yes please.
