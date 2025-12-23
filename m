Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719651F3B87;
	Tue, 23 Dec 2025 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766451669; cv=none; b=gzE075lyhWq3oGDojuSQJ3ZZlU66x3XOmb6fljylRH3myszToh0gW5Uax+SDXx6dLmvHzmGkv+fMG5wYLsfnq5E4Rf6fGB7blbI8VR64ZXXtmlpIlXmZdx6vPKSZ4L6h0nZGYii6eq6lMy6bZUvL6aAxxjXsREj9xV7Mayh/78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766451669; c=relaxed/simple;
	bh=2r+Tiz3V4y6CTzvUEe64MBbKMKKAXzykFnfKZv8E7bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE8MzsdR3tHBvRLttjGcpLmJxggP8b939t4osNjcWqsyCeydTIWOI2306LIAxSr+O0RGVW9X+algad2OgHm6LpWsji4keTEtDCv1gxhGftABrGR6t3g3F0x5eGkz3P5PtEViE4zgyqiLh78AKl9om3NbUKulU0uhAIFBULX6v1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKXOod1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKXOod1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDFCC4CEF1;
	Tue, 23 Dec 2025 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766451665;
	bh=2r+Tiz3V4y6CTzvUEe64MBbKMKKAXzykFnfKZv8E7bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKXOod1DQEHksmNbUU5BF4sr8bUpQw3a+YSB2GU0WjWrW3HIhEgiDp3Oq1DR58s5S
	 cs4UZRVxczFzSlo8zgvKRTqCrsQtqHhVPiRai5Oz4buLWLAUtU34SHqm9yf+siwz3m
	 zff6KSKY9nicwx2gbDNIojIMkGO8ZwYqo+3VSQKzUyLlI4HWm9Jr1cqsNEgFxSnfNN
	 1z1NVfEahqwNpgioukKAYpYihS/Nx9GrUpLfwPPBi6mHLRK3jYAoOzSK+BUT7bYNW2
	 +OiAqZqAwXSXlSVJ2lBGOSb63o3Hrp3AG1eoxPy7NHxx/fq95X9llbYWk33NmJ9yGO
	 UaKFaZPzKXttA==
From: SeongJae Park <sj@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 09/11] tools headers: Sync linux/gfp_types.h with kernel sources
Date: Mon, 22 Dec 2025 17:00:57 -0800
Message-ID: <20251223010057.4135-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251222225716.3565649-9-namhyung@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Dec 2025 14:57:14 -0800 Namhyung Kim <namhyung@kernel.org> wrote:

> To pick up changes from:
> 
>   4c0a17e28340e458 ("slab: prevent recursive kmalloc() in alloc_empty_sheaf()")
> 
> This would be used to handle GFP masks in the perf code and address these
> tools/perf build warnings:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/linux/gfp_types.h include/linux/gfp_types.h
> 
> Please see tools/include/README.kernel-copies.

Nit.  I don't find the file on linux-next tree.  Do you mean
tools/include/uapi/README [1]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/include/uapi/README

> 
> Cc: linux-mm@kvack.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Other than the above trivial nit,

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
