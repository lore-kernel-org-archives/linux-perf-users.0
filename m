Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB8199BC;
	Thu,  2 Oct 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429859; cv=none; b=t3jV5LFW/ipiVRtfYUK/V/vDwH5h8x0XvwnUtrViPY5kz/9KnsJN9qLwK9gRtCKci1VQu9dI9SunyFC+mUvLztpCeTAwJ1NRJHNfdOF8Sd5S94iqZQecjtByZzh6XQme5Nr1mL3Mq9VQ4gB7FwsrHNvrSB8/d1vlCkd+TLt9ZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429859; c=relaxed/simple;
	bh=TPmUtaOmhEOtnyz7HwVCcESys30sYI5R1LXkxDooksY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZiSCcNepCSu14XyKM/zNoUhGb6MzZZWxnHqaT27NvIGUZY1CWWjwYUhosly+YRMvixqVaoSi6jl8z7iZj6PnAc+2feQ2LCVlhPQtwpY+trDrLS5JGEhZhJIKOLKyS+H2+HXjrpfR9ty7N6paF+BsiMrZtUvzig3XxWyhx4MDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQwcoa/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQwcoa/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BB8C4CEF4;
	Thu,  2 Oct 2025 18:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759429858;
	bh=TPmUtaOmhEOtnyz7HwVCcESys30sYI5R1LXkxDooksY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQwcoa/LMBvcoRrils/3zNGpoLA6Q+OpFPwkMSDqGPO9Uc3vlUcwlJUNpXz0C97l7
	 4k9yECUbhC0x4toJWC8tdTQgognBMEZnL0x7nYrpqyOl/8zL3BEOU62XGCYz+DPIUg
	 PRBlfD/0PBBMdjhejkWNX31SQ+EYDEBWaqMdQybB8hpk/x+MjvUUmBwDBSIdWFjMCs
	 CoIiSoWFSvSqgavLfZ1fL4MjuVE0xe/pKN+iSTExlhNXMKseYyRAC580Qe9UQNfUXS
	 6bx7CbEHhEOQJ3N68ef8czo8XbifjDIyr9v3KyNR5qlBb13SYYrWv3vgIvdo3Oekmj
	 VHZjMVjVqTiOg==
Date: Thu, 2 Oct 2025 15:30:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 0/6] Perf kvm commands bug fix
Message-ID: <aN7E3wnC4tZ8jenN@x1>
References: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>

On Fri, Sep 19, 2025 at 10:16:53AM +0800, Dapeng Mi wrote:
> This patch-set fixes perf kvm commands issues, like missed memory
> allocation check/free, out of range memory access and especially the
> issue that fails to sample guest with "perf kvm record/top" commands on
> Intel platforms.
> 
> Since the change "KVM: x86/pmu: Add basic support to enable guest PEBS
>  via DS"[1] starts, host loses the capability to sample guest with PEBS
> since all PEBS related MSRs are switched to guest value after vm-entry,
> like IA32_DS_AREA MSR is switched to guest GVA at vm-entry. This leads
> to PEBS events can't be used to sample guest by host, otherwise no guest
> PEBS records can be really sampled. The patches 5-6/6 fix this issue by
> using "cycles" event instead of PEBS event "cycles:P" to sample guest on
> Intel platforms.
> 
> Changes:
>   v2 -> v3:
>   * Correct the fixes tag in patch 5-6/6.
>   * Add "acked-by" tag from Namhyung.
> 

Thanks, applied to perf-tools-next,

- Arnaldo
