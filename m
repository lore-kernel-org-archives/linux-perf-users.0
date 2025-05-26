Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265AE7E110;
	Mon, 26 May 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271023; cv=none; b=WDpUTZBN36Uq7WwDh6QCas82pd223oAoRU9YpWneDjtf8xkQMtn6xGwivS3i93aadNCWO65hEO8JHr6V0rs5p1NhSs0SDhcPWJsCp89btJapVNBUoKjANiQ6B9YKfE45PWtn1m/u05P7s4mNVAaXm2kxgfUY7kk4oTSOr6qBybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271023; c=relaxed/simple;
	bh=ZxYIp2TgdyRyWrfp3iOr00VxDZSBZjiNlSPLs0mE9as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYtLLBIcoigXhb9yyKTgGSv+PjUMfcPWcvmxBvRK5fBnOn1Pn5sLvOy9C9u73AH8D7RjOr9i9fyc9yFYGAdzOL9ZSfo2pzW1cKloot6lDIGIeOdkP00o6HPgkt3OaZCZPCPjRUpyfZqmALFJ9vGIL9VhcL2rJe8+J2OX1wadJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q8InF6CJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q8InF6CJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q6qcxL029745;
	Mon, 26 May 2025 14:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZxYIp2TgdyRyWrfp3iOr00VxDZSBZj
	iNlSPLs0mE9as=; b=Q8InF6CJ+rx2e9m0K9x2iRdmpsLHg1tw8WQ49XxKruhyae
	vYiWEQKf5R0DDrKO2n4C9+VFiN9EtqnjFpbCUSUuRzwOMAiXLP/3kV6EtzEndNeF
	05SPEBR9/O0XtlDVxuqqgVc2hz06DAJR535zrwvXHxTQ//Om7RUduQ9FJfuBMQNI
	mtbVEnVAVQrOCOhaDXhgH4CyCOs1iteo8b1pfAwy0k2aycvmcrtUTT7lMHHCC0/f
	LwggzbkkfmGAsZA0BJ5H4xmg58iyTIU1Um3lPmm3kWNYPa40KR9l1OJAJFYbXtrA
	r4GDSS61LQBxydJ1l6Ji5oxTV18WEC37o62RGxZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u3hrt3xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 14:50:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54QEg6GC012848;
	Mon, 26 May 2025 14:50:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u3hrt3xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 14:50:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54QDW4SI006819;
	Mon, 26 May 2025 14:50:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46utnmebws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 14:50:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54QEo5Pg22479170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:50:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A69C2004B;
	Mon, 26 May 2025 14:50:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF92F20040;
	Mon, 26 May 2025 14:50:01 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.124.209.42])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 26 May 2025 14:50:01 +0000 (GMT)
Date: Mon, 26 May 2025 20:19:58 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Subject: Re: [PATCH v3 4/7] perf python: Add support for perf_counts_values
 to return counter data
Message-ID: <3wn3cpouicbzkwlzlgfetqxnrfpwpbgryna2nk2etjks7wtedz@gwvsm2bd2p23>
References: <20250519195148.1708988-1-irogers@google.com>
 <20250519195148.1708988-5-irogers@google.com>
 <aC-jR0b3mji4oJ7Q@x1>
 <CAP-5=fXdpT3-=e4cqZN4fBJK1c4TnYC1ZVV5Q5zTjmf7T7Fffg@mail.gmail.com>
 <aC-m7G-AVJP6sDD3@x1>
 <aC-nOmMADRlnqkP8@x1>
 <aC_PNda-nDPHGr19@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC_PNda-nDPHGr19@x1>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AOOMbaiN c=1 sm=1 tr=0 ts=68347fa0 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=a59WGzUNEWtFLksj9kYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3m8QtZlCsjg9ufuxZyvWWbp5avUEQ6sx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyNCBTYWx0ZWRfX60hMF0YTAA48 lp8ceG4L16CDHoD3SxrKOTKv8+143NCtTu5GNsAZHLCRQGbU8iNU/6Woof/ZTI1CisDpUhMSsfW F8koiSQZ00ThgTEBnIQWXQhc8EXfGlocJ+0P6q6INmnDCvzC/ytCQWo7fBa5Lu+FDrz9tQifkaT
 XAWlmlAPT7rJKdYvliuRT8melPG1lprVnYKlCSbCXX1nNu1YdeGho3KCQWPPNnFAo1Ec60OZSzT FfosOjD3bNylL0vNUj2kEo5EfytDeTUUiEPS0dNM1GdBXaDvknRSibeBJMlUJL87i69S/qV9yC1 rxrMpo/9YAmThQnkG7q8bUvzN9r+Oii7iPhJVpUW2mFonqhKe8Bzcrb1MliV6VzB8UWBTToCNLa
 ngAnC8fPSnlqz00VLTbesppJm6rD0Nouj3RRsin/vlTDEuzEkY9Udo32P27490HY5uUYJjnC
X-Proofpoint-GUID: uDLsIOHoBmNYxnQXch7-i1saFITF079F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=925 malwarescore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260124

Hi Arnaldo,

Thanks for fixing this, I should have looked at the other
initializations in the file.

Thanks,
Gautam
