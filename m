From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Question to struct map
Date: Tue, 12 Sep 2017 12:17:56 -0300
Message-ID: <20170912151756.GB3452@kernel.org>
References: <1d758097-b01b-cbad-913a-855a61f8ce73@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751534AbdILPR7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2017 11:17:59 -0400
Content-Disposition: inline
In-Reply-To: <1d758097-b01b-cbad-913a-855a61f8ce73@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Tue, Sep 12, 2017 at 05:04:53PM +0200, Thomas-Mich Richter escreveu:
> Hi all,
> 
> I have a question regarding struct map. 
> What is the purpose is the functions pointers in struct map named map_ip and unmap_ip?
> How do they relate the to dso the struct map is refering to?

A DSO has a symbol table (ELF or other kind, like the JIT ones
(documented in tools/perf/Documentation/jit-interface.txt) that may be
identity mapped or not, requiring or not use of relocation, etc.

The map, on the other hand, is where this DSO was loaded in memory,
which will be used to add to the symbol offset to do the address
resolution.

- Arnaldo

> This is not clear to me. Must have been on vacation for too long :-).
> 
> Thanks a lot.
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
