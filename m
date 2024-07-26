Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753217C64;
	Fri, 26 Jul 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003484; cv=none; b=l00xRFxmt6+d2HuZrsdl8aG5GuyKgJl8kdEXdVG7meNif6QGqctITjb40TThh7nztnO4wdDcLpjl2Jw5nF8QEyLruUegbXbbsVkTZjqgKUpeTBpJ3OWWi1tLxCpEyWfTpndTxd6fKta9Ikt5xmW7t2fF8D1wkVD+JyMpeoGQGGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003484; c=relaxed/simple;
	bh=GEuaYMdifYZj2qLr1Mq99LFYCiUGknXwcHjv8sE9EFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYhKA3BcQkXD5hNjhEM0iouvvAZAs6fpM0WbVg6hPNSv/EXZqFND+PMJeLy939Ejl2CZiy7ayxpjEjI3bRF7+8aHvlFnadVx3zfaP86X0MjiXLuifkjYAGw7idOEOS78WrH1+/S/7wjhfxQW2RNmmfkLm2P3jVLYCxgVc13wBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSWKFfta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSWKFfta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEBCC32782;
	Fri, 26 Jul 2024 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722003484;
	bh=GEuaYMdifYZj2qLr1Mq99LFYCiUGknXwcHjv8sE9EFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSWKFftauRsaLRxZmdLfuuVG2ePLQOFeHnnI6QJWpy+1ZehwCup3TY6FvOnsIjI2u
	 Yue3izIg8qvGX07TSDEQWnotMFQHxwd2NeuPbYxZlD372ZImq6WpdP4szqiSlzsgIr
	 17K9R8Yq4RNUN5Rnoyn55sQWLjSmvnPbD3lOBcmzKII2nfB5JQeHJLsFPgLS9k/pKw
	 PNvc23TGdfHzoe8XlSpbFTYFeDPeta+TRSNDZJrCq6axAqqOo4vIJv/wC9TDLkoQ2G
	 630fSxQ40MougIhHfpuzAAfovjMqXOJwZNBf3amTUjtMg8HII8kQrWJpLQT7wNhqjH
	 HJWZoOFzxnIAw==
Date: Fri, 26 Jul 2024 11:18:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
	leo.yan@linux.dev, anshuman.khandual@arm.com,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
Message-ID: <ZqOwGWcYosGe9ru4@x1>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>

On Mon, Jul 22, 2024 at 11:11:42AM +0100, James Clark wrote:
> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> as long as there are fewer than that many ETMs connected to each sink.

Hey, may I take the tools part, i.e. patches 0-7 and someone on the ARM
kernel team pick the driver bits?

- Arnaldo
 
