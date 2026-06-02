Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822351F1513;
	Tue,  2 Jun 2026 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402026; cv=none; b=UvU/JxP2u2RB8tYNtu++xNsdsc9ykjHkOZyQ+zAK8WNpYQLW24FQKH718vQ6SHW1HPWEjkzKHhO/iR3nJTq7Tk+OR7ZztsWOvrs/6MDTsWu/BiFzA4prWUZLd2AelTYCQFIyq74ralD98aUrzfRx1pQQ/YSKtwIslCA0N/sr4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402026; c=relaxed/simple;
	bh=njIhGSVu74a9H5gu1xZT49dHP0J9KtPaenedAzvXZGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F27S/3QyY13DrruKvzIlUM/r12Yrxfi6/Rfm70rhrYSs5kACDi+Tj6p+w7TC9Pf9Q4zwq/eSYvytkl6vFNEmSQagl67jD0qJnEZQNaK3yxtZ8zETgsWppyKU6lrI2ptXSbY6ozfvZrrHwGMANWaKzeT5grbCLaydW25GCQhXtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c+WO+MfS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c+WO+MfS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6523eAid2012063;
	Tue, 2 Jun 2026 12:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WbECGbQlQcCrfawRKmg5JfF1erVYBw
	WpopIZGKfqjMs=; b=c+WO+MfSCrhWwkHDFHrr0XTyoPIwd4A0EZ+Y4pbRlyAh6C
	mDES61t/7ajkBf1N6yV8xbXBsm5UuK7JIsLcWO8XwerhqEHyLnaqYcOs5e26HuGw
	Tvdy09WDY0WQrJ3ojJkxlZ4fqblrfhuROGgHqJzUrjfUgheLQQdHb9UisPsQqE/L
	d5sDytHmGQUSrTWAT3j7XzdnbcaXo2IwAVa6/z6NyBEBA9NU1WLsu/f4opScZeZl
	5je4DhkEyoWWvSfctsiSxmAgo0gcf8pE0Gl0fMOHwbeS6uaaWMQ+pDRkxSH6iqMP
	crPId8eQkDYSrNAchZFnOkfeGb5AyCU6V0F9kNLQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae5cvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:06:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652BsPWO012143;
	Tue, 2 Jun 2026 12:06:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvu7y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:06:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652C6faZ10158342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 12:06:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 997772004B;
	Tue,  2 Jun 2026 12:06:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB8A320043;
	Tue,  2 Jun 2026 12:06:38 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 12:06:38 +0000 (GMT)
Date: Tue, 2 Jun 2026 17:36:31 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Tejas Manhas <tejas05@linux.ibm.com>,
        Gautam Menghani <Gautam.Menghani@ibm.com>, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script powerpc: Update the hcall list with new
 hcalls
Message-ID: <ah7HRzA8ddE7dY90@mac.bl1-in.ibm.com>
References: <20260512084654.57729-1-Gautam.Menghani@ibm.com>
 <61c8d600-72b4-4320-a1ff-18e061569f24@linux.ibm.com>
 <ahoo5dI-6fVlFvvR@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahoo5dI-6fVlFvvR@x1>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1ec756 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=dQQfcrzLAAAA:20
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=jRNdTEU3ykmnNMFuCJYA:9 a=CjuIK1q_8ugA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 2APIun1A24ZywhHYFT-YbQOBiZuQrNGe
X-Proofpoint-ORIG-GUID: 4m140wurgwLKOHpaOI8Nky4Xcvr_LT5J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX2i1j5XJ14zmw
 zoOcM30C5MSh7Coa4t6ol8BGPyjjhE0+dTaEV951Mc2MD7pEfTvuPpgDxUyzq/MDnjBJ7yc/tc8
 VnsUMOna+8pKPL627nzXHr+1cEkdxpo2OU7WL5U5BzIFHms7Ggv0dKonCE3wZtJf5B0h66P3ajS
 BpS0Ldpo4DLdLwffP8JG1r2W8opIrCjFfpvpJYVdeyN5dBsN/mZzuZmsHPmRn1F0Gu6MCFofc0N
 0le8LIfWZZWCR/s3IEgG70gu4t1dufS4dAQb3UXhpbMKuqsQ8DI/48MQ65JYZMzJe8N2PPTOxso
 ayAt4l/UDD37yhDkbgmJ1YuivTEzOuY0QVlESkBek3OKjIXMZG25mml1zrnTQ9cxvvBpnc5r3A7
 mDbjIvSfHGv3otACarzFEJhnDQsJkwSerV9oj09wST3x5dXg8l81CgIFrbi8Ypw6kyGUGsxN/T6
 VE9WuG1ocWgtlM7A1Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116

On Fri, May 29, 2026 at 09:01:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 20, 2026 at 09:25:08AM +0530, Tejas Manhas wrote:
> > From: Gautam Menghani [1]<gautam@linux.ibm.com>
> > 
> > Update the hcall list with the hcalls in bcc's ppchcalls script [1].
> > 
> > [1] : [2]https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py
> > 
> > 
> > Hi Gautam,
> > 
> > This patch doesn't seem to resolve the issue where numbers are seen instead of h
> > calls.
> > I have applied to the latest upstream but the numbers are still visible in perf
> > script.
> > Also the command doesn't recognise python-audit already present in the system.
> > 
> > Please find logs below for better understanding.
> 
> Any progress on this?

Yeah, sent a v2 - https://lore.kernel.org/all/20260602115644.8133-1-Gautam.Menghani@ibm.com/

Thanks,
Gautam
