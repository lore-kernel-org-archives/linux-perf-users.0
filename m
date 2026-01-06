Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A271D340A70;
	Tue,  6 Jan 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712123; cv=none; b=CMOsZbaEe5U9J3sShWUDoTLNXQKLojs7ZtFGmMYYwQCGzB0bPXr1Fbgh19MiFYmz9V9lYNXEuVaWSL8334e5eVIVNTr1X+pvzxYjRCeXBv1Q4Lgi9OE80pGeZBSrxXvn6KZ8WUhet60MmGgWReZzsjXH7UM2lYIeNLAHsuzzAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712123; c=relaxed/simple;
	bh=wLbj9LDtB53QHQl+hQyVEcTGulHjZMoc6xQmHNrxOaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5ZzaSX6nnox087Oux6Jqk/I8ivniKMePUPufSrTiwg7hAPeWbAiuTCsVZyV6xhMnoETEL/3xMId4qTVps1xQMzklRUmpqSbE/IND1PniKtHZgo6aWMyUdnYDJaRX54t9/6U+Yb3x4JpY8q40mXrpioGSIfY93gn2MEgrP00hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OIOocKzx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OIOocKzx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q9aq/Ciomf9bwZXegh8p7a/KEdbOoDqIh9OwTAwSpuk=; b=OIOocKzxrWCmZSRHxeQ0fUVEni
	utnaGUK3eQzuBhcVnxKNKYAdTG4tOYUwk3S+Pt5enVb8dEAAdgOsUCOu1EhtFX4uz22aGLj/dv6fM
	tThu7uCUWL3q82P0qIiBWeQnVCPI9d5n4Zp88y7cLC4GOQ339O0kiXgFzOeaJq5qhz8WP9IfccoRO
	T8etuTrDlnY6K9F2rSDNctK+hTEzqn5T2xAllE7SlqcBOeT2XHFzVCiKVvcHLmweXLegct7mHtFXc
	hI5ZsS1MhaaZ9TUIvKwrzhP4r5j2AY7QVSAtS1z07LdOuWeLlKmr8Np6P4oeF/KHiWyViSyvbyEW2
	U//1fuVw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd8fi-00000009w33-0BoC;
	Tue, 06 Jan 2026 15:08:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9128D30056B; Tue, 06 Jan 2026 16:08:33 +0100 (CET)
Date: Tue, 6 Jan 2026 16:08:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: Re: [PATCH V2 00/13] Add DMR/NVL and missing PTL uncore support
Message-ID: <20260106150833.GD2393663@noisy.programming.kicks-ass.net>
References: <20251231224233.113839-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231224233.113839-1-zide.chen@intel.com>

On Wed, Dec 31, 2025 at 02:42:17PM -0800, Zide Chen wrote:

> Zide Chen (13):
>   perf/x86/intel/uncore: Move uncore discovery init struct to header
>   perf/x86/intel/uncore: Support per-platform discovery base devices
>   perf/x86/intel/uncore: Remove has_generic_discovery_table()
>   perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids
>   perf/x86/intel/uncore: Add CBB PMON support for Diamond Rapids
>   perf/x86/intel/uncore: Add domain global init callback
>   perf/x86/intel/uncore: Add freerunning event descriptor helper macro
>   perf/x86/intel/uncore: Support IIO free-running counters on DMR
>   perf/x86/intel/uncore: Support uncore constraint ranges
>   perf/x86/intel/uncore: Update DMR uncore constraints preliminarily
>   perf pmu: Relax uncore wildcard matching to allow numeric suffix
>   perf/x86/intel/uncore: Add missing PMON units for Panther Lake
>   perf/x86/intel/uncore: Add Nova Lake support

Thanks, pushed out to queue/perf/core for the robots to have a go.

I made a few minor edits, the biggest of which I already shared in a
reply.
