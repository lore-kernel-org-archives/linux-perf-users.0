Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pI9nPJX/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B69A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 06:39:48 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDlCU7026127;
	Wed, 22 Nov 2023 14:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rD5CIAvlIW3SeOYjd55cdiEkITsj/TY4vFmyAm6f2T8=;
 b=pI9nPJX/ASxXhcxnX9MgH45RRK3MgRpbD+Gl9kSYw9F3oL5tFgWl6MSVRe6ZfliqgDmy
 KULc79Sy0vs1r1U17hqjh9IcMPmV/p30lEJf7zoeqNZVzl7ybPG5dJEq5+MvF7ALjEBC
 HQ5KCYxx5q9aKd6K/8DyzC2HL0H7DYqxiB/fovvu7VUcadM20rJof18pms531VohHt32
 3g3v+gRHsAhrPHuVyKpREZgds1U4SO+0jootQqIHbhQGnJ7yG8GglkEIi3qBblKvDyNI
 Mx8gqYleefB0DUHjp0unHLw377QB3pW0cmtMIFkVdquKFKHX7/+QyxWrxSAgL8mDBQaz lQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhju5hj2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 14:39:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDMkKi032399;
	Wed, 22 Nov 2023 14:38:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kp0dd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 14:38:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMEcaW220447750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 14:38:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFF7A20040;
	Wed, 22 Nov 2023 14:38:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D23520043;
	Wed, 22 Nov 2023 14:38:36 +0000 (GMT)
Received: from [9.171.44.146] (unknown [9.171.44.146])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 14:38:36 +0000 (GMT)
Message-ID: <375537e9-1382-4e27-88df-3c636e72f69d@linux.ibm.com>
Date: Wed, 22 Nov 2023 15:38:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION linux-next since Nov 16th, perf tool broken (at least
 on s390)
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <aca1eb79-5dee-4634-8727-eebb251c9e1e@linux.ibm.com>
 <20231122100756.GP8262@noisy.programming.kicks-ass.net>
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20231122100756.GP8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GuKYtrOSynTTJX1QXqBP6ZFvC4G8N-m8
X-Proofpoint-GUID: GuKYtrOSynTTJX1QXqBP6ZFvC4G8N-m8
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
 definitions=2023-11-22_10,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220104

On 11/22/23 11:07, Peter Zijlstra wrote:
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
> 
> Does this help? I'm not entirely sure on the is_visible thing, but the
> way I understand it, it was only supposed to hide the nr_filters thing,
> not the entire group and @n helps select the attribute.
> 
> Greg, did I get that right?

Yes, the is_visible call back function hides whole group, not just this
one attribute.

static struct attribute *pmu_dev_attrs[] = {    <--- This group controlled by is_visibly                              
        &dev_attr_type.attr,                                                  
        &dev_attr_perf_event_mux_interval_ms.attr,                            
        &dev_attr_nr_addr_filters.attr,                                       
        NULL,                                                                 
};    
static struct attribute_group pmu_dev_attr_group = {                          
        .is_visible = pmu_dev_is_visible,                                     
        .attrs = pmu_dev_attrs,                                               
};

So is_visible call back hides whole pmu_dev_attrs group with all 3 files.

> 
> Also, spurious return... clearly I should've woken up before merging
> that patch... oh well.
> 
> 

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

