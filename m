Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065CD1DED72;
	Fri,  6 Dec 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476950; cv=none; b=sM1RArq/Ac1LR5SOWwyWNydhZ2E0chc2iv0Fy/eijs1rw/UYLfMHyd047nu0mHUh1lLlk0Uccgcxr6En2S8dTDy9y3pNTzUNLhkVT+JbFhV4pHcaGfyl0WeBHkbD50hOanTvx5HtGC0BU4aJuztMM2CKZ27n/7tcTrl5SaIUyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476950; c=relaxed/simple;
	bh=Kxhxu18faEJa0qeL2OuOGGTYdBFWaoX3zZs4VtZlzcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7EVpAE4FOJpmxRgcGL3ysFDiM4rWQsaBSdINIit3IY+9c8OwnUkDL3cjXDVNgvPUO66qIxcU0V+9gIMm5GT+cnb6AKtLeOmglJfbBU8M+uQGJzJRZhs8gXChfyD7Gwnhza0M0va7zMglkn6opZLVSDSUpvR5qExYDMaXkKoE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxjnQtST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxjnQtST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01064C4CED1;
	Fri,  6 Dec 2024 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733476949;
	bh=Kxhxu18faEJa0qeL2OuOGGTYdBFWaoX3zZs4VtZlzcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxjnQtSTdTRcCBlJRB5QsQ4ruIfv/B0e4uInSmkgUbpVD74aWzEdEspOQeIP3POy2
	 Yi5DWbbojx/hAArPCL1e0LlEiJ6wsObPPeS73YWPBBs0N/HhW244hiJ95BatGGgI0n
	 2jWmuSwpb+M1i9YhJ776s9hg/eUMXNwYOnjO/xOahkecbvH3LgU93jxRQ9e126EmPn
	 qTf+jHCVua4RANwqChVxmyTtkD4baNdNEinYqHtkBZD3maglpncgECg7yy82Iu5jQL
	 cMaLeVqsFnb5KpO1erLxRyv69bnhNYihaWEP8Sux452RtDF+k3R0lS0S22bC9Wi7A6
	 M+xXwsv20Q7Ng==
Date: Fri, 6 Dec 2024 10:22:22 +0100
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
Message-ID: <Z1LCTtw99YTutYOR@gmail.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
 <20241206051713.991-6-ravi.bangoria@amd.com>
 <Z1K6IckahmlME6Py@gmail.com>
 <abe58150-735f-4d9d-8ff4-a20b0fc6b376@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe58150-735f-4d9d-8ff4-a20b0fc6b376@amd.com>


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> Hi Ingo,
> 
> >> Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
> >> MSR. Since the sample period is programmed in these control registers,
> >> IBS PMU driver allows opening an IBS event by setting sample period
> >> value directly in perf_event_attr->config instead of using explicit
> >> perf_event_attr->sample_period interface.
> >>
> >> However, this logic is not applicable for freq mode events since the
> >> semantics of control register fields are applicable only to fixed
> >> sample period whereas the freq mode event adjusts sample period after
> >> each and every sample. Currently, IBS driver (unintentionally) allows
> >> creating freq mode event via ->config interface, which is semantically
> >> wrong as well as detrimental because it can be misused to bypass
> >> perf_event_max_sample_rate checks.
> > 
> > Then let's fix those rate checks?
> > 
> > AFAICS this patch limits functionality because the IBS driver would 
> > have to be fixed/enhanced to support frequency based events?
> > 
> > I'd strongly favor fixing/enhancing the driver instead, as 'perf top -F 
> > 1000' is easy to use and it is a useful concept.
> 
> No. This patch does not prevent opening an IBS event in freq mode. User
> can still open freq mode IBS event with usual interface attr->freq=1 and
> attr->sample_freq=<freq>. i.e. 'perf top -F 1000' with IBS event will
> work fine with this patch.

Oh, I see - the regular tooling uses perf_event_attr->sample_period, right?

Never mind then.

Thanks,

	Ingo
