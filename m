Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84C2E228D;
	Tue, 14 Jul 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047847; cv=none; b=ejR5xDAK8B4cMHMTzlrGzFjRUvuSxHy/9xkTUqz6G3kaeUZ6TaSZiPwJfB60VtiCgN3eowGZW1yBJYqbsjzsPTiOwApRfs94im1P3buGhPzp/06myNf0YtSn66scbUY5c0GEOmEZ78VOz1MhvMWlbzVojsolisZQ9amDMdw2/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047847; c=relaxed/simple;
	bh=rozZlj9Pj0HU0lGVTLRVQm01/xJtEHC6whOFUom3pbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ocX6yrI4rhNVZQAUtad7cWDyO8INJqWfJQx3hj8G8ag+dR7NsiwCmU2yYgQ3k+0Gn1+llTyX5l95Auvd76QnTRj3APxyf+YNq0AvOJ9PMlMBo37uicc8AvaogIl7oOZ50XC9RYnlhfr9scTCG6wju4XEXWCCZWcWqymmNuO/l2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boB6fQ5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boB6fQ5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7771F00AC4;
	Tue, 14 Jul 2026 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047846;
	bh=N9Zk5UCVMrqBJOCri0aUMmlye6JT0QLZVSCcurRCvDY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=boB6fQ5HvTg1dIrKEyE1J1yCdyWI4pP+BHwNGHgNidQNGuRM7mOB1/7lhmFdOB2ZT
	 gV0sCGa2wbsWOHPmBsUkWDoY79j3zoEfD+otYQNBibgVQZp2Xqb5S8/AqQOBH/xu+F
	 5E62+WsKgugpRjgAOhWfoQp1goZiPRFGNkRnElPSORXv2fZh609JVvyexrUgf86ukT
	 tLHlYIm3ugtD9HLrpIPNy/AWzXEoF7SB0vjuOulXAeEBIb6dYWsIXlT0qNwpio6C/n
	 ajuvmN4cDrbShWw18qYT+K/6vYeszxohXPWTwlPpMzVqTFJcoiU3sbTdLDOr2QsFV3
	 i63achnoeAJag==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>, Dmitry Ilvokhin <d@ilvokhin.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 kernel-team@meta.com, Farid Zakaria <fmzakari@meta.com>
In-Reply-To: <cover.1783513665.git.d@ilvokhin.com>
References: <cover.1783513665.git.d@ilvokhin.com>
Subject: Re: [PATCH v3 0/2] perf record: fix multi-record Zstd compression
Message-Id: <178404784628.1340197.12459480082277002163.b4-ty@kernel.org>
Date: Tue, 14 Jul 2026 09:50:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jul 2026 13:38:32 +0000, Dmitry Ilvokhin wrote:
> Fix a 'perf record -z' regression that aborts recording and writes a perf.data
> that cannot be decompressed (see full analysis in patch 2).
> 
> v2 -> v3:
> 
> - Dropped "perf record: Avoid overrunning the zstd output buffer" and "perf
>   record: Don't store raw data on zstd compression failure": both are now fixed
>   in perf-tools-next.
> - Added "perf record: Return the written size from process_comp_header()", a
>   no-functional-change prep patch, so the fix's per-record padding can't
>   overrun 'dst'
> - Removed blank line from record+zstd_comp_decomp_multi_record.sh between test
>   description and license (Namhyung Kim).
> - Added missing <string.h> include (Sashiko).
> - Rebased onto perf-tools-next (Namhyung Kim).
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


