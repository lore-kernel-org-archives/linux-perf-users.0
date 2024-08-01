Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A2158207;
	Thu,  1 Aug 2024 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497647; cv=none; b=phgdfEaV09c6b2Pjy98OoD/I3SCJ9qbV890kY3BEkdYs4WOiCv3zn41TCCBv3xyNrz3ojPMk5Ex/ZXLQ15WikC1PTGRqBkF8DNvAypIGd/7LI8+bMa704ygNJ9u0hxN4Mws3We1fuK+EhI9tsgdLqqJmh/9LWjFsxg1pjAW8pGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497647; c=relaxed/simple;
	bh=jWQgIqK7qduK/GL9yTdv/it6HsJmZnpuh8xgZKwSAM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xf+m79Dxsuae3YpS3KtNULWAnG8T/xXn0AsY6XW5hoUza6CcvDNJr6I2ZjW4GyY2bNSznTlSgfWOM+CkrgmqkNxMb+9yuhCB/Qvti+XRlqoyWf6ijdKZvPFQvTuIxiQwekJGJw2IcJuS331zyPp6Ujn0dZMuSddlZ5wa6tm18mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bXs3z4lI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bXs3z4lI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47150698032670;
	Thu, 1 Aug 2024 07:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=S
	Oc099JyKiPKu3si/kk0QU27Tm5aC7/sxQUxbrtkQFg=; b=bXs3z4lItYjICGjPP
	3bbxtoIQkgEzzs2QL/ydJ2Xr9EbUW0+8/Rw153k4dsvIhE4MnLS8d+XG67XlPuCq
	06Ost/WwintOetp/fcQCLzo4lblwAarVgIWYob+zCAR/1nMG9vaidt/HLzIbkMjY
	5z9PL7Ab3NjZLa9PXzcbPqZFK9vMv5Wteyfo7NyOU2nAQbbQQGGV304fSQe1kyKl
	tfBcl7dqp0hQpyo2DmGxubZJP7o7L6lMRyOHz+Y1CdbX5yvK3CNkd2qOXFNsqgux
	LgyqOi50klXLYsV5ZZ41p/x+Kly7j0px93A/5eB1pKLGxrml+bXjJ3wVu9MMVvPH
	MlLzA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r3tp8b88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:33:57 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4717XuQr005932;
	Thu, 1 Aug 2024 07:33:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r3tp8b86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:33:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4715TDG6009176;
	Thu, 1 Aug 2024 07:33:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx385nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 07:33:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4717Xo8q57147732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 07:33:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 291522004D;
	Thu,  1 Aug 2024 07:33:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9757C20043;
	Thu,  1 Aug 2024 07:33:46 +0000 (GMT)
