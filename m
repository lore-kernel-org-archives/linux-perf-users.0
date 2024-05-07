Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57C1635CE;
	Tue,  7 May 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094760; cv=none; b=ZzJ/ZVzh7fb6/42y3qvDN91Mm3GTwwx5kwaKWgpwhcK6elSGdwXGvplJSsPdEYX/EuPDDU8WNgJXdYw1lqYV02v3QxAX8r0irUMeM76nEHVOSduyK3Zo1k1DN7Xjxkl6bajHCDo3bu9KXmlxsDBQnl56biT2r8yB07cjULThyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094760; c=relaxed/simple;
	bh=CXLjYfLWjcW6h21E1qVlgB2tJ6ZoVOvZXdLSoPbpeQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbRfuVPPMz9W7u9LT35L8SZhjeik+w1NsO4NpCJMCLYnsKk4eDW2zdRa+vPahklFVPhr0/GdjRwVXVP4ZvVRA6kt2cypMuDFqVkN3skn5PKsktc2bZtbw++l0y2odedKCA3Aad8qztbcyfwl/IloSfWfOJc11HkdbDWV3mEdaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPCFaH9Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPCFaH9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE3BC4AF67;
	Tue,  7 May 2024 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094759;
	bh=CXLjYfLWjcW6h21E1qVlgB2tJ6ZoVOvZXdLSoPbpeQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPCFaH9ZYRWC8WYu168aEE+/NSpLngqdAgzKhKQrDEeO9VNHXCf3bKpEbLvgNggs4
	 STXzErw4ugrSIMeyOgqGqpNnEkFHx02jjKY/JTP7JqF2zbwpQilo3k+8GiN4kiAWB7
	 Oil1vZvLNzS/Knrl286FQ7KfyJMYwYaOwf+vH5DpgP1Bbk7FWE6afXvdxMExXSQTBj
	 S2knS+qJoY7JNRLjkOKjg3rMH/aCgKAUqZZjJmRm+s6dyM8AjcLOfuXzVUZO6V5p+2
	 ZO9DNOO5sjWqoaKaTQAzw8ipfz3QP3txK+v9M8ILbqzEeZ3w5ZsoK2Y90Fz8Yfpv2v
	 fBpi4IO8dXr4A==
Date: Tue, 7 May 2024 12:12:36 -0300
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
Message-ID: <ZjpE5KfP_Wm3fxNm@x1>
References: <20240507141210.195939-1-james.clark@arm.com>
 <ZjpEqyR74rl92jhb@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpEqyR74rl92jhb@x1>

On Tue, May 07, 2024 at 12:11:42PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 07, 2024 at 03:12:04PM +0100, James Clark wrote:
> > A few different asserts are hit when running perf report on minimal
> > Arm systems when kcore is used, or the .debug/ info can't be loaded or
> > /boot isn't mounted etc.
> > 
> > These result in some less common paths being hit for resolving symbols
> > and things are done in an order that breaks some assumptions. I'm not
> > sure if we could do something to make the tests pick this up, but maybe
> > not easily if it would involve mocking the filesystem or even a specific
> > kernel. I tried a few different variations of --kcore and --vmlinux
> > arguments but ultimately I could only reproduce these issues by running
> > on specific kernels and root filesystems.
> 
> Please consider adding Fixes tags so that we can help the work of
> backporters/stable?

Sorry, you already did it for the last two patches in the series, so you
couldn't find easily what were the csets that introduced the problems in
the first two patches?

- Arnaldo
>  
> > James Clark (4):
> >   perf symbols: Remove map from list before updating addresses
> >   perf maps: Re-use __maps__free_maps_by_name()
> >   perf symbols: Update kcore map before merging in remaining symbols
> >   perf symbols: Fix ownership of string in dso__load_vmlinux()
> > 
> >  tools/perf/util/maps.c   | 14 ++++++------
> >  tools/perf/util/symbol.c | 49 ++++++++++++++++++++++++----------------
> >  2 files changed, 36 insertions(+), 27 deletions(-)
> > 
> > -- 
> > 2.34.1
