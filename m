Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43831DFF7;
	Mon,  5 Aug 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888215; cv=none; b=HN3+o9wC81ju7/7AUgAvGbVzdCB92eYbBQYtZzIhv9CrfFPGHhjeHaIxkyKxuxK6WnhoKcIoCUfbrRa+E8LxydNaHBYq7YB536fH1YGlD60b/kArmCRbetG3SXPEsddaDlxDAj+TgJiX7g8xY7HxMpEW/G9pqUeJIcN3Nho6XKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888215; c=relaxed/simple;
	bh=I56lUn0T50rnwoB+HaYuikOVZBf51CF/GJDlHl+cHv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGfvAZqsmJkpZoHhmVx2hx/ZaW6srQ5Vdk9ZDLJqqVjQmdS2suKcvsbhgeBpUyy8I+XhSmTV4lFy96VIWnNcZ4IZXNEAiOYPEhMsTPDX53xBE1IYGlJPb3TLZzhXO0gsbigklGwZRpBGFUqhR/Rt++wkhvLAt5sCMVi0xVix1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EueP6hOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EueP6hOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74948C32782;
	Mon,  5 Aug 2024 20:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722888215;
	bh=I56lUn0T50rnwoB+HaYuikOVZBf51CF/GJDlHl+cHv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EueP6hOJGnTdBDozqxx7yqeaV2qTCDlkr06m4184D/UI9UftacpfKZYFpT8Y3mpg+
	 N8yKNOb2Rvsw3eyOnm+LT7gpFmKFEwI/KrR2zrMK+jeGnJr/9bdjLErlqRn5r1Vjaq
	 acPjUwecYZv8s2Dcvb7h5uTIyLqbi/tpAihSW1lR9hiIMNkMG/D0VbmMqKc46Uiqm1
	 lTtgD1IctE4V0A+UJNIDJ7lA7IV/hlCjO6GIEjiugkOArXFCnqSFJjY0eViv8Q/nsI
	 bqp++huTXR0u7xplv2gksTdgcc4DtDjPWoETjDS0i3e1Yas3F6rtCcvypOozCeIH2D
	 9BKsxQUgHZJuw==
Date: Mon, 5 Aug 2024 17:03:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Ci-Jyun Wu <dminus@andestech.com>,
	Locus Wei-Han Chen <locus84@andestech.com>,
	Atish Patra <atishp@rivosinc.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com,
	greentime.hu@sifive.com, Eric Lin <eric.lin@sifive.com>
Subject: Re: [PATCH v1 2/5] perf pmu-events: Change dependencies for
 empty-pmu-events.c test
Message-ID: <ZrEwE1bzUsfC6Wfl@x1>
References: <20240805194424.597244-1-irogers@google.com>
 <20240805194424.597244-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805194424.597244-2-irogers@google.com>

On Mon, Aug 05, 2024 at 12:44:21PM -0700, Ian Rogers wrote:
> Switch from $? (all the prerequisites that are newer than the target)
> to $^ (all the prerequisites) as touching jevents.py will mean that
> empty-pmu-events.c won't be passed to the diff command breaking the
> build.

Thanks, added:

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/Build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index c3fa43c49706..d941bc9d16e9 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -39,7 +39,7 @@ $(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(ME
>  
>  $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
> +	$(Q)$(call echo-cmd,test)diff -u $^ 2> $@ || (cat $@ && false)
>  
>  $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
>  	$(call rule_mkdir)
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
> 
