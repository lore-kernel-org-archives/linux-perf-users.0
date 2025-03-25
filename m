Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0F1862;
	Tue, 25 Mar 2025 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863598; cv=none; b=bEpc7uX8kdjOL5rMVDUKk42o4yO8ZLi8Gmw4Qw38GQJmmFt+Mq2S7r2ZygOKsjybjWsCrsQ3ltjtPlTh4TZQ3cY3frHXehyMHbWe9IqkFgHkU2Pi6NSzSZttj6e8g7yeevNpt5Bc3zKJ8n+ByLUH9WJi6KxyAjV/deTq5/FqisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863598; c=relaxed/simple;
	bh=Q/lzL6OCDNpoFu0x3+dBvwcDr1c7KMqQz/RNspTnP2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfY6qi0RVtFw0ws5zlh8YyLXJSZK7osfjINJuqtcChz3wbGoeQSpAHTineVHPaNxkjqiHFZ3axbRK3q94fod887CjaIYI+GAkxlRAcl8cAN1z5dYA6JR2VeLAzDVlaKfQYr+M2m869gmFu66dECDVn1lEBqqam8sxgIsZDRxFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nChGsZEu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nChGsZEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED828C4CEDD;
	Tue, 25 Mar 2025 00:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863598;
	bh=Q/lzL6OCDNpoFu0x3+dBvwcDr1c7KMqQz/RNspTnP2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nChGsZEu0f3JqJORROTwnypmGRxozhVG88lQ90HkHXXjYF9zKJCprd0cTD5cLbwTo
	 rHaAcZNyhq7M/pJNenWUK/yAHmi+54AG89bwLp3Bq9/q6gLp2f8e9G7+T7scRjSGur
	 X6AvLWYbUsyZzK6orIIEZOhcjc3CqIxlmc+eXtWkM76plxDNAHLeVySwQwpTlY3qLK
	 tHtNtBbCS1p3XZ7GXYdj9AmikExsWtYHRBFZWu9wGRrTjns9IIAhckqJjtaV6xSdEQ
	 HIlDw/ugAfiADnI3Vk+nmZ1NjCg/FTFhGZsBwuaeSoT1l/CqY4LHd+GGDbnGJ4D/X4
	 4pPr6Qhz7zRqQ==
Date: Mon, 24 Mar 2025 17:46:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/3] perf sort: Keep output fields in the same level
Message-ID: <Z-H87C_X63bH5QPw@google.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9vgt1pjiNbDBDbM@gmail.com>

On Thu, Mar 20, 2025 at 10:32:39AM +0100, Ingo Molnar wrote:
> 4)
> 
> It would also be nice to have an export function to save current 'perf 
> top' profiling data and have it available for 'perf report' et al 
> analysis. Ie. frequently I just see an interesting snapshot and decide 
> that it's good for further analysis, freeze the screen and are left 
> with very few options to keep it for further look and reference.

I've thought about this but there are some limitations.  Basically perf
top and perf report aggregates sammples into hist_entry's using the
given sort keys.  That means other information in the samples are gone
already.

For perf top, it only has dso and symbol - plus number of samples and
the total periods.  Other informations like CPU, PID and TIME are not
available so it cannot reconstruct samples precisely.  So it's only
possible to use the same sort keys or a subset of them IMHO.

Do you think it'd be useful even with this?

Thanks,
Namhyung

