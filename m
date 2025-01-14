Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990E22DC34;
	Tue, 14 Jan 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850625; cv=none; b=jtZdg6gEqJm6Ah+sh2RktsEs2V4NdX0e+49RYx0cr2G10Q/XoSQKXkhz3fBrtcv5djn3Ec+sRoGaDFyaFXjAzK0Z+Af2sAXJU/iJcnOZ25CVRgH6c2y2MeTrJO0kTCDlzoCwoVXmJ6GsVWXF74+WpfxPC4CrNswd36IgqtiHpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850625; c=relaxed/simple;
	bh=q63dToz/mvfQrW44QuyDORWJo2vkBO0sAJ3dcuJDzYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCrGOMSyLXLEofMrxkCIJXoonZIV9Ab33YiM49RrC/1ywUQ8c2LP7wtKjlZvr+eJXhhicNQlcuz51gUZ2nxchTsfxlzKMDW/HNBpxzxfSSE8epoF2ozA1mn12ZL8iLcx/p4IGmLW/PXnXloCHybvPxT0fQnH4bnCFbjIBPQ2CeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aOeJU4Y9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOeJU4Y9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q63dToz/mvfQrW44QuyDORWJo2vkBO0sAJ3dcuJDzYQ=; b=aOeJU4Y9+Zi3K/aHzeU7LGhFeG
	vqgras9ckhNdNHaO0hDDx6eouRPvm2C5dYJZjrplLSDOioA4JYHP2ReHhJdelfLHcYhrfe3dw51NA
	qyEAped/3nosltnaDptNkn8JOvJk/Rck2HXlbzkxB7+b33yxQQ04hvJ3WzeqUcNd/rNccJKj6NSbu
	0QnqHp9ReaL+zDboRFXjqsPNQLkvkz6nkJTmqlOCaHZULnls+JJCMhBnKbYdpZz9NC7bldeda/Vzk
	82O6yHgQdHlon+bU/1m6UOeLyq9BSbabRUyiFw3ddb2n2dE8Hu9k4bOZCaE+9H0v8jAAa/DVkkawI
	if2uirfQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXeBc-0000000Dujo-18SH;
	Tue, 14 Jan 2025 10:30:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E0E13004DE; Tue, 14 Jan 2025 11:30:15 +0100 (CET)
Date: Tue, 14 Jan 2025 11:30:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V8 2/2] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20250114103015.GN5388@noisy.programming.kicks-ass.net>
References: <20250106142103.1735729-1-kan.liang@linux.intel.com>
 <20250106142103.1735729-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106142103.1735729-2-kan.liang@linux.intel.com>

On Mon, Jan 06, 2025 at 06:21:03AM -0800, kan.liang@linux.intel.com wrote:

> The current Linux perf sample read feature intends to read the counters
> of other member events when the leader event is overflowing.

This doesn't sound right. Any event in the group that has 'read_format &
FORMAT_GROUP' will read the entire group. There is absolutely nothing
leader specific here. Nor sampling for that matter, read() also works.

You can have 3 sampling events, all with FORMAT_GROUP on, with a
non-sampling leader.

Anyway, let me go read the code...


