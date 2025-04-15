Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9529A3E7;
	Tue, 15 Apr 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725212; cv=none; b=PRHPdcZt85z0J73sWOkJtk7LSi7aRYt4PxeCxHDnH1JlgyrwLCUOzWeg9ySRx7hlFtgZJFWGqgFi4PvbA7kKJHz2SavLlgqzWQtD5oRJdzhIif/WB8XA/rPX80aXUoi50zwf8lnPFoKsvomFwHMpofXdOkLgNxgwQtYx3aRCX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725212; c=relaxed/simple;
	bh=op8vw67cOur828GJU/2ZcMGdv1kRcb3KfkJNVv5p/rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLm4Xss2P7MRvwYT4D6F9tdczVKmFyiuIgGLDYffliOkyrg1i02jAUp9IyPFfr/TYmFbtZq00iT85CqT56v69b8EsGI9oXOROKlP22ZNwzIQir+ngXrX0sLQLPmKHHetbPYaxiZbV7x3QBeafgTOwu11aQPhI41pE24KEQNvvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qh02m+rA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qh02m+rA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eKkIqQ/T/g0xUsNwRjjkvlqAyXTb8q6GArFbtSlSXZE=; b=Qh02m+rAVahE4tMh/W9yxoCMwY
	vNns/r2Iqj241nUmBTQLz198myQYuhGkMmBgK2HpFhzysjpjgNgQ6NSg2f3LBtgU2oJA/w9hMocsQ
	u7IXjFY/vQcuC+GF6Dluafm672kPE2IaDky6ctfF59ZWr9kz5LqJlKk4JPXT/h8LDpRSiwTIMX0ON
	r1ef68xwxP6+fb0PAHchPx+biWHA/+7Tk9pgOCW2myeZaWyUlbPGic6qAn/cQP/yY4vwfYwcNLjm+
	M5spTiX4HBYlfglFoYdC/zh70pvDAmKoINxGjGkMIleRDDEGjdoMEjxK3wsykIhH+P7sVyEieDizB
	ZcCHDaKg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4gj6-00000009u6S-27rn;
	Tue, 15 Apr 2025 13:53:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1378F300619; Tue, 15 Apr 2025 15:53:24 +0200 (CEST)
Date: Tue, 15 Apr 2025 15:53:23 +0200
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
Subject: Re: [Patch v3 12/22] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
Message-ID: <20250415135323.GC4031@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-13-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415114428.341182-13-dapeng1.mi@linux.intel.com>

On Tue, Apr 15, 2025 at 11:44:18AM +0000, Dapeng Mi wrote:
> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
> sampling and precise distribution PEBS sampling. Thus PEBS constraints
> should be dynamically configured base on these counter and precise
> distribution bitmap instead of defining them statically.
> 
> Update event dyn_constraint base on PEBS event precise level.

What if any constraints are there on this? CPUID is virt host
controlled, right, so these could be the most horrible masks ever.

This can land us in EVENT_CONSTRAINT_OVERLAP territory, no?
