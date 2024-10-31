Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBF347C7;
	Thu, 31 Oct 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402624; cv=none; b=EW/VkPiNS1e+df7N5+WUClBDSY5J1Q0kZYnDntFHy3+2B47RZbw1wRM1tRPe4j+Ms+eQsdC+mtyJUh+4UipiQV9sFSjSdgEAkC+SAUr+E8Dm9YCtd4tXAb0j0P5RR01bLiRCgTqWeOCZv2mzHtfuPipOHdoohSpo/W0m5wILffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402624; c=relaxed/simple;
	bh=OqHzbT3W6OUzCW6HNPgRXYBBlYhhv7Stk2knreBpnjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OngDTrAPX0L+OCBqjqBWDW1wKL8bwZvohxpe+GycF0/41ivmREWtCIjeTlRGeMIpB5ofQYh2D0K+URsEpSm404/vhmN4732OMcrF9edApdTZTTDIDKk3Ul1viZ7NlVPkMgk1XSn/xWJM/gDlLHWyEE1iSnRjVShRvq/oVDSx2XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqiCf/AG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqiCf/AG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8E8C4CEC3;
	Thu, 31 Oct 2024 19:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402624;
	bh=OqHzbT3W6OUzCW6HNPgRXYBBlYhhv7Stk2knreBpnjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqiCf/AGbUZQOaNE8OI36OiQsFiBpq2yXa8ZSuxhdkB7ZuQdHOo2jz+DswOk3rFOv
	 pZNWII/nGrJC50CCmyDjuI98OkcpufFeQn3YHOclfvRt5bmoRVtZq96Bi4FoFZ7fkf
	 m/7inUrj35a4RnCofMMym++FH1Y7635suRm9qD9nJkgQelFZCSiZq3CIBr36TgcRVC
	 XQAzHxVAb16KZRKPiFjENbXMtqargUJ3XMEWTsTX8uDQ4sVd7i0D2lVVaxixLHMcXA
	 f5mg5ToMINg3q5z4IICpNbnwcoAvx8mqtUmZzoNb4kf4FZxB/3m9dgzaGdsU16lwwu
	 GX65iB1dTG4RQ==
Date: Thu, 31 Oct 2024 16:23:40 -0300
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
Subject: Re: [PATCH v5 21/21] perf python: Correctly throw IndexError
Message-ID: <ZyPZPMPuzzZHSGB_@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-22-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:52PM -0700, Ian Rogers wrote:
> Correctly throw IndexError for out-of-bound accesses to evlist:
> ```
> Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import sys
> >>> sys.path.insert(0, '/tmp/perf/python')
> >>> import perf
> >>> x=perf.parse_events('cycles')
> >>> print(x)
> evlist([cycles])
> >>> x[2]
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> IndexError: Index out of range
> ```

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 0d71ec673aa3..25114dcadd21 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1071,8 +1071,10 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
>  	struct pyrf_evlist *pevlist = (void *)obj;
>  	struct evsel *pos;
>  
> -	if (i >= pevlist->evlist.core.nr_entries)
> +	if (i >= pevlist->evlist.core.nr_entries) {
> +		PyErr_SetString(PyExc_IndexError, "Index out of range");
>  		return NULL;
> +	}
>  
>  	evlist__for_each_entry(&pevlist->evlist, pos) {
>  		if (i-- == 0)
> -- 
> 2.47.0.163.g1226f6d8fa-goog
