Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088691741FA;
	Wed, 11 Sep 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046109; cv=none; b=iuSu11KNmFR5QD6pCcGIU2MzVdrngGwrYyNCNeHIBUsbzSGCtMzXRYVMm+Qjz/YrYXt7Sxm156UvWlTFD4I0IJzqG+8bPmiP+2pzVtUeZO7iPW0OO8lHJeK16yzPmZXmoaAFdZ0d9pzW7RVS3taAOdw7qoVBwfaL8raVPjgwQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046109; c=relaxed/simple;
	bh=EzOgyENAkSRDLS0/Rm6Wrv/w/unR8WK6P/9IJOPE5jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2LJS88Mp0VuQyVbtqaTlRFUCsITwyHEQJ69bSrf856G5+Knw1dpJjjc1oBC62eM1NRCJcjma31ANrjHjEN17HxJw2EyxjKn3v0SWiipTq9KIwUpnUBYqbXFe+hY+E2WxIHEqULxgbabThYuFIc70Lfo+FK3aVtheKC2UJhnhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SHdDFhO5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SHdDFhO5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B2uVu5001140;
	Wed, 11 Sep 2024 09:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
	AYToqwqpaAF12l4NLq3V5bnkBKyKRlPqzOnNsbo3vU=; b=SHdDFhO5iOY449uLO
	SoLejLPIsi8XHtddR49wTz7I+G2hoaDEEHnte851xTKajn6wjTQU5EtkTuPuY1BT
	vZ/IsWyTJ0xzCUCXsx+bq4Pb2Iq8EParLDs7tsmsjDui0AZYm9ys47FpdcYmeRH3
	sg7QvBUowLZO9M0NyhAKzAw59i8+cNQ5HFN4bFFACY2CjLe16c3z1Cbhp554zmN4
	RMBJRmQMY0e4e0wn8R/1XuxIkTKq4PrG27VX/O1JeCo/Oii1q1GP9Cbd/ektz5Ng
	EDODh2thO+sKarGLkw8FkkkubqhxnmF87VaW6SOrLgU6/fbZo/HLahqV4F8qQY+8
	ERPzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qcu0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:15:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48B9Exlg011193;
	Wed, 11 Sep 2024 09:14:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qcu0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:14:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B6dC9R032418;
	Wed, 11 Sep 2024 09:14:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0rjcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:14:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B9EtRl49545680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 09:14:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06C5120043;
	Wed, 11 Sep 2024 09:14:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD29820040;
	Wed, 11 Sep 2024 09:14:54 +0000 (GMT)
Received: from [9.152.212.137] (unknown [9.152.212.137])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 09:14:54 +0000 (GMT)
Message-ID: <1d7f3b7b-9edc-4d90-955c-9345428563f1@linux.ibm.com>
Date: Wed, 11 Sep 2024 11:14:54 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux next breaks s390 test cases perf test vfs_getname
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <3f5eeb1b-6679-4ff5-8046-0cbe1b6e4ba8@linux.ibm.com>
 <ZuCrCRfUi6QiRV_3@x1>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <ZuCrCRfUi6QiRV_3@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 19WviOqQnj0tpOAmAJ2eKy4IBH_lXDI8
X-Proofpoint-ORIG-GUID: Tsv9tpkwrl800sBx7zw_XxXpUnnhSzUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110068

