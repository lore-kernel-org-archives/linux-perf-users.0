Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CD14A4F5;
	Thu,  9 May 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246426; cv=none; b=eBS+izAeQCHGigXUuMFP51N8lSF417Vl5UsL8GFsls9NCpc+ZgP0JMKgQ5D9drZ4k7/T46syzwsscpHhq9CFSgJyVQxAx9k3QZ+7Nfy/iUbCFRuoXY6bsBDp8UlKPwExVtXSbLovrZJdZsdi3Vn5QG+NZXnUFOKsFOF/Bw6xWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246426; c=relaxed/simple;
	bh=5rpSr7Ybn4FuugiTBduCab0kHB71LSTX+pO9YxOqoTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvIWoroALlftPg3oJrCOPUdUog5xPOyMFo3Du8OlZRn2BrkxZv3KrxIHBU0Gk1Hthah/HJA74yqzFUDTRc4hb89vuhrfepWTk7MXAuCPZfafoJS08zJ9wI5hpmXsWaYnJgXJL6dHTAltG+0QZd2wQCi6qIZnO7c6lR5BLCKdb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YphcUNl/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YphcUNl/"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44993kQI010776;
	Thu, 9 May 2024 09:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6ZQgaWALZN0CtOTRXnpZfUTg6hqELQ8osXjMUy+R0QM=;
 b=YphcUNl/msyenbtnuL8giUj1/AJOWu5KMlsOSoCm37bWR78g3ITIsmwKX4IIMHM2tPgc
 QdpUD0klmDyN03EhDavxmCVNp9XxcKTmUMvgUJ4oFKr6IR9e5uwtyTm+t5S9OAdfQLIr
 FNWZCUBNrjXn217wUP6g+o/JhU7GQx/QhGX+iJZMEs2QBge5Y2bXIuT+7BfPrrNYS8Hp
 EFN7+wZYjqvxLESOogRHZoQWEjIhpcuG0wMWwDXNLR7/hBKQCohC2i4XX6ffDStAIO8R
 EdE3XPQyFgZIWZU4R2XyGJzsiMK6tK+4DGoRVkSMaVHCJSd0CBQlAk0HPbL78gHtZrCH vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0ugp80ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 09:20:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4499HUMf030711;
	Thu, 9 May 2024 09:20:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0ugp80yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 09:20:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4498S4ED009823;
	Thu, 9 May 2024 09:20:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xyshusy15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 09:20:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4499K25E25428640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 09:20:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1E7A20040;
	Thu,  9 May 2024 09:20:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EFEF2004E;
	Thu,  9 May 2024 09:19:59 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 May 2024 09:19:59 +0000 (GMT)
Date: Thu, 9 May 2024 14:49:56 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched: Rename switches to count and add usage
 description, options for latency
Message-ID: <3buy7zyybshlphybersfof2acjcbrpxllrcvobizwyse4356nd@7sp74wyxbbfc>
References: <20240328090005.8321-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328090005.8321-1-vineethr@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3O8cVxwZCUAFIwm17-iVxCBqhTHU7hNF
X-Proofpoint-ORIG-GUID: lDPzNrU9-GgNAV8nBMSv-DVGGoG2whAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405090059

Hello vineeth,

On Thu, Mar 28, 2024 at 02:30:05PM +0530, Madadi Vineeth Reddy wrote:
> Rename 'Switches' to 'Count' and document metrics shown for perf
> sched latency output. Also add options possible with perf sched
> latency.
> 
> Initially, after seeing the output of 'perf sched latency', the term
> 'Switches' seemed like it's the number of context switches-in for a
> particular task, but upon going through the code, it was observed that
> it's actually keeping track of number of times a delay was calculated so
> that it is used in calculation of the average delay.
> 
> Actually, the switches here is a subset of number of context switches-in
> because there are some cases where the count is not incremented in
> switch-in handler 'add_sched_in_event'. For example when a task is
> switched-in while it's state is not ready to run(!= THREAD_WAIT_CPU).
> 
> commit d9340c1db3f5 ("perf sched: Display time in milliseconds, reorganize
> output") changed it from the original count to switches.
> 
> So, renamed switches to count to make things a bit more clearer and
> added the metrics description of latency in the document.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Makes sense to me. 'Switches' seems to be context switches, so it might
be better kept as 'Count' only.

Hence,

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
Aditya Gupta

