Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883AD53B;
	Sun, 16 Jun 2024 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718508750; cv=none; b=ZNU/m+6wesaqXU1dYi6zxYgQzY7UTCZpr8iGrJ2nDoukCmOlCKf67N9XidUu/cVu866m3tOY0B4ZubCfqG8ITBz41xzyiuLBBfG5M3XpZ+bEnod2ykgq/FrnoDBz+UT4YIrl0jMdo3LGNIfKK0vU8RNQeMhheOcGxT0D3v1C8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718508750; c=relaxed/simple;
	bh=h2Rupb3bRR++IkyJmTxLp/G1ivGk3oFy6DUp33fuDJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBkIHNXaSLF4cS7iL7hOdiyXdJHme41SAp5072X6888nh9YVouk0/s7cM5+MOXd4/nh8jAAKLv5zoxPPpbcaME+zQYhpXhVLo80CYh4fhKD9J05J89hFYRyWMiEsmZv5f0WZojyCWB7E9R3Sr/ImYVfmR0kkx7AZt5SbR6bq5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JruMbUdf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JruMbUdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1206FC3277B;
	Sun, 16 Jun 2024 03:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718508750;
	bh=h2Rupb3bRR++IkyJmTxLp/G1ivGk3oFy6DUp33fuDJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JruMbUdfJQ9hvfk7YNxEY/g13sfle3Smr9l3hDu7HgWQhCkuacKMoKnbczDvXyZMf
	 x7F+5cPGqSFbfvce/GvdNLgOBFWJ3OC/rQCrll2Bz0KBLNQ81wZGtlro5tAt7KAvMA
	 S+bnCwsoH2C2GhTOON4ecldJT0/rgf6uwkccwCzSk2vUfOefoi1ee7p3Pg7MmqmepR
	 orcGLddxVkCgcCaDEE9ydUVkF33gbLDFknxOG9GfiPCViVivCLjJDf67Y+WRdEX093
	 fQfxexOYcj2OQDaK36uzMeSwRh/qFCKg/II4E2KbgwndXxknOhwR9KinWI5M0/8AxY
	 VvIRZBHp0HApw==
Date: Sat, 15 Jun 2024 20:32:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v13 9/9] perf test: Add test for Intel TPEBS counting
 mode
Message-ID: <Zm5cydyXAuf71s71@google.com>
References: <20240613033631.199800-1-weilin.wang@intel.com>
 <20240613033631.199800-10-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613033631.199800-10-weilin.wang@intel.com>

Hello Weilin,

On Wed, Jun 12, 2024 at 11:36:29PM -0400, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Intel TPEBS sampling mode is supported through perf record. The counting mode
> code uses perf record to capture retire_latency value and use it in metric
> calculation. This test checks the counting mode code.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  .../perf/tests/shell/test_stat_intel_tpebs.sh  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> 
> diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> new file mode 100755
> index 000000000000..3c8763b39bd4
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> @@ -0,0 +1,18 @@
> +#!/bin/bash
> +# test Intel TPEBS counting mode
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set e
> +
> +# Use this event for testing because it should exist in all platforms
> +e=cache-misses:R
> +
> +# Without this cmd option, default value or zero is returned
> +echo "Testing without --enable-tpebs-recording"
> +result=$(perf stat -e "$e" true 2>&1)
> +[[ "$result" =~ "$e" ]] || exit 1
> +
> +# In platforms that do not support TPEBS, it should execute without error.
> +echo "Testing with --enable-tpebs-recording"
> +result=$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1)
> +[[ "$result" =~ "perf record" && "$result" =~ "$e" ]] || exit 1

This still gives me errors like:

  In tests/shell/test_stat_intel_tpebs.sh line 13:                                
  [[ "$result" =~ "$e" ]] || exit 1                                               
                  ^--^ SC2076 (warning): Remove quotes from right-hand side of =~ to match as a regex rather than literally.
                                                                                  
                                                                                  
  In tests/shell/test_stat_intel_tpebs.sh line 18:                                
  [[ "$result" =~ "perf record" && "$result" =~ "$e" ]] || exit 1                 
                                                ^--^ SC2076 (warning): Remove quotes from right-hand side of =~ to match as a regex rather than literally.
                                                                                  
  For more information:                                                           
    https://www.shellcheck.net/wiki/SC2076 -- Remove quotes from right-hand sid...
  make[4]: *** [tests/Build:90: tests/shell/test_stat_intel_tpebs.sh.shellcheck_log] Error 1
  make[4]: *** Waiting for unfinished jobs....

Please install shellcheck and check the build.

I'm not sure what's the correct fix but it seems the shellcheck
suggested to match '$' as a regex special character.  You may
disable the shellcheck if it's a false alarm.

Thanks,
Namhyung

