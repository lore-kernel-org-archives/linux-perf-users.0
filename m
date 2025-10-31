Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC023195E3
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894405; cv=none; b=C6fj9AZ6bNkXUvKMDS6uEIAPmPax18bCZhpnFZ2CAg7/l7uENI243CGbuield+3x/o1xkRaEoGo30QD97iZxcIQY1VTSl4UNFthI3nhpO2dr5qqZwH2EkeTCW/00+w77Oz3f1ApGfsjsCclq+Gd47M6KbdjN3BHa5ODd1hlWEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894405; c=relaxed/simple;
	bh=zpSsdlxAgel8A1maxObCz5dhwToGEFygvGQUwQFns94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBKdFLTqtszOA8g9NWYzJbb6yUCBcC/7mdjJkrTlwc5X3hQftwl61Uxe79u/Rd7EOIXlyUpuvQHrPrFq1hTKR9mkQY42rYm731EaHr8Z2oMEWVE9r/y7LpqhTiPGP1SAUieulY45WCOp3kj+lB53iLQtg5yz/3hBM5a0O8XH6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mwt5+D+V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mwt5+D+V"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UJeAWC020439
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 07:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=deI2I+
	ltGZl4QcQqzmG3fEyLf0TZpKCp3Y/VfQLZlm4=; b=Mwt5+D+VfyODCct22jE9rW
	02GlXSA8gwVcl1EnrM4K98263KjpYcePxzxxg3aIuJr9xPIjSYZPQWXnhgHQsfD4
	MLmZEHR5S7WYClz9VEN8xgZ7a3jQI9TwCYfol0efGc3u+kjxuAS7vCLSRZlblvzz
	qd6Ujuk6QiV0UmC1W2tH0gFy4Jn+1nsxK+LlxPBeJEoDC/gPDD1b0N26J5liSbj2
	FcOw/kVIlPl2ZlcFlB7+JmF915SIN3Z4el7kqufjBLmPthJ28YVEV6qVTlQvLJsS
	BIclVB95brI7l6y5wmQzgEpXCMFFlUBfs9MoF4AZvc24q+UYXKnRzwoQKzs07M4w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agvbx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 07:06:42 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59V74OFL022587
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 07:06:42 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agvbx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 07:06:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59V2rXtX019545;
	Fri, 31 Oct 2025 07:06:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xyd11q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 07:06:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59V76bk037355990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 07:06:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F2722004B;
	Fri, 31 Oct 2025 07:06:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4119E20040;
	Fri, 31 Oct 2025 07:06:37 +0000 (GMT)
Received: from [9.87.152.126] (unknown [9.87.152.126])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Oct 2025 07:06:37 +0000 (GMT)
Message-ID: <ad38454d-b4b6-4bfa-b179-4a460087247d@linux.ibm.com>
Date: Fri, 31 Oct 2025 08:06:36 +0100
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
 <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com>
 <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>
 <13800bed-1256-4414-ac8b-e99439c748ec@linux.ibm.com>
 <3b86c7e0-5b3e-468c-8077-7efa3959d221@linux.ibm.com>
 <02841ee0-d0b2-48a8-b523-7bcc561ad64f@linux.ibm.com>
 <CAP-5=fUKaX0b5b3QYarL9qUK4Z=u0zpKnB9XVm-_bOKap7sJag@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fUKaX0b5b3QYarL9qUK4Z=u0zpKnB9XVm-_bOKap7sJag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=69046002 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=XPtN7dBuAgipyJ0TDSUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AitCLFYFv2FkYjPVCEuQsmj-ub0UYBtF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX3dXLzktVQwl6
 dX/EyK2Sr3Smh46GG/x1PXvu10q32BmvlZqbacReDeTMiFQb5pwFitH7oXfKyZ6Fab/gNvKG4uj
 3z9M1RDPsEovtWhVlJkI+41sYbkNBPArA8VCHLIjaT8/ybeY8pJrM86YGLfDgwoLIz0BVi2+drM
 KFRXxb0tP+0IWXqqHxm4fknlVSDwq/45ZieLbP2MZ38mrzTBEYaMhh2/LRX3iIflJXm2O64uly4
 TpgV30U5ZtmEXDUz/tDvA3XHox1Q4Rq3hDRXIgqCc7jXzfSFVHj7qVVXePyg5mjVJtPKldIBLjk
 bWpn6jZFXgVKpMmaGN8ayarnjTFYKeXBTUIEqQTvUxGDtt0L3q+PxuwIO3YHUsYGdIiobidSMeM
 vF2Gv5vQkHG9DLjZBLc5Mkk3nJ1RDw==
