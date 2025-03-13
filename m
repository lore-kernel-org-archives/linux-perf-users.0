Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852701F37C5;
	Thu, 13 Mar 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895397; cv=none; b=a32fKNLX5CISRsYSmgWMgxBp3aMtRQjmtUy6ECefRnepW9Hm4rESWdwf7Vd7hBvN96BrjcEdc270zdxshM0Eh3MjNADjOgVzEHoO/Whwx1LHMs3NdaycEwCgK8LPn1qqQliRH7m6rzbCkf0r2MSzDuo3JDdmRK6mgcnBvDy93WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895397; c=relaxed/simple;
	bh=1YzttVdgq5+u/AxQqAkYwqXrSltdtIta8g7Z1gi1D7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBrpVuvLklnxTD3hD65V28ZCOE4+VmrOJgQT/EoImT5mLRP8HJuwYm5V76gepOdlyMZ+X7stUkfviE4uZeqBE8ZySrZKD8pYbmCKKzqXB9iThV7ySHqDuGqkP07eL8+ifPWFmaPuzMSSi0aV8wdDP0uNhDg/gAIK/oMqGTgZs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sULZwX4M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sULZwX4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B689C4CEDD;
	Thu, 13 Mar 2025 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741895397;
	bh=1YzttVdgq5+u/AxQqAkYwqXrSltdtIta8g7Z1gi1D7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sULZwX4M9PKSa6466D2DlJy9Ip5EDhLUq3A+vikUkMXgbPAbUADuC0zYvMNa/J5hI
	 ANX71yDtpuvLBG1JLsO1eBBmLyNJ3QhMfPHYihDswsplsww5D8g/hRk9MVDJFruNDh
	 TKchTZNrBsyZPqoP+v73Ve816VsA3QcgpeTN61AjnsDTeAc03sbCicEmw/AGgfPeH6
	 bUWc7s2FFp1AItmGx9XZtnXchwZwzoN0TH2HTD/5gykb/kYMsr9bJHQa51u7BALMOG
	 UGHTFeUtqsvBkYBzCZ9+TmpBU4yRgh9YDAyj2Q0K0iUWpJdP8RkF1bAMB2FI5GveKm
	 OMlowBU3ZUT9g==
Date: Thu, 13 Mar 2025 16:49:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	guoren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 00/11] perf: Support multiple system call tables in
 the build
Message-ID: <Z9M24AJzui9lFbGo@x1>
References: <20250308003209.234114-1-irogers@google.com>
 <Z9KFLGpenwOP32q3@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9KFLGpenwOP32q3@google.com>

On Thu, Mar 13, 2025 at 12:11:40AM -0700, Namhyung Kim wrote:
> On Fri, Mar 07, 2025 at 04:31:58PM -0800, Ian Rogers wrote:
> > This work builds on the clean up of system call tables and removal of
> > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > 
> > The system call table in perf trace is used to map system call numbers
> > to names and vice versa. Prior to these changes, a single table
> > matching the perf binary's build was present. The table would be
> > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > perf, the names and numbers wouldn't match.
> > 
> > Change the build so that a single system call file is built and the
> > potentially multiple tables are identifiable from the ELF machine type
> > of the process being examined. To determine the ELF machine type, the
> > executable's maps are searched and the associated DSOs ELF headers are
> > read. When this fails and when live, /proc/pid/exe's ELF header is
> > read. Fallback to using the perf's binary type when unknown.
> 
> Now it works well for me!

Its working for me on x86_64 as well, I'm doing some more tests, the
container builds and will do 32-bit tracing on 64-bit ARM (rpi5 aarch64)
and then report results here, should be later today as the default
kernel for the rpi5 doesn't come with CONFIG_FTRACE_SYSCALLS=y and BTF,
so building one with it.

- Arnaldo
