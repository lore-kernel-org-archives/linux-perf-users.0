Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6612F5A1
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744217; cv=none; b=IVOGfPPkCYTTWB2jPxSnOW4cGbbny/v48y1+IX7gQL2nYMv0jVWvvNils2XfaP5rSrGPT9UdWpQi9INEbzArT4LIcc/XO7BNZTpVnXCWJGcsO8d6gOehyx1d/3rYUdTKG393xl/fKitV+S/F3nUl7NrEJGpa7pFsuhXpKDl/d9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744217; c=relaxed/simple;
	bh=Z7ZpE6dHogB31FJkTEpmQZoVlftKTYPnspBud8ZZX0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iXwW/3sOHWBkLP18xvpBWbbFAqCIc86Gc8TpbZlL7zytpQij42eFzu0YSwESR7/SosTanCWwPRj1WHBp1wqVybv4RIKz6dbINU91QmqCvyVkpbFqBtnybWeDJXnQOUeX3NsOPgsX/wvwQ0shBOMt8wfsKdP9IY9t8H0H3Dgu8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AuvoahSm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AuvoahSm"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UAR0Ck005615;
	Sun, 30 Jun 2024 10:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:content-transfer-encoding:mime-version; s=pp1; bh=l
	j8plU7kst4qqNkt/EgqXAEcVb2tsgDnWg97kuGJm3U=; b=AuvoahSmKksi6ZSPz
	64hEbepWkmexP21Lj2gsB/79xdAkEZMU5J3xBFCEt69N5RjkI+g+SW8AZFJWkj5g
	TkLxKHZ6AwdHH7vEGACFOIvvaNtKeWLr7Jc6FyvK4FoF/s9lgKz/bUBTY9wjxaGN
	ROV+DgBuCd00VCTr5i915LevLzSwrlXqitW1TSd7nnPQO1pFCOQ8+7BgWMdL39Qb
	K5oYHdHLL9Saq6KvsutrsyLrY8cKp/Jm8wKnwELD8WFdpM6V6CoJNu2HOpldt39V
	qqmhAb+entH6dgkjauvxcenMEfLG3y0cW4KhLrpHF5IXUae/WE68lYGkiO/Dc20Y
	lIZ2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4033vm878s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:43:32 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UAhWKw029485;
	Sun, 30 Jun 2024 10:43:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4033vm878r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:43:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45U6j5gu029195;
	Sun, 30 Jun 2024 10:43:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402x3mhp35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:43:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45UAhP1534734456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 10:43:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3895520043;
	Sun, 30 Jun 2024 10:43:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BD7920040;
	Sun, 30 Jun 2024 10:43:23 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.221.162])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 30 Jun 2024 10:43:22 +0000 (GMT)
Date: Sun, 30 Jun 2024 16:13:20 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <wdcwubiscw22qko2ok5am3l7rxplnqwvea2ru632xkjlvpjzr5@36zlvfs5zqzq>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1>
 <Zn7GsEKwLxn5bMyN@x1>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn7GsEKwLxn5bMyN@x1>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X6BOgS16VkfpJGMPuFNZkLf1ojLf4827
X-Proofpoint-ORIG-GUID: oTASul-hvEQb1ov1j56iOn4dkSw9Tcv5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxlogscore=591 impostorscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300081

> Ah, to clarify, these comments are for the v12 series even being replies
> to the v11 thread, I'll move to the v12 e-mail thread. Using b4 I got
> the latest version, v12:

Sure, understood.

Thanks,
- Aditya Gupta

> 
> Cover: ./v12_20240628_adityag_introduce_perf_check_subcommand.cover
>  Link: https://lore.kernel.org/r/20240628064236.1123851-1-adityag@linux.ibm.com
>  Base: applies clean to current tree
>        git checkout -b v12_20240628_adityag_linux_ibm_com HEAD
>        git am ./v12_20240628_adityag_introduce_perf_check_subcommand.mbx
> ⬢[acme@toolbox perf-tools-next]$        git am ./v12_20240628_adityag_introduce_perf_check_subcommand.mbx
> Applying: perf check: introduce check subcommand
> Applying: perf version: update --build-options to use 'supported_features' array
> Applying: perf tests task_analyzer: use perf check for libtraceevent support
> Applying: tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
> ⬢[acme@toolbox perf-tools-next]$
