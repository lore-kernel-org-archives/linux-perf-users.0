Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813A1C7015;
	Tue, 25 Feb 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481348; cv=none; b=fdVUMEISRLUCd7sMySHw5iwHe5/gr9Ktkzt3qbQQsYqbz1qyakBu2CMBrjM5DYr+z47leRQLC1SGzMSVGt9qPuDmL72+HZS5u1XxdidjWoB4pbwAQdx1pDL0kKxd1s3ku3h32MCzlUUBVJBxqV9mrDeSM153OLoPJeItVL5KlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481348; c=relaxed/simple;
	bh=QcVbB9YTd76TFlvMGuHyc13wsSM8tZOkheB7ESibszE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEdt/ZvHvkDCKVhPrCRiumx0HYFkhF7m/S84nsbN0E4mASdXRND6wyR8HFRFqflpVrH5BBviR5AslbUg9sIgjoRv2jd1foRekApdCmIMaAxaDUibVF5K10mJPcVVirhB8r3QizeP1sz9m6nqBDod9jM19dO89CAQXsKso90SqB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LzcJEJPO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LzcJEJPO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QcVbB9YTd76TFlvMGuHyc13wsSM8tZOkheB7ESibszE=; b=LzcJEJPO510tbX4MfrEKTDgYGH
	A3Lm1sijJVVSio3eYSHWdxCr8yYETRKLlUunKM6rku5V+Vb2fTKdWftFvTQKDCr5Tzcp/RACvAnRy
	xHDdtPQZ6a+wWpEh8ThOiic6cMB/aXgn+ttQBQ7JbH6zS9Gupq6N6q0+KbVF3xjL9F/WQ0gr5O3yX
	OiE43VxRjU65qmwFY1yNPbPOdu7JTiikQgwwT/MR7C9dMBFAI6h9awnW4vIscTbENPDKass0H26TK
	Xylzf8ShnCrDE3+nScM+z92qpPGLwydAnpeXzuxE1a1Lcc8ZCPLPEVilJApPf2KF0Oa/+HEHuAr4C
	obGv33rg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmshe-00000003Knm-2jQP;
	Tue, 25 Feb 2025 11:02:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4BAF3006E6; Tue, 25 Feb 2025 12:02:17 +0100 (CET)
Date: Tue, 25 Feb 2025 12:02:17 +0100
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
Subject: Re: [Patch v2 11/24] perf/x86/intel: Factor out common functions to
 process PEBS groups
Message-ID: <20250225110217.GK11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-12-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218152818.158614-12-dapeng1.mi@linux.intel.com>

On Tue, Feb 18, 2025 at 03:28:05PM +0000, Dapeng Mi wrote:
> Adaptive PEBS and arch-PEBS share lots of same code to process these
> PEBS groups, like basic, GPR and meminfo groups. Extract these shared
> code to common functions to avoid duplicated code.

Should you not flip this and the previous patch? Because afaict you're
mostly removing the code you just added, which is a bit silly.
