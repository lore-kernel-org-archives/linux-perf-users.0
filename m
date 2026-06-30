Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE940BCD5;
	Tue, 30 Jun 2026 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823371; cv=none; b=A2uFeSKLinyI/RD0VFzMJnb7/iEWAqwXWM3W7AOWGlNyh7K47QkEMCuL8IhyZyCdAUqX/+iRUyFoYUdxP59BFwUlYimGWGZPRP7QqDK7VqWJK04CYTxPyfzhuBVBa7moZXkZJmLS7mKA+Kp8elFwoUeCqFPyATUkwyYUCdRCiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823371; c=relaxed/simple;
	bh=+cJXEm+KjRZ0DpPg5so5fYZK1PrmRDTUwD1K58JzvJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESE5CH7CBIrIHZR5D65wdKVfbVtHt9V+XLPziH9tevcjGcy5LtcobAOCDtxRykx+gTMqGlp24G2hbbPWYzi/nubT7fVJ20wzGW2hXHetdZunrtA6ATSQ2BHKsZCwt4qH19Mct/jbL/SWFvuCAuNCWfoQDcLwir/0UVpp/MgQDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PThlLmLz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PThlLmLz"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nBqQ1699827;
	Tue, 30 Jun 2026 12:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Iv4pWc
	cesCIXtCFMCSOry33zmxaQyYIaEt252rw6iDA=; b=PThlLmLzx44dIDJnkOTSCS
	EoeXYpQhixLqzEGuKtA7PoDp1/E9yAbPMJYrgizen0SSyArKA1wG9y0VwrCAUqVh
	9k843HOajTGVjKpTkxmqupN6iV5NNEu5pWiIBu6TqGaG2V7EBvHd8sTAhAUxTCB9
	resZkZnNofsFi46Opq3fMzHgh8KpmyGNtSToJ6w+ducgya6Dj2xw29UB+GGuKuqD
	7rMOj6Z17VuyHKXMMN3uhWE83ed0KrDO9onnkhlZBdtgpkm6A00aTNxcAIpszbLG
	xkRBy3PUsx9nSHTWX+78AwQB5g6VgFTB6SQpc7FEZitQvhjLfak070F+7msl7P+g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdxsum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 12:42:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UCJaBs022884;
	Tue, 30 Jun 2026 12:42:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ga2rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 12:42:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UCgeKQ31720120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 12:42:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E496058059;
	Tue, 30 Jun 2026 12:42:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCEE458043;
	Tue, 30 Jun 2026 12:42:37 +0000 (GMT)
Received: from [9.39.22.207] (unknown [9.39.22.207])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 12:42:37 +0000 (GMT)
Message-ID: <c7290425-f198-4993-ab5b-03a7cbb54483@linux.ibm.com>
Date: Tue, 30 Jun 2026 18:12:35 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf dso: Fix kallsyms DSO detection with fallback
 logic
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
References: <20260626161052.1024439-2-tshah@linux.ibm.com>
 <20260626163135.6936F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260626163135.6936F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: GaiKXuYDai7Af3S2ZdSXEcuXcGJLPgTk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNCBTYWx0ZWRfX8iC3/9Rwj2UV
 CqV590BNw1jmoHj+kp9PdAWdFZDYxF7CL/usq/6nvvMRTKbYj+N103g9w1yrUeLfNE8rmy5/7JT
 D6Xl3JFmwUeyTSk5/jbLrFDjBjAxfdM=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43b9c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7Y6hcW0sWS5Gh66Wr2IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNCBTYWx0ZWRfX3WzTZB8ehmA5
 +kACy+wVPM0RUYFF/oKhBdveaRcrnOmxIZFaFDU5PBt5ZlrBO3dNA4/jfWpF1zthCZMqQ5z+qqw
 2enbeeEIWe+ELOrLBhnozzCWyhnutOJ11NxXGkHcsklaOkJU9Un92810PwcHRXXbhRwOrSmdGNO
 nYzF/Evi8B4NOX1O9CdqTYSchj25joB2Fi2yr6dxpVwKm9tHAOMWBYS+UMwAiEPi7RXAro0ZWW+
 QYpOgo7LruGzwMe+/IfVR3qJ8LSZFSlgglhXSheIwB2GjcmyClcmEc4p5uR1eXhOFyvKu4StCBQ
 9h7R0tsyF1nz5Xy9bOUD65C10p4cyHwvUh9I6AncffowK5eJ3XCX2MCL3q5CvJJhETyDpnNS3fs
 9WtHxUjmAuj6AUO4vqf1wsRGaEHfnBQK9Uw2gv6eWgzuyOqfJR5Ep3v3Cpi+Y0IF4LRITG6FUzn
 NAcT9UVoSrU6rt58Vpw==
X-Proofpoint-ORIG-GUID: i2s7GpnLKc0zORtmBp4Xx_1X7ZpycoGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300114


Thanks for the review.
On 26/06/26 22:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Use-After-Free vulnerability due to lockless access of `dso->long_name` in `dso__is_kallsyms`.
> --
> 
> commit 9c2571a16a38ac5caaaeb737772bc4cd229c357c
> Author: Tanushree Shah <tshah@linux.ibm.com>
> 
> perf dso: Fix kallsyms DSO detection with fallback logic
> 
> This commit fixes an issue where kallsyms build-id symlinks fail to be
> created during perf record/inject because the dso_binary_type is not
> yet explicitly set. It falls back to matching the long_name against
> known kallsyms strings when the binary type is not found. A strict
> validation function is also added for guest kallsyms to prevent path
> traversal attacks.
> 
>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> index 2916b954a804b..884cca37753c4 100644
>> --- a/tools/perf/util/dso.h
>> +++ b/tools/perf/util/dso.h
> [ ... ]
>> @@ -924,8 +959,28 @@ static inline bool dso__is_kcore(const struct dso *dso)
>>   static inline bool dso__is_kallsyms(const struct dso *dso)
>>   {
>>   	enum dso_binary_type bt = dso__binary_type(dso);
>> +	const char *name;
>> +
>> +	if (bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS)
>> +		return true;
>> +
>> +	if (bt != DSO_BINARY_TYPE__NOT_FOUND)
>> +		return false;
>> +
>> +	if (!RC_CHK_ACCESS(dso)->kernel)
>> +		return false;
>> +
>> +	name = RC_CHK_ACCESS(dso)->long_name;
>> +	if (!name)
>> +		return false;
>> +
>> +	if (!strcmp(name, DSO__NAME_KALLSYMS))
>> +		return true;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but lockless access to
> dso->long_name is a systemic flaw that could lead to a use-after-free here.
> 
> If a concurrent thread modifies the DSO (e.g., the event processing thread in
> perf top handling a ksymbol register event calls
> machine__process_ksymbol_register() -> dso__set_long_name()), the old
> long_name can be freed while the UI thread is executing dso__is_kallsyms()
> and performing this strcmp().
> 
> Is it safe to expand the surface area of this pre-existing lockless string
> dereference into a function that was previously safe?
> 
>> +
>> +	if (!strcmp(name, DSO__NAME_GUEST_KALLSYMS))
>> +		return true;
>>   
>> -	return bt == DSO_BINARY_TYPE__KALLSYMS || bt == DSO_BINARY_TYPE__GUEST_KALLSYMS;
>> +	return is_guest_kallsyms_pid_name(name);
>>   }
>>   
>>   bool dso__is_object_file(const struct dso *dso);
> 
Since this is a pre-existing issue and outside the scope of this change, 
I will take this up separately.

Thanks
Tanushree Shah
