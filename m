Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4F4EFFB2;
	Mon, 28 Sep 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613936; cv=none; b=c2Ip8vYTciV/hALg88a7NdQGIgwelNK6cqpmC1BLGQDUBAmKhyZvIcYDyMhGhwHWgLsOh+B1u11vjQiH6V2lXzJrGXxO24PxXulBvqw9ZG6ivFJHEZadS6JNXZ9k3ck7H5wyBPaiEfKM+GSCPPhfOMNRRabr8VOYTiaUZpAEObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613936; c=relaxed/simple;
	bh=dDLRT2eyxO8XQlUsfcYvFerVwQ8Yh4/r0zuS/BmF+bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvRcxH1lJ0Y1+Cba9ewlRFyJppnkb9UMAqn4XLQxZa9OIN3diJvIeZep3CofsH8hdKKVGdvOHKGvrCn1LtmbpuP3YpdcvZvqqUgoCRDNTXf+foNzG/7RR6DfI0SzuQYJ9Rwh11aLcTS0rWex0mKfmbSPOt4rc/XUmsAGdfXfzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKnRlQ1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKnRlQ1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B301F000FF;
	Mon, 28 Sep 2026 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613934;
	bh=4xl58aQ5JI8XOQTBo6dTKz9E2P99vW3Ghi/lePj9PUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JKnRlQ1ozvolSKzlg6lIMsQlXc+Y+6mdhwDD2JSMs3SgmH/oArUDoMd3+vDx9kstX
	 CCkGzM/vm3xhWiKEX4fWJo1Scmx6XSxDYJUw1MnXtaDFaxc7Ghn5T7AICS7bDdEXbP
	 SSwgk9JDVs+Gj+jkmY8+YNJFyydueFWAQiD919z/vFbQhRa0TJIlolc+xMVPmqYeyL
	 nJdzdJJmsSKuxeB5XTenTMgMnPe8VDBMNyoOOajJ3grR5tM45UbhwdoPI0CQzfwAwy
	 6YVDdwUWZpdHXntJJ8aA1eO4/s/NkTrUnoLDwv+H0dRPlS3gi6Z3SFP3yHNB5QGFZt
	 GmmC3LyqvVeEg==
Date: Mon, 28 Sep 2026 18:45:32 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v1 0/8] perf tools: Cleanup dso debug info access
Message-ID: <arqZrMG4klapZNcU@x2>
References: <20260928055055.95144-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928055055.95144-1-namhyung@kernel.org>

On Sun, Sep 27, 2026 at 10:50:47PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is a preparation for DSO file access cleanup work.  IIUC DSO
> access has three types - symbol table, binary data and debug info.
> Those information can be placed separately like stripped binaries and
> split debug files.  I've added dbginfo_type to DSO to track location
> of debug info like others.
> 
> I'm sending this out before it grows too much.  This patchset focuses
> on debuginfo open path.  Once it looks good to others, I'll update
> other places accessing DWARF info to use this info and cleanup other
> file type accesses too.

Sashiko found an issue, apart from that:

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
