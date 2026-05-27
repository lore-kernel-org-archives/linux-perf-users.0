Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D173F44D4;
	Wed, 27 May 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880542; cv=none; b=gUFRecIaGt2UVZ9gk1q9FBSMG2Htk14WQVwPZ2qz6BGyYdNxcoe6E4n5ok/dvq5VDE7H7AlKGI79byAaO1h4Nh1WhEwMpFMy7ilXHcYEHbIff+0e5EwftN+LmS1Q7czIrEWlNsBuqW50yjZcSFo5xQ8BtmuxOcAL4Iy+P6cHqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880542; c=relaxed/simple;
	bh=TKCXm3eA1bEeZ9b9oqhX4rMzWG99UALIg1F6/0R9nXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGIUmuG+rk2bSx/gOjcw8rXleHevkQ5SpW09FaiVqdXG+YvBcr6vhY/gvvk3ndE5qTACD52enJzQR4cdCPRSG5KKIOA8149PGmhnEWfqxLlhoQ/7A54daUMWfQTVEjSNG9tf/5E0Ri19iwbZL4XK4BxnYNTBU4ecJ3A3mJQMCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS3Du4Gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS3Du4Gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D321F000E9;
	Wed, 27 May 2026 11:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779880540;
	bh=M/8ugNHxGBDTMWF+tbKYQh2cRQhOiuIi+devoJ672Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XS3Du4GghL9AoeqxFkzu48agdcYbTzYKkXw4SA1CSG4go1gH8aQQrc8mMXS/Zp3nx
	 bQRhRJHQPJqDw/8djfoO0CAGvF3md1fqgquxMy7K1ncMveuUdPakfxZgd5OVSaBEx1
	 mMI/HDYvndE7PM/unaTJlVfNlIexwbz4ljRqEk6D3r0axYOmREUUKMp/7/Slgn04De
	 gpQDwughBWaBTrwVnnzYrqBqzw/K+ZWzqfxAwon/yJv9T5Q5dMn9w+R78Q+lh54Dw5
	 3mFf7WHHJys3A9G05jorFKCIfggHdpqrbqbRZP0Fm+PqaWM9BagJ+l/riGGRF7nqla
	 th+E0qF1Ey8Fg==
Date: Wed, 27 May 2026 08:15:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Rui Qi <qirui.001@bytedance.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf: Add is_ignored_kernel_symbol() for kernel
 symbol filtering
Message-ID: <ahbSWSMRlxhJUbz6@x1>
References: <20260507071103.2772577-1-qirui.001@bytedance.com>
 <20260522082604.89447-1-qirui.001@bytedance.com>
 <ahT_m5dG6rITpTNB@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahT_m5dG6rITpTNB@google.com>

On Mon, May 25, 2026 at 09:04:11PM -0500, Namhyung Kim wrote:
> Hello,
> 
> On Fri, May 22, 2026 at 04:26:02PM +0800, Rui Qi wrote:
> > The perf tool currently has ad-hoc logic to filter out ELF mapping
> > symbols scattered across multiple files. ARM, AArch64 and RISC-V each
> > have their own inline checks in dso__load_sym_internal(), and kallsym
> > processing has yet another check for ARM module symbols.
> > 
> > This patch series introduces a single is_ignored_kernel_symbol() inline
> > helper in symbol.h and converts the kernel symbol handling paths to use it.
> > The helper covers the existing "$" prefix used by ARM, AArch64 and RISC-V,
> > and also adds the x86 local symbol prefixes so that perf stays consistent
> > with the kernel's own is_mapping_symbol() logic.
> > 
> > Changes in v4:
> >   - Rename the helper from is_mapping_symbol() to is_ignored_kernel_symbol()
> >     to make its purpose clearer.
> >   - Split the single patch into two logical patches:
> >     - Patch 1 introduces the helper and applies it to kallsyms and ksymbol events.
> >     - Patch 2 applies the helper to the ELF loading path for kernel DSOs.
> > 
> > Link (v3): https://lore.kernel.org/all/20260507071103.2772577-1-qirui.001@bytedance.com/
> > 
> > Changes in v3:
> >   - Add is_mapping_symbol() check for kernel modules in dso__load_sym_internal()
> >   - Add is_mapping_symbol() check in machine__process_ksymbol_unregister()
> > 
> > Link (v2): https://lore.kernel.org/all/20260506073820.2419087-1-qirui.001@bytedance.com/
> > 
> > Changes in v2:
> >   - Only apply is_mapping_symbol() filtering to kernel symbols (kallsyms
> >     and ksymbol events), not to user-space symbols from ELF files,
> >     BFD libraries, or perf map files.  This avoids incorrectly
> >     discarding valid user-space function names that start with '$',
> >     which is a legal character in identifiers for many languages
> >     (e.g., Java, Scala) and compilers (GCC).
> >   - Move the mapping symbol check in machine__process_ksymbol_register()
> >     to the beginning of the function, before any map/dso allocation
> >     or insertion, to avoid leaving empty maps in the kernel map tree.
> > 
> > Link (v1): https://lore.kernel.org/all/20260504090609.1801880-1-qirui.001@bytedance.com/
> > 
> > Rui Qi (2):
> >   perf: Extract is_ignored_kernel_symbol() for kernel mapping symbol
> >     filtering
> >   perf: Apply is_ignored_kernel_symbol() filter in ELF loading path for
> >     kernel DSOs
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

