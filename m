Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE402FA627;
	Thu,  3 Jul 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566897; cv=none; b=s/Fj1OtMTBun+V/mT0yxdxtcF4jDORVFTh9QrMOjcmEh2hq/caBi31L3VHJfrNmTdI8aUGFt/4NXrnXzuV0BgwTAVYEdMmF7u3q1f5EaWJVE6qScq1EIkWz0WZE3MG7TyFwv8kYGCIilsYO5P0C7w0nXM/+HUZeofe5H/Ha1ep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566897; c=relaxed/simple;
	bh=comsglRO8MoeAgt/YG6y2jZ5FywI+W3zZGLs2qsqv44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfDOl7WkHdHgId0Qd6iaMXVFAi0Z8wXm/I9k8KNGC4Buix8CzjvjZqZmr0k2YRaya4ZG6N9UeyEd98xhjkSuEzaUaYAzrcLV0TEf1eToO8pay17kcIV8/nipP4h9+9J0SF+It1irjE6GYftaG4x7Uua9ULZvsXy/aUh5t7HPBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwlBNp+d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwlBNp+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06BCC4CEE3;
	Thu,  3 Jul 2025 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751566897;
	bh=comsglRO8MoeAgt/YG6y2jZ5FywI+W3zZGLs2qsqv44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwlBNp+dX0hCAI2HTyVDK3m5Od/dtveV7FsJ+ijhFLEUt9x/JdKV/HA8g9ZDkdn6w
	 z+qd4xdd9dj+8V/Gld5AqYA13L+rZrW4826MXAEiLa+Sml5NqsdJ5IuN70s1eE9tC8
	 05p5y8Fl5Siemdh2OFRfGRMfZH85Vcme0FEsD4WLaC5PCDdvHJxBZ0U6+ZnsgXRQ8d
	 2V/b1hE1wHu41sbrchSa0Fy9JAh2ot4mElNkwZTB/os1UreFjchoajviXctzIIhNRz
	 thPG3M2RDsnZDlEbaoKWU2fsRJrWlVcVHg/HOwBb55/gsc5wRWND3uKzaB407LWK+u
	 +4LWsZi92a5zA==
Date: Thu, 3 Jul 2025 11:21:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf header: Fix pipe mode header dumping
Message-ID: <aGbKLj6ZQxlVrXAA@google.com>
References: <20250703042000.2740640-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703042000.2740640-1-irogers@google.com>

On Wed, Jul 02, 2025 at 09:20:00PM -0700, Ian Rogers wrote:
> The pipe mode header dumping was accidentally removed when tracing of
> header feature events in pipe mode was added.
> 
> Minor spelling tweak to header test failure message.
> 
> Fixes: 61051f9a8452 ("perf header: In pipe mode dump features without --header/-I")
> Signed-off-by: Ian Rogers <irogers@google.com>

Yep, this makes the header test succeed.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/header.sh |  2 +-
>  tools/perf/util/header.c         | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/header.sh b/tools/perf/tests/shell/header.sh
> index 412263de6ed7..e1628ac0a614 100755
> --- a/tools/perf/tests/shell/header.sh
> +++ b/tools/perf/tests/shell/header.sh
> @@ -42,7 +42,7 @@ check_header_output() {
>    do
>      if ! grep -q -E "$i" "${script_output}"
>      then
> -      echo "Failed to find expect $i in output"
> +      echo "Failed to find expected $i in output"
>        err=1
>      fi
>    done
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 487f663ed2de..53d54fbda10d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -4343,6 +4343,7 @@ int perf_event__process_feature(struct perf_session *session,
>  	int type = fe->header.type;
>  	u64 feat = fe->feat_id;
>  	int ret = 0;
> +	bool print = dump_trace;
>  
>  	if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
>  		pr_warning("invalid record type %d in pipe-mode\n", type);
> @@ -4362,8 +4363,20 @@ int perf_event__process_feature(struct perf_session *session,
>  		goto out;
>  	}
>  
> -	if (dump_trace) {
> +	if (session->tool->show_feat_hdr) {
> +		if (!feat_ops[feat].full_only ||
> +		    session->tool->show_feat_hdr >= SHOW_FEAT_HEADER_FULL_INFO) {
> +			print = true;
> +		} else {
> +			fprintf(stdout, "# %s info available, use -I to display\n",
> +				feat_ops[feat].name);
> +		}
> +	}
> +
> +	if (dump_trace)
>  		printf(", ");
> +
> +	if (print) {
>  		if (feat_ops[feat].print)
>  			feat_ops[feat].print(&ff, stdout);
>  		else
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
