Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D4320298D;
	Mon,  5 May 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445904; cv=none; b=Bt4xHEnzJ1tHdUe/UfIlsVTPudctiLM8QxTyGbMT7Qh89FoaYXIoN/y4EoqpWSaElaMNJmGP9jn9ae/+FGgtn9T3EvYjPyqKewM8c1UWJlsHM8bGO5ODVF+/ss8i7DmvOcO5vjmi5RLIRK/yjWEjxYVCK87rc5UoY7Hdwj5GEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445904; c=relaxed/simple;
	bh=FQZr1U9JLAw5KgfFXqZlRJ+sQz8gN2OMKUqjKLKRjQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gumBi8nPgUPabjxqHHqusVS1zjFrClC9ult70UbldmNLzRolmYoKPIwE9w+BGW8v7ODQutMXZvt6lz4IHopfT4BMMPsCJHDeeEKt8KT4KCDzFcgMvrDLKcbpNvt3iA/U6ihUQERk4PX6VzJbBFBUtEZO9bHBCG9SYHqxcYcLWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VE7am65/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VE7am65/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545Bj5gX005583;
	Mon, 5 May 2025 11:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NbAyJm
	9Y+YfaWYhzS0pcUnwJ6XAa1Ucras3HhsFwIjo=; b=VE7am65/a2xL70wGgQvinz
	TpAZo7XFdQy5DqMIOjDi7K6bW8ifDnif2mYs6SZ67XC4S18D6dQcsS0tfilFLiHL
	h8zxRtHR2RUUEuYbJoezPWJ5b+L1VzBef21x3r/Ocq8EJnwc+3e4HdWK70zymD2q
	T8PRX6tlbBEXsY4dtMIfiVVTvJRFHs6PbH8Zy0T2xUHyn+qr9kz9Jk8iGPBo2QKS
	HAKD8NYrw7brhaDy4jtF/9rKFvMmnYcvC+cOV2pTIdLtNIB3AvbMbaYamezDket4
	i15XF/pz4feqWwqDchV4wqBnBOtJQixTMyyAivWuINAxwaQt0SjL9UtKG1qUpY/Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ej6ytd6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 11:51:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 545BnRWJ025788;
	Mon, 5 May 2025 11:51:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ej6ytd69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 11:51:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5458c23o014122;
	Mon, 5 May 2025 11:51:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkdtjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 11:51:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 545BpMRg43712996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 11:51:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 748B42004B;
	Mon,  5 May 2025 11:51:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F35120040;
	Mon,  5 May 2025 11:51:19 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.124.223.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 May 2025 11:51:19 +0000 (GMT)
Date: Mon, 5 May 2025 17:21:16 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com
Subject: Re: [PATCH 4/4] perf python: Add counting.py as example for counting
 perf events
Message-ID: <2xbykwmqdsxdmsewisrp2e6epzaokfuutcbcwtzxar7hy5mstb@cbnkvsjzi6wy>
References: <20250501093633.578010-1-gautam@linux.ibm.com>
 <20250501093633.578010-5-gautam@linux.ibm.com>
 <CAP-5=fW2--aUG9=14R8fqSEJQN-D3PATTwU15czWVsQidA51bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW2--aUG9=14R8fqSEJQN-D3PATTwU15czWVsQidA51bA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2MMRaUiTCMBp2IMoewy7Ol1sOIrlIahJ
X-Authority-Analysis: v=2.4 cv=GKAIEvNK c=1 sm=1 tr=0 ts=6818a63d cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=4PM7ALANNoHl1poGAt4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QHJnRT67wznKJVQb3Dd_sGEEOG35Insg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDExMSBTYWx0ZWRfX8dGOlX2lY9YW y5p4Zyznd6bI1q4yDPiXNT+ocEW1Sz2f6lEpT8kLJXTeTuWvd7mUvJuhHLoOe92jqzBlfOuNE52 zNiaqMe+XrVUexTW0EkCBiAcT87X3Ax+R5AqRUp+UyKQXGxNmwgmcz8CbvmOWmPDFNBH/E9Ste9
 fiTHuPyLe+fak7gFC4hVcMzJTOaBm1YkpH9bVIEAkbWN63Nc++ZPo4yXB3+K5DfT92EKKiXsWlw KYbGLoJewc2TPBh1c5vqr3fqpBjQP5DZDcRpmMUtWDlRRKczqJw6FMRd+075zT3SdzcL9Ho4jki gfnx5XmabxOLvG82M5yq0ZSTBASkAg1Vuz44NNmJm4Bz1MkvHBvdJIOsFj1VIz7ryeJ0kfDfJxA
 CYOgjt5srPLKVf6DtZKaxPGhsAZ4AtdrKzyu6JeYbLs2ANCMX9Fuu8CsyPgjuxjrOQwvRge1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050111

On Thu, May 01, 2025 at 09:04:43AM -0700, Ian Rogers wrote:
> On Thu, May 1, 2025 at 2:37 AM Gautam Menghani <gautam@linux.ibm.com> wrote:
> >
> > Add counting.py - a python version of counting.c to demonstrate
> > measuring and reading of counts for given perf events.
> >
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  tools/perf/python/counting.py | 41 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100755 tools/perf/python/counting.py
> >
> > diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.py
> > new file mode 100755
> > index 000000000000..0c58907bd8bf
> > --- /dev/null
> > +++ b/tools/perf/python/counting.py
> > @@ -0,0 +1,41 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +# -*- python -*-
> > +# -*- coding: utf-8 -*-
> > +
> > +import perf
> > +
> > +def main():
> > +        cpus = perf.cpu_map()
> > +        thread_map = perf.thread_map(-1)
> > +        evlist = perf.evlist(cpus, thread_map)
> > +
> > +        evsel1 = perf.evsel(type = perf.TYPE_SOFTWARE,
> > +                 config = perf.COUNT_SW_CPU_CLOCK,
> > +                 read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING,
> > +                 disabled=1)
> > +        evlist.add(evsel1)
> > +
> > +        evsel2 = perf.evsel(type = perf.TYPE_SOFTWARE,
> > +                 config = perf.COUNT_SW_TASK_CLOCK,
> > +                 read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING,
> > +                 disabled=1)
> > +        evlist.add(evsel2)
> 
> Nice example! Would this be better as:
> ```
>     cpus    = perf.cpu_map()
>     threads = perf.thread_map(-1)
>     evlist = perf.parse_events("cpu-clock,task-clock", cpus, threads)
> ```
> If you run `perf stat -vv -e 'cpu-clock,task-clock' .. ` you can
> double check the perf event attribute bits. For example in
> tracepoint.py we remove the SAMPLE_IP:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/python/tracepoint.py?h=perf-tools-next#n27

Yes this is cleaner, will fix in v2.

> 
> > +
> > +        evlist.open()
> > +        evlist.enable()
> > +
> > +        count = 100000
> > +        while count > 0:
> > +            count -= 1
> > +
> > +        evlist.disable()
> > +        evsel = evlist.next(None)
> > +        while evsel != None:
> > +            counts = evsel.read(0, 0)
> 
> Rather than just reading on the first CPU and thread, perhaps change
> to iterate over the cpus and threads? Something like:
> ```
>     for evsel in evlist:
>         for cpu in cpus:
>             for thread in threads:
>                 counts = evsel.read(cpu, thread)
>                 print(f"For {evsel} read val={counts.val}
> enable={counts.ena} run ={counts.run}")
> ```

Ack, will do

Thanks,
Gautam
