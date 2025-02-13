Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B469476
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417693; cv=none; b=rF2YVUJwh7zvPYDiOY3yLm9y7U2MoUMzliL6Zr6sI+gNQn1Z+jeNrSn+czPbrq6GSxBD2+Nd35AoJL0LjyKmOyA30/jSpDqy8K4BlCmMg28bU1qaZPKtfR8MOL0RKbjP5ADxDrkHFfBOrxHX6NHckgAjpwRVCgbDfgwVWsPEg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417693; c=relaxed/simple;
	bh=Aayi0JKLnbqq30nO8hz+ejLA0s7Jkjsteezm9FkASsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLDC5nKR5+Mt0lT8ppPwl9FYIq9qXRzqIfKV5rUCeLus5uO1jDiKThUTVN59bOnBN6gnyTo4enFXAUjfcaRtV1tAfRI4Z5q9PHZV6VC2dYNzS0CVvpiPNRH6rF67MsDxoKexAVPeafOdI9sGZmFdP9jjtY1cRNkCgvDpOk+m0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmCF82ki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmCF82ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747BCC4CED1;
	Thu, 13 Feb 2025 03:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739417692;
	bh=Aayi0JKLnbqq30nO8hz+ejLA0s7Jkjsteezm9FkASsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmCF82kiyDAJQCZ9hvSmbNxWvZRbCrrpBXeE/VuA92anLO11mNC5jODnvsJaVG4gA
	 6gJzRE8U71jBhB77BdpVX3TdUtkoPSInt2PeFYFgcYiV/4ybvUbLLXdB+ou3vFqlew
	 7uzDaN5bGWmHJN1z+S8ZIEF3UxDHVLRZW7lNBfLZbCrPvV1S0AxZYDdW/8uooGcg6X
	 T13+ro4QG5rkJSw89UTc4+DxIKF0nAOCY6NGomy4lG8bsiJuVolHnoimhgKJCtTi/n
	 a9K2DLbR0EqGuVJafVURS/1m+Pv4n8CY+Vg9GkfULrXsHz6uA87RaOq7JdGQtYsSX5
	 SgCQ3Mu77+c8w==
Date: Wed, 12 Feb 2025 19:34:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com
Subject: Re: [PATCH] tools/perf: Add check to tool pmu tests to ensure if the
 event is valid
Message-ID: <Z61oWlOoyF0BKwYV@google.com>
References: <20250212185438.15251-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212185438.15251-1-atrajeev@linux.vnet.ibm.com>

On Thu, Feb 13, 2025 at 12:24:38AM +0530, Athira Rajeev wrote:
> "Tool PMU" tests fails on powerpc as below:
> 
>    12.1: Parsing without PMU name:
>    --- start ---
>    test child forked, pid 48492
>    Using CPUID 0x00800200
>    Attempt to add: tool/duration_time/
>    ..after resolving event: tool/config=0x1/
>    duration_time -> tool/duration_time/
>    Attempt to add: tool/user_time/
>    ..after resolving event: tool/config=0x2/
>    user_time -> tool/user_time/
>    Attempt to add: tool/system_time/
>    ..after resolving event: tool/config=0x3/
>    system_time -> tool/system_time/
>    Attempt to add: tool/has_pmem/
>    ..after resolving event: tool/config=0x4/
>    has_pmem -> tool/has_pmem/
>    Attempt to add: tool/num_cores/
>    ..after resolving event: tool/config=0x5/
>    num_cores -> tool/num_cores/
>    Attempt to add: tool/num_cpus/
>    ..after resolving event: tool/config=0x6/
>    num_cpus -> tool/num_cpus/
>    Attempt to add: tool/num_cpus_online/
>    ..after resolving event: tool/config=0x7/
>    num_cpus_online -> tool/num_cpus_online/
>    Attempt to add: tool/num_dies/
>    ..after resolving event: tool/config=0x8/
>    num_dies -> tool/num_dies/
>    Attempt to add: tool/num_packages/
>    ..after resolving event: tool/config=0x9/
>    num_packages -> tool/num_packages/
> 
>    ---- unexpected signal (11) ----
>    12.1: Parsing without PMU name                                      : FAILED!
> 
> Same fail is observed for "Parsing with PMU name" as well.
> 
> The testcase loops through events in tool_pmu__for_each_event()
> and access event name using "tool_pmu__event_to_str()".
> Here tool_pmu__event_to_str returns null for "slots" event
> and "system_tsc_freq" event. These two events are only applicable
> for arm64 and x86 respectively. So the function tool_pmu__event_to_str()
> skips for unsupported events and returns null. This null value is
> causing testcase fail.
> 
> To address this in "Tool PMU" testcase, add a helper function
> tool_pmu__all_event_to_str() which returns the name for all
> events mapping to the tool_pmu_event index including the
> skipped ones. So that even if its a skipped event, the
> helper function helps to resolve the tool_pmu_event index to
> its mapping event name. Update the testcase to check for null event
> names before proceeding the test.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Please take a look at:
https://lore.kernel.org/r/20250212163859.1489916-1-james.clark@linaro.org

