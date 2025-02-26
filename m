Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65E19EED7;
	Wed, 26 Feb 2025 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563223; cv=none; b=F0oBCeTtUVMGtFcVtUbTlBnk4NqOm0+vQNqXXOnQHWpFdGOIHlEoSrF9dEFDeftNSCK7ElGIteu55wFiz/kpZJfA0gMlKHegYapPoYiCcthq5qqDXOB9Mmkc65abyRMNVlzm8V1ik4yF/oJz3/GGLpxzFP0wfS/Rt5eCX3lcspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563223; c=relaxed/simple;
	bh=65mCvrCgQ8vUabuuLrrDfQqdfH8PfOiynZ1+gS5LqcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3GpXJ5reIUcl9X5akXHv6VjGZJPW9W/3KIWDzIZ85ScnWEXgUInO+3uEcxEQduya8xAs1Zb1yu1C0sJdVEyoDGS8vMX0rUp+FSW6hvvGSF2PJTbkWElr32aFRbp1WQElawgmrUngrtgxq85PXo/HSfTzehSDdamAo8tQZF5zIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GR8ZTEI2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GR8ZTEI2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YtowJyTfySe91smR0qJ/muHbcExkBlLYkwOcrWOMYg0=; b=GR8ZTEI2cDfxbbLGLTUqMau5x8
	QU3gurHsTGFVIe1eAvVAGwAY/J75XF8XyeaaAurSkh+fufJHMbOokeO6+4vENMZ5oVhxBWZNRLfIm
	5Pr592CUB/oZsCmKVj0wwvv/UNx17MqjkjazitGIeaiWOi6nBrtbquf+H5dTlI6kvzduZYUctgCNg
	EpEP71ClhZ9Z0QFbV/kRLznf26IH6lgnU+3IjQCV1+6v7RLEQaF25A8WCFtyXZ/ao6kwyUISCaJUl
	QvhrV42Uft2Vb8mb9oETo0p1Beox4u3KSyx26qi+iOuFhuFnDzOgxZtInOK9e+icO8dlV1HU12h2E
	q498Gy3Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnE0G-00000003ZNY-3ZXz;
	Wed, 26 Feb 2025 09:46:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6C9CD300677; Wed, 26 Feb 2025 10:46:56 +0100 (CET)
Date: Wed, 26 Feb 2025 10:46:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 12/24] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
Message-ID: <20250226094656.GS11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
 <20250225111805.GL11590@noisy.programming.kicks-ass.net>
 <2e1b48d7-1528-4de0-affa-e6c13e0ce1b1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e1b48d7-1528-4de0-affa-e6c13e0ce1b1@linux.intel.com>

On Wed, Feb 26, 2025 at 01:48:52PM +0800, Mi, Dapeng wrote:
> 
> On 2/25/2025 7:18 PM, Peter Zijlstra wrote:
> > On Tue, Feb 18, 2025 at 03:28:06PM +0000, Dapeng Mi wrote:
> >> Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
> >> buffer physical address. This patch allocates arch-PEBS buffer and then
> >> initialize IA32_PEBS_BASE MSR with the buffer physical address.
> > Not loving how this patch obscures the whole DS area thing and naming.
> 
> arch-PEBS uses a totally independent buffer to save the PEBS records and
> don't use the debug store area anymore. To reuse the original function as
> much as possible and don't mislead users to think arch-PEBS has some
> relationship with debug store, the original key word "ds" in the function
> names are changed to "BTS_PEBS". I know the name maybe not perfect, do you
> have any suggestion? Thanks.

Right, so I realize it has a new buffer, but why do you need to make it
all complicated like this?

Just leave the existing stuff and stick the new arch pebs buffer
somewhere new. All that reserve nonsense shouldn't be needed anymore.

Just add it to the intel_pmu_cpu_{prepare,starting,dying,dead} things.
