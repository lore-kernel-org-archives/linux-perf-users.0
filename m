Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F372F43;
	Sun, 18 May 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592547; cv=none; b=menoZ6sTTompfDx5N3eUW4jF4vId6GDhdANL74cHvHhJcL8uBynh5RklqctK9I3BelpSy8lKed6p87bnOgQwxIzIhBrBouOLGzebAi5tLO9jjbQnuRX/PGNrxLTi7CplF5ScCK5/5p7cjTpyMT+3blQWaYXtxwiVYlV01vAX+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592547; c=relaxed/simple;
	bh=EnnWZB0MZexjMCxP36KNpsbyoK0cjDvkX8TX3PirRJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5URxrv9ayDSev24KbtFgC3BPQisIcTY1P9O5VO3DXVKzFumnW3YB4ubXt+Wo95KJ0//CFJXAcU2EWxYdpiQJS1W3b0sePRUWUS353tvflhE6oKgA+7pxBq4+dGPuHGa59ZOZCTCpKXnjIa2sn0fcFjetdHdti5XzCGwoqvxwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maqrxpi3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maqrxpi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28723C4CEE7;
	Sun, 18 May 2025 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747592546;
	bh=EnnWZB0MZexjMCxP36KNpsbyoK0cjDvkX8TX3PirRJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=maqrxpi3IRvVCV5MGiHONoKbNmT/aoH1u2upsW9aOd4LTKV2Czyz9mAxYdAbQksbC
	 Rmi9yNXDVS17TjSdhGTELsJkcdgd39uTKxNuOpSESenRWPCu1i+K8uVQeUAGaTl607
	 spUTlBA6V8MkNGoLm9aZ2C5536zHt0DCBzVWpoQMNwHiMN6XWau85XLVhFOUIuUjbW
	 jOudksV7AEY6ICKygYeZuM4dXsf2cSBPygApUUDhEb9naa6RCO1oduAmAxFEHfWLXH
	 ZVPY1GpovPNZX4KPIyg69iqEwH8GqeCP4GDOhafgZLTmISTbIH8xmM03iB4Skxmodb
	 NtU4sZwED2jUA==
Date: Sun, 18 May 2025 11:22:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: IBS perf test failures on 9950x3d
Message-ID: <aColYM3RqE4T5t5c@google.com>
References: <aCfuGXUnNIbnYo_r@x1>
 <33e86415-c90d-420a-b7a8-6a360769aea4@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33e86415-c90d-420a-b7a8-6a360769aea4@amd.com>

Hi Ravi,

On Sat, May 17, 2025 at 05:33:19PM +0530, Ravi Bangoria wrote:
> Hi Arnaldo,
> 
> > If it needs a specific kernel, then the test needs to cope with that,
> > etc.
> 
> 1) Bunch of IBS kernel fixes went in recently (v6.15-rc1):
> 
>    https://lore.kernel.org/r/20250115054438.1021-1-ravi.bangoria@amd.com
> 
>    Since you are running on 6.14.5-300.fc42.x86_64, the failures are
>    genuine and indicating that kernel should be fixed.
> 
>    I'm wondering how would the test cope with the buggy kernel. Or
>    probably 'perf test' a wrong place to put such selftests?

Maybe... some kernel internal changes can be tested in the selftest.

And 'perf test' should work with any kernel versions.  Is the test
checking any invalid configs?  Probably then it should move to the
selftest so that it can be tied to the fixed kernels and 'perf test'
should only use valid configs.

Thanks,
Namhyung

> 
> 2) "mprotect() failed. Permission denied" seems to be because of
>    SELinux enforced mode? I'll prepare and post a fix but, even
>    with the error, it's just part of the dummy workload function
>    so wouldn't break any test functionality.
> 
> Thanks,
> Ravi
