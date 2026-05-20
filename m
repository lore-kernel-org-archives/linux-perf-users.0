Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A9425CF5;
	Wed, 20 May 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302341; cv=none; b=dHdyVRQdYNVIVmQAKqeZCU/v6vq03HwZ3foF4eMK9NrbJ3+C8lKpyPcQhpstO+iZK4jt+49NQkK07weocGABPvWMwzlmd1vnskaAW4OqHtlusGN+q7YuAoET8NGCZXAaHOWnkDay5/2dI3W8y3N/sUc8MJD2ycByaoUyM10esjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302341; c=relaxed/simple;
	bh=ORayapsip8fYTZwwH+GzjQbXqQq4c5jiuHfo25nVAv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxVbm8FDTgAuKPmvXxa3V7T/EoSnSTXiIgFQE5i8jHP5NGDAOCyEUl51HkvqWFlGvSrYGG3kF854zYZVCksGy6bXLfeh3gKga1cwFMW1fKfs27AuwKgLGBogjRKtJY3IWWB25LfPcFrzu2lPQPTzL2hLcKDU9rb2r8+0MB3J2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsqAPW/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsqAPW/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5DC1F000E9;
	Wed, 20 May 2026 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302340;
	bh=VOpXmAPcEruNx/cf/oxeYmJREV4t13slTwzcIHMK0lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YsqAPW/2ahSktswS5YUHJlURzUHYjvB4DcGCujVaQ4zzE1syWRcH5JF+lO0Ut4qrw
	 gchpKMxzk4YMQsgBeOznTUN5UkKyENRQ83Z6G0RA54i8DYQZrcBdp0My490rk0mpIq
	 yAt5zQ7w2wnuXiTMeeXNLnK0es/4BbuQX8yUXUqjzCY06hLJ1dT6mg0jloizCyg0KB
	 0HRzGm20WRWf/n5BnGyGfJ/NJQ19+6QA1PrckirtUHZcNKfOBlWMNNLamGEv6LumIB
	 Jv1xFsZjagc+70cbAEWEq9VQQE6aUI83wG59+/fNXGr9EuGMH/lICoFA3NlzFul1p1
	 SX/ayeQhJNVog==
Date: Wed, 20 May 2026 15:38:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, akpm@linux-foundation.org, joe@perches.com,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, morbo@google.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf clang-format: Add a perf clang-format that
 overrides some kernel behaviors
Message-ID: <ag3_wYuUbKi1al3s@x1>
References: <20260407165551.3075684-1-irogers@google.com>
 <20260428065432.1877423-1-irogers@google.com>
 <CAP-5=fU9m_kHV+qKogUQhZhtguhCoxKsC051APsyQW5zjzbZFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU9m_kHV+qKogUQhZhtguhCoxKsC051APsyQW5zjzbZFQ@mail.gmail.com>

On Wed, May 20, 2026 at 08:37:24AM -0700, Ian Rogers wrote:
> On Mon, Apr 27, 2026 at 11:54 PM Ian Rogers <irogers@google.com> wrote:
> >
> > In particular, header file ordering is an issue in the tools/perf
> > directory given the larger number of depended upon libraries.
> >
> > The order of header file includes was proposed in:
> > https://lore.kernel.org/linux-perf-users/CAP-5=fUitzKwJONTngiW17XkS7kVr2cDS4cDL_HccJKcnR2EgQ@mail.gmail.com/
> >
> > Sorting headers is desirable to avoid issues like duplicate includes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Move the .clang-format file under tools/perf rather than tools/.
> 
> This change helps format header files in tools/perf, otherwise
> following the parent linux clang-format options. Could we land this in
> perf-tools-next?

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
