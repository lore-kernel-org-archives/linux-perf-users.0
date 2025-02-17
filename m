Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F00227BAA;
	Mon, 17 Feb 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822658; cv=none; b=fuX7LOWuudBGib7aBjs+wzNc1TyORGhNPNAoO8MQs1Flfvck8MrCu45P00sj38NJuSRszkStHGfd9ZK2BnPf5MHiKZDs7QVQ3FSK5C0ec8qzcZ+3Fyp9AyXGaeyZV1CRtRU++wT4KbZ/Bd3T5MvUCK9wdAnZD1epDsIg50o9+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822658; c=relaxed/simple;
	bh=fMBnlLxk2mqjJMmrkkTbsI+W9nTHUXVEsSQOO5LWjB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtEiaixrcyPUatY0dQx+pQE3koC9ZQ+Rj3nvRsSKORIz9sFZ4XTAARVNvwkupiVpa9MQUUvnyRcxRgUfeKSF6wAlgomQ7hFIwlgGPV/LeImAbqMOodPgaM172nR6eB+KTi9kaiq2pTixAfS7JibrkQUgF6QxJyNQ0Q3LfPA66SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB2A152B;
	Mon, 17 Feb 2025 12:04:34 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E09D73F6A8;
	Mon, 17 Feb 2025 12:04:14 -0800 (PST)
Date: Mon, 17 Feb 2025 20:04:09 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] perf arm-spe: Fill branch operations and events
 to record
Message-ID: <20250217200409.GC8144@e132581.arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
 <20250214111936.15168-9-leo.yan@arm.com>
 <a5d99e7f-1d8d-41f1-976d-7d67a0d5decb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d99e7f-1d8d-41f1-976d-7d67a0d5decb@linaro.org>

On Mon, Feb 17, 2025 at 04:20:57PM +0000, James Clark wrote:

[...]

> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > index ba807071d3c1..52bd0a4ea96d 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> > @@ -207,6 +207,18 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
> >                               break;
> >                       case SPE_OP_PKT_HDR_CLASS_BR_ERET:
> >                               decoder->record.op |= ARM_SPE_OP_BRANCH_ERET;
> > +                             if (payload & SPE_OP_PKT_COND)
> > +                                     decoder->record.op |= ARM_SPE_OP_BR_COND;
> 
> I think this results in memory events being synthesised for these
> samples because of a bug in arm_spe__synth_data_source().
> ARM_SPE_OP_BR_COND overlaps with bits from other packet types like
> ARM_SPE_OP_LD:
> 
>        if (record->op & ARM_SPE_OP_LD)
>                data_src.mem_op = PERF_MEM_OP_LOAD;
> 
> arm_spe__synth_data_source() needs to only interpret that as a data
> source packet if ARM_SPE_OP_LDST is set. This was reported by Mike
> Williams but you have the privilege of hitting it for real first.

Good catching.  I have added a new patch 06 to fix the bug in the
v3 series.  Thanks for hooking up the info.

Leo
