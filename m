Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03B267AF2;
	Tue, 25 Feb 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482751; cv=none; b=FPK80oS5xncH84BBQfaQtJhwDvh4sbAy0wRwVTD1/4xus1Wzie/E0LArkExyTlr5kTjNqUnZEiA4tgePvuy7i+TA3hEhmNv9Ks4m7KOrc/DOY1QDoiXjTtkOvH70vdaxvxub5m85Us9B1QOxXK5tIvQroWZd3NoNX9ya3asdmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482751; c=relaxed/simple;
	bh=Lhrwl1x6WS1e4L0zo3QZm7lLfOMmhJbsDbNnkKZwnoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ien8MnF3Ty8oQKgStkZivCy/NkTzOFuwJYqMrl5mgY1Lxy6jh/i52Zf/H5RwgxEo/dm+GQf0zhJstkE3aqK2u8MrNTypd2VM2N7VXCNjU/ObkX7ZjFncuyzefR2Y0DXNXcYD02xrV3UOX/N7rJyUCTIIA+E0N7bQhr9A3llLeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WL0S8IpA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WL0S8IpA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lhrwl1x6WS1e4L0zo3QZm7lLfOMmhJbsDbNnkKZwnoc=; b=WL0S8IpAQoEwauZY6lBtK5wOR9
	5O5SN6NWP0e5vkh+piwcr7J1+FN4O6oiABvTqF6EMpPg2tsL+LJd6cbyfIInpEYpgdclKGSNAZMiS
	p5szNhj617nQInk8okB5JuYAvhi7vkxUCenxvVwt91pZbcoQSKqkOshl1jdaCnTpcWyhodPUJsV70
	PTEFm6Ey6Vk3Bn5Z01ZVeSnG6bXkPnZW0SHOMKWOuzp5iVJhrmVc2Y4iRuafFgzFpkuGmgxMhHMoI
	lE8RhK7wCPEQVlNbOzCsgQjeHtokHqtsEJ20CeD9zlsd078JXDXiN42bEQuRFFFLkoni7vp1kVUwY
	QEBBfQOQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmt4J-00000003Ktc-2raQ;
	Tue, 25 Feb 2025 11:25:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 451C73006E6; Tue, 25 Feb 2025 12:25:43 +0100 (CET)
Date: Tue, 25 Feb 2025 12:25:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
Message-ID: <20250225112543.GM11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218152818.158614-13-dapeng1.mi@linux.intel.com>

On Tue, Feb 18, 2025 at 03:28:06PM +0000, Dapeng Mi wrote:
> Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
> buffer physical address. This patch allocates arch-PEBS buffer and then
> initialize IA32_PEBS_BASE MSR with the buffer physical address.

Just to clarify, parts with ARCH PEBS will not have BTS and thus not
have DS?

