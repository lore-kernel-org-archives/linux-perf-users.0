Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D542BEE49B2
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 12:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjHWMQY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjHWMQX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 08:16:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C12CD5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h0H52xtfgXFJKiojPzFRYLqgYQ7ep2Z8nxNUt3SOtYM=; b=GPm0QEcyStjGCZAY16pXw8tT+b
        ldLMGoakETXe0XejoNRcudwYIKQzIrdWXzAZcSMrr9eePbxdW9yVWOq2/TbhzUdRRsotzxgRhERVR
        DaHBHD8iTv+azZNBUSt4zK94JcrnisuibvxfnVfvtbCADNzSES0nB/+pJYJyWrWongStPFBubcP5M
        o2hDjof0my04gfbzY/VjHI3oyZU40q5GWwnu2HKhnzMrAnNFyMtkMYabgx4+M4v+f3kAHCIaRSkNn
        8qrpxDGHCU13dHtGuDFKZu1eHS4+H4iq1VB+GX8ac6fdvdGDjexaTu0KOGhvygtUTi5UetsCi+p69
        heSlVxYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYmmU-004l34-Sa; Wed, 23 Aug 2023 12:16:14 +0000
Date:   Wed, 23 Aug 2023 13:16:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com
Subject: Re: [RFC PATCH 3/4] perf: Use vmalloc_to_folio()
Message-ID: <ZOX4jq8Kir6yZCnO@casper.infradead.org>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-4-willy@infradead.org>
 <627a43c1-048b-c6c7-62ab-28dc111a055e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627a43c1-048b-c6c7-62ab-28dc111a055e@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 23, 2023 at 03:30:22PM +0800, Yin Fengwei wrote:
> On 8/22/23 04:20, Matthew Wilcox (Oracle) wrote:
> > +static inline struct folio *vmalloc_to_folio(const void *addr)
> > +{
> > +	return page_folio(vmalloc_to_page(addr));
> I am wondering whether we should check the return value of vmalloc_to_page()?

That's a good question.  Almost every user of vmalloc_to_page() just
assumes it works.  But it'll cost very little to check for NULL, so
I'll put that into the next version.  Thanks!

