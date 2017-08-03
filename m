From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf report fix module symbol adjustment for s390x
Date: Thu, 3 Aug 2017 09:45:46 -0300
Message-ID: <20170803124546.GO12201@kernel.org>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170802184202.GK12201@kernel.org>
 <8b684e81-5af9-4b61-0116-3b2ff6492318@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdHCMpu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Aug 2017 08:45:50 -0400
Content-Disposition: inline
In-Reply-To: <8b684e81-5af9-4b61-0116-3b2ff6492318@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

Em Thu, Aug 03, 2017 at 11:37:02AM +0200, Thomas-Mich Richter escreveu:
> On 08/02/2017 08:42 PM, Arnaldo Carvalho de Melo wrote:
> > Then have it as:
> > -			/* Adjust symbol to map to file offset */
> >  			if (adjust_kernel_syms)
> > -				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> > +				arch__adjust_sym_map_offset(&sym, &shdr, map);

> > I.e. the weak function name becomes the comment :-)
 
> Ok , I will provide a version 2 with your findings fixed. I'll include a 
> Reviewed-by:
> if this is ok with you.

yeah.

- Arnaldo
