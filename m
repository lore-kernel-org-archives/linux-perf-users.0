Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD331C7B62;
	Wed, 22 Jan 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584075; cv=none; b=rdhn60hRkmq7pWU/m8bhvrtJ3bkTl37gdXIdW1eRqFStxx9LCfpQ8sTnFRUh3EVgKrApRHztb1sFNYyV0PPbWE6XAZnAD0hTNP6GX5cQaHF8Aayimo6t1xiXTitVHAGbal1TZWwFrCVKE3Yf0Saj0z2Vi3/VJYD6X82DrNiH77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584075; c=relaxed/simple;
	bh=wNx+xKmh5ZkvXW2oGFzqRnpoaQpNc6b/iXxd9FQrR8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfqX6W9adGYELhcF33wDGABsqY8BRzGsLb6UHLYRYVmp+qK7WDMb2cEZ80hO081h0epcOsnANR2PBGososRB84JDaXrQS3RUMWtHMObXPh2d7zts7kqCqpxjST9bH5m3vi5NNOXtxzkItszpGFkbtOT4Bvdn5xwp+F5Dw2BHmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHCeAnfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHCeAnfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5321DC4CED2;
	Wed, 22 Jan 2025 22:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737584073;
	bh=wNx+xKmh5ZkvXW2oGFzqRnpoaQpNc6b/iXxd9FQrR8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHCeAnfMcAc0enMt1PmTZu4JK2S5rg5PWxNzmjqZbMhILAiVZZTcJDWA4N7oFk28h
	 SPK36tUAKjqUWqYVojruexksgiuxdn46RDYqN/yMiK420YRCETt+C6B6Ky6f/iEJjZ
	 vBBhKHxR3v4VA9qrR+T3Tz4kToK3hAsU3Faiw8ebvGHCnsH/E2KHmEYlZVRqf265n3
	 6MaICNna+qk2c3FQkGZMZacJwKOlawgJr+nrQTQosDsuxUJwcbbtgz4pUcVPG95T0N
	 R0SenjQ0v/oS6m0hWUWDnHYaLhjDID9nvrucLsnb4F8+BqtVBdCd8VipSI/eDEydDh
	 aG1YUX3+E59tg==
Date: Wed, 22 Jan 2025 14:14:30 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 02/39] task_work: Fix TWA_NMI_CURRENT race with
 __schedule()
Message-ID: <20250122221430.jfnleewvjj3mcbif@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <ad5fb696fbcd276c0902dbb94baa75fb79a6e1e2.1737511963.git.jpoimboe@kernel.org>
 <20250122124228.GO7145@noisy.programming.kicks-ass.net>
 <20250122210339.i6sehdw4ddzqyy5h@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122210339.i6sehdw4ddzqyy5h@jpoimboe>

On Wed, Jan 22, 2025 at 01:03:42PM -0800, Josh Poimboeuf wrote:
> The self-IPI is only needed when the NMI happened in user space, right?
> Would it make sense to have an optimized version of that?

Actually, maybe not, that could be tricky if the NMI hits in the kernel
after task work runs.

-- 
Josh
