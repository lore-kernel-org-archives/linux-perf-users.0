Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104A184524;
	Thu, 12 Mar 2026 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773278242; cv=none; b=hk2R92z1UNtAcNWlAMr3pAf+EhjhrNY0W1lovmFysWByZVtkw0KHvlE7M7x+Hhpd3Ihln1D4tYyfvmdaKQz6WK+NTkJ188aOCCCE5gir2iqSrZexypf3xvslTPUQonDrYjjgZH3P6xPT9I6PNVbmOaovXxhFDWl/do6Qf14uguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773278242; c=relaxed/simple;
	bh=n72JmdMzJIo9j1P5az3z+hqeQi8sLKBLprzeW71Ueis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKSZl6JrNHBfF2C2JASdq8n875Yg/B6osfJrSEN5kRN7KQ1ynz/8kGbX6gsa0fGenBXBX4Ip5SrXZuR3AGI+t8jpjExcCc9JYaqWxTNwujLfMrrzIUoV3q9egt/80QLWBt0zauXIgbFhYmpTAICul75EI0+o0mltEwaWOzOMjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnIareX3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnIareX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A4DC4CEF7;
	Thu, 12 Mar 2026 01:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773278241;
	bh=n72JmdMzJIo9j1P5az3z+hqeQi8sLKBLprzeW71Ueis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnIareX3kFnsnX0zJudneOt4oJIuJmwVBAQS5SGS7pIGgjsl/BmPgCMTx5MfxEypN
	 3AWcSG4r0wwI0hyNPHDdLqPadnZtRUQPdBss1fQ3pzP8S4UY8syP1x553P7qZugDue
	 Rq1BfW1PnqPWeVdqX0XsfM+6x+PdfmHseE9MsUQ23fZDMHlbASud5wjp3nwoqccBHo
	 EOF0aAr19oPEtSi3rzOG+FGXpRjukP/S1c9HRVxFttxD4eHsyrB8DegwtKJTyKQx8q
	 GOmFQ+yczNOlRp4GwtWX7xumP+Foq+HdTMKVMdzGUvqWrUMqv32+7Ht6IPmEk203od
	 ui2yCT2YxtSKA==
Date: Wed, 11 Mar 2026 18:17:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf: Add layout support for --symfs option
Message-ID: <abIUH0ATipVuBKxz@google.com>
References: <20260309174412.1166259-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309174412.1166259-1-changbin.du@huawei.com>

On Mon, Mar 09, 2026 at 05:44:12PM +0000, Changbin Du wrote:
> Add support for parsing an optional layout parameter in the --symfs
> command line option. The format is:
> 
>   --symfs <directory[,layout]>
> 
> Where layout can be:
>   - 'hierarchy': matches full path (default)
>   - 'flat': only matches base name
> 
> When debugging symbol files from a copy of the filesystem (e.g., from a
> container or remote machine), the debug files are often stored in a
> flat directory structure with only filenames, not the full original
> paths. In this case, using 'flat' layout allows perf to find debug
> symbols by matching only the filename rather than the full path.
> 
> For example, given a binary path like:
>   /build/output/lib/foo.so
> 
> With 'perf report --symfs /debug/files,flat', perf will look for:
>   /debug/files/foo.so
> 
> Instead of:
>   /debug/files/build/output/lib/foo.so
> 
> This is particularly useful when:
> - Extracting debug files from containers with different directory layouts
> - Working with build systems that flatten directory structures
> 
> Changes:
> - Add symfs_layout_flat field to symbol_conf struct.
> - Parse optional layout in symbol__config_symfs().
> - Modify __symbol__join_symfs() to use basename() when layout
>   is 'flat'.
> - Update documentation in Documentation/ folder.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

