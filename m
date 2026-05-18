Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16A19ABC6;
	Mon, 18 May 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116779; cv=none; b=bNv7pwZrTUN1PwBEthfP4L+qws9jqPYSTCG8Hyxe/YPSRMneBXetPy6QpF1PqBHbKxOyOafVfOnBe+MPcZqkeahDp6O1MHecvfz9QYlBn9zjEV3tsZO06QvVHvXXSgzo+3gAFsGdhxtzKF3BRl4VEHCg0lth2yan94dWLYc3qyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116779; c=relaxed/simple;
	bh=lATa/r0ZFjw8qqV79/ZQNsUYTNfLU6ueO04eOm44xtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3AkOvMXfGzJ0cPxh88DXmKwo/ONU6pBfhO8NAZxfWO+gIqO+/98OEAWzZ/UmphHdGco4qOX4wr6PsEW+JhPUzDVCdQpF0lAvSHG/a8sJh6515QZ2ZitxuC9kVSZOutBDRL4px0ZyT25c7MxNueGu0bxyWq7ItfsKM0aIIB4vtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDSQU9Ik; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDSQU9Ik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00FDC2BCB8;
	Mon, 18 May 2026 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779116779;
	bh=lATa/r0ZFjw8qqV79/ZQNsUYTNfLU6ueO04eOm44xtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDSQU9Ik86VcwMW+OHuD9X8bUcZFMKMi5POlmSn6wCAMje+cG2xN9F5ScxYbZ44Wz
	 IFSgolBsUDPX5yCAVN4Se9swKebpvd/NiVca7o8l8Ru8zBQm3lGzeTrDvhl9HEHIil
	 VvznJgGdhRxmZIclUhXK9+bk1u+8EJO8A9rs3SHaKyaW7qNV/hMp9ufWvBtxT9NxOx
	 djFk5yVSGOaKK2yhfahm434KPsSj44fYqB5YmENPlsA5Ab2WhGF8ilxVvKfiFE7cNH
	 aLFKwscgEhqU6fenL2wkSK3V2ILiu+3H7S+ug519nIDIEpnLHgdxW1G6h3uhyO0Ks6
	 TLr9QYkQuPAeA==
Date: Mon, 18 May 2026 16:06:11 +0100
From: Will Deacon <will@kernel.org>
To: Fredrik Markstrom <fredrik.markstrom@est.tech>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Ivar Holmqvist <ivar.holmqvist@est.tech>,
	Malin Jonsson <malin.jonsson@est.tech>
Subject: Re: [PATCH v2 0/3] arm64: perf: Skip device memory during user
 callchain unwinding
Message-ID: <agsq4wZMGth-T3BG@willie-the-truck>
References: <20260430-master-with-pfix-v3-v2-0-bd526ec04a75@est.tech>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-master-with-pfix-v3-v2-0-bd526ec04a75@est.tech>

On Thu, Apr 30, 2026 at 12:55:12PM +0200, Fredrik Markstrom wrote:
> Perf callchain unwinding follows userspace frame pointers via
> copy_from_user. A corrupted or malicious frame pointer can point
> into device I/O memory mapped into the process (e.g. via UIO or
> /dev/mem), causing the kernel to read from MMIO regions in PMU
> interrupt context. Such reads can have side effects on hardware
> (clearing status registers, advancing FIFOs, triggering DMA) and
> on arm64 can produce a synchronous external abort that panics the
> kernel.

Hmm, but why is unwinding special in this case? If userspace has access
to sensitive MMIO/device mappings, it can presumably pass them to
syscalls and trigger crashes all over the place?

Will
