Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892A1A3027;
	Mon,  2 Sep 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298740; cv=none; b=fsntSCe1UbAxdzlFmJvSTaXkRS8t60+uKXnMV4LmaRtzTbGZ2agrlNDs2vzDNcKT+URvHRNx8yNxWBltTBtf5SrSibPKXgsClaVDR/K9JMR+AXBte05dRSSgbZiciW+BbfqU0XnwbroWQJiDt4mmYrcKIi55+gzq75K8hPgJn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298740; c=relaxed/simple;
	bh=bX+2Dk5f6Pn6flxK/K+xqLVqQh5xT/flT6CrVjGjCxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHdh9K73JEC2yCwlzvNGX+LznqXkcTG0Uh7taOY+QB1czVch94CAmdL9zPVX3IfF6oNIoLixlq5LtujT95qItKKWGvDqu2fF30O+ad004p+Hk903Ry0f13Ljj+7RnMgG8jOt0Ye6af6GZUIb5RoYSAfCLe5AoRhdeUbgGCYLmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyuUWjfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyuUWjfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B62C4CEC2;
	Mon,  2 Sep 2024 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725298739;
	bh=bX+2Dk5f6Pn6flxK/K+xqLVqQh5xT/flT6CrVjGjCxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyuUWjfJucWSO2Jw+/EPZwTJYmXsSYhljcyWtQ6cNX5zM9WpbEnCBxduIp+1YQygb
	 XdZi4zSQzCqIwy6DQxVh1TK1KvAHLPabA4dI57TnyCrGOhGEzb5ZZasW/9PsrVNvlG
	 JBaJiZl9JWetf4EmJxX178Rnrh3R1NR597dl+ED99PHZm+1rQQlosTpVNf9/uXMXJT
	 +K83ajMZTY70mUsGikiKJRAwPBVzNcqdYKBvU6wkCexTQ5iRpiWZS0SEgBbAH7evoo
	 OgP9INxucArjhh26GUVc8EWw3950w/3OuiJSJ9roqzT7/90KCkWCp4jDrC8HxZBgtJ
	 M+gB2IhFwcoDA==
Date: Mon, 2 Sep 2024 10:38:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 1/4] perf tools: Don't set attr.exclude_guest by default
Message-ID: <ZtX4MeNBledBXVnS@google.com>
References: <20240902014621.2002343-1-namhyung@kernel.org>
 <20240902014621.2002343-2-namhyung@kernel.org>
 <f9377001-f6d1-4e7f-a3b2-c80f5741b4a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9377001-f6d1-4e7f-a3b2-c80f5741b4a1@linaro.org>

On Mon, Sep 02, 2024 at 10:15:57AM +0100, James Clark wrote:
> 
> 
> On 02/09/2024 2:46 am, Namhyung Kim wrote:
> > The exclude_guest in the event attribute is to limit profiling in the
> > host environment.  But I'm not sure why we want to set it by default
> > cause we don't care about it in most cases and I feel like it just
> > makes new PMU implementation complicated.
> > 
> > Of course it's useful for perf kvm command so I added the
> > exclude_GH_default variable to preserve the old behavior for perf kvm
> > and other commands like perf record and stat won't set the exclude bit.
> > This is helpful for AMD IBS case since having exclude_guest bit will
> > clear new feature bit due to the missing feature check logic.
> 
> Probably another case where again the real fix would be to add
> /sys/bus/event_source/devices/cpu_core/caps/exclude_guest and then we're
> able to keep the defaults.

Yep, I really need to work on it.  But it's another story whether it's
supported and whether it's required.

> 
> > 
> >    $ sysctl kernel.perf_event_paranoid
> >    kernel.perf_event_paranoid = 0
> > 
> >    $ perf record -W -e ibs_op// -vv true 2>&1 | grep switching
> >    switching off PERF_FORMAT_LOST support
> >    switching off weight struct support
> >    switching off bpf_event
> >    switching off ksymbol
> >    switching off cloexec flag
> >    switching off mmap2
> >    switching off exclude_guest, exclude_host
> > 
> > Maybe Apple M1 users will scream but actually the default event for
> > perf record was converted to "cycles:P" which doesn't set the
> > exclude_guest bit already.  So they need to specify the necessary
> > modifier manually like "cycles:PH" and I think it's ok.
> 
> I'm reading this to assume that the default record command was always broken
> then? But what about any other command, now isn't just "cycles" also broken
> making it worse?

Hmm.. right.  Maybe we can add a detection logic to figure out the
required exclude bits for a PMU at runtime.

Thanks,
Namhyung

