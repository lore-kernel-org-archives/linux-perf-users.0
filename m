Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFCBC2D0E4
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF75F246AD
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Nov 2020 08:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xit+1EWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKSIRO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 03:17:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgKSIRO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Nov 2020 03:17:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ82ZCi066525;
        Thu, 19 Nov 2020 03:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ELNuPOk/VVa4q1zMJbIOgi4hqEOvS4J+iKmH7hl1TrM=;
 b=Xit+1EWbjmjdKOmAcoraec4S0weXBe6lqp89PyIjoCnXCRfe+qJNH7WIRhoGjztXQnnP
 PAldWTuaqvWIPKwAqfZCEHjbZhI1aQr7A1YE4kql3PgpoNxqvX/+kr+I6a64NxQksMZv
 ClBnwp84Gf0JNoKECYSj2feZ/chjAEfzUkkibXq6cQK62tZ27UZ75Ok4jTcXQFWDLNUa
 rnaRCAIsf9uz6PwlkFJ9X7Efag6N/cbdgJr0Hezjxxla3VqZeSNH3XSU3jknHX76HRqY
 EVGDQxsJmjL085hNjDDPw2srnHQisTeZ6J/KZX2YLuN2ff90drAt4xh5QUU6c9Ua1B1d 8w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34w8p93eyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 03:17:10 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ8D99h003782;
        Thu, 19 Nov 2020 08:17:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 34t6v8cpud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:17:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJ8H5kE35848466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 08:17:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C461E11C054;
        Thu, 19 Nov 2020 08:17:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F00BA11C04C;
        Thu, 19 Nov 2020 08:17:00 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.206.168.23])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Nov 2020 08:17:00 +0000 (GMT)
Subject: Re: Fedora 33 and perf probe failures
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <63cdd43f-c970-6c7e-b322-a41f6d418cf7@linux.ibm.com>
 <20201119100711.2309580850fec6a58142f7f1@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <42f12f48-d515-8d7b-0116-d063afea9273@linux.ibm.com>
Date:   Thu, 19 Nov 2020 09:16:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201119100711.2309580850fec6a58142f7f1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_05:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190054
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/19/20 2:07 AM, Masami Hiramatsu wrote:
> Hi Thomas,
> 
> On Wed, 18 Nov 2020 17:37:21 +0100
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
>> I debugged the failure of some perf test cases on Fedora 33. The following
>> test cases fail on s390 and x86_64 using
> 
> Thanks for the report!
> Let me setup Fedora33.
> 
>>
>> [root@f33 yum.repos.d]# uname -a
>> Linux f33 5.9.8-200.fc33.x86_64 #1 SMP Tue Nov 10 21:58:19 UTC 2020
>>                                 x86_64 x86_64 x86_64 GNU/Linux
>> [root@f33 yum.repos.d]#
>>
>> [root@f33 yum.repos.d]# perf test -F 74 77 78
>> 74: Use vfs_getname probe to get syscall args filenames
>>                 :Failed to write event: Invalid argument
>> Error: Failed to add events.
>> FAILED!
>> 77: Check open filename arg using perf trace + vfs_getname
>>                 :Failed to write event: Invalid argument
>> Error: Failed to add events.
>> FAILED!
>> 78: Add vfs_getname probe to get syscall args filenames
>>                 :Failed to write event: Invalid argument
>> Error: Failed to add events.
>> FAILED!
>> [root@f33 yum.repos.d]#
> 
> BTW, do we have vfs_getname in the kernel?
> 

No, that is the name of the probe when calling perf probe command,
as in .../perf/tests/shell/lib/probe_vfs_getname.sh:

perf probe -q "vfs_getname=getname_flags:...."
The probe is set on kernel function getname_flags()
in fs/namei.c source file and named vfs_getname inside
perf/tracing subsystem.

