Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC9168DA;
	Fri, 29 Nov 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896238; cv=none; b=gjMxC3PYEcd+RDTuk1CLLygTzTUIS8+WmXBj6ssk0VT1s7i/iKwxKkUhveLxVFT2dvorc3wB/22zzVaxUqmMgqWdp1wLMJUMe4rkVzNagRmC84sMGS8legQUdzt9xHF+4CrOIu2TuPcRQalVdaq0Sp1AS3DNGwPulTUbkX7YtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896238; c=relaxed/simple;
	bh=zr8ZTysZx845AFDYxj/P7skeZoHvpBbRjoNRlu121cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfj5LxcmETPwTZkaqrEGbX7xwSUZrV2HtknjG1AmuChNcE6Jbv0PLQtjdceMMjaU6qUzZDAwTeKOxfbp/V/YINcAMQAorfV7m/K7xbnDvGaFRL0euOl2nCaIoO2h1cCZFVHSVN8D/XgibrXEtEMT1sr7bhaDrsjtilcVA6IJgnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xozfh4s7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xozfh4s7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zr8ZTysZx845AFDYxj/P7skeZoHvpBbRjoNRlu121cg=; b=Xozfh4s7JRsYDDI1apNa56DwhV
	/8Zx92ys2FeLa1s2CZedoSszasnEouqNyR5ptp8uCiJHNRZDCxHY41Mfo2OnUFbEZnXVEfKetF9SH
	90tcmeUH+WGf3bbQuSInVicbql0mXf7klOWJ5tpi1nAjVsSUFwRpEbu4Wut9B3B5l9r/THqW5ZkYW
	x/6W8spUfoV1hmj8kH9NUpbrl4ArEHzmVbbe55C2MwCYTQBiE1HpVnlbBAdTy2Bie34g+65zpE7pN
	qUOvaNeQiXJxsKtfjlQ4gQxkVTCiiYQLWfmJOcPVS8MGtCE0YwJVJh50l82pNMjUQwzGgmHULy+LM
	0xw9Q8SA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tH3T7-00000004LuH-0Jgq;
	Fri, 29 Nov 2024 16:03:45 +0000
Date: Fri, 29 Nov 2024 16:03:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] perf: map pages in advance
Message-ID: <Z0nl4B_71PP-yf4m@casper.infradead.org>
References: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>

On Fri, Nov 29, 2024 at 03:31:34PM +0000, Lorenzo Stoakes wrote:
> While it is not ideal to use a VM_PFNMAP here, doing anything else will
> result in the page_mkwrite() hook need to be provided, which requires the
> same page->mapping hack this patch seeks to undo.

Or we could map the first page read-write to begin with ... ?
Or we could implement a page_mkwrite handler, but do the permissions
change in the driver and return VM_FAULT_NOPAGE.

I don't think we should do the second option in this driver, but
mentioning it because we're going to need to have A Talk about fb_defio.