Received: from [9.171.14.149] (unknown [9.171.14.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 07:33:46 +0000 (GMT)
Message-ID: <ac3ce4aa-146b-4be9-9edc-1533d0b7dc98@linux.ibm.com>
Date: Thu, 1 Aug 2024 13:03:44 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events power10: Update JSON/events
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240723052154.96202-1-kjain@linux.ibm.com>
 <CAP-5=fWsQbA-h=_Y_q7z1E7GjCkHE3w-9h-OXu4jLBM3Fag6ag@mail.gmail.com>
 <ZqOt9G9e-AIN6hY-@x1> <ZqqULZ5pSojnixUh@x1> <ZqqbO54hbW5Tzk9Y@x1>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <ZqqbO54hbW5Tzk9Y@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bAMQxRXsFS9VRiKy1SjeI1_dGQOaTPi5
X-Proofpoint-GUID: ul4LwN91O2ar-CwS7Z2ez79FxFnb5YB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010042



On 8/1/24 01:44, Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 31, 2024 at 04:44:49PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Fri, Jul 26, 2024 at 11:08:55AM -0300, Arnaldo Carvalho de Melo wrote:
>>> On Tue, Jul 23, 2024 at 09:02:23AM -0700, Ian Rogers wrote:
>>>> On Mon, Jul 22, 2024 at 10:27 PM Kajol Jain <kjain@linux.ibm.com> wrote:
>>>>>
>>>>> Update JSON/events for power10 platform with additional events.
>>>>> Also move PM_VECTOR_LD_CMPL event from others.json to
>>>>> frontend.json file.
>>>>>
>>>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>>>
>>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>>
>>> Thanks, applied to tmp.perf-tools-next,
>>
>> This seems to be causing this:
>>
>> Exception processing pmu-events/arch/powerpc/power10/others.json
>> Traceback (most recent call last):
>>   File "pmu-events/jevents.py", line 1309, in <module>
>>     main()
>>   File "pmu-events/jevents.py", line 1291, in main
>>     ftw(arch_path, [], preprocess_one_file)
>>   File "pmu-events/jevents.py", line 1241, in ftw
>>     ftw(item.path, parents + [item.name], action)
>>   File "pmu-events/jevents.py", line 1239, in ftw
>>     action(parents, item)
>>   File "pmu-events/jevents.py", line 623, in preprocess_one_file
>>     for event in read_json_events(item.path, topic):
>>   File "pmu-events/jevents.py", line 440, in read_json_events
>>     events = json.load(open(path), object_hook=JsonEvent)
>>   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
>>   CC      /tmp/build/perf/bench/evlist-open-close.o
>>     return loads(fp.read(),
>>   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
>>     return codecs.ascii_decode(input, self.errors)[0]
>> UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 9231: ordinal not in range(128)
>> pmu-events/Build:35: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
>> make[3]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 1
>> make[3]: *** Deleting file '/tmp/build/perf/pmu-events/pmu-events.c'
>> Makefile.perf:763: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
>> make[2]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>>   CC      /tmp/build/perf/tests/hists_cumulate.o
>>   CC      /tmp/build/perf/arch/powerpc/util/event.o
>>   CC      /tmp/build/perf/bench/breakpoint.o
>>   CC      /tmp/build/perf/builtin-data.o
>>
>>
>> This happened in the past, I'm now trying to figure this out :-\
>>
>> This was in:
>>
>> toolsbuilder@five:~$ cat dm.log/ubuntu:18.04-x-powerpc
>>
>>
>> So 32-bit powerpc, ubuntu 18.04
> 
> This did the trick, so I fixed it in my repo, please ack, just replacing
> ’ with ' :-\
> 
> - Arnaldo
> 

Hi Arnaldo,
  Thanks for fixing it. I will make sure in next series of patches, we
are also checking for this combination to avoid ascii issue.

Change looks fine to me.

Thanks,
Kajol Jain

> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/others.json b/tools/perf/pmu-events/arch/powerpc/power10/others.json
> index 53ca610152faa237..3789304cb363bbb7 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/others.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/others.json
> @@ -197,6 +197,6 @@
>    {
>      "EventCode": "0x0B0000026880",
>      "EventName": "PM_L2_SNP_TLBIE_SLBIE_DELAY",
> -    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG that targets this thread's LPAR was in flight while in a hottemp condition. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_SNP_TLBIE_SLBIE_START to obtain the overall efficiency. Note: ’inflight’ means SnpTLB has been sent to core(ie doesn’t include when SnpTLB is in NCU waiting to be launched serially behind different SnpTLB). The NCU Snooper gets in a ’hottemp’ delay window when it detects it is above its TLBIE/SLBIE threshold for process SnpTLBIE/SLBIE with this core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
> +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG that targets this thread's LPAR was in flight while in a hottemp condition. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_SNP_TLBIE_SLBIE_START to obtain the overall efficiency. Note: 'inflight' means SnpTLB has been sent to core(ie doesn't include when SnpTLB is in NCU waiting to be launched serially behind different SnpTLB). The NCU Snooper gets in a 'hottemp' delay window when it detects it is above its TLBIE/SLBIE threshold for process SnpTLBIE/SLBIE with this core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
>    }
>  ]
> 
