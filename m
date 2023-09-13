Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239CFEDEC50
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Sep 2023 13:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbjIMNc7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 09:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbjIMNcn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B01BCB
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EOkYNpzApRJQCT/O2B5pDACJi7EP5ROb+5sy26SlgUs=; b=Dv0Hoc+Ai7nDr4phmRjMnDxNr0
        RkIKIOZbO0BD2W4UXMidT8ePWJJmNOP13olxVP3nkE34UTJ23gHR2rkZFx+3ncSk6gv6McXjUtumJ
        n5grZJ/fYJhcUiWFFNJhkGiM0pwQA1ZRS2OxeVzIRzFZ7aPN5/ItCOmdvltDq4QbARjI0zp2nT/yf
        fdM6Is1MtLzCGIJqVoDm575F7hSjMWnDjefe2wLhSOEbh2/pSTZQzB4QTndP+UeFnzRMoKKqcs2i6
        xaFhgbU0eh9FD0XhXDUOael8Ie4KVf/PaRWslpO/T1RfosT5b518m1v9SV+7YPynnoxfiBQzaxxTQ
        NZbjer0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgPyh-00758R-3D;
        Wed, 13 Sep 2023 13:32:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 080E6300321; Wed, 13 Sep 2023 15:32:25 +0200 (CEST)
Date:   Wed, 13 Sep 2023 15:32:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        mingo@redhat.com, acme@kernel.org, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com
Subject: Re: [RFC PATCH 2/4] mm: Add vmalloc_user_node()
Message-ID: <20230913133224.GG22758@noisy.programming.kicks-ass.net>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821202016.2910321-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 21, 2023 at 09:20:14PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow memory to be allocated on a specified node.  Use it in the
> perf ring-buffer code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
