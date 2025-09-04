Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4B2BD5A8;
	Thu,  4 Sep 2025 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972041; cv=none; b=KrI+k/UBY36eaQ9VhrjG9BCae8PX7MRIGb9OP3U2t01o3pNdrKLVcKZ++8tY7nPOGyn8xT2Jgfat5TRqB9SmTnncRvPqNZp9mWkAXZiW8teu9mjD6IsXjkFAfPYOmsgBMy0DOXyve9A/h5UCDZCqeq8ifv1vO0a2HzEa9mbKr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972041; c=relaxed/simple;
	bh=RdxnZN7SSA8WBmRvG93DF96dGRkqV/lygyU5uiMSXd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6kw+HWdflthJoS7hpkvWYOP9MopytbEZ0Q64Dd6eDw9fet3NOoCGCxMqvHIdQB2j5rJ0G0wB7iMKHG7KZ2tolnRJBispphQUbs9OL/jqAI9h9LmU8fW0US3HzuBfqhSHuIITfi7+x8uRlj3BFPdTzKpsLsOwT9z5vE7i/7QKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrGnfIHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrGnfIHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C7CC4CEF0;
	Thu,  4 Sep 2025 07:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972041;
	bh=RdxnZN7SSA8WBmRvG93DF96dGRkqV/lygyU5uiMSXd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrGnfIHy/ew3+TDD2Q+GIWT/eihpT0m8aQUi7r/kFJ2QGsPaaHuRfGx9hSOOlwEo6
	 a7M7QvX24FuWzY1GyGMrKeVe6AdzkSU9QxfZO44RrMDkjocqSFykak+lxA1G/r+xwv
	 qUNNMt9lvCPq6b2locszWGgIF5qgLQnuAC46fb3NcSI7F0brH96Fdz5nymg7nkEyjA
	 a6XAH+KyIkm2RwwNlWVT9Iz2x2uc8rv7zHQ6JXW0UDOngW0z0tRUiheYtEOvsmPvjA
	 N2PcW/4cpdALn8PVZGwyYPV2w4yEHSJKDq4e8+LmY6qZZisv6e/jO9a4sWjrG++op3
	 tx4tEm4HPgv0Q==
Date: Thu, 4 Sep 2025 10:47:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/18] mm/ksw: add ksw_config struct and parser
Message-ID: <aLlD-74aBdb-ZD5K@kernel.org>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-3-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904002126.1514566-3-wangjinchao600@gmail.com>

On Thu, Sep 04, 2025 at 08:20:59AM +0800, Jinchao Wang wrote:
> Add struct ksw_config and ksw_parse_config() to parse user string.
> 
> Update `Makefile` to pass compilation.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  mm/kstackwatch/Makefile      |  2 ++
>  mm/kstackwatch/kernel.c      | 70 +++++++++++++++++++++++++++++++++++-
>  mm/kstackwatch/kstackwatch.h | 34 ++++++++++++++++++
>  3 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
> index 84a46cb9a766..d422f0e114dd 100644
> --- a/mm/kstackwatch/Makefile
> +++ b/mm/kstackwatch/Makefile
> @@ -1,2 +1,4 @@
>  obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
>  kstackwatch-y := kernel.o stack.o watch.o
> +
> +CFLAGS_kernel.o := -Wno-error=unused-function

Can't you just add the function along with the code that uses it?

-- 
Sincerely yours,
Mike.
