Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA5C001B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Aug 2023 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjHKNrD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKNrC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2023 09:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE52D72
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 06:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8B864DB0
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Aug 2023 13:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52EC433C7;
        Fri, 11 Aug 2023 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691761621;
        bh=DyVTLT2NItQVze876SzD7NXM5CZcYX0ABirj6tNgd4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upeDHgxLNvMAWBr125SeUwIkH9ZcKPCs2Ki7lPJ0bLJ0aRBaEGrLoZ5+v7436M7Qj
         uAUFU+Yn2I6va1UqiDedV/tOiRw4uunYEoFXFg/GDwQK1YIpNlZ71NpEYRdAjnNsVs
         jW8jFNRbzXOj1MTZiVuEPWR3C2kXoVBKl64BvqV+xXnsR/SB1Q79HNW77rVE3zejNI
         rrv988q0vV6j1OuE4JxGteYMaXONCKTBj5tN7Dq9xBDJvn3e1jpvZB2eQ9v/M+IOwt
         ksCtHKVujOURome8hzXz5KXQiXk2Pps3I1ATcZaP7okLfh66DCvLVrlqEp/oI91zOL
         pdupy2EwFPV2g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B16DE404DF; Fri, 11 Aug 2023 10:46:57 -0300 (-03)
Date:   Fri, 11 Aug 2023 10:46:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH] tools/perf: Fix dso kernel load and symbol process to
 correctly map dso to its long_name, type and adjust_symbols
Message-ID: <ZNY70VuUn0e86bAD@kernel.org>
References: <20230811051546.70039-1-atrajeev@linux.vnet.ibm.com>
 <f21cbbed-8e51-fae1-9e77-56b5d239bafd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f21cbbed-8e51-fae1-9e77-56b5d239bafd@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Aug 11, 2023 at 12:49:35PM +0300, Adrian Hunter escreveu:
> On 11/08/23 08:15, Athira Rajeev wrote:
> > Test "object cocde reading" fails sometimes for kernel address
> > as below:
> > 
> >     Reading object code for memory address: 0xc000000000004c3c
> >     File is: [kernel.kallsyms]
> >     On file address is: 0x14c3c
> >     dso__data_read_offset failed
> >     test child finished with -1
> >     ---- end ----
> >     Object code reading: FAILED!
> > 
> > Here the dso__data_read_offset fails for symbol address
> > 0xc000000000004c3c. This is because, the dso long_name here
> > is [kernel.kallsyms] and hence open_dso fails to open this
> > file. There is an incorrect dso to map handling here. The
> > key points here is:
> > - dso long_name is set to [kernel.kallsyms]. This file is
> >   not present and hence returns error
> > - DSO binary type is set to DSO_BINARY_TYPE__NOT_FOUND
> > - dso adjust_symbols is set to zero
> > 
> > In the end dso__data_read_offset() returns -1 and the address
> > 0x14c3c can not be resolved. Hence the test fails. But the
> > address actually maps to kernel dso
> > 
> >     # objdump -z -d --start-address=0xc000000000004c3c --stop-address=0xc000000000004cbc /home/athira/linux/vmlinux
> > 
> >     /home/athira/linux/vmlinux:     file format elf64-powerpcle
> > 
> >     Disassembly of section .head.text:
> > 
> >     c000000000004c3c <exc_virt_0x4c00_system_call+0x3c>:
> >     c000000000004c3c:	a6 02 9b 7d 	mfsrr1  r12
> >     c000000000004c40:	78 13 42 7c 	mr      r2,r2
> >     c000000000004c44:	18 00 4d e9 	ld      r10,24(r13)
> >     c000000000004c48:	60 c6 4a 61 	ori     r10,r10,50784
> >     c000000000004c4c:	a6 03 49 7d 	mtctr   r10
> > 
> > Fix the dso__process_kernel_symbol function to set the
> > binary_type and adjust_symbols. adjust_symbols is used by
> > function "map__rip_2objdump" which converts symbol start
> > address to objdump address. Also set the dso long_name during
> > dso__load_vmlinux function.
> > 
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> > Note: Found similar discussion here in thread:
> >       https://www.spinics.net/lists/linux-perf-users/msg06337.html
> >       where Adrian proposed the fix, but looks like this was
> >       not added to the perf. Hence addeed Suggested-by from Adrian.
> > 
> >       Additional to the fix proposed by Adrian, the patch also
> >       adds setting of adjust_symbols which is needed for
> >       map__rip_2objdump to convert symbol start to objdump address.
> > 
> >  tools/perf/util/symbol-elf.c |  2 ++
> >  tools/perf/util/symbol.c     | 15 ++++++++++-----
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 252d26a59e64..9e7eeaf616b8 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1440,6 +1440,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
> >  		curr_dso->kernel = dso->kernel;
> >  		curr_dso->long_name = dso->long_name;
> >  		curr_dso->long_name_len = dso->long_name_len;
> > +		curr_dso->binary_type = dso->binary_type;
> > +		curr_dso->adjust_symbols = dso->adjust_symbols;
> >  		curr_map = map__new2(start, curr_dso);
> >  		dso__put(curr_dso);
> >  		if (curr_map == NULL)
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index f849f9ef68e6..3f36675b7c8f 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -2204,15 +2204,20 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
> >  	if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type))
> >  		return -1;
> >  
> > +	/*
> > +	 * dso__load_sym() may copy 'dso' which will result in the copies having
> > +	 * an incorrect long name unless we set it here first.
> > +	 */
> > +	dso__set_long_name(dso, vmlinux, vmlinux_allocated);
> > +	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
> > +		dso->binary_type = DSO_BINARY_TYPE__GUEST_VMLINUX;
> > +	else
> > +		dso->binary_type = DSO_BINARY_TYPE__VMLINUX;
> > +
> >  	err = dso__load_sym(dso, map, &ss, &ss, 0);
> >  	symsrc__destroy(&ss);
> >  
> >  	if (err > 0) {
> > -		if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
> > -			dso->binary_type = DSO_BINARY_TYPE__GUEST_VMLINUX;
> > -		else
> > -			dso->binary_type = DSO_BINARY_TYPE__VMLINUX;
> > -		dso__set_long_name(dso, vmlinux, vmlinux_allocated);
> >  		dso__set_loaded(dso);
> >  		pr_debug("Using %s for symbols\n", symfs_vmlinux);
> >  	}
> 

-- 

- Arnaldo
