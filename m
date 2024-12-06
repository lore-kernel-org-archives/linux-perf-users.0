Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5E79DC;
	Fri,  6 Dec 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474862; cv=none; b=cH68cr707l/niMswqvsDNiiZSbQP+63WF5rVZ40/2jSrqPVsyulW7AGgf2tk1rFxgLbIzGf2kc7qu6mhe3hYNnNuW6zE70vlOQ7senovN1J6nCauAu3H1Z3i2vN+4iAsDJu0TqtqT0rLfTAFIRpx1BK1P0Kb1YiPSaXqbc4GC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474862; c=relaxed/simple;
	bh=2cJuzFgNXMqIJtJQhtY5xVPvfwt5CjsjMpyZAI+EGs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s894Zi7ZBUaKuTqNeTXkbpncNXe8sJlOGHXJtj3AyLORm0rT9KyOAqbkX/EnFNVkgbpXrU1UvndRwIe3jr+6dgC1GwdsTRdK/nftMS4tWSuDWmfqdg0NdNmh9eWJ6SjBh04iW0bpa+QyxpVCU5W0Xq6P6Zu4aBM9oIkAn1IqT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGfurh+M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGfurh+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDCAC4CED1;
	Fri,  6 Dec 2024 08:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733474861;
	bh=2cJuzFgNXMqIJtJQhtY5xVPvfwt5CjsjMpyZAI+EGs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGfurh+M4GHhe3XK9feusgf9MBHi5zcUyCtG1m5deErYBWFAgE9ALFrD9pMzbPeLx
	 leuqUdUE+Taj235OPAj0rNDpf5zKU2wAgsp8XtlDNio54l9grTgh7P0wZ97afFcJLE
	 n9QN3aG+uxsH93qe1DzBSbXRMcZzYUtToj1E9HRK0/612JI3bBUHaCjddn1LqkW6St
	 D2aKpNg57LLpxykOJun7kb/NlU0AVMo+raPBoBMFmjzNyxTqbvDQzcLFiKiDlfBS8Z
	 YSnjj4xYmSesQtAq2T78UySaCwVWgu5ABUFz1uhG1WpyingjjsYurVKQk7Wqh9xoF9
	 AhzEMiX5RX0mA==
Date: Fri, 6 Dec 2024 09:47:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v2 05/10] perf/amd/ibs: Don't allow freq mode event
 creation through ->config interface
Message-ID: <Z1K6IckahmlME6Py@gmail.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
 <20241206051713.991-6-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206051713.991-6-ravi.bangoria@amd.com>


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
> MSR. Since the sample period is programmed in these control registers,
> IBS PMU driver allows opening an IBS event by setting sample period
> value directly in perf_event_attr->config instead of using explicit
> perf_event_attr->sample_period interface.
> 
> However, this logic is not applicable for freq mode events since the
> semantics of control register fields are applicable only to fixed
> sample period whereas the freq mode event adjusts sample period after
> each and every sample. Currently, IBS driver (unintentionally) allows
> creating freq mode event via ->config interface, which is semantically
> wrong as well as detrimental because it can be misused to bypass
> perf_event_max_sample_rate checks.

Then let's fix those rate checks?

AFAICS this patch limits functionality because the IBS driver would 
have to be fixed/enhanced to support frequency based events?

I'd strongly favor fixing/enhancing the driver instead, as 'perf top -F 
1000' is easy to use and it is a useful concept.

Thanks,

	Ingo
