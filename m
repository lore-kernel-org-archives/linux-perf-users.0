Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1934405D;
	Thu,  4 Dec 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859422; cv=none; b=dn5NbR2JEFHa/gZlzzycBvFoSt7Q6jjC4uPIcJLHlCZubvFI//a1rckgB6N9EpmnVGbYi7QTKwdzsSINQeBg8Y9ZiBBWiJ/NDhkl0iFHiW0+UisShWA08gqyU+ngz0/QZdMmItj4Xg1kPSF8vcMgELDq6vBEvPe/nO0OMvzTwMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859422; c=relaxed/simple;
	bh=X7HIHJgLEosjztrkvQ70G2wQxtfoQrekxHSQYmvNjO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb0tfTlc+bj8Wz15CvK6auIhJ1uKZdZfELITtViPX9INH21OWrnOzp1+w7twdy7pgIDCNXHvpVW6iA1yCq4ayL7vAWt/E/IhV1nX2kON6CA3158M0rlS+/l8eplhrh6GI701pgA4z42AwjaBktRyixzy+5c69xQpnFj8LC18b/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA605339;
	Thu,  4 Dec 2025 06:43:31 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDAD23F66E;
	Thu,  4 Dec 2025 06:43:38 -0800 (PST)
Date: Thu, 4 Dec 2025 14:43:36 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] perf cs-etm: Don't hard code config attribute when
 configuring the event
Message-ID: <20251204144336.GN724103@e132581.arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-6-22ecbbf8007c@linaro.org>
 <20251202121528.GX724103@e132581.arm.com>
 <857538e7-cac2-4871-9711-4c434420df8a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857538e7-cac2-4871-9711-4c434420df8a@linaro.org>

On Thu, Dec 04, 2025 at 02:08:59PM +0000, James Clark wrote:

[...]

> > > +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid", &ctxt);
> > > +	if (err)
> > > +		return err;
> > > +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid1", &ctxt1);
> > > +	if (err)
> > > +		return err;
> > > +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid2", &ctxt2);
> > > +	if (err)
> > > +		return err;
> > 
> > Seems to me, this is not right.  The current code checks any context
> > ID setting but it can tolerate if missing "contexid[*]" format.
> > 
> > After calling evsel__get_config_val(), if any "contextid[*]" format is
> > missed, it returns error and will diretly bail out.  As a result,
> > cs_etm_validate_context_id() will always return error.
> > 
> 
> Missed by the driver or the user? evsel__get_config_val() only returns an
> error when "contextid" isn't published by the driver, not when the user
> doesn't supply one of those options. The actual user supplied value is in
> the out param, not the return value.

My question is for missing format from user.  Thanks for reminding the
error is only for driver's publishing.

> Having said that, this does make it an error if the driver did stop
> publishing one, which might be too inflexible and is a new behavior. I can
> change to it ignore the errors instead.

Yeah, this will likely break nVHE / pKVM cases.

Thanks,
Leo
