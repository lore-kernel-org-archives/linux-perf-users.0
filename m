Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662723C8C5;
	Wed,  2 Jul 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446689; cv=none; b=k/Kixy7CTW6k2+Bc7cCh24d0cI2xkHv+B8xN6J2nVoga32BvgFJ57GdAQ0OAoy7qWk3PAVBKTz/LJ1WTtK31RlNWse+frrdN6HhlUvBvu1MJ46vzLQporE/rZ4hdyNwAOxZheJvPgknXz9JmCaEmtzlyU/f/wkQ2Q5CcGvyr6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446689; c=relaxed/simple;
	bh=hN6X+y4YJsDLqBUBF+puGdtAc8xXvaGCEdfGLztGYmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCuJbO5M7Y/dsVaOeIzzYfPURrsVCzZ1yApyEe+VMGYkH5lRQ1TSNvXLmxcZ8LbNUEhfrHNy5130z0rXtgGZC7MViHZ9JXBo0+WNAR4dd7bxVjpunkofpm/iEUc0C/YNV7K+Jvo11+hgRR2uf2lXGrrgk1bfYVa4yNBVITWP/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHoNOOqj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHoNOOqj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5625SuGh024499;
	Wed, 2 Jul 2025 08:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vcyYqz
	MTUtZIDyj+coq/f+ClbS9PwNEG6AskO6e1rCA=; b=aHoNOOqjsWwXcyKmN5quzA
	k8xyIsckkTv4W2fAxCGlhcpeyiO4BbqQHXXiK8lPrUd0Kn3xeR+cFY2o0jypLGyF
	rQxmMj8gc68/Mw9vC8mE+Titbh3lf+dXV1tXPfcR/UidDS711GgWsXiuCbHsa8JF
	SO9/nc+FngSlXLyu0vkJKbrLFuSA8QSFh2y/8w5r9gKuSki81WaBTabH5LcGlu9c
	20U/azaryf+XIP7kZIH6sQAWDW3F+nl1rqMDIow0f0Y3QWymbxkRPqbW2s92ZQXP
	L2MYfTKUV903KEIsFY7+0xDBvqs5iyzfb3i0HKZU5pAqVZhd/sINY7uwnqMc9kaQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830v9ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 08:58:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5628sM21020554;
	Wed, 2 Jul 2025 08:58:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830v9tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 08:58:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5625UGY3021906;
	Wed, 2 Jul 2025 08:58:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpppgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 08:58:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5628vx6O46531040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 08:57:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E07C20043;
	Wed,  2 Jul 2025 08:57:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D650420040;
	Wed,  2 Jul 2025 08:57:58 +0000 (GMT)
Received: from [9.152.212.130] (unknown [9.152.212.130])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 08:57:58 +0000 (GMT)
Message-ID: <a63ecea7-8ab0-4691-897c-09f6efa82068@linux.ibm.com>
Date: Wed, 2 Jul 2025 10:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Ping][PATCH] perf list: Add IBM z17 event descriptions
To: Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, agordeev@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
 <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
 <ad905a68-a89b-458d-8a8b-2081a6656b91@linux.ibm.com>
 <283e109b-9eb5-4e7d-b7df-215f54496503@linux.ibm.com>
 <CAP-5=fVcNqE9txXQgO+EUV6xz3Mvsqin9FP8FNUztPp35LW2Ng@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fVcNqE9txXQgO+EUV6xz3Mvsqin9FP8FNUztPp35LW2Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xhxVdaFy5r3v5RLH9nAGTYN47Piw0eDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3MCBTYWx0ZWRfX+j4mUWqGyzWF dhnEosHuZ4W6EmJ3BzgBRIxMoRE+nba4Iy/46YdffLf9Y8IxrNAgAVdnHJpu/lFCT2w7QZ22Vye tqlvHEubbZlNj4z30ux7BzdyBSUMWW5DNByQ8cM8mkDkfphT553PyL23Hg72eAWUlv101kbXUBS
 SQx/D6sBF6sUdv9L8j1KxDqf1AxNzKU9c1uGjydeg3u2oBXQmHnfWlhSodrT9b2v3Z8a3KgYwfp rigA/XXcdFixjOx/J8tljEXFrWzyWWf81iw+pd09lS/HXy3sLh6aDkY6CPnYqKtSonGsPu9BY8i fynUBiviZihrm/rdmOFBwb7qEPUZPP9+QT2ZKQSAuICRxG30BiIALpwRUEv1yylicIIrPM23gCd
 oePcVY4ImTwC2I9STalD8TYTheAtJpPpZnUWDW5d2CD8sO0J8O4UVXbriUYvbQfgl4IqWv0u
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=6864f49d cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=VTD5pCTsERiSmnhXbdAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Li_SBf8Twpxvmp5U0LO_3fcQzeIwJ4OT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020070

On 6/27/25 18:55, Ian Rogers wrote:
> On Fri, Jun 27, 2025 at 1:13 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> On 6/24/25 08:35, Thomas Richter wrote:
>>
>> Gently Ping
>>
>> Ian, I have responded to your comments some days ago.
> 
> Thanks Thomas, minor nit in your explanation the events must exist as
> they are in json, but the json events are only exposed if the PMU is
> present, so the has_event is more of a has_pmu test. Maybe we should
> add a function like this to the metrics to make this kind of case
> clearer. Maybe `perf list` should test the events of a metric and hide
> metrics when the events aren't available to avoid the have_event
> logic. I'm a bit uncomfortable with that as the events may not be
> available because of permission issues, but it'd still be useful to
> know the metrics are around. Anyway I'm digressing.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 

Arnaldo, Namhyung,

with Ian Rogers Reviewed-by: approval, it is possible to
accept this patch soon, so it will land in the next merge-window.

That will give me an commit-id which I need for my addon work.

Thanks a lot for your help.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
