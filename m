Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CF253F35;
	Fri, 25 Jul 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469330; cv=none; b=hkLS1mVakRGzUZVx9HZ0Fy+ihnRxBJ1VdZHZVHf1UBRfiqldlIWW/J8C8NhQDkjSMEUEc15rBsL7SP7aL9MXozP3oOUhCXObf2lMNA7r6ZhkPC04eQODKGwqcEOeYzYrAnCuATOk7Ng+5iFmP35NSzYRydsoKXtpVHdFSTfM0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469330; c=relaxed/simple;
	bh=7tOp4fhmXYOed6wTXikc7Qq+hhnuSNnnTFWaPgPPAuc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LmiBIojVmn9oQuGXatRiK0K7JCiTDlfJfGSjwt7w6WM0/pyybUYxZ22KhorEpyXHXWg0XoKsRnhE7FlvbfD5ph7mrhiSl+rmNdUOxrHh5PNz5Fp/Dkny35Fo6tazZgcw3fY3xtRcgFl3AfQkG/fxaqNdnd3r6kZMv/xU9liRguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOQMBn7Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOQMBn7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74BFC4CEF4;
	Fri, 25 Jul 2025 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469330;
	bh=7tOp4fhmXYOed6wTXikc7Qq+hhnuSNnnTFWaPgPPAuc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=oOQMBn7QMiN2zZgAHmvQaWAYGZlC7k8Tsdg0KsU9VagTl9cI7NMEuIAYlGkmupQ6h
	 tRkTBooIHb6lQkDfq1DcRnf2rXW1pY2SretlYXN0a167G3fGFMB9tuyRci5ge7UfZO
	 UcPGX9c8ZkWW1jcuMcj/Skw4BCFU9rcIdHIqsl6EyDEBU8sp9WZmhpZVUDhi4/9sM2
	 GnfQc3NfC+BUm4CyPUdF7k9FFsCZ4YJIizjzSKYLwdsQNoQ+x7SjRTCH5epe0hOxPJ
	 NQEY7zamrreD/uxamedjUMG4V0bD8c29OPDmg8PVafC6CCVTMMn0t+AdBiBgOorCQ+
	 5ONGKeUOL4jbA==
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@linaro.org>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250719030517.1990983-1-irogers@google.com>
References: <20250719030517.1990983-1-irogers@google.com>
Subject: Re: [PATCH v3 00/15] Fixes for Intel TMA, particularly for hybrid
Message-Id: <175346932984.1444596.3658930443325277654.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 11:48:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 18 Jul 2025 20:05:02 -0700, Ian Rogers wrote:
> On hybrid systems some PMUs apply to all core types, particularly for
> metrics the msr PMU and the tsc event. The metrics often only want the
> values of the counter for their specific core type. These patches
> allow the cpu term in an event to give a PMU name to take the cpumask
> from. For example:
> 
>   $ perf stat -e msr/tsc,cpu=cpu_atom/ ...
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


