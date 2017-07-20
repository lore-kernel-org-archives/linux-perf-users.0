From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: perf record: wrong size in perf_record_mmap for last kernel module
Date: Thu, 20 Jul 2017 13:12:39 +0200
Message-ID: <ce93dfbf-48fc-7880-2737-148c39e0b78b@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49991 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934421AbdGTLMr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2017 07:12:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6KBB4hI004460
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2017 07:12:46 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2btp93dajj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2017 07:12:46 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 20 Jul 2017 12:12:43 +0100
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zvonko Kosic <zvonko.kosic@de.ibm.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

During work on perf report for s390 I ran into the following issue:

0 0x318 [0x78]: PERF_RECORD_MMAP -1/0: [0x3ff804d6990(0xfffffc007fb2966f) @ 0]:
	x /lib/modules/4.12.0perf1+/kernel/drivers/s390/net/qeth_l2.ko

This is a PERF_RECORD_MMAP entry of the perf.data file with an invalid
module size for qeth_l2.ko (the s390 ethernet device driver).
Even a mainframe does not have 0xfffffc007fb2966f bytes of main memory.

It turned out that this wrong size is created by the perf record command.
What happens is this function call sequence from __cmd_record():

perf_session__new():
perf_session__create_kernel_maps():
machine__create_kernel_maps():
machine__create_modules():   Creates map for all loaded kernel modules.
modules__parse():   Reads /proc/modules and extracts module name and
		    load address (1st and last column)
machine__create_module():   Called for every module found in /proc/modules.
                    Creates a new map for every module found and enters
	            module name and start address into the map. Since the
		    module end address is unknown it is set to zero.

This ends up with a kernel module map list sorted by module start addresses.
All module end addresses are zero.

Last machine__create_kernel_maps() calls function map_groups__fixup_end().
This function iterates through the maps and assigns each map entry's 
end address the successor map entry start address. The last entry of the
map group has no successor, so ~0 is used as end to consume the remaining
memory.

Later __cmd_record calls function record__synthesize() which in turn calls
perf_event__synthesize_kernel_mmap() and perf_event__synthesize_modules()
to create PERF_REPORT_MMAP entries into the perf.data file.

On s390 this results in the last module qeth_l2.ko
(which has highest start address, see module table:
	[root@s8360047 perf]# cat /proc/modules 
	qeth_l2 86016 1 - Live 0x000003ff804d6000
	qeth 266240 1 qeth_l2, Live 0x000003ff80296000
	ccwgroup 24576 1 qeth, Live 0x000003ff80218000
	vmur 36864 0 - Live 0x000003ff80182000
	qdio 143360 2 qeth_l2,qeth, Live 0x000003ff80002000
	[root@s8360047 perf]# )
to be the last entry and its map has an end address of ~0.

When the PERF_RECORD_MMAP entry is created for kernel module qeth_l2.ko
its start address and length is written. The length is calculated in line:
    event->mmap.len   = pos->end - pos->start;
and results in 0xffffffffffffffff - 0x3ff804d6990(*) = 0xfffffc007fb2966f

(*) On s390 the module start address is actually determined by a __weak function
named arch__fix_module_text_start() in machine__create_module().

I think this improvable. We can use the module size (2nd column of /proc/modules)
to get each loaded kernel module size and calculate its end address.
Only for map entries which do not have a valid end address (end is still zero)
we can use the heuristic we have now, that is use successor start address or ~0.
If you want I can work on this patch.

Any other ideas?
Did this issue never showed up before?

Thanks
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
