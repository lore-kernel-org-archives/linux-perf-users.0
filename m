Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A631F0E27;
	Mon,  3 Mar 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025519; cv=none; b=CttAgW33kQWR7PSRmEvX8wxNMstRuGL002xR2883WA6bbyjU6J1VWbuawpl0v/vUY630U48AAKODf5emRnloJ03dbVRvcKv1mLz2b336rURv1wpx4+sDObh8+uEnv/hyBD5GEj5LwQsqiCyUUmZGLsfDJHFIQkq3FevGedM8v+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025519; c=relaxed/simple;
	bh=ZCxORyPl4nyY3eukGRlhcWRGsacK8pI/fA44Yfq+yBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDcoKSVY122CIJX7DLRc11SycxoJ81NaLJniXcDYScgXMGjWQ0zh7o8uMsGvNeCKC9xjv7pmZRA7CzuaroayBcFgAfP0SBtp8Qu7rjphUJT3AbkrT9qXm429OEVNTjYUoazSmQsCRLulaufKThjx+ECc8kWD253xiRR/e4MF1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81023106F;
	Mon,  3 Mar 2025 10:12:10 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7DF3F5A1;
	Mon,  3 Mar 2025 10:11:55 -0800 (PST)
Date: Mon, 3 Mar 2025 18:11:52 +0000
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
Message-ID: <20250303181152.GI2157064@e132581.arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250217195908.176207-2-leo.yan@arm.com>
 <34795c29-d256-49ce-9d01-435f8cd91611@intel.com>
 <20250303162210.GH2157064@e132581.arm.com>
 <447bcafc-4c47-4b95-bf21-7aee2cb6a629@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447bcafc-4c47-4b95-bf21-7aee2cb6a629@intel.com>

On Mon, Mar 03, 2025 at 05:05:13PM +0200, Adrian Hunter wrote:

[...]

> >>> +	ret = max(ret, SAMPLE_FLAGS_STR_ALIGNED_SIZE);
> >>> +	return fprintf(fp, "  %-*s ", ret, str);
> >>
> >> -21 means the field width is 21 and left-justified.  It should not
> >> truncate the string.
> > 
> > No, it does not truncate the string.
> > 
> > It calculates a maximum value between the returned length and 21 (
> > defined in SAMPLE_FLAGS_STR_ALIGNED_SIZE).  It keeps left-justified and
> > can printing a complete string if the string length is bigger than 21.
> 
> Maybe I am missing something, but that isn't that what
> 
> 	return fprintf(fp, "  %-21s ", str);
> 
> does anyway?  Why change it to something more complicated.

You are right.  I should have done an experiment for this.

I will remove the max() sentence and update the last line:

        return fprintf(fp, "  %-*s ", SAMPLE_FLAGS_STR_ALIGNED_SIZE, str);

Another option is to drop this patch.  But I prefer to keep it, the
reason is except the benefit for the debugging log, an extra reason is
the SAMPLE_FLAGS_STR_ALIGNED_SIZE macro is used to replace the opened
value '21'.  The macro also will be used by a later patch for
right-alignment printing.  How about you think?

Thanks,
Leo
