Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E21E9B2A;
	Mon, 20 Jan 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397613; cv=none; b=P+IYEoATqQG7iAsDakCw2HjCbvJAs3EHuODEft+IeRJTMx/H+jd21qPphqchUeTAoY7i9UaXFhZqWiq3eiAhym6oJ7V8h4IbIxNRn5/R4OjGP9sWH+HhTRe99F8YIEaCKp+er03h1p9EQeajm1sPr7/OSRHjk82HnAm+hpQQYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397613; c=relaxed/simple;
	bh=Q/fcUq+Z2zKVTrBPFTtMg7IuhExPLXL6+eWlvIZevhU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ox4+5lQbKDZnhCIMRXsSUhiOviIyAfVZTCxBGTxzHEIRxW2nyRN95ayUgFD7JL8mPw68LQHChyWwKP4YipTJ6Yx1L56vG+3npiZdPWa6smuKgbC6AAGUuheh9MPCwxOPDOpR2HLWiQkLMFTVsx2KHYDbbdipAAVhyUNIFH9EKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyG4m2Uc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyG4m2Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B9DC4CEDD;
	Mon, 20 Jan 2025 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737397612;
	bh=Q/fcUq+Z2zKVTrBPFTtMg7IuhExPLXL6+eWlvIZevhU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=IyG4m2UcOHcTRlA1fo6RHGP595iOJYAa+KL2G8j0N65oI87Vf/bXbUIqfnf54bmal
	 hGvIh65KFHnm+qdk6d8o7ctVxsUNx2ZzzI9pwE0Y8z6RKvzOgNJWx0cshtHDJosrvm
	 tnzwUXvcqCZfO9sb6/HynFB8wzeov4GIvVz3UuNBbH7/4Z6SZKo44KQIXd7WVE4K2/
	 ygJYltcWmAxlPbK3sKqXm92Wb1iG+pKsOt4aeUBe4XZ+4SP6U+OrdEc7Ws90eS+XbU
	 t1mcP3R9rPzglBIKi2LIzwJaEzmf1nuK6N4pQYLEZY+FudhJdu6zIBzlAd5tmTBe6j
	 epjeu5KZeCW1A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Chen Ni <nichen@iscas.ac.cn>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250117181848.690474-1-irogers@google.com>
References: <20250117181848.690474-1-irogers@google.com>
Subject: Re: [PATCH v3] perf annotate: Prefer passing evsel to
 evsel->core.idx
Message-Id: <173739761245.3950752.18015295807257633517.b4-ty@kernel.org>
Date: Mon, 20 Jan 2025 10:26:52 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 17 Jan 2025 10:18:48 -0800, Ian Rogers wrote:

> An evsel idx may not be stable due to sorting, evlist removal,
> etc. Try to reduce it being part of APIs by explicitly passing the
> evsel in annotate code. Internally the code just reads evsel->core.idx
> so behavior is unchanged.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

