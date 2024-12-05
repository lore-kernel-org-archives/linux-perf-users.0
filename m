Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94E221461;
	Thu,  5 Dec 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424256; cv=none; b=C5ESc6y1aZ49VFqCTCkz7VAhcPBnQeqmWQ21nW5wr76YxS0zAD0+2felkNToVPrAqJ42YzD9QBTRZjQCZQ9Wo/ATQ8cu3amsFXoNZHbRHk0yNP82oyrieJxdLvDRwkdIsn9q8Zn+T8J5tXLVdRYcwhREbnQ/b//msTGZyKXxfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424256; c=relaxed/simple;
	bh=rhyRws2RvyWwmmlvymd4NvI6X/QYo5gUNBZJxdn0cr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKEiypyrSfySoN5M+1qnBal+jlpNrWmc2Pwd/S2lXKoBLmB8i0diDEfgAw7eQXsCTEFNd0jcyRwbd9hToj0y6yP6DtoT7i0+6xywMKI/WehZMpcrTG5ylJ+0HO/ZtuCV6YBMRRQLN3Nm0DunlpT6wimY+iTKgwJWL5ofwK38NV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mu08w1mU; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mu08w1mU"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HhmRj017980;
	Thu, 5 Dec 2024 18:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=YE
	A+a4VeBZqyZzyZ1JUkJu7XAw0Og0L1SG6vVFY10fs=; b=mu08w1mUyuJkNJWyGG
	Shvl51kHQQF0MBCZQWbvqFaOwZv8FxyVGkSrws3SSLWO6dYMsegazV/H/WEnE7C1
	IYXIVtRR5rtkVut3eFXFCJucyTPFC3g+ikNFqbVLr+iGotU3RUrg/y4F7677wLmU
	gR8blKV4HlKsKTplQQmQj+zgBHKPfNi1v2B5NUjqsqEm4sORLbMnD9QXzcb0qWUj
	pbQhwtyamoFFLrzYM3w2L/8UJT2KLs2utk3Jia6Nwo5KQSZl3DgRL5ONRNs1I1Tz
	BIzx2BqUIh0KInDoO9yli1gK9mIu2AEbgyKYELluUZFJ6PIS7NAg4Q1d5R1yUioH
	Kr/g==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 43bgtmr67p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 18:02:08 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 18E19801610;
	Thu,  5 Dec 2024 18:02:08 +0000 (UTC)
Received: from DESKTOP-V47QP3F. (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id E4AAA801092;
	Thu,  5 Dec 2024 18:02:05 +0000 (UTC)
Date: Thu, 5 Dec 2024 12:02:05 -0600
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Increase MAX_NR_CPUS to 4096
Message-ID: <Z1HqnTwKNvWucrEd@hpe.com>
References: <20241205165118.153148-1-kyle.meyer@hpe.com>
 <CAP-5=fXu2Ye22EAOp8jNEaVHmmNSx4gJXNL521ViH5x6w-bLBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXu2Ye22EAOp8jNEaVHmmNSx4gJXNL521ViH5x6w-bLBQ@mail.gmail.com>
X-Proofpoint-GUID: xjQA8USmAoiHaT-vXbatMwMapcI6ijBd
X-Proofpoint-ORIG-GUID: xjQA8USmAoiHaT-vXbatMwMapcI6ijBd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050131

On Thu, Dec 05, 2024 at 09:36:07AM -0800, Ian Rogers wrote:
> On Thu, Dec 5, 2024 at 9:01 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
> >
> > Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.
> >
> > Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
> > and cpus_runtime will increase from 81960B to 163880B.
> >
> > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> 
> This is very interesting, thanks Kyle! Just noting, having the same
> #define in many places is clearly error prone and there are other
> redefinitions of this value:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/bpf_skel/kwork_top.bpf.c?h=perf-tools-next#n21
> 
> I wonder I can refactor `tools/lib/perf/cpumap.c` to get rid of that
> constant as it is only used when parsing from a file/string.
> 
> Could the kwork developers perhaps look at their many uses? The other
> uses in the tool may be removable too.
> 
> Wrt this change, perhaps bump
> `tools/perf/util/bpf_skel/kwork_top.bpf.c` too and then we merge that
> while trying to remove other uses.

Sure, that sounds good to me. I'll send a second version.

Thanks,
Kyle Meyer

> > ---
> >
> > Tested on a 32 socket Sapphire Rapids system with 3840 CPUs.
> >
> >  tools/lib/perf/include/internal/cpumap.h | 2 +-
> >  tools/perf/perf.h                        | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> > index 49649eb51ce4..3cf28522004e 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
> >  };
> >
> >  #ifndef MAX_NR_CPUS
> > -#define MAX_NR_CPUS    2048
> > +#define MAX_NR_CPUS    4096
> >  #endif
> >
> >  struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
> > diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> > index c004dd4e65a3..3cb40965549f 100644
> > --- a/tools/perf/perf.h
> > +++ b/tools/perf/perf.h
> > @@ -3,7 +3,7 @@
> >  #define _PERF_PERF_H
> >
> >  #ifndef MAX_NR_CPUS
> > -#define MAX_NR_CPUS                    2048
> > +#define MAX_NR_CPUS                    4096
> >  #endif
> >
> >  enum perf_affinity {
> > --
> > 2.47.1
> >
