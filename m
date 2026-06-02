Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61635F8D2;
	Tue,  2 Jun 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426399; cv=none; b=ZovgBBGXhvWR9KzbMHr72rduEGwcTAONd7Zlgwzxt8Ppj17QBuuj4pXHg3JiwpjXOHI/i8MVegqGHUJti8IlRTTZ9beBi3DJ3Mvhrz9hUGBR14zHR1BYXV52Rw+NHybQyHj/si7QtSxQnrHWWjzJP90hmEA0/WIk/C7eMCpYDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426399; c=relaxed/simple;
	bh=bsBaAFW5KFDPCS7BWhRLnXMd0ijq7QTvh6ovcADRCtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCdY8Gjm0v+I4nfLLiFB1EW2QW5GicOyqy34ogSjNGZAjaaTYmt8gP1nlX7ZakX2949GcKtwYqyR1OtnR+FZG0bpJEpaqGxT8aP+wi791e0UJ67FrCLa6OGrLq/9L47xyKQ4lgr+uVB1dnnV+jARn9V0VzLQzhOmqYWvZ7PL0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oYAZiV28; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oYAZiV28"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652G60XL867987;
	Tue, 2 Jun 2026 18:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Q46lrmNrTGJ+dKM/VnbaqCfJEGKxV3
	4VeTHbA8t5EDY=; b=oYAZiV28vSX68GTi0zVQ9iRNfWLIRNa5Wt1zH03PLJ+JiP
	PGbYWhRBiZdbdibh6AlWXNH9n1bHkjgLR42h/mn/aBJBd1pytnCLYXgParOdKyfh
	oW0Cv2HRbqFyhOdUTn533CZE0050b/4b402z6hFBeoL6VRO6bHEWz2ObU1aeShyb
	kon1J4rB3wWyPzeTerpoHmTw8KAhAFZCf8FET6DWpu0hOkOUBNwmy/VWI/CoK4od
	KWH8LVl3psdF5f5Rttj5OY8qpUiXjsoaoQQhCI9rA43D4XVUWMgRM6Ggj0QiABzo
	sOR6SXps1w0V7WZAmQpterDBZhc+wFQK3RZxadJw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq7g3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 18:52:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652Id70M030955;
	Tue, 2 Jun 2026 18:52:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k4qyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 18:52:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652IqpB219988824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 18:52:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C2DD20043;
	Tue,  2 Jun 2026 18:52:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCEFB20040;
	Tue,  2 Jun 2026 18:52:47 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.124.222.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 18:52:47 +0000 (GMT)
Date: Wed, 3 Jun 2026 00:22:46 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf kvm stat: Add missing mappings for PPC kvm exit
 reasons
Message-ID: <20260603001958.2cef17b3-18-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260518125041.39286-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518125041.39286-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: a_F3W8FoECoIlI5XTk3mlvMAzxA1vhC5
X-Proofpoint-GUID: -4fVPeTZ0_KzV_xhVEBMouu9mGijdmyQ
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1f2688 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=HR90um4bXCwT2XOkuecA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4MCBTYWx0ZWRfX5KxSReVvoaTw
 7Xtyy4YuAbh5W8PRv0TlPCi71hGbsEOPvq1s18SIMYy7WCfs4zFTfcE7VQ2AuJTVXr+/50P4L55
 HqRIOoUrmiQS6kmMtyomHGrTxDoMLeNwem/aXFx+y02LC5+o1iDQlESugbXWbQnw65pqLAYWIQB
 tvKe/H4naVtYcSPEw9YvhIgILDASYk1c8fnZLAl7Zza2tHCweQxn0xH6xOkx6mlf1SmVtyCaGUT
 oNyGM0QormQTxRZfTme+AOZBBW+6pqGx2S+OyMHufjxhZ5v0OrjCdomoCRhgmbQ4O6JyFnyV9qz
 2kvZ1IL70gKmp6iOLA33pNlsrVYbOfx9NL6dA0G/uBKfteZlM2RPH1EZxgNZr+cdwxruk2xU/49
 x2l90UE5yI8U5eJGz8rYipqlP7IB09GHGA/C9xqxCEXFZs/WqEi7/EV+AAHXazZj8/oJ7/FzIbR
 wNZ0QQ8Pf9M3f0M4wJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020180

On 2026/05/18 06:20 PM, Gautam Menghani wrote:
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the exit trap vectors and their names. Add mappings for H_FAC_UNAVAIL
> and H_VIRT so that exit reasons are displayed as string instead of
> vector numbers when using perf kvm stat.

Do we want to make a copy of the existing header in perf to keep things in sync
with check-headers.sh as suggested by Ian earlier?

Thanks,
Amit

> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Update the patch title and description to remove dependency on
> another file trace_book3s.h
> 
>  tools/perf/util/kvm-stat-arch/book3s_hv_exits.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> index 2011376c7ab5..2688ca7d0399 100644
> --- a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> +++ b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> @@ -26,8 +26,10 @@
>  	{0xe00, "H_DATA_STORAGE"}, \
>  	{0xe20, "H_INST_STORAGE"}, \
>  	{0xe40, "H_EMUL_ASSIST"}, \
> +	{0xea0, "H_VIRT"}, \
>  	{0xf00, "PERFMON"}, \
>  	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"}
>  
>  #endif
> -- 
> 2.53.0
> 
