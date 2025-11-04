Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8F8248C;
	Tue,  4 Nov 2025 04:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232194; cv=none; b=QxJSKSs5Wq5kUlQzBsehv6GPfgigxBiHLGI/GuKgOwpKmZswAM0rj5i40KrJ0XeHVG7QtT7zJtjuPkz19zRjfvu6RJOJZ1/P+hrVPLTsyKH4z4RBjc3ns2417dvQcwG3YgdNq6J1yZyctunUhjEYn+YLnGYH+prBp+ZevoDYXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232194; c=relaxed/simple;
	bh=dhmMrBLVyxKqMVKDRWFG+f1uPSry0Fn1e2cRqwN+yhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSiAQW68CyxdfD6tX4wnsNJF4+0kNrrCD1hd1c7YGahdXJ6afii9rHAfktXJvmgdVJ1eGyGmHc1hVJ4dRocvy6tlCM07NDtqBoKYlT40jlqS+jylv+RakvF1c7QGbb8ICFlhx9NjD59Bl6XAbjQz3YkbBCc5pomvMGC+OsyCnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdvIqm0m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdvIqm0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCAEC4CEF7;
	Tue,  4 Nov 2025 04:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762232193;
	bh=dhmMrBLVyxKqMVKDRWFG+f1uPSry0Fn1e2cRqwN+yhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdvIqm0m5T/jQVSaj2gcqgFV2ODzlxZevbS1Rx+z92uRlH8uO+SwcQTblaLEcSDyR
	 OjpFYwotQkCiPPGZbYrNA90PlooY4n1PQ+HPf8TQaPbwUZxSZJgt626yugupolJqgH
	 cUvqfBoISpJ3ZzSHX+smQxMbz0SRJJVSlPZCTHQJNU2hemd5E8go9P1ZqbTYmu5wEH
	 9iMQDv9npjV5eIN3u8cfrLMAOE13na2tXGS+4hh++hnsO2uSof8tzy74yV56/9B6PD
	 1fc6lESqnC2paB3qaO3JzCloG08dpOnedXmlJP+8tPWj+sNenaU80uKssOl1EWpRIq
	 tpvrfogCQV90A==
Date: Mon, 3 Nov 2025 20:56:31 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 07/22] perf expr: Add #target_cpu literal
Message-ID: <aQmHfya8SYIcVGcg@google.com>
References: <20251024175857.808401-1-irogers@google.com>
 <20251024175857.808401-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024175857.808401-8-irogers@google.com>

On Fri, Oct 24, 2025 at 10:58:42AM -0700, Ian Rogers wrote:
> For CPU nanoseconds a lot of the stat-shadow metrics use either
> task-clock or cpu-clock, the latter being used when
> target__has_cpu. Add a #target_cpu literal so that json metrics can
> perform the same test.

Do we have documentation for the literals and metric expressions in
general?  I think it's getting complex and we should provide one.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/expr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 7fda0ff89c16..4df56f2b283d 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -409,6 +409,9 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
>  	} else if (!strcmp("#core_wide", literal)) {
>  		result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list)
>  			? 1.0 : 0.0;
> +	} else if (!strcmp("#target_cpu", literal)) {
> +		result = (ctx->system_wide || ctx->user_requested_cpu_list)
> +			? 1.0 : 0.0;
>  	} else {
>  		pr_err("Unrecognized literal '%s'", literal);
>  	}
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 
