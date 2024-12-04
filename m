Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDD239186;
	Wed,  4 Dec 2024 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346886; cv=none; b=RKc8DYQSuy4+UnWfd7tAR2ZZOmo9pudKJLH7jX4MBcR2rmTcHGSmhU9+YGUg1E8cEuqYZx1Vw6/jAwlUiHs0BGuZpooAZBA/LVOWmeunN9bfdbjG3JXG9p6ocnE685Ato81WpPiQsbUAH50wkpWiUhh/CD+dkpNcN2ZG9/nPKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346886; c=relaxed/simple;
	bh=v8j3BUCG88ijthg2mICcvqP+ZMewN+fTTSM8Zj9u2sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw1gxKofMLViRAiSAEP5+ux7M9k5J+ZoAlUFdB8MRpyj+dBkfDXtvHoMvmJT8Fy3vuhFcaPtLWPlRN9se+P86a9J5H9ocEoVVpDvP8sH4fmzTAaF52EeM8wFkx2fYo+nJo6e63RAT3FKZklUwaO2iADu5itmXhdW0QlHV8XQMtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6Iv8K+J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6Iv8K+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79AEC4CECD;
	Wed,  4 Dec 2024 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733346886;
	bh=v8j3BUCG88ijthg2mICcvqP+ZMewN+fTTSM8Zj9u2sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6Iv8K+JNDAJ0uGpvWu0kZoHvBvoyUwgZx31Eu8iVQdpBNmjvqob2j5z5y5/pjT3z
	 ZjHKcNuKr2ygXvwvYo79P5xsiaDG8bx95yv/cYRB5h1484jW9xTORD/rQL2UkIVHHo
	 nuUqPI2P58XFz0/CxUEPUaP0PL95Ysz/9qFshh5vzSLidmtdZxkr/m6zhuvQr1K0DQ
	 CYW3kmunNlno/XrT+ZINfJmNr9lqbseQnl74jtPE6TFt6/gauxz+mUKYfciqvhKoat
	 aOgdMGF62mZxyA48i20q+KypQQo0QrYSA2SM4KMR2DeHm+w0DHhC2NnauqlECqNQO+
	 511sbfEnFKpBQ==
Date: Wed, 4 Dec 2024 18:14:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf script python: Improve physical mem type
 resolution
Message-ID: <Z1DGQp_ahnYFcF6J@x1>
References: <20241119180130.19160-1-irogers@google.com>
 <9fe0616a-edfa-4e51-9649-f19fb1d44821@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fe0616a-edfa-4e51-9649-f19fb1d44821@linux.intel.com>

On Tue, Nov 19, 2024 at 03:05:41PM -0500, Liang, Kan wrote:
> On 2024-11-19 1:01 p.m., Ian Rogers wrote:
> > After:
> > ```
> > Event: mem_inst_retired.any:P
> > Memory type                                    count  percentage
> > ----------------------------------------  ----------  ----------
> > 100000000-105f7fffff : System RAM               9460        90.5
> >   841400000-8416599ff : Kernel data               45         0.4
> >   840800000-8412a6fff : Kernel rodata             19         0.2
> >   841ebe000-8423fffff : Kernel bss                12         0.1
> > 0-fff : Reserved                                 998         9.5
> > ```

> > The code has been updated to python 3 with type hints and resolving
> > issues reported by mypy and pylint. Tabs are swapped to spaces as
> > preferred in PEP8, because most lines of code were modified (of this
> > small file) and this makes pylint significantly less noisy.
 
> Thanks Ian. A very nice improvement!
 
> Acked-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, tested on a:

  root@number:/tmp# grep -m1 "model name" /proc/cpuinfo 
  model name	: Intel(R) Core(TM) i7-14700K
  root@number:/tmp#

and applied to perf-tools-next:

      root@number:/tmp# perf script mem-phys-addr -a find /
      <SNIP>
      /bin
      /lib
      /lib64
      /sbin
      Warning:
      744 out of order events recorded.
      Event: cpu_core/mem_inst_retired.all_loads/P
      Memory type                                    count  percentage
      ----------------------------------------  ----------  ----------
      100000000-8bfbfffff : System RAM              364561        76.5
        621400000-6223a6fff : Kernel rodata          10474         2.2
        622400000-62283d4bf : Kernel data             4828         1.0
        623304000-6237fffff : Kernel bss              1063         0.2
        620000000-6213fffff : Kernel code               98         0.0
      0-fff : Reserved                              111480        23.4
      100000-2b0ca017 : System RAM                     337         0.1
      2fbad000-30d92fff : System RAM                    44         0.0
      2c79d000-2fbabfff : System RAM                    30         0.0
      30d94000-316d5fff : System RAM                    16         0.0
      2b131a58-2c71dfff : System RAM                     7         0.0
      root@number:/tmp#

- Arnaldo
