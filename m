Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7194EF12B;
	Mon, 28 Sep 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613287; cv=none; b=sC0W6W0e5fjKKs4oT5qnuHs7F0xmomFyfPzx1co5HvNfHoElAwJwbsPJX5FzYOjcxcbcL7pY7CyFyalr12wc22JTjtyOjMyVhmRYD2a3DMjYYdUeSkSvdRUrU1AaGOIN6p/Fa1IOk1MCcHdkeMXbrdlp+JgjidXI6eiBxw1gSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613287; c=relaxed/simple;
	bh=obZsD+FWW3oqDzsoLNMqpqUaAsf4d521DemQEYwhIjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb8qnp1rBm509N1VZWhes3VPXCTVFWZK7FLlMoFSKaJQPS86BtYMULXbSAKq7/aJEGzMuxfdnvoDOuXI37Kdi0gcvv947zXL9ipnfTY3VTRpYVxNBKXHiBnwp/IIm2cTvQVSnHfGdRjAv2OJ+scGA9jZg++DpLvHZVGm1dcikZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PI/8/8J8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PI/8/8J8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BAD11655;
	Mon, 28 Sep 2026 09:34:41 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01ED3F86F;
	Mon, 28 Sep 2026 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790613285; bh=obZsD+FWW3oqDzsoLNMqpqUaAsf4d521DemQEYwhIjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PI/8/8J8yrQrFMZmzJQgn4uZ6EucWfJXdonIN5VW9GDb+Fl2Ed+/YbTA2ld8DpBf6
	 xLBfyPEJBbn/pxoChCazWY6CLeHsF/yzNHXbn5zE7xL1YPzyxKpyvvkRvpJYQ9M3WJ
	 BaknA+7RpTNlK65eSpRK9TeSihlbN9KXV2idnFZk=
Date: Mon, 28 Sep 2026 17:34:42 +0100
From: Leo Yan <leo.yan@arm.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, john.g.garry@oracle.com, will@kernel.org,
	mike.leach@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	guoren@kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tsc: Replace the compile-time TSC support check
 with a weak hook
Message-ID: <20260928163442.GG14479@e132581.arm.com>
References: <20260928094739.2605-1-cp0613@linux.alibaba.com>
 <20260928094739.2605-3-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928094739.2605-3-cp0613@linux.alibaba.com>

On Mon, Sep 28, 2026 at 05:47:39PM +0800, Chen Pei wrote:

[...]

> Add a weak arch__rdtsc_supported() next to the weak rdtsc(), let the
> test query it instead of the macros, and have x86, arm64 and riscv
> override it in the file where they implement rdtsc().

The patch itself is fine for me.

Just a bit on refactoring. You could refer to the implementation of
PERF_HAVE_JITDUMP in arch Makefile and "CFLAGS += -DHAVE_JITDUMP" and
do similiar thing for rdtsc.

Seems to me, we can just use build system for configurations.

Thanks,
Leo
