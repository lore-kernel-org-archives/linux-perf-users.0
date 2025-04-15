Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10CE145FE0;
	Tue, 15 Apr 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725428; cv=none; b=A6eHYqmIvdQ6mQRJlt+PDbDOv3mu/+MzzZr5iXMD0FrdsOoIR+qmSTGS48jpmYEZ2TRmqPNvYfJCUqn/1XGGln5ZoUCA2ZRJiymXyXlxLbg6WMEXURjM+25JMl6yZtkLUtWRL5z87OIGiiiPLGPa22EUmOAdhSgs3SZrwLyO5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725428; c=relaxed/simple;
	bh=0l8w+naLLR2m9/EluSyXqkppDcRiCHUv816MhV+FDbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eac9D+JNLpRMcg+nYEP88IsZVt6IxHf2/SXYHpyyKiQOtr9m2t+ah8H4LG8fYF1Sb9xTL3F98mYUa9bum25il34bItblvRqOLBFkOI+M+Jw9OEVRbbt6Piv3NqJVxQlek//s7AjxfF6077YoX/cn5MWlQm4TMTpu0Guu35JT59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CAfllJvk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CAfllJvk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0l8w+naLLR2m9/EluSyXqkppDcRiCHUv816MhV+FDbQ=; b=CAfllJvk000h2k9cx428yTFAJr
	n3gYvMUBu3Wfscc3DQte0kLFJPHKr3NrTD67NsdZ1qyjoyQ3nENzM6UXS25qbRkAKdMwc+LBxxwqe
	61levoJoAvaKZEgtwTCK5ZYg9RDHf1gidiXWIgMv8vZgLxak6kIBC27TN1Sr/wRivRtEHOmNmVFcG
	vMa4V5/uYtZuRPsxPBsXA3dlCBrCO1pUts5Q0uGWsI+VebwqYE7IscJnWxsqqf+ZJ1mwINFVuptwA
	IGxkix/yFGqRS1uRIyh7lwEX44qP89i5fYkyfwaub/Mv4kCUCZqaoWUKWwnvY3LfWRYql6QDbr8wD
	L+4N4wOQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4gmb-00000009u8U-2P5h;
	Tue, 15 Apr 2025 13:57:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28C4730037D; Tue, 15 Apr 2025 15:57:01 +0200 (CEST)
Date: Tue, 15 Apr 2025 15:57:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 10/22] perf/x86/intel: Process arch-PEBS records or
 record fragments
Message-ID: <20250415135700.GD4031@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-11-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415114428.341182-11-dapeng1.mi@linux.intel.com>

On Tue, Apr 15, 2025 at 11:44:16AM +0000, Dapeng Mi wrote:
> A significant difference with adaptive PEBS is that arch-PEBS record
> supports fragments which means an arch-PEBS record could be split into
> several independent fragments which have its own arch-PEBS header in
> each fragment.

With the constraint that all fragments for a single event are
contiguous, right?
