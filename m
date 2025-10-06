Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F41BD9D0;
	Mon,  6 Oct 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740517; cv=none; b=hzCq1R8Y4o2Z3ZE83QFYEn/pjnrDNTBRRwP3p6VOM2yFRzu3EsYSzcPL7IMTSZch6EswnACeBtWediZVzwtaKgPDn/xmLS1MJfEymyj6WvoTH5yAUXCVsMkpfbg6KD9bAMsETzdRYIZvpNl1wr4Th4YbNqXMzdtT2+X6MyxU+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740517; c=relaxed/simple;
	bh=5WJXUapKxjRvwz3WWs30B0bkoxzS2udBAnqQ7MJq214=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc0cNBkYWhqLL6e3icqkxW4rZD9eiuD2og68xiJHwyANaDN9jfLWoQILfSt7ZOtn1g/mzekPSmzVFibq93WEmSN1Yzt9e9GU5mHDaB0xOf6cHIAl4LvNQ5oThaFSrIXRJCVyCUemS77yLMQaouJTpBjyQe/jVlCXQCX/rQPGHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FZcQ6Ejv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZcQ6Ejv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5WJXUapKxjRvwz3WWs30B0bkoxzS2udBAnqQ7MJq214=; b=FZcQ6EjvpuFXpekQDbNE1WLPlI
	1uiT2kbN7thfkb7+8z36ZaZW7waugA4gSboVKkJwvi923hfxpAV3tYUDDsMpnEc37fdsFsbmBhFx9
	VBw3Zys3dZf9xnJ6KlhZugO3Q72jYBuucHfERQcfF+ge4T3VITAx6hjL8Cx9ZTtDrd6vHwWWjpi4A
	7a7lBRJlBrFpzbpZix2ZaVswWH3Se9T919oeTwVpCO5j2nvFegc3ztPEfCwBAE5fVDd/OslHJcBBr
	7ioZV7NkkXix9dvOly5ACrLP36NDY5eMsyQ0pGiSdx+dFM9v37DL8/HYvtmeJS4hdCgF54CBGveeS
	T0p00LTQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5gtQ-0000000Go8k-1ldd;
	Mon, 06 Oct 2025 08:48:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6D80300289; Mon, 06 Oct 2025 10:48:27 +0200 (CEST)
Date: Mon, 6 Oct 2025 10:48:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/events: replace READ_ONCE() with standard page
 table accessors
Message-ID: <20251006084827.GR3245006@noisy.programming.kicks-ass.net>
References: <20251006042622.1743675-1-anshuman.khandual@arm.com>
 <20251006082238.GQ3245006@noisy.programming.kicks-ass.net>
 <fa89fa8b-f5dd-4e01-a079-9b414efac30d@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa89fa8b-f5dd-4e01-a079-9b414efac30d@arm.com>

On Mon, Oct 06, 2025 at 02:10:14PM +0530, Anshuman Khandual wrote:

> These accessors provide platforms the opportunity to override and have different
> implementations other than READ_ONCE() when required.

When would this be required? Traditionally the only case that was weird
was Alpha, since it needed the dereference barrier, but since we folded
that into READ_ONCE(), that has all gone away.

[ also, historically we trusted GCC to emit singe loads for word sized
accesses -- something we've walked back from as C compilers have started
to be more agressive ]

Anyway, READ_ONCE() is the only sane way to dereference a page-table
pointers, doubly so in the face of lockless access.

There should be no need for architectures to be 'funny' here.
