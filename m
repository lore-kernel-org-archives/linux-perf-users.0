From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Tue, 25 Jul 2017 10:45:26 +0200
Message-ID: <db7b9f88-a299-7b35-5473-042760904fea@linux.vnet.ibm.com>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
 <20170724182007.GY4134@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44979 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750893AbdGYIpe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jul 2017 04:45:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6P8imoD062170
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jul 2017 04:45:34 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bx0qv5d7s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jul 2017 04:45:33 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 25 Jul 2017 09:45:31 +0100
In-Reply-To: <20170724182007.GY4134@kernel.org>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

On 07/24/2017 08:20 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 24, 2017 at 04:35:14PM +0200, Thomas Richter escreveu:


[...]

> 
> Nice analysis, I don't recall why we ended up not using that 2nd column
> of /proc/modules... :-\o

Nor do I :-)

> 
> Humm, probably the modules maps were created from the entries in
> /proc/kallsyms, where we don't have the size, then, just like we do
> w2hen parsing symbols from /proc/kallsyms, we set the end by looking at
> the next entry...
> 

The maps where created for the kernel by reading 
dso: [kernel.vmlinux] (/lib/modules/4.12.0perf1+/build/vmlinux, Functions, 
   loaded, b31f6c58ffca1ca9ecc4a3451b7bb1b1a9a6be0e)

and for the module by reading 
dso: [qeth_l2] (/lib/modules/4.12.0perf1+/kernel/drivers/s390/net/qeth_l2.ko, Functions, 
    loaded, ed1c8278b4b1cb67262e83cd535f155415197610)

In fact I printed out the possible paths to search for the kernel:
vmlinux_path__add 0 vmlinux
vmlinux_path__add 1 /boot/vmlinux
vmlinux_path__init kernel_version:4.12.0perf1+
vmlinux_path__add 2 /boot/vmlinux-4.12.0perf1+
vmlinux_path__add 3 /usr/lib/debug/boot/vmlinux-4.12.0perf1+
vmlinux_path__add 4 /lib/modules/4.12.0perf1+/build/vmlinux
vmlinux_path__add 5 /usr/lib/debug/lib/modules/4.12.0perf1+/vmlinux
vmlinux_path__add 6 /usr/lib/debug/boot/vmlinux-4.12.0perf1+.debug

So there is no kallsyms involved.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
