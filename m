Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E726F478;
	Thu,  8 May 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715932; cv=none; b=rT5evFXbKDlwMc9FuPTFarNWxejP0VeuN9JNDrK9aa3otcQlOCEdZ+0F/mT9oOgdnCWaMjgjd/31rVo6hIneXRwdE/utdkf+npSCWVa66PwIcB6ig1AuyjbCqkqTas2yusZ9aTaS7itk6Ea2mUZA3unBcXpxlS/pbEciP6ancfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715932; c=relaxed/simple;
	bh=m9+dvvH99WOk1Q+YGo6PeA3k97JBnWhonrMgm9Unthw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgohs6XQjd9Bs5++dPxZZ/EgXIkuvQQ8vSiXW445rdlwHjIsnXkPFaU53h2Rr9UTzMNrqZJ4V24m8TdO8ftZh8CKGOmGNZdo17cxAMfjsspeADLdSIjctjeU0LVKg0bjdeTBb+8aQkKHk8RqzONZumhp9USrcH28e4Omg4Hg/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egLbwTX5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egLbwTX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842CDC4CEE7;
	Thu,  8 May 2025 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746715932;
	bh=m9+dvvH99WOk1Q+YGo6PeA3k97JBnWhonrMgm9Unthw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egLbwTX5kYtcWDxF3pn+h6VTXTWbSAcexEh4T80EqMnZT8K3dD1DxveyRZl8dNWHF
	 Bz8R0Tg7S0i3FFwyhV/YeWbXb5cmQbTumgVquKzqw8nALHHvpOJUQuyYOoaCOMT/k4
	 DX13/JrDQOJpswCP4htG77iiUDstsLiVySJCsLY6ODNro4Co8VT8Y2A/6aehoLmfCN
	 kGYElrH+djZQtFrObp8ha3Mj5tZ2nNkmEkULAq2XaFq1NUgFqe7Y3Ay343zkv0bC+v
	 h3y6Pd38S5ty9c60ENFNakD/iCe0bPvjOV3xtB4pgesMSFWLWthUhpRdI/nMu8LI+c
	 J+n+vAShgBMWA==
Date: Thu, 8 May 2025 11:52:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix some more memory leaks
Message-ID: <aBzFGKKubskQDLrs@x1>
References: <20250401202715.3493567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401202715.3493567-1-irogers@google.com>

On Tue, Apr 01, 2025 at 01:27:15PM -0700, Ian Rogers wrote:
> The files.max is the maximum valid fd in the files array and so
> freeing the values needs to be inclusive of the max value.
> 
> Add missing thread__put of the found parent thread in
> thread__e_machine.

Split it into:

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -2
7900938850645ed4 (HEAD -> perf-tools-next) perf trace: Add missing thread__put() in thread__e_machine()
8830091383b03498 perf trace: Free the files.max entry in files->table
⬢ [acme@toolbx perf-tools-next]$ 

So that git --oneline is more descriptive, etc.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 3 ++-
>  tools/perf/util/thread.c   | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 58a2ce3ff2db..c02ea4e8b270 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1657,7 +1657,7 @@ static const size_t trace__entry_str_size = 2048;
>  
>  static void thread_trace__free_files(struct thread_trace *ttrace)
>  {
> -	for (int i = 0; i < ttrace->files.max; ++i) {
> +	for (int i = 0; i <= ttrace->files.max; ++i) {
>  		struct file *file = ttrace->files.table + i;
>  		zfree(&file->pathname);
>  	}
> @@ -1703,6 +1703,7 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
>  
>  	if (file != NULL) {
>  		struct stat st;
> +
>  		if (stat(pathname, &st) == 0)
>  			file->dev_maj = major(st.st_rdev);
>  		file->pathname = strdup(pathname);
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 89585f53c1d5..415c0e5d1e75 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -471,6 +471,7 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine)
>  
>  		if (parent) {
>  			e_machine = thread__e_machine(parent, machine);
> +			thread__put(parent);
>  			thread__set_e_machine(thread, e_machine);
>  			return e_machine;
>  		}
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 
