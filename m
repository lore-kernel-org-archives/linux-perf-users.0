Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BF39D6D1;
	Wed, 20 May 2026 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313874; cv=none; b=a2Z3WK5O7hWElrrRMfNXW1U5yuP6NM7HtXUDZ3yUyWhdcoXeoEyaUZxGhyBw4OTuGmsTj9+0xmSoq0MH3ZKRBhdo8L6bkqhjVN2ZYWWr6ydbDhm2x+zGqeu1vEJ9JgO4yH3m+nd+v3EjenXpJikI5cUErmjdP3kqux5Srtx92so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313874; c=relaxed/simple;
	bh=0NXNWBCqZIw7E/AQBKSMu9e1tdd4Q1/jtyh6I20e7FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxVlUMSjXbgQxi6qVWUkQxUa8nXKaI/sloIns0vrtdsD12HvqbHCSgMSxgwepeAJkNFOm9DT37EyoaT0M5FagsTYs3lGvwN1Us+vz9u4vkp0I5smpenYCfYaO1//Dx1SFhva27f5tKfO6q7DBAq48eXCncknVF4bUyInTEzMMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2qcbzj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2qcbzj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801751F000E9;
	Wed, 20 May 2026 21:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779313873;
	bh=0NXNWBCqZIw7E/AQBKSMu9e1tdd4Q1/jtyh6I20e7FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F2qcbzj3ATkrmpfn85i77Kogl6gRDkS4hgbHrqiOU7+Tp9n37lZeOZnCSWiJqgRwP
	 QzAfUDBraGVi9o37IVHr6fVTY+CgLrbpdBG63iqxwAqT2wtY6lniNbhj9tcsXBPXa9
	 44sddx8nIDPCB7PgFbN4MzPg9f7g0pyflMdJFxhpF1exvNNs16v1eb+sSiOZcgupZN
	 NWYN4KPT88ceRoWqa2alDEw7cHIg2OegkVuLxbcr3wOyiokK2QT4CEz19q8IbZGgpz
	 gpLnilXUMUKyOmxL8nJPGkf383DHJ+V+AwOHNo2kANsqfb+pygRWU4O1aMp3LOMSCT
	 PfBq6GvBrXE6A==
Date: Wed, 20 May 2026 18:51:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
Message-ID: <ag4szmCZdWwqHR_R@x1>
References: <ag4PpWl-wV7SDpd5@x1>
 <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
 <ag4ecqF1PZg_u4Op@x1>
 <ag4e1BNQlZWVWISE@x1>
 <ag4f1iYyHdkpToXu@x1>
 <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>
 <ag4j-dzzaa2xMr4y@x1>
 <ag4kauWBogiPBhRh@x1>
 <CAP-5=fW5DbyqPJwxO87YQ4DC4bRnhXxCe93Fkdbr3RMjT8-AQw@mail.gmail.com>
 <ag4l42A5UJOR3tQz@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag4l42A5UJOR3tQz@x1>


Everything is at

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

I also rebased my perf.data validation (that has some extra fixes, because... Sashiko):

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-data-validation

I think I addressed some of your review comments, if bored, take a look,
I'll submit as soon as I get what is in tmp.perf-tools-next moved to
perf-tools-next which I plan/hope to do later today, after the container
build tests finish.

- Arnaldo
