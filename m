Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685529CEB;
	Wed, 10 Dec 2025 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334894; cv=none; b=tRr2VsKW/6MxJWPl+9RxLZmuC5X8Lb5SS7ioQGDgdeXzgPXb86QjP346zZ1bfD5M+MjMvj+sFJBPwxT8EM512D6FAS6yQaszByGnAJiGmxpARFpOFfjznfZt83SuegHnBxbmxOxISENi4DGHD/UCCtFDHS8/n/wjwbPfu2tNo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334894; c=relaxed/simple;
	bh=xPLWQTN9+U5KNZc3NIm5mSgSYldyZ8laKFCV6KyOsTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5nsg9vArzBsMWe1FmvbJH0v8EwhDVbwdI3D2mqDUcwcNPy+/LnByyEK2hQnlEOJBc4UY8KjNHJnTlEyykhYhDOz3d4D7cjP6WlCH8McKIlJj2jJGQudeEnmWn2pbXIFacHNnqLw+T2Ar8O9Ewg0MddzESwtfCccqyzXd9PTSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=XLA5WBQ5; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="XLA5WBQ5"
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 5BA1UfQu4069696;
	Wed, 10 Dec 2025 02:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=xPLWQTN9+U5KNZc3NIm5mSgSYldyZ8laKFCV6KyOsTQ=; b=XLA5WBQ5t6Io
	137Fn9iiCFX6D2fnc0VXEL1+vjegub71XnyQiBnj6Ul80GgbQkWamhV9Vvezqqs/
	UbhS9h1nqhtJneU1wbI9iMMhQSCuYJ7ewJFqJLgE//Sd0YcAtWnPqGzz/QaTk+v2
	fcCVtJ9O+dSwgoFaOcmg0Z3lN007B24Vk/iU7Myj3Dx3HV1hL0Z4a7AqRb7wCSGh
	UJYCHkGg028otWkVz1AU2Aa0kgZkOQ8trzBEIR0pbJt+EmW3KMiqMCvUNTSA108n
	15kWH9pvnTISrIvTBgBGsLR8opo4jDwaVnNux/vdoukbN7Bhcs0b7c1hhoDiTSuk
	/zM5vLFP1A==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4axkha4kh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 02:00:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9M9I6S008084;
	Tue, 9 Dec 2025 18:00:27 -0800
Received: from email.msg.corp.akamai.com ([172.27.91.41])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4avkbdwxjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 18:00:27 -0800
Received: from usma1ex-dag4mb7.msg.corp.akamai.com (172.27.91.26) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 18:00:26 -0800
Received: from usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) by
 usma1ex-dag4mb7.msg.corp.akamai.com (172.27.91.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 9 Dec 2025 21:00:26 -0500
Received: from bos-lhvg4i.bos01.corp.akamai.com (172.28.221.248) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 id 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 18:00:26 -0800
Received: by bos-lhvg4i.bos01.corp.akamai.com (Postfix, from userid 35625)
	id 6CAC115F522; Tue,  9 Dec 2025 21:00:26 -0500 (EST)
From: Sri Jayaramappa <sjayaram@akamai.com>
To: <irogers@google.com>
CC: <acme@kernel.org>, <amadio@gentoo.org>, <johunt@akamai.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <namhyung@kernel.org>, <peterz@infradead.org>, <sjayaram@akamai.com>
Subject: Re: [PATCH] libsubcmd: Fix null intersection case in exclude_cmds()
Date: Tue, 9 Dec 2025 21:00:26 -0500
Message-ID: <20251210020026.3265559-1-sjayaram@akamai.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAP-5=fUs8jD_qLJGjLBiVheu6JzynmmYSmfr_9PgKmxK4qEwVg@mail.gmail.com>
References: <CAP-5=fUs8jD_qLJGjLBiVheu6JzynmmYSmfr_9PgKmxK4qEwVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=511 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512100013
X-Proofpoint-GUID: q6ANxLEgeZ8hIHq0IOO4aAJKHPxWjszX
X-Proofpoint-ORIG-GUID: q6ANxLEgeZ8hIHq0IOO4aAJKHPxWjszX
X-Authority-Analysis: v=2.4 cv=He0ZjyE8 c=1 sm=1 tr=0 ts=6938d43b cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CrTSlZ0qHoPYa9lPNiQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAxNSBTYWx0ZWRfXzU+KWp1dkthl
 d8aV7nBezLN3Kvl/i2L3IWIqtwtwmYAbN9r/lp8Qm7pxzhA9IugavYP1BesAtBJ1pb91QuKtHG5
 iado41/OsiRCLxYsi0eWFsguI/7O9Jcvb/ni29MR9W00fWP0OMRI9+jd1Bo6GbZcoxLQY7F5Jz5
 8ShaTbpN/NpdgocheYBTwGGX5M0N4wQydzgHL+Oy/h6jFpWn7Py2IQ9KQlx+ubAw1lZQTel3hwD
 /7/7Ru82TN1RWIK3O8S6pQgjd+s2pYJqyGyVHe/+IcBCXZu0B45mABTeICInII5p2MNRobXfBm2
 SoSyb3YCkNzyJhVgp3CaLzp4JZmsUI1I9civhQraDFIfCE+MdV1BrwTqMeeTELZRcDRrWEwcuwL
 QeuDgKtaG5uiVkp/ZQX5Ft5AG5Tpbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100015

Hi Ian,

Yes, this covers my case. I had thought through other possible scenarios before sending the patch, and I don’t see any additional issues.

Best
-Sri
