Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC325A634;
	Tue,  4 Feb 2025 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637944; cv=none; b=iCi0FzKC878sD4eQvXuJl1FNBhIqHqgjyLspAnnQgSjfDacZ8QmvGKYn76Wf37HDdzogFY16SKsb+6c8i2kxWWBdhRBh7G2VfXT5AylQ6zu/S1BaetKNQn06JHhn5qddaUSCu7gh47KrIz/KsRykV+lunnzUR6FgOuYJ5/2yzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637944; c=relaxed/simple;
	bh=RGRkVVJqlRNC7tv95ZEo+qB5qw19XQ9KEmwG3KdfDNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT2RtXPFif0EeMiCcU9u8JGb09fZ3/ILvNxXZMNgFnxq/NeXC7nJ0M4i6IO7WwRcb1IT2vD3zwvJrNnXpOEfIYuMTZ3ZVNmL73LGIamAcGR2H4JoBhs7fpMyQcqsL7hZBj4JipVZ7q8G/YIQZHTESrwtid7+d10VuOHrOc87mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTmHzbrM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTmHzbrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD87C4CEE0;
	Tue,  4 Feb 2025 02:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738637943;
	bh=RGRkVVJqlRNC7tv95ZEo+qB5qw19XQ9KEmwG3KdfDNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTmHzbrMIAgTvKOl7tDCkDehPQAxarm6ybWiKRlbbp4o4S2+5of0uKCN1NTvBfiE9
	 ShHVpKUu+uirVDFu34PidE939lZ8TRNRIpBuPRoei18qwdhvD8Gabc2muVkFW19WcM
	 Pbg59q/bmIC4+Zh1XbUqBoqHK99K0+0QYj9sRFijfD57yX7tGDF3fHOKf7eGxbZvv5
	 NELhcGS4vEVa5aGBxhyT3doXfchfXdgYLJFFQHWR0e/ORlDT9eRJHHDaQS/NeKpeMr
	 EcN6g9KuQ/xeZFsXJyHJKGvZYfn4Vg93H8h/b1xUgga4GqCzumxU+K2JUWwpc4MkHl
	 QCyji51re+axg==
Date: Mon, 3 Feb 2025 18:59:01 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 1/4] perf trace: Allocate syscall stats only if
 summary is on
Message-ID: <Z6GCde4XqCuEZlgz@google.com>
References: <20250130030525.1482498-1-namhyung@kernel.org>
 <20250130030525.1482498-2-namhyung@kernel.org>
 <CAP-5=fVJDi2UuhTYk5g-QaLqZC29tAprKWs_0PKNmd+y=iugjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVJDi2UuhTYk5g-QaLqZC29tAprKWs_0PKNmd+y=iugjA@mail.gmail.com>

On Sat, Feb 01, 2025 at 10:57:00PM -0800, Ian Rogers wrote:
> On Wed, Jan 29, 2025 at 7:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The syscall stats are used only when summary is requested.  Let's avoid
> > unnecessary operations.  Pass 'trace' pointer to check summary and give
> > output file together.
> 
> I don't think this last sentence makes sense.

Thanks for your review.  I'd say:  Pass 'trace' pointer instead of doing
'summary' option and 'output' file pointer separately.

Thanks,
Namhyung

