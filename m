Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D44366DD9;
	Tue, 24 Feb 2026 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922899; cv=none; b=lv8cqscuf0u+JMxDGgY4znPNRjS7PdHFHB1v8YQlJN+gcExd45bpxZhM0isVsX9UB4PSx3dW2jdAbSvh1w6CJ42JqYTT58mDlnCsyZIREeKRw3b/4GizAbQu8wHRsTOq8xtcemOR9DZjpG7N5udGVlAPVMvaCkWAQwtYYMfFVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922899; c=relaxed/simple;
	bh=OPwMTZWQmzw+6Xa3CNcGXsn5offzw2jIHRKSeIEW9o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcxzP9GpCFsKrRas+0ocg3wm66pa/b0BPCsO8URW57ww433f0cIcMYBm3TSx5xLg7pD5EF8Ld/cMQZdS8xpDZ2k3BVJSrnXpvUzeiSvmwuivCqYvUlRjQeGsKTbyq23SsJGV5Uhjf89XV8Y+IKqABGBUlbCk8UmhUy0XHSVxIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jtAfpbVT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jtAfpbVT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OPwMTZWQmzw+6Xa3CNcGXsn5offzw2jIHRKSeIEW9o8=; b=jtAfpbVToV5pGfAUIriftlmEtd
	grhIHAD2SR3tLyqTldmXkDaSTrIl4xvbwgOceVOAFcqLDFtpLzDbV0tkUhmy2SL6zZDc+dX3fkfTO
	nlSz5M6CUcfD1q6LTSX6P76TUpfzB1fR/Cc0eX/Jbl8CS9/KACpkB/hVfTxB0fJRs8UNQqIGbSmuv
	wZUtZ4V3PgZJ/Yzjyt0c67S9ovhN1ovWwe8cLzxk/lygrx2usidPXqsTma9wMSABdUbL9Ri1xIMd+
	59ehPIuFVTtRwyvuZJArnuKZjDSZ5ZLKh2o6K4PS0RxAY9EKhtRVJGxObSv+aNjgWy9J6qmK1jg65
	cz7+U6PQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuo5N-00000006hUZ-3Wje;
	Tue, 24 Feb 2026 08:48:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48CEF30095A; Tue, 24 Feb 2026 09:48:04 +0100 (CET)
Date: Tue, 24 Feb 2026 09:48:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Linu Cherian <linu.cherian@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC V1 04/16] perf/events: Replace READ_ONCE() with standard
 pgtable accessors
Message-ID: <20260224084804.GU1282955@noisy.programming.kicks-ass.net>
References: <20260224051153.3150613-1-anshuman.khandual@arm.com>
 <20260224051153.3150613-5-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224051153.3150613-5-anshuman.khandual@arm.com>

On Tue, Feb 24, 2026 at 10:41:41AM +0530, Anshuman Khandual wrote:
> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
> anyways default into READ_ONCE() in cases where platform do not override.

This is a bit silly, no? All of them should always be READ_ONCE(), with
the exception of pte_get() on PAE like scenarios.
