Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849581C84C0;
	Wed, 17 Sep 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130914; cv=none; b=SWQKUPQTg5swcscXj2JYPfEjDSE6GcqRcKCVYSwZH0L8IDQbMGsRQs8fzfQ+kBVflD0g3ZQxbdvvEJa32cDFREloyZoqAumxAwY8TfljT9n8xrpa1BzP3AH6Hj0wndHpk5kQL9AGvBMLv5rDeiJUjZM9Ws/S2QQm4cGw/n1raTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130914; c=relaxed/simple;
	bh=eU9XjJtC64BBSVnRNJIJPMBgCSmlAXCpzw3dyv+oXIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTcIQpcM6wb4SkVYi5cvHjr2CXU/UD2zVZE0HHJoIGlDshT7uhG0HNPVC0ZWhcT5PQxmON4T3zXdBEZND/sldkQpjBeI34InAx4v9WwAVrtXrCkWgK3FbKe6E5H2PswswrrM4ZM6PMOPbSeL7rbkJO2QTvZ4HPbDd6gao8gOm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRCyoIl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRCyoIl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C54C4CEF9;
	Wed, 17 Sep 2025 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130914;
	bh=eU9XjJtC64BBSVnRNJIJPMBgCSmlAXCpzw3dyv+oXIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRCyoIl6G2tfbuPzLdLvjstCPUOoYZZezVoRSZr0bjTJUK0KOd/5QV86HQAyt456x
	 L0k58cEo0+xJsOSR7lDbk8O1rc7/6a+si0UyoFq0kiYWnX36jAlRAomw0delwStWQp
	 6mb+KNVP5fDlF3zE90G4ntZHgHFsuy360L9NRurtkuzqyYoQGJTg47Bdk9U0Pl6COn
	 GZ70zmNAszeOEaWYFHc4Zj9UtSNWPnbFy4os3fa08gb37+60Tf+esfMSb0BYhEADuV
	 hn/0YCf2A5uETBSlepwNdJ6OHHSDGpCfLJLcz+Hm4bxrAJHzt3mjLCuE1dx5QLE1jy
	 xE5IUIYtXYOig==
Date: Wed, 17 Sep 2025 14:41:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tamas Zsoldos <tamas.zsoldos@arm.com>
Subject: Re: [PATCH] perf session: Fix handling when buffer exceeds 2 GiB
Message-ID: <aMry3oh_qaV0ZI03@x1>
References: <20250808-perf_fix_big_buffer_size-v1-1-45f45444a9a4@arm.com>
 <aJ-V2ZsYpN8RDQ3M@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ-V2ZsYpN8RDQ3M@google.com>

On Fri, Aug 15, 2025 at 01:17:29PM -0700, Namhyung Kim wrote:
> On Fri, Aug 08, 2025 at 02:24:40PM +0100, Leo Yan wrote:
> > If a user specifies an AUX buffer larger than 2 GiB, the returned size
> > may exceed 0x80000000. Since the err variable is defined as a signed
> > 32-bit integer, such a value overflows and becomes negative.
> > 
> > As a result, the perf record command reports an error:
> > 
> >   0x146e8 [0x30]: failed to process type: 71 [Unknown error 183711232]
> > 
> > Change the type of the err variable to a signed 64-bit integer to
> > accommodate large buffer sizes correctly.
> > 
> > Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
> > Fixes: d5652d865ea7 ("perf session: Add ability to skip 4GiB or more")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
