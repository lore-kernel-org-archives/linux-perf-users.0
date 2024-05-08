Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5945017C79;
	Wed,  8 May 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209453; cv=none; b=Oz6ZYNsqR/v/vsp/8Xuor/3wZ3/H1zkWAsKgcnCnz8L7zaX0SwMpvr1Y87olpg1NfEGI8XU16Ct8REO2CLdSEtL2KA7Pf9MGT+TiQ5O4pn0qaC5mS75s+eo9jwHRcGBzlUk5DV7alUpGDsexBZR/1Fe21cKdEqLst9Q4fKxjs1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209453; c=relaxed/simple;
	bh=CzH0IYNCJc5EFl+zLkOH4IRgWt4Y1NZ4kSjGdtP2xfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IP30pJGcT6A8lJrTLdyxlHWwoXU281gpQeQzl/dr1GKlkk1BRqibuPHEqPTkzx/5AKOCrYLjYMLxqDmwobvYgvaRsBSL8qkWcUIvREVXxepWga15i+WC5k3CU1pR3WZBwq/kXErx4bD5a7pO3kX6F22dk5SB7eWVpuPp+EoPNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=2WgMnFrj; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="2WgMnFrj"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 06C3514C2D7;
	Thu,  9 May 2024 01:04:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715209451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=7awdW0nZMf+wLX5TxklzvUQjE6+vqp8L5Rc0ppMrkmk=;
	b=2WgMnFrj7l2n4mj8dMoJoju5T5s8FBvESB4Je9g0vz0Wo2gXwekEOENoir7pGeiT1tw2Vg
	blk5oPan23XyZMkwArtEc08L9UK3LHpPQ4EwZFJcoeh2XYNI1iM1PE6qStSbFgo10UYPeD
	kW9ROc6gq07rcfMjn2Gr8Va9gP6aduPzSqJvL+rz2sT2fHMr7x80l/x+i3FdU/nmy4KFOW
	2BR8UQ1Dz6V4m4EQb+4SzQOe9lIBPbB8lS3mrOh29xXV/Eq2dbeKR9c55XD0JnSJ5brqmH
	nrRxXFD+9/Q4vcLay1nMxrMzwHXrwhf4ufOfy2B11+0sr0kp72agPz80gBrNIg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7ee5b842;
	Wed, 8 May 2024 23:04:04 +0000 (UTC)
Date: Thu, 9 May 2024 08:03:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf parse-events: pass parse_state to
 add_tracepoint
Message-ID: <ZjwE1dVbJVUN34dP@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fWRLcsgMvBJnJNBt1k1O8vDqk2O6V2v2k7Jf3nY=yA+cQ@mail.gmail.com>
 <CAP-5=fUmeyd3BR7njJEDQ-=qkpvLPMoQO-7De+3mqLaSOoZZxw@mail.gmail.com>

Thanks for the review!

Ian Rogers wrote on Wed, May 08, 2024 at 02:37:16PM -0700:
> Nit: evsel__newtp_idx typo

Fixed in v3

> Fwiw, I think the idx value is possibly something to be done away
> with. We renumber the evsels here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2077

(I'm not sure what's immediately actionable here, so I'll consider this
a higher level comment for later cleanup)

Ian Rogers wrote on Wed, May 08, 2024 at 03:47:29PM -0700:
> Note, this isn't applying cleanly to the perf-tools-next branch on:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/

Thanks for this note, I've rebased on this branch for v3

-- 
Dominique Martinet | Asmadeus
