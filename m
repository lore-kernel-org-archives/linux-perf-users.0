Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136861917FF;
	Fri, 13 Dec 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119725; cv=none; b=J2qWkZ1XrLrd/sowlTGWuEXl+3pQzkqtZenO32UXBWNRI3TvR7D2VHKHj9qkCvEqxIPYmIOwdEawqHq7LgNPWFiV75acWzClE+hrs9nkUk6kH2RKJf+vO8xKYUpHeQvTnNwW72WdLDSbVyXd5K5LVx8wYifoLlVLcw/70DQPcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119725; c=relaxed/simple;
	bh=O1BrkSmk15lfmBVgBcoXh74LUiTwTfwBVZuenj4XM74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3XAGAwUCJCccnG1YzlMHNKqpqYKdI9yB3um8z3tYAFMLX3gVwfLpQOO4jcdl74wM7X6fLOIV0YJ9IUB1v6EDYJwxKiyPCJEwoOl2RyiyH7NPi693DVOkXyKTOiPD3/xu2EejgF4DOr4ieKX9D5cH2hdkYniSaAsBl3McgK4erw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaHdHK6B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaHdHK6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C9CC4CED0;
	Fri, 13 Dec 2024 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119724;
	bh=O1BrkSmk15lfmBVgBcoXh74LUiTwTfwBVZuenj4XM74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaHdHK6B1DCufyEl2iAShSF/v/+Cyp43l+adxbybOUhwGP2w8GIEyB7hftWtvKql6
	 Ej7FF3WagXVQ/jU6aM5FTlQUbcxB31DdevD6Cx2LOgaKOMAhmEZdvE3eOB47COLWPM
	 K5LcQnafS5kxGIyQJspmn0DjCDc2fTlx+T7E6WC0En07f7w8662QJ3vldTbZnVMrTB
	 a7JKyYhH4weUN+63W3n627gcIDF2iQLhBOvuYe6PSPxBbTME8w+eAjvitOnDuH4pfL
	 0pbVa0+V+BiQHDl+JxHawyovAewiEsJ9LDjyblKeQNAHiQm6medkNE/TtMu4M++JcG
	 LiYLPC/vfI0JQ==
Date: Fri, 13 Dec 2024 16:55:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v3 09/10] perf test: Introduce DEFINE_SUITE_EXCLUSIVE()
Message-ID: <Z1yRKdo3JpQ9KPe-@x1>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
 <20241210093449.1662-10-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093449.1662-10-ravi.bangoria@amd.com>

On Tue, Dec 10, 2024 at 09:34:48AM +0000, Ravi Bangoria wrote:
> A variant of DEFINE_SUITE() but sets ->exclusive bit for the test so the
> test will be executed sequentially.

Cherry picking this one as I need it for some other work.

Ian Rogers pointed me while reviewing.

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/tests/tests.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index cb58b43aa063..8aea344536b8 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -81,6 +81,16 @@ struct test_suite {
>  		.test_cases = tests__##_name,		\
>  	}
>  
> +#define DEFINE_SUITE_EXCLUSIVE(description, _name)	\
> +	struct test_case tests__##_name[] = {           \
> +		TEST_CASE_EXCLUSIVE(description, _name),\
> +		{	.name = NULL, }			\
> +	};						\
> +	struct test_suite suite__##_name = {		\
> +		.desc = description,			\
> +		.test_cases = tests__##_name,		\
> +	}
> +
>  /* Tests */
>  DECLARE_SUITE(vmlinux_matches_kallsyms);
>  DECLARE_SUITE(openat_syscall_event);
> -- 
> 2.43.0
