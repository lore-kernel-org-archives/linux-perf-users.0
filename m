Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB01EA84
	for <linux-perf-users@vger.kernel.org>; Sat, 16 May 2026 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893748; cv=none; b=STbUtQiIALz9TiaWxVZtMyv+ovvQefOAqh0/GViKSmTIu9U7EGr0Hh1mbKVXpHJdnkNZ/Lt4ypcyODHYPHGmz7yvHV5BoZOhHAROhu3WGC3M16MZ88qdDqd4pCKtyMr5+VX2OdYU6W/uPkTmO8zsEvR/H+/F7Hvix+fNIFZzZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893748; c=relaxed/simple;
	bh=tKcGnJzxFt0VAIY6s5ZdskUhwsc5kZk78pRUW1y11Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAgkLUr0BDS0mWgbWtXOBjWm6YTR89g4S4I+eZSM/DZkfFLqerSvljsoizJU5GVPE1LgWbtKzrnqhr9Txm3K/tJqsAAVmOH18GhxUCaUVN0eBMZ3tpLCM4XLkmP8NWL13tNhi4pzPwPGEECF7SoCijD+e+EvJWhI1w3LgZT50W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzorSoUR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzorSoUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD334C2BCB0;
	Sat, 16 May 2026 01:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893748;
	bh=tKcGnJzxFt0VAIY6s5ZdskUhwsc5kZk78pRUW1y11Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzorSoUR3Ke2jBhL8YZZY6K92zBE3PEf7yYrOCx7uE1FULTSyFmee4EWagbu4wD/q
	 LzUgNX+0QtVqGtedxxmBZofO190tkR5cRvGw46ue+9OX/jUn9nCN5YTkcdeMIMz7FI
	 G5iuEo7uDao1xgoHZPBXUoYCbVXTrjPv5wHAtEKzlsAW05uopnDnvlhZr0kRW+xsTV
	 rUOeoqxeHUieM4fAiiiFkjBnqhGSU5xB0j8HGi5oS7/5B4r0wGN6MH28CFOxkKX9Wa
	 KhG7XGQlXD2NXDyfOt+j1swhsLAv468g7Ucn+tLQYCUmqbp7b/fqkrnY9LV7fhVrku
	 nhCXT4A4VCoow==
Date: Fri, 15 May 2026 22:09:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Chris Mason <clm@meta.com>
Subject: Re: Perf review prompts
Message-ID: <agfDsTgSyTRNIwgA@x1>
References: <CAP-5=fW5Wozj=F2dnXoLTWmUjudNWLyjjg95CuP3Jk9bLcYwww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW5Wozj=F2dnXoLTWmUjudNWLyjjg95CuP3Jk9bLcYwww@mail.gmail.com>

On Fri, May 15, 2026 at 04:52:43PM -0700, Ian Rogers wrote:
> I think we can improve the review prompts for Sashiko and others, so I
> sent out this PR:
> https://github.com/masoncl/review-prompts/pull/62
> I wanted to advertise this and suggest that others contribute similarly.

Thanks for working on this, from a quick look it seems sane, some
comments:

-----
The "File Descriptor and Directory Stream Management" is describing
the dir equivalent of open and close and saying they need to be
paired. Assume this is base knowledge for an AI code review tool.
-----

That is completely reasonable expectation, I would be surprised if it
wouldn't catch this, but have you tested it?

For the validation of perf.data headers I plan to contribute what I
learned while working on:

  [PATCH 00/28] perf: Harden perf.data parsing against crafted/corrupted files
  https://lore.kernel.org/all/20260510033424.255812-1-acme@kernel.org>

That I hope soon to satisfy the last review comments from sashiko
addressed.

Anyway, I think this can be added FWIW:

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
