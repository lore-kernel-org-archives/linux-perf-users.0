Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F0219ED;
	Tue, 17 Sep 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726570703; cv=none; b=kA5uR6xNXvhy/aB/24aSBUgvgHnHQ6R6497bfE/X24zGYZ3mDfvxs2NkD46ajUXS8H0Pf/AMfagTwXn1sZIk+mWuZ1giwOs91YLDSjGu1XV6WjwrnpUJuJp6hHVfZXBZTg1ACs1JFAparpzfEuidCvf8ImZuynKHkLGcjb66Tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726570703; c=relaxed/simple;
	bh=IzMuiBOejD8SXsFTpNVG/91tA8LVUWgFaCjUbYdAO04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eF48q6VxteR4holmgWjc2Vlzyq/RdTxMvtXhBWinafn2WiIEQ06xskQ1hwbFqaeGRF5NYzIF6I67yJXp4C47x6LLacj3ZsxmJGVsop+vA/Xce78d6Yb8I79Cw5Dgb0Mo+6fZgAJ1TVMx5mMtofcfFPRM38dOmwNsoqb2a7BmziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UjW0AdMG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UjW0AdMG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HA4l1f031051;
	Tue, 17 Sep 2024 10:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=0dFKfQlU63J4x9Kv0Trg8wyXx2LL9Si9gsosnZgyWyM=; b=UjW0AdMGQGmN
	cM1ND9pbD+V2+N2WECErqPNiFxuqdS5PbkAhPmYa1BWgv9Mjgx6RGpHiQtFUaRVN
	+X91mEz+bOph20TPzRmuis6nx9UxEQ+vTBIVumZXzsUXsu9yr7mcGWBxzdsRQt7v
	E914pKhVLnVYUMULFPwwnJ8YbFa1pVgkLIocR8WJIxKDEPDdw8NxJiv/kUDMAfTK
	z8Kycw+6VoeW3uJM+pjdYtIvLczgn4FxX17XvRYI2FWHCO1ZVoKUe5yW2Mkzeyhs
	vBMgjN1dyrWkGoZ2tMtf/fCtm250kDUs3anqG2zeUXVOfoG+uWZCohA3S5hc+6gL
	PGmL0MLdXg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnq3cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 10:57:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48HAvjnh005102;
	Tue, 17 Sep 2024 10:57:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vnq3cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 10:57:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HAcNoS001823;
	Tue, 17 Sep 2024 10:57:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nqh3md42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 10:57:47 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HAvk1b22479570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 10:57:46 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65AE058052;
	Tue, 17 Sep 2024 10:57:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5B0C58056;
	Tue, 17 Sep 2024 10:57:37 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 10:57:37 +0000 (GMT)
Message-ID: <af4000b6-02c7-4160-8207-57f34239bd49@linux.ibm.com>
Date: Tue, 17 Sep 2024 16:27:36 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] perf sched: Introduce stats tool
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: irogers@google.com, namhyung@kernel.org, acme@kernel.org,
        peterz@infradead.org, swapnil.sapkal@amd.com, yu.c.chen@intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
        bristot@redhat.com, adrian.hunter@intel.com, james.clark@arm.com,
        kan.liang@linux.intel.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, juri.lelli@redhat.com,
        yangjihong@bytedance.com, void@manifault.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
        mingo@redhat.com, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
Content-Language: en-US
Reply-To: 20240916164722.1838-1-ravi.bangoria@amd.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240916164722.1838-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W9Xwj_4eqYQ3okMpBkE-XElKP-zJsmJQ
X-Proofpoint-GUID: 80uqf8cxpmRt6lT6KPzkgGTyepYm4-gR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170076

Hi Ravi,

On 16/09/24 22:17, Ravi Bangoria wrote:
> MOTIVATION
> ----------
> 
> Existing `perf sched` is quite exhaustive and provides lot of insights
> into scheduler behavior but it quickly becomes impractical to use for
> long running or scheduler intensive workload. For ex, `perf sched record`
> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> generates huge 56G perf.data for which perf takes ~137 mins to prepare
> and write it to disk [1].
> 
> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> and generates samples on a tracepoint hit, `perf sched stats record` takes
> snapshot of the /proc/schedstat file before and after the workload, i.e.
> there is almost zero interference on workload run. Also, it takes very
> minimal time to parse /proc/schedstat, convert it into perf samples and
> save those samples into perf.data file. Result perf.data file is much

per.data file is empty after the record.

Error:
The perf.data data has no samples!

Thanks and Regards
Madadi Vineeth Reddy

> smaller. So, overall `perf sched stats record` is much more light weight
> compare to `perf sched record`.
> 
> We, internally at AMD, have been using this (a variant of this, known as
> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> of any scheduler code changes[3][4].
> 
> Please note that, this is not a replacement of perf sched record/report.
> The intended users of the new tool are scheduler developers, not regular
> users.

