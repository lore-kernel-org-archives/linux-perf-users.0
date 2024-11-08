Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53391D52B;
	Fri,  8 Nov 2024 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047311; cv=none; b=HlbL04FJ9n9dIcgMmVsBHcl7W5QoBPwr5F2N+tp6tKUkOQkjNN1XbUxFg6wiR9RMaQeDec5h17EIbTZfF/rS7Afc0wyeeTwsA7kTn4qT0DWrS2Oz23ysrjqsR3iFVDFuBZQbcuwlj86/geKpthy2MFZyYSmNkdf5LATy679lGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047311; c=relaxed/simple;
	bh=vGpm9c8Go+hIdvjd+ws4rirXLAyvQkMLKioK1vvCGDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qk25ZM0g90vBOCMMaXedYiNDvIaXwkMuGXtV03vHWuAuhb3Uj4vpAFEb2JCCx54sq1LNZy3QdPdVx0U82M7xFHTCt2EcvCEOvU/d5hLOdFx6DN4qfDvNIYRFrTKUqFA7yf1yqtpWJJnQqLSWVgPldezVVYVS5BmurFvyi6ZQhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HnSyj1YW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HnSyj1YW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A869ml9017648;
	Fri, 8 Nov 2024 06:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5tXKZIc9DzhALNJU+G9X2Cwncncnk8
	seDhujvMJvhi0=; b=HnSyj1YWGgSlYCHZnnp4jSQBEzp4moliJbfg0QfWpSCFKm
	KBcE7MTZSvhoLKA+oT9x8w5cD8hZ0PMTuiYjWScFSahV6Hznw2bNcgK0WVdAJZ3F
	GNLuB9tCn3AbJvWWplhAsIAhc0CuGaqXxsuRUObF7Oz8OUXLHiIf1q3nNEA+WLY+
	2FYWONCXWgKWSAij7dJAm5PD+oaPR6Y4x25WNQDBEoBV54MTlRqo1OF32s5y+oO6
	cWUTdpoBjJ2BpWoPAq2NZM7VNUFJ0capqHTYBsxL2VGBZWTGwXsBR2PuIYcIisut
	pK0EKF5h7varXIlob+WwcL0XAb5oM2IqKaOwAl/g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sd4q023m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 06:28:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A86Eera008450;
	Fri, 8 Nov 2024 06:28:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywmek8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 06:28:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A86SMFZ51577128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 06:28:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3608020043;
	Fri,  8 Nov 2024 06:28:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 152F020040;
	Fri,  8 Nov 2024 06:28:22 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Nov 2024 06:28:22 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        sumanthk@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: fix perf ftrace test on s390
In-Reply-To: <Zy0X9kz_tmjNue5D@google.com> (Namhyung Kim's message of "Thu, 7
	Nov 2024 11:41:42 -0800")
References: <20241107123343.1580616-1-tmricht@linux.ibm.com>
	<Zy0X9kz_tmjNue5D@google.com>
Date: Fri, 08 Nov 2024 07:28:21 +0100
Message-ID: <yt9diksyqlx6.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S1e0I9GiKZ-_mHN-UeEXEbmae30PounX
X-Proofpoint-GUID: S1e0I9GiKZ-_mHN-UeEXEbmae30PounX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=629 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080051

Namhyung Kim <namhyung@kernel.org> writes:

> On Thu, Nov 07, 2024 at 01:33:43PM +0100, Thomas Richter wrote:
>> On s390 the perf test case ftrace sometimes fails as follows:
>> 
>>   # ./perf test ftrace
>>   79: perf ftrace tests    : FAILED!
>>   #
>> 
>> The failure depends on the kernel .config file. Some configurarions
>> always work fine, some do not.
>
> Which test do you fail?  ftrace trace or profile?  I don't think it's
> gonna be a problem for ftrace latency.


The ftrace profile test failed, because the ring buffer was not large
enough, and some lines (especially the interesting ones with nanosleep
in it) where dropped.

>
>> To achieve success for all our tested kernel configurations, enlarge
>> the buffer to store the traces complete without wrapping.
>> The default buffer size is too small  for all kernel configurations.
>> Set the buffer size of /sys/kernel/tracing/buffer_size_kb to 16 MB
>
> Actually you can use -m 16M option for perf ftrace trace and perf ftrace
> profile.  Then you don't need to care about restoring the original size.

Ok, thanks. I leave it to Thomas to decide whether he wants to add this
option to the CI run.

Thanks!
