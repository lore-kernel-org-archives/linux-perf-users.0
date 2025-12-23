Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B634DB54;
	Tue, 23 Dec 2025 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513469; cv=none; b=YYzW+i91hH9XmPlyKWUU6yZf8P9783IVzOuU+hdc1Jk0cXFX301HDALVVOKwZjTxmRz2JDhSgs4Il8A8ueqihIZKj8f+2xLBAAvPd6npDcY1CzPbu5kL3vMmP8DhrowZiG0FfjS1idkOre0JjOSfMFMeVS5vPlRxbvbePqQVvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513469; c=relaxed/simple;
	bh=vCKrrF1o0/Sy5zt04haiRM3dM3kVeJ9oxBI9ruG+/lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu9WJHuC2qfVogFv9XfKmSOZsOUpF2T2iwce+xNSi6K88+hSB2hEs12PwwVpPY0Bn+5nyX1LTj4TC3PNE/LNaMLJ8tC9Adz8FeIYI559Xf+9PfL66OgYPJRLbxdUnDDAt3wc0d0FONxNRVJarhx8p/4ZSsa6nVf30+j0ubS8P20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm7dP9K3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm7dP9K3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBFEC113D0;
	Tue, 23 Dec 2025 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766513469;
	bh=vCKrrF1o0/Sy5zt04haiRM3dM3kVeJ9oxBI9ruG+/lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nm7dP9K37WQ91NFZL+iwUFWhCmuzJSPvFZeTgq7f8lpN19LuwUdZomDaO+GfjfH5h
	 cqX2BUZ/VXsg4XDxwrxuM0rNfDKlO/95CvnGRErQ/JKirXVWOxjBBQa8VTZP+KzwVy
	 PT0WbsNxeKg4QZGXfl02aiw1mhCATHIL6Z4oKwy0P75pLnN6xkkZqatLqvMHYEJpZe
	 +F2jDS/Y+o6L0uhU2sdiIGaY7zjiK2AtG+k1z2wlQHueKKlWk2mp6fYzEV+iBORpOU
	 xy+IYZynIulenhDOcdnOj2dSwbGclzmwm5Q9J8CSBDXsuZK2kBHUtg/ZiJnMAO88Vm
	 cIbgRs2WxgBuw==
Date: Tue, 23 Dec 2025 10:11:06 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/11] tools headers: Sync arm64 headers with kernel
 sources
Message-ID: <aUrbOlBwdLFTMjH1@google.com>
References: <20251222225716.3565649-1-namhyung@kernel.org>
 <20251222225716.3565649-8-namhyung@kernel.org>
 <20251223153648.GG9788@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223153648.GG9788@e132581.arm.com>

Hi Leo,

On Tue, Dec 23, 2025 at 03:36:48PM +0000, Leo Yan wrote:
> Hi Namhyung,
> 
> On Mon, Dec 22, 2025 at 02:57:13PM -0800, Namhyung Kim wrote:
> 
> [...]
> 
> >  #define NVIDIA_CPU_PART_DENVER		0x003
> >  #define NVIDIA_CPU_PART_CARMEL		0x004
> > +#define NVIDIA_CPU_PART_OLYMPUS		0x010
> 
> Just remind, this is duplicated with patch [1], so you may decide
> which one to pick for merging.

Oh, thanks for the reminder.  I've missed it.  I think it's small enough
to merge to perf-tools tree.  I'll drop this part.

> 
> Otherwise, LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks,
Namhyung

