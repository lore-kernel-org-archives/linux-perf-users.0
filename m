Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037D17548;
	Fri,  6 Jun 2025 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749178820; cv=none; b=aE1PT0oS/Z1nqUXn1C6ASVT48J5ZIxHGlrCKOAcjsDfz55VVKYYeMApC9rPoYFPsetzpV/M4Q6hvGK6jhOwKkaxOTJfu/eJEcETepXE1rvY3/VuozffeE9JWq531aHQFBnvj45sFzB9uhMCkpTKJuuegwM4JGywrbF80+3NT8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749178820; c=relaxed/simple;
	bh=0SBFn+UFBCjBbQknts0xVOLJjHL4WwxwjCBOj86vEq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHAbqdhT72SVcRXjPRy8z2WKH116Kdh80xWR4FsxAAarQuhAo3Sm96d2//S107HmGZEGpSrTN9WMZItT2XwuLCsynSwtX5gWCoZ6QVeSGedip3cggisuJGFPRufmkMA09r+sL1ZPFM2UmA8m0MEsZgERZsNI9EKi/bCzZzybmXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAdaOlqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAdaOlqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04685C4CEE7;
	Fri,  6 Jun 2025 03:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749178817;
	bh=0SBFn+UFBCjBbQknts0xVOLJjHL4WwxwjCBOj86vEq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAdaOlqbode3ipa6f/IWpCh512dDHE61uJM7IIR4KSIFG/AHRFi6ZVj98ZuayYZJj
	 u8RldMYhBWSaZSWG1FRYSFFdRVPnEisAv4FtMPaHXlKMlxgDd2cZv4xdUcXlNO0DAF
	 nDxayHNKKXxocU0mDm2U+DPvICvsHRjBAiCNL1GP2VKnJvkBw/XskOljkAxir/rng7
	 pDjDn0gYJd0xniDjJQs3dynZmDJAtPCimX/dteznts/Ih7bEbGUT0sDvvNxm/voUJ5
	 V7R76hw77TvOWg6/ENtbMSz6BZjRMw9DgC89TpUHFvoymnBMbf6HhxFpKuu3/Wccc6
	 dUJ63RyuRZmig==
Date: Thu, 5 Jun 2025 20:00:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/6] perf annotate: Pass annotation_print_data to
 annotaiton_line__write()
Message-ID: <aEJZv0i7WgN7yXJO@google.com>
References: <20250601065302.12531-1-namhyung@kernel.org>
 <20250601065302.12531-4-namhyung@kernel.org>
 <aEIBvIVWmi8vsCHS@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEIBvIVWmi8vsCHS@x1>

On Thu, Jun 05, 2025 at 05:44:44PM -0300, Arnaldo Carvalho de Melo wrote:
> There is a typo in the subject: annotaiton_line__write()
>                                       ^^

Will fix, thanks!
Namhyung
