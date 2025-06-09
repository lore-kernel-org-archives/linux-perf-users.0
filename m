Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA5E571;
	Mon,  9 Jun 2025 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496902; cv=none; b=WvI09wg9ZwmusYLFX4JiBG0nHUYI+/CnthiI99MrbIa+BW+x6r9EtnnIi3hCzASIffP41ycP3KT7wJ1W66rLqApX0ySR2hL8ZXX2fITO21QFAP0S14EgaiVphTPVN9qqZZopnL5nwg3t9GotvMyEvjDDn5QBQN0bpuV3v737lbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496902; c=relaxed/simple;
	bh=EmHLi+WIDwMTitqB8Wtmq6J7R6/P0VzWwAE4IwfHS8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIeb4Fdu7CbdZnBlnXyN/8P4wQPgTe0omlrBm/lCBEfUgKSJSCWEQoItUHB+sn6L02ZKPgGD110PNSOKfV5UfgUFQSY2aGMK75qXNzRi/IY8xfFZB+6FXmtjAVFA4EkQhQGAvhxMuXF2e+3WM5gMyPB9fMFFuuS9TPUkJokZkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bNX3b5nw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bNX3b5nw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EmHLi+WIDwMTitqB8Wtmq6J7R6/P0VzWwAE4IwfHS8c=; b=bNX3b5nwxTn5n0yNcF2QKjEpQq
	qgqnwyxlpoPvZVuxK7Uf2SrgH15tnzfsi70JqF7/9CD2D9OdpxSfOUwsAyGIDKhkpfgFtwOgbhtGd
	aA8FavFlGjCA8U/iv/KHNCpO5c3VV+PG/wztGdr7icXUXEKk/8wWtYOaWKnCpVkmuvXs2hu5va/Tq
	fBL/BJvJwKN9+/N1dNTkGod5t5eK6kPtdxIv5wYUiyvLd/zyMFogfkbXnz7gpI9b9p2xzxAryRw2K
	NepI4bi4dvzqyKcRfHpBthddaYKPxvOOkwtDPKEF5xOe+lxOGwz/kxf1sms2PXTW2OhTwY7Lpudx0
	K42Sndvw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOi3c-00000008ZNe-1Ru4;
	Mon, 09 Jun 2025 19:21:20 +0000
Date: Mon, 9 Jun 2025 20:21:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, david@redhat.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
Message-ID: <aEc0MNj9JNXbLHmw@casper.infradead.org>
References: <20250609170806.447302-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609170806.447302-2-shivankg@amd.com>

On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:
> Replace open-coded folio reference count calculations with the
> folio_expected_ref_count() helper to improve code maintainability
> and reduce duplication.

If it needs this much additional commentary, perhaps it's not actually
clearer?
