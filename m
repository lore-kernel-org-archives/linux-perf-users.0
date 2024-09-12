Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC091BFE0F;
	Thu, 12 Sep 2024 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168996; cv=none; b=a7V0o+OjxhXIWDgY6w2ezWjtYk9D49jCXm3IXj7WPS9JBK5j5zjEBbnsTtLS2YkUCI6ZmK3lt9Bhpu9Y4EqdKdSQUApzx0BjqN3nNEFVQtFA20i3QR9EitnpFUQU+HWjDhdlTmRzZgjPtP9NzRFZ5YEXdl8n+BtB1xhDCgZ7YaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168996; c=relaxed/simple;
	bh=2H2D1UKN3ueeo9obCoL9xvBF5quxcPzdVyyieDRhrjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2heOQMa4yhEUpNdkbdHf+VYJaXLXhm1aLlwLVnuRmiObeBdBoy4+1ibumX9/YVS1HEX48u9uwe2iwmkB5ZAWjKccrLnj+14/Ym/G6b4mhiGQUPDXS2bqnbopb1NWY7TgQs57jOGH/n5i7Vw5lbIqf2AN4lJtKcFcYgRxa1RhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buaQyJw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buaQyJw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D43C4CEC5;
	Thu, 12 Sep 2024 19:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726168996;
	bh=2H2D1UKN3ueeo9obCoL9xvBF5quxcPzdVyyieDRhrjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=buaQyJw5NfVVPPRjX7zrO8uUO44LLB5E9Dr8GlBWf5QTbEwubouXz0Q71WxdqVlcP
	 coJbud3OSPQvakRZEzM/WSgv36cOcXzSibVDT+dOL/5e/oj1IIVma61k1o5Evpas0c
	 BdZJ63XU+kywBckaOASlglGrBo7zj8531ear4dYgBx9i9yq9Az/kyc1BMwpGA8RvAl
	 iTaDnnSdBiOw/wUVN+FEiXb+Arlmdnf+/MDQLxyP2A9F/riUEyeY1gtJAZqiabz2ec
	 82Ura9GdOwaeZIJFsWoTol9uurCmCaBsjCWrxLAOzRSsTa8nwoHNvC9frsd2ILDPpr
	 k4781pAQtAtqg==
Date: Thu, 12 Sep 2024 16:23:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org, leo.yan@arm.com,
	scclevenger@os.amperecomputing.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/7] perf: cs-etm: Coresight decode and disassembly
 improvements
Message-ID: <ZuM_oMuODcF0WVza@x1>
References: <20240912151143.1264483-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912151143.1264483-1-james.clark@linaro.org>

On Thu, Sep 12, 2024 at 04:11:31PM +0100, James Clark wrote:
> A set of changes that came out of the issues reported here [1].
> 
>  * First 2 patches fix a decode bug in Perf and add support for new
>    consistency checks in OpenCSD
>  * The remaining ones make the disassembly script easier to test
>    and use. This also involves adding a new Python binding to
>    Perf to get a config value (perf_config_get())
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/

Looks ok from a quick look, but I can't test it, so since there are
reporters for problems that are being fixed, it would be great to have a
Tested-by: from the reporters and probably from someone with access to
the hardware where this can be tested.

- Arnaldo
 
> Changes since V1:
>   * Keep the flush function for discontinuities
>   * Still remove the flush when the buffer fills, but now add
>     cs_etm__end_block() for the end trace. That way we won't drop
>     the last branch stack if the instruction sample period wasn't
>     hit at the very end.
> 
> James Clark (7):
>   perf cs-etm: Don't flush when packet_queue fills up
>   perf cs-etm: Use new OpenCSD consistency checks
>   perf scripting python: Add function to get a config value
>   perf scripts python cs-etm: Update to use argparse
>   perf scripts python cs-etm: Improve arguments
>   perf scripts python cs-etm: Add start and stop arguments
>   perf test: cs-etm: Test Coresight disassembly script
> 
>  .../perf/Documentation/perf-script-python.txt |   2 +-
>  .../scripts/python/Perf-Trace-Util/Context.c  |  11 ++
>  .../scripts/python/arm-cs-trace-disasm.py     | 109 +++++++++++++-----
>  .../tests/shell/test_arm_coresight_disasm.sh  |  63 ++++++++++
>  tools/perf/util/config.c                      |  22 ++++
>  tools/perf/util/config.h                      |   1 +
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +-
>  tools/perf/util/cs-etm.c                      |  25 ++--
>  8 files changed, 205 insertions(+), 35 deletions(-)
>  create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh
> 
> -- 
> 2.34.1
