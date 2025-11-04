Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA575284B2F;
	Tue,  4 Nov 2025 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227437; cv=none; b=dx8MpJuU9zZ0wyPjdWYiG80b8/4b2pYl5FsfXtPkuBUO3Ei4xkpI27iQKeWSMP4um4gvs2UpbPIhly0K8W9ndOFk3hmwGYVJp0TK1gnfPqSjXSnSAVP6Klf3hbgZOqBBib7W2Jf6MwgPVHEgNWumUVMTiQomR1cUq/ISJDlKujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227437; c=relaxed/simple;
	bh=39CO+XaUGpLosyhRtO2iIIpZNqpzsU53LeeeMJvVfVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGUOvKaOrAiZuuOViKwx6p7slh8zmVdDFhGQph9cVyFLNaGi6DwXHraHDH5/p+uY8PKe4IvXiV3b52p/yMjsGB4FO9DsDpAxFpE3eAIN8v0DNo2iMSR92fnVDeP+ist72cXUiIP9uH1hXSgTO893qUO9OxCH4xKN+sMZxXcWYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyl85co7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyl85co7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B98C116C6;
	Tue,  4 Nov 2025 03:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762227437;
	bh=39CO+XaUGpLosyhRtO2iIIpZNqpzsU53LeeeMJvVfVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyl85co7/zwbelUFvKkh8NMqjqVVLGr+cS32If16qaRWjmJ9hdmAxyCro7t8VQWyK
	 /xERrLOGG9hYTf3leFl/0HBYtUmPq+EDqOO4QzzIo5sbtq4IARL3HBqptiPrkNQyAB
	 R3nNkT+ZwpeZNVpfLbSl0kEOF2GMu7xogYkUfqFGYIdHh8dnBFDvkbdf+vG5l3I1Po
	 FVJSxKbiHtFyWTtspfNLwKIdGw87xaJl4fJ++TjPm6ft4dhg/cxrcYzJEyxJzzEmdS
	 P83U6koOfFfa/dRjrkkIlaSMV7VmCtQPUWyysCulkg+31mARm2oJg8iVWIZa6lKLGz
	 CgqKYJjz6edPA==
Date: Mon, 3 Nov 2025 19:37:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Add test that command line period
 overrides sysfs/json values
Message-ID: <aQl06yRnXvdBEkJ4@google.com>
References: <20251029222638.816100-1-irogers@google.com>
 <20251029222638.816100-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029222638.816100-2-irogers@google.com>

On Wed, Oct 29, 2025 at 03:26:38PM -0700, Ian Rogers wrote:
> The behavior of weak terms is subtle, add a test that they aren't
> accidentally broken.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record_weak_term.sh | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_weak_term.sh
> 
> diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/tests/shell/record_weak_term.sh
> new file mode 100755
> index 000000000000..7b747b383796
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_weak_term.sh
> @@ -0,0 +1,25 @@
> +#!/bin/bash
> +# record weak terms
> +# SPDX-License-Identifier: GPL-2.0
> +# Test that command line options override weak terms from sysfs or inbuilt json.
> +set -e
> +
> +shelldir=$(dirname "$0")
> +# shellcheck source=lib/setup_python.sh
> +. "${shelldir}"/lib/setup_python.sh
> +
> +
> +event=$(perf list --json | $PYTHON -c "import json,sys; next((print(e['EventName']) for e in json.load(sys.stdin) if e.get('Encoding') and 'period=' in e.get('Encoding')))")

This line is too long and needs some explanation like what's like the
original text and what it does.

Thanks,
Namhyung


> +if [[ "$?" != "0" ]]
> +then
> +  echo "No sysfs/json events with inbuilt period."
> +  exit 2
> +fi
> +
> +if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
> +  grep -q -F '{ sample_period, sample_freq }   1000'
> +then
> +  echo "Unexpected verbose output and sample period"
> +  exit 1
> +fi
> +exit 0
> -- 
> 2.51.1.851.g4ebd6896fd-goog
> 
