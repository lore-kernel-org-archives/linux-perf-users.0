Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9278145329;
	Fri,  8 Aug 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651666; cv=none; b=o3ZAS4XAz+wkNswJhHf6Qjb5LCRP/yP81uRsorLWhsXiP+DaF4Zeq7o8u8HE6ELm9zgc6d9C08Uycq0pEzufOazb6jhPhDv3gWKDB8tY9gQz31sTwTmdsZh0VNVHOju9/L/xIXmh342cEr+iWwAHaUzSUcblc+TqgqNL6eGR1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651666; c=relaxed/simple;
	bh=R06DB1k7Nsf6Xd6cNpFhaIM0QPB+aGfks2d2CYwSgfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1iyVwXTsqyIHtlgUCkdHBssBxXFgxaW02xXMJChowp72vrYEACJst/F5TtH3YlUvz5ePeD+i5ou8CxIon0gDNKbU74PjKv87Yao6VhJCxLDSboE9MdX/lW8M1ubJnsePBiLpsn0vquJUVn2QSSii2Ykk3XrWK1UZOJlepAKcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SaoqjUi3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SaoqjUi3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5783BTDv019460;
	Fri, 8 Aug 2025 11:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GjCnjo04A1Cr+U7z0J+HZile9njCaw
	Nwe+p/nblK1Tk=; b=SaoqjUi3eL03/RLGxToniSp7773W2YC5tPkObOxdo/NphM
	WRdSc6qnswm3IJznyBiv+Axe40HmH7CBH8HK0/ziqTav5/TROzv5N4+5lRP+Evck
	G/t3JUBtZgitYx8V7WTDD1ujFxkMQU13S3AT27pW0Q6bpPimRdOwc7lScWQtncvD
	bW+lMIAGGmzmUzQzae3e9jaFY/muTmzHixqGPwnIss9J8qmmuHe5DCD4dohYguNq
	5mvJSmikmzJsKuVm7NnARF60Mk3foAIrPAVxSbv35C2Mph09RSZNgWXs74JgWpac
	bxm5AbmxMHVs4PzjRRPlHukgX39xbEN03Ljnk+RA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u5bxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 11:14:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578BBmkj027700;
	Fri, 8 Aug 2025 11:14:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u5bxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 11:14:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578A3oZ1025897;
	Fri, 8 Aug 2025 11:14:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwndc4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 11:14:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 578BE9JK34341516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 11:14:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D73D12004F;
	Fri,  8 Aug 2025 11:14:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5BDA20040;
	Fri,  8 Aug 2025 11:14:06 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown [9.39.29.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Aug 2025 11:14:06 +0000 (GMT)
Date: Fri, 8 Aug 2025 16:44:03 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Avoid redundant NULL check in
 auxtrace_mmap_params__set_idx()
Message-ID: <20250808164216.a982f3d0-5d-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804110602.23422-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804110602.23422-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MP8F7KRGLUVyWRI-RkwoKFBAcnRaOp8s
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6895dc05 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=3B45m_xtiCOFTJ9Nk4UA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5UzG9qcwQ5UN-9JpAfdtjsBwdw8qfKPa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA4OCBTYWx0ZWRfX/gOXPhA3RnU5
 py+sgm093ddNkpyCFEa1HTXepX0h+jOCfXg1Qoq8UDKc9yIxvE4yTD6/qmvFkUOSKlKPASX2YI1
 C1J7d+DQ2zVH1oNDYoA4x24++kDo935jv4ThOiOuq65VlvFXpp4Oqm3WDcYkmfvuRGNedvS+tJR
 nfckgZV23L0ktFK3PJF47hSVWrHgu7uGbJ22OYrmU9zk4I5KngSvUj5q9eiruVMJhuNpSodIOL9
 bQUcei5iAMjxzbVuICF2h6SU8p8Gg8JFVxgAo3r1/rdQ5qLjMWAvGNX65JDKeYT7XLk4VYOQEQP
 TFjJTgi5hsAAEDHbEUDF+D+0ciwntr53bj01t4glhNTh/O3y5xbfzAqE8W/giR3b/b8bwQHkFVT
 0jFg8YFZJCxGTsQsu1xtTG5xiU6Fw1ovj8ZP0UmxPtB0W+ad0I4a4Q5g90yFMOeOGZjJ+C1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 mlxscore=100 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 spamscore=100 bulkscore=0 adultscore=0 mlxlogscore=-999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080088

On 2025/08/04 04:36 PM, Gautam Menghani wrote:
> Since commit eead8a011477 ("libperf threadmap: Don't segv for index 0 for the
> NULL 'struct perf_thread_map' pointer"), perf_thread_map__pid() can
> check for a NULL map and return -1 if idx is 0. Cleanup
> auxtrace_mmap_params__set_idx() and remove the redundant NULL check.
> 
> No functional change intended.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

LGTM.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Regards,
Amit

> ---
>  tools/perf/util/auxtrace.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index ebd32f1b8f12..5e437133c753 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -185,10 +185,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>  
>  	if (per_cpu) {
>  		mp->cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> -		if (evlist->core.threads)
> -			mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
> -		else
> -			mp->tid = -1;
> +		mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
>  	} else {
>  		mp->cpu.cpu = -1;
>  		mp->tid = perf_thread_map__pid(evlist->core.threads, idx);
> -- 
> 2.49.0
> 
