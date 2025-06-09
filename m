Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76001DE2A7;
	Mon,  9 Jun 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498670; cv=none; b=MJwn6Csbc8k3D4Bz4gFZG/aahFOFWKdMG5GqmhhbwwrzmK1uwYGBDFtNsgYzBJF69eXY0osDUHRt0e1iR7FAsx2ltXNhoxTpHtTYlfTM9/Wmm8mKyoOGz0dSraf2yF8uRciblArmJEH9bWY9NjaT9f3jB/+5tVR+yMcq89XqZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498670; c=relaxed/simple;
	bh=NSk9kTu7mQ9UesVjuqh1wiEjX5MHkMHssyrEe7F7CeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWOv9tmZRPlY3GNhsN2BfiAZVjfhhm+/Ja8QhT0RTNCXHfiNHRNcZYNoDm/Vuvx1h2xPLK/+fKKFcKs17psJ6WTL9uIct7iEPZLbZ86/g5r7GJti2adEjmYa8vYZiug6k1ee6MEZpwD4MtCTighGlld6px563wuVLkFBKm54N0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NPDd4RJx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NPDd4RJx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=85TAzXXcGObkIpSOMC2VeDSg1VAoupbTgbj/ahVWIVM=; b=NPDd4RJxANb9b7Jo+/f8FU7asW
	9KTgylLu9Lp2yPzwLdKaOgApaomKnGXLZ5XP5KdylzCGEAuug+Xt0F0Bnzu/Vur83Ta5P/SAU2tYY
	2nt6jIIgb4s70PWKmxxfDOe9IniTTZJkOhEdsJMjAuxDKz8ki5e0xtxBIdNlGCaD4wZQ/pPI/IWEp
	Zo6PQly2y6Id7o8ZUo/V3vBUIgGO5n3UeOqt6TsTMi9tVrNf2c6zS95p+2vGCnhkqsf3glNz0uaGQ
	2pcbP1Y6c5b59lAPSRpjFuqMa2I4+d0Xdef1a0i9DKpj+1Kfj0CjC4jfvbJO2tXg1zKOGmSL+WhtM
	yH7S3wwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOiWK-00000008aqX-1C8K;
	Mon, 09 Jun 2025 19:51:00 +0000
Date: Mon, 9 Jun 2025 20:51:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shivank Garg <shivankg@amd.com>, mhiramat@kernel.org, oleg@redhat.com,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, david@redhat.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
Message-ID: <aEc7JG-OL2fp075j@casper.infradead.org>
References: <20250609170806.447302-2-shivankg@amd.com>
 <aEc0MNj9JNXbLHmw@casper.infradead.org>
 <E40B36E2-1D0E-4769-B155-0175A06DE3AB@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E40B36E2-1D0E-4769-B155-0175A06DE3AB@goodmis.org>

On Mon, Jun 09, 2025 at 03:31:40PM -0400, Steven Rostedt wrote:
> 
> 
> On June 9, 2025 3:21:20 PM EDT, Matthew Wilcox <willy@infradead.org> wrote:
> >On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:
> >> Replace open-coded folio reference count calculations with the
> >> folio_expected_ref_count() helper to improve code maintainability
> >> and reduce duplication.
> >
> >If it needs this much additional commentary, perhaps it's not actually
> >clearer?
> 
> I don't know. I tend to over explain as I rather make it totally obvious what is happening. I wouldn't say excessive commentary is necessarily a sign that it's not clearer.

That was a Socratic question, not for you to answer.

My opinion is that the extra commentary is obfuscatory and should be
removed.
