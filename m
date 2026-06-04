Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922D409618;
	Thu,  4 Jun 2026 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604566; cv=none; b=mYwOijoI9HJFlniM09tuS6OYt14O8UWAU4E7/Dklge3E8j+/WfiTqIqogQE8icN2jQyrE2/F1DCTBtyGLqmCcLk3HyhXR4U23nNFz86s2/3qUCj2nZfnMN++Bo1DyS2riJ42cihtLQn/Mkmqp127x/oNdVoy7jUI1AYr5xX6o1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604566; c=relaxed/simple;
	bh=rEq3xlwc7BB183NFmdVaGABpcQaDIIjshbrTU4KJ/KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQFAduN7kZOpSqum5xUJEw/J4Q51ezGpkc2TAsfoC69vn4G3LGhFvuLlk1/jARH8F9gxPtrx9Nc0nJsOrOAR3t8/fi56NpQrLCnyVR6ZDdA3ZhQFcy2QvzG6RnmdzNPzAj/+m8lveE5g41Q0sC9BkPjiNTBrAbje9Zktq2DBY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm/llZEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm/llZEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61D61F008A0;
	Thu,  4 Jun 2026 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604565;
	bh=Hi9lMlEIOKbs505RqK4HwvsuZiH7qb6ZyOAQbkd3wqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vm/llZEI/hF9wLRktS3Eks8vnsGfAW+Z8RtAsPfLo9ttf+sxRpsw+pueo3NGxjWcO
	 Xvj+XO7YK2zzTvZhUrlhPpE7+pkxY2OjRXTfZSh4+/Pvp+0WX7jAtFj1QJil95LbrX
	 1UJRDWrq/1lCqb8lTW0dBslOt9kIP6+uQBupEkA6cFEw9cszRlOJmb/gnreRPG5/t6
	 eSv+GSX0GFOimalerT+lYrPsqfScfc9t8k6R1DrUMOaZYaWnMhRfj6xhW6JwbUDMgI
	 04QyvaUt0P5b+qOQKU/GgO55iigNGQmIStCXHPgEXRIcVKnUChAeDVDJuxWj+jZ4Ln
	 l/bYqu4mBBQwg==
Date: Thu, 4 Jun 2026 17:22:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Subject: Re: [PATCH v9 0/2] perf test & PMU metric resolution improvements
Message-ID: <aiHekvJrnAZU3eLu@x1>
References: <20260602174129.3192312-1-irogers@google.com>
 <20260604163627.501078-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604163627.501078-1-irogers@google.com>

On Thu, Jun 04, 2026 at 09:36:25AM -0700, Ian Rogers wrote:
> This series contains the final remaining unmerged patch for the perf test
> improvements sent as v8 in:
> https://lore.kernel.org/lkml/20260602174129.3192312-1-irogers@google.com/
> 
> v9 Changes
> ----------
> - Patch 1: Resubmitted the "perf pmu: Recognize 'default_core' as a core PMU..."
>   patch, but this time with a squashed fix for a metric resolution bug due to
>   its use of is_pmu_core.
> - Patch 2: Added explicit clamping for max_desc_width and width based on the
>   buffer size in format_test_description() to satisfy GCC 16 and prevent the
>   -Wformat-truncation warning reported by the maintainer.
> 
> Ian Rogers (2):
>   perf pmu: Recognize 'default_core' as a core PMU and document matching
>   perf test: Truncate printed test descriptions dynamically to avoid
>     terminal wrapping

Applying, will ask local sashiko to give another look,

- Arnaldo
