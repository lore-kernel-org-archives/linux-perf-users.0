Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A87155359;
	Wed, 18 Dec 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550075; cv=none; b=EBU3pv0ay4FsDn0qCpkugUyS829QsFIf5ny9s0d7Liha6kKt3+iFaxU07UnttR6PDyNpug3jl5gmcbH7dboUKLdkAQTZw7cV6/glr29bs/R94eVZ06F0A9mPvL6QHL7WEQtEPn0uaBlhZOkKZYfJPwL8oFc2iX47RdU0aL0IkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550075; c=relaxed/simple;
	bh=bW5jd46BzKi8BD19ji+u1O741bs/ueShqkYIRX2wIoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6WcJXdrdy09fgZvQzMY6G0D5Kep+jKm4cSaicd56+ZncNPec97K5mt0gxCrO1MUUZPkOYBR92OOyXGmmBk9awaYTsREnqctyf9O68pt4oXr6nAmvLKcT62be5qiQ4qD83p8xkRHZksowC2XrlzPVIMlp6n/0pH3H0QVRSi/95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn3c7l8a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn3c7l8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09C8C4CECD;
	Wed, 18 Dec 2024 19:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734550074;
	bh=bW5jd46BzKi8BD19ji+u1O741bs/ueShqkYIRX2wIoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mn3c7l8ar07LdF1bOA9Pr/GdMI7dM2ggnlaQ1BwZPjV10KghX/YSR9JtKc6f59Bnz
	 X1eafqsN8z8F00p81uhZkZqpSwen6g3sLa24+DzrAXhNlcklM4QTjTZvmR7Kl1KTZW
	 lJTxZ4wb9kT71+KMOU/7ugvO4n2ozVlQzdZibAz0xrycQ4wIe+PAXzEqFGx+ScUtPp
	 YWQI7oT0RBmdRmjbVYUu7scQTNUrKSmQ4FCoYFFT2givAq5GGtbjVzpQOB9yX0JARs
	 8coqskjy9Fuu1//kbALAeofOmWkWr2hDENGAp1n6huSHkw4U3EwUNVLZ1xXQlynneT
	 7KDKmeuWY4FdQ==
Date: Wed, 18 Dec 2024 16:27:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/22] Python module cleanup
Message-ID: <Z2MiNxw5a4HXwhFQ@x1>
References: <20241119011644.971342-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119011644.971342-1-irogers@google.com>

On Mon, Nov 18, 2024 at 05:16:22PM -0800, Ian Rogers wrote:
> This patch:
>  - removes workarounds for Python 2 module support due to long
>    deprecation and challenges in developing new code;
>  - constifies variables and parameters to functions;
>  - removes python.c stub code which existed due to missing functions
>    that are defined in the builtin-* files, in general the builtin-*
>    code is moved into util;
>  - remove bench and test perf C code from the python module;
>  - adds parse_events to the python perf module.
>  - improves upon some of the existing python perf module functins.
> 
> v7. Move ifdef-ed function stubs into header file for Namhyung.
> v6. Rebase. When moving find_scripts, separate the switch to using
>     is_directory_at into a patch before moving the function,
>     Arnaldo/Namhyung. Add acked/tested tags from Arnaldo and Adrian.
> v5. Rebase. Fix NO_LIBBPF and NO_AUXTRACE related build failures
>     caught by Arnaldo and the build-test. Fix NO_AUXTRACE x86
>     arch_fetch_insn in the process, which was incorrectly using an
>     empty weak symbol stub.
> v4. Rebase. Fix the parse events evsel to be embedded in a
>     pyrf_evsel. Add __str__/__repr__ functions to evlist and
>     evsel. Throw an exception for a bad evlist index.
> v3. Move is_directory_at to patch 6 rather than patch 7, respond to
>     review feedback on the list from Namhyung.
> v2. Add the bottom 4 bullet points - 13 more patches.

Thanks, applied, testing.

- Arnaldo
