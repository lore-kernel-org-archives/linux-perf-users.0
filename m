Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE910E6;
	Wed, 27 Nov 2024 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732665614; cv=none; b=OVoWO4Ue/xb2lwYEeHgb4o3wYOjhwu20WUPIKKa1fQldNz+OVe+fPiCJ7Ivp0Ze+NXrcPBT0aldsbvcvcMCDF1CIg8/dIGoUoUoeoTvP24+2g9g8b6MxuMQTxJ2DgBfCl/juPSZ5iMqTYLfPWJ5Vr/A1wKFRrISOQps3wCQwa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732665614; c=relaxed/simple;
	bh=lY4JbojFl0Wtgggf+UCXczVKuazezpJRQrQLFYXIWfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzhr3ruyGi9TsIo8ySIwST5m3f38ZNR1dUfg0LJYlF6fP0TP8EMOj7B2yo/erIHOmMkT//Gz6Ns9Q5wjLzKiMqsWKF7svkizKRRymhQVzFKD7i9h0mbPb8TAIh2kLN4HD/jO+K8yrNWpZ0vE2ib23E1/B3IMCL3AI88j3/Gj3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/kF94SA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/kF94SA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB3AC4CECF;
	Wed, 27 Nov 2024 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732665614;
	bh=lY4JbojFl0Wtgggf+UCXczVKuazezpJRQrQLFYXIWfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/kF94SAxZtKbu2g9Phy4/m0r7WnMqVQdyn8yW5sDaHFgXPjVeitJ3l1+DPt5kBLQ
	 hRl9MhyEGAAZ0d9mYImqOblTC/2ekdXCnRk/y9l7782/gQsDbFm1vzaZmcObCBMXMa
	 r7yqmg4yA9NiW+2PwO37qmDQZHmlKSkgjtguOpWFGFtiQiXHrK76iGYtDLhxra++PX
	 mQKfJnaAb6CexeX+h19XcZ0gHsPVruGrCymZQTXfj7a6uwXvdV/auvM+NF72gFeVLf
	 luSgFK0mKJs7EwgT+jpnoboHxR5g1/cEWBCBT3PWrPY78cyOt+7Oa36AmmrCeU0N9e
	 905VYDFiWXzBQ==
Date: Tue, 26 Nov 2024 16:00:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] perf-tools changes for v6.13
Message-ID: <Z0ZhDHXxHKoE2Nrl@google.com>
References: <20241125071653.1350621-1-namhyung@kernel.org>
 <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>

Hello,

On Tue, Nov 26, 2024 at 03:33:10PM -0800, Linus Torvalds wrote:
> On Sun, 24 Nov 2024 at 23:17, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Please consider pulling the following changes in perf tools for v6.13.
> 
> Hmm. Has the default search path for the vmlinux image changed?

I don't think so.

> 
> Doing profiling with this, I get
> 
>     openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 5
> 
> which is very very wrong for my kernel build - it basically picks up
> the vmlinux image from the build directory, which has absolutely
> *nothign* to do with the image that is being run at the moment.

Sure, at least it should match the build-id before use.

> 
> So now I need to point "perf report" at the actual image, which I
> didn't need to do before.

Ok, I'll try to reproduce it and take a look.

Thanks,
Namhyung

