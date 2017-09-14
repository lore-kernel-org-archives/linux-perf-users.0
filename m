From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Question to symbol address resolution in perf report -v
Date: Thu, 14 Sep 2017 12:44:57 +0200
Message-ID: <89610e15-5e64-0cf4-8e91-73ece7265447@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41663 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751892AbdINKpE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2017 06:45:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8EAiwnW041665
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2017 06:45:04 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cyr8dg6jg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2017 06:45:03 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 14 Sep 2017 11:45:00 +0100
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On s390x I do a 'perf record -a -g -- ls -l /'
to create perf.data file.
Using 'perf report' and enter V in the GUI shows symbol addresses
and names.
Symbol vfs_write is at address 0x585350 in this expansion.

/proc/kallsyms and vmlinux have different addresses for vfs_write:
[root@s8360047 acme2]# fgrep vfs_write /proc/kallsyms
00000000005800c0 T __vfs_write
0000000000583178 T vfs_write
0000000000583f60 T vfs_writev

[root@s8360047 acme2]# readelf -Wa vmlinux| fgrep vfs_write
...
155953: 0000000000583178   880 FUNC    GLOBAL DEFAULT    1 vfs_write
156542: 00000000005800c0   814 FUNC    GLOBAL DEFAULT    1 __vfs_write
160573: 0000000000583f60   402 FUNC    GLOBAL DEFAULT    1 vfs_writev

Both files show vfs_write in the range of 0x583178-0x5834e8, which is consistent
with
[root@s8360047 perf]# ./perf kallsyms vfs_write
vfs_write: [kernel] [kernel.kallsyms] 0x583178-0x5834e8 (0x583178-0x5834e8)

So in the GUI there is a mismatch between address and symbol name after the
'V' character is entered. (Use ommand ./perf report -v --stdio
to avoid using the GUI).

On Intel I have the same issue, using a virtual machine with F26 and 4.13.0rc5:

The GUI shows:
+   36.36%     0.00%  ls       [kernel.vmlinux]            [k] vfs_write
and when I enter 'V' it shows:
+   36.36%     0.00%  ls       /lib/modules/4.13.0-rc5tmr  0x7f5dbd21         v [k] vfs_wr

[root@localhost perf]# ./perf kallsyms vfs_write
vfs_write: [kernel] [kernel.kallsyms] 0xffffffff811dbc70-0xffffffff811dbe10
                                (0xffffffff811dbc70-0xffffffff811dbe10)
[root@localhost perf]# readelf -Wa ../../vmlinux | fgrep vfs_write
[...]
48987: ffffffff811dc420   267 FUNC    GLOBAL DEFAULT    1 vfs_writev
54535: ffffffff811dbc70   408 FUNC    GLOBAL DEFAULT    1 vfs_write
60615: ffffffff811da800   332 FUNC    GLOBAL DEFAULT    1 __vfs_write

When I do a './perf report -k /dev/null' there is no symbol mapping to addresses
and the output is:

+   36.36%     0.00%  ls       [kernel.vmlinux]  [k] 0xffffffff811dbd21

which falls in the range for symbol vfs_write. Address 811dbd21 is within
811dbc70-811dbe10. Why its an odd number I do not know.

So I believe the original address is correct and the symbol name matches
that of the address, but when you enter 'V' something goes wrong and an
incorrect address is displayed.
Again command ./perf report -v --stdio shows this issue without using the GUI.

Is this a bug or do I misinterpret the output.
Thanks a lot for your help.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
