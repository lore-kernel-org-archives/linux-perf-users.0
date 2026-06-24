Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241412E0902;
	Wed, 24 Jun 2026 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782262234; cv=none; b=Z5FHARBwYJ5ijToQhDtF0DvAFW/pjXZTXFQD9YYgWl8PSLd7smmSUJlNq6qVmd/76u8TaPDchp2LvNj8N/qneTFePr/RVuT//3p+2lcd8Y7NJCZKEy9OutFnjuKy+aA6xzsQ7tXi8FZWzvHkjxU3sNna+k4E7tb3N7JE4StWtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782262234; c=relaxed/simple;
	bh=60mwFsM5b+aG9AS2Xr5ByP6LfaZvFc9s2FbKxXVXwBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQXNl1Jy7MOD0sU9rL/+fU33hLGIBUJbjWg4Al8BwzfqMwssV9JpzNIdhYU80jdTa0GmUnlT+aSHlW+Isc8eCA/Ykn97dZA7ag45Pml0L2ZFz5bi+OK0by0BMPrSHNY4lrDR3ZuFB3nV/rScucP1t5SmbDcUXl7awmAZp7CWOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8ddaJ+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8ddaJ+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ED01F000E9;
	Wed, 24 Jun 2026 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782262232;
	bh=ql45DuBi62Ja8pgqfUgCiEps3I4UE6RV02anYpcpfEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b8ddaJ+L4j6+2bUQuwuNZszX0exiE2/63sNIYwDOUXiDJpIYBaO+k/O0idXdTjZuj
	 A+SEEAd/QhY5j5sclMP7b5VbBM0Rgb6yBO7q22gsmNcEjDZDrvvXYcPo1vHkNQD2+i
	 ge28Q3KLXBmcvttyDj1vKy8CFlk2PpAiujv+CsnGc553A6PTNeJqUV069u7wg5OvSa
	 L2qcmWPXOX4KszPtQEoF7YXH4ZBZWLO9gNnvoH6VgmU9R0KnLi0M9Bcafujg3XFvdG
	 t3UDvV7jH8Izjw5SNWswvI9RaNLl6Kgd3kPbw5IWbL/LFNohBAn1zkcCwet2QFZoJq
	 pQ4iUoVOBweMA==
Date: Tue, 23 Jun 2026 21:50:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf bench bpf: Add missing .gitignore file
Message-ID: <ajsp1UEtRk4PY0cW@x1>
References: <ajsfSkRm0T7J2eF3@x1>
 <ajskevFfXGkVt-si@google.com>
 <ajslsBPoAPMioSeW@x1>
 <CAHk-=wjntSyV0sZvOU4wAKU83GiBWQ0Y2bbvtg84QSg6SbpgDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjntSyV0sZvOU4wAKU83GiBWQ0Y2bbvtg84QSg6SbpgDw@mail.gmail.com>

On Tue, Jun 23, 2026 at 05:42:58PM -0700, Linus Torvalds wrote:
> On Tue, 23 Jun 2026 at 17:32, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > .tmp is created as well.
> 
> Note that the top-level .gitignore makes sure that we ignore any
> dot-files by default (along with a lot of the usual patterns, of
> course - not just object files, but various other binary file
> endings).
> 
> ( Yes, gitignore files do allow overrides to "un-ignore" files too,
> but almost nobody ever uses that, there's seldom any reason for some
> top-level file to say "ignore all generated files of this pattern" and
> then a subdirectory gitignore says "but not this pattern". Some crazy
> directories do say "ignore everything" and then they explicitly
> unignore some patterns, but honestly, that's a mark of a diseased mind
> )

Yeah, but having .tmp there its kinda like not depending on having the
prototype for a function indirectly obtained via some include chain, by
luck, having .tmp there documents that that thing is (or a strong maybe,
in the case of vmlinux.h) generated there and should be ignored.

Anyway, now it is ignored, doubly so in the case of .tmp.

- Arnaldo
