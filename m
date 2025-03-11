Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC117260364;
	Tue, 11 Mar 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709507; cv=none; b=M8XjCeYSNl0+A6r6RrLYp0srabkgTwnQ6dsEw3NCEbB5KMPi0ErZKOUL7FohKNicXFF8bizG4xYinml3a4G/zlkba8eJEVg73uNo2Sa7CjWQI0k59J4vBHMwIADgCZg5LZLujPemlmselidIWtBJQAqbiNsszj/Mx5Cuesa+eZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709507; c=relaxed/simple;
	bh=OCFRy93g88m4ra4SDHEq0xudVlXvg1kpUq6cKBZ+NEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HqNufADO+O+u8ZDLJXfFU2CSeErRFPrg6SUA2nvtTqlHWa4j35mBf6UcTCkHec+yO5RLHgtY7iXS/O4guxPIz+aBYP8/OzYq69+IBNCznutfsHE9K44QQKtn2xZvOoMOfxPLJdb9l/3CgDNgbR0VXgEN1ggPTN8Fi7pZxUTUcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/3+vyJ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/3+vyJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA5CC4CEEA;
	Tue, 11 Mar 2025 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709507;
	bh=OCFRy93g88m4ra4SDHEq0xudVlXvg1kpUq6cKBZ+NEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s/3+vyJ9m0XspkpsPXH6pMIh56UeHAryJmni/XnJF83Yq/I/+Ti/4QRYDI3z47wRo
	 4J+c6MSPuPQCcCwdgnb4HCX7IVKydCnybuJiyQeqbFodY0QD1mL8rs2kia6DPU32ln
	 cCmlvvJlcqvU8wvLi1S8BRG2tJvXvM0Ljb92c/sdVsi1EahaeRQerzacqIzq6L3bWo
	 mIsneSMwEUexCqcOk7jvYz7hqtgUAfdQSVL7037QSjFIwZKwPzdfrBYq15TKLfBeW1
	 eZBjoF2bchSsWTdAawOa7JdkyPBpTVH9KBPIoQuDR8RFeNc1zIlmvIaIdR3Bleow3j
	 Ybp4yCGnMgFDg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
 linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
References: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v3 0/3] Support .gnu_debugdata for symbols in perf
Message-Id: <174170950714.2288726.12218368681417551780.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 09:11:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 07 Mar 2025 15:22:00 -0800, Stephen Brennan wrote:
> This series adds the ability to read symbols from the ".gnu_debugdata" section
> of DSOs. More details are the cover letter of v1. This only has one small change
> from v2: it adds the missing entry in dso__symtab_origin(). Its lack resulted in
> truncating the output of symbols in "perf report -v" -- thanks to Arnaldo for
> testing and catching that.
> 
> v2: https://lore.kernel.org/linux-perf-users/20250220185512.3357820-1-stephen.s.brennan@oracle.com/
> v1: https://lore.kernel.org/linux-perf-users/20250213190542.3249050-1-stephen.s.brennan@oracle.com/
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


