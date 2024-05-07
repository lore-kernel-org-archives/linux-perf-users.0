Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC815FCFC;
	Tue,  7 May 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093669; cv=none; b=hQtj2XYPI3F8JC/ddJpde+8sHHJOFbGiFvhdWp5xEx3tGRzAcOUeMg6CSaG7UTqtsKRRu1alh4w/AeFsngtu+6ug9CU2WNKQ/2u1GpFyDskdpFkuDli2V+lXpNwIqEcm1tXcH4kvuydghyMgIe6T4rd4sLMzcnfnMtNCXwYCKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093669; c=relaxed/simple;
	bh=Yskj674ZMF177lDIJTS3t2DCNKi8KbRLjMbjRBFCvDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/GDEwrU+twUo+OElnN9YxLiSF5I/gOeUjs+iwZ88b5aPhUhP9fsG6CNiUrx0+7xHwtJ0OLeXifrgaiyGcYKKNV1bFwXhpwh9z79AvJ/qd7Lz210NXIPoMgr9YNgMCgBZJxqcUkELk2sxEqc4umMYpidXBscZgmnbIotZvQjGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maSV0SdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maSV0SdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F295BC2BBFC;
	Tue,  7 May 2024 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093668;
	bh=Yskj674ZMF177lDIJTS3t2DCNKi8KbRLjMbjRBFCvDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=maSV0SdSvYk9LCFNKcXLubAdxffaYIb9IBUOo8nvYgE/vbrjkokm7EXkhHi/46wbH
	 jrQb/ujpzl8k+TDX13WUV9KSHBYjqxeSHtInzTDDQjjUwkWWWI+LB7snR8hLoGoDFf
	 ArlNz1Nxtswsg3O23MwPQ1+TG9Pc9wg+oYxRH0rpSOnzLMlc4p/vM+7se4ojUb/PqK
	 hgZQJY26vJkaiOlTKRJyE7iXXpXE4dw6Kr2vfGfjPLQp8dCuTyGJy74vz05Beh66ON
	 X40v0Bpwp3eqBUIkjrIRDmOmuBIknqheXCQ4y6Ng1Rz+85tY+3YTaNWRKR33IxFFzE
	 4gPD9fVMOzyIw==
Date: Tue, 7 May 2024 11:54:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
	mike.leach@linaro.org
Subject: Re: [PATCH 01/17] perf cs-etm: Print error for new
 PERF_RECORD_AUX_OUTPUT_HW_ID versions
Message-ID: <ZjpAoVEam4CQ96zC@x1>
References: <20240429152207.479221-1-james.clark@arm.com>
 <20240429152207.479221-2-james.clark@arm.com>
 <08bcd616-5006-45df-b8cc-45cf3a1dd762@arm.com>
 <de635db0-6510-452f-91be-4fc5f7fdf671@arm.com>
 <ecb16ad9-7c91-4cf6-ab7e-4b4b5be7165c@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb16ad9-7c91-4cf6-ab7e-4b4b5be7165c@arm.com>

On Tue, May 07, 2024 at 04:27:25PM +0530, Anshuman Khandual wrote:
> On 5/7/24 15:36, James Clark wrote:
> > On 07/05/2024 04:47, Anshuman Khandual wrote:
> >> On 4/29/24 20:51, James Clark wrote:
> >>> The likely fix for this is to update Perf so print a helpful message.
> >>>
> >>> Signed-off-by: James Clark <james.clark@arm.com>
> >>> ---
> >>>  tools/perf/util/cs-etm.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> >>> index d65d7485886c..32818bd7cd17 100644
> >>> --- a/tools/perf/util/cs-etm.c
> >>> +++ b/tools/perf/util/cs-etm.c
> >>> @@ -335,8 +335,11 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
> >>>  	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
> >>>  
> >>>  	/* check that we can handle this version */
> >>> -	if (version > CS_AUX_HW_ID_CURR_VERSION)
> >>> +	if (version > CS_AUX_HW_ID_CURR_VERSION) {
> >>> +		pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID version %d not supported. Please update Perf.\n",
> >>
> >> Is not this bit misleading ? PERF_RECORD_AUX_OUTPUT_HW_ID is just the perf record
> >> format identifier. The record version here, is derived from the platform specific
> >> hardware ID information embedded in this perf record.
> > 
> > Not sure I follow what you mean here. 'version' is something that's
> > output by the kernel. It's saved into a perf.data file, and if Perf
> > can't handle version 2 for example, you need to update Perf.
 
> Got it.
 
> >> Should not this be just s/PERF_RECORD_AUX_OUTPUT_HW_ID/hardware ID/ instead ?
> >>
> > 
> > It's just a way to go from the error message to the part of the code or
> > docs that you need to look at. "hardware ID" wouldn't lead you anywhere
> > so I don't think it would be useful.
> 
> Sure, fair enough.

I'm taking this as an Acked-by, ok?

- Arnaldo
