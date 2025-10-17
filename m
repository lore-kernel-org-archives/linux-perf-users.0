Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9C339702;
	Fri, 17 Oct 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710894; cv=none; b=Mgf82hvqUG9qsFl3t/UEmmKT6AMsjbax1vQUD5upAVtB+Tv8DUw2gx+eazMxIJbTLnePhE/0Mx5zamXCV8kCbmswH3iKvFOuwv0+eAdH96nlsDsKjVsN4VRXzYv6EiwohX6nODMW34ouhvSrKPS+2p++WUQKgfMJyY+bHozuCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710894; c=relaxed/simple;
	bh=OHRE0uUg2nN5buzbZtL3nz9GjqwMqeEhTwMOzl5rZ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj641gN+mR9nzi0dNISGVuctTPT7isuikvoTlUMb6whMncU2MIEHJIlVUblbrA/0HRA3jxrAQ2pe/E/cChtn+wNne4oTl+sNY+aZmbVoiQIx8uLjPLDoghpGBDV+6NREii2mb9hCb1+nbJU2ll5zkC5/t7wmUk782MIVXWtUndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Czgf+Zii; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Czgf+Zii"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCfA62010243;
	Fri, 17 Oct 2025 14:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3jXNHNgCV3IkdKIXbAH1GuYsgBTZvN
	+r4fugYXz/4yw=; b=Czgf+Ziiczod3T9wWISgJVeBgMqPkvRF6Rl5CXbNvfgL4t
	B5rEpGk2TpXPIxYsZASLhxcBMrLooHKwolfrQW6dziAl84haSrfmhrwUE6m7Uh2N
	awxpBc9cLrO9t7TtTscg0WjmE2ub3UFGcHJf5Fb/fTjox2PJXBjEfXf5Hl+3NpVN
	goSUERSYkpK5Fraq4csTEseKosnwFyO+HxGa4zIgesghYU7/K4e4/Wlr3HF/WYP2
	ER1LESnnJUxZtB7Ndkkc7KGLXcVhahFUyA0MLk6RBV/SGuyTk+mA/BurNlEGQh/R
	5fQffy/Ugiu2BhsNvEbHkU5bJtOXPuZiah5g95pg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewuk6bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 14:21:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HEBUbc006904;
	Fri, 17 Oct 2025 14:21:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewuk6bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 14:21:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HD1YB2015002;
	Fri, 17 Oct 2025 14:21:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjwew8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 14:21:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59HELF5f44564756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 14:21:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 101C52009B;
	Fri, 17 Oct 2025 14:21:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C805620099;
	Fri, 17 Oct 2025 14:21:12 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.28.209])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Oct 2025 14:21:12 +0000 (GMT)
Date: Fri, 17 Oct 2025 19:51:03 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Howard Chu <howardchu95@gmail.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] perf python: Add PMU argument to parse_metrics
Message-ID: <aPJQz475v3OmCqEl@Gautams-MacBook-Pro.local>
References: <20251016222228.2926870-1-irogers@google.com>
 <20251016222228.2926870-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016222228.2926870-2-irogers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3vyHl5SNsbVIZLWzszTQqzhaHm7mQSP1
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f250de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=BEo7XnksbjeIKY7Z5mUA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: RHXD2D7xegmEeMPsc1wu5OID3hrfLdge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX/DAkEZqALFLA
 ewzwr/jnjt7RpDNaShotjOf/t8xgQ6jnBwqmyAk7/AoqsXsFO1UrFBWo0838pXQ4Ruq3mX3Gxul
 VWO7S5E2No/uU4GgkHR6mxn0JqlROz4gMw7hQx63sOrRrtJVY1JJDMxjBnWU6J2DtQKmXqiGTrZ
 N6YOSqnoj8gGuyYdelsDCQ8eSj0z9W7Gn1zuc2EvzFjEDtgf0p04shvGaq8GcIkyoUUVD94xw2l
 NLcgPQzJs5CVhM9u5wVHA0/zYudVDmtbyAl/H+zznlaj//DmLifUG82ikRfhbsVQpAJrZ4e3WDo
 nUhCWMdCTkkX1CT3b6g6FBVcvYkaf4p+Y8lXxzD04g3LrHsysxIe0t8th6fk7EiXnDVFWqnOf+k
 6mTH9XZRK1B0ovNNPhpkSA5OnA7umw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

On Thu, Oct 16, 2025 at 03:22:27PM -0700, Ian Rogers wrote:
> Add an optional PMU argument to parse_metrics to allow restriction of
> the particular metrics to be opened. If no argument is provided then
> all metrics with the given name/group are opened
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 779fe1280a56..fa5e4270d182 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2051,7 +2051,7 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
>  
>  static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
>  {
> -	const char *input;
> +	const char *input, *pmu = NULL;
>  	struct evlist evlist = {};
>  	PyObject *result;
>  	PyObject *pcpus = NULL, *pthreads = NULL;
> @@ -2059,14 +2059,14 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
>  	struct perf_thread_map *threads;
>  	int ret;
>  
> -	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
> +	if (!PyArg_ParseTuple(args, "s|sOO", &input, &pmu, &pcpus, &pthreads))
>  		return NULL;
>  
>  	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
>  	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
>  
>  	evlist__init(&evlist, cpus, threads);
> -	ret = metricgroup__parse_groups(&evlist, /*pmu=*/"all", input,
> +	ret = metricgroup__parse_groups(&evlist, pmu ?: "all", input,
>  					/*metric_no_group=*/ false,
>  					/*metric_no_merge=*/ false,
>  					/*metric_no_threshold=*/ true,
> -- 

Acked-by: Gautam Menghani <gautam@linux.ibm.com>
