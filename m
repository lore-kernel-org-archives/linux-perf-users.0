Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77B265CB0;
	Wed,  9 Apr 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208950; cv=none; b=LkEaDvvleie52nY4F4eChrfIHLDOgjcI0bGYCkSYtDx4Uu84kz5dlnGNuWgHc0+bfjO8bz+FGvjEvKAdvNLnW4FbvEo4FpjnhrrBlj5Qimfl8EeAqbhAdNfTRyC6yfqrcnMO035a0QcAe9Npxe4ezsseeY6VgNGPMhjOBYM9BDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208950; c=relaxed/simple;
	bh=n2ht8mjONbndvKewbWqCR1f/Qxe2MhaYKYQ8fab8Kck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h25Yw9/yxd+LRkxG3AGRHzORh9mkbtFI3ItDsTBHHC46iTzrS8MsJqGgRwLMha8gN2awodYg3FDU2ZJuO2sxkMz+CcW72l9+IjtKdWEjzxkhER4tdiDbArjuEkdM1TdJMyxlqvC03l6WVbxwXQ+aMDwLZUKm/nBmnl8nXzYVVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VUfZDKMh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUfZDKMh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GfxegZ0KYTJ8SeY85RB4SV1VMpClIouJSyJAqXohpDM=; b=VUfZDKMhsTtFBu6EgVZG5tJoim
	0nnQ8Cm4/YlWFxcQEeW39XR5+4L9v8zC95D6/xGnVxmqS2b5R26A3gUYFwlBuqNwUcFAs38t6+Znb
	ihm3rIKycq9g6+P+OdvQTdOjFwe/psZEp9Uuar1e6+p7B8orKVx0ZKvDqo8M1wyQwG06aPOMLrZ8g
	HzHUFO/rjAUDuZN+i+TcF8fPpHLnD7o4b/GhCKnUrDWaruTHCB9k70y7Dai2VDNp+NsDj/VjJhS4A
	iFww5vvFO5p2g/5TScvmN6KUNeyUd25lKzjpkDhsbt/mJohLP5r0PQgKGMaQxvRt20HVlJFAZMXw0
	VVT5zg4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2WQH-00000008dLA-0I5A;
	Wed, 09 Apr 2025 14:29:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9DAC03003FA; Wed,  9 Apr 2025 16:29:00 +0200 (CEST)
Date: Wed, 9 Apr 2025 16:29:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mark.barnett@arm.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] A mechanism for efficient support for
 per-function metrics
Message-ID: <20250409142900.GD9833@noisy.programming.kicks-ass.net>
References: <20250408171530.140858-1-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408171530.140858-1-mark.barnett@arm.com>

On Tue, Apr 08, 2025 at 06:15:25PM +0100, mark.barnett@arm.com wrote:

>     perf record -T --sample-cpu --call-graph fp,4 --user-callchains \
>         -k CLOCK_MONOTONIC_RAW \
>         -e '{cycles/period=999700,alt-period=300/,instructions,branch-misses,cache-references,cache-misses}:uS' \
>         benchmark 0 1

>     perf record -i -vvv -e '{cycles/period=999700,alt-period=300/,instructions}:uS' benchmark 0 1

Should be updated to read something like:

	cycles/period=1000000,hf-period=300/

right?

Also, cycles/freq=1000,hf-period=300/ should now also work, right?

Anyway, the kernel bits look good to me now (with the nits fixed), so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
