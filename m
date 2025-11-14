Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF282C21D3;
	Fri, 14 Nov 2025 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145327; cv=none; b=Fm39rA8hI3Xq9Dwq5O/mMCFAOfJh+5vIsjoUIZ8D8oblwAF+FfQ/oSLti2vy8mRejTfH4Gtrt/zxadBavvcTLCnwpf4XcSSncwVYBw5oa0z7WJjmSUxtLkuLWKZx+etBCZDAeFoSjUCDmO2ETl9C7j+xiFH85o7BCpVPXLX8/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145327; c=relaxed/simple;
	bh=ZSzk9hs9x/7uPAy2OYyIor7FVN392iJxedW4H6o7HYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gM5TfOyPfCbJF0Pwnpca7tuZr5A7l5XeF0bvuk0rGy0inA9JzpbryArXP3E4UhrfW6Jz8OyAKLMNqTSqJZKQ+CQvHr3STiUNpW9wHPDjfrYkfjXCw7wAt6cuVnJQmnNR/GrADRJOc2S+e3kq6Z8fYT8AqKar1RUM7UUI9xm+Zig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUW6bUjT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUW6bUjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF28C19421;
	Fri, 14 Nov 2025 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763145326;
	bh=ZSzk9hs9x/7uPAy2OYyIor7FVN392iJxedW4H6o7HYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TUW6bUjTtUzg8GhhAqNNsGVFjTjlFXoeY9FOisEouindBecGIV6OfaCoOKMNzHhMt
	 mM7UwlOa1wpkSrNzBJ+ZCqKvMr3iY1Q771JEEvsSA0Ad4r048Tcl0MEnAEf60z1pmx
	 KE2sDrBjClOn8fWll4XCo2Pun5gls/464jAgV/At5H0gL+8t77edltjmwTbFrjVz+Q
	 WfoLngHBFgd2MNnL4l95rqPwvM3Ri3QSs0seBqIUbqzA8xsKN1ug4vhDnkNIjQQCqQ
	 oJLqJ168P4Lq5jqXU5C1OC6aZRbZV5+idnZjiBbo1mB6t8WpL3t2fZRro1yCxpfuI8
	 nyBvvowyj+9dg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Zide Chen <zide.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 thomas.falcon@intel.com, dapeng1.mi@linux.intel.com, xudong.hao@intel.com
In-Reply-To: <20251112164823.80168-1-zide.chen@intel.com>
References: <20251112164823.80168-1-zide.chen@intel.com>
Subject: Re: [PATCH V2] perf test: Add a perf event fallback test
Message-Id: <176314532528.3522480.1979899143868946845.b4-ty@kernel.org>
Date: Fri, 14 Nov 2025 10:35:25 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Nov 2025 08:48:23 -0800, Zide Chen wrote:
> This adds test cases to verify the precise ip fallback logic:
> 
> - If the system supports precise ip, for an event given with the maximum
>   precision level, it should be able to decrease precise_ip to find a
>   supported level.
> - The same fallback behavior should also work in more complex scenarios,
>   such as event groups or when PEBS is involved
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


