Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C51D5150;
	Mon, 10 Mar 2025 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639562; cv=none; b=hWpKiYUlR5Mg5zQihfZdDhlW5hGm78YJuLaqYjTadvljh2wKPaxGtd82ENSx399/E03SA71opatuxk3UvsEWOz7xvB08vKKouSmj6dWtAgiI5usGEKYe69IJcQSaePFtGhElZ8yuVusARe1cc80SFl+uGRJ4YE2vBx2s6C3SrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639562; c=relaxed/simple;
	bh=fA1URd4R99/itZE2fqq4mCuoIUcgalZxg6XGoryNuY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISKl92vU0jHjw9K+EubfjDXGTcMbgCIQIikmHph9a9/Cs3tz0wkd8PA9qAmkCSyeEAueFR11GzcUf1nE16qtrwFXczHPmbgzn09sMc96Dhofyr51aIsDJk5Nae+8XvblJpjLhnN0ejdIDGY0u7kyIUCMCby1hn/i/JhwGoyeBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1xIwb7t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1xIwb7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47574C4CEE5;
	Mon, 10 Mar 2025 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639561;
	bh=fA1URd4R99/itZE2fqq4mCuoIUcgalZxg6XGoryNuY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1xIwb7tn+wCOKyWMEr1eay5sGbbATRcIer1z0xWsQB7rwbNIKpgIlSVwrQDgBAWV
	 eUCmkjIaYYR2h+/pOsnanOMhgVO81LaUl9nHU01UocROoFrKQsy8jpoWd/cHHLshwi
	 YeMgH6sM6wi9I4TJI5TzEj+ZVdboxPJz4wkdZm3Kkaz/WPWmb1dAxYDTOxJv3P1/T8
	 IRCsj+TosWZji329a7393n8gp2PTLiIEp0hCOIrNWYOEiIyHB37SjPPdAi3do3sk9g
	 Yqhuc/EW2T10izqg0uLNZiFxwYpuj6jSp2ioWyxSyT5dyae+vfkGnshlJstqN/q7G2
	 Xeopr8ZDxTRJg==
Date: Mon, 10 Mar 2025 17:45:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 05/11] perf python: Add member access to a number of
 evsel variables
Message-ID: <Z89PhsZgHwKhstIC@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-6-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:02PM -0800, Ian Rogers wrote:
> Most variables are part of the perf_event_attr, so that they may be
> queried and modified.
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 0cf81cfcfafb..b600b6379b4e 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -811,6 +811,28 @@ static PyMethodDef pyrf_evsel__methods[] = {
>  	{ .ml_name = NULL, }
>  };
>  
> +#define evsel_member_def(member, ptype, help) \
> +	{ #member, ptype, \
> +	  offsetof(struct pyrf_evsel, evsel.member), \
> +	  0, help }
> +
> +#define evsel_attr_member_def(member, ptype, help) \
> +	{ #member, ptype, \
> +	  offsetof(struct pyrf_evsel, evsel.core.attr.member), \
> +	  0, help }
> +
> +static PyMemberDef pyrf_evsel__members[] = {
> +	evsel_member_def(tracking, T_BOOL, "tracking event."),
> +	evsel_attr_member_def(type, T_UINT, "attribute type."),
> +	evsel_attr_member_def(size, T_UINT, "attribute size."),
> +	evsel_attr_member_def(config, T_ULONGLONG, "attribute config."),
> +	evsel_attr_member_def(sample_period, T_ULONGLONG, "attribute sample_period."),
> +	evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute sample_type."),
> +	evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read_format."),
> +	evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_events."),
> +	{ .name = NULL, },
> +};
> +
>  static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
>  
>  static PyTypeObject pyrf_evsel__type = {
> @@ -820,6 +842,7 @@ static PyTypeObject pyrf_evsel__type = {
>  	.tp_dealloc	= (destructor)pyrf_evsel__delete,
>  	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
>  	.tp_doc		= pyrf_evsel__doc,
> +	.tp_members	= pyrf_evsel__members,
>  	.tp_methods	= pyrf_evsel__methods,
>  	.tp_init	= (initproc)pyrf_evsel__init,
>  	.tp_str         = pyrf_evsel__str,
> -- 
> 2.48.1.711.g2feabab25a-goog
> 
