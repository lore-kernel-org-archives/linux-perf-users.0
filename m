Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2243786357;
	Tue, 10 Dec 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855060; cv=none; b=qRFjAm2LcIfaULqzRA1I6CjqYPVpwwBeFUbnxYFK6YBLFqt4sIMbauX6ruhWV4xLZxG8ApsA0Rsqy9LebWJNkCMw6PnIstUWP0Kry7kfUIgJGNG2hk8e627uvBpLtl0ZPhEyVgWvg7ht6SEDZTnPy71+LyF3h7HTbp8WiV1GeaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855060; c=relaxed/simple;
	bh=jGy78569S4tV2WAiXrkQv4BrwK/R7Y2sD93xKm9soio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxD94O6g0D5IU9OVnfDChC8h9Z02IgaQ+uSQEFMYo8Q1GP03tq6DUEXu64Nl0YGDuIsA+yBjG88Oz9PSW9YFG4XGQZabj0vVPT7n3Gtu/lmGPY/WgVfaMO3jrYlhWyz4PM5lRP7kQGUV7I1Hl8jOV60hFSY3ELMFYuiz84zq34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2QKUf3s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2QKUf3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CB6C4CED6;
	Tue, 10 Dec 2024 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855059;
	bh=jGy78569S4tV2WAiXrkQv4BrwK/R7Y2sD93xKm9soio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2QKUf3siGL7b6NroqQ4bX6UOEldaH4jMa9iaUtMl34MhNafRFDzuJugwjQ19180X
	 9EPxDAzpNb4Te//KkTwfV/obX9sDN06CaMuyoLm43cj9NElPdlAu1VB4SiXY1Z/+4H
	 Ji8Zc51ycYvXNCzg0JvOrPNcr5Dn9YTM573oSgzu4wtfizkGSTHJiSTlkWTavoSChr
	 64ItN0Nb1uIYFkSKkpyMSf7uvZdaqBS3tpgmAYVSHs9j3l6LQ51XqR2uxF5VSEzLpA
	 zcSoLiwIl+r0xkZ+zuFZD2VQy3VNBttqZ6LIkE8fmQztG9mmLekB/AUsgEGysMEd6+
	 YoMllr+dBYoXQ==
Date: Tue, 10 Dec 2024 10:24:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v9 01/10] perf record --off-cpu: Add --off-cpu-thresh
 option
Message-ID: <Z1iHUTN_T4xZcrgj@google.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
 <20241122043840.217453-2-howardchu95@gmail.com>
 <Z1eGw52LThYh1Gjx@google.com>
 <CAP-5=fUm6kWmX3FzFYJ_xoBgfgs0zPigyMKLy7VrXvNt1sC+iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUm6kWmX3FzFYJ_xoBgfgs0zPigyMKLy7VrXvNt1sC+iQ@mail.gmail.com>

On Mon, Dec 09, 2024 at 06:24:21PM -0800, Ian Rogers wrote:
> On Mon, Dec 9, 2024 at 4:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Howard,
> >
> > Sorry for the late review.
> >
> > On Thu, Nov 21, 2024 at 08:38:31PM -0800, Howard Chu wrote:
> > > Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> > > the unit is us (microsecond). Default value is 500,000us (500ms, 0.5s).
> >
> > I guess we mostly care about more than milli-seconds of off-cpu times.
> > Can we change the unit to msec?
> 
> I wonder if there should be two values, one for the command line and
> one in the code. I think microseconds make most sense in the code, 1ms
> being roughly 1000 context switches. On the command line millisecond
> would align with perf stat's -I option, and as you point out, users
> aren't usually working at the granularity of a microsecond. Having the
> code be microsecond oriented allows the option to have a more precise
> command line option in the future, autotuning, etc.

I'm fine as long as it has a proper suffix for the unit. :)

Thanks,
Namhyung

