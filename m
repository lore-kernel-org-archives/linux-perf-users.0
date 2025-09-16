Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A72DAFB5;
	Tue, 16 Sep 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029484; cv=none; b=R06rrkcfNDw7tFop46Vcz7auYxHP0L/Ao3IuH05eMd5he0Cx7RzLCbdIk4jMqpf4lwyY1/3rF+1GO6SBHI4FI+Z7YXtPIaWGcv7RTSeGWugv8acMPXt4EWar6BOpnHami0Xmrbgt0Wd1Xw0Z89WZXIWQd51J77L1KkOTf5piKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029484; c=relaxed/simple;
	bh=eaiguNiv3IiJurV7vpMt3YJy2iyvkR3xDYI9wQMO+Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8a3hKiujWiM6v2AqOPMuQZY4RX2JaSarZYy7ZDz1LPSu69o8gOeL0gu4ngk4ymhm6NNbXbhGOcMAuZWmAxs3mRADI3F+J5sqeLgRjxiKxW7rJFxov+5KI4nHHMkQqblHxQ9c7/+C3sl++4P2h0aYeqCSsbIVeOKOpLUL0Dsmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R+1zHJBl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R+1zHJBl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G6uIXG020960;
	Tue, 16 Sep 2025 13:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eaiguNiv3IiJurV7vpMt3YJy2iyvkR
	3xDYI9wQMO+Co=; b=R+1zHJBlGqTxw4PIUT8ZZCSBbpQTFg2KTY3fjbR4nY2RYv
	fde7eIwUx7US2Pt3iwT4QzJEbA+HH1BjCDsw6SK5OihAisE6vvb8rOJzEPE19OGN
	bIzWH5vKddGEH8parhZUo5LYFtrG6hrcF36zWrCFpCpbRKp7suZDmXtCRX2Sg4te
	Fu/6BS+6cnSjrI643V+7Ur79RdV3niM3cabvzGXWVW0HaMmyJ85CQzDNodfovqw7
	qcAwgncBKTjcFkxUKeUH7TSB963MZafTJOwX4lxztuoytpoL910tldAEGDiMz3d4
	8KKOKoB5boXq5/Ej8OP5mX2UvUhgYDWw5q5+NSEQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g537c0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:31:06 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58GCeO5a022467;
	Tue, 16 Sep 2025 13:31:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g537c0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:31:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9vsnn005929;
	Tue, 16 Sep 2025 13:31:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxu48fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:31:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58GDV3KU26542484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:31:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3791120040;
	Tue, 16 Sep 2025 13:31:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2884F20043;
	Tue, 16 Sep 2025 13:31:00 +0000 (GMT)
Received: from mac.in.ibm.com (unknown [9.109.215.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Sep 2025 13:30:59 +0000 (GMT)
Date: Tue, 16 Sep 2025 19:00:48 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
Message-ID: <aMlmiHATn5WHUcSM@mac.in.ibm.com>
References: <20250728055937.58531-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728055937.58531-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vRJY6iQXGbzEferAhLtEWP6AL0cK4Xap
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfXzLmlqbRrP6wS
 pxd8eGkg8nTEPPLsRnAlGpFtxDl7FiUZD9e4mewOR7xmWtyt+o7fRTiWc8jPgbJgIdfY1WTggxn
 U3MdoztUEFHyw/5QY4+q74EeNKIwbjaNIrkAOwrOu0qF6FLXiVDXAgHaoZXtmA3Jbb5cpiy2iFE
 P1Z1LwgmFaLigZHQ3mdFRljCZVu0+YofXAUqMiK9miQUeTuJ5saNYLWXrN6agNv2hR6tLEXJRWV
 IZNxcuW/jFWRN+Ljd3V9bdnXyvzs/STVP7/fYsl6IbFJYllcA0mtbt2e8AZoOJub9EOMOZos148
 52n6iRuhbY4pq3gBwaonJattNwD0mBVUC+mDZZbjtxl8wzzsNBBXuyvp0ccnS6dgHbn5hG3tfAj
 s8Y6t0MS
X-Proofpoint-ORIG-GUID: TRA8eS2hPVamDhbfiBHzGwjl3nUTmpW0
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c9669a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=4H6ACr21Ec4LRm_unsIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

Hi Ian/Arnaldo,

Can you please review this series and let me know if any changes are
needed?

Thanks,
Gautam
