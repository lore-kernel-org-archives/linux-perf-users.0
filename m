Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E834AB06;
	Thu,  4 Dec 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875452; cv=none; b=Mh4onrQY+AbWqLjrfjGlPuoEWDAOZFouM9HgNg3ed9ugwPqyYk0Xe9FE1FPN9Dm0g1yFPa3QowRT9y3oz5sg5tStkQmFJUUzLXR1ouVrUGkNXWQt5sbilp6xbtOhDaoCwZxjSRj9zZ2OjuNg1FRrLaCJ78O7ZtB2Jczevfpk6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875452; c=relaxed/simple;
	bh=SEEI08sTcE+M9GCu4jYIFFinRsXOfr5EWBdLhOarA5c=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jwWqBwVF8dxOUCbrffn1bzMLBaP4FlNjBeaaWnPHzk3OUflJDnpXA9vmftiZs4NpGqjWPkzAgiN4V3/FJQvSdtYcAeBFlbari70cgFNzj8W1FL9iFhsYHh6SnTA/ETuLLNaYzSFWzJH/oYiTO+iPNjWltNlKTnZLObpoD5WmWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNNJ5RWe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNNJ5RWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5F2C116C6;
	Thu,  4 Dec 2025 19:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764875451;
	bh=SEEI08sTcE+M9GCu4jYIFFinRsXOfr5EWBdLhOarA5c=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=bNNJ5RWeMSBzO8pKTTp/qR66SaxGDSpt8TpEEu0wvkKVkkUVn3gX4VL9GWanm4n0J
	 OhLsdTgYu4Qzc/VNLqeefqpSu1s0bkXGp/X6CnGIc9djkMkUN84AelL8GJiBhJkE5G
	 B3yOVXmNqn1BAl1k2F6UfRLuVJFbvJa+4AmCFS2Z6rwjEowqqnoA3YpU3I51mC9u18
	 3dvlrICyoNAGSzDfiQc7PWrMVezQcj0JZtRP10sAlHr9W4fFZfJf2cuJPhOR8NyYBI
	 a3rqeiN5SzDfI2uOpROaEzXz5GqdaMABlhm6P+V0rP7aWI3Ozwie7Z76F7p+pRiVXa
	 KsPRIiNdUpMbA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
References: <20251203214706.112174-1-irogers@google.com>
Subject: Re: [PATCH v2 0/7] Perf stat --null/offline CPU segv related
 fixes/tests
Message-Id: <176487545073.182574.11916635182102768588.b4-ty@kernel.org>
Date: Thu, 04 Dec 2025 11:10:50 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 03 Dec 2025 13:46:59 -0800, Ian Rogers wrote:
> Ingo reported [1] that `perf stat --null` was segfaulting. Fix the
> underlying issue and add a test to the "perf stat tests". Do some
> related fixing/cleanup in the perf util cpumap code.
> 
> Thomas reported an issue fixed by the same patches [2] but caused by
> giving perf stat an offline CPU. Add test coverage for that and
> improve the "error" message that reports "success".
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


