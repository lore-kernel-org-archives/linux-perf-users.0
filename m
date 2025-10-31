Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F721C2334;
	Fri, 31 Oct 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937696; cv=none; b=cKUZJdr4n7tTzS3NHHoz9Xl8X1LKcKGXYToMaRC42DvlAWLNlWm4vS4lGQ1jKO9QqrJtc4bWmWdPsJ+NWSEEYvoZN7crKemKsMJsQAFJv1yNC+a4IC/NV/JKHqCckqsSXI0B0PJQ4AgAbLQUo1LFkGKFMlp1gcQbwg58SMblYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937696; c=relaxed/simple;
	bh=BaWf5dMVF1lBf8NuDuLBearKmPeDx9gZwT93XKsw1bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+SQ8kjEagYealsENcWroxOEWUtX2+W3jfYtXCKeh4lE+PqAJrHDU10CiO54KkSYoxYX2/9w6h1qj/KNzl4JNLkQjsFM0p9D/EJWYGbmWarx5KmEF4+RxJRJWWCN31Jjx5q8D3JColw9A9p8re2Ou4MGgIU/HnB8Pbs0CQ3hIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWa23m0x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWa23m0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48656C4CEE7;
	Fri, 31 Oct 2025 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761937694;
	bh=BaWf5dMVF1lBf8NuDuLBearKmPeDx9gZwT93XKsw1bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWa23m0xK49sm1nJe6bHCGfpWRPw3iCgkx5ic8aZFu2b9NZR1yVwtdmZvQkjIfDaV
	 IpV7CzgoxKN5F/alX1gA2osspPbeXl1bTXvw5wQXe/p7/HrCxqFoAEP45Emo/thZWx
	 7HchQ4NZE0dV3SPO/RXOkXmdCiZR2AA7QmaU57npasFud17mhmpTbr0ECz7OvtkQ17
	 c8aeihLLYqQKS/5YIOuafd438+IXhIpbUt145gnvfUbIQRtLPXsU9isZupkI5dNb7c
	 aagxIUoIp1R+UZYooynhImj+xRMRmIw+ocrlaeHjIAWPzOOJaQ7XhM14uhprE+cH6U
	 +2kdnq0cm6skQ==
Date: Fri, 31 Oct 2025 12:08:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
Message-ID: <aQUJHMtTQ5IVBQ2x@google.com>
References: <20250519232539.831842-1-namhyung@kernel.org>
 <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
 <aCz-wD2Syq8mj2_0@google.com>
 <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
 <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
 <CAP-5=fVBXUeEH2oi6NU2Hs5GCBUqW7BMVUJ6=LDTBfmb=xoL3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVBXUeEH2oi6NU2Hs5GCBUqW7BMVUJ6=LDTBfmb=xoL3Q@mail.gmail.com>

On Thu, Oct 30, 2025 at 01:47:55PM -0700, Ian Rogers wrote:
> On Mon, Oct 13, 2025 at 1:22 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Aug 21, 2025 at 9:45 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Tue, May 20, 2025 at 3:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > > > > On Mon, May 19, 2025 at 4:36 PM Howard Chu <howardchu95@gmail.com> wrote:
> > > > > >
> > > > > > Hello Namhyung,
> > > > > >
> > > > > > On Mon, May 19, 2025 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > >
> > > > > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c has
> > > > > > > max entries of 512.  Usually syscall numbers are smaller than this but
> > > > > > > x86 has x32 ABI where syscalls start from 512.
> > > > > > >
> > > > > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in the middle
> > > > > > > of the loop when it accesses those keys.  As the loop iteration is not
> > > > > > > ordered by syscall numbers anymore, the failure can affect non-x32
> > > > > > > syscalls.
> > > > > > >
> > > > > > > Let's increase the map size to 1024 so that it can handle those ABIs
> > > > > > > too.  While most systems won't need this, increasing the size will be
> > > > > > > safer for potential future changes.
> > > > >
> > > > > Do we need to worry about MIPS where syscalls can be offset by 1000s?
> > > > > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com/
> > > >
> > > > Argh..
> > > >
> > > > > We could do with a map that combines BPF_MAP_TYPE_HASH with the tails
> > > > > calls of BPF_MAP_TYPE_PROG_ARRAY.
> > > >
> > > > Right, it'd complicate things but I think it's doable.
> > >
> > > Should we merge the x32 fix while waiting for the hash fix?
> >
> > Just a reminder that this is still not resolved.

What do you mean by the x32 fix?

Thanks,
Namhyung

