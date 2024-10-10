Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2511C232C;
	Thu, 10 Oct 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564637; cv=none; b=P+bowF08sxnkxSVAbfvidDkJkPxy+mQyUPJckmPzQFE3CmPHVopI395EvnBLDJ4GaDpOE6aylNkvGtTDFTqzuPevd3iaBp789xbWvTrO4lHgJe0+7jCD5DKreEG6jd1qy1Twu2tKh4UetjDSDxvbLsgsoGTc2OVEceo3bGFRmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564637; c=relaxed/simple;
	bh=aBExbcoJgvgk8QWms6jdMkorwsq2eYAQQrGI5zjZuCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuvF7BUmMUN3yIy+shgmCpBiZwC1gQ9F+MGw9F++u01HFu+Q3kfuj81PCTkHFsACSzvtu42JF3CsrjEMzg3APJpAAbfM+oRnsLy2r4cK8/pv4o9M6hLz0r9xZcZFA2inZe9/qZ9HRGciWuCNsIJCG6tgonVExpwbaE4fbXmpJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG18FaHC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG18FaHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9D5C4CECC;
	Thu, 10 Oct 2024 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728564636;
	bh=aBExbcoJgvgk8QWms6jdMkorwsq2eYAQQrGI5zjZuCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oG18FaHCExOHblK6VAouDGXsV4pgotZCSfgH3heCemomG97ePUgjp/0wg9NUwIq5K
	 hyfScTWkt7bgOZQsIx+TUOHasdy8HSCTNkwwtnsWCVR05JpOBSp7qElPxQ1YNa9jRb
	 bH250KB6X5WmGdiz912w3rW3IG2bzgXekYcPKd0FYwW4G4P6YcLZayKMV2l9eWePKB
	 8unxRfFPh+FVdg1Z3DqVpeDXFFBRoI41SSjZAe/BEAdOWqOzyd8uIfpuf4f9brdx5t
	 xqynoYd403UArbJ0bE+mKy7rY/T4/I7J3u/QP94VahhStOxnXJ2W/e5QvOd/gdlz0N
	 kPjvI0y5Vx5Eg==
Date: Thu, 10 Oct 2024 09:50:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: Re: [PATCH] perf test: Fix probe testsuite with a new error message
Message-ID: <ZwfNmDNzQAXf0ZQV@x1>
References: <20241010051620.1066407-1-namhyung@kernel.org>
 <ZwfNL2sLL8cDy2au@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfNL2sLL8cDy2au@x1>

On Thu, Oct 10, 2024 at 09:48:52AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Oct 09, 2024 at 10:16:20PM -0700, Namhyung Kim wrote:
> > On my system, it's constantly failing because of new error message from
> > perf probe.  It should update the regex pattern to match the message -
> > "A function DIE doesn't have decl_line. Maybe broken DWARF?".
> > 
> >   $ sudo head -n 2 /sys/kernel/debug/kprobes/blacklist | cut -f2
> >   warn_thunk_thunk
> >   asm_exc_divide_error
> > 
> >   $ sudo perf probe warn_thunk_thunk
> >   A function DIE doesn't have decl_line. Maybe broken DWARF?
> >   A function DIE doesn't have decl_line. Maybe broken DWARF?
> >   Probe point 'warn_thunk_thunk' not found.
> >     Error: Failed to add events.
> > 
> >   $ sudo perf probe asm_exc_overflow
> >   Failed to find scope of probe point.
> >     Error: Failed to add events.
> 
> We discussed this in the past, I came up with a similar patch, Veronika
> rightly pointed out that this may point to a real problem, Masami said
> that since these are for DWARF from assembly those are known issues, I
> suggested Veronika checked if the CU where the function came from was
> generated from Assembly (there are DWARF tags that have that info), IIRC
> she said she would try to do it.
> 
> I'll try to find out the threads and see what happened.

https://lore.kernel.org/all/ZvXhJLkJcR99Y2sF@google.com/T/#u

Veronika, was there a v3?

Thanks,

- Arnaldo
