Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95D340293
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753135; cv=none; b=Hv/TuSr4EyMnv1YGS681Q6OxeYBMjfMl+rgB8d5wp/anTe7PYapqx5i7Ey68puzhkmQ22q4wkIxA6O/C2rf5OaVww7br4AbIcKgIX9kOi2j1oV0ALr119pI1GhzRQghoP9vc1m0bqIyuRuxHm5KZyaXpTRxYFKW2yKBFGX0MYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753135; c=relaxed/simple;
	bh=nJrsHH3dD/1bAcb26Pg8nOYAoGBo6gAnKL2jwyfNAMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq39XUwFcT6Q4VWjiA+D3OpHJDBMpX+uh/cwToGcbbWvng/fWK7SUHwflH6C7sJoFSJw2bJQNORs/zEG3t5GjfINTsf8gVB8TjGURpTBQJJmNR79cCwzSlposcbmP/KCSAW8xhYJ4kJ8hE9SkbDa9voR/gpXtepFnfj33S6oXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pGfsZcLf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pGfsZcLf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBHdA7019658
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B5kV8B
	QdcdYOsQUBvoNplGAv3y8aAHmer4Geln9l0AA=; b=pGfsZcLfHnODcSuYjKhdBu
	hD0X7FtW0tQ9KBdiJ5lbPzqJKjp6pYYn6OYsmwhrRVnOGeWX7SJz64mYo1dudT+v
	8WzqkQJqRires+gDqjTiDgVMzb9hnyN874gV+P7F9xZO0ZEyuUck9H79tJa4xaFr
	9oTglLIGWsTr8V1MFcxrGp/bfXO6ZGH+/e72sR0JDmAFboMdPyM0yutGNl2Wyz31
	DnH2SPvrl5c7IdmZHgLWr5dAoCI5jh7kRpyM1+mnH09KCFYuyR9+SRYXT03Z7Rgh
	PBlTPuZnmCSWOl1Yzn6lpqHnny7d2a4TAnCeex8JKnagfiKJh601YzXBYaoSNj3Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agm356-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:52:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59TFjP9g021994
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:52:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agm355-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 15:52:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TDX65I023839;
	Wed, 29 Oct 2025 15:52:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx45tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 15:52:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TFq7ca29557088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 15:52:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2125420043;
	Wed, 29 Oct 2025 15:52:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3F5720040;
	Wed, 29 Oct 2025 15:52:06 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 15:52:06 +0000 (GMT)
Message-ID: <219af201-12d4-4700-8d84-575969f83f0e@linux.ibm.com>
Date: Wed, 29 Oct 2025 16:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next] perf report runtime extremely long
To: Ian Rogers <irogers@google.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Jan Polensky <japo@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com>
 <CAP-5=fU7zGF90yPyPhNUKqZp6zvynjZ_fQd_+x4hB6+KFumrhg@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fU7zGF90yPyPhNUKqZp6zvynjZ_fQd_+x4hB6+KFumrhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=6902382c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=4R-LyMsM1prMZTzBb9oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WSnCkugOzwzz2zzxlWVForuHZyFKO3u4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX6HDy32G4oAi0
 zCFmLBaAJI7t+e7ZFS+8ACvAk7iVW033EqQrPdq2RB2X9Zp/KWD6WWbVjDu9WEUSaBE3NaGjvEX
 dmgvOKtk3mKu7xN0MksRHxZYPam2E1vxHqMy3pVfRRt8YAmQA+JiHbxl3jbTPlHy6qu/CD5chAC
 bJ8Naj5UJIL1HDrI8Otgu8TK1uGji2wdzxSioZKQs84nbQ46jReqrgHUk2Vj+j8o0pYuk+70oVU
 CIOIrl6iLBey9yo3tPpDye0zL5ZnQEMvSqxuRALz6SaBBDmsOyVq5u/HfsSza645dehNXlQTwvN
 TtJr0dRSqCWNKGRORtKzJULDJ0uF6rzvuk7QZXwaFv+3T2WPdg3ZnPYPPf0gOYkteLrtO/xfYtR
 Bsdz7Lj1uRGp7iTxh3uCByRIgmEwfA==
