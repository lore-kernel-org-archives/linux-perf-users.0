Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F71A317A;
	Fri, 14 Mar 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940470; cv=none; b=me3ZKC5Qcc5j6rP8Ow0TzHb5BGtuMl2qPcgZ1zGCM4xnPMEJIoSDLzmedWmkOtZohrXkO4kxw3AkcazPK/be/ca8+9z+GvYhVv7vSeLnqVwUhfaMf23KoPx8NR0+eFzFQJc0nyueqkv4EsGA3r3B/nPXxNF+XFLnnbOcWslfZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940470; c=relaxed/simple;
	bh=APocdxWic3wcmYJIWYvP7OT2+DhSgNE+HRKba5vzeZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6xXCmV958bvBhGZQTO3FjWzvARXRO0DEzpcJVjrq+LLGxKFgo0G/tcJjkcsPtyLB49iAiQoiCyB3COXOTSpb1VAhRDVFtgEH9ewjEVz4Oc2KsgWQpxwYzJu+x1ribxKNKmjP5FUtFwYejfR3bxBxsaP4jLs2NM5YHd/E+DSEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L+ZrOTHg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+ZrOTHg"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNPZec000438;
	Fri, 14 Mar 2025 08:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aSKmf/
	zE0RFtUDkCAcjTv1jKQGKI/4mOr5Oai3ghZMA=; b=L+ZrOTHgt2Z418d6TFSMqq
	EgvjbMwJE3GspVGmSRDHnHwHydCuyKWD40KGbdC2kxZA70DISc9VQLZHDWbvMGLg
	flXgSzjlxbGfPLqiFOgRinakoSfpkVqQA93Wf/tDCAE8bfdFXFVI2cboG6yyVga7
	hTYkTQKgunxddPBMQIojHjoOJTupYncWezLYHgwjmpR4e+Kr089Hm4o/0ha4vXA8
	dq081yjobpRZYFerMzvfg7vgQ6q+XAR9mKRBA0+MVpoP+zvHVTH9Apkf99miXKjJ
	GnnYyEgapRmLrVrR01SsdcnOmAEiuQDUcBgXnuA0rh6A0+kF9/Bmzp9SCOrJ9AXA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpth3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 08:20:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E8IYeB005869;
	Fri, 14 Mar 2025 08:20:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpth37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 08:20:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8BhiJ026010;
	Fri, 14 Mar 2025 08:20:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspp1jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 08:20:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E8KpB650463166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 08:20:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9E6D2004B;
	Fri, 14 Mar 2025 08:20:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8120B20043;
	Fri, 14 Mar 2025 08:20:48 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.204.206.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Mar 2025 08:20:48 +0000 (GMT)
Date: Fri, 14 Mar 2025 13:50:43 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com
Subject: Re: [RFC PATCH 0/3] Introduce a C extension module to allow libperf
 usage from python
Message-ID: <owus55cwihmlvqjcphymjvfinpag3pem4qnn5xkkk3wl6o3ffs@tgycw7azoz2p>
References: <20250313075126.547881-1-gautam@linux.ibm.com>
 <Z9LnuXCvK5P5KCiU@thinkpad2024>
 <CAP-5=fWjca+SMBdsyPe8Ggsqrqz=ZzWqxDYhaF+pcYk0MJ12zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWjca+SMBdsyPe8Ggsqrqz=ZzWqxDYhaF+pcYk0MJ12zA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hO4L7x8o7D5JNM-VijRdUCAD2s41EPDz
X-Proofpoint-ORIG-GUID: DIJAfDk65UApmVbLOCxZmh9WQYvxFxNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140062

On Thu, Mar 13, 2025 at 09:01:10AM -0700, Ian Rogers wrote:
> On Thu, Mar 13, 2025 at 7:12 AM John B. Wyatt IV <jwyatt@redhat.com> wrote:
> >
> > Hello Gautam
> >
> > On Thu, Mar 13, 2025 at 01:21:21PM +0530, Gautam Menghani wrote:
> > > In this RFC series, we are introducing a C extension module to allow
> > > python programs to call the libperf API functions. Currently libperf can
> > > be used by C programs, but expanding the support to python is beneficial
> > > for python users.
> > >
> > > The structure of the patch series is as follows:
> > > 1. Patch 1 : Create wrappers for the perf structs which are used by
> > > examples/counting.c
> > >
> > > 2. Patch 2: Create the C extension module that maps and exposes the
> > > libperf functions to python programs
> >
> > May I ask why you are not using SWIG? With libcpupower the kernel has
> > already been using SWIG to generate Python bindings for a C user-space API.
> >
> > This has several advantages including a much smaller footprint (you only
> > need to copy the header definitions into a .swg file), can generate for
> > several languages (Perl, Ruby, Java and C#), and SWIG is an active,
> > tested, and mature piece of software code that has been around for
> > almost as long as the Linux kernel.
> >
> > Python bindings including the makefile as an example:
> > https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bindings/python
> >
> > How to use the bindings in a script:
> > https://elixir.bootlin.com/linux/v6.13.6/source/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
> >
> > Original discussion:
> > https://lore.kernel.org/linux-pm/20240724221122.54601-1-jwyatt@redhat.com/
> >
> > SWIG has been pretty useful as it helped me find two issues in the
> > libcpupower API that have been around for over 10 years:
> > https://lore.kernel.org/linux-pm/20240905021916.15938-1-jwyatt@redhat.com/T/#mf04b4ba93f79fe68c20c1d88d8ed966164a1c7d7
> > https://lore.kernel.org/linux-pm/20250305210901.24177-1-jwyatt@redhat.com/
> 
> So I think we should probably get rid of libperf and re-integrate it
> back into the perf code. There are issues in the code, like removing a
> list element:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/evlist.c?h=tmp.perf-tools-next#n58
> just leaks the removed element. Deleting the element means that the
> container evsel, rather than the libperf perf_evsel, leaks things like
> the name variable. We can add yet more call backs and complexity but
> I'm not sure what we're winning. Perhaps we can move things the other
> way, perf code into libperf, like machine, session, pmus, .. I'd
> prefer if we were to do that we refactored the code and adopted the
> same license as libbpf as both libraries have similar packaging
> issues. The viral GPLv2 on libperf is something of an issue. Perhaps
> we can also migrate this code to Rust.
> 
> SWIG is fine, there is also CLIF, I'm way of dependencies as even a
> python dependency in the perf build is optional.
> 
> We already have perf python bindings, and I've been working to extend
> those for example in:
> https://lore.kernel.org/lkml/20250228222308.626803-1-irogers@google.com/
> and I've been working to expand those for things like hybrid CPUs. It
> seems a shame to reinvent all of that logic again on top of libperf.

Thanks for the feedback and pointers. We'll look more into this
approach.

Thanks,
Gautam
