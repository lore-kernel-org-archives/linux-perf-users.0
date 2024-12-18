Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364B1DDC2A;
	Wed, 18 Dec 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539575; cv=none; b=kTcGzeEcZbjUQatgwOcHJcFrOA9Z/f07b0yKUK5HTqSybLmMPxECxE9sMuhOVbepZfH3pGTek73nybi0Z9+VKLZ+gTO7dBAfxt1MuVuZwRsuIW9xHoyOwP7DP7Cwy5slZZbqNI09Cv4U6aCiH5s4Qn2fpYm518fByy6PuOzacl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539575; c=relaxed/simple;
	bh=HboskYK+twKMIoWiBKmOPgWeAx/KnSQNDJYRdga95HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/8SczCReXd1nTSGr8qxaNWt9hjPC/2WjRd1HoBvBxDL4FE6gFZOdE5nk1V7xaUYkY9cp1I7qP1pxcEvMySlURjtoGlSR/PIYTJKAozlj707SI+Opgc6ZbWdsQuYozVNIa3LkPFK9URr+hkbEtdFryIVO2pY/xro2K4Y7dyt51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fquRtZMX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fquRtZMX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4YGdBzqD0oh0KvL5ZvD/0KtuEPmkk1BFxKeIfr5dcUY=; b=fquRtZMX5qv4uOxGK55m8Bslkl
	w7zbI63YUZKDYDmMOmoevA3tLnsy18acW7fi8i08HcZtAWh19lLVnqvLTRekMEcnx8xezpqJcbo83
	ETWkW3gD5wacC3daiLt9pRtsAuWuQMdtGOes9GhLhWPJ/l5IlLuqARDLVbLdeoDfhvmRDWhGAttDX
	iEGCv8FLCmpl67dnhXAxyG5Roig1tC27DWVRu1dfYcfylaeUvd+GLh4ytFMiueymJdW/IcKBTD74K
	N4QmXDzYP1QshGy9d5RmSNuP74Rb2BlgWm4npx9CsHiZAKhR5Il6ZFXuoc8N559h+IUwLnNrYDlgc
	C0UUnqQw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNwyf-00000000H9u-2rxF;
	Wed, 18 Dec 2024 16:32:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DED0230031E; Wed, 18 Dec 2024 17:32:49 +0100 (CET)
Date: Wed, 18 Dec 2024 17:32:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V6 3/3] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20241218163249.GI2354@noisy.programming.kicks-ass.net>
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
 <20241218151643.1031659-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218151643.1031659-3-kan.liang@linux.intel.com>

On Wed, Dec 18, 2024 at 07:16:43AM -0800, kan.liang@linux.intel.com wrote:

> To prevent the case that a PEBS record value might be in the past
> relative to what is already in the event, perf always stops the PMU and
> drains the PEBS buffer before updating the corresponding event->count.

Like I wrote here:

  https://lkml.kernel.org/r/20241218082404.GI11133@noisy.programming.kicks-ass.net

I don't think this is sufficient.
