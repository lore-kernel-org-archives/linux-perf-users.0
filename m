Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132EC247291;
	Wed,  4 Mar 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634205; cv=none; b=EQ7PODK3e5HkCnHk7AB+AMx7WzR74EVP9iUm7hAGSVqhLT4Oe4KAEeNbmMDeJobeUELzBSBYXLeeUKJMuChNi9PE/mJpx/jZN8kC6ex+eGIbyMbiTwP0cNncf+sAgkIWGSvLubcQDhpucuzGg0UhsKsIWAx4SxxzIpW/D0BDwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634205; c=relaxed/simple;
	bh=4z4cyPCe84oADZ2tElUeb+CeV+cpjWGzN6wBvzmg2O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgE6VssaqIiuoDyAmtHnHdKru30vBMVQaJza7GMHSRne1uR0/utevecTtiRRUbJnjaFPpHYPM+8GUJPA5xui8QHw+A5Qg8sAwUcCVjWZvPCFJGIPc6WoanhNaeQqANCy/E7OxLhbKnQqtsYEY2870b/Rb0lebIvt8gbLSeaZufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0p5NJR3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0p5NJR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DC5C19423;
	Wed,  4 Mar 2026 14:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634204;
	bh=4z4cyPCe84oADZ2tElUeb+CeV+cpjWGzN6wBvzmg2O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0p5NJR3Z1cjanX6DxwFtdvClgjyRMapACrlubEQy7CGXwwOJPM1GcO7udGxlHFVI
	 raKVTx/OvIbPWI4McD23qjYzmUyLi+yUGpDH/V/cp2ilYst+nFUJHTbSi9iRSdUEBu
	 xjcZl9j34Zzpl8+m/c4K0t6BUMfd2sMdmGzqjmJBtnhOT692FxqTpAfX47lGonUA3Q
	 TxekYpuBHwEZDWCLLCiDBJ9aObX9IO3aQgZQ+upu4PmMfZxIAQVhJnA8n9zV8kHkFz
	 cUeaAIzT0tsANGb0F6coblg3Y973iWcjO+tiE20TjAqY2RhujX9GLbPku/p/29GuNO
	 vjlwev0Ji+UdA==
Date: Wed, 4 Mar 2026 11:23:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Markus Mayer <mmayer@broadcom.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Perf Mailing List <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf build: prevent "argument list too long" error
Message-ID: <aahAWdOciPcOvL-N@x1>
References: <20260303211503.165337-1-mmayer@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303211503.165337-1-mmayer@broadcom.com>

On Tue, Mar 03, 2026 at 01:15:01PM -0800, Markus Mayer wrote:
> Due to a recent change, building perf may result in a build error when
> it is trying to "prune orphans". The file list passed to "rm" may exceed
> what the shell can handle. The build will then abort with an error like
> this:
> 
>   TEST    [...]/arm64/build/linux-custom/tools/perf/pmu-events/metric_test.log
> make[5]: /bin/sh: Argument list too long
> make[5]: *** [pmu-events/Build:217: prune_orphans] Error 127
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [Makefile.perf:773: [...]/tools/perf/pmu-events/pmu-events-in.o] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [Makefile.perf:289: sub-make] Error 2
> 
> Processing the arguments via "xargs", instead of passing the list of
> files directly to "rm" via the shell, prevents this issue.
> 
> Fixes: 36a1b0061a5 (perf build: Reduce pmu-events related copying and mkdirs)
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Thanks, applied to perf-tools, for v7.0.

- Arnaldo

> ---
>  tools/perf/pmu-events/Build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 63c65788d442..dc5f94862a3b 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -214,7 +214,8 @@ ifneq ($(strip $(ORPHAN_FILES)),)
>  quiet_cmd_rm  = RM      $^
>  
>  prune_orphans: $(ORPHAN_FILES)
> -	$(Q)$(call echo-cmd,rm)rm -f $^
> +	# The list of files can be long. Use xargs to prevent issues.
> +	$(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
>  
>  JEVENTS_DEPS += prune_orphans
>  endif
> -- 
> 2.52.0
