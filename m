From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Question to struct map
Date: Wed, 13 Sep 2017 12:18:34 -0300
Message-ID: <20170913151834.GG5866@kernel.org>
References: <1d758097-b01b-cbad-913a-855a61f8ce73@linux.vnet.ibm.com>
 <20170912151756.GB3452@kernel.org>
 <ff3ff19d-de45-61f9-cd16-5d7c39c67cf0@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdIMPSi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2017 11:18:38 -0400
Content-Disposition: inline
In-Reply-To: <ff3ff19d-de45-61f9-cd16-5d7c39c67cf0@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Wed, Sep 13, 2017 at 04:48:03PM +0200, Thomas-Mich Richter escreveu:
> On 09/12/2017 05:17 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 12, 2017 at 05:04:53PM +0200, Thomas-Mich Richter escreveu:
> >> I have a question regarding struct map. 
> >> What is the purpose is the functions pointers in struct map named map_ip and unmap_ip?
> >> How do they relate the to dso the struct map is refering to?

> > A DSO has a symbol table (ELF or other kind, like the JIT ones
> > (documented in tools/perf/Documentation/jit-interface.txt) that may be
> > identity mapped or not, requiring or not use of relocation, etc.

> > The map, on the other hand, is where this DSO was loaded in memory,
> > which will be used to add to the symbol offset to do the address
> > resolution.
> 
> I think I got it now.
> The map__map_ip() function converts a symbol's virtual memory address to the
> byte offset of that symbol in the ELF file.
> 
> The map__unmap_ip() function does the opposite.
> 
> Thanks for the explanation.

You're welcome, and if I may suggest, please consider these moments as
opportunities to help people that, like you, scratch their heads in the
future about these pointers, adding comments to the struct definition
:-)

- Arnaldo
