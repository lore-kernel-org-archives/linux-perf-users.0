Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11154BFE;
	Sat, 11 May 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443609; cv=none; b=HBre84QBSsEZyYSbxV4fNH622aKM9t7ZH/xMPD+hoTI424XVHQphOWASF497pvKIZLoPNNmhhKevxa6JmgFJB11M+p8VRZb9lQPIYLVXOzrgUUlr7cqvUd3MbFX1dcAksWmTc27fcLshXL322Ial8NrSjc/ffpfWnj8HvqDGRWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443609; c=relaxed/simple;
	bh=TDN0gBCpCl5l12uhlNFfdynTxX1nZiCCsDe3asGgAEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsmlagNdCfuZDWZMW1cJSGapej16ZSFalnAsAXlh9hc1Tp8gwmplrRQtcNeiKTBOel4EdUZdqK1OCr0wNfT/0zZ6s8F7yb8GZp1hpL0sK5E+lRk2vgYe0QPPNB+2v2Tej7L1C4wy7t87u7l3lCqNN9puNA3vRXggaJjKvoyTbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAvKm+n2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAvKm+n2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB18CC2BBFC;
	Sat, 11 May 2024 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715443609;
	bh=TDN0gBCpCl5l12uhlNFfdynTxX1nZiCCsDe3asGgAEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAvKm+n2URP351N9lqaqGfa0fExPFxy1kp5KSrSm9xlqvIJ52AN5G1BP1Dp0RbBDp
	 003U5em2FnqKWjZPWdOoE0j3esJS4eLvvxCs0nb8VYVeWc8oYMtGRTSV8JM4NwzH5s
	 vrOqeAGQOhBxbCuwfLgnWIHHKInG6a4h7y2xeCKIJbVQfVgjVhHeZLN9l2DCQfuoID
	 n982JW6OOtTbeM35F+7Qgj7yIKhvP6Z/6EQgVFDIeXQnGic9AKgIgvd4Fz2VUmqtwg
	 jMl7rro0fXJj+jrDPnFbzRt5CaKWq3etgZ/lJidU61f7yYkGXe974DKlrtGL8SePvb
	 egPYafHdZBNaw==
Date: Sat, 11 May 2024 13:06:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Bhaskara Budiredla <bbudiredla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/2] perf pmus: Sort/merge/aggregate PMUs like
 mrvl_ddr_pmu
Message-ID: <Zj-Xlj-hIRAv_EZL@x1>
References: <20240505031624.299361-1-irogers@google.com>
 <20240505031624.299361-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240505031624.299361-2-irogers@google.com>

On Sat, May 04, 2024 at 08:16:23PM -0700, Ian Rogers wrote:
> The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
> the previous PMU sorting/merging code assumes uncore PMU names start
> with uncore_ and have a decimal suffix. Because of the previous
> assumption it isn't possible to wildcard the mrvl_ddr_pmu.
> 
> Modify pmu_name_len_no_suffix but also remove the suffix number out
> argument, this is because we don't know if a suffix number of say 10
> is in hexadecimal or decimal. As the only use of the suffix number is
> in comparisons, it is safe there to compare the values as hexadecimal.

Removed these patches due to:
 
util/pmus.c: In function ‘pmu_name_cmp’:
util/pmus.c:67:19: error: ‘strncmp’ specified bound [18446744071562067968, 18446744073709551615] exceeds maximum object size 9223372036854775807 [-Werror=stringop-overread]
   67 |         int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   68 |                         lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/tmp/perf-6.9.0-rc5/tools/build/Makefile.build:105: util/pmus.o] Error 1

Noticed while doing a 'make -C tools/perf build-test', the tarbz test.

