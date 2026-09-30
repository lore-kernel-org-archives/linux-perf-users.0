Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB853750CF;
	Wed, 30 Sep 2026 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788246; cv=none; b=OwLPPErOCVh9x3TqLq2qzghJs/EHT1UOuSaX/bxo9BrGWPlu2WIE9Zw87L4FcJLBmfxdebg0ftkzXbwyoNhXjmYVeSvXDHjSvLccIcDmwzSb6UqN+0JN90qL8VWCWg+kV6ZujTaFpXe9QRcJ+jcpX5UMdz7V/U77MSgFbcAz3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788246; c=relaxed/simple;
	bh=lROlxHTTcQJi6y3TUuFJF3HQonBJhQNnKFw9dLL/Gy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ5huLvLjUFse0hrEIFMe9JiEd1V4xHj1xYV/PUFXNCKNZtjLadKM/JzlzV8WPkIg3DWZGJvnUxIAG/uafhOSeB1TpQ6bjs4NQpJaeIyX3+3HQKNgPTBqS53VbX2ZCyAdQw5fyeCDvSOabmVzdHi8TWjEnbjUqcoGdKbv84O4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvyIrFQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvyIrFQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A16B1F00899;
	Wed, 30 Sep 2026 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790788245;
	bh=iRsEKNEyL0VaKkimqTILdI7BdOTg5w4hsY69aVh1uC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HvyIrFQi/N5L2hWVFQ/stz0bOmDUP+hWzoI3AeviMAjYIADbYoBh0DRkei6VwdVSm
	 dFcdYVe9dEaYAUHzKCT511mymv+lnhRCQI279iIb5Cl/W/0fgaVgkkM1dPYZjDjRSj
	 iO3flzMQWP7AnL6Q9T003WkNSwyDT92G125ZiZGbyfVAV3D/J2bnlDNTgktqsG9xsx
	 11IbWKwG++zD7is6PPWBpnEDLt7MduINwTDjP/GFJAaTw5QWMhuycHxuqgameK5RDQ
	 y8CG+yuAhhFmY9QugMrolOjS9zsovo81lcwh6lQCwvsWuxNrcmmZPbl/M3u5iinPkb
	 arRNmbEJ3I6rA==
Date: Wed, 30 Sep 2026 19:10:40 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Michal Pluta <michalpl2003@gmail.com>, namhyung@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] perf symbol: Don't return an unterminated Rust
 demangle buffer
Message-ID: <ar1CkL__7BDEBLT7@x2>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
 <20260928010227.1903673-3-michalpl2003@gmail.com>
 <CAP-5=fUZZkagjaQy0wvme_L_+yif826nPXJzXNJ2YXuYZ6RW3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUZZkagjaQy0wvme_L_+yif826nPXJzXNJ2YXuYZ6RW3A@mail.gmail.com>

On Mon, Sep 28, 2026 at 02:33:45PM -0700, Ian Rogers wrote:
> On Sun, Sep 27, 2026 at 6:02 PM Michal Pluta <michalpl2003@gmail.com> wrote:
> > Free the buffer and return NULL in both cases.  Callers already fall back
> > to the mangled name when no demangled name is returned.

> > Fixes: e20848c317b5 ("perf symbol-elf: Integrate rust-v0 demangling")
> > Assisted-by: LLM
> > Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied the first two patches to perf-tools-next, for v7.4.

- Arnaldo