Thanks,
Namhyung

> ---
>  tools/perf/tests/tool_pmu.c | 12 ++++++++++++
>  tools/perf/util/tool_pmu.c  | 17 +++++++++++++++++
>  tools/perf/util/tool_pmu.h  |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> index 187942b749b7..e468e5fb3c73 100644
> --- a/tools/perf/tests/tool_pmu.c
> +++ b/tools/perf/tests/tool_pmu.c
> @@ -19,6 +19,18 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
>  		return TEST_FAIL;
>  	}
>  
> +	/*
> +	 * if tool_pmu__event_to_str returns NULL, Check if the event is
> +	 * valid for the platform.
> +	 * Example:
> +	 * slots event is only on arm64.
> +	 * system_tsc_freq event is only on x86.
> +	 */
> +	if (!tool_pmu__event_to_str(ev) && tool_pmu__skip_event(tool_pmu__all_event_to_str(ev))) {
> +		ret = TEST_OK;
> +		goto out;
> +	}
> +
>  	if (with_pmu)
>  		snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
>  	else
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index 3a68debe7143..572422797f6e 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
> @@ -60,6 +60,15 @@ int tool_pmu__num_skip_events(void)
>  	return num;
>  }
>  
> +/*
> + * tool_pmu__event_to_str returns only supported event names.
> + * For events which are supposed to be skipped in the platform,
> + * return NULL
> + *
> + * tool_pmu__all_event_to_str returns the name for all
> + * events mapping to the tool_pmu_event index including the
> + * skipped ones.
> + */
>  const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
>  {
>  	if ((ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX) &&
> @@ -69,6 +78,14 @@ const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
>  	return NULL;
>  }
>  
> +const char *tool_pmu__all_event_to_str(enum tool_pmu_event ev)
> +{
> +	if (ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX)
> +		return tool_pmu__event_names[ev];
> +
> +	return NULL;
> +}
> +
>  enum tool_pmu_event tool_pmu__str_to_event(const char *str)
>  {
>  	int i;
> diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
> index a60184859080..da76808ae71e 100644
> --- a/tools/perf/util/tool_pmu.h
> +++ b/tools/perf/util/tool_pmu.h
> @@ -30,6 +30,7 @@ enum tool_pmu_event {
>  	for ((ev) = TOOL_PMU__EVENT_DURATION_TIME; (ev) < TOOL_PMU__EVENT_MAX; ev++)
>  
>  const char *tool_pmu__event_to_str(enum tool_pmu_event ev);
> +const char *tool_pmu__all_event_to_str(enum tool_pmu_event ev);
>  enum tool_pmu_event tool_pmu__str_to_event(const char *str);
>  bool tool_pmu__skip_event(const char *name);
>  int tool_pmu__num_skip_events(void);
> -- 
> 2.43.5
> 
