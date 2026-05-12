Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E182DECA3;
	Tue, 12 May 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602742; cv=none; b=s4UHbqq/62/DRZvpHbRRyG73mVPhnWtLmydSEgFXPE0hf3cMBz1dJBcHn9M6rcoJIIj8tZ2TagBVnEBP6r+cQ18AJKCzrMMItRWy1irKMkyoBMl3DGT8wRRYgd4F2mTyZAiKCDeKFUAVzOHPiaPEBTlGfQikLk4++QmWVJlcJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602742; c=relaxed/simple;
	bh=G+xxUvD3/6YziyvvV1TwPiCMcVKKAKJV39ZlO22xdKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t859GfD45hqcxjjLj3psLGOYhQURW3q4Brol/s/5zZrbxxAyflW6u42GNMUS9GR6Y6BkdbirWD4+vLqGrI3dpXf2zxZ3zfZQivZ8K5KNGgh2LLZqeDYsJxx+LVWpwX2amBR+qj75dxxENdbEXSGZmBTQTi1JuulLIrwAiNpd/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ktjn7G+e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ktjn7G+e"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CC1uT13185041;
	Tue, 12 May 2026 16:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6z439V
	2G1VDIajwRj0Gyhys3KSSSaZot9X5haPq7B/k=; b=Ktjn7G+eK7d/IRLiF1pvE5
	9zA4N07Xags5Hay/MrARUuewUsIHwesw4H88I+tAXGy9fFO41pZXWWMJ48+63r1P
	a7ialwG42+IJp21OByyAw5x8JKeh/1S0LktkAWWdpeJsiZHM+1GzIaWveoQYT2B5
	fmVO8vdpiY1pGkxJh1RnNgPow10kqEsPUiqLbtI5k2U1LLlC2MTXM9BlpQqOZMLG
	Zfvhszft178ha5nKU9APBdv59iEcJ9TmyrVNp1dQ048WhVRThYtMQEwnBeKdP70Z
	oFrUUdJ1k478swlEDDjqkP1NTM3NTT4mbDbEVwZPr9/RmbwN0DXoiwZsclgX3TcQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5byn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 16:18:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CG9eIt003341;
	Tue, 12 May 2026 16:18:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgkvpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 16:18:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CGIhwf51970480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 16:18:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B9820043;
	Tue, 12 May 2026 16:18:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3607D20040;
	Tue, 12 May 2026 16:18:41 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.72.48])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 12 May 2026 16:18:41 +0000 (GMT)
Date: Tue, 12 May 2026 21:48:34 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, james.clark@linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf kvm stat: Update the exit reason mappings
Message-ID: <agNS2p8vXm-Pkkfv@Gautams-MacBook-Pro.local>
References: <20260512120408.59332-1-gautam@linux.ibm.com>
 <CAP-5=fUzQRCpF4U_0dnPxrx5sa3U-XbpLzn=c=EbeRsCY2=dPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUzQRCpF4U_0dnPxrx5sa3U-XbpLzn=c=EbeRsCY2=dPw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a0352e6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DYoZp0UIEKPuHAnjvS4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 16iVy6Wvt1Q8jnNzJFkzA05RMkKFjXKw
X-Proofpoint-GUID: 4fs-letQ0qz1yJPy_QL-8kgHd4OyIFpa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2OCBTYWx0ZWRfX0OUWTdOzyXaP
 fuKJ+upovhm5ZiE8MPplnrj5t1iS41Ub5dvACxf+LLnUdVJUP+7447fgLG+9hIoMawezXZH0NIz
 zonokhx4MZHSps0hEZ+9qLEuTH6gc7i8DMK0BRiO+FAnZmHdh+x5PCqmTDN8cWoSeHic9tHp7xC
 wjO/q1A8vYK4MYpguJ9b1iQS91jWNZhLckY+Zu7RmooP6k1AWMWiMC2xiboJg9+ABx8rxec/f0q
 22sI/hYYVUUSxwEZAA643YDn2J9tTwVSakg6AvVsmeXjsQ0KUAs9Y45XhsyBp3ilIujrhGFMnmx
 GyJ3Bxf1zWb7rN2bW3PMXEpVf+b1CQk4gzAVj2T3fF9GhZeMXHylrWDzccHG+jVIJQOgsDgmDkT
 Nq/34R7jqaOmVhFE1ENzM/Lq1/y2E53GnmBY5QczEMfHyHXn9kuW0lmblpyvifMTwD0rHkenJTB
 I7QRiMJCVbJDlFJasJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120168

On Tue, May 12, 2026 at 08:25:08AM -0700, Ian Rogers wrote:
> On Tue, May 12, 2026 at 5:04 AM Gautam Menghani <gautam@linux.ibm.com> wrote:
> >
> > Sync the exit reason mappings with the mappings in trace_book3s.h
> 
> I see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kvm/trace_book3s.h
> Would it make sense to have a copy in perf and use the check headers
> code to keep them in sync?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/check-headers.sh

I'll take a look at this, thanks

> 
> Could you add the commits that add the H_VIRT and H_FAC_UNAVAIL
> definitions? I don't see them in Linus' tree yet.

I posted that patch earlier today - https://lore.kernel.org/linuxppc-dev/20260512115724.59299-1-gautam@linux.ibm.com/
should've pasted the link in the patch


Thanks,
Gautam