On 9/10/24 22:24, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 10, 2024 at 02:05:42PM +0200, Thomas Richter wrote:
>> Arnaldo,
>>
>> On linux-next
>> commit a68080e1a21b ("perf test vfs_getname: Look for alternative line where to collect the pathname")
>> breaks the following tests on s390:
>>
>>  # perf test vfs_getname
>>  85: Add vfs_getname probe to get syscall args filenames             : FAILED!
>>  87: Use vfs_getname probe to get syscall args filenames             : FAILED!
>> 120: Check open filename arg using perf trace + vfs_getname          : FAILED!
>>
>> I used the linux next kernel from yesterdays build on s390 and the corresponding
>> perf tools also built from that kernel repository:
>>  # uname -a
>>  Linux a35lp62.lnxne.boe 6.11.0-20240909.rc7.git205.100cc857359b.300.fc40.s390x+next #1 SMP Mon Sep  9 20:05:44 CEST 2024 s390x GNU/Linux
>>  # perf -v
>>  perf version 6.11.0-20240909.rc7.git205.100cc857359b.300.fc40.s390x+next
>>  #
>>
>> The root cause is a changed regular expression. Before the change the command
>> extracts this line and strips everything after the line number:
>>  # perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;'
>>  79     result->uptr = filename;
>>  # perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;' | \
>>          sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/'
>>  79
>>  # perf probe -q "vfs_getname=getname_flags:79 pathname=result->name:string"
>>  # echo $?
>>  0
>>  # perf probe -l
>>   probe:vfs_getname    (on getname_flags:79@fs/namei.c with pathname)
>>  # perf probe -d '*'
>>  Removed event: probe:vfs_getname
>>  #
>>
>> With your changes the result is slightly different. The first part still matches the
>> same line:
>>  #perf probe -L getname_flags| grep -E '[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*='
>>  79     result->uptr = filename;
>> but the sed command does not return the proper line number:
>>  # perf probe -L getname_flags| grep -E '[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*=' | \
>>         sed -r "s/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*=/\1/"
>>  79 filename;
>>  #
>> The filename; is not stripped and the perf probe command looks like
>>  # perf probe -q "vfs_getname=getname_flags:79 filename; pathname=result->name:string"
>>  # echo $?
>>  254
>>  # perf probe -l
>>  # perf probe  "vfs_getname=getname_flags:79 filename; pathname=result->name:string"
>>  Failed to find the location of the 'filename;' variable at this address.
>>  Perhaps it has been optimized out.
>>  Use -V with the --range option to show 'filename;' location range.
>>   Error: Failed to add events.
>>  # 
>>
>>
>> The issue is that trailing equal sign (=) in the regular expression:
>>  + result_filename_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*"
>>  + line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_filename_re=" | \
>>                  sed -r "s/$result_filename_re=/\1/")
>>                                               ^--------here-----
>> which prevents word filename; from being stripped away.
>> I wonder if this works on x86_64 platforms and if we need a archtecture specific
> 
> root@x1:~# perf test getname
>  91: Add vfs_getname probe to get syscall args filenames             : Ok
>  93: Use vfs_getname probe to get syscall args filenames             : FAILED!
> 126: Check open filename arg using perf trace + vfs_getname          : Ok
> root@x1:~#
> root@x1:~# uname -a
> Linux x1 6.10.8-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Sep  4 21:41:11 UTC 2024 x86_64 GNU/Linux
> root@x1:~#
> 
> I forgot to mention the kernel version wher I did that a68080e1a21b
> patch, but IIRC it was a recent, locally built kernel (not a distro
> kernel, but with the fedora, probably 39, config):
> 
> kernel="/boot/vmlinuz-6.11.0-rc5+"
> 
> But even with the distro kernel I'm getting the same results:
> 
> root@x1:~# perf test getname
>  91: Add vfs_getname probe to get syscall args filenames             : Ok
>  93: Use vfs_getname probe to get syscall args filenames             : FAILED!
> 126: Check open filename arg using perf trace + vfs_getname          : Ok
> root@x1:~# perf test getname
>  91: Add vfs_getname probe to get syscall args filenames             : Ok
>  93: Use vfs_getname probe to get syscall args filenames             : FAILED!
> 126: Check open filename arg using perf trace + vfs_getname          : Ok
> root@x1:~# perf test getname
>  91: Add vfs_getname probe to get syscall args filenames             : Ok
>  93: Use vfs_getname probe to get syscall args filenames             : FAILED!
> 126: Check open filename arg using perf trace + vfs_getname          : Ok
> root@x1:~# perf test getname
>  91: Add vfs_getname probe to get syscall args filenames             : Ok
>  93: Use vfs_getname probe to get syscall args filenames             : FAILED!
> 126: Check open filename arg using perf trace + vfs_getname          : Ok
> root@x1:~# perf test getname
>  91: Add vfs_getname probe to get syscall args filenames             : Ok
>  93: Use vfs_getname probe to get syscall args filenames             : FAILED!
> 126: Check open filename arg using perf trace + vfs_getname          : Ok
> root@x1:~# 
> 
> With my changes, i.e. what is in perf-tools-next now:
> 
> root@x1:~# perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;'
>          	result->uptr = filename;
> root@x1:~#
> 
> So no line number to be found:
> 
> root@x1:~# perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;'
> perf probe -L getname_flags 2>&1 | grep -E 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/'
>          	result->uptr = filename;
> root@x1:~#
> 
> Then, with the change in place:
> 
> The first part continues not to find the info:
> 
> root@x1:~# perf probe -L getname_flags| grep -E '[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*='
> root@x1:~#
> 
> Then it falls back to the new way of finding where to put the probe:
> 
> root@x1:~# perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re=" 
> root@x1:~# perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" 
>      73  	result->aname = NULL;
> root@x1:~#
> 
> Yeah, that = shouldn't be there
> 
> root@x1:~# perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/"
> 73
> root@x1:~# line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
> root@x1:~# echo $line
> 73
> root@x1:~#
> 
> Can you try with the patch below, that ending '=' is noise :-\
> 
> - Arnaldo
> 
> From 9ccaf9a0ebcff9b4c45c34d92ca97be9926da636 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Tue, 10 Sep 2024 17:18:26 -0300
> Subject: [PATCH 1/1] perf test shell probe_vfs_getname: Remove extraneous '='
>  from probe line number regex
> 
> Thomas reported the vfs_getname perf tests failing on s/390, it seems it
> was just to some extraneous '=' somehow getting into the regexp, remove
> it, now:
> 
>   root@x1:~# perf test getname
>    91: Add vfs_getname probe to get syscall args filenames             : Ok
>    93: Use vfs_getname probe to get syscall args filenames             : FAILED!
>   126: Check open filename arg using perf trace + vfs_getname          : Ok
>   root@x1:~#
> 

I applied your patch to linux-next kernel and it works:

# ./perf test vfs
 85: Add vfs_getname probe to get syscall args filenames             : Ok
 87: Use vfs_getname probe to get syscall args filenames             : Ok
120: Check open filename arg using perf trace + vfs_getname          : Ok
#

When I remove your patch the error shows up again:

# git reset --hard HEAD^
HEAD is now at 6708132e80a2 Add linux-next specific files for 20240910
# ./perf test vfs
 85: Add vfs_getname probe to get syscall args filenames             : FAILED!
 87: Use vfs_getname probe to get syscall args filenames             : FAILED!
120: Check open filename arg using perf trace + vfs_getname          : FAILED!
]# 

Your have my Tested-by:
Thanks a lot for your help.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

