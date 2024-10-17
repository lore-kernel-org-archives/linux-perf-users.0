Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176891DF73A;
	Thu, 17 Oct 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183161; cv=none; b=UQGscK6MMlujZDYSp9OeUM4ueHFbuEQCIMS+uPaVscZ7rYN0fIbALu2mqeDUk0eTwuK2ueBcRJWmE0iyFf8gtF3b93pv/ZH8P+4mGKZvwqjydw3eIz5+CI2u36Av0nAsAyq39aPwCGxy83e+u4cK13lDg7EcB+9ggyNxPYBk86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183161; c=relaxed/simple;
	bh=sQmjhkW1sVHwavY1/+k1svK1lnupAJBrdjjQaarKm6I=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NNGNyp1zLGbRdXtItgoS/s0myWb6a/fPia5VfZXVY4yO/Y8ECMT7ufVgLkn7NzD+X557vVcZ4z0tvwy34SUdTt7j7r1o/8tYD2Y92cyeb9G7SPKiAjP9vmUpT1cP1EbNFXbRo6K9c19kLOJyKyEj8yEbXXPz5P7k02zlnU4jHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQh9wuNQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQh9wuNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573C1C4CECE;
	Thu, 17 Oct 2024 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183160;
	bh=sQmjhkW1sVHwavY1/+k1svK1lnupAJBrdjjQaarKm6I=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=rQh9wuNQRpbtWPiTzJb2H4B0GSvr9T0v0zkF73raMagLHakbncXKsfJiL5d2dckpy
	 lNIU2il0q+uP2hhx9fltJEvqm/zMkoDHq6J3dSJ2cllrx6H+TTCOOQV9mYCtK33I9F
	 c/3Zf7hCHkiMNeQm/tWfviJLfN+I9jbTC07SyKcoMDqrY5SnzX9sJpmZRepirGrpyK
	 3dxbImaNM5fDS/6Jd93c/f9Otc7zlCgJy3+01JqS7ggyjLwignW4YgRXARFua8Lz8O
	 +YiSRXjyKAOkgrtXDnV8FTwdkLso/r7wsISZwZ6TDp4B8T/2/bv4MO2BPy7zWmwnV6
	 1DS3/7ZgUJyGA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
 Tim Chen <tim.c.chen@linux.intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
References: <20241016175350.116227-1-irogers@google.com>
Subject: Re: [PATCH v3 0/8] CSV/JSON metric thresholds, fix printf
 modifiers
Message-Id: <172918316032.639809.5792146702013848062.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 09:39:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 16 Oct 2024 10:53:42 -0700, Ian Rogers wrote:

> Metric thresholds are being computed for CSV and JSON output but not
> displayed. Rename the color that encodes the threshold as enum values
> and use to generate string constants in a CSV column or json
> dictionary value.
> 
> Add printf attribute to functions in color.h that could support
> it. Fix bad printf format strings that this detected.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

