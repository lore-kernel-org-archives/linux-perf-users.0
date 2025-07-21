Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2313D246;
	Mon, 21 Jul 2025 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083185; cv=none; b=a0GUwApGDP05VXfZBB3iNNVuDamdPyXYQokv67J9wzbVe3xydgk5WVM5vcdx6kLAglSrCpsM7vlDsxAyTfzuY1GnToo9Eez8wJcYTwNYyFaj7gOMC2dXAlz1peIiyv7V9ZLXBAl9d804GxPiXbm2nTeb0tDrFw41XczqMCqFMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083185; c=relaxed/simple;
	bh=HLIurAWfxqejbIm3m4sjbpfV+0AkGKFzRvVlMGHWpi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDtmXvEy7H2qB4ZLW1NWZqtrTQxc4SVmi4IDC7N4aGnLg4u1lqOTKbDCF+TchJ7euUwjAQNyaIzxrhOaoYS2NetHW9QurtEEPRWBhR/psr68iBAxFuza0Ynhc+bKZXBFFM5Lg2rtRUtztV+zd/L5TFfKiYTG5KrPfltrIclmXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C2P+hdLF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C2P+hdLF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KLO8ud017521;
	Mon, 21 Jul 2025 07:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HLIurAWfxqejbIm3m4sjbpfV+0AkGK
	FzRvVlMGHWpi8=; b=C2P+hdLFgXz2HaRlktZBkuvLWh2JNJep97+oUeTouPo8ZV
	x6O23e6BgmW0jpXKk+n5ASj0eNWLY58IG/LcJaDgerhiIynRyKCvGMLrhNO5lZb1
	8oGrgxNKrsbrdhcu34FE+oulK80E1IjrsF15IKtA+XtFo9OpQcdmkTWvhouxlrec
	w9YmHVf/mZm1ebCZK/ufa2P1ig5kQpxoJM4UXVWegZohUIq2AlUW8Iw0WwbyJhy1
	jPYx8cBhnU5cwJSDWjKcKicom0PlTAkWjtYW9yRtXKJuPTtLJChfzM3n2clXGoyH
	v/K1UeCa3rFah7x0fIXElvnK72skNUEzMsHE4P4Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqq6fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:32:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56L7WUFV032185;
	Mon, 21 Jul 2025 07:32:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqq6fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:32:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56L3SlrV005445;
	Mon, 21 Jul 2025 07:32:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvqm8df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 07:32:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56L7WRBW49545488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 07:32:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A15CA20043;
	Mon, 21 Jul 2025 07:32:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 451FF20040;
	Mon, 21 Jul 2025 07:32:22 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.124.223.44])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Jul 2025 07:32:22 +0000 (GMT)
Date: Mon, 21 Jul 2025 13:02:17 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Collin Funk <collin.funk1@gmail.com>,
        Howard Chu <howardchu95@gmail.com>,
        Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Falcon <thomas.falcon@intel.com>,
        Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 11/16] perf ilist: Add new python ilist command
Message-ID: <inu4jmw3jpnbhpaqjou27sn7m5zlzu3ksiuhir42wz4yxj2nvz@xpekkgpqldo7>
References: <20250714164405.111477-1-irogers@google.com>
 <20250714164405.111477-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714164405.111477-12-irogers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qpT46FbYMCcb6Wjb4D_XKuYTLgPJPlyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA2MSBTYWx0ZWRfX89ib/3yI4a+q
 Otcke16785NOR3nmU9tvSoAwUwkQkaqwbFIAcSFnvUAS2CuJPGUp6eiSpU1Tusx4udfIRZTryzi
 LkcDDWE4JW8ihi5dHXhBeB9eLt7cBK890NXfBXjWuwDoSSizXu4z4AqZZul9tBZ/evhSxMjGgkN
 Jroe2ML6luxQV6L8XC3PiaJZOLYa0E/TLGcC7XVp0SyOyUoYXvkr1HGg8UXagy1fAGM/CvHdbwf
 jUfVg9xAwHwIp0rom/563lcUiFNQvE62dL3Ivdgg8WLvBif372oc0oKPdgs83uAfxcvxPxVXjp2
 7lQMH2Q4LqhhRjy4SK/tarIolEB6R+2VQ80taq5kMUxKAXM6Ql2ni6mVq6/q733+5UU9qrbZi1b
 ufLy0RyqIZicAxHDtwfTV3/hGSGvMbYeLIQZJxLGSdvrCpNF9yKavJyS7rf+gxWoth1C8BJ0
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687ded0f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=HAfQxcFdIi2WblIoubEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: dcLuUJdKCwkOKEI9M7Yyl3miQNW5loIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=659 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210061

Hi Ian,

Thanks for this. I tested this on both x86 and IBM pseries machine, the
entire series LGTM

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks,
Gautam


