Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64913AD03;
	Thu, 31 Oct 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402573; cv=none; b=spCFLoiF6glxwZ6+SWqZoIIC5n8ZZ7LKSdwpBmmkUC2U3R2nBIBK5aoS49osdoFBCuq2pQXcREDDadAAA8KrRKK0b6KL4PKdJqG6FpEA5KFwJD771pnfcNNvagPsoS24B9/HZ7rELUPGQf8LX2OUi5bLmP9HeDLlnpPRMrH90hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402573; c=relaxed/simple;
	bh=DJUCf3ljFjSD5vA8Dx1qWfX0hrTWyHwLabFgpdIEa8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/3U8+UIDl+Ra+54YYFKgS/IxCxpVQi2AV+9T7mlbAybPynE6fkKd6EuD2GX18BRtlEp5tRCCf1vEBV2BHUzY8pmceLB3KRAduG36bgNaCGhh6leNAF5hDHy2o8c6md+xPmock1HLmI5XGBOlXNSMBQ/tGBhtDXrpiUiTiROxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhxLCSdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhxLCSdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3157C4CEC3;
	Thu, 31 Oct 2024 19:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402573;
	bh=DJUCf3ljFjSD5vA8Dx1qWfX0hrTWyHwLabFgpdIEa8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhxLCSdY74d1bHTnusqvxOjc5b7HsCQ+oNG2L4xRcf1Pv9hvISTxM/Cyh2kSksBbp
	 2WpGeMoQD0+jLu5ZyaTvoGVWZtBeVDlqK58oG7ZvRn4jIrIO0aYf+AMwsecVfeKN8u
	 bZa3fOACZFwibvIh6dF6pfUsPaT6TvNoAEMjcnoA2glHzfY0rwpWSLaWAtRADWiwDX
	 zNcBN2+zaCqzaupakg87h9BeBuWVccTU4fdcZcuv4kyKHLn3CQsk2zkqRc91vgrtvt
	 xiu6eQbjbCJCi1z1ZDfW4anOBSR2y44QRkDO9XWoP+iPQK4NyMXULU4N+6uxX79o2V
	 sy4eGxk5mAtCQ==
Date: Thu, 31 Oct 2024 16:22:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 19/21] perf python: Add __str__ and __repr__ functions
 to evlist
Message-ID: <ZyPZCbwBdypPhDHA@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-20-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:50PM -0700, Ian Rogers wrote:
> This allows the values in the evlist to be shown in the REPL like:
> ```
> Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import sys
> >>> sys.path.insert(0,'/tmp/perf/python')
> >>> import perf
> >>> perf.parse_events('cycles,data_read')
> evlist([cycles,uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/])
> ```

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 1a53a97c513d..a71bad3418da 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1069,6 +1069,30 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
>  	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
>  }
>  
> +static PyObject *pyrf_evlist__str(PyObject *self)
> +{
> +	struct pyrf_evlist *pevlist = (void *)self;
> +	struct evsel *pos;
> +	struct strbuf sb = STRBUF_INIT;
> +	bool first = true;
> +	PyObject *result;
> +
> +	strbuf_addstr(&sb, "evlist([");
> +	evlist__for_each_entry(&pevlist->evlist, pos) {
> +		if (!first)
> +			strbuf_addch(&sb, ',');
> +		if (!pos->pmu)
> +			strbuf_addstr(&sb, evsel__name(pos));
> +		else
> +			strbuf_addf(&sb, "%s/%s/", pos->pmu->name, evsel__name(pos));
> +		first = false;
> +	}
> +	strbuf_addstr(&sb, "])");
> +	result = PyUnicode_FromString(sb.buf);
> +	strbuf_release(&sb);
> +	return result;
> +}
> +
>  static PySequenceMethods pyrf_evlist__sequence_methods = {
>  	.sq_length = pyrf_evlist__length,
>  	.sq_item   = pyrf_evlist__item,
> @@ -1086,6 +1110,8 @@ static PyTypeObject pyrf_evlist__type = {
>  	.tp_doc		= pyrf_evlist__doc,
>  	.tp_methods	= pyrf_evlist__methods,
>  	.tp_init	= (initproc)pyrf_evlist__init,
> +	.tp_repr        = pyrf_evlist__str,
> +	.tp_str         = pyrf_evlist__str,
>  };
>  
>  static int pyrf_evlist__setup_types(void)
> -- 
> 2.47.0.163.g1226f6d8fa-goog
