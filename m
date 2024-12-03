Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776B1885A0;
	Tue,  3 Dec 2024 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263118; cv=none; b=qYsfFLCUWEBa8OHPJAizuyI/IMaeb4WNVjV4/QD+fWgPAHjBQUrzrOqU2WanASv8JHtBrOvXx/5arG/+JIeGZOXcBoK9xf6Jt4bn8OYkaQJz0HqPEWI3dm3FeV7RgBh8tKVi+S5qGsSfuZ4h6qaNTsBx81NevCY0Pk54FWrKuBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263118; c=relaxed/simple;
	bh=65uAzCJU6cU/BO3nc8fI6lel6FFXdMhK+xYX9hA6kpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RHS8oBLwaV3dOV/XhQ0LXqxMCNIzkOzZXf8Ks4GCZw5H1+uVjtNJQPtHUHArB2+qru6wjsDFPSPjO5e/VMK1zgYLpq9juSMUhiG8OSB3szEKLJu8QUUTSdI2Bf2HoFb7Y7XLJzjMAft1yWohAKTv8DZn7HWo8jbm9bdM6zhTfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFL1k7Le; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFL1k7Le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ACFC4CEDC;
	Tue,  3 Dec 2024 21:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733263118;
	bh=65uAzCJU6cU/BO3nc8fI6lel6FFXdMhK+xYX9hA6kpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VFL1k7Lex/H1slIDc3MRBsmpLtgYjNbAiNpITtCXtPKfT+qUEi31abQW3sDWZ+mB5
	 SSy2pqyjbE+is8flF/D74Uf1o3REXWhEvfqjhE3X9gG1WW+Ktc3cwQ+3uut/G5BVwX
	 vHsNuroWSx2+JaHFBj1Cx4uy7XyHBknUa+qwcpgwDzhsK7Q3/dYF+HR9XgJijZrkSz
	 fROcszkYvLxYyKB283WYVi6IzOAibng2/1kNjTA4w1Vnw8cyIDL6THqKCq6//tHm/X
	 cJWNPlwKx/g6rivDLed1QnvRtWr1EHHSp3IiNe7gcgIxMrw528JcPMW+outsbr56To
	 TFdryRJ2t6PdQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20241129151948.3199732-1-james.clark@linaro.org>
References: <20241129151948.3199732-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf test: Don't signal all processes on system when
 interrupting tests
Message-Id: <173326311805.2683269.12425210230530039581.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 13:58:38 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 29 Nov 2024 15:19:48 +0000, James Clark wrote:

> This signal handler loops over all tests on ctrl-C, but it's active
> while the test list is being constructed. process.pid is 0, then -1,
> then finally set to the child pid on fork. If the Ctrl-C is received
> during this point a kill(-1, SIGINT) can be sent which affects all
> processes.
> 
> Make sure the child has forked first before forwarding the signal. This
> can be reproduced with ctrl-C immediately after launching perf test
> which terminates the ssh connection.
> 
> [...]

Applied to perf-tools, thanks!

Best regards,
Namhyung

