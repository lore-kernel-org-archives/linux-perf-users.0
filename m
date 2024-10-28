Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237F8837
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730085219; cv=none; b=NLyjhWXPFVW0uN3I5rQDZCuhBFLCsXN8b+1X8htN9c4RZMcHElNGe/3dsveWUjMUL3k36fHQqRjX5rnlmgpMSqWSJeXacQT/zHfxVqsgwyo4X0epFX/Nt1AReO9qChJeJixX5y8/VEe1j7Mnze1TozCZg6wUiSJxEG6KY9MBJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730085219; c=relaxed/simple;
	bh=jxi1IVw4FLMkAF2ZyvZBQzFhh81JZz00YiPeZRD6VqE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=udY14rERLn0zpBIGmIi3T7Dx4xuCHXCSXGv6kvgIKWPmwpEZhJfNir0pYo5j0PrBy6OCmJLmylQRgvxTBwSGW452yf4hTADmMMFf0OuZVET1h/0qjgEIAvgJBTSimPd6T0uC5fVrb9KZdBCLO9unsoflZ06bAHZ8ppIlt+mz5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX/Pg+0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX/Pg+0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53460C4CEC3;
	Mon, 28 Oct 2024 03:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730085218;
	bh=jxi1IVw4FLMkAF2ZyvZBQzFhh81JZz00YiPeZRD6VqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WX/Pg+0TvOyhcUCOd/H9g7nbEzRRPLAk2gV5J4zWyHgyIFg5PuHB3M7dRbI7a09Jf
	 cjDPYyuXmuttqQG1e+s8yEYALgEicGfOVXE44sAhUTrC/2CvklRmYskP1nol9U3B6o
	 I+FXEptJqN3dzI6D5L6ofLb7Ieixc+OWrHt+Egmu4cU9baiXppxt9I0blG9iR10jHb
	 uwcjNzpNWg/1AC6E0oRdbXaxGyMVb63NJnQL+Qc4UPu6G/tT0R9U6cByXt6NS+aE9U
	 Ulw2j7DUdwzXPzZ1GgoJXmEri+VQ4CShxCVs0cvSFpuNnay6T1WGj938rAIvCtF3sx
	 pWM2C8VY6Un8A==
Date: Mon, 28 Oct 2024 12:13:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Can perf drop libunwind support
Message-Id: <20241028121333.92aaef3cc934432ace2e227c@kernel.org>
In-Reply-To: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>
References: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 14:57:05 -0700
Ian Rogers <irogers@google.com> wrote:

> Hi,
> 
> perf wants to build with BPF support these days. libbpf has a
> dependency on libelf, part of elfutils. libdw is also part of elfutils
> and amongst other things provides unwinding support. My understanding
> is libdw unwinding is used by perf in preference to libunwind when
> present. My suspicion is that libunwind is being feature tested,
> linked against but then seldom or never used. Given this could perf
> drop libunwind support in order to simplify the code base?

libunwind focuses on unwinding but libdw (elfutils-dev) is more general,
so if we can unwind only with libdw, we can remove libunwind dependency.

Here my concern is that the libunwind is smaller than libdw, thus
any small system may still need libunwind support. Can we warn when
using libunwind at this point? After all users move to libdw we
can safely remove it.

Thank you,

> 
> Possible savings:
>  - remove libunwind's 8 feature tests
>  - removal of 10 arch or not libunwind C files in perf
>  - removal of libunwind #ifdef-ed code throughout common files.
> 
> Thanks,
> Ian


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