X-Proofpoint-GUID: BbAz-d0UyP-bZq3cYAnbPCzIs3gOsCkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On 10/29/25 16:13, Ian Rogers wrote:
> On Wed, Oct 29, 2025 at 1:04 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> Hi all,
>>
>> has something changed recently in perf report in linux-next repo?
>>
>> I run perf report -i <file> -D | grep something
>> on s390 with 2 different kernels:
>>
>> master 6.18.0rc3:
>> # uname -a
>> Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 CET 2025 s390x GNU/Linux
>> # ll /tmp/perf2-eSso2q-2
>> -rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
>> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
>>
>> real    0m22.262s
>> user    0m22.068s
>> sys     0m0.200s
>> #
>>
>> This runtime is ok for the perf.data file size.
>>
>> linux-next:
>> # uname -a
>> Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc42.s390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
>> #ll /tmp/perf2-eSso2q-2
>> -rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
>> # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/null
>>
>> real    2m53.601s
>> user    2m52.938s
>> sys     0m0.575s
>> #
>>
>> Same perf.data file and run time increased from 22 seconds to nearly 300 seconds, roughly 14 times longer
>> for the same input!
>>
>> Has anybody similar observations?
> 
> So there were changes relating to addr2line that could impact this:
> https://lore.kernel.org/lkml/20251005212212.2892175-1-irogers@google.com/
> 
> There was also the switch to always using build IDs:
> https://lore.kernel.org/lkml/20250724163302.596743-1-irogers@google.com/
> 
> Any chance you could do a `perf record`/`perf report` to see where the
> time is going?
> 
> Thanks!
> Ian

Ok here is a first try, can do more tests tomorrow morning.
The file perf1.data has this size:

root in 🌐 s83lp47 in ~ 
❯ ll perf1.data 
-rw-------. 1 root root 99692290 Oct 29 16:17 perf1.data

root in 🌐 s83lp47 in ~ 
❯ 

time perf record -- perf report -i perf1.data -D > /dev/null
^C[ perf record: Woken up 6 times to write data ]
[ perf record: Captured and wrote 2.742 MB perf.data (70481 samples) ]
Terminated

real	13m9.894s
user	13m6.583s
sys	0m2.449s

root in 🌐 s83lp47 in ~ took 13m9s 
❯ perf report --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 70K of event 'cpum_cf/cycles/P'
# Event count (approx.): 88101250000
#
# Overhead  Command  Shared Object      Symbol                                                                            
# ........  .......  .................  ..................................................................................
#
    26.67%  perf     libc.so.6          [.] __printf_buffer
    12.43%  perf     libc.so.6          [.] __GI___strnlen
    12.30%  perf     libc.so.6          [.] __strstr_vx
    11.92%  perf     perf               [.] perf_pmu__for_each_event
     7.46%  perf     libc.so.6          [.] __printf_buffer_write
     5.48%  perf     libc.so.6          [.] memcpy
     5.13%  perf     libc.so.6          [.] __GI___strchrnul
     3.25%  perf     libc.so.6          [.] __vfscanf_internal
     2.61%  perf     libc.so.6          [.] strchr
     2.39%  perf     libc.so.6          [.] __vsnprintf_internal
     2.19%  perf     libc.so.6          [.] __printf_buffer_done
     2.03%  perf     perf               [.] perf_pmu__is_tool
     1.14%  perf     libc.so.6          [.] __snprintf_chk@@GLIBC_2.4
     1.05%  perf     perf               [.] get_counter_name_callback
     0.73%  perf     libc.so.6          [.] __GI_____strtoull_l_internal
     0.60%  perf     libc.so.6          [.] memcmp
     0.28%  perf     libc.so.6          [.] _IO_str_init_static_internal
     0.19%  perf     libc.so.6          [.] strlen

Hope this helps

Kind regards
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
