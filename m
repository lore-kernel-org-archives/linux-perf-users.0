Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EDB2010EA;
	Fri, 18 Oct 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264810; cv=none; b=hwOlhLxT0EpgTeSCDrgGeOU6O0p5i8qVjjStQ4bD46XJpW1juuW+9kCp92PKCwoNkjowkEj7uhvUrqFhLJliEav29w7DAinVoUyWdINcv477IV9wr/99LXKDBQZ7usJNPQjITQrdqI6AvQDKv/dNFJ2EZjQtQ0n7nCKHCmJsONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264810; c=relaxed/simple;
	bh=y4DrISeZVzRIlfXoffKtCEjelkoshbYi4XvZvyngL1s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=atAztO1CQISjObqLagNmeJsyXYMaxnwcNL5O7LGewv/blL+jfNwK/ZYBlPZsyjnm6KCPPKmqzu4J9ewIMKmFnolgnZcZwaVhTo3TebRqfAaG/dyUxJEua0COL7zWu6hfdUYQCZJJBkx3PHsaUVH8x8urKWcpP7IXAIFpiHSKTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHQEsX+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHQEsX+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D9C4CECF;
	Fri, 18 Oct 2024 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264810;
	bh=y4DrISeZVzRIlfXoffKtCEjelkoshbYi4XvZvyngL1s=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=jHQEsX+GAhcJpM19NTwXLuR2dilxekSWinXH698I5LavzJbVbYoP6ppeIwDiOcCPU
	 BIS+sBkdRjKs9uia54HJaWMLj4M4Tp2stOGlpjXcdTfuKpjCP34yjy81CQ4yGqVU+E
	 AInptXgv1OXStAGT4QfOx7XxNKnsrHkSxIN93Rwo/UXKxRpDARa/rsBlsRVQpOr9vn
	 veeJKQNfwuz+JLp5q/IpOOQcJGB+yFf/xzb+gwxH9ivDuSoHW2haLz5BlVnMpj1qK3
	 NnUDn03VmqOdj2d4VZF9SAJ2Jm5pDUzNBqCYwAOAlDze9C0Q05lgJO5AIVro+CuzhW
	 9CGiZffNW4Fsg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Yicong Yang <yangyicong@hisilicon.com>, 
 Tim Chen <tim.c.chen@linux.intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, 
 Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
References: <20241017175356.783793-1-irogers@google.com>
Subject: Re: [PATCH v5 0/7] CSV/JSON metric thresholds, fix printf
 modifiers
Message-Id: <172926480967.1381973.12650335764215597685.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 08:20:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 17 Oct 2024 10:53:49 -0700, Ian Rogers wrote:

> Metric thresholds are being computed for CSV and JSON output but not
> displayed. Rename the color that encodes the threshold as enum values
> and use to generate string constants for a json dictionary
> value. Disable metric thresholds with CSV output.
> 
> Add printf attribute to functions in color.h that could support
> it. Fix bad printf format strings that this detected.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