>>
>> The root cause is the output of perf probe -L which returns:
>> [root@f33 yum.repos.d]# perf probe -L getname_flags
>> Specified source line is not found.
>> Error: Failed to show lines.
> 
> Hmm, could you run it with -vvv option?

[root@f33 ~]# uname -a
Linux f33 5.9.8-200.fc33.x86_64 #1 SMP Tue Nov 10 21:58:19 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@f33 ~]# cat /etc/fedora-release 
Fedora release 33 (Thirty Three)
[root@f33 ~]# perf kallsyms getname_flags
getname_flags: [kernel] [kernel.kallsyms] 0xffffffffa8325000-0xffffffffa8325060 (0xffffffffa8325000-0xffffffffa8325060)
[root@f33 ~]# find / -name vmlinux
/home/richter/linux/arch/x86/boot/compressed/vmlinux
/home/richter/linux/vmlinux
/usr/lib/debug/usr/lib/modules/5.9.8-200.fc33.x86_64/vmlinux
/sys/kernel/btf/vmlinux
[root@f33 ~]# nm -g /usr/lib/debug/usr/lib/modules/5.9.8-200.fc33.x86_64/vmlinux| fgrep getname_flags
ffffffff81325000 T getname_flags
[root@f33 ~]# 

[root@f33 ~]# perf probe -vvv -L getname_flags
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/5.9.8-200.fc33.x86_64/build/vmlinux for symbols
Open Debuginfo file: /lib/modules/5.9.8-200.fc33.x86_64/build/vmlinux
fname: ./include/linux/fs.h, lineno:2527
New line range: 2527 to 2147483647
path: (null)
Specified source line is not found.
  Error: Failed to show lines. Reason: No such file or directory (Code: -2)
[root@f33 ~]# 

> 
>> [root@f33 yum.repos.d]#
>>
>> whereas on my Fedora 32 installation this command shows
>> [root@t35lp46 perf]# cat /etc/redhat-release
>> Fedora release 32 (Thirty Two)
>> [root@t35lp46 perf]#
>>
>> [root@t35lp46 perf]# ./perf probe -L getname_flags | tail -10
>>      68                         return ERR_PTR(-ENOENT);
>>                         }
>>                 }
>>
>>      72         result->uptr = filename;
>>      73         result->aname = NULL;
>>      74         audit_getname(result);
>>                 return result;
>> }
>>
>> [root@t35lp46 perf]#
>>
>> Any ideas how to fix this? Is this failure related to a missing debuginfod
>> setup, even when I have installed the debuginfo packages for the kernel:
> 
> If you can find the vmlinux in debuginfo package, could you try
> eu-addr2line to find getname_flags?
>  
> eu-addr2line -e /somewhere/to/vmlinux getname_flags+0

[root@f33 ~]# eu-addr2line -e /usr/lib/debug/usr/lib/modules/5.9.8-200.fc33.x86_64/vmlinux  getname_flags+0
fs/namei.c:129:1
[root@f33 ~]# 

> 
> Thank you,
> 

You are welcome, thanks for looking into this.

I have added my Fedora32 output for completeness:

[root@t35lp46 perf]# ./perf probe -vvv -L getname_flags
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/5.10.0-rc4d-perf+/build/vmlinux for symbols
Open Debuginfo file: /lib/modules/5.10.0-rc4d-perf+/build/vmlinux
fname: fs/namei.c, lineno:128
New line range: 128 to 2147483647
Get 20989 lines from this CU
path: fs/namei.c
Search fs/namei.c from debuginfod -> -38
Failed to find fs/namei.c in debuginfod (8a690c7c154db1283cebb8953128584dd4f94b3d)
<getname_flags@/root/linux/fs/namei.c:0>
      0  getname_flags(const char __user *filename, int flags, int *empty)
         {
      2         struct filename *result;
                char *kname;
                int len;
......

root@t35lp46 perf]# eu-addr2line -e ~/linux/vmlinux  getname_flags+0
fs/namei.c:129:1
[root@t35lp46 perf]# 


-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
