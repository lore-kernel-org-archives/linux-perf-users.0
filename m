Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF03239E84
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969879; cv=none; b=Z9WQyzIqdyufMwAcE9mIDaCdEsF52rh7gZAZ2svRHFt/nSqhJbzxx/qqLGYrQ5IR7UxoUrAEIsZGkRGZm9SoNXbmcEFprfmjP+a8mfOfykPtaQqqTwBi/8SyhlzbSy3WvcD49nHB9Ui0oNuugkJDl6KB65cyWTKOj38j1/T3dbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969879; c=relaxed/simple;
	bh=nXos4Ll3CHpYjZpzFVAIS8h/Xi8ZAkpbw5NpZCSZW48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok7IIeP2J6ktnKjXFl+HofOeZgcjCxsaIUeToyE4FQXXyM4jjFIdt2eP4KYV5d6okCIGnCLvf8qWGD7Ft3aKxsS99zrli2AW5Z77B20WYiZMCEjHqSttEY6ZVW7LZ4WL7mWJhjZ/52xxd8XUn6fc75a2RUmLjk/2Vn5fx90adrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=snMaOmlF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="snMaOmlF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V9ra2i009276;
	Thu, 31 Jul 2025 13:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qvxEQX76mnQOHxi3vSOyjMIlZ7Noop
	uXqOw6QoGaSQo=; b=snMaOmlFxlekw+KiLiVwalA1/vbaeyYXEwUOyKEfvpVNkd
	Dur9LWpC9Lj+s2vxCyQ1nMlrdPHEsagTkZmxZBJF06RMK+VHJ8U7nXFglQZH7VVW
	sAbU06s32CI2VPGSnY+ACSVJz4qvBkRnEHsBKeHuxXNTGmKP+WLJK1SCLM36LcIX
	JxPRIA9LxSkYWfY7H/+7h3dPBYPZGevWJO14HMzwF6TpGALmqIfKuBMyyfjvaXI8
	e2SRVSnBS21wysx6U/5ZZ5L/IZ/JJ4RI9modQlBORdjO/yCXB+kcTZei7COJqHVc
	w9WDFbNib0y3J4uHMzkk4KZIqh/7tM/YwPrFMpXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgb0f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 13:51:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56VDmAPX016376;
	Thu, 31 Jul 2025 13:51:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcgb0f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 13:51:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56VCYJxM006269;
	Thu, 31 Jul 2025 13:51:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjmcfu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 13:51:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56VDpAw250987462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 13:51:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 089E92004B;
	Thu, 31 Jul 2025 13:51:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDBB820040;
	Thu, 31 Jul 2025 13:51:09 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.155.201.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 31 Jul 2025 13:51:09 +0000 (GMT)
Date: Thu, 31 Jul 2025 15:51:08 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/1] perf test: Ensure lock contention using pipe mode
Message-ID: <aIt0zOSp41uiKXAd@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20250725170801.3176678-1-japo@linux.ibm.com>
 <aIRoR6j1qAfytIPC@google.com>
 <aIfNaheJ5REpoFE_@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <aIpgeZUGKb3t9NRq@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpgeZUGKb3t9NRq@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA5NSBTYWx0ZWRfX7wi7j00cvCca
 WrdTcJ1TJj7XNiIwYUqoEJD+3dJRdgKAWKRO8YYjn28QkKNo0osts8LeGWEW9RppqzxJtTUI2qN
 O5e52H6x9ClaHAG/9QDVPX39Mtcu2mwo170bt26/s/15yxGa/O3pJnO5fbVFAFF+ZGJxd+RyL1R
 KNFDGOUKDPQP5MhdVtt9Z4XT7YODobqcWc8Fyyb+YgK7FolkAj9GM6U6g1KCT33sUDgR5voQK9Q
 LgR0SLOsxdKgSQqLwYEyFsn9WxHyzW7e4VTC3wLlsDo0REdD9COTTg0mmFHyqHEB9K3ROM4KPph
 JeIoigm+bAQxqwIoCUYDjwWuXiB8U3bVe38r4RjL+LasaViVSXDAIIlhnyqhlVBU8xhbq9iqD4/
 o4vk8k9Sq4JhjVQoi8GLb2Sf9IPQXnFj4wytey3s6G1OQe5du7HuCfCd5mmk9ACR8aXnIFHA
X-Proofpoint-ORIG-GUID: e8DrEgE5Jyx5hftz9818yBG7VnXJxNeL
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688b74d1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wdoH1GY5UkHe-R5Uq1oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: A_T-znWlTMzfRyRhu0AbFlk8T4HGp9UI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310095