> 
> See 25412c036:
> 
>   ...
>   (c) The Apple M1/M2 PMU requires that perf_event_attr::exclude_guest
>       is set as the hardware PMU does not count while a guest is running
>       (but might be extended in future to do so).
>   ...
> 
> > 
> > Intestingly, I found it sets the exclude_bit if "u" modifier is used.
> > I don't know why but it's neither intuitive nor consistent.  Let's
> > remove the bit there too.
> > 
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >   tools/perf/builtin-kvm.c                   |  1 +
> >   tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
> >   tools/perf/tests/parse-events.c            | 18 +++++++++---------
> >   tools/perf/util/parse-events.c             |  2 +-
> >   tools/perf/util/util.c                     | 10 ++++++++--
> >   tools/perf/util/util.h                     |  3 +++
> >   6 files changed, 23 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > index 692267b1b7e8..ca94dd3de04d 100644
> > --- a/tools/perf/builtin-kvm.c
> > +++ b/tools/perf/builtin-kvm.c
> > @@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
> >   						"buildid-list", "stat", NULL };
> >   	const char *kvm_usage[] = { NULL, NULL };
> > +	exclude_HG_default = true;
> >   	perf_host  = 0;
> >   	perf_guest = 1;
> > diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
> > index 576ec48b3aaf..8ce6f0a5df5b 100644
> > --- a/tools/perf/tests/attr/test-record-dummy-C0
> > +++ b/tools/perf/tests/attr/test-record-dummy-C0
> > @@ -37,7 +37,7 @@ precise_ip=0
> >   mmap_data=0
> >   sample_id_all=1
> >   exclude_host=0
> > -exclude_guest=1
> > +exclude_guest=0
> >   exclude_callchain_kernel=0
> >   exclude_callchain_user=0
> >   mmap2=1
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > index edc2adcf1bae..9179bf3084c3 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -932,7 +932,7 @@ static int test__group2(struct evlist *evlist)
> >   			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >   			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> > -			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> > @@ -947,7 +947,7 @@ static int test__group2(struct evlist *evlist)
> >   			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >   			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> > -			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   			if (evsel__has_leader(evsel, leader))
> > @@ -1072,7 +1072,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
> >   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >   		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> > -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> > @@ -1222,7 +1222,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
> >   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >   		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> > -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> > @@ -1437,7 +1437,7 @@ static int test__leader_sample1(struct evlist *evlist)
> >   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >   		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> > -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> > @@ -1453,7 +1453,7 @@ static int test__leader_sample1(struct evlist *evlist)
> >   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >   		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> > -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> > @@ -1468,7 +1468,7 @@ static int test__leader_sample1(struct evlist *evlist)
> >   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >   		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> > -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> > @@ -1497,7 +1497,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
> >   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >   		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> > -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> > @@ -1513,7 +1513,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
> >   		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
> >   		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >   		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> > -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> > +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >   		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >   		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >   		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index fab01ba54e34..ab73b3d45f04 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1739,7 +1739,7 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
> >   		if (mod.user) {
> >   			if (!exclude)
> >   				exclude = eu = ek = eh = 1;
> > -			if (!exclude_GH && !perf_guest)
> > +			if (!exclude_GH && !perf_guest && exclude_HG_default)
> >   				eG = 1;
> >   			eu = 0;
> >   		}
> > diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> > index 9d55a13787ce..7e3159faaa19 100644
> > --- a/tools/perf/util/util.c
> > +++ b/tools/perf/util/util.c
> > @@ -78,17 +78,23 @@ bool sysctl__nmi_watchdog_enabled(void)
> >   bool test_attr__enabled;
> > +bool exclude_HG_default;
> > +
> >   bool perf_host  = true;
> >   bool perf_guest = false;
> >   void event_attr_init(struct perf_event_attr *attr)
> >   {
> > +	/* to capture ABI version */
> > +	attr->size = sizeof(*attr);
> > +
> > +	if (!exclude_HG_default)
> > +		return;
> > +
> >   	if (!perf_host)
> >   		attr->exclude_host  = 1;
> >   	if (!perf_guest)
> >   		attr->exclude_guest = 1;
> > -	/* to capture ABI version */
> > -	attr->size = sizeof(*attr);
> >   }
> >   int mkdir_p(char *path, mode_t mode)
> > diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> > index 9966c21aaf04..d33ae883a54f 100644
> > --- a/tools/perf/util/util.h
> > +++ b/tools/perf/util/util.h
> > @@ -21,6 +21,9 @@ extern const char perf_more_info_string[];
> >   extern const char *input_name;
> > +/* This will control if perf_{host,guest} will set attr.exclude_{host,guest}. */
> > +extern bool exclude_HG_default;
> > +
> >   extern bool perf_host;
> >   extern bool perf_guest;
