Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B477EE49B0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 12:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjHWMYC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHWMYC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 08:24:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC0CD5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NAn7Et+nztXESFPu12aEfljdvss36V30xUJRFOCYDik=; b=KB4J0oRGKXky6wM0JaxipxV2LA
        9UMJBaEnoOehAfxgL1vhnEF4e0aE7f4gCC7v+yxjC5B8RuqKeZ/eGTPdEiWXeBPLnEJAPl4858djn
        YVNKkw8FwSdKQP1SKnuip+KrhKkYoey6fRXYlFoj48ITb2fNFpJqfbBPaODcrlJHLpTbZU/IsREv+
        VLkmGkL+lOIDQmnEgtzTnvEiOvyKxhd2CIxXVC/x23C19kfCnK2PD9IsA484ZR9dL9IqBtfkLZj0Q
        0jSX+ArokHZNEBLDhpOa7hVAVnqv4UPeUXm2/1qOTFJPTvlEvODyDdFcsFLlpYBZBBbyTQy22m17K
        raPapzPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYmtt-004ncu-4r; Wed, 23 Aug 2023 12:23:53 +0000
Date:   Wed, 23 Aug 2023 13:23:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com
Subject: Re: [RFC PATCH 4/4] perf: Use folios for the aux ringbuffer &
 pagefault path
Message-ID: <ZOX6WXatEmIWXx7O@casper.infradead.org>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-5-willy@infradead.org>
 <05db7f07-2ac2-f4d5-54ea-b5f1633e8c0c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05db7f07-2ac2-f4d5-54ea-b5f1633e8c0c@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 23, 2023 at 03:38:13PM +0800, Yin Fengwei wrote:
> On 8/22/23 04:20, Matthew Wilcox (Oracle) wrote:
> > -	get_page(vmf->page);
> > -	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> > -	vmf->page->index   = vmf->pgoff;
> > +	folio_get(folio);
> > +	rcu_read_unlock();
> > +	folio_lock(folio);
> > +	if (!folio->mapping)
> > +		folio->mapping = vmf->vma->vm_file->f_mapping;
> >  
> > -	ret = 0;
> > +	return VM_FAULT_LOCKED;
> In __do_fault():
> 
>         if (unlikely(!(ret & VM_FAULT_LOCKED)))                                 
>                 lock_page(vmf->page);                                           
>         else                                                                    
>                 VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page); 
> 
> As we lock folio, not sure whether !PageLocked(vmf->page) can be true
> here. My understanding is yes if vmf->pgoff belongs to tail pages. Did
> I can miss something here?

There's only one lock bit per folio; there's no lock bit for individual
pages.  When we check PageLocked() on a tail page, it redirects to the
head page.

__PAGEFLAG(Locked, locked, PF_NO_TAIL)

#define PF_NO_TAIL(page, enforce) ({                                    \
                VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);     \
                PF_POISONED_CHECK(compound_head(page)); })

#define TESTPAGEFLAG(uname, lname, policy)                              \
static __always_inline int Page##uname(struct page *page)               \
{ return test_bit(PG_##lname, &policy(page, 0)->flags); }

and that expands out to:

static __always_inline int PageLocked(struct page *page)
{ return test_bit(PG_##locked, &compound_head(page)->flags); }

