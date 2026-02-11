Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB90342CA7;
	Wed, 11 Feb 2026 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827710; cv=none; b=qe1AY+vKTmdFH9nAnE9XMfw8NCPkNuEOplJNoL+5ERLa5B0iuy/PesZCQaBZAgyZczONHu+ThMtlO0oksmNhyFKam5FTq2E8yP1gzO5T6ItWKagjqHD2BLKSveYvETfiFO/xI4MekxZfJg5f4ASiB5hNt7Vyk0vvoJFCJ5+jTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827710; c=relaxed/simple;
	bh=apgSBTEG7ZY6jvKbqjnoRi1NAp/MIqtLYi5dXzMdgjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk3ehiRjFSSWlRnKjoPJH1u6zd3Sw8Ux/8QaBAqHXQJHryMtWGy9h2FSrkBEBXSnJnnEwlWlWqOa/iz/3jEzYY8i4Pnyfias03Frt2EpBz+pTi+HDb1QBVuH3OB5XAOMoGMl9JGH0AWUIxAnFRvRWH3xMcU6jjYxIb/BAfygclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcL6GE5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcL6GE5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5B2C4CEF7;
	Wed, 11 Feb 2026 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770827710;
	bh=apgSBTEG7ZY6jvKbqjnoRi1NAp/MIqtLYi5dXzMdgjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcL6GE5d6gj/mkfVU1dYu1pNzvo5mCC3dwkC6T3BytIJtCWFh1GGhBXQIhXXmzyzY
	 lt+cR8Vlq7odtjdPWPNNUzni7gX2vLWQySI+6gwqe0wRrDaLevITAt7SZWG6OhT7Jw
	 dCX77EU/5cfzr79ZdNnT+6C8MwQt0ihoHm3h9LI53gvrPOMJdOr/Jgf49eLmaz/QiV
	 6SqUxnVZXOgguo0vZGbxmlHLaf5+z9myhURDEGTDIXfZ1tSxCBoHBqkrO6UDFk+AnR
	 IH8on0EXwwtVx24piv2WqLf4F62J6ajCWBadr2/1510AE/IiVL/o5y4FtnPE773tTg
	 VfTGE8D4JaF5Q==
Date: Wed, 11 Feb 2026 13:35:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Derek Foreman <derek.foreman@collabora.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/5] perf data pipe mode support and tests
Message-ID: <aYyvutsnYSnNfCsy@x1>
References: <20260211015242.2700218-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211015242.2700218-1-irogers@google.com>

On Tue, Feb 10, 2026 at 05:52:37PM -0800, Ian Rogers wrote:
> Add pipe mode support to perf data conversion. Add testing to perf
> data with pipe mode and add --to-ctf testing if libbabeltrace is
> present.
> 
> Ian Rogers (5):
>   perf check: Add libbabeltrace to the listed features
>   perf json: Pipe mode --to-json support
>   perf json: Pipe mode --to-ctf support
>   perf test: Test pipe mode with data conversion --to-json
>   perf test: perf data --to-ctf testing
 
Thanks, applied to perf-tools-next,

- Arnaldo

>  tools/perf/builtin-check.c                    |   1 +
>  .../shell/test_perf_data_converter_ctf.sh     | 104 ++++++++++++++++++
>  .../shell/test_perf_data_converter_json.sh    |  33 ++++--
>  tools/perf/util/data-convert-bt.c             |  54 ++++++++-
>  tools/perf/util/data-convert-json.c           |  16 +++
>  5 files changed, 197 insertions(+), 11 deletions(-)
>  create mode 100755 tools/perf/tests/shell/test_perf_data_converter_ctf.sh
> 
> -- 
> 2.53.0.239.g8d8fc8a987-goog
