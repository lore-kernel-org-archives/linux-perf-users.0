From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: Question to struct map
Date: Wed, 13 Sep 2017 16:48:03 +0200
Message-ID: <ff3ff19d-de45-61f9-cd16-5d7c39c67cf0@linux.vnet.ibm.com>
References: <1d758097-b01b-cbad-913a-855a61f8ce73@linux.vnet.ibm.com>
 <20170912151756.GB3452@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751734AbdIMOsL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2017 10:48:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8DEicWc048115
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2017 10:48:10 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cy38940tv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2017 10:48:10 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 13 Sep 2017 15:48:08 +0100
In-Reply-To: <20170912151756.GB3452@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 09/12/2017 05:17 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 12, 2017 at 05:04:53PM +0200, Thomas-Mich Richter escreveu:
>> Hi all,
>>
>> I have a question regarding struct map. 
>> What is the purpose is the functions pointers in struct map named map_ip and unmap_ip?
>> How do they relate the to dso the struct map is refering to?
> 
> A DSO has a symbol table (ELF or other kind, like the JIT ones
> (documented in tools/perf/Documentation/jit-interface.txt) that may be
> identity mapped or not, requiring or not use of relocation, etc.
> 
> The map, on the other hand, is where this DSO was loaded in memory,
> which will be used to add to the symbol offset to do the address
> resolution.
> 
> - Arnaldo
> 

I think I got it now.
The map__map_ip() function converts a symbol's virtual memory address to the
byte offset of that symbol in the ELF file.

The map__unmap_ip() function does the opposite.

Thanks for the explanation.
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
