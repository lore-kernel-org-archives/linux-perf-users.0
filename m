Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5F2EE606
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460607; cv=none; b=WP3Ohi4k/UJ37r54KT43W+Y4uy7UuHeN/7l7BpFcNFqxYHiXNZP1crqZpnhOGwFMUimH8U1JdqLPNEkIJDonZv3w2n0vIZrgxgH7ZMxvSxz/e2/3RLhfKRAYfib4Xvmbe6OPTgOfPImOKLM2tB2igIgq6PPpadFPzX+eLZHkv94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460607; c=relaxed/simple;
	bh=w+B9VrcuggbyWVbHoznEIB9N4yNBFou8+jbhEN6Eqg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxcNp0PXUhteM64ce8ATJl4JO74OHDxVxNM/RTWIn9XLypslEKPJpUe/jcaAVH2VEqDrwwtouJJ7U0Hspj6rAc2Dgc9LspeVjeNY7vB3GfYdDyxCei0QtrEZPjsh0yLaZAWgnLcrddKWFTmxLODkBCDqv1ECkgO6WZiwTghJuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=smMikwTV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="smMikwTV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAiKjg024042;
	Fri, 25 Jul 2025 16:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=93X+jS
	RC9e5ufgbH0++BtwfWucRt64i2+a5x9aSZcY4=; b=smMikwTVWFaTtaQrkUbk3h
	hmd62QSSoY4z+1FlK2SZ+h5z+S2uPvNCwHwooxEaUQg1yAwg4PM4nOZOvkFxr54+
	V0lgTMYOIITQaBA3K0L3TbuJeMhItGPeY8DczOr/we2Rzy5wNtMzPsGUc1U4DjAc
	r4juTqw9snJoU3QUGn1/CtT15xuQSuL5SvTPT3ObasJtS8TWK+YUhndaDsv+CkJJ
	y7W0V51og6anSn0ZDHBWfMP6m+fn3+rGLHt89Xu0tHzZBxoltEwzaLARl7gb5MDn
	1VW+Rh1Hqy+PkpUEwukYV2n34FnQmaGjAD5L1vkyOcSgAONb5hc1mNMMMLCMBSzg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wchv2eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 16:23:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56PGDT4X024169;
	Fri, 25 Jul 2025 16:23:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wchv2ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 16:23:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PCiret012827;
	Fri, 25 Jul 2025 16:23:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p30je6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 16:23:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56PGNJZr42271132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 16:23:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6620F2004E;
	Fri, 25 Jul 2025 16:23:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 238EE20043;
	Fri, 25 Jul 2025 16:23:19 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.73.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Jul 2025 16:23:19 +0000 (GMT)
Date: Fri, 25 Jul 2025 18:23:17 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] perf test: Increase load in lock contention
 test on low-activity systems
Message-ID: <aIOvdQ003hRqFEH1@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20250709203809.3211178-1-japo@linux.ibm.com>
 <aHgCmxEZ_bcNeki-@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHgCmxEZ_bcNeki-@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEzOSBTYWx0ZWRfXwblObe6r7f4H
 ODWPn+ZwLL1h9RrZJaIiq6biZdF4R963DKhfGa+OxagY1eBqQKntrDk8Lfqi692DQ+LzAMM0y94
 igVIgaGfpoqF+PoNhtig+xrhdyHPXYeUP3/d3YDw4ieB7pebgKj9WnUEmC2e926BSKWcYsJ7X+b
 tD3vV6Qf8datkPfGYD/TIrFrxPnqrEjIlWSYSY+pG85l30zDf5cEFms3EkgItT9uv+Rb9Z+9cgO
 5g9xnJaUVhXYh8qVpTbQtpUgJATDKUT87L1fXE8C8WN5F6RzfHmb0XGNZrhLTKyZSUhC0mzshVY
 yIsnk/teOazcxnBvpE+8GSS91MDR2l5S3Ukz73v5YOIu10vW9NgPvvPYbHeE3mTQdr/2rh8Gced
 jI/v5CNccF0YlM0QY/q8qAkbjy8uV2ymxqB0l9PXptdPLUMX78hZzKiiUcA8AMYhCkkOC6xs
X-Proofpoint-GUID: khYBdA_aH_XGxtQJ0hUpCBqOv-C_dTjj
X-Proofpoint-ORIG-GUID: V3NetZZyqJu-U9P0IRZttekW0433_BYg
X-Authority-Analysis: v=2.4 cv=G+ccE8k5 c=1 sm=1 tr=0 ts=6883af7b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=XprcNsXrX9gmfxLExzcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250139

Hello Namhyung,
On Wed, Jul 16, 2025 at 12:50:51PM -0700, Namhyung Kim wrote:
> Hello,
> On Wed, Jul 09, 2025 at 10:38:09PM +0200, Jan Polensky wrote:
> > On low-activity systems, the 'kernel lock contention analysis test'
> > often fails due to insufficient system load. To address this, the test
> > now increases load by using multiple groups and threads in 'perf bench
> > sched messaging', scaled to the number of available CPUs.
> >
> > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> > ---
[skip]
>
> More importantly, there are several instances of this workload.
> Probably we want to change all of them by introducing a shell variable.
You're right — introducing a shell variable makes sense, especially since
there are 13 identical calls. However, I’m slightly concerned that this
might reduce readability. We might also consider an alternative solution
to avoid this.
> But I'm a bit afraid how much overhead it'd bring up.
Indeed, using the --group parameter on large systems can lead to issues.
For example:

    [root@localhost perf]# ./perf stat -- perf bench sched messaging --group $(nproc) --thread
    # Running 'sched/messaging' benchmark:
    perf: socketpair(): Too many open files

To avoid this, I suggest following the approach proposed by Thomas
Richter (tmricht@linux.ibm.com), using the -p (pipe) mode instead:

    perf bench sched messaging -p

The pipe-based solution generates sufficient load and lock contention for
the test, while avoiding the use of sockets and their associated file
descriptor limits.

I’ll incorporate these changes and send the next version shortly.

Thanks again for your feedback – it's much appreciated.

Best regards,
Jan
