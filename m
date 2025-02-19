Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96E1DE3AE
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960010; cv=none; b=Chv99IajbME2YL5zk9gRy2TqR6MQN5Rn/11md8ObsodIQc+8Ynqu/mKaKceKJMrw5RbQdR4s83l1Mrs9yVcW1LDQEVAzJTI3Sk6fqTvccNMOVFm54OEhPx8yE7DUiAqXVNXhbJXo6Y+VyfmsYpBJLt4NxMnl4xU6Il2a6Xtlhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960010; c=relaxed/simple;
	bh=23VFbswcJIWATnzUEQmrCkChqjPm4rXRYmGECvMB4jk=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=YhiYdDtkP1F+YBCWU1KEOK4Ydyq41axYr9mWuRRDRxsNMsRlH51WU1AYAGLKinI7D9SP72nHJJ4qvqJe7lrxJoqNyZuJJYT1tKE+sv6azLFcxo5kzwJwoaaxzNKGDaBQ1SfM0GiW/zvnUrNowuGCG/bfKeukoqxrxg2o26GZfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AwSLfqcF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AwSLfqcF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75Cao019820;
	Wed, 19 Feb 2025 10:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xZtOqq
	xqnZQ2CfOc2ruVLzEWJnueWN819PqKHj6LulA=; b=AwSLfqcFcNxQdMzkknS6O8
	p6u3ARGuJVxROsnkj6gH9D2nYpS/rIFDvzFYoF7409gbe2rvp5b7F0Dcg37FI+lj
	54148dBKEU4ZD9dIOfKiwgJ7hA2TR267+zwaS9xahYTOYMVMLDABqsNEDNr3pLDU
	XTf641j0ygeNq2zIlUrGzHc1KzEEihGkTfJOtx7x+7nqeYgPRu5NJlitp6KWpkqk
	7eqlQsrbyFUYzOFKYvc5T948x/VDjiF9+5qfZAB6Pw8COikq4nn6+HKFtEL9xbI9
	Uesz0uTSgwUWU2IdjhRsURiYoop3tuEsFpLELVZVplMjRVSEQGj3GhYq6xYFQ4RQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyq3abt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 10:13:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JA8IQK009702;
	Wed, 19 Feb 2025 10:13:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y3f8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 10:13:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JADLYN14156180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 10:13:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 563FC2006E;
	Wed, 19 Feb 2025 10:13:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EF872005A;
	Wed, 19 Feb 2025 10:13:21 +0000 (GMT)
Received: from [9.171.69.222] (unknown [9.171.69.222])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 10:13:21 +0000 (GMT)
Message-ID: <92d122f2-cde7-4382-8303-0ad8a29c1e14@linux.ibm.com>
Date: Wed, 19 Feb 2025 11:13:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: PING perf script: perf script hangs forever in linux-next
Content-Language: en-US
References: <b8b12ca5-28bd-4e17-923a-f4f5853b999a@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: ashelat@redhat.com, Michael Petlan <mpetlan@redhat.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <b8b12ca5-28bd-4e17-923a-f4f5853b999a@linux.ibm.com>
X-Forwarded-Message-Id: <b8b12ca5-28bd-4e17-923a-f4f5853b999a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8voU_QiBbIoInHgK0HCPE-H-5hTyAo6y
X-Proofpoint-ORIG-GUID: 8voU_QiBbIoInHgK0HCPE-H-5hTyAo6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190080


Hi all,

just a friendly ping as reminder that this issue still exist...

Thanks for your help.


-------- Forwarded Message --------
Subject: Re: perf script: perf script hangs forever in linux-next
Date: Fri, 14 Feb 2025 11:21:56 +0100
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
To: Namhyung Kim <namhyung@kernel.org>
CC: linux-perf-use. <linux-perf-users@vger.kernel.org>, ashelat@redhat.com, Michael Petlan <mpetlan@redhat.com>

On 2/14/25 03:13, Namhyung Kim wrote:
> perf script flamegraph -a -F 99 sleep 1

Thanks Namhyung,

i have tested your patch and both invocations of the perf script command
work again as can be seen here:

# perf script flamegraph -a -- sleep 1
dumping data to flamegraph.html
#  perf record -- dd if=/dev/zero of=/dev/null bs=1M count=10K > /dev/null
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB, 10 GiB) copied, 0.294051 s, 36.5 GB/s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.060 MB perf.data (1177 samples) ]
#  perf script report flamegraph
dumping data to flamegraph.html
# 

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
