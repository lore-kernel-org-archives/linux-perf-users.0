Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B119CCF5;
	Wed, 26 Nov 2025 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141602; cv=none; b=mYi37H2SXCxNUwbRcyH+p7ChLdKox1ZcPP7S5P3pHy2x+9m1eTrLqQ4JT5PngIQZQhw9OEGxcJvSZqHs7l04n2+xHZyl/xhT/95qWxk/x53ixB//m3eC9IJdzaqaq8rHRg+Mf4A5rkUvglyzlbVk1XALWPRltjL5ERiSDWNqQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141602; c=relaxed/simple;
	bh=+xqDmyWS2yizyUsQHqqBC/HQaxjRA3/nR9ClxKarT80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bowwABTSnMhOyoo0WJgoxfdZtErmUEYgReYwDCKEy7BVecnWT3FHblCDkIabPqieM6Jh2fVqfLbg4+oOpBJpzica+iQ2x5/F1e248Su1r+GzL/ug78/yPHCmhbWgChl74dGv93a9erPGHYHfYsu8J1W2j5QpeFqCo3fsaQcGlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYgI2bv5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYgI2bv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42B2C16AAE;
	Wed, 26 Nov 2025 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764141601;
	bh=+xqDmyWS2yizyUsQHqqBC/HQaxjRA3/nR9ClxKarT80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYgI2bv5hvUWUsSO/c/e7/bELcg5kyjchoKjbsVcazJx1YB/mY+xAZrQhLPitlb/J
	 ISqZs82YtiOIv/gDk9BESSHoqrm/BocI9Vx9i6oW/BM1S8H0NhUs0UxWixI82Fkp4G
	 Rtk1tQ+lKcP1USMc/3mwD4I5iMpnkHauKfDCrXCHmBWgJgjH55fOCYOVL48wlOTv5h
	 y+HW5sbv4pkWKssBvf2/cO+oCbpy5TGRBBWUGA1xoy91IppfWdg75aHxqtMpKfA8Cg
	 P6EsS5ZVqizJm2yEqLYnelEw5rQ1XyRE/c3TRYj595yOfwwmLawitB5vI1KkIVNpbD
	 07QNn8qlTxtkQ==
Date: Tue, 25 Nov 2025 23:19:59 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 16/17] perf tests evlist: Add basic evlist test
Message-ID: <aSaqH8xF7zcjq2Nc@google.com>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-17-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:28AM -0800, Ian Rogers wrote:
> Add test that evlist reports expected events from perf record.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/evlist.sh | 79 ++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100755 tools/perf/tests/shell/evlist.sh
> 
> diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/evlist.sh
> new file mode 100755
> index 000000000000..140f099e75c1
> --- /dev/null
> +++ b/tools/perf/tests/shell/evlist.sh
> @@ -0,0 +1,79 @@
> +#!/bin/bash
> +# perf evlist tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +	rm -f "${perfdata}"
> +	trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +	echo "Unexpected signal in ${FUNCNAME[1]}"
> +	cleanup
> +	exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +test_evlist_simple() {
> +	echo "Simple evlist test"
> +	if ! perf record -e cycles -o "${perfdata}" true 2> /dev/null

I think we need to use a software event to make sure it can run on any
platforms.

Thanks,
Namhyung


> +	then
> +		echo "Simple evlist [Failed record]"
> +		err=1
> +		return
> +	fi
> +	if ! perf evlist -i "${perfdata}" | grep -q "cycles"
> +	then
> +		echo "Simple evlist [Failed to list event]"
> +		err=1
> +		return
> +	fi
> +	echo "Simple evlist test [Success]"
> +}
> +
> +test_evlist_group() {
> +	echo "Group evlist test"
> +	if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true 2> /dev/null
> +	then
> +		echo "Group evlist [Skipped event group recording failed]"
> +		return
> +	fi
> +
> +	if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*instructions.*}"
> +	then
> +		echo "Group evlist [Failed to list event group]"
> +		err=1
> +		return
> +	fi
> +	echo "Group evlist test [Success]"
> +}
> +
> +test_evlist_verbose() {
> +	echo "Event configuration evlist test"
> +	if ! perf record -e cycles -o "${perfdata}" true 2> /dev/null
> +	then
> +		echo "Event configuration evlist [Failed record]"
> +		err=1
> +		return
> +	fi
> +
> +	if ! perf evlist -i "${perfdata}" -v | grep -q "config:"
> +	then
> +		echo "Event configuration evlist [Failed to list verbose info]"
> +		err=1
> +		return
> +	fi
> +	echo "Event configuration evlist test [Success]"
> +}
> +
> +test_evlist_simple
> +test_evlist_group
> +test_evlist_verbose
> +
> +cleanup
> +exit $err
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 
