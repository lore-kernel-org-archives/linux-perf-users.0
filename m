Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287821C186;
	Mon, 17 Feb 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802301; cv=none; b=vGYirYEqCf8pMbvIElJXPBcpVvxFYGiJkveZrTGm03mCo9Am0caIUGfE7t/Kqw2tbPRub3XtpvU4ICKv9eEj1pDaK4NNJdMuZTjXbVIxf2U18U5KEPV2bpJUozG4+Q9lorjr1sGqMBqqTr1CGue8TKdDuat6Nn90Yc8eRsEN2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802301; c=relaxed/simple;
	bh=4O6pUbxU9WhZLQgMK95/BrypKre2S+YKMb4hZtOiXFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQF+gx1KX9WS5k0ELAJaan0dbOMeTTbFcMnpjGlou5XYt+QcPAjNsw3fXW4DJugJaSFhVyiBR4ZTHoGMGqCU8WU7F66DVZmNOF67k0r13PblEUZA+ha4bj0tonEKx8/ksJAaG0FtGoORKrM7+uRoJ19hdyXT2ksPTmBGAhADkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IhGT9vNn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IhGT9vNn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MTfZEpj9A3ZPs39PczkqPfdLk2kt/FXHPcDnQdLDiQ4=; b=IhGT9vNnq7KY3wiwOFVEaFUuGD
	TWu3bhkXjnhGHNkSUzOjccXBymT68+AhQiCUCEYr0XIfRquHjvKRLHFjvpjapYQUqemDg1J0+Uo0R
	6JZomK7FBkaITfGoa+Gzk0C3XGa1fxOOzfFf8z37dXKEmqlLLtB6vtIavXa4PkKkZOxh+Z0yiAxPa
	5926D4pPM4fQuJlCD+IR93c6Jc4f79rQqcRxeP9JyG9/cxNvpEVhkK6dMv51S991J3eTt5C2nUknA
	9ybw4r+Sz0UEpnDe20c3pDeuwgbFL2cIuUtwKUWU9D/Do6CGXRQvAp6IcngwuHLw+F2ufd0C4oU8x
	72/UXRGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tk23C-00000001N3V-3H2B;
	Mon, 17 Feb 2025 14:24:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B16C83002C7; Mon, 17 Feb 2025 15:24:45 +0100 (CET)
Date: Mon, 17 Feb 2025 15:24:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	eranian@google.com, irogers@google.com, jolsa@kernel.org,
	bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com
Subject: Re: [RESEND][PATCH v3 0/7] perf/amd/ibs: Add Zen5 support
Message-ID: <20250217142445.GA2076@noisy.programming.kicks-ass.net>
References: <20250205060547.1337-1-ravi.bangoria@amd.com>
 <65818316-434e-4468-9ead-2e55c15b62eb@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65818316-434e-4468-9ead-2e55c15b62eb@amd.com>

On Mon, Feb 17, 2025 at 02:00:14PM +0530, Ravi Bangoria wrote:
> On 05-Feb-25 11:35 AM, Ravi Bangoria wrote:
> > IBS on Zen5:
> > - introduced Load Latency filtering capability.
> > - shows DTLB and page size information differently from prior generations.
> > 
> > Incorporate these changes into IBS kernel driver as well as perf tool.
> > Also include a perf unit-test to test IBS sample period constraints.
> > 
> > Patches are prepared on peterz/queue/perf/core (cffa473a06d2).
> 
> Ingo, Peter, gentle ping!

First 3 patches are in queue/perf/core, assuming the robots be happy,
I'll push it into tip/perf/core.


Thanks!
