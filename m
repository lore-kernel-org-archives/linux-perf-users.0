Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3943D413F;
	Fri,  5 Jun 2026 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702864; cv=none; b=IFlBg1Fmjb78sAHOOdfS/kDRt3F+Xizf56Rndy3+ErL8KJp2NjORFq0ntw85wDh1H0JRQVcXDys21GYAORY54l+voTW8SQpwUoqCyjKLd4tdwm1Aco1acnSD2Maaa4pS4glgwCil4GgmkHIgX30sWGf5piFcAoqq5CX5B85q0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702864; c=relaxed/simple;
	bh=mmXUwxcXKxpDGBjgR3VkEzMvhczrZGI4t4RU6cLrQ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFn72krYavziSCBwcZUDN/4qVcW6VyxEfG4ZKlTXWEhwOf9eyafdF4bfKS/CuXE1C6KfDPKrInkHpv+0OD8MJiiCBKFkW29ODsYf0hSPrCymbAcyNOPh8iDvAOV0hC7gg2c9DIsxKlOnFNR8g5sNzNG141yLyVIfIKZMmUKBTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY8SVya8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY8SVya8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397E81F00893;
	Fri,  5 Jun 2026 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702863;
	bh=zKUZswYyqb3fTkpmDGDuQHCpFg03P5/zTNonPJpsVCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fY8SVya8jFYP77kMjtnf2W+vFhe19H9mesXGqOj15TxqbJeClzvJiWeYLv8AgLwL3
	 SeYzNb4I/52KIjfOgjPPgaiCIW4O/qEI8ZXNcJ7LDIwkbOolhHJSiQVzf5JdHrwSsp
	 U6NS8mUB8NLKKK9eoiSENM02IKKlienOYG+P+xFQkzlV3UZbfipykk3Pw2cuWwTK5M
	 e5B8FRvm4bJMz8e+fsbhrGC8BPBDQYFXTB+BG2LzPCkOq/FTcCvyVlbIigLphHoy7H
	 uYHu3TPDxWihVGc6R+NoeDYvDvJRMOv8t6yLzRrVm1gsgDAwfcuYsVpzEE/szA6uEf
	 QeXck4pvuhn7A==
Date: Fri, 5 Jun 2026 20:41:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf timechart: Fix memory leaks
Message-ID: <aiNejLm6HZf3iAC-@x1>
References: <20260605231155.2415760-1-namhyung@kernel.org>
 <aiNZcZosyvKQnQk1@x1>
 <aiNbjYgW2FFltUa8@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiNbjYgW2FFltUa8@google.com>

On Fri, Jun 05, 2026 at 04:28:13PM -0700, Namhyung Kim wrote:
> On Fri, Jun 05, 2026 at 08:19:13PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jun 05, 2026 at 04:11:51PM -0700, Namhyung Kim wrote:
> > > This patchset fixes memory leaks in the perf timechart code.
> > > I've extended and verified the timechart test with ASAN.

> > 	You submitted a series for timechart before, so I had to go on
> > looking if this was a second version or a different series.
 
> Right, this is a different series.  I believe they are independent.

Thanks for clarifying.
 
> > 	I suggest you always have a version in the cover letter, i.e.:

> > [PATCH v1 0/4] perf timechart: Fix memory leaks

> > 	To avoid this brief distraction :-)
 
> Ok, I'll do that if that helps. :)

It is a small detail, not having anything it may have been that the
submitter forgot to add something or that it is the first entry, having
v1 removes this ambiguity.

Thanks,

- Arnaldo
