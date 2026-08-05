Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D03E6DD0
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926433; cv=none; b=hCZCzsmxwK29LxnYQ5+QmXGUE2RtYg6e/MTdzuMN/BxDxSsM1aqYgT1X1g8EuTU9MeVl3b+SyRmqcYNUzX3YEiu8ymLm3ZyJg0ufWS2dSHLKnlZ0v7qb8121lX8jrleRjFwq3pkieHAwn0HIzI27sNWnZxefmXqvMx8GMttPSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926433; c=relaxed/simple;
	bh=XOWclAMMkuYhDhV+dPAHCPcN8X7muDkskjE3Rwdczos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B00ewngMu4WLD1sGEnRavlxQvB4L43SDHNT1PwRnhxfOG6vH18Vlt75/A+LQbc1UfirnFQYOKgLaCD+p2lvezOG1GmHWn+YbSJRE1dSWVMjmPlrowJfy/q8PXCFabVNKbSEOrcNpjdq4Hjc0yiWShWcSpVUzajXOVviacKEJ9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EtaVx5yG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EtaVx5yG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lh0L3354542;
	Wed, 5 Aug 2026 10:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TYULhW
	4oC3L2Ksd4Waw3BondtEz1OQMHWVeyTdfKkfk=; b=EtaVx5yGwlWm4Uvru9IlwO
	U/Qswvd6HPvonj17UjFUbVSzTzHsVLn2H9mfwQtQ/A/+HfSbKhobEtDrFNIdxH3d
	3j7YM3kkXjJ41MGVvekK1QeAPhr7Oh/Cpqnhr4GY2HIWv7PXk5La50Q7xA/FyK0b
	6d73AJoan9tieutJ2eXldUy0PH3XtXBG9yMKyCDo6dMFH5B7Q1T3rh5ubuLMuFuu
	0HR+6VWAZqvk+J5Q3iR0FH+Jqe5fO/H2GIVEfbLJKwG1yMDd0NGMKMShn3csmMoR
	nW/nfJIrf3VbBeSDjBzv1xb0AVwb39zYNSi0hJcUYWKRkIRKZXt15Tdk1Z0u9cmw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42kab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 10:40:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AQF12025485;
	Wed, 5 Aug 2026 10:40:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtynwcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 10:40:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675AeCNb21889674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 10:40:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AEF15805A;
	Wed,  5 Aug 2026 10:40:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D1835805C;
	Wed,  5 Aug 2026 10:40:05 +0000 (GMT)
Received: from [9.124.212.93] (unknown [9.124.212.93])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 10:40:05 +0000 (GMT)
Message-ID: <be4c4d52-a74d-4d71-8ec3-b1fe2ed08349@linux.ibm.com>
Date: Wed, 5 Aug 2026 16:10:03 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] Add perf.data tracepoint events to trace.dat
 conversion
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org
References: <20260802180801.65183-1-tshah@linux.ibm.com>
 <CAP-5=fXGaMPzt8BUZKQB4QeuxrfiERAF8Kdut+uBPnXWvL82-g@mail.gmail.com>
 <CAP-5=fV0Y=__y11kmcLBo+1yAMraUKf6pUpdNUfav4NJEocwGA@mail.gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <CAP-5=fV0Y=__y11kmcLBo+1yAMraUKf6pUpdNUfav4NJEocwGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731310 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=1XWaLZrsAAAA:8 a=BxoDo6MavbR7QgIzhckA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: BiqrcGLGTCvHt7phAxQOQo3zLCSyiLsv
X-Proofpoint-GUID: IBomcz3ilk-37tTHJML14EuISnaUA2uI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4MSBTYWx0ZWRfXwc/j2VHUwg9r
 CMTVmChTTw36bqeb4DfJTv/hniWW2glNQ/PlZRUWQ81K0/XSNPn/nXOF9y6MUKolmbovfyRkHSx
 ncmYzdxRdO5AdvsocPnoBXRKSMZIyTc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4MSBTYWx0ZWRfXxJbP7AxVyop5
 JZasnNM25/0RGVwqXKu9ab8K8FS1MCPk4BMpvnNRmBvPq7kbvtDi4ghJBfE/ZQBzkUjOGEnOsAu
 8AxfjYz2KHs4bO5we0ABzlDSA7kT8DDBMCqx7HJYYSBRIwIYaRzZ47nq8dyTEqYag9s9OpdNIlo
 g3KstgPyW/atBo3rokoQKzARI2UjYbzGtWS650Pled9oWh92wlKDynB+Jj5nnoYG+5w5ayt8PKc
 CCvdKWJI1FtoRKv2chNzxvN6UzzY03PKgmySexktaMejZBrpnKz38bYDx7uwI/bz/CoBU1euLii
 tv+2sqEAO7uXl0YeF5sf9v7yktxWrV34NNFayWfYy+lqFirrpHNApsfmhnd1t0kIm5gvP+7idKe
 vsEiSM/imD9j8Sx426E4wWfUSPU7m3kyIVp6DJBV95XKY6PHFRjmnwMnVheMFiClhKaJ48jC4DO
 O7c0pnkf/pqGLw7+mTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050081

Thank you Ian for the review, glad it looks good!

Thanks,
Tanushree Shah

On 05/08/26 07:57, Ian Rogers wrote:
> On Tue, Aug 4, 2026 at 7:07 PM Ian Rogers <irogers@google.com> wrote:
>> On Sun, Aug 2, 2026 at 11:08 AM Tanushree Shah <tshah@linux.ibm.com> wrote:
> ...
>>> v1: https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tshah@linux.ibm.com/
>>
>> Thanks again Tanushree for pursuing this. I see on sashiko.dev that
>> sashiko couldn't review the v2 patches because they failed to apply:
>> https://sashiko.dev/#/log/baseline/53604/2
>> The SHA of perf-tools-next that sashiko.dev was trying was
>> d04ef71492fad7230d474efe33d05f4c0563d409, which corresponds to "perf
>> machine: Check snprintf truncation for guest kallsyms path," added 4
>> days ago:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=d04ef71492fad7230d474efe33d05f4c0563d409
>> Could you rebase the patches so that we can benefit from the Sashiko review?
> 
> Fwiw, I went through the individual patches in case I could give some
> useful early feedback. Everything looks great, and thanks for adding
> the test!
> 
> Thanks,
> Ian

