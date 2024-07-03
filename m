Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115A1C68D;
	Wed,  3 Jul 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049919; cv=none; b=ccIxVp54lV9GK4f5YyAUaHstyVItEYkQtXDswTwlFZFs90XIs8dh49ZsBHaxP6C3pnVFJGfaAqHL/jrTVKl0Odx9MfiAhkPkIik6lgP37YBeObfhyD3xjYEQ03sS7cSoTQqv5rEc6zq4fszdB5XwyxGRwOwcZTtVa/zXHkjlW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049919; c=relaxed/simple;
	bh=DQANRoZlWcBn5MSR4esKceMThOyrEVTNXCDaUV26OdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxXibBCMsC3z6Sq/iyM9xCO3oAofH3dyg89MHTCMb5RtA2ScMJOzbWJ3dM9SuSTTcO9EhshVaMbTe4c1LOCvADiRhHKiUm4RM0zfrA6FtQYH9zEq0WIZdf60DqHoHb20bsjCZU+wOjls10LEGscotW/2jCF3ljDAIUq/fK22jqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV/Vs/WO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV/Vs/WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF577C2BD10;
	Wed,  3 Jul 2024 23:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720049919;
	bh=DQANRoZlWcBn5MSR4esKceMThOyrEVTNXCDaUV26OdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pV/Vs/WOTGsgBuJaNkcF1i2kPFuB0wmAWOm9nirn1/qI/bQLpdHP6kLu+PNBD3VnO
	 Lvnmo3GIkDyDFrF53NF2XAZ5ORAhrSRX5hSFW0zB/YajPMnKw+2uzeJd3Mj8oDnG3I
	 zonRgFVWi5VtVNdbfj4ccxMHR0/omvAEgWFdmoRem7VKMGbPlFW/zFeWX+UZx2WE3f
	 vhSfmKyfpXEg4bG16+H5e5O6jk4FEtM2AZsvgsdBQHiyvoAlTf9j2RSs4Uj+5I22MP
	 TJDFx4W095t8a92CnGyH3jns9mLuueZeNpWLIB5IQxltNM7/gIKr3gUIS79GXorwNj
	 7tq/WcKHaQCIg==
Date: Wed, 3 Jul 2024 16:38:37 -0700
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
Subject: Re: [RFC PATCH v15 8/8] perf test: Add test for Intel TPEBS counting
 mode
Message-ID: <ZoXg_fk7HRZn89ij@google.com>
References: <20240702220757.262825-1-weilin.wang@intel.com>
 <20240702220757.262825-9-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702220757.262825-9-weilin.wang@intel.com>

Hello,

On Tue, Jul 02, 2024 at 06:07:55PM -0400, weilin.wang@intel.com wrote:
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
> index 000000000000..220b830eac61
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> @@ -0,0 +1,18 @@
> +#!/bin/bash
> +# test Intel TPEBS counting mode
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set e

Probably you want 'set -e'.

> +
> +# Use this event for testing because it should exist in all platforms
> +e=cache-misses:R

Please rename it to 'event'.

> +
> +# Without this cmd option, default value or zero is returned
> +echo "Testing without --enable-tpebs-recording"

I think you need to update the option name.


> +result=$(perf stat -e "$e" true 2>&1)
> +[[ "$result" =~ $e ]] || exit 1
> +
> +# In platforms that do not support TPEBS, it should execute without error.
> +echo "Testing with --enable-tpebs-recording"
> +result=$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>&1)

Ditto.

Thanks,
Namhyung


> +[[ "$result" =~ "perf record" && "$result" =~ $e ]] || exit 1
> -- 
> 2.43.0
> 
