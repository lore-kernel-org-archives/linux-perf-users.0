Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8763176FE
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Aug 2025 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290327; cv=none; b=XD5KVFWz/N4W3RBK0rgvRBmTvvgofLuv1N71Jw8G9GJtLWc89hXK73g2J83NLTe6jYPNqXzZHiM2CCO1R8Nvyfz4iSIYgmPhyruDElq/CGpNCLun62/YgTJmqBjJJBhmSfJWtvMKbk4NLPmcHKBCZ7Q1CjoYqwxhI4udb7Ki60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290327; c=relaxed/simple;
	bh=81295dDm/Nq5IaGxrf4exqjWaiFe6tACBP0OaSIv1dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTR8dOrxW8nOTniNXFmc4nUGs+NRZcnaJj4o78DHytQWwGU5PBQ64bJW/kLJwvNltFaaAxmiPIZ+x9SVMZqcWa3/IIwzgp9xdBodxbzbdj7yUHgl3Kibw64PMk1wLYqV7blBVWb9kIyeeR6gNb/i5EyzyWu6izesPgCxuGA3AJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkRVt4/m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkRVt4/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E0EC4CEEB;
	Fri, 15 Aug 2025 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755290324;
	bh=81295dDm/Nq5IaGxrf4exqjWaiFe6tACBP0OaSIv1dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkRVt4/m0WkCQdw3EYZtzbE3IjAnI8xQa8r3yyAwAlAaxsUomaOqNj+4g8h8+6D9j
	 sQTqJqnWANoJNDd6/6sT8WrCRthvjy/G2YN5Xab4rbpWHrEAcp6cQ6HCmWsgLgGz0I
	 +JzDuqSj7QnF/StUTh4Mooykm6ZVn0Cm7+XXs6ChGyXqkDx/vIkdVl4381J5FX4fNT
	 Dprzk9iAlkHlEKi7GiHLGyvWQAMs3plaM5X42MRHrZjAhvq7u12YMvU+SokAnJtCXN
	 NxwYYwfkrw8jXYVVuJk13xvqNCP4A3cfhesJOieI+NKsxvdEbd+jsJLHNrdwZtyBZA
	 mVaonpHYSyJQg==
Date: Fri, 15 Aug 2025 13:38:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] perf test: Added .gitignore to shell base_report
Message-ID: <aJ-a0of7IdpssEuI@google.com>
References: <20250804174157.319224-1-devaanshk840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804174157.319224-1-devaanshk840@gmail.com>

Hello,

On Mon, Aug 04, 2025 at 11:11:55PM +0530, Devaansh Kumar wrote:
> Created .gitignore to include base_report files so
> git status doesn't gripe about untracked files.
> 
> Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
> ---
>  tools/perf/tests/shell/base_report/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/perf/tests/shell/base_report/.gitignore
> 
> diff --git a/tools/perf/tests/shell/base_report/.gitignore b/tools/perf/tests/shell/base_report/.gitignore
> new file mode 100644
> index 000000000000..8d3ce1278d83
> --- /dev/null
> +++ b/tools/perf/tests/shell/base_report/.gitignore

Probably better to put this in tools/perf/tests.

Thanks
Namhyung


> @@ -0,0 +1,2 @@
> +*.log
> +*.err
> -- 
> 2.49.0
> 
