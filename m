Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA502C859;
	Thu, 14 Nov 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598049; cv=none; b=dji6MI66ai1mz//RctRAfg8aLFIT+6iMGoQ+6Pw4w7u28hNoseY7rovT10bvy5zT0bynj8OokRFRaTnHXrugkRG0Jodalv4c/mlKbIMBeH1sGO90Ht2qH0wt4fOAyb5pkyxRd/nR5/UkC2N4rhPaeov18IzARlCrKiMe2MPkvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598049; c=relaxed/simple;
	bh=AlrJiZZOyYgTIyh3xiaPHspbKmDJnPiNHoinUQL7L1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=agDEYSIFecrhvuaCpcFLP9boGe63FRay6AztSh3KFoWueZj6JRKxX0yDJH+EDF0tLT4ioCwI03T7GMi2iUWYSj6B8Dyll8SYq3DKMBLCxAeWDUhgdqD3L8t+yUT/UrkbqARFgYxi8PSDlxfk+JH/EqsMrL5EKaRty37ty/Z8QhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h1s8dlpx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h1s8dlpx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEAUeh016507;
	Thu, 14 Nov 2024 15:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qWzriA
	jXB4q5NSkWXUx0bVViLmGjPmLT8Bq1oELXIQs=; b=h1s8dlpxqUMwhOugdDIU2A
	WabGaArQssp100QhFqjRPH1ChQ7XyG42NSAUz3MMeVJXnkT5wId5iLui45KoHPXL
	6zyQY8cYLuwwL8cptRgjOnZsvbDmung95+ZHo7+E/IT6AQLMWhVYyPoCIjeoxMoa
	1bd9RQp356j53y2GQ6rj+Ci4C9uFdY6zpk1I5PbR/L2k8815PNLmDKVz9Itv6bNd
	3fHxLh9bAPBkS/0gseTGxApid+kh8B6CSUgVrxrsgJ2m85CE9zLkhcBugNnTXVdz
	UFBWl0/PiD2yArk6JraBytOiti1tStBF7Ykg6YkTm0Znl2qPu19KGd5FbOwf10Ww
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wjqrgb38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 15:27:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AEFOmVf021989;
	Thu, 14 Nov 2024 15:27:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wjqrgb33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 15:27:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEAtOY7010521;
	Thu, 14 Nov 2024 15:27:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s8krb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 15:27:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AEFRE4S29557494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:27:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F28220043;
	Thu, 14 Nov 2024 15:27:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D6A620040;
	Thu, 14 Nov 2024 15:27:14 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Nov 2024 15:27:14 +0000 (GMT)
Message-ID: <8eb7e7d2-6fd6-4f3f-a3ca-265639adc61c@linux.ibm.com>
Date: Thu, 14 Nov 2024 16:27:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: perf report: fix off-by-one for non-activation frames
To: Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jan Kratochvil <jan.kratochvil@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>
References: <20170515150444.6841-1-milian.wolff@kdab.com>
 <1916323.ygRLzu1ryd@agathebauer> <20170619185939.GA2170@redhat.com>
 <1729469.05pq3V20xn@milian-kdab2>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <1729469.05pq3V20xn@milian-kdab2>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zDrQ29wDvZryIbrmCKcN7E3NOvqQQJn-
X-Proofpoint-GUID: NdkQDcVZhV_yExKTemOuLAf2KPIhtRIZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140114

On 04.07.2017 09:59, Milian Wolff wrote:
> On Monday, June 19, 2017 8:59:39 PM CEST Arnaldo Carvalho de Melo wrote:
>> Em Sat, Jun 17, 2017 at 01:13:11PM +0200, Milian Wolff escreveu:
>>> On Samstag, 17. Juni 2017 10:04:02 CEST Jan Kratochvil wrote:
>>>> On Sat, 17 Jun 2017 09:56:57 +0200, Namhyung Kim wrote:
>>>>> Not sure whether it needs be fixed or not.  If we fix it, srcline and
>>>>> address would not match so it can give its own confusion to users.
>>>>> Ideally it should display an addressof the instruction before the
>>>>> address IMHO.
>>>>
>>>> One can figure million ways how it can behave and each one has its pros
>>>> and
>>>> cons.  I was just describing the current behavior of GDB and LLDB which
>>>> people are used to already.
>>>
>>> Personally, I agree with Jan that we should mimick existing tool's
>>> behavior. I just fear that it's not trivial to do it with the current
>>> code base...
>> But we agree it is a worthwhile change (have backtraces in perf match
>> what gdb, etc show), right?
>>
>> If you can, please try to do this, your attempt will help us understand
>> more the extent of the changes needed and perhaps someonw can come up
>> with simplifications...
> 
> Sorry for the (long) delay, but I'm sadly busy on other things right now. I
> have this on my radar and will try to find time to look into it. But it
> probably won't happen before end of July. If this is urgent, maybe someone
> else needs to look into it before me.

I ran into the odd "decremented by one" IPs (and function offsets) on
s390, which requires instructions to be aligned on 2 byte boundary, and
ended up debugging the code to learn that this is actually on purpose
and why.

If it cannot easily be "fixed" in the output, could it at least be
documented?

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303) and z/VSE Support
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des 
Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der 
Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

