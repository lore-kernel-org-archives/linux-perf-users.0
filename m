Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D63FBB74;
	Mon, 18 May 2026 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106919; cv=none; b=n3G/8G2NAsiXEsHdLrlnC5dC9nCAmza2v7WUz9l3lQNJM4LYfqzUkpM1sbmSH3B+dnEgKBohhU4ruVvniA3Q7Sf93yHrDl+qW6j0lV1jotKyoPPLShQ8r3FXLrdoElECC03nCOxs+/ohxoY5+eb98WiWXJoVPjFeijw2UbdJm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106919; c=relaxed/simple;
	bh=qmcrosSgc1UoHAF/XqqpIf8vyh6/ihQbUAqwduKEFtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTHG5+tJPCfcQ/7gxWilEL8dlcAFEa33UGagW9rewu/JqLt/7fPjXk/wDKUxDHMJO4fWHgfQGP7jnTTbvZWUjAPOpyB0BJVn4b19WmhwcTLYbcMVQesCU0Cip1M7AiY/74NajOHAQi/h2Jf6/HUR0L+AL9bgn0poIULTgvKMAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ICaE3Bqq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ICaE3Bqq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I3pCsY3015276;
	Mon, 18 May 2026 12:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f4+rXp
	VRgrkbELwi/9AY2NbjQFiUzG9Bzv0hZ6LTzfc=; b=ICaE3Bqq31cSh2PshtOKXb
	JmfD9faz0XbXSXRxbMpDTIRFvVj8Um62wPV2ZF/C4Sz9C8ivNcVS6gE3ZNkGfV/Z
	cW9JfTYqqehQBmKxfbNbqOph2tBAf27BO0uHhzFnvOpbRqzUtqpBHR2k3uLSg915
	zMW7FZ1IQSvfjWLaNX4RbsVGK32qdLDUHCgAtbjV4udzEbcCUo6abXmFtNipMvCV
	/STpbJQMY+9LZYjIV4x8bLZnBuIli6g9EA5er/+/I4Sf7tVgEKRm44AaUf93fyKb
	enK4vP4RgILpt9SvbEGo3vUuHTgBTxlrA2tvE/a7O5cmdCGw7baunSxb9HFMWBVw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havyfrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:21:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IC97I2024884;
	Mon, 18 May 2026 12:21:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxwhdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:21:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64ICLXS225231898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 12:21:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFC6820043;
	Mon, 18 May 2026 12:21:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C482F20040;
	Mon, 18 May 2026 12:21:29 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.103.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 May 2026 12:21:29 +0000 (GMT)
Date: Mon, 18 May 2026 17:51:19 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, james.clark@linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Subject: Re: [PATCH] perf kvm stat: Update the exit reason mappings
Message-ID: <agsEP8NR2WkOPilU@Gautams-MacBook-Pro.local>
References: <20260512120408.59332-1-gautam@linux.ibm.com>
 <CAP-5=fUzQRCpF4U_0dnPxrx5sa3U-XbpLzn=c=EbeRsCY2=dPw@mail.gmail.com>
 <agNS2p8vXm-Pkkfv@Gautams-MacBook-Pro.local>
 <qzngq7lt.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qzngq7lt.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExNyBTYWx0ZWRfX7sT14UkVm/0u
 IngafRC3ikGJFVVaceB3rmqGSKkFmYZ+j+eiEHJi2Tf1TQViQ2IroB00aNK6bXL+Eu7LShB0Y0N
 iG33PvqSBKNSJygOfGnTe2P8HzGNjCXZubE0jK/N8bC5D/9f3+5ewPPRNJsfn1vFBgReOZYUb24
 pDoGWpwcWl/dN1Uf4Wi1G9UaoFosDArYhd7kJO020IJNK4LIrca57tYG60vOasx35pLny2+Z2r4
 SIcxzEo9Y6Z0wRhx7VDhdfq0JLqK/udTtGC8hEKFlbRcReBCd7KwHPil5Zcr0wVP0f412raBS5t
 Q67oCj+3OWy59GHRZBV08XNSUx+bidoX0/s0FC7e5kKV3rq+QdNPDttxKSZ3cigT+5jbie+WUKG
 m1Ov4s07FDmzFcpfsLfMXWarjMZe0hRFgImh64VTQ/U1Z1cA89sNPou9le4qu2IPy8Y7bL8qF9B
 EG7YviSaqOmLR5SRLtA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0b0450 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bP1jAfTCD8O6lo9rXwIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3KI73OW83UjFZ34a1Nlqp1jQpACuvLwo
X-Proofpoint-GUID: krEa4ham6ND4dYQPdWbxrr_OvI_j-cMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180117

On Wed, May 13, 2026 at 09:33:10AM +0530, Ritesh Harjani wrote:
> 
> ++ linuxppc-dev
> 
> Gautam Menghani <gautam@linux.ibm.com> writes:
> 
> > On Tue, May 12, 2026 at 08:25:08AM -0700, Ian Rogers wrote:
> >> On Tue, May 12, 2026 at 5:04 AM Gautam Menghani <gautam@linux.ibm.com> wrote:
> >> >
> >> > Sync the exit reason mappings with the mappings in trace_book3s.h
> >> 
> >> I see:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kvm/trace_book3s.h
> >> Would it make sense to have a copy in perf and use the check headers
> >> code to keep them in sync?
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/check-headers.sh
> >
> > I'll take a look at this, thanks
> >
> >> 
> >> Could you add the commits that add the H_VIRT and H_FAC_UNAVAIL
> >> definitions? I don't see them in Linus' tree yet.
> >
> > I posted that patch earlier today - https://lore.kernel.org/linuxppc-dev/20260512115724.59299-1-gautam@linux.ibm.com/
> > should've pasted the link in the patch
> >
> 
> For patches not yet merged and having such a dependency, this could cause
> confusion. What I generally tend to do in such case is, group this
> patch (changes in tools/perf/util/kvm-stat-arch/book3s_hv_exits.h) into
> the same series which adds H_FAC_UNAVAIL to trace_book3s.h [1].
> This way it is easier for everyone to keep track of the dependencies.
> 
> [1]: https://lore.kernel.org/linuxppc-dev/20260512115724.59299-1-gautam@linux.ibm.com/

My patch description is incorrect, there actually isn't a dependency -
both patches can go in independently. I'll send a v2 to make this clear.

> 
> Note, that we should still cc the relevant mailing lists, reviewers and
> maintainers to get an Acked-by. Since the changes in this patch are
> largely powerpc specific, so IMO, it should be ok even if it goes via
> powerpc tree via a common series, as long as everyone agrees.

Yes noted, thanks.

- Gautam
