Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8B15F414;
	Tue,  7 May 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094703; cv=none; b=iaz33BEsPU4weCq1uDbmQ5v8ho1seIPUcWmCwAynOghRH7uOZ+43gX6rBgo40ESAK/7i13vpmo2hVlm9vsk0brG6/a9JKQbxAJsZMMtbmvoSowkVerCH3jJYtJ6JpiE+2pxFuIzPRJ9Rm2xptaKSt4fMGna73hLARgj2n/iRm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094703; c=relaxed/simple;
	bh=OvO4hU6FbxLQCI8dRSSkC2frlsAefmth7VKNn4rLX64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGQaK/fMQUlBz2rL+5gA6GTGWtOf5tNC9lPCUG0V3V6uyEuDCGQtk6IcIP9adVLqWohZFaCjGbLWQ80axAC9HTM86XuI9Utdzp73iaGVXjWVPNJSiDfnZu0ukOxEEJRktvqV8ta+FoAc7lgoOvfn2co/BmGs8R2vT9GUlCD184s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj4SEG4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj4SEG4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D18C2BBFC;
	Tue,  7 May 2024 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094702;
	bh=OvO4hU6FbxLQCI8dRSSkC2frlsAefmth7VKNn4rLX64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lj4SEG4rG+swNVVMfblGTHrNIo4JZzl+85zJxvVzDJrZJxa/Z3TShmbUfSC45mMdX
	 KILwU50T6yaQICNzl6xecSDCxqjy1zSRUNlnjyf/IrpXEzvtQ5ycmpzZUyj5GcPEmU
	 3SVIoHULSWTBxQXhrsijMurDMc//uCbf6WNbdGgDoYN+nliihaWiAm5a5dX5/O7i0D
	 NZO5spHtmEO1VZh3FBgETZh4KEbv/V2flKrwK00Y0/MrtBYPno9OLA3/7HUE8y6mEe
	 SrDRRpSwK9yEn3r6snqcd3urQuyM6maZcDnFYyPj7QKWEMAf2IDLIeVm/3x1RKGaWq
	 fdMcGl9xTbPsw==
Date: Tue, 7 May 2024 12:11:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
	irogers@google.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf maps/symbols: Various assert fixes
Message-ID: <ZjpEqyR74rl92jhb@x1>
References: <20240507141210.195939-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507141210.195939-1-james.clark@arm.com>

On Tue, May 07, 2024 at 03:12:04PM +0100, James Clark wrote:
> A few different asserts are hit when running perf report on minimal
> Arm systems when kcore is used, or the .debug/ info can't be loaded or
> /boot isn't mounted etc.
> 
> These result in some less common paths being hit for resolving symbols
> and things are done in an order that breaks some assumptions. I'm not
> sure if we could do something to make the tests pick this up, but maybe
> not easily if it would involve mocking the filesystem or even a specific
> kernel. I tried a few different variations of --kcore and --vmlinux
> arguments but ultimately I could only reproduce these issues by running
> on specific kernels and root filesystems.

Please consider adding Fixes tags so that we can help the work of
backporters/stable?

- Arnaldo
 
> James Clark (4):
>   perf symbols: Remove map from list before updating addresses
>   perf maps: Re-use __maps__free_maps_by_name()
>   perf symbols: Update kcore map before merging in remaining symbols
>   perf symbols: Fix ownership of string in dso__load_vmlinux()
> 
>  tools/perf/util/maps.c   | 14 ++++++------
>  tools/perf/util/symbol.c | 49 ++++++++++++++++++++++++----------------
>  2 files changed, 36 insertions(+), 27 deletions(-)
> 
> -- 
> 2.34.1