On Wed, Jul 30, 2025 at 11:12:09AM -0700, Namhyung Kim wrote:
> On Mon, Jul 28, 2025 at 09:20:10PM +0200, Jan Polensky wrote:
> > On Fri, Jul 25, 2025 at 10:31:51PM -0700, Namhyung Kim wrote:
> > > On Fri, Jul 25, 2025 at 07:08:01PM +0200, Jan Polensky wrote:
[skip]
> > The solution suggested by v1 in
> > https://lore.kernel.org/all/aIOvdQ003hRqFEH1@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com/
> > can be significantly faster and more reproducible in some cases. However,
> > on large systems it may fail with the error "perf: socketpair(): Too many
> > open files", which in turn can lead to kernel lock contention. While this
> > can be mitigated by increasing the file descriptor limit via ulimit -n
> > <number>, we should avoid modifying system settings during testing.
>
> Interesting, I didn't know the socketpair would generate more file
> descriptors than pipe.  Maybe there's a bug in perf bench handling
> socket file descriptors?
>
From what I can tell, this seems to be expected behavior. socketpair()
creates a pair of sockets. The issue arises because the file descriptor
limit is too low for the number of CPUs/nproc on the system. As a general
practice, we try to avoid modifying system defaults during testing. If
the solution worked with the --group parameter, one could temporarily
raise the limit for the executing shell using ulimit -n <num>. However,
since this doesn't address the lock contention for s390, it wouldn't
solve the underlying problem.

For context, the default file descriptor limit (ulimit -n) is often set
to 1024, while systems may have a high CPU count:

    $ ulimit -n
    1024
    $ echo $(nproc)
    32

Which can lead to issues when running benchmarks with many threads. For
example:

    32 groups * 20 sender * 20 receiver = 1280 --> exceeds the default limit
    25 groups * 20 sender * 20 receiver = 1000 --> stays within the limit

The desired behavior with fewer groups works as expected:

    $ ./perf --debug stderr bench sched messaging --group 25 --thread
    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver threads per group
    # 25 groups == 1000 threads run

         Total time: 0.142 [sec]

When the number of socketpairs exceeds the file descriptor limit, the
benchmark fails as expected. For example, with 32 groups:

    $ strace -f -e trace=socketpair ./perf --debug stderr bench sched messaging --group $(nproc) --thread
    [skip]
    [pid 94410] socketpair(AF_UNIX, SOCK_STREAM, 0, [1019, 1020]) = 0
    strace: Process 95418 attached
    [pid 94410] socketpair(AF_UNIX, SOCK_STREAM, 0, [1021, 1022]) = 0
    strace: Process 95419 attached
    [pid 94410] socketpair(AF_UNIX, SOCK_STREAM, 0, 0x3ffde576ef0) = -1 EMFILE (Too many open files)
    perf: socketpair(): Too many open files
    [skip]

This shows that the 509th socketpair fails due to hitting the ulimit -n
threshold of 1024 in this case.

So it seems to work as intended, but the system limits are simply not
suitable for this particular case.
> >
> > 	[root@localhost perf]# ./perf stat -- perf bench sched messaging --group $(nproc) --thread
> > 	# Running 'sched/messaging' benchmark:
> > 	perf: socketpair(): Too many open files
> >
> > 	 Performance counter stats for 'perf bench sched messaging --group 32 --thread':
> >
> > 				 43.14 msec task-clock                       #    0.104 CPUs utilized
> > 				 1,013      context-switches                 #   23.483 K/sec
> > 				   900      cpu-migrations                   #   20.863 K/sec
> > 				 2,905      page-faults                      #   67.342 K/sec
> > 		   162,801,472      instructions                     #    0.74  insn per cycle
> > 		   220,427,613      cycles                           #    5.110 GHz
> >
> > 		   0.414804757 seconds time elapsed
> >
> > 		   0.004687000 seconds user
> > 		   0.071900000 seconds sys
> >
> > Analyzing the lock content w/o pipe:
> >
> >     [root@localhost ~]# perf record -e 'lock:contention*' -a -- perf bench sched messaging; perf script | wc -l
> >     # Running 'sched/messaging' benchmark:
> >     # 20 sender and receiver processes per group
> >     # 10 groups == 400 processes run
> >
> >          Total time: 0.135 [sec]
> >     [ perf record: Woken up 1 times to write data ]
> >     [ perf record: Captured and wrote 0.363 MB perf.data ]
> >     0
>
> Hmm.. strange.  It causes some contention on my system.  But it could be
> an arch specific issue.  I'm ok with changing it to pipe then.
Yes, communication is highly optimized on s390x systems, which might
explain why we don't observe the same contention here.
>
> Thanks,
> Namhyung
Thank you for your input and feedback, much appreciated.
Jan
