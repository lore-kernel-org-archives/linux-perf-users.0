Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB511EEE6;
	Fri,  2 May 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203540; cv=none; b=cQoLUWc18Nuyrtq9xix0ydUsN2yzgiUJrOocJTBm1JeY7+0nUn2JYPLe8zdnN4Uuf9crRYSPT3gd9n2bE40KEvYodCuT6H9QeQbWEqClIBIDMlC1sDAv03awi3bKP1l3R6MiTMB/eIW7a66vzA6AoYUezZfK+A5O81eT55zR5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203540; c=relaxed/simple;
	bh=Ex0V+mdFa3wWpJAaWC1vaJo/G3UpVI7H7KM2zjkElgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT2VsUFE1LgT3Cvi9LsxgQmxM6K6QDgvsEaMjGr17CCfQF0A6rMrgg0uzhp99W/1RvZlK1jSJAAGt2UfXBuD5Joq6EPBGiK0SPEUhrAMhPlg8F2XAgZyMV8LvaWSr5fxxs2mG9V5UILIhgOeKZk/wtQ4Pexk/s/uujgolz32WjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhg68QUQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhg68QUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67333C4CEE4;
	Fri,  2 May 2025 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746203539;
	bh=Ex0V+mdFa3wWpJAaWC1vaJo/G3UpVI7H7KM2zjkElgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jhg68QUQtxblsPCPDZy0W3PY4N6N4VryqoBPW/laCo3PdZSBBGSnrDl9ebVwWj1gi
	 FTZalzRRM9FeRkaBq0daBglrvmN2tckWOmuDVIsy4IQAWkZx9YTHaJEYnLicq1PGqc
	 OnHbIY6S4xP6b9GFSUoPaSYWiXUrpkwOpNaZOZG9T0NTW17dKLp9pooppNAkRAYlQb
	 GhbWLATUy5na2LmF3kcGdNMx04eW5EHfzY9KIuRUt3pscKJ2dRlEaXGcCmaWwTvyA7
	 U74DBQ4TjSAZNNYFk5mT4v/mDyWzvrCsBN8XyEmCchrIVtduj74X1bjUW9WAG5TFa5
	 Qb9cJer05t2Qg==
Date: Fri, 2 May 2025 13:32:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf symbol-minimal: Fix double free in
 filename__read_build_id
Message-ID: <aBTzkQctM8p2HsVw@x1>
References: <20250501070003.22251-1-irogers@google.com>
 <aBPYt1G3VpLI5qBa@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBPYt1G3VpLI5qBa@google.com>

On Thu, May 01, 2025 at 01:25:27PM -0700, Namhyung Kim wrote:
> Hi Ian,
> 
> On Thu, May 01, 2025 at 12:00:03AM -0700, Ian Rogers wrote:
> > Running the "perf script task-analyzer tests" with address sanitizer
> > showed a double free:
> > ```
> > FAIL: "test_csv_extended_times" Error message: "Failed to find required string:'Out-Out;'."
> > =================================================================
> > ==19190==ERROR: AddressSanitizer: attempting double-free on 0x50b000017b10 in thread T0:
> >     #0 0x55da9601c78a in free (perf+0x26078a) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
> >     #1 0x55da96640c63 in filename__read_build_id tools/perf/util/symbol-minimal.c:221:2
> > 
> > 0x50b000017b10 is located 0 bytes inside of 112-byte region [0x50b000017b10,0x50b000017b80)
> > freed by thread T0 here:
> >     #0 0x55da9601ce40 in realloc (perf+0x260e40) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
> >     #1 0x55da96640ad6 in filename__read_build_id tools/perf/util/symbol-minimal.c:204:10
> > 
> > previously allocated by thread T0 here:
> >     #0 0x55da9601ca23 in malloc (perf+0x260a23) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a)
> >     #1 0x55da966407e7 in filename__read_build_id tools/perf/util/symbol-minimal.c:181:9
> > 
> > SUMMARY: AddressSanitizer: double-free (perf+0x26078a) (BuildId: e7ef50e08970f017a96fde6101c5e2491acc674a) in free
> > ==19190==ABORTING
> > FAIL: "invocation of perf script report task-analyzer --csv-summary csvsummary --summary-extended command failed" Error message: ""
> > FAIL: "test_csvsummary_extended" Error message: "Failed to find required string:'Out-Out;'."
> > ---- end(-1) ----
> > 132: perf script task-analyzer tests                                 : FAILED!
> > ```
> > 
> > The buf_size if always set to phdr->p_filesz, but that may be 0
> > causing a free and realloc to return NULL. This is treated in
> > filename__read_build_id like a failure and the buffer is freed again.
> > 
> > To avoid this problem only grow buf, meaning the buf_size will never
> > be 0. This also reduces the number of memory (re)allocations.
> 
> Thanks for fixing this!
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
