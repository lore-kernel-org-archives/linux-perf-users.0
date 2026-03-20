Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56813DF018;
	Fri, 20 Mar 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030371; cv=none; b=d7JRc/hg5nqZVe7BZustHDQvbQdu9hphxdQbSjYZid/T07Yr4LGFUYyqfnJRvJTjFQRiGp8iW1VKuIQXeITnTQdbXjgagNUNciQBEgxLQQLa002rEsU78VDyPa6LWLf64cSKwZh4pS+O6g/DfMV638Tf6bcMH9HU+TKoXRRBDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030371; c=relaxed/simple;
	bh=n1QvfQWiSTblXnZbnr64EergjifBJapiMlDBUHZi4Lc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IyGxib0SWvyz/H6kuv/viVORhvf6YPFWqtuH/b5z30TPRZcbel4dbS3Um1W6eM5zobQU2xqlgZOzwkY4TUO9rbQIBKacrVoNmX858DX7kBt0Je3hU5p406kxkqDGqVUr91VSKctDSmkZfLR4iRaCGvfkAZjxIPEB1GUs6XLlYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQsoyEuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQsoyEuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE288C4CEF7;
	Fri, 20 Mar 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030370;
	bh=n1QvfQWiSTblXnZbnr64EergjifBJapiMlDBUHZi4Lc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vQsoyEukDPovTA5HKZB4zM/MF81VBYhPNksMx1Y/RVbWUJI5ursuqHM3MNb1znVRx
	 HMFrbq2gyjaTXxGg3YEagU9tPoich2wOy86uS5qJm3/673WWzAiVXocLBOgYYDEZue
	 ziNe20ptij0kOxtAE9Lh5ll5A7sUMKOOePyde/V7QhRlGPwle/k4nCKT0uDwuTrq0S
	 LFNPLGutBqbGvIJ67nr7FYOsubeSUEl0BvzsL+IhaJYwWZKEAkHnF4lYTFsC0deOls
	 2ueeHBZlYxwjK+BSrmIhT8sLXJjpfPhxg7ljS85Y57K7n7Xq66BVRLF0PwtT8I0e1z
	 Xwd/+ILvE4Clg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Zecheng Li <zli94@ncsu.edu>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, xliuprof@google.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260309175546.916039-1-zli94@ncsu.edu>
References: <20260309175546.916039-1-zli94@ncsu.edu>
Subject: Re: [PATCH v2 00/11] perf tools: Improvements to data type
 profiler
Message-Id: <177403036976.155109.14080981113837815530.b4-ty@b4>
Date: Fri, 20 Mar 2026 11:12:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-02735

On Mon, 09 Mar 2026 13:55:13 -0400, Zecheng Li wrote:

> This patch series improves the coverage and correctness of data type
> annotations in the perf tools.
> 
> Here's a breakdown of the patches:
> 
> Patches 1-4 improve variable type matching:
> - Add die_get_pointer_type() to properly handle typedef'd pointer types
> - Preserve typedefs in match_var_offset for consistent type handling
> - Skip redundant check_variable for die_find_variable_by_reg and
>   die_find_variable_by_addr since match_var_offset already performs
>   sufficient checking
> - Improve type comparison when variables are found in different scopes
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

