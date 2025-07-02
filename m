Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C12F7CE7;
	Wed,  2 Jul 2025 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751483860; cv=none; b=FJf2hu4IfN+DposEZMi2HcvK+soQkB2HbFgW6/MtuZtpaPb7/7A01iMNkWxsWGgroFuKljFQTIgcHQICpTOtXKixXFpD7//m1QTED2ZgzA5mQBfTcPE25QhpMieMCNb/pjXEd0Sug4yct61zE90n9PQNn70zY6mwjz1NkmIWXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751483860; c=relaxed/simple;
	bh=ae0YSSTMJY0yFeF41XCO6ZMo0RwLJkVnxIpyijNUtO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa+y2Qig4alNb4zVmtOApSP96dmoIRbITPOsuPTAB2OMTqkpohyd70PLMXVHLz1xLfxRFA7I1lGhUe+JEwvXVtnpk1RIsgT3rpTemZVPwcZ1KfdbTnzpUH5e7TPjULoDX3LEIrjcYT3kednxc94MrviDqYduJrIMrZTnm1QsTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQK3o/rm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQK3o/rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFB7C4CEE7;
	Wed,  2 Jul 2025 19:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751483859;
	bh=ae0YSSTMJY0yFeF41XCO6ZMo0RwLJkVnxIpyijNUtO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQK3o/rm1pQred0z44XroT0vRwuPmpANmof0x/4kjSmShZtsh4DWVCsXgfNB2UIwZ
	 TCeGyR01Da5ihnX6EnJ8XDefR6yKEK4Yd4Kq6PI9ht1hewaWP/tp0gfopmqBQoaY6J
	 rwwLTis3tvS8Rz3wFLftQuKIYeabpMHV9SvqmN+zDdj1vtGOkL7poODG1XifT0OvJl
	 1h4elV3AjXpC6BtXvnqE010t23WfTrNMTGBPodiZghReuoeCTf0H+aKO+pgREqUJnq
	 hjy2/WqdfxQHBVnorcpZCYtWprPEHa3wOhXJrrF+1KLNHP/8rzEbg8dF5gm6+p56+8
	 NfDkrGIB3isfw==
Date: Wed, 2 Jul 2025 12:17:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf genelf: Fix NO_LIBDW=1 build
Message-ID: <aGWF0Czs_7moo8uO@google.com>
References: <20250702175402.761818-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702175402.761818-1-irogers@google.com>

On Wed, Jul 02, 2025 at 10:54:02AM -0700, Ian Rogers wrote:
> With NO_LIBDW=1 a new unused-parameter warning/error has appeared:
> ```
> util/genelf.c: In function ‘jit_write_elf’:
> util/genelf.c:163:32: error: unused parameter ‘load_addr’ [-Werror=unused-parameter]
>   163 | jit_write_elf(int fd, uint64_t load_addr, const char *sym,
> ```

Thanks for the fix.

And I found there's no entry for NO_LIBDW=1 in the build-test.
Can you please add one?

Thanks,
Namhyung

> 
> Fixes: e3f612c1d8f3 ("perf genelf: Remove libcrypto dependency and use built-in sha1()")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/genelf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index fcf86a27f69e..591548b10e34 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -160,7 +160,7 @@ jit_add_eh_frame_info(Elf *e, void* unwinding, uint64_t unwinding_header_size,
>   * csize: the code size in bytes
>   */
>  int
> -jit_write_elf(int fd, uint64_t load_addr, const char *sym,
> +jit_write_elf(int fd, uint64_t load_addr __maybe_unused, const char *sym,
>  	      const void *code, int csize,
>  	      void *debug __maybe_unused, int nr_debug_entries __maybe_unused,
>  	      void *unwinding, uint64_t unwinding_header_size, uint64_t unwinding_size)
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
