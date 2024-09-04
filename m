Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5631DB52D;
	Wed,  4 Sep 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455246; cv=none; b=OFVWuHniAPLIrqThDXFrivyixGWyw58hubRja34dtGVnhkIiLtUzX+/yBmlPKI3yzbBQmEX1uu5YzERYkYAC0E/SCE4OWtrzVbdpfRByTKnRR2RR2RtaCA5F4e+XgnlFvPCYFcX8epsNBHMc1+00F8ta3O5cq3qNRvlGZ/1kdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455246; c=relaxed/simple;
	bh=doGplWmC7gTV2We5eGUFR0c1CPu4CTYCqcKo329WYjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIdUmYQmmqSTwHeNbF+Lg4FWI34vygZlwdAo6OgW7LUS7+LKII9IQ/ij5tiG8Kzuobni+AjSo7s/0UjQKCUC3scuehCcmgHy7aPCMQp5clSXbpIDZbqM8yKmhNILVocD3Tu0r310HVL0AMPZF02LyQspDOLWDhO5kwSnLIVp9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdcJxWsx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdcJxWsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444EAC4CEC2;
	Wed,  4 Sep 2024 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725455245;
	bh=doGplWmC7gTV2We5eGUFR0c1CPu4CTYCqcKo329WYjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdcJxWsxH/yM3H+MhcioMttY5yBXFMqED1TkV1CTGStTzbJdhi18depeHWM/0+ucF
	 t0MA24sSfg7y7EZ/0CdGvz6Fqbh8TXgCqzOfTJLf0nBXbIl+wyRDG/MyHnLo6jYyBc
	 cqw2Zuz0Oa+hLF38qJI+Rq5qyM2dDQA9xzqAzbvD8CqmE591CD3Q3KY/44v5nr5QX2
	 n+2po4pY1VYgf6gOVMsjv/Ab046E2UojhwFOcXtitZgRoi4XxPBUo0fFDt1FjHo8On
	 67bmyenFfIz8zmKzB/P6LAwXQxaNUPW2gy+NE2NO9/oxg+vo+LC5nqji5REDXZKZPy
	 Qhi1SAbd0URaw==
Date: Wed, 4 Sep 2024 10:07:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH 1/8] perf tools: Don't set attr.exclude_guest by default
Message-ID: <ZthbiKEi7BMr_Zuz@x1>
References: <20240904064131.2377873-1-namhyung@kernel.org>
 <20240904064131.2377873-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904064131.2377873-2-namhyung@kernel.org>

On Tue, Sep 03, 2024 at 11:41:24PM -0700, Namhyung Kim wrote:
> The exclude_guest in the event attribute is to limit profiling in the
> host environment.  But I'm not sure why we want to set it by default
> cause we don't care about it in most cases and I feel like it just
> makes new PMU implementation complicated.
> 
> Of course it's useful for perf kvm command so I added the
> exclude_GH_default variable to preserve the old behavior for perf kvm
> and other commands like perf record and stat won't set the exclude bit.
> This is helpful for AMD IBS case since having exclude_guest bit will
> clear new feature bit due to the missing feature check logic.
> 
>   $ sysctl kernel.perf_event_paranoid
>   kernel.perf_event_paranoid = 0
> 
>   $ perf record -W -e ibs_op// -vv true 2>&1 | grep switching
>   switching off PERF_FORMAT_LOST support
>   switching off weight struct support
>   switching off bpf_event
>   switching off ksymbol
>   switching off cloexec flag
>   switching off mmap2
>   switching off exclude_guest, exclude_host
> 
> Maybe Apple M1 users will scream but actually the default event for
> perf record was converted to "cycles:P" which doesn't set the
> exclude_guest bit already.  So they need to specify the necessary
> modifier manually like "cycles:PH" and I think it's ok.

Would be really, really good to have a Tested-by: Someone # on an Apple M1

I'll reinstall my rk-3399-pc and try it on that hybrid aarch64 board.

I have access to Ampere Altra systems, will try there as well.

- Arnaldo
 
> Intestingly, I found it sets the exclude_bit if "u" modifier is used.
> I don't know why but it's neither intuitive nor consistent.  Let's
> remove the bit there too.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-kvm.c                   |  1 +
>  tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
>  tools/perf/tests/parse-events.c            | 18 +++++++++---------
>  tools/perf/util/parse-events.c             |  2 +-
>  tools/perf/util/util.c                     | 10 ++++++++--
>  tools/perf/util/util.h                     |  3 +++
>  6 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 692267b1b7e8311f..ca94dd3de04d34a3 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
>  						"buildid-list", "stat", NULL };
>  	const char *kvm_usage[] = { NULL, NULL };
>  
> +	exclude_HG_default = true;
>  	perf_host  = 0;
>  	perf_guest = 1;
>  
> diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
> index 576ec48b3aafaa6a..8ce6f0a5df5b7013 100644
> --- a/tools/perf/tests/attr/test-record-dummy-C0
> +++ b/tools/perf/tests/attr/test-record-dummy-C0
> @@ -37,7 +37,7 @@ precise_ip=0
>  mmap_data=0
>  sample_id_all=1
>  exclude_host=0
> -exclude_guest=1
> +exclude_guest=0
>  exclude_callchain_kernel=0
>  exclude_callchain_user=0
>  mmap2=1
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index edc2adcf1baed195..9179bf3084c302c1 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -932,7 +932,7 @@ static int test__group2(struct evlist *evlist)
>  			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -947,7 +947,7 @@ static int test__group2(struct evlist *evlist)
>  			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  			if (evsel__has_leader(evsel, leader))
> @@ -1072,7 +1072,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -1222,7 +1222,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -1437,7 +1437,7 @@ static int test__leader_sample1(struct evlist *evlist)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1453,7 +1453,7 @@ static int test__leader_sample1(struct evlist *evlist)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> @@ -1468,7 +1468,7 @@ static int test__leader_sample1(struct evlist *evlist)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1497,7 +1497,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1513,7 +1513,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index fab01ba54e34da7d..ab73b3d45f0467f9 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1739,7 +1739,7 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
>  		if (mod.user) {
>  			if (!exclude)
>  				exclude = eu = ek = eh = 1;
> -			if (!exclude_GH && !perf_guest)
> +			if (!exclude_GH && !perf_guest && exclude_HG_default)
>  				eG = 1;
>  			eu = 0;
>  		}
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 9d55a13787ce3c05..7e3159faaa1991df 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -78,17 +78,23 @@ bool sysctl__nmi_watchdog_enabled(void)
>  
>  bool test_attr__enabled;
>  
> +bool exclude_HG_default;
> +
>  bool perf_host  = true;
>  bool perf_guest = false;
>  
>  void event_attr_init(struct perf_event_attr *attr)
>  {
> +	/* to capture ABI version */
> +	attr->size = sizeof(*attr);
> +
> +	if (!exclude_HG_default)
> +		return;
> +
>  	if (!perf_host)
>  		attr->exclude_host  = 1;
>  	if (!perf_guest)
>  		attr->exclude_guest = 1;
> -	/* to capture ABI version */
> -	attr->size = sizeof(*attr);
>  }
>  
>  int mkdir_p(char *path, mode_t mode)
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 9966c21aaf048479..d33ae883a54f2f2f 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -21,6 +21,9 @@ extern const char perf_more_info_string[];
>  
>  extern const char *input_name;
>  
> +/* This will control if perf_{host,guest} will set attr.exclude_{host,guest}. */
> +extern bool exclude_HG_default;
> +
>  extern bool perf_host;
>  extern bool perf_guest;
>  
> -- 
> 2.46.0.469.g59c65b2a67-goog
