Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC93815DC;
	Tue, 29 Sep 2026 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642309; cv=none; b=oSbbMZOc8EQR3x9G8P9G516foAq7TeMFDEcXfxe6TfpRFLxc9aiExU0XZ7/rlCFqnD3XOdFe+oKMPgq4fmXN+2lgqb72hUoBx46F5RidrjgJCR5LjuIpcbto5yIm44gaXDWDuaEc9tzXxMeXds3nBkjS7DXhNlFwDR8oeuop63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642309; c=relaxed/simple;
	bh=TynLa5x1Zba9mZqlZKYp5nY6gCIz99l4QxPfYRO/C3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1QsJI3apjwz4gBxXuyISbL2w1p0JlYu8bKQCtwjv0wo2s8gdD4ko8vXaT6rYl/+OsxCoDTyHomRhK65hkUtANBaPq/VtpRHJD0T6kMb7CSDyQ5YIlBun2ym7hdP3OZKNOc2AKp1tgADgBzA84Ot2CbnObYIdu1UL5vUVVdTHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNH8rqtE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNH8rqtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E122A1F00893;
	Tue, 29 Sep 2026 00:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642301;
	bh=pUpov82pH5U9yDhAoooUrXt0W+MZxWOPFVA+HkPrrIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YNH8rqtECK0LKhjMRQQPWkCxZLGKSxtwVpcrR9WOAlhUkAjDYsxugnRegcAr21V0f
	 xC3Lfgjt26HozOnKDwyIgg7mKx1lJUQ6uER+0c24Mh8u10PX+wx7sOPk5JlbDq5d96
	 lHcaDyNQ88H7DD4XgGHaWYr20dcWp4OYEA3QhiF8BXkqig12eUVTAdFjHbiW8GweeU
	 DDV1++Js2fKQYF1iHXTtlSuyI9YpwO2cWAzke7QIr2MJtZ7c1JmyChaS7KtGlyaEQs
	 OvYPgjoH3dFS9IfHMsrzRcudpeMLAH4/pkDr458HlEH7/AcbgngUV+RCu1wuapAguI
	 kZbNRAKN2wZhA==
Date: Mon, 28 Sep 2026 17:38:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v1 0/8] perf tools: Cleanup dso debug info access
Message-ID: <arsIe8Rd4CNg2aNd@z2>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <arqZrMG4klapZNcU@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arqZrMG4klapZNcU@x2>

On Mon, Sep 28, 2026 at 06:45:32PM +0200, Arnaldo Carvalho de Melo wrote:
> On Sun, Sep 27, 2026 at 10:50:47PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > This is a preparation for DSO file access cleanup work.  IIUC DSO
> > access has three types - symbol table, binary data and debug info.
> > Those information can be placed separately like stripped binaries and
> > split debug files.  I've added dbginfo_type to DSO to track location
> > of debug info like others.
> > 
> > I'm sending this out before it grows too much.  This patchset focuses
> > on debuginfo open path.  Once it looks good to others, I'll update
> > other places accessing DWARF info to use this info and cleanup other
> > file type accesses too.
> 
> Sashiko found an issue, apart from that:
> 
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for the review!
Namhyung