X-Proofpoint-GUID: 9i6XWs76XvThcPf_4CNSdrhthCR4R69M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On 10/30/25 16:57, Ian Rogers wrote:
> On Thu, Oct 30, 2025 at 7:27 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> On 10/30/25 14:25, Thomas Richter wrote:
>>> On 10/30/25 09:59, Thomas Richter wrote:
>>> This is the first bad commit.... (I actually tested it :-(, obviously without -D option )
>>>
>>> commit 0012e0fa221bf9cc54aa6a0e94d848653dc781bb (HEAD)
>>> Author: Ian Rogers <irogers@google.com>
>>> Date:   Sun Oct 5 11:24:16 2025 -0700
>>>
>>>     perf jevents: Add legacy-hardware and legacy-cache json
>>>
>>>     The legacy-hardware.json is added containing hardware events similarly
>>>     to the software.json file. A difference is that for the software PMU
>>>     the name is known and matches sysfs. In the legacy-hardware.json no
>>>     Unit/PMU is specified for the events meaning default_core is used and
>>>     the events will appear for all core PMUs.
>>>     ......
>>>
>>> What puzzles me is that the above patch does not change anything in
>>> util/s390-sample-raw.c which handles s390 specific sample interpretation.
>>>
>>> Maybe that patch affects perf_pmus__find()?
>>> Not sure how to proceed.
>>>
>>> Thanks a lot
>>
>> Ian,
>>
>> the issue is within function perf_pmu__for_each_event().
>> Without calling this function the output is as fast as before.
>> (Well a bit faster, because I replaced this call by strdup("hardcoded-name");)
>>
>> I have looked at this code, but I did not understand a thing....
>> Strange, perf_pmu__for_each_event() did not change in this commit,
>> but the behavior changed a lot.
>>
>> What we need for s390 is some way of faster event name lookup,
>> the PMU is known, its "cpum_cf". Is there no easy way to
>> find the events on this PMU (given the event number).
>>
>> Maybe a some sort of table, because this lookup is done
>> millions of times on a large file with samples including raw data
>>
>> Ideas?
> 
> Thanks Thomas!
> 
> The bisect and the behavior make sense now. Previously the legacy
> events weren't part of perf_pmu__for_each_event and now with the
> legacy-hardware.json they are. The events were parsed by matching
> explicitly in the parse-events.l lex parser, but for lots of reasons
> the json is better. Anyway, there is common functionality for
> reversing a perf_event_attr.config to an event name in
> perf_pmu__name_from_config:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.h?h=perf-tools-next#n306
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n2728
> 
> The normal case for a PMU is that we want to see if it has an event by
> name, so we have a hashmap from name to the "alias" information (I
> don't really like the name "alias", it is information about an event
> we want to encode):
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n58
> 
> The use-case for perf_pmu__name_from_config is generally debug output,
> so there isn't a fast path config to name lookup. Is config to name
> lookup sufficient in s390-sample-raw.c? I notice that the code is
> matching the "event=" part of the encoding, which is a sub-part of the
> config (and may actually be a value in config2 or config3).
> 
> I wonder if it would be easier to add a cache of matched names in
> s390-sample-raw.c? So a global/static hashmap in that C file with a
> key of set and nr as per get_counter_name (it seems the PMU can be
> implied to always only be the core PMU) and a value of a strdup-ed
> counter name.


I do confirm your assessment, here is the proof. A very poor man's caching
in util/s390-sample-raw.c:

# git diff
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 335217bb532b..b04d3b1a8750 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -162,6 +162,7 @@ static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
  * number and use this as key. If they match return the name of this counter.
  * If no match is found a NULL pointer is returned.
  */
+static char *ctrname[500];
 static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 {
        struct get_counter_name_data data = {
@@ -171,9 +172,14 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 
        if (!pmu)
                return NULL;
+if (ctrname[data.wanted]) return strdup(ctrname[data.wanted]);
 
        perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/ true,
                                 &data, get_counter_name_callback);
+if(data.result)
+    ctrname[data.wanted] = strdup(data.result);
+else
+    ctrname[data.wanted] = strdup("unknown");
        return data.result;
 }
 
# cd
# time mirror-linux-next/tools/perf/perf report -D -i ~/perf.data-test > /dev/null

real	0m25.908s
user	0m25.548s
sys	0m0.182s
# 

> 
> Let me know what you think and I can send you a patch if you like.
> 
> Thanks,
> Ian

Of course!!
A hash list is more flexible, but an array is fine too. There are very few holes
in the counter set numbers, They are listed as "unknown". That does not mean these
counter do not exist! Most of them have values, but their name was not made public
in the documentation SA23-2261-09.

And there are more counters from the PAI crypto (172) and PAI NNPA PMUs (36), not much
but in a different range. So I guess this qualifies for the hash solution.

Thanks a lot
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
