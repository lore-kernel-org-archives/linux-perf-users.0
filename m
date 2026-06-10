Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C1233954;
	Wed, 10 Jun 2026 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129803; cv=none; b=Rig0pecnTobRzMTJbHAfhlBVI3VhMwqNQjBNHiZJN3O9FlYPbVWHxQJu7INR14hnrN9iMkwModarr1ezt2fWzbN0eFa7F80Gl5kz/+UaKYhSOiL02paroFiutkq5ap8TDHePl6i3hov7iC/FC47cq4JVBHWE0wQ03nNSvBAGE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129803; c=relaxed/simple;
	bh=fuiNKKPc7lmrCax+7CqrsRNg0tW3q/vQ+Gr8MEvYkSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktbWaWATollNk7RRVAyBTrM0bE677vRFbUySsJ0ec/UYKH2Q8Fih853aGhdltRN8y8uV7SwqWd3Seg4CaaLiKhHCc5Gr0yrM/4kIb2eEl4nOdlrrPF+JIk9xDY2Q6TdpzVswZqgHnTxa5OU1L+9VQBIFgMt3bbRMlvVhetpPe4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXKWWxn7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXKWWxn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795811F00893;
	Wed, 10 Jun 2026 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781129802;
	bh=JDmVUl+kqZiFDt/eGk7Ew8Cl/bFJ/LnjqKWASCJcX2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MXKWWxn7H3Q369wjc+YaLOkzT5USByx6OIEAvaMWOSxMxl1Iu94GcTBUbbDT0OY/I
	 X56OmZATHtEIHIe42VkPsigg1u3M/PbyHl2n5QjOyZxuYLuIFmiu3xGUfmdvcCoyrZ
	 OjrDoZKdWtMhdadaCmkwrIuC5IlKphXNi1cUQi1t5uN1eYEuA0VA1jIQEJifYhrlP3
	 jiHXEHD/y4abd+eWD100GR5y7zsZn5waf/6hVfZr2JgaX3p2SB7PIxtHFHij40zo02
	 a1fHGUgug4oz306Ivk77fTvdkrTeSq31XOX/jJDFgnaRnS8kNOQvrhgOgdDZuqnAVT
	 eu3TBmoIPvYpA==
Date: Wed, 10 Jun 2026 19:16:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 13/23] perf tools: Fix uninitialized pathname on
 uncompressed fallback in filename__decompress()
Message-ID: <ainiRoo-dVtkaQbS@x1>
References: <20260610195157.2091137-14-acme@kernel.org>
 <20260610200810.8D93F1F00893@smtp.kernel.org>
 <aincj3a3BDJ22jfq@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aincj3a3BDJ22jfq@x1>

On Wed, Jun 10, 2026 at 06:52:20PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jun 10, 2026 at 08:08:10PM +0000, sashiko-bot@kernel.org wrote:
> > New issues:
> > - [Medium] The commit message explicitly describes a logic flow that would cause a severe data-loss bug, while the code implements the opposite (safe) logic.
> > 
> > Pre-existing issues:
> > - [High] Missing error code propagation and improper negative error handling cause `__open_dso` to mistakenly return valid file descriptors on failure.
> > --
> > 
> > commit 5ae85aedfdb730a58a0d285fd77526ec0c92c20e
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > perf tools: Fix uninitialized pathname on uncompressed fallback in filename__decompress()
> > 
> > This commit addresses an issue where filename__decompress() left the
> > pathname parameter uninitialized on the early return path for uncompressed
> > files. The code is updated to set an empty string in this case, and
> > callers are modified to check for this empty string condition.
> > 
> > > Fix by copying the original filename to pathname before the early return,
> > > matching the behavior of the normal decompression path.
> > 
> > [Severity: Medium]
> > Does this commit message accurately describe the implementation?
> > 
> > The code below sets pathname[0] = '\0' instead of copying the filename. If
> > the code had copied the original filename as described here, wouldn't callers
> > assume the populated pathname was a newly created temporary file and call
> > unlink() on it, deleting the user's uncompressed kernel module or binary?
> 
> So this was the only non pre-existing issue found in this series, I
> rebased it on top of the 28 patches I merged in perf-tools-next while
> waiting for this last series to be reviewed and will do a full container
> suite test build, then push everything publicly.

Ah, there was a patch for replacing snprintf with scnprintf by Athira
that made one of the patches in my series to be dropped, same changes.

- Arnaldo
