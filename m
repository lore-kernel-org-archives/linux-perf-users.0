Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5421CC170;
	Thu, 22 Aug 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335588; cv=none; b=bGvxGz20DsK5f3OBuWLHoO7zpNgYfTct+T8wHKU7wHDJm8RHsE6b6y59nm1rZLHggMWLjr5XhJqb0pVNw9ivWAIUXz4ZcuSceKS8rwpiGiAr8PtBIT7QG1a1sPh/FW1asq2A0JiBNqHe8MX2+ifHAhQ3gwgPtDYb5MVh7xeVHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335588; c=relaxed/simple;
	bh=BPtoV+Z2sZAtwy9VZzlsztIQ+D4S9C7Y7xrQ4jNccaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7w/1ylcb2TghJivLj4PM1HVyG8zsYrbAt4V1BFhlybqazX2+SFr2Xgy3h1U0CLCvI/2iaLMOGy+mBPS3DnYcCLcQm+rIm0vjt6oBnAwf99mLcz+EjVwdNXQ7zaLU+EyeJCPPjuVTlFii6kL7rsQVwxZxlxXHkiVhmrpC5JijXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EC40DA7;
	Thu, 22 Aug 2024 07:06:51 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 403FE3F66E;
	Thu, 22 Aug 2024 07:06:22 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: anshuman.khandual@arm.com,
	James Clark <james.clark@linaro.org>,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	coresight@lists.linaro.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	James Clark <james.clark@arm.com>
Subject: Re: (subset) [PATCH v6 00/17] coresight: Use per-sink trace ID maps for Perf sessions
Date: Thu, 22 Aug 2024 15:05:53 +0100
Message-Id: <172433479466.350842.6920589600831615538.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Jul 2024 11:11:42 +0100, James Clark wrote:
> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> as long as there are fewer than that many ETMs connected to each sink.
> 
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
> [...]

Applied, the kernel driver changes to coresight/next. Thanks!

[09/17] coresight: Remove unused ETM Perf stubs
        https://git.kernel.org/coresight/c/34172002bdac
[10/17] coresight: Clarify comments around the PID of the sink owner
        https://git.kernel.org/coresight/c/eda1d11979c0
[11/17] coresight: Move struct coresight_trace_id_map to common header
        https://git.kernel.org/coresight/c/acb0184fe9bc
[12/17] coresight: Expose map arguments in trace ID API
        https://git.kernel.org/coresight/c/7e52877868ae
[13/17] coresight: Make CPU id map a property of a trace ID map
        https://git.kernel.org/coresight/c/d53c8253c782
[14/17] coresight: Use per-sink trace ID maps for Perf sessions
        https://git.kernel.org/coresight/c/5ad628a76176
[15/17] coresight: Remove pending trace ID release mechanism
        https://git.kernel.org/coresight/c/de0029fdde86
[16/17] coresight: Emit sink ID in the HW_ID packets
        https://git.kernel.org/coresight/c/487eec8da80a
[17/17] coresight: Make trace ID map spinlock local to the map
        https://git.kernel.org/coresight/c/988d40a4d4e7

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
