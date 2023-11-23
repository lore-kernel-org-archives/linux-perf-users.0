Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C0uFilQF"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E17CE7
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 23:54:39 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN7Hlpl007258;
	Thu, 23 Nov 2023 07:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aWI5XKReaMXbY+mzt4nuiVmzg9/Ktdch9NSLBOovobE=;
 b=C0uFilQFPzQQ+8//L/8zJgKiWWh/NMvglNzp2aJB55FGyLVKpYnB7W1KMZeQkgUcz57C
 adIPCtS9Nns1/8kRDDBge7Jy3OVjQooeo5tuYZZDNHfcv40XPFePvxNgkurGgeHMlekg
 qbhV14UNL3DBynbYC2vUighijItbrKZjQiSafudMhVYerM1AqYZJE7KZw17SsgmM5aEY
 qh+aFIf22uWGxB9uE10Qh3fvrxo9gBpxqZf9jvK0B+8szpg92jByDcKsFgwqwGFX6Qp+
 LWofnBagJsaALb4zHbvWbjbnkF3s5cShl+HJYwE18nzpd13QJf1cD/lwzknB+DkSuFK2 vQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj27jgwu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 07:54:23 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN7M8E2001041;
	Thu, 23 Nov 2023 07:54:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kp5ssu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 07:54:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AN7sJP217957556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 07:54:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D27C20043;
	Thu, 23 Nov 2023 07:54:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EFE620040;
	Thu, 23 Nov 2023 07:54:19 +0000 (GMT)
Received: from [9.152.212.233] (unknown [9.152.212.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Nov 2023 07:54:19 +0000 (GMT)
Message-ID: <2be9c97e-3208-4deb-8172-004601aabc7e@linux.ibm.com>
Date: Thu, 23 Nov 2023 08:54:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION linux-next since Nov 16th, perf tool broken (at least
 on s390)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>
 <2023112248-unskilled-flagman-05e6@gregkh>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <2023112248-unskilled-flagman-05e6@gregkh>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yWt3tiX46qUiGvgG1C8UrXtJ_mvOgPOw
X-Proofpoint-ORIG-GUID: yWt3tiX46qUiGvgG1C8UrXtJ_mvOgPOw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_05,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230055

On 11/22/23 10:31, Greg KH wrote:
> On Wed, Nov 22, 2023 at 08:38:28AM +0100, Thomas Richter wrote:
>> perf tool fails on linux-next since Nov 16th on s390 when invoking perf on
>> any PMU event, as in
>>
>>   # perf stat -e cycles -- true
>>
>>    Performance counter stats for 'true':
>>
>>      <not supported>      cycles                                                               
>>
>>        0.000598399 seconds time elapsed
>>
>>        0.000055000 seconds user
>>        0.000567000 seconds sys
>>
>>   # perf stat -e pai_ext/NNPA_ALL/ -C0 -- true
>>   event syntax error: 'pai_ext/NNPA_ALL/'
>>                        \___ Bad event or PMU
>>
>>   Unable to find PMU or event on a PMU of 'pai_ext'
>>
>>   Initial error:
>>   event syntax error: 'pai_ext/NNPA_ALL/'
>>                        \___ Cannot find PMU `pai_ext'. Missing kernel support?
>>   #
>>
>> This error is caused by following commit, which got into linux-next around November 15th:
>>
>> commit 652ffc2104ec1f69dd4a46313888c33527145ccf
>> Author: Greg KH <gregkh@linuxfoundation.org>
>> Date:   Mon Jun 12 15:09:09 2023 +0200
>>
>>     perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file
>>
>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>     Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh
>>
>> This commit adds function pmu_dev_is_visible() as the PMU bus function
>> to make sysfs attribute files visible.
>> On a failing system these sysfs attribute files are exported:
>>
>> #  ll /sys/devices/pai_ext/
>> drwxr-xr-x. 2 root root    0 Nov 21 14:59 events
>> drwxr-xr-x. 2 root root    0 Nov 21 14:59 format
>> lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_source
>> -rw-r--r--. 1 root root 4096 Nov 21 14:43 uevent
>> #
> 
> /sys/devices/pai_ext/ is a real device?  Why there?  That's a very odd
> location, what type of device is this?

S390 has 5 different PMU devices, all show up at /sys/devices/ directory:
drwxr-xr-x   4 root root 0 Nov 22 14:30 cpum_cf
drwxr-xr-x   4 root root 0 Nov 22 14:30 cpum_cf_diag
drwxr-xr-x   4 root root 0 Nov 22 14:30 cpum_sf
drwxr-xr-x   4 root root 0 Nov 22 14:30 pai_crypto
drwxr-xr-x   4 root root 0 Nov 22 14:30 pai_ext

The cpum_xxx driver hardware for counting and sampling, with its
own memory mapping, device control registers and assembly instructions.
cpumf stands for CPU Measurement Facility.

The directory entry are created when the device is registered
via perf_pmu_register(). This call creates all complete directory
entry for this device. Nothing else done to it.

The pai_xxx are pseudo devices, again with its own memory mapping
and control registers, are  sort of a successor to cpumf.
pai stands for processor assist instrumentation

I have inherited this code many years ago and never encountered
any issue with this approach. I have little knowledge about the
sys device tree and its setup for individual devices.

> 
>> These is no file named 'type'. Other files are also missing.
>> Therefore the perf tool can not access any PMU event defined by this PMU.
>>
>> On a system with proper export of all PMU sysfs attributes (same linux-next kernel):
>> #  ll /sys/devices/pai_crypto/
>> total 0
>> drwxr-xr-x. 2 root root    0 Nov 21 14:44 events
>> drwxr-xr-x. 2 root root    0 Nov 21 14:44 format
>> -r--r--r--. 1 root root 4096 Nov 21 14:44 nr_addr_filters
>> -rw-r--r--. 1 root root 4096 Nov 21 14:44 perf_event_mux_interval_ms
>> lrwxrwxrwx. 1 root root    0 Nov 21 14:43 subsystem -> ../../bus/event_source
>> -r--r--r--. 1 root root 4096 Nov 21 14:44 type
>> -rw-r--r--. 1 root root 4096 Nov 21 14:44 uevent
> 
> Ick, again, a "root" device?  That's not right and needs to be fixed
> first.
> 
>> # cat /sys/devices/pai_crypto/type
>> 12
>> #
>>
>> Also on such a system the perf stat works again:
>> # perf stat -e pai_crypto/CRYPTO_ALL/ -C0 -- true
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>                  0      pai_crypto/CRYPTO_ALL/
>>
>>        0.000741258 seconds time elapsed
>>
>> #
>>
>> On s390 there is no need to export sysfs file 'nr_addr_filters', but setting
>> this member pmu::nr_addr_filters to a non-zero value before
>> calling perf_pmu_register() exhibits the old behavior again.
>>
>> In my opinion this breaks previous behavior.
>>
>> Is this intended?
>> How to fix this?
> 
> Looks like no attributes are exported unless nr_addr_filters is present
> in the device, right?  That's the way the patch was written, maybe the
> change is not correct?  I wrote it a while ago, sorry, I can't
> remember...
> 
> thanks,
> 
> greg k-h

I am fine when the indented change was to hide 'nr_addr_filters'
as a single sysfs file. But right now the complete device attribute group
is hidden and the perf tool seems to have trouble with this.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

