Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B6E2741C2;
	Tue, 29 Apr 2025 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920591; cv=none; b=azDveMGa1DcdD0vq2dHB7Y3waVGuug81DiTh6h29rly4BQbc2QneZcPIFln6c/3ABvl6zfzfqHuF1dSIsOz/6Rl514MxS5TvURjmMht+aLjhi+/A5aqqj6D2vW05SlSUGf5nPPuvl4kYYqhR0x2SiH/Dp8TRGtrP00JTfQDg7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920591; c=relaxed/simple;
	bh=873o4zG4rWdsqZx5RoDf2BmYwZe7j3rvQ8zTJTDrBNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jir1D0OC7TsuUBH/pBfWC7nVpguGw+HWxfrIt4yznYDjQoY/LV4NpV0ArJ4mo0vIdFExQh/Cx5k+kQd5OeGuEtVe1aSmCw0Lo0B89UV9l6lfoJSrLFGoIXbWD6VdURvBmhMy6wywb5a+U8sW1hdBDeIJ5XJl9u0Xl305MV1a70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92FC11515;
	Tue, 29 Apr 2025 02:56:22 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3C4D3F66E;
	Tue, 29 Apr 2025 02:56:28 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:56:27 +0100
From: Leo Yan <leo.yan@arm.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Wander Costa <wcosta@redhat.com>
Subject: Re: [BUG] perf segfaults when combining --overwrite and intel_pt
 event
Message-ID: <20250429095627.GI551819@e132581.arm.com>
References: <CAP4=nvTab7BnT4uu0iCuFJpZ-_MdY-MYU+Q25QnpygEZKmsQ8A@mail.gmail.com>
 <20250428101234.GB551819@e132581.arm.com>
 <CAP4=nvQ_7oS5ZAsKmOd_ORg0tyHS=B+i2m63K=TLg22rTEiRGQ@mail.gmail.com>
 <20250428124727.GE551819@e132581.arm.com>
 <CAP4=nvTdD=eKcO_sJL3G7U0KxRTQ6XjJeJxNrmeD3n8UGBv5+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP4=nvTdD=eKcO_sJL3G7U0KxRTQ6XjJeJxNrmeD3n8UGBv5+g@mail.gmail.com>

On Mon, Apr 28, 2025 at 04:16:58PM +0200, Tomas Glozar wrote:

[...]

> However, the data cannot be read:
> 
> $ perf report
> 0x7620 [0x30]: failed to process type: 71 [Invalid argument]

I can reproduce this issue, it is likely caused by failing parsing the
PERF_RECORD_AUXTRACE sample.  I will look into it.

Thanks for reporting the issue.

Leo
