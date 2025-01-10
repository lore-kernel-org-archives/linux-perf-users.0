Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561D139587;
	Fri, 10 Jan 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517793; cv=none; b=Ygt6vE0VIMK34eG3NMt/UkzW22S3TcFfPJsOO0Zk8yZQzK9prnEB7pcCgdMOLdg/Kpj7SMEvuNUCFEz0gCnkqshcFVgoMwFODNy0o9MSO2MREht1zmDDehaxZ29vlxlNnRLk4o5EJ3gfIjo0/Q/SpOSuebKb3WEp+eltLLmNct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517793; c=relaxed/simple;
	bh=UAbkm7+oWyHmZ2Q1y/z7wd9fB7oyeP7oFjrp+AH+ZeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp8Ybetc9vBqHqKhhN/USrxLUjg+au3NcToyHYJroBibZ0jYXYnMkzO7C7J0YFlD34XphH2StU3ypVvpssONgWnOnilxCZT5TalJUUGYf4n5+sRhTdwcetxVDZ9mQMA6apZh+1LkfNVJfU6GINpvFegQQyhJ1gvCR8BZjoJKkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1D/vXE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1D/vXE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F280EC4CED6;
	Fri, 10 Jan 2025 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736517792;
	bh=UAbkm7+oWyHmZ2Q1y/z7wd9fB7oyeP7oFjrp+AH+ZeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1D/vXE8Ge3xUP9mpnWXnjKwLgdrT+4Jq/2ECi1y47dox80fRa/NiO4TFK+NSL0b9
	 MrmgsuXwuSnLF+DPN3tnEuKOiBN48tpvytRaIuGnaMdmeccNHcGeQkD7Amg0VHUl3R
	 P/l2zULOA3IK478sWX67r7PHBP38KmfFAQvDVAgy0L6l1LcxTx2P6CIIUx3UPke1LT
	 Yjg25+GpJKDB7/Ioaq1sp34gY7CQF6NOcpNT1hHrfMq4lmo7TbHdv1qRomWByZIwVY
	 +v7izd/GVfzQZDwW5l1fi1K4Cbp4wkheU26hka/ke6yDSqa7SQ+c23kR9tm4ujzTuD
	 thzOQmu0T6L4w==
Date: Fri, 10 Jan 2025 11:03:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf ftrace: Check min/max latency only with bucket
 range
Message-ID: <Z4EonTmShlWn3n0X@x1>
References: <20250108210015.1188531-1-namhyung@kernel.org>
 <a016ab208eb3ee3821ab59a2520a2bf56645917e.camel@redhat.com>
 <Z4Bt8aIkX5uErX8a@google.com>
 <0ef32d5e-594a-43a4-ae5c-e8ad05a2d320@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ef32d5e-594a-43a4-ae5c-e8ad05a2d320@redhat.com>

On Fri, Jan 10, 2025 at 10:09:14AM +0000, Gabriele Monaco wrote:
> 2025-01-10T00:46:49Z Namhyung Kim <namhyung@kernel.org>:
> 
> > On Thu, Jan 09, 2025 at 08:53:02AM +0100, Gabriele Monaco wrote:
> >> On Wed, 2025-01-08 at 13:00 -0800, Namhyung Kim wrote:
> >>> It's an optional feature and remains 0 when bucket range is not
> >>> given.
> >>> And it makes the histogram goes to the last entry always because any
> >>> latency (num) is greater than or equal to 0.
> >>
> >> Thanks Namhyung for fixing this, something definitely slipped while
> >> testing..
> >>
> >> I confirm your patches work well also when the bucket range is provided but the
> >> min latency isn't.
> >>
> >> I'm wondering if it would be cleaner to propagate your changes (using
> >> min/max latency only if bucket_range is provided) also to
> >> make_histogram. That function currently works since we assume
> >> min_latency to be always 0, which is the case but probably not
> >> considering it altogether would look a bit better and prevent some
> >> headache in the future.
> >
> > It looks good.  One thing I concern is 'num += min_latency' before
> > do_inc.  I put it there to make it symmetric to 'num -= min_latency'
> > so it should go to inside the block too.
> >
> > Or you could factor it out as a function like 'i = get_bucket_index(num)'
> > so that it can keep the original num for the stats.
> >
> 
> Good point, I can have a deeper look at that. But I'd say it can come as a cleanup patch later.
> I have a couple more changes in mind and this would be no longer related to your changes.

I'm tentatively taking this as an:

Acked-by: Gabriele Monaco <gmonaco@redhat.com>

But it would be great to have it as a Reviewed-by and perhaps a
Tested-by, provided explicitely in response to this thread, ok?

Thanks,

- Arnaldo
