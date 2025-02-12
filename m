Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0753126BF9;
	Wed, 12 Feb 2025 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326246; cv=none; b=VW3yYPlzeusbVU1e8WSeSgTppUP/eYWQlTPpJBDZClqqFRsacbOA9g5lmTxSUQti3jr5KZiWVtuXP8oSUCgjUDSzDUXqXG/LIY72OEUbklKWbonBnKJaIbp+tMZQKnS8ZrEiz0K+RXwjAkTNQDbs6utI1j0rLrI1gC5PPbkeZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326246; c=relaxed/simple;
	bh=I/rZw4FowRhXgjGEoVDTnReTLRjQoga6pAUhWf0cJq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4s50Dw1oOy+dhS83TGP5TEm3ZvgBI1MqMZwlb3049/m893dA1wsFrqMyfMRR1/qW936xZmHH9Tm5Wm3mA7TPwW8LS88pp2hWQEz+RHBMMq3MwhrMkeoohYAUHr5ZOTmEkGmL/pMIpdt0qUY8bapfz0vzTwsPES1QuknAz+Tju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/QGEmyk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/QGEmyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB52C4CEDD;
	Wed, 12 Feb 2025 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739326244;
	bh=I/rZw4FowRhXgjGEoVDTnReTLRjQoga6pAUhWf0cJq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/QGEmyk7j2fk1Sqwd46EJnohFD9PdRSSiCZeeNc4n7sGaZ/nQGrL8Fv22MnV02K6
	 eVOQjOKaE+8dh4CYT818VPzyxetScxBldyofoaKMtjZOggVlqDSH/3DJLNhYpBAKyr
	 ITt2qA4PN/5A+migOyVNqScLjvAi2AZoS3TlzU9OJbfrqw0nsp6f75zuQFxqOOpVGG
	 MIbyGBrIUSMu+xVp2N80zL1wYZGL+N3OMQyClJRWVpG5oICXn2rU/MIEpw0Y7+Z7/R
	 KzwtcNXbzksLc30LC7sQnE9PywzSU+5RsXA55k9NQzC4tLIL7zLKGRcSiaPDIgWnCL
	 L2axJutzH8Blg==
Date: Tue, 11 Feb 2025 18:10:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Cc: Ian Rogers <irogers@google.com>, acme@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Improve startup time by reducing unnecessary
 stat() calls
Message-ID: <Z6wDInRZ7VVVcaHb@google.com>
References: <20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com>
 <CAP-5=fXV6b2g9QxPe1EsSTcHZpSPq+EAR71jvpBGW7ehydN+Uw@mail.gmail.com>
 <CAOQCU64Fhoek2YEJjhtAsTqPa1Jt1X9z3_C4+pL+R-6hs-EdDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQCU64Fhoek2YEJjhtAsTqPa1Jt1X9z3_C4+pL+R-6hs-EdDg@mail.gmail.com>

Hello,

On Thu, Feb 06, 2025 at 10:45:02PM +0100, Krzysztof Łopatowski wrote:
> Hi Ian,
> Thank you for taking the time to look into this.
> 
> > I did a series and a new io_dir set of primitives.
> > The last version of which is:
> > https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/
> > I mention this as I think that series may be a better route than this
> > change as it solves a little bit more of the performance issue.
> 
> I'd much prefer to have your solution merged, as it covers more instances
> of the same directory exploration pattern and provides an explicit
> approach to memory allocation.
> 
> > I stopped pursuing the series as the maintainers were complaining
> > about unpopular libcs/platforms missing system call definitions
> > (getdents) and the series breaking on those platforms.
> 
> Yeah, I agree. I also don't think doing an #undef because of muslc is a
> good approach. Would you and Namhyung be open to bypassing libc and
> calling SYS_getdents64 directly instead?

Yep, I'm ok with that.

Thanks,
Namhyung

