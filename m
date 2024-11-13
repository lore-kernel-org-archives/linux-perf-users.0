Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE71667DA;
	Wed, 13 Nov 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532538; cv=none; b=L/kBi992FLXvwJjtRxTbLdqbcXAMpZxkgE6tAd5y8+cL3Kz/7XzXJ69jWBZs1+wypkCD443B5OrRYW/eSiyIjtKHcB73FlTRqzxsRUp1YjP+CgvITKMPIrX/yJxN0iWJZ5QOzzEKYTg9eh2GymTMUh9y65ZPN7CSKfCBMAxb6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532538; c=relaxed/simple;
	bh=t2R8Ex3j4lee5VTlTR5A719plwgG3aS/+QFBe3U7xFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLpaHtqr/efgMtDGtjsKP40uhKvyXiLOlEqYgGMtZvHzPXmWPpcU560gF4m3+jo+hXBfmGqzfrAJFqyZKng9ao0SNW7j19/gSmNzEvemC7kVgT8RGmlk1LMy6Md0R5Ehhg7sUIP7U65KSmET5jkjkx+r6v3EuRChZWhiiV6XNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxH7PTJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxH7PTJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4FCC4CECF;
	Wed, 13 Nov 2024 21:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731532537;
	bh=t2R8Ex3j4lee5VTlTR5A719plwgG3aS/+QFBe3U7xFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxH7PTJ/Un4Jg69bGOhhLuuBE3zGM4GazaIDNoEfCmmCmO41SzOmggeDcjpKIMYtu
	 DoUUD9O7yVGpx3cD2oSatrIsaLk7rAe+IfmTf9WVjcG8OpAon/XrjDHrn2auVuESIZ
	 s6g3JMh1y4w54LRX8m1RGZatEyLY1WMaKmfQ/Jw1WRRUJ5d+M1NNbORKwREBIE+oqz
	 RIuMpf0PX3COabowVNAdYm0CiPAUFEUvBX8inH5A7HMXqVUgP/m5aFjLxBrk2OlVls
	 wEfBODfS+NDMLfHQUC2OKtCfP8rTHyf1UZcLpIMyX+uX6OQS6ki8YocJ0nqiI+Cz6O
	 nkl7wSdrBvg5Q==
Date: Wed, 13 Nov 2024 13:15:35 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Remus <jremus@linux.ibm.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241113211535.ghnw52wkgudkjvgv@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <1f83be89-b816-48a3-a7ee-9b72f07b558e@linux.ibm.com>
 <20241113155040.6a9a1bed@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113155040.6a9a1bed@gandalf.local.home>

On Wed, Nov 13, 2024 at 03:50:40PM -0500, Steven Rostedt wrote:
> On Thu, 7 Nov 2024 17:59:08 +0100
> Jens Remus <jremus@linux.ibm.com> wrote:
> 
> > On 28.10.2024 22:47, Josh Poimboeuf wrote:
> > ...
> > > diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c  
> > ...
> > > +static int find_fde(struct sframe_section *sec, unsigned long ip,
> > > +		    struct sframe_fde *fde)
> > > +{
> > > +	struct sframe_fde __user *first, *last, *found = NULL;
> > > +	u32 ip_off, func_off_low = 0, func_off_high = -1;
> > > +
> > > +	ip_off = ip - sec->sframe_addr;
> > > +
> > > +	first = (void __user *)sec->fdes_addr;
> > > +	last = first + sec->fdes_nr;  
> > 
> > Could it be that this needs to be:
> > 
> > 	last = first + sec->fdes_nr - 1;
> 
> Yep, I discovered the same issue.

Indeed, thanks.

-- 
Josh
