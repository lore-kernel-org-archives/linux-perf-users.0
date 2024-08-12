Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9018E772;
	Mon, 12 Aug 2024 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493481; cv=none; b=orAp4OJlASpJ/g6Nn/gJglVRnUJkyWT3cstSaozlfpjjlj8HMrOVrrIk2kZP4oevRyAhRK0lyxhnqXuBUnlveKisBs7NXC26KjfrzIx5ewcecRDueSJn5sb3wMPFg6VxUBsTiTd50IoQcThUOxlQmh5nb6WboAD0aBzStZpZFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493481; c=relaxed/simple;
	bh=2sv1RLCsYO8NmnF1i47t83qVH6otaIIzAtoLunput04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4Tf/+5IzYJ50crq6bCXx/svKirPNZOmOj5osamNs/BCssmad532lYAb0tgcvJGg6ApyORaZfS53O248dn+N0+rlwRd1BDjDp2KhVBDYhVnZfmy5BJ+SUHhY6paFzvkf1AQEr8DZ/0O1XfTXPHz/NNqk+MWkkNdjpUoODOSDLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzcLWYW6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzcLWYW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86A9C32782;
	Mon, 12 Aug 2024 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723493481;
	bh=2sv1RLCsYO8NmnF1i47t83qVH6otaIIzAtoLunput04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzcLWYW6lBfs3XxoY96bphpDyl1yIGsTBmNmEvaysTONIfvBygoMmJkmeH66xImNT
	 ARVOxSf55/PQCIV1a02hjRQPpO0pHno3/V26GDgzBd/iPuxgsuLzSHLk+owbNoSrkS
	 F9Vopx+7UUtK9hAzn1pnTagqc4zem4ROLDl+4ujdIb5QFQCKupAbYDzidM/3jXBq1h
	 6NBkE5D5jwG4t30+zchy5brphS3FQpIslgk/oyy8zGrkUoinfZzKEbcgeyKkax8BEm
	 LPYL+oulqHdb6tfGlmftSaHCIZWEUoGHeIdc78sHKU83QoBPMtTaGUA1kOigT8gQUF
	 UuMgsbtr5VTCg==
Date: Mon, 12 Aug 2024 17:11:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Weilin Wang <weilin.wang@intel.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCH v1] perf vendor events: SKX, CLX, SNR uncore cache event
 fixes
Message-ID: <ZrpsZmksSJBrOJz7@x1>
References: <20240811042004.421869-1-irogers@google.com>
 <6947c956-2ba6-4fec-8d8b-79c5bbd3d725@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6947c956-2ba6-4fec-8d8b-79c5bbd3d725@linux.intel.com>

On Mon, Aug 12, 2024 at 10:26:36AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-08-11 12:20 a.m., Ian Rogers wrote:
> > Cache home agent (CHA) events were setting the low rather than high
> > config1 bits. SNR was using CLX CHA events, however its CHA is similar
> > to ICX so remove the events.
> > 
> > Incorporate the updates in:
> > https://github.com/intel/perfmon/pull/215
> > https://github.com/intel/perfmon/pull/216
> > 
> > Co-authored-by: Weilin Wang <weilin.wang@intel.com>
> > Reported-by: Song Liu <song@kernel.org>
> > Closes: https://lore.kernel.org/linux-perf-users/CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com/
> > Fixes: 4cc49942444e ("perf vendor events: Update cascadelakex events/metrics")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Thanks Ian and Weilin
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied to perf-tools-next,

- Arnaldo
