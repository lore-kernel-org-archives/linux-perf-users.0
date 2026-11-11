Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389007;
	b=USw4nL5NbSh6Dq47K3Cjc+lo846lTfVRwNgIpz7R1IUW0N1hyRhb+s8KLfl6es6O5BuG
	 6To67AnatpYdvoAiFJ498GenU44uZHQWtseKu/tuLkDJOilihftoIsWGiAkQtXznB1T/N
	 ln3nxXMucvXmCNjtObqF77e4mYeTtuLZf2qC7cas60o+V6dt1gpkx5ATAAOUz8Yiyde9J
	 0RaLS5VsSP/IMDKuvF2GhocDuiFKoRR8HeWhJPHniTaggjIIIEwFrMFz5u4E7n4czpZAv
	 Ljjy66xZn4Pbw80lIC1wVZ+sTw6qIlpRzaSVoBaRDTqQn1nc4GW8MJCmI7gFUThUMNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bcUd4k3QsasLWhd4sxzl9fnWZWaHTNHfLltKMtGghto=;
	b=uLsZV1PT1z7YdoLlWHPfMO6cn5Fxnlkq/kcuNO/flAjag6NIr1KaWp5wFAXiN40DdR2a
	 Ts57biHgNgHLwJ40vbAaCvhlyYwSnfQnDzWe0mUdl1GVCrkdt4Rh9ZZGt8DvSpawlPLnM
	 onXg2PLOaPsuTX5pYIn12+kAF1W1Q1SnfZlqWnkQLWg5SXgaO519eflVIk/2PdZ4VEKDh
	 MjpbwMGulB9J+Mvn3YkFbD5G5HWRzBxZL9kmn3eylhtiXzyWe1N8MJYBeIijB9zXBHajQ
	 6+3KuZ5z7FwW0gHWMLXt0+G76/6vOYJ8BM4qKDg2Wfafpg3yvO5vX0Hm0j4ELJ/mhPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Z68Je/8e";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B0606A31C;
	Wed, 11 Nov 2026 09:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 914B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z68Je/8e
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iPgG285442;
	Wed, 11 Nov 2026 09:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bcUd4k
	3QsasLWhd4sxzl9fnWZWaHTNHfLltKMtGghto=; b=Z68Je/8emtLwXksAifow/S
	Fb/TPamUPkSDAGSaoQsAR90uf8kWfHUfv1vVhNmWXQvLCJSXzeJnfRiPhLss6zNs
	a7+XBCk2WOm3f1eIStvpB+96Tht5gCJ0lZYJx5fHySLKmU/VnLvSvikOtQ06/ux0
	FBr8l4iXG4sNiWO8NIkoOe+09uCyTlNHuYFpivRCG7Su0npnzrMSDCx09/JhL6Vf
	lKIl9LThbedpYXkHCTf1rMLWrucyvUoJn0/X57ImzQUfAdgY1KcwhUL3ro4NTY2q
	rf0ZMc0I5CWvL4wfShFLuNxkzxMRrgO+iLvNqnNo+BXDlFzGlSOnDGEqzq7gdmBA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq71dq7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:23:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5K4Qs2859522;
	Wed, 11 Nov 2026 09:23:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309kur6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:23:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB9N2sE28508454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 09:23:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA76420043;
	Wed, 11 Nov 2026 09:23:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 327A720040;
	Wed, 11 Nov 2026 09:22:59 +0000 (GMT)
Received: from [9.124.213.92] (unknown [9.124.213.92])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 09:22:58 +0000 (GMT)
Message-ID: <c1e22acc-dedf-4f07-8d97-a79649826b99@linux.ibm.com>
Date: Wed, 11 Nov 2026 14:52:58 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cpumask: Use cpumask_intersects* APIs where
 applicable
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-perf-users@vger.kernel.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
        sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111091644.GW2668804@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261111091644.GW2668804@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfX26wOkR3iQmp0
 cKK5NVhy/p4bgbYpUNBkUenANvmcoCCMXGMfV9czeYBHVhF0pmD59+SaOuCp8Hd+re5C+iDQJK0
 kNT2h4uTO8HaRpAkmqgj+E/KtRJ3NvQ=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af433f9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=FAYFa1rvXLutK0IN9csA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sx_JLqJm0al1JK25HpNF-ufnu4Dv-wf3
X-Proofpoint-GUID: F76lRWt1pKnHdp4fbujLKp7rxTTLwqD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNiBTYWx0ZWRfX/coYLva5u1hL
 pKpwYGpOC86anwp+SXb86Ee2YAbgd/mh67k7FfZS9p6+46Mq0p7YfHoc3bMeSk1brLAQjNFodws
 Rpa8iVaseUIDBrXrKit2P/kIj0Be/ecKtWety4y9yASNA3PduCo9Kn5JZdJibj0aveHWR9B61wv
 XxOPPzyI5K6KR2vA9wfAmz42zocRUlZvXIYN4fcKldDpOyTUfdPkwY5CWPWtuZHNK7wV+wqV3Yo
 gMLlqXp/Tvlxns9KbNKsqNHYzoD/GINT/A9OSbHdur0L2O3Fa+YpoHH0FtNELSzxcBgsTZ1xTlb
 aD8P9pmQQm0ILACVkedo/2cI6hIWXAfelPI3cib8fIMWPBb/C/eMRnq+EEYq0YhTybysRRAAQ8A
 CyShd4wG6KHChdWKYtSldwzUib2vB9AXiqRojzt1zrfNQD0qXpoGLzjP6aT5GFRguyompMcUeN4
 HKCNKPiBdv4FXP480eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110036



On 11/11/26 2:46 PM, Peter Zijlstra wrote:
> On Wed, Nov 11, 2026 at 01:29:40PM +0530, Shrikanth Hegde wrote:
> 
>> Shrikanth Hegde (5):
> 
>>    cpuidle: Use cpumask_intersects_and where applicable
>>    arch_topology: Use cpumask_intersects where applicable
>   
>>   drivers/base/arch_topology.c | 9 +--------
>>   drivers/cpuidle/coupled.c    | 4 ++--
> 
> That's not actually code I maintain. That's rjw stuff.

Yes. Sorry, I should have cc'ed him.

Should I split this series and send it to each subsystem instead?
