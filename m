Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83E72600;
	Mon, 14 Jul 2025 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481839; cv=none; b=TGGbn+2AeCDxo218Ro/cFIt9RsFIb+FIUJRVa5+BiwptMGThrwXljMRM5hAVuVXBWI1EQzeGa7XMKQYXJYiI7HKqcqSbpGf4HI+lBkGvJO1fTe05gn3zLzCsczrPb4VkCB/bQfILpFqzgKaRzlXf8sfBIr0j2oMQaBBkKIDFHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481839; c=relaxed/simple;
	bh=UXxWUo53aedqVB8S2fdgJLytsMH1oCAccK6tpYkBahQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oswLCqRe0RSxImNPRuE34l3ieTY1BmNU0EiSkNBAZIzyiLqHnX1tGs4ONJqNet2V9Tdz8FgM3VCY/2+B7PEEnXN6i0lHtmqWGIccZC9dVM4s2TUpjR/Nfw4Iar42w3wyxRIMH9oGyLF6EIloELhTlx56Cev83rSBGaYxHvIfeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N82ZdbCj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N82ZdbCj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UXxWUo53aedqVB8S2fdgJLytsMH1oCAccK6tpYkBahQ=; b=N82ZdbCjturlES3ex0s4qZ5ELi
	ZRYcC79RYeThJxke0T2vwa75bcTjUhvtnhO/iTRQBa0UEFVir4P28IRmwZjUTwZiLsO1SVwImeHuF
	7hFlHsXyJbMfMH52l02zK2/L8fcKcPWp/2Q6sg/B7t7+MJN7BKIc/1a4NgUO4O1RICAoDEr7QBXGq
	To19P7TLya59FIblwm/L4zJeOouCEbITe3Ki+9Jvcdp9MecnGA0AXbt1wKiEKa8DBcHwq8itpAFsq
	yWu9MpCNRaBTHmgbYJDM18xKzGMHXkH4kqGZzvJslNwijPsDmPR1Mg9nDOUOSSq96hCWW9mj0EjJ5
	r8sWX5MQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubEZs-00000006WXJ-025b;
	Mon, 14 Jul 2025 08:30:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AFF7B300186; Mon, 14 Jul 2025 10:30:22 +0200 (CEST)
Date: Mon, 14 Jul 2025 10:30:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matt Gilbride <mattgilbride@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/1] uprobes: relax valid_vma check for VM_MAYSHARE
Message-ID: <20250714083022.GJ905792@noisy.programming.kicks-ass.net>
References: <20250711200705.1545447-1-mattgilbride@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711200705.1545447-1-mattgilbride@google.com>

On Fri, Jul 11, 2025 at 08:07:05PM +0000, Matt Gilbride wrote:
> ART maps a memfd twice, once as RW and once as RX, to uphold W^X for
> security (defense in depth),

I'll argue this is no defence at all. As long as there is a writable
mapping for an executable page, you've lost. You have effectively
violated W^X.
