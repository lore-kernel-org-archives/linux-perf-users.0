Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F592153DA;
	Mon,  3 Mar 2025 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027765; cv=none; b=qCNwVrXnQhJaxlYdhMdN9qG66B28Hb6MDkE1+rWJM9dO7ApCZMtxGS69GcafKHGVffpDnQkXJ4W8dHGOuP/qPk0LfnY0VXDW6dW9JXFVrtLSXZ56TRTWe+qcwmN6jjb8393XKqijG/SFtd/HkmDxkeXV8LJCLYLbhClgeNRKHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027765; c=relaxed/simple;
	bh=yvOErWgGplr1RzfmwsWTWEThOitL1zHkxHLo/eafhMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fstRheqKOwt9QyqxMRJFRRI06JglWohtK2hkuuJifFgtKSip+8pIC1dpReUSMRrss/2g9o7AhyRVm2z4XwA38XhqSrN3AX4z7W1/YmGR+0WsGsMklcMhI4Bae5Q7oaUFLo4BgKwBrQZzSmliF4GpspROOmA9vKSLU0K8QXRMHnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC63106F;
	Mon,  3 Mar 2025 10:49:36 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A063D3F5A1;
	Mon,  3 Mar 2025 10:49:21 -0800 (PST)
Date: Mon, 3 Mar 2025 18:49:17 +0000
From: Leo Yan <leo.yan@arm.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/12] perf script: Make printing flags reliable
Message-ID: <20250303184917.GJ2157064@e132581.arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250217195908.176207-2-leo.yan@arm.com>
 <34795c29-d256-49ce-9d01-435f8cd91611@intel.com>
 <20250303162210.GH2157064@e132581.arm.com>
 <447bcafc-4c47-4b95-bf21-7aee2cb6a629@intel.com>
 <20250303181152.GI2157064@e132581.arm.com>
 <c227a1c2-13a4-4078-87ee-ed3fe0638060@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c227a1c2-13a4-4078-87ee-ed3fe0638060@intel.com>

On Mon, Mar 03, 2025 at 06:56:42PM +0200, Adrian Hunter wrote:
> On 3/03/25 20:11, Leo Yan wrote:
> > On Mon, Mar 03, 2025 at 05:05:13PM +0200, Adrian Hunter wrote:
> > 
> > [...]
> > 
> >>>>> +	ret = max(ret, SAMPLE_FLAGS_STR_ALIGNED_SIZE);
> >>>>> +	return fprintf(fp, "  %-*s ", ret, str);
> >>>>
> >>>> -21 means the field width is 21 and left-justified.  It should not
> >>>> truncate the string.
> >>>
> >>> No, it does not truncate the string.
> >>>
> >>> It calculates a maximum value between the returned length and 21 (
> >>> defined in SAMPLE_FLAGS_STR_ALIGNED_SIZE).  It keeps left-justified and
> >>> can printing a complete string if the string length is bigger than 21.
> >>
> >> Maybe I am missing something, but that isn't that what
> >>
> >> 	return fprintf(fp, "  %-21s ", str);
> >>
> >> does anyway?  Why change it to something more complicated.
> > 
> > You are right.  I should have done an experiment for this.
> > 
> > I will remove the max() sentence and update the last line:
> > 
> >         return fprintf(fp, "  %-*s ", SAMPLE_FLAGS_STR_ALIGNED_SIZE, str);
> > 
> > Another option is to drop this patch.  But I prefer to keep it, the
> > reason is except the benefit for the debugging log, an extra reason is
> > the SAMPLE_FLAGS_STR_ALIGNED_SIZE macro is used to replace the opened
> > value '21'.  The macro also will be used by a later patch for
> > right-alignment printing.  How about you think?
> 
> Sure

Thanks a lot for confirmation and review!

I will send new version in my tomorrow.

Leo
