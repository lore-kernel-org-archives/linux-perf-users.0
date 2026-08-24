Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C393932EA
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609542; cv=none; b=Kblo/j5kKMlgEw8ER32dEsH+sSoVa+VscSB50Kcq/gsbECGN7rIdVGJK9QDAxc7S3doZEpgw5HDNm9hg7NcvFLQKswfNDm8AEVUY1luTrWCXQzZN4pYI8JpB3Sp5N67O8Nh1C7xYKxEnyt6fNNjXx8Io/G+sOZCP25Yq2EekjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609542; c=relaxed/simple;
	bh=qjw214U5/ORQfcpCagzS0jixNF4x4Wxq19G7s8NmSg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMp20qsS1stc/WvJ9YRbr/OWWVLeBycEAO/7IDv9IdMw7VxkGIu3RjI1h51Wxl2nqbxt1IO6S0FT91HBiQvvH2PkxPjdGyGUIAA1dqiEpkYuUlU4LsBwq2Z26Xb5JFebobtKLZ+LUYRqu4T+eqRM4k+l+2Tpe0Q/NN+iTKyj3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDngvxsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDngvxsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2589F1F000E9;
	Mon, 24 Aug 2026 22:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609541;
	bh=GJEmLvDQx8cZ0hA8rzQGeZxU0UwLm8M/IUT0Qzpy4WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YDngvxsQJfjqfXrMTVitHT29fHb3R8hVx9XLZui96/ipVLdZcsTqmGdwsATMS/oWg
	 xFY5Glfv1GatZOmSPm3FraH8h6Ld1MgQ1/2lGWLLKdQ9l9bBbGyq5udnUheNbCCBlL
	 4gkgUMuOChkDqpz5KECaXQ8eZgkjiJuWFY9DDIoIPTWqbtAc66LN9jVj8oDby9XO4+
	 ZsKsgsLl20aAZ5rNe1ro2XzwUOUakjfiP28KdppEvCjoI9LkvDp/vt91c79X11UNJL
	 5KHxV/pEYZ7zbWdjKW7RDtsnmaXqQ2XbxxUTVmveYpG9G1CSES3j6BpgtcmASj3QYt
	 fcALjlBbbblwQ==
Date: Mon, 24 Aug 2026 15:12:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v1 0/2] perf annotate: Fix source option behavior and
Message-ID: <aozBwyQ85OjoPlMi@google.com>
References: <20260818144149.101248-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818144149.101248-1-kohei@enjuk.jp>

Hello,

On Tue, Aug 18, 2026 at 02:40:11PM +0000, Kohei Enju wrote:
> Source annotation has been disabled by default since e201757f7a0a ("perf
> annotate: Fix source code annotate with objdump"), but the documentation
> still describes the old default. Also, an explicit --source does not
> currently override annotate.hide_src_code.
> 
> Update the documentation and make explicit --source/--no-source take
> precedence over the configuration.
> 
> Kohei Enju (2):
>   perf config: Fix annotate.hide_src_code documentation
>   perf annotate: Honor explicit --source option

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-annotate.txt  | 4 ++--
>  tools/perf/Documentation/perf-config.txt    | 6 +++---
>  tools/perf/Documentation/perf-report.txt    | 4 ++--
>  tools/perf/Documentation/perf-top.txt       | 4 ++--
>  tools/perf/Documentation/perfconfig.example | 2 +-
>  tools/perf/builtin-annotate.c               | 7 +++++--
>  tools/perf/builtin-report.c                 | 7 +++++--
>  tools/perf/builtin-top.c                    | 7 +++++--
>  8 files changed, 25 insertions(+), 16 deletions(-)
> 
> -- 
> 2.53.0
> 
