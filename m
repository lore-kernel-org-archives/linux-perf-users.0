Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EC1DFCB;
	Thu, 10 Oct 2024 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520450; cv=none; b=hE3gD3XeCDtIBesr3mTqIFL9XW0d7lVCQ9JWFZhmnW3ZzFN8ILHxSr4Wd7tHLHYl2yISN7W8Dh9/UWMQFiayEgXU8W6J2QOftNj6ayj5ev4NaLLdY7r4vFGJhe0Yn5Vwtc9uPB6CppBldJ9C39qmMr9yzsY3Z7VVyJamAk9XONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520450; c=relaxed/simple;
	bh=PbJxKxeMx5OKjb0jDOSajF3Li7qreAoN0MDyNcWteQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT80GoweKkpFbfQPeBOfDdvIHpssj3wNB76tpi/QCFYuK/6XbYbzYUhMkJGLAV5WuOgoGevakja0Y9QBQ5ang3vrcS1lnial95x8iYUOSlLHJoCKKGLWoy4J70UzqTcvNWqD/Dzch1tIByYMb8w3Q7mdkygBV+x1oVmx75lNjao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekwByMxx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekwByMxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B34C4CEC3;
	Thu, 10 Oct 2024 00:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728520449;
	bh=PbJxKxeMx5OKjb0jDOSajF3Li7qreAoN0MDyNcWteQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekwByMxxKh8g2UyD0zlSRo4AXjn0ntnU+si0Cmkhx4uK7w/5Wd/M8yioCuWklIHg6
	 /OZOL+Jgx2aKPlJds65odQv3jPFGj1vc3rw3K4g4FUbWL1y80Ju6DjJCRRhi6ePLBA
	 3q+n5mSSZM0C8QQYg0dRfySsK/taPNoAlYAWGLDFfeS5qCogsQrZbI65BGAuRBjmWh
	 xv0lHcZNIrfBtyv0f0nOoMmUlzTekrm+xf+IT0oaRnPqbdaBClbl8ouERlVnnUAYVl
	 fEKs+EzScXj9JofeZF6LsNJjCrd9rytF5vl8rIFZASTE8JpDM3FsSdoZ8KM7vmz1PH
	 ApaSjy4OykBMw==
Date: Wed, 9 Oct 2024 17:34:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: Re: [PATCH] perf callchain: Remove unused callchain_branch_counts
Message-ID: <Zwcg_xprl-n8me4D@google.com>
References: <20241006012204.373803-1-linux@treblig.org>
 <ZwYVCTsf8p3v22HQ@google.com>
 <ba80cbe4-877a-4b5f-a5d6-de16fc1d2d4d@linux.intel.com>
 <Zwa0bfGAaBGTdD33@gallifrey>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zwa0bfGAaBGTdD33@gallifrey>

On Wed, Oct 09, 2024 at 04:50:53PM +0000, Dr. David Alan Gilbert wrote:
> * Liang, Kan (kan.liang@linux.intel.com) wrote:
> > 
> > 
> > On 2024-10-09 1:30 a.m., Namhyung Kim wrote:
> > > On Sun, Oct 06, 2024 at 02:22:04AM +0100, linux@treblig.org wrote:
> > >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >>
> > >> callchain_branch_counts() was added in 2016 by commit
> > >> 3dd029ef9401 ("perf report: Calculate and return the branch flag counting")
> > >> but unused.
> > 
> > It seems the original patchset was not well organized. This function is
> > actually used by the last patch of the series.
> > https://lore.kernel.org/lkml/1477876794-30749-7-git-send-email-yao.jin@linux.intel.com/
> > 
> > But for some reason, the last patch was not merged. I think Andi gave
> > the Acked-by for the whole series. It might be just accidentally missed.
> 
> OK, that'll be the 4th time this deadcode series has found missing calls
> to functions!

Nice work! :)

Thanks,
Namhyung
