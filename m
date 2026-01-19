Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF8835B15F;
	Mon, 19 Jan 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831152; cv=none; b=exhAAGb6DL4oosIpxI71hloLOktlxZbHAg2bdaYjgLtQs9ojGAJQPhrOqtnOl4XvXSsuQxMcI4KXLlEC/T27rmU07V71cmSJR6Quc/yr/4HYng0o6MbJPvJ2z+jqaCv255/W8iDMwR90nTT1ZKg+YNRFOlSFWBI77BiqbudGxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831152; c=relaxed/simple;
	bh=5ivbxlTB9wJXufyx5pbfLSOZrVI0Lg8OAK/Ny/Rl1Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcIxC4sV6nb7BAG8k19bLxpSZK1//MvBLmFJKs+SVBxkNqmGFkW/EXJ26Rzz+NuYu4vL7V875O1+YEuDs8egFzuitny6FMhzHxlmwDomeFvMBnWmGWTuI+XbVgYtDpBpiA2hBSrXPtLkvXumndETmwBo/KtTUPipemCarNOyTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86661FEC;
	Mon, 19 Jan 2026 05:59:03 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B02033F7B4;
	Mon, 19 Jan 2026 05:59:09 -0800 (PST)
Date: Mon, 19 Jan 2026 13:59:07 +0000
From: Leo Yan <leo.yan@arm.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf cs-etm: Fix decoding for sparse CPU maps
Message-ID: <20260119135907.GA2732125@e132581.arm.com>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>
 <20260119111509.GD1286628@e132581.arm.com>
 <c50da3af-e6f5-4b40-bd25-1e37fd6bf0d5@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50da3af-e6f5-4b40-bd25-1e37fd6bf0d5@intel.com>

On Mon, Jan 19, 2026 at 02:11:43PM +0200, Adrian Hunter wrote:

[...]

> >>   0 0 0x200 [0x90]: PERF_RECORD_ID_INDEX nr: 4
> >>   ... id: 771  idx: 0  cpu: 2  tid: -1
> >>   ... id: 772  idx: 1  cpu: 3  tid: -1
> >>   ... id: 773  idx: 0  cpu: 2  tid: -1
> >>   ... id: 774  idx: 1  cpu: 3  tid: -1
> > 
> > Seems to me that this patch works around the issue by using the CPU ID
> > instead, but event->auxtrace.idx is broken.
> > 
> > Should we store the correct index in event->auxtrace.idx (e.g., in the
> > __perf_event__synthesize_id_index()) ?
>
> The idx value represents a perf events ring buffer.  Events on the same
> CPU can share the same ring buffer.  But in the case of per-thread
> recording, different threads have different ring buffers and therefore
> different idx values.
> 
> So I don't think the idx value is wrong.  It is just not the same thing
> as CPU number.

Thanks a lot for the explanation, this makes sense to me.

Leo
