Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A69280335;
	Tue, 13 Jan 2026 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340455; cv=none; b=EeiI8WysDgDXQlOilpcS6Y0RSs0uBn+WSyFW8fDvdboYO2iP5MpFOky7Yi83bychwyLz1EkFjJ4WnVAnnAlM1IOiIZ7W7qTprV+m5UoL031jWm1j0tkJhiGB1IIykIFcMre7KZgKCRnhEJ7NM+1qJ+ojZN7XIC85yTHEiqwWh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340455; c=relaxed/simple;
	bh=k4wE3jl1JpSOSZ8ntDRy7wD5tow4+4FceA8nR5QW21E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfVA1aYzngyJHY42wP18zQpg1xpZwwxro+R7Nl3gMeIN8mlSVXcn+e14o8eOch6NOK8K6OnHG0eJSUQYBUR1ebWrqdjvNfSrYKC+qslehebmYab1OfZ0TY3S6OA71La9PeoSZxiuT++Y2gai4pGjE4QadD6wco9gZqTF/S2E2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To8twG55; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To8twG55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9DFC116C6;
	Tue, 13 Jan 2026 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340455;
	bh=k4wE3jl1JpSOSZ8ntDRy7wD5tow4+4FceA8nR5QW21E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=To8twG55buAqsuEG8swTbgdUlu8j4VLzbo1jmRN+wIweF3XhiXjZFS9xCoDQ8wWak
	 eEHo2LUs/OBkRLZzxzWw1Wh6DnkNoejuLBQJMCImb8Upx5dtjOepHPkFiX4Hh5iieg
	 75y2TM8cHA3VIqu+1bl27UYPO+EVeDjJGObaVjxgqNh3cSPnAj2QvzAIDh9T1dmVzA
	 Rtmy+78LUBGebo0h/vseaVEa1U72iHOMyavSpeNA8rA39Zuv02/CoovEJMtHaiLZM8
	 KT+0OlVCsGdiBFT9Ji6V+TZOmmNH2J3wDCU1TsT95SrD79uw1I+k3vBQn3oHXYVaUx
	 YFFlRO5tunQUw==
Date: Tue, 13 Jan 2026 18:40:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf: Make more global variables static
Message-ID: <aWa75MJy7FMyzR9P@x1>
References: <20251204214235.589865-1-irogers@google.com>
 <aWGtNvi9kbBCTNVE@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWGtNvi9kbBCTNVE@google.com>

On Fri, Jan 09, 2026 at 05:36:54PM -0800, Namhyung Kim wrote:
> On Thu, Dec 04, 2025 at 01:42:35PM -0800, Ian Rogers wrote:
> > `make check` will run sparse on the perf code base. A frequent warning
> > is "warning: symbol '...' was not declared. Should it be static?" Go
> > through and make global definitions without declarations static. In
> > some cases it is deliberate due to dlsym accessing the symbol, this
> > change doesn't clean up the missing declarations for perf test
> > suites. Sometimes things can opportunistically be made const. Making
> > somethings static exposed unused functions warnings, so restructuring
> > of ifdefs was necessary for that. These changes reduce the size of the
> > perf binary by 3,264 bytes.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
