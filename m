Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8976144C8F;
	Thu, 15 Aug 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742243; cv=none; b=tCGGXBou1Bt8NWIadr6vtYjkHeUi7KyKL2HusT1Eho034VZko/qDS924CwZP3g99eq7tb3vmkI2iodsxtp5I+Pi7uugq0+1At+NTQDUZGvYp+0O4Ar52gURv4L9Ip2o3ZEmc0Q+PBZ1GvCJ3iNjPQnWyNAtlS0mKt0lOfNh64aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742243; c=relaxed/simple;
	bh=WflzLsFCxzKcRBpC/qAaqkvYHFzCVDgfmiGDqMQk0tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asu6lhw0ZVqfiZ3HcKt7e+u3u6qyS3tmY4QkANxa9pdm4IV0CVNvbpDehGuH196a1xmCdgWaZsOlysw3KdmoRcf/lVVJ/36G3VbH0N2+DsWVhUwQRryoyd95mdFGUpRwL5WUUWR3zRJvcrSeDyypHSUmPDEFOblkj0eqkuD6qWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=m3KHMlo2; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="m3KHMlo2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1723741902;
	bh=WflzLsFCxzKcRBpC/qAaqkvYHFzCVDgfmiGDqMQk0tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3KHMlo2XEwevTgz2V7OewvXnHufbm3HNIxmynSvCb+FVc5tnxlbrFOzAXQHq9A3r
	 QwkNhrZNVUxwxF0fRQRVQNZfR/VUtITrJ8FAqCJj3Yh1IFIir6LawMrN201FoYgItT
	 rQZEV1wLHfhBdynfkV686c62G8fZcHxXXvHa+bDY=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 019505EEBB; Thu, 15 Aug 2024 19:11:41 +0200 (CEST)
Date: Thu, 15 Aug 2024 10:11:41 -0700
From: Andi Kleen <andi@firstfloor.org>
To: duchangbin <changbin.du@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf build: Fix up broken capstone feature detection
 fast path
Message-ID: <Zr42zRmI9SuPO2hh@firstfloor.org>
References: <Zry0sepD5Ppa5YKP@x1>
 <76c92af3b3544f8a9fed412fc287947d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c92af3b3544f8a9fed412fc287947d@huawei.com>

On Thu, Aug 15, 2024 at 03:26:22AM +0000, duchangbin wrote:
> Hi, Arnaldo,
> 
> How about workaround it by rename the 'bpf_insn' in capstione?
> 
> Change test-libcapstone.c as:
> 
> #define bpf_insn capstone_bpf_insn
> #include <capstone/capstone.h>
> #undef bpf_insn
> 
> I haven't tried it but seems feasible.

Yes that seems like a better fix.

-Andi
