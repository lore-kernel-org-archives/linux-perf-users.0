Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937421494A8
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816081; cv=none; b=l7/cjZ4Q5iA6Y7j2o88TZ/TAC3C9QhqHusxX8njnTJxu2bMjhm9+km8lXSuhFNBL1Y0s98XmknVawB8tUF4IQk9bBAmrcwhxUcxExaFo6LTSWphGEc8YOi+5VbvRttJ13q2nMPMtoZHVq7h4KCFV/KNq/Fi55SHnGVEbXIXs4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816081; c=relaxed/simple;
	bh=jC0pIYwcJ+FOED7fWw+V1uYGRjk53axT4uj4+VxHBcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEfwDZLR/XOob6nm2f5BGCVCqpkt1M8oMCK80EyiJ9RqwcGtDkpqMln2iNxTEtxZd6j+ZmY5VMBsgzOgeZWf9qX9NH5ry7AzzmzZIfnskALq9Bwe57Fv2zxAeM+yOWd5G9t5+VmIHYXMSAlerFMG3Zyk25LR4DZ8dG+uPXGFPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ji1Y+G9q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ji1Y+G9q"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596LhDUs029541;
	Tue, 7 Oct 2025 05:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2P/nj3
	SzyZ+y/0RbeSS7tOWS9VGqkmGBBSyGWXEKLf0=; b=ji1Y+G9qfXHz/fh1hdR2hD
	mh9yZ6JhZjVGYnjNdirEPZiF1eYW3SdM/QeWc3RxaRczRb2wPcXTejRYbuDBFYXE
	R72/kDlEMXMBdcGc2FMZEhaSX6HD5CG6JUi2MAjWiliENpoiU4TJc11i74YbN4eq
	pi7qMyY9wRVXdp51LDKDjs5XPknd3mGXDOktX8ydWAGdF/sXYd/sloSyL5bFyzeS
	xSbLGpFpBbqgMezURVtNsc7O3RMWJa0svPfiNq8D7Mp7CT6BbSQfP4fuO1cOpyJv
	3u+GJphnFJT0jxdpa8WRZ1ytdzxMXqKqHiIUL25FBN9HcK/FatdBODTpAxH7Ey5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pcveb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:47:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5975lahC000726;
	Tue, 7 Oct 2025 05:47:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pcve6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:47:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5971PYsi013202;
	Tue, 7 Oct 2025 05:47:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kg4jhhwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:47:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5975lXdD43319710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 05:47:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52DAE20043;
	Tue,  7 Oct 2025 05:47:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AE120040;
	Tue,  7 Oct 2025 05:47:33 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Oct 2025 05:47:32 +0000 (GMT)
Message-ID: <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
Date: Tue, 7 Oct 2025 07:47:32 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        dapeng1.mi@linux.intel.com, james.clark@linaro.org
References: <20251001195047.541745-2-ashelat@redhat.com>
 <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e4a978 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=jG6JC8piQt_4cliN:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=lsPmfbrLWt6WFo8QjA0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: MRvOXKK3n_w0IGcv-QhpcYnpyTvqI6Nh
X-Proofpoint-GUID: jZqHQzjaJAWu6dH-4WGevxqocBChREfk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfXwfMIJIJzePCf
 UZ2Oi6bOG+X2Ncnq+Z1AOSDAIBGtpy+RGqxKUPSasme50QLKHw4moEnCSWmiOjDhXB3KEBWGESK
 6Y1hgamtU7lKwtAFYhiuDLdF6z7MF9vOK/gs0j47WosRStBoyE0AcvuNQt2wjQlPEuLcKbb9/62
 dbFrDfkh3PqRf/SYfo5jHgg1dIVt5TwQ2RNbYwFT0rhPOI1OMnMJntQsogYChUgvgQ/zfkP2UhS
 kLptbAsovApgrBn7j+fDo1MlhlnHs93zh6bz6lQu9SbPuPj5bgNymo5v7dqRjJMg8GwVfO3N79G
 JBQESCBKQtPGDJXVC2qdE2Mut7pXmNMMGZLqDa+zA+8k8ElQgPTvQDnP1PQ4M9MepoNcbqtJDY8
 OCZyZ6kxCeNh2iIGWBKN6DcHcD3e6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009

On 10/2/25 15:39, Anubhav Shelat wrote:
> On Oct 1, 2025 at 9:44 PM, Ian Rogers wrote:
>> If cycles is 0 then this will always pass, should this be checking a
> range?
> 
> Yes you're right this will be better.
> 
> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
>> Can we use a larger range to allow the test to pass?
> 
> What range do you get on s390? When I do group measurements using "perf
> record -e "{cycles,cycles}:Su" perf test -w brstack" like in the test I
> always get somewhere between 20 and 50 cycles difference. I haven't tested
> on s390x, but I see no cycle count difference when testing the same command
> on x86. I have observed much larger, more varied differences when using
> software events.
> 
> Anubhav
> 

Here is the output of the 

 # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack 
 # perf script | grep brstack

commands:

perf 1110782 426394.696874:    6885000 cycles:           116fc9e brstack_bench+0xae (/r>
perf 1110782 426394.696875:    1377000 cycles:           116fb98 brstack_foo+0x0 (/root>
perf 1110782 426394.696877:    1377000 cycles:           116fb48 brstack_bar+0x0 (/root>
perf 1110782 426394.696878:    1377000 cycles:           116fc94 brstack_bench+0xa4 (/r>
perf 1110782 426394.696880:    1377000 cycles:           116fc84 brstack_bench+0x94 (/r>
perf 1110782 426394.696881:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
perf 1110782 426394.696883:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
perf 1110782 426394.696884:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
perf 1110782 426394.696885:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
perf 1110782 426394.696887:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
perf 1110782 426394.696888:    1377000 cycles:           116fc98 brstack_bench+0xa8 (/r>
perf 1110782 426394.696890:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
perf 1110782 426394.696891:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
perf 1110782 426394.703542:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
perf 1110782 426394.703542:   30971975 cycles:           116fb7c brstack_bar+0x34 (/roo>
perf 1110782 426394.703543:    1377000 cycles:           116fc76 brstack_bench+0x86 (/r>
perf 1110782 426394.703545:    1377000 cycles:           116fc06 brstack_bench+0x16 (/r>
perf 1110782 426394.703546:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
perf 1110782 426394.703547:    1377000 cycles:           116fc20 brstack_bench+0x30 (/r>
perf 1110782 426394.703549:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
perf 1110782 426394.703550:    1377000 cycles:           116fcbc brstack_bench+0xcc

They are usual identical values beside one or two which are way off. Ignoring those would
be good.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
