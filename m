Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA237191F9C;
	Wed,  4 Dec 2024 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350869; cv=none; b=isWJs2Ic6aNtCXI6thIRvUkEMfI2UnmFyzR8lvLnMCv4gHS2l/GgFKkx/PtbhUvsoWPLSjJya2k3nyNREUUMYEmsYR6+gWKkcE5gpiijGErlrgN3zxIccMoE18yR7LSY3qoA0XSZY5l/GcyVx2H+rVZhOD3DcmJvRYX6j6gU7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350869; c=relaxed/simple;
	bh=7Kjwv6X8sBlPbnZSg35bGxloNhQZkO7cxpO2/leNb70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7H0jz/+B0UWVKP/dPZ4aLDyHcfax120+Tp2wtf9sQCb/cVqRoziD5RwIkeqANvs6DkY0oBm3fXXZj+JSKNllaOqZjIl440BnW0uuEOeYJCaOPmc6YWeJs3q8bKRhKEbtOdUNLnVTd+ZbqZJlWfQ7B5VzE3QoCnWF7IRYNTnV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG6WqY8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG6WqY8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35233C4CECD;
	Wed,  4 Dec 2024 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733350868;
	bh=7Kjwv6X8sBlPbnZSg35bGxloNhQZkO7cxpO2/leNb70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NG6WqY8nt8BOlMu3is3Z8/126MyljUh+G25WjO47mr3cx7/Kw2Wb/UYef8zXXW44A
	 eW3g3J9aTPwlz0VVfL1QAqjP12xCjK27qlN8Xxidn5TRERb5AQM9FJDOP2KUOJsXlF
	 mpEMerhgCI0dOgPWDyl7X0mIgUaonr/DWOlxMQvv3GgiYQOtgH01PAAi2buk46tMw3
	 9JANmaCDcfJ1vF1DCwBNQvjcx191In0hzmMasmqzqJx4OVoN1LpFrJVxwESv6xn27R
	 1IrKBivisRl/XfCWinYnu5Ld3DYgaGANn9mljubBh/ref+1sRfqf68QzMfp/J9wr31
	 pVRzP3kA8idiw==
Date: Wed, 4 Dec 2024 14:21:06 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Mingwei Zhang <mizhang@google.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [linus:master] [perf tools]  af954f76ee:
 perf-sanity-tests.Test_data_symbol.fail
Message-ID: <Z1DV0lN8qHSysX7f@google.com>
References: <202411301431.799e5531-lkp@intel.com>
 <Z04ZUHaGdsBapIEL@google.com>
 <Z1BhfpYWpUQ0p+qR@xsang-OptiPlex-9020>
 <Z1DNJpDzCIBFrIZT@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1DNJpDzCIBFrIZT@google.com>

On Wed, Dec 04, 2024 at 01:44:06PM -0800, Namhyung Kim wrote:
[SNIP]
>   perf_event_attr:
>     type                             4 (cpu)
>     size                             136
>     config                           0x1cd (mem-loads)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|ADDR|CPU|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT
>     read_format                      ID|LOST
>     freq                             1
>     precise_ip                       3
>     sample_id_all                    1
>     { bp_addr, config1 }             0x1f
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
>   sys_perf_event_open failed, error -22
>   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu/mem-loads,ldlat=30/).
>   "dmesg | grep -i perf" may provide additional information.
> 
> There's an issue with fallback on the inherit bit with the sample read.
> I'll take a look.

Hmm, no.  It doesn't have neight SAMPLE_READ nor inherit.  So the error
message was misleading.  Maybe it should be printed when it actually
clears the bits.

Anyway, I've tested with the old code and realzed that it might be due
to precise_ip being 3.  I expected it'd return EOPNOTSUPP for the case
but it seems to return EINVAL sometimes.  Then it should check it after
the missing features like below.  Can you please test?

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f745723d486ba962..d22c5df1701eccc5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2571,12 +2571,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
 		goto retry_open;
 
-	if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
-		goto retry_open;
-
 	if (err == -EINVAL && evsel__detect_missing_features(evsel))
 		goto fallback_missing_features;
 
+	if (evsel__precise_ip_fallback(evsel))
+		goto retry_open;
+
 	if (evsel__handle_error_quirks(evsel, err))
 		goto retry_open;
 
