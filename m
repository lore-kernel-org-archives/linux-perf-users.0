Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C41DD0DC;
	Tue,  5 Nov 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824902; cv=none; b=FrstwX2AWROrmOR8I4n97dceEuQahkKsKmiXeyBOBUaa+bwJkZOpwu/Zts62AJUJhysHLWg1eOWIhT1Dbw/Pggl5pPrKU7kl6QaATDARtaF/dg6B/Gp7cg7PqH3YtlGl8h+ASzbM7ZAVsi4QYhQ8ktxZAkgpVpDsJzU7kC1muVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824902; c=relaxed/simple;
	bh=w5LNjnL8bN89NOkJV3QdTW8R96XvIGdaMyqkSdyLA0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KwJzblqQMJLytdMWxy2Jlqull2fqqKFqiFadoqsBJ3vyDpl7Junh0Mt2PzarWLfYsFUb5+mEvJEbIbfOdXPMiX1hgqvDy6NuUWnnWN25HW4nEz6Yfpi63qPdEExKvPDgqjcjERutiZopJu8rR6AzKT10/0JxWJ68RkDNQLA/mWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz8I552x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz8I552x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C1C4CED5;
	Tue,  5 Nov 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824902;
	bh=w5LNjnL8bN89NOkJV3QdTW8R96XvIGdaMyqkSdyLA0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pz8I552xAOM/j0GNLHWwmwTYk+8MO17ONOV9IW0Z1O86+A9FOUT7i6EdxMr+RZUQz
	 fYwGUnvpfkUXVVwIVv1pDcuQ+qqW9RNpK2YAM4ck4sVPEMrJcFbasEV9xxnvIyLCxh
	 PAxkKYKgXaICGNiNhB6V1xHIzy9ikAdHmcq047w6rZxzURsHwWMPfr/m8BM6S57ZgT
	 ZpqydyXg0N6VvlsxDfyRdcZptBYz0Q7ZcqKp0GJKsCE8hAnr16Z+9KGh/ARwFIHZyi
	 FtfOa5IRWYhvYrpLUYkS/qv+fuV7QMs3Ekag8I3neJuAU8CUkkYCBU7UoaDoa7qiw1
	 vopjn5IGrtDWw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20241102231702.2262258-1-namhyung@kernel.org>
References: <20241102231702.2262258-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf test: Fix ftrace test with regex patterns
Message-Id: <173082490183.149345.8969186375573010854.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 08:41:41 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 02 Nov 2024 16:17:02 -0700, Namhyung Kim wrote:

> During the parallel testing, I've noticed some ftrace test failures.  It
> seems the regex pattern checks 100 msec of nanosleep with the error
> range of 10 msec.  But sometimes it's affected by other processes and
> resulted in more time in the syscall.
> 
> The following output shows that it took more than 120 msec and failed.
> Let's update the regex pattern so that it can allow more drifts.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