> Each sink owns its own trace ID map, and any Perf session connecting to
> that sink will allocate from it, even if the sink is currently in use by
> other users. This is similar to the existing behavior where the dynamic
> trace IDs are constant as long as there is any concurrent Perf session
> active. It's not completely optimal because slightly more IDs will be
> used than necessary, but the optimal solution involves tracking the PIDs
> of each session and allocating ID maps based on the session owner. This
> is difficult to do with the combination of per-thread and per-cpu modes
> and some scheduling issues. The complexity of this isn't likely to worth
> it because even with multiple users they'd just see a difference in the
> ordering of ID allocations rather than hitting any limits (unless the
> hardware does have too many ETMs connected to one sink).
> 
> Per-thread mode works but only until there are any overlapping IDs, at
> which point Perf will error out. Both per-thread mode and sysfs mode are
> left to future changes, but both can be added on top of this initial
> implementation and only sysfs mode requires further driver changes.
> 
> The HW_ID version field hasn't been bumped in order to not break Perf
> which already has an error condition for other values of that field.
> Instead a new minor version has been added which signifies that there
> are new fields but the old fields are backwards compatible.
> 
> Changes since v5:
>   
>   * Hide queue number printout behind -v option
>   * Style change in cs_etm__process_aux_output_hw_id()
>   * Move new format enum to an earlier commit to reduce churn
> 
> Changes since v4:
> 
>   * Fix compilation failure when TRACE_ID_DEBUG is set
>   * Expand comment about not freeing individual trace IDs in
>     free_event_data()
> 
> Changes since v3:
> 
>   * Fix issue where trace IDs were overwritten by possibly invalid ones
>     by Perf in unformatted mode. Now the HW_IDs are also used for
>     unformatted mode unless the kernel didn't emit any.
>   * Add a commit to check the OpenCSD version.
>   * Add a commit to not save invalid IDs in the Perf header.
>   * Replace cs_etm_queue's formatted and formatted_set members with a
>     single enum which is easier to use.
>   * Drop CORESIGHT_TRACE_ID_UNUSED_FLAG as it's no longer needed.
>   * Add a commit to print the queue number in the raw dump.
>   * Don't assert on the number of unformatted decoders if decoders == 0.
> 
> 
> Changes since v2:
> 
>   * Rebase on coresight-next 6.10-rc2 (b9b25c8496).
>   * Fix double free of csdev if device registration fails.
>   * Fix leak of coresight_trace_id_perf_start() if trace ID allocation
>     fails.
>   * Don't resend HW_ID for sink changes in per-thread mode. The existing
>     CPU field on AUX records can be used to track this instead.
>   * Tidy function doc for coresight_trace_id_release_all()
>   * Drop first two commits now that they are in coresight-next
>   * Add a commit to make the trace ID spinlock local to the map
> 
> Changes since V1:
> 
>  * Rename coresight_device.perf_id_map to perf_sink_id_map.
>  * Instead of outputting a HW_ID for each reachable ETM, output
>    the sink ID and continue to output only the HW_ID once for
>    each mapping.
>  * Keep the first two Perf patches so that it applies cleanly
>    on coresight-next, although they have been applied on perf-tools-next
>  * Add new *_map() functions to the trace ID public API instead of
>    modifying existing ones.
>  * Collapse "coresight: Pass trace ID map into source enable" into
>    "coresight: Use per-sink trace ID maps for Perf sessions" because the
>    first commit relied on the default map being accessible which is no
>    longer necessary due to the previous bullet point.
> 
> 
> James Clark (17):
>   perf: cs-etm: Create decoders after both AUX and HW_ID search passes
>   perf: cs-etm: Allocate queues for all CPUs
>   perf: cs-etm: Move traceid_list to each queue
>   perf: cs-etm: Create decoders based on the trace ID mappings
>   perf: cs-etm: Only save valid trace IDs into files
>   perf: cs-etm: Support version 0.1 of HW_ID packets
>   perf: cs-etm: Print queue number in raw trace dump
>   perf: cs-etm: Add runtime version check for OpenCSD
>   coresight: Remove unused ETM Perf stubs
>   coresight: Clarify comments around the PID of the sink owner
>   coresight: Move struct coresight_trace_id_map to common header
>   coresight: Expose map arguments in trace ID API
>   coresight: Make CPU id map a property of a trace ID map
>   coresight: Use per-sink trace ID maps for Perf sessions
>   coresight: Remove pending trace ID release mechanism
>   coresight: Emit sink ID in the HW_ID packets
>   coresight: Make trace ID map spinlock local to the map
> 
>  drivers/hwtracing/coresight/coresight-core.c  |  37 +-
>  drivers/hwtracing/coresight/coresight-dummy.c |   3 +-
>  .../hwtracing/coresight/coresight-etm-perf.c  |  43 +-
>  .../hwtracing/coresight/coresight-etm-perf.h  |  18 -
>  .../coresight/coresight-etm3x-core.c          |   9 +-
>  .../coresight/coresight-etm4x-core.c          |   9 +-
>  drivers/hwtracing/coresight/coresight-priv.h  |   1 +
>  drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
>  drivers/hwtracing/coresight/coresight-sysfs.c |   3 +-
>  .../hwtracing/coresight/coresight-tmc-etr.c   |   5 +-
>  drivers/hwtracing/coresight/coresight-tmc.h   |   5 +-
>  drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
>  .../hwtracing/coresight/coresight-trace-id.c  | 138 ++--
>  .../hwtracing/coresight/coresight-trace-id.h  |  70 +-
>  include/linux/coresight-pmu.h                 |  17 +-
>  include/linux/coresight.h                     |  21 +-
>  tools/build/feature/test-libopencsd.c         |   4 +-
>  tools/include/linux/coresight-pmu.h           |  17 +-
>  tools/perf/Makefile.config                    |   2 +-
>  tools/perf/arch/arm/util/cs-etm.c             |  11 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  49 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   3 +-
>  .../util/cs-etm-decoder/cs-etm-min-version.h  |  13 +
>  tools/perf/util/cs-etm.c                      | 629 +++++++++++-------
>  tools/perf/util/cs-etm.h                      |  12 +-
>  25 files changed, 650 insertions(+), 475 deletions(-)
>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h
> 
> -- 
> 2.34.1
