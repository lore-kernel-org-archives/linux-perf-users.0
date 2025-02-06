Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9F2248AC;
	Thu,  6 Feb 2025 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829130; cv=none; b=WjrUF33dp3kL67P02qIYStxLJJjvkw3YvaJBEWH0ab58n3L3Nx/cNVJlU2tQsiHSn7fibvDUx98DGkN5X2swz7mG/ii0b0tilun06ax4LcNAVsi6LXWgeYbwiZeqFioLy9HdzWxSgg2IrB+v0rhvoxUl9Pstd26EiPwZmde/zos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829130; c=relaxed/simple;
	bh=ApYFjmEsxpSM59JtDQ/pIORkEOwlMgn2oMqmpGvZh3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPlIkjbiFyv2V4kSc011uZSbpOvkruGaxtTb6yEVahEwly82RtDL2ufvc6vB5KW0Agzo3wRyPwz2tQQAUn5XHD77zc//z3M+J1Du78WyL3irNDv/Cgt0IaRVzB/bhG4vj5O7VZRFh42Ju+87N3K67QBRAhD+8w5ky2X7eCs/kNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ph6QGPgz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ph6QGPgz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ApYFjmEsxpSM59JtDQ/pIORkEOwlMgn2oMqmpGvZh3o=; b=Ph6QGPgzdBy+pCoIyHrAfu5plb
	CZjFP5wPOe7OQyK6pKx2Bbtn3D5848oeJVx8fkbvlVf+R+oZBOLJ0vPT9/00Cua8W+VWLx20gGT5Y
	4uR4Ia/Kff7JnTyad3PeMm1AIhfNDlinQQrPny+gTOZrtn0NT9TckA0/WX3a4ZyclAmj86UGuP0WF
	n2BGI/G4wZleudbI6cMy16q3mMkuVOh7MbFuZPEgfQG42nYonGfg9qSwuZ4X3Yta1ralq+vps9Vhz
	C2Fnu0AT91OZsvAc3fjQZUynKi69GCUhiGjS9XsSxts/ym0LEavWt0l8qrkIAq2+V5rokAXX8nJMz
	ZlmF7QtQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfwsz-00000005fpe-1O10;
	Thu, 06 Feb 2025 08:05:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DBF8130031C; Thu,  6 Feb 2025 09:05:20 +0100 (CET)
Date: Thu, 6 Feb 2025 09:05:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	shuah@kernel.org
Subject: Re: [RFC PATCH] perf/core: Prevent dereferencing NULL pointer
Message-ID: <20250206080520.GG7145@noisy.programming.kicks-ass.net>
References: <20250205190608.93508-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205190608.93508-1-richard120310@gmail.com>

On Thu, Feb 06, 2025 at 03:06:08AM +0800, I Hsin Cheng wrote:
> According to coverity scan check, there's possible cases where
> "ring_buffer_get()" returns a NULL in "perf_mmap_close".

That makes no sense. Having a mmap should pin the buffer.

> Use a "BUG_ON()" to check for NULL pointer existence, panic if it does
> exist, otherwise it's safe to dereference "rb" and access its members.

How the hell is a BUG_ON() any better than a NULL deref?

