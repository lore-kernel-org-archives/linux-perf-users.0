Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD1B2114
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987772; cv=none; b=un/GPXzfjG8a5NvYkO/htCb9DxoKkW67o5lYKUNLJ2LjoF56xaaFbZafPpd7VTXJjccNg6Mn7wEjMVPlMQiiQMreCaftMfPzB16jwrWMMhLmqljHJ3Wloh/GRgNF0DM5/sWQ8pz3l52/rViGEAj1IgVqWm76v/POYBVCeK7qgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987772; c=relaxed/simple;
	bh=dUIM7ae7yvsDxVnRVGglZ93yjiyBAEx19zx4AqhLkdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG5DDbz/ylkmGjxHxwRr80wXQ6Md8RJOwX20oCBJPmlps0MpkLUpyJ8k41vVigsekEplXmqajKXKEFfEeeFi+9gQ1hgATUO4WxivBGdjZPHL0EOUF+tSnToV/1u/0nYAK21ZMGkh6rh7H20Ww9hD/iF3/YRClhS/jzagM+sJNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8323497;
	Thu,  7 Nov 2024 05:56:38 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97AB93F6A8;
	Thu,  7 Nov 2024 05:56:08 -0800 (PST)
Date: Thu, 7 Nov 2024 13:56:06 +0000
From: Leo Yan <leo.yan@arm.com>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, tmricht@linux.ibm.com,
	acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: Re: [PATCH] tools/perf/tests/expr: Make the system_tsc_freq test
 only for intel
Message-ID: <20241107135606.GA47850@e132581.arm.com>
References: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>
 <ZyF2-XNUh38p_5Gg@google.com>
 <B72F330F-2A56-41B0-ABED-FCA7DC9EE711@linux.vnet.ibm.com>
 <CAP-5=fXCYURva6Q8ktRVmnf2QCcsr-E3fPn327k0JRCw_9fn3A@mail.gmail.com>
 <BBF1A4DC-3BD9-4377-BE2F-CBEFE55F0497@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BBF1A4DC-3BD9-4377-BE2F-CBEFE55F0497@linux.vnet.ibm.com>

Hi Athira,

On Wed, Nov 06, 2024 at 03:04:57PM +0530, Athira Rajeev wrote:

[...]

> > Hi Athira,
> >
> > sorry for the breakage and thank you for the detailed explanation. As
> > the code will run on AMD I think your change will break that - . It is
> > probably safest to keep the ".. else { .." for this case but guard it
> > in the ifdef.
> >
> 
> Hi Ian
> 
> Thanks for your comments. Does the below change looks good ?
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index e3aa9d4fcf3a..f5b2d96bb59b 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -74,14 +74,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>     double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
>     int ret;
>     struct expr_parse_ctx *ctx;
> -    bool is_intel = false;
>     char strcmp_cpuid_buf[256];
>     struct perf_pmu *pmu = perf_pmus__find_core_pmu();
>     char *cpuid = perf_pmu__getcpuid(pmu);
>     char *escaped_cpuid1, *escaped_cpuid2;
> 
>     TEST_ASSERT_VAL("get_cpuid", cpuid);
> -    is_intel = strstr(cpuid, "Intel") != NULL;
> 
>     TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
> 
> @@ -244,11 +242,13 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>     if (num_dies) // Some platforms do not have CPU die support, for example s390
>         TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> 
> +#if defined(__i386__) && defined(__x86_64__)
>     TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
> -    if (is_intel)
> +    if (strstr(cpuid, "Intel") != NULL)
>         TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
>     else
>         TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
> +#endif
> 
>     /*
>      * Source count returns the number of events aggregating in a leader

I confirmed the change above fixes the failure on Arm64.

Tested-by: Leo Yan <leo.yan@arm.com>
