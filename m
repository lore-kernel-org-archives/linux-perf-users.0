Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qYDhJHoI"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB2F19D
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 03:38:44 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANA6Yrb015147;
	Thu, 23 Nov 2023 11:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1qbzHg+20nA6Mp5kPOPrZCNQmNSmK3FxFunTTWG9F58=;
 b=qYDhJHoIMniWpOKbXHuWlH0DIbhNISYVPka6M5m3mBzrEHDJAKOT/JKkk2HzDb3vBFRn
 9TiiaJkkFRyNLH7Or8rZSoazJEPLzH8QdB4+nU7qR1G/AuWO44N9cp1TXQGjMEL3jQUO
 OPlE5S4Ovt/Ed6m3smrO5wh1fcPwMzlALK0/PQkPsXlRI6HSzWtAgvb9LqatrK/5aOu0
 bXF9wVstnCHH7bHtfuazFO+aBp58P/0kIviAxKbqdztfCenT4emYsYgNrTTL8lbFDOKB
 urplE0XlbVSg2xm1CGsNGyUevHiUeNRt/m+siCe3y108MQOmQVBZh0Gb5cNejJYw7M2C iw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj4psa7wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 11:38:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANBIirE003503;
	Thu, 23 Nov 2023 11:38:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ktf34g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 11:38:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ANBcW4G38208068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 11:38:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F43C20040;
	Thu, 23 Nov 2023 11:38:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D43262004D;
	Thu, 23 Nov 2023 11:38:31 +0000 (GMT)
Received: from [9.152.212.233] (unknown [9.152.212.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Nov 2023 11:38:31 +0000 (GMT)
Message-ID: <74ee8a88-1b3a-4aa5-84d0-d1c77e400e1b@linux.ibm.com>
Date: Thu, 23 Nov 2023 12:38:31 +0100
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
X-Proofpoint-ORIG-GUID: _e9KSDjhPKYCOgUJmHYHA4dub45AOJ5H
X-Proofpoint-GUID: _e9KSDjhPKYCOgUJmHYHA4dub45AOJ5H
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
 definitions=2023-11-23_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230083

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
> 
> Also, spurious return... clearly I should've woken up before merging
> that patch... oh well.
> 
> ---
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4f0c45ab8d7d..59b332cce9e7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11417,12 +11417,10 @@ static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct pmu *pmu = dev_get_drvdata(dev);
>  
> -	if (!pmu->nr_addr_filters)
> +	if (n == 2 && !pmu->nr_addr_filters)
>  		return 0;
>  
>  	return a->mode;
> -
> -	return 0;
>  }
>  
>  static struct attribute_group pmu_dev_attr_group = {

Yep, this fixes the issue. As you can see, the type file etc is exported again:


# ll /sys/devices/pai_crypto/
total 0
drwxr-xr-x. 2 root root    0 Nov 23 12:19 events
drwxr-xr-x. 2 root root    0 Nov 23 12:19 format
-rw-r--r--. 1 root root 4096 Nov 23 12:19 perf_event_mux_interval_ms
lrwxrwxrwx. 1 root root    0 Nov 23 12:18 subsystem -> ../../bus/event_source
-r--r--r--. 1 root root 4096 Nov 23 12:19 type
-rw-r--r--. 1 root root 4096 Nov 23 12:19 uevent
# perf stat -a -e pai_crypto/KM_DEA/ -- true

 Performance counter stats for 'system wide':

                 0      pai_crypto/KM_DEA/                                                    

       0.000983239 seconds time elapsed
#

This looks very and and you have my 
Tested-by: Thomas Richter <tmricht@linux.ibm.com

--
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

