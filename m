Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C5826D4E5;
	Mon, 13 Jul 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966513; cv=none; b=PjuyWk9zqyeLCCGxqWXlsSxhHdfubtKEkNv+ebiQk5ffxPLk/k9mdAXYntyQGI5SVtkAhRhY9fUbqpzQJFoyJqRapjWC0jtUMVcC/6Rw37XvidOUoNJyt/x2YX4rM9yZyP9Zsvl/PrjgI7panzR9b8O8xERg2H18lRJb1Pt22g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966513; c=relaxed/simple;
	bh=y1jBZKNYrBX8kR1+2Jhl4nZ/OL0rZMX6I8ODg5m2G/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+jewqT5dEYbbdHXw6oF/keFm7c4NDBd6tE1QYT7lTCAkzMxZDKe73TSc+s7tnlkHIck0AHmcnfVrCPM7ZXMEzAH1QAHra+fK03nZtWaaNIigJNTNulqSlFkXDfOe98NiHugwPN3+JhUChPJElfwjtDCgkLzhrsrOzwbukEwzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CTpOJb8m; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CTpOJb8m"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D8C1570;
	Mon, 13 Jul 2026 11:15:06 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285AB3F7B4;
	Mon, 13 Jul 2026 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783966510; bh=y1jBZKNYrBX8kR1+2Jhl4nZ/OL0rZMX6I8ODg5m2G/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTpOJb8m0qsP9YSviwLg+x8qEZ7AI2UsEf6PBN8I+o8MrgxFXqabdnNP0JVZjvUFG
	 yo3zAFoJqgQqdATUdPKkIIP28N+sqi3lv2lyJcWuqQ6AdBLk22qDTrO+5Z0BVrAUvU
	 42n+tFlxd+MIocAYfPvnrVkl766/QPzW7oSfdmuw=
Date: Mon, 13 Jul 2026 19:15:07 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Trevor Allison <tallison@redhat.com>
Subject: Re: [PATCH] perf build: Do not pass -static to dlfilters
Message-ID: <20260713181507.GB512733@e132581.arm.com>
References: <20260707000357.823509-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707000357.823509-1-namhyung@kernel.org>

On Mon, Jul 06, 2026 at 05:03:57PM -0700, Namhyung Kim wrote:
> The recent commit caused a failure in make build-test for static builds.
> Let's not pass -static the option to dlfilters which is dynamically
> loaded as it's hard-coded with -shared even for static builds.
> 
> Fixes: e1065ed188cf ("perf build: Add LDFLAGS to dlfilters .so link")
> Cc: Trevor Allison <tallison@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Leo Yan <leo.yan@arm.com>
