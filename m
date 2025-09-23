Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC17081C
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609651; cv=none; b=p8GXo9X8XxJ3Opleg2ZqNDHzDa7FPKuH4pq+TUtPMjRWmMj/OT/GJy9JMNYzwm6tAW/MrXZN8hJeVI+pfZX3gUeXTmrI6e2YXd1bFh68opUdrYJn4RMUHuhx1k4lDwxRca0yT8H0ku60EOUG4GbwhclRX3rrHDYgukQnKG8TE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609651; c=relaxed/simple;
	bh=fZ2zBanofoywceKlsD95+SBmZuBKzq/f9RzscqfxCto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDDbJDBLHK5vUl2V55cuC9k3NnWh3omSWzf8CGqKLm0zZO1z+IhY5oXs+nfk/ncp10XcUEwbtMXSmNJlm+Cv+vac3eLmy+bkMhcZcfiosO4wnW3MabxopX4pVMM/oXdxlyXrg42gyfmYGLwnZrXFoXO2MWu9xI0Z/qS09yNEX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p9NvMc6z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p9NvMc6z"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MIoLLC025249;
	Tue, 23 Sep 2025 06:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8L8Zk3
	aGDumtFBeuituLPxeAoM1QdnKL7ctml6ul9tU=; b=p9NvMc6zoXsm4613GT3vzr
	hhz9qBZPT0Qw68betQcaNu5jwh6EfEm871Fg9P6Fwu/FKSTAFEjLTjmHFQVxX6YF
	v2sfJAcCBJdBK/EmewSf8ohXxtq13VQk4UP7rujN+1FDxJHgBBB0e8Giv7CgiMgD
	DRQsM3iKbTwTlmHxoHHo5APmuumSp6UmLTN6ImbE2GfUJU+kqxzZsvM+cu+v5A4F
	bNupzaHpYRjXWj9toZ3ia+YHe4P+T+jp1p5EtaoQo/atXQ3MvYJdjSWbbhCO8vUh
	gkHCGjBsmQEhdawZ/ecBvJ3QO8PZlw4sFU6DJ06/isvzTpwpIipPzDeUsnpg4TZA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky5y8ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 06:40:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58N6ecUB009006;
	Tue, 23 Sep 2025 06:40:38 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky5y8eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 06:40:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N5OiSw031150;
	Tue, 23 Sep 2025 06:40:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vd2wyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 06:40:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58N6eXWG37945838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 06:40:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE6C6208BE;
	Tue, 23 Sep 2025 06:22:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D23BE2089A;
	Tue, 23 Sep 2025 06:22:38 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.94.138])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 06:22:38 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, aboorvad@linux.ibm.com,
        sshegde@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com, venkat88@linux.ibm.com, Tejas.Manhas1@ibm.com
Subject: Re: [PATCH V3 0/7] Add interface to expose vpa dtl counters via
Date: Tue, 23 Sep 2025 11:52:37 +0530
Message-ID: <175860852521.1640363.14331907385336078326.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915102947.26681-1-atrajeev@linux.ibm.com>
References: <20250915102947.26681-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EJSqHDN4COH8cOMY2DW7lTnBe9jD98Db
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfXyQ1rBcwhq3m2
 WtE+Cij/2bkgeYtw0T93nRrMI+kHfFHR2dWvVbOz9GfFOZTeR0nTwsj1QLtkU5D7a7BcwnnxG56
 AVDHD7HZ6ovpflC3DDkFdUbQFUoQxJuJHAnRJNSxkfffrYeqVSihZMGuc9L98ZE6EyhzQ9Zivov
 ebKJpg49EIL/g3lXPMUDbU0xYYz41Dj3uHmrprGYF+bEIuW4WJKLc5mtgH7mWtC2Ev73VjN6ArN
 rkIWwxUOHdY7ETU9K5VJSEPb8Hykt+XjdTeGpTFfSi5hAN3kfQpOhEIszyqGZq/q9PgAPDEfG4T
 z/C/MeRFrKNcfKeIEcT3I1XYc/BNGdLo9mRrlR9zHW7VBPAkmzlU6+s3m+VLGsGzxnRfNDhmAyq
 ZMLdd26K
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d240e7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=mKQpEHmZPOLzfWqt6YMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r4OjiLHTGHZ3fbG3lstIKY4jTNmv_hVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

On Mon, 15 Sep 2025 15:59:40 +0530, Athira Rajeev wrote:
> The pseries Shared Processor Logical Partition(SPLPAR) machines can
> retrieve a log of dispatch and preempt events from the hypervisor
> using data from Disptach Trace Log(DTL) buffer. With this information,
> user can retrieve when and why each dispatch & preempt has occurred.
> The vpa-dtl PMU exposes the Virtual Processor Area(VPA) DTL counters
> via perf.
> 
> [...]

Applied to powerpc/next.

[1/7] powerpc/time: Expose boot_tb via accessor
      https://git.kernel.org/powerpc/c/2dc019ca39347f76891d34a992b67258078aa45d
[2/7] powerpc/vpa_dtl: Add interface to expose vpa dtl counters via perf
      https://git.kernel.org/powerpc/c/4708fba19adee9ba14ef28af6face4ab043d9cd6
[3/7] docs: ABI: sysfs-bus-event_source-devices-vpa-dtl: Document sysfs event format entries for vpa_dtl pmu
      https://git.kernel.org/powerpc/c/6f2c65680c336a274b69b1fdcbfa2eeb8159bee8
[4/7] powerpc/perf/vpa-dtl: Add support to setup and free aux buffer for capturing DTL data
      https://git.kernel.org/powerpc/c/5d75aed84d3b6d25c7c4bb4a212b14fae4d1020b
[5/7] powerpc/perf/vpa-dtl: Add support to capture DTL data in aux buffer
      https://git.kernel.org/powerpc/c/2de8b6dd5ae72eb6fb7c756a3f2c131171fe3b8b
[6/7] powerpc/perf/vpa-dtl: Handle the writing of perf record when aux wake up is needed
      https://git.kernel.org/powerpc/c/b5e71cafa02d4e673639a3bd4c03d84db5dd8b8a
[7/7] powerpc/perf/vpa-dtl: Add documentation for VPA dispatch trace log PMU
      https://git.kernel.org/powerpc/c/4a774b39e68fac7d6c7c9cffeb6a4ea4b6dc8b41

Thanks