acme@x1:~/git/perf-tools-next$ head /etc/os-release 
NAME="Fedora Linux"
VERSION="39 (Workstation Edition)"
ID=fedora
VERSION_ID=39
VERSION_CODENAME=""
PLATFORM_ID="platform:f39"
PRETTY_NAME="Fedora Linux 39 (Workstation Edition)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:39"
acme@x1:~/git/perf-tools-next$

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c  |  4 ++--
>  tools/perf/util/pmus.c | 53 ++++++++++++++++++++++--------------------
>  tools/perf/util/pmus.h |  7 +++++-
>  3 files changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index b3b072feef02..32e5a73273d7 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1761,7 +1761,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
>  {
>  	struct parse_events_term *term;
>  	int pmu_name_len = skip_duplicate_pmus
> -		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
> +		? pmu_name_len_no_suffix(pmu->name)
>  		: (int)strlen(pmu->name);
>  	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
>  
> @@ -1805,7 +1805,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
>  
>  		info.pmu_name = event->pmu_name ?: pmu->name;
>  		pmu_name_len = skip_duplicate_pmus
> -			? pmu_name_len_no_suffix(info.pmu_name, /*num=*/NULL)
> +			? pmu_name_len_no_suffix(info.pmu_name)
>  			: (int)strlen(info.pmu_name);
>  		info.alias = NULL;
>  		if (event->desc) {
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index b9b4c5eb5002..28cfa7adbfd7 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -40,31 +40,44 @@ static bool read_sysfs_all_pmus;
>  
>  static void pmu_read_sysfs(bool core_only);
>  
> -int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> +int pmu_name_len_no_suffix(const char *str)
>  {
>  	int orig_len, len;
>  
>  	orig_len = len = strlen(str);
>  
> -	/* Non-uncore PMUs have their full length, for example, i915. */
> -	if (!strstarts(str, "uncore_"))
> -		return len;
> -
>  	/*
>  	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
>  	 * the full length.
>  	 */
> -	while (len > 0 && isdigit(str[len - 1]))
> +	while (len > 0 && isxdigit(str[len - 1]))
>  		len--;
>  
> -	if (len > 0 && len != orig_len && str[len - 1] == '_') {
> -		if (num)
> -			*num = strtoul(&str[len], NULL, 10);
> +	if (len > 0 && len != orig_len && str[len - 1] == '_')
>  		return len - 1;
> -	}
> +
>  	return orig_len;
>  }
>  
> +int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
> +{
> +	unsigned long lhs_num = 0, rhs_num = 0;
> +	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name);
> +	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name);
> +	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
> +			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
> +
> +	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
> +		return ret;
> +
> +	if (lhs_pmu_name_len + 1 < (int)strlen(lhs_pmu_name))
> +		lhs_num = strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], NULL, 16);
> +	if (rhs_pmu_name_len + 1 < (int)strlen(rhs_pmu_name))
> +		rhs_num = strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], NULL, 16);
> +
> +	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +}
> +
>  void perf_pmus__destroy(void)
>  {
>  	struct perf_pmu *pmu, *tmp;
> @@ -167,20 +180,10 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
>  static int pmus_cmp(void *priv __maybe_unused,
>  		    const struct list_head *lhs, const struct list_head *rhs)
>  {
> -	unsigned long lhs_num = 0, rhs_num = 0;
>  	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
>  	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
> -	const char *lhs_pmu_name = lhs_pmu->name ?: "";
> -	const char *rhs_pmu_name = rhs_pmu->name ?: "";
> -	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
> -	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
> -	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
> -			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
>  
> -	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
> -		return ret;
> -
> -	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +	return pmu_name_cmp(lhs_pmu->name ?: "", rhs_pmu->name ?: "");
>  }
>  
>  /* Add all pmus in sysfs to pmu list: */
> @@ -300,11 +303,11 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>  		pmu_read_sysfs(/*core_only=*/false);
>  		pmu = list_prepare_entry(pmu, &core_pmus, list);
>  	} else
> -		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", NULL);
> +		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
>  
>  	if (use_core_pmus) {
>  		list_for_each_entry_continue(pmu, &core_pmus, list) {
> -			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
> +			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
>  
>  			if (last_pmu_name_len == pmu_name_len &&
>  			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
> @@ -316,7 +319,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>  		pmu = list_prepare_entry(pmu, &other_pmus, list);
>  	}
>  	list_for_each_entry_continue(pmu, &other_pmus, list) {
> -		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
> +		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
>  
>  		if (last_pmu_name_len == pmu_name_len &&
>  		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
> @@ -566,7 +569,7 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
>  			.long_string = STRBUF_INIT,
>  			.num_formats = 0,
>  		};
> -		int len = pmu_name_len_no_suffix(pmu->name, /*num=*/NULL);
> +		int len = pmu_name_len_no_suffix(pmu->name);
>  		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
>  
>  		if (!pmu->is_core)
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 9d4ded80b8e9..69d64fbd4259 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -2,10 +2,15 @@
>  #ifndef __PMUS_H
>  #define __PMUS_H
>  
> +#include <stdbool.h>
> +#include <linux/list.h>
> +
>  struct perf_pmu;
>  struct print_callbacks;
>  
> -int pmu_name_len_no_suffix(const char *str, unsigned long *num);
> +int pmu_name_len_no_suffix(const char *str);
> +/* Exposed for testing only. */
> +int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
>  
>  void perf_pmus__destroy(void);
>  
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
