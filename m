Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADA3C9444;
	Wed, 11 Mar 2026 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224486; cv=none; b=hEOuMke8MBcRenGpp5PHL1SVs0MjfUmrBqGo4yMgneZqJ31aM/d4/11myZvbfmnWKX1CW5wmYvk6aR0uvDZfhyG2rCnPIu21DZbxrvahOB/3us8nIzrMSPyxG0Pr1igmfX8j+/ON/pxvCH0v79FAOTJGUcntA+Ll4tfWBYbidnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224486; c=relaxed/simple;
	bh=9B80gy4b8eyziKxoQCoYsZtZL+yEkuBSTXQbPAmPnjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnoNPJw7zT1zCsvBlzA90RizL7KduZ8StscTN8aWvOO8ketUQjj9Nls9FlPyggO97jimNBZzsoHddgLEwjszr2fB5xtj2KuNnD6/mzY7DZcWnWI16Rovn/DwIfAMLg+OCUzoHkmZ1iU0q5US69sx/TtnVvpiQvg5Itp5m9PEibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DAg94XJc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DAg94XJc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9B80gy4b8eyziKxoQCoYsZtZL+yEkuBSTXQbPAmPnjM=; b=DAg94XJcfr8rZMEJJBuPfvH0sH
	mHPKiwFcZIiuZCxZwJ4l2lxU6S9giEEI+QUiOvtm6ryZDOHySw2xRC7mh2DS4psMsrWozJJ3CkY0s
	7GyogwyON96Mp9wxS4B91h9xdwvivQppIhS/ph6+v14ksmJOLTsWwFzdPl5sQP7NJunS0GQC8KcO7
	M35Zrkb8BX1N5yNXQXOFTQM7ecsfvEfROAEsjhbZiOKe5rTYD6zA/hfY9H8NxUTpSuSM3wlkFQ6nU
	08tqhYhjFKIH5bu/9YaYmAePzL8y3M+zAoq74++In8qVK6UqrKoZieJ0AvPKUi0yGrDI5yeZWLNK+
	5Bdh9tSQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w0Ggb-003hNl-Lc; Wed, 11 Mar 2026 10:21:05 +0000
Date: Wed, 11 Mar 2026 03:21:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Ian Rogers <irogers@google.com>, leo.yan@arm.com, acme@kernel.org
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Denis Yaroshevskiy <dyaroshev@meta.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
Message-ID: <abFBoVrlGl9cIg1h@gmail.com>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
 <20260205173918.GB3529712@e132581.arm.com>
 <20260205175250.GC3529712@e132581.arm.com>
 <CAP-5=fUY8dYzwKu-g3-HER4ji9ZeGmPQo9DeORW0w9ocW1qnMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUY8dYzwKu-g3-HER4ji9ZeGmPQo9DeORW0w9ocW1qnMw@mail.gmail.com>
X-Debian-User: leitao

On Thu, Feb 05, 2026 at 10:22:27AM -0800, Ian Rogers wrote:
> I think it is a different issue, they have metrics while you don't.
> Your report does highlight we're missing a NO_JEVENTS=1 build-test,
> but the build is working for me. I'll send out two patches for these
> issues.

Hi Ian, Leo, Acme

I wanted to follow up on this. Are there any next steps I should take?

Thanks,
--breno
