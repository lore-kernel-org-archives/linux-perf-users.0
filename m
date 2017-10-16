From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf buildid-cache -p <path> question
Date: Mon, 16 Oct 2017 15:45:49 +0200
Message-ID: <976d65b3-9cc0-920d-1c02-31d5d0a1a969@linux.vnet.ibm.com>
References: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752139AbdJPNpz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Oct 2017 09:45:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9GDdJjv135879
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2017 09:45:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dmufrqav6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2017 09:45:54 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Mon, 16 Oct 2017 14:45:53 +0100
In-Reply-To: <8594e11c-9aa1-f600-3f04-eb80058c9abf@linux.vnet.ibm.com>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 10/16/2017 02:24 PM, Thomas-Mich Richter wrote:
> Maybe its me misunderstanding the buildid cache completely, but I ran into the following issue:
> 
> I can add and remove files using the perf buildid-cache command. For example 
> perf buildid-cache -a /usr/bin/tar adds the tar executable to the buildid-cache directory
> .debug/usr/bin/tar 
> and creates the <buildid> subdirectory
> .debug/usr/bin/tar/e54c9946802bbbcb85760ffeb80700a5fd35ebe7/elf file.
> Also a symbolic link from the directory
> .debug/.buildid/e5/4c9946802bbbcb85760ffeb80700a5fd35ebe7 --> ../../usr/bin/tar/<buildid>/
> is created.
> 
> Command perf buildid-cache -a /usr/bin/tar
> removes these entries.
> 
> Now when I run ./perf buildid-cache -p /usr/bin
> nothing happens and success is reported:
> [root@s35lp76 perf]# ./perf buildid-cache -vp /usr/bin/
> Removing bash /usr/bin/: Ok
> Removing dbus-daemon /usr/bin/: Ok
> Removing ls /usr/bin/: Ok
> Removing readlink /usr/bin/: Ok
> Removing sleep /usr/bin/: Ok
> Removing tar /usr/bin/: Ok
> Removing time /usr/bin/: Ok
> Removing vim /usr/bin/: Ok
> Purging /usr/bin/: Ok
> 

Sorry, but this trace output when option -v is specified is incorrect.
I had too much debug code included when this append was written.


However the problem still exists and I have a prepared a patch which
I post soon.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
