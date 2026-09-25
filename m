Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031382D0614;
	Fri, 25 Sep 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341917; cv=none; b=YvSxknSxTOQDAXdU1mnZUTiKKpvZ6q0cG8zxF9bHmCAGYplJkPiWX3fxfozloSKWflp7dU4VxNALeLc//j704vqzvOd4K/mCmj4HeH9M/1ffaXqVYVBgnVm8RQJVuK3AyRSQoz8qZSqsBjHdRmI1tODBNsoc/lw3gnjhdi7PywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341917; c=relaxed/simple;
	bh=3xXjeIfjE5olobpqirdvRMSssU0F48J7ka5QFnuJLXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYBlKFzkYdssCSrOdwit0FeF2FkOA7xms/A7lbfFdJdJuePQOzTEDbOp//GkhWST1/1yQ3NOVaOT4q4ROytilThvdY4YMXd9S6nAdhiY7BA0yqlDso++AttsLcigxzsXjO3yjQlE9p8qHddAndeVr8PynI4QL4cMC0Y8NZ9rffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhIs8z9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhIs8z9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209541F000FF;
	Fri, 25 Sep 2026 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341915;
	bh=3BadcMjEWTl7+F9Vd64VknDaQ8Xv+MroGU1H4zhUT8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jhIs8z9TnapSKgJr2h1dtTLLU7L5tm54MP5DkCIxqsOakzYV/O3ABrtN+pOJhH6rO
	 puSh3L8YWbBSKvu69H+MiBKUTdDHHHmdq9Khg39qEKnz7fYnpveSA4kgIPyaNiR0Xb
	 O3UnMF+D0WBRNhQ/+4lsGDGAr/J1La6QHUtE5Hk0hiclxD5LKB9VGOONl0qHu9wkL6
	 T+c29EFWvbYB6FNFsTKC9oCbyLoK0d9Qf+S3IOyene9OFpB2TdPC41gczrTqIvnUcY
	 BzWJ1eDA+Yx0OydM+nZQaTFqU+/D/iTurrzrUGDmmqewHuZ64phTiAMd4wFHXWfnSk
	 JUpkU4wKvxH0Q==
Date: Fri, 25 Sep 2026 15:11:53 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] perf: fix typos in comments
Message-ID: <arZzGXKtmgZLomli@x2>
References: <20260907065421.11739-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907065421.11739-1-hemanth.selam@gmail.com>

On Mon, Sep 07, 2026 at 12:24:21PM +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  tools/perf/builtin-trace.c                      | 2 +-
>  tools/perf/trace/beauty/include/uapi/linux/fs.h | 2 +-
>  tools/perf/trace/beauty/syscalltbl.sh           | 2 +-
>  tools/perf/ui/hist.c                            | 2 +-
>  tools/perf/util/annotate.h                      | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c3c7f1f85c53..de86901b178b 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -104,7 +104,7 @@
>  /*
>   * strtoul: Go from a string to a value, i.e. for msr: MSR_FS_BASE to 0xc0000100
>   *
> - * We have to explicitely mark the direction of the flow of data, if from the
> + * We have to explicitly mark the direction of the flow of data, if from the
>   * kernel to user space or the other way around, since the BPF collector we
>   * have so far copies only from user to kernel space, mark the arguments that
>   * go that direction, so that we don´t end up collecting the previous contents
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
> index bd87262f2e34..ee2203d60643 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
> @@ -88,7 +88,7 @@ struct fstrim_range {
>   * We include a length field because some filesystems (vfat) have an identifier
>   * that we do want to expose as a UUID, but doesn't have the standard length.
>   *
> - * We use a fixed size buffer beacuse this interface will, by fiat, never
> + * We use a fixed size buffer because this interface will, by fiat, never
>   * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
>   * users to have to deal with that.
>   */
> diff --git a/tools/perf/trace/beauty/syscalltbl.sh b/tools/perf/trace/beauty/syscalltbl.sh
> index 1199618dc178..e70a8c79e019 100755
> --- a/tools/perf/trace/beauty/syscalltbl.sh
> +++ b/tools/perf/trace/beauty/syscalltbl.sh
> @@ -55,7 +55,7 @@ build_tables() {
>  
>  	echo "static const uint16_t syscall_sorted_names_${e_machine}[] = {" >> "$outfile"
>  
> -	# When sorting by name, add a suffix of 0s upto 20 characters so that
> +	# When sorting by name, add a suffix of 0s up to 20 characters so that
>  	# system calls that differ with a numerical suffix don't sort before
>  	# those without. This default behavior of sort differs from that of
>  	# strcmp used at runtime. Use sed to strip the trailing 0s suffix
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index e58327595d37..dcc535cc991c 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -431,7 +431,7 @@ static int hpp__header_mem_stat_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hp
>  		int left, right;
>  
>  		len = 0;
> -		/* update fmt->len for acutally used columns only */
> +		/* update fmt->len for actually used columns only */
>  		for (int i = 0; i < MEM_STAT_LEN; i++) {
>  			if (hists->mem_stat_total[mem_stat_idx].entries[i])
>  				len += MEM_STAT_PRINT_LEN;
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index fa08d09b80f7..c2a0a5cc4af9 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -275,7 +275,7 @@ struct cyc_hist {
>  /**
>   * struct annotated_source - symbols with hits have this attached as in annotation
>   *
> - * @source: List head for annotated_line (embeded in disasm_line).
> + * @source: List head for annotated_line (embedded in disasm_line).
>   * @histograms: Array of symbol histograms per event to maintain the total number
>   * 		of samples and period.
>   * @nr_histograms: This may not be the same as evsel->evlist->core.nr_entries if
