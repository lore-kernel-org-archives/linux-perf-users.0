Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECE1DE2CB;
	Fri,  4 Oct 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070155; cv=none; b=M6x1h90AN7TukbIFqGa3s+T+gdXsiKDZFnESCygXJNtYR1VZ78Obm461CpBK86yCAGasO6hdk5q8FZYbP8KMdG+unrKf5NbnkY2USMd+Vl5LKl5bbFyIptLyhUfbey5SPDYwaLspOrhGvT8pt6C1mrJqoKDId+wsFtB6HBVJhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070155; c=relaxed/simple;
	bh=tWSO/MncUs1SQCjxuxhVbYn2mD412cgL14vVOxyUSgw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HyfvcPFhs3m6ulyPrXFJA34/7ZFYx8lVg6jdBqvuCjpW3HnJp0QIfoCEPnUjPGDtXKdO1mndzL+vJZApd5wJngvEWtA5lc7IIYeo0jwAxaZ/M5k0z4kCUFSOgxVIWbjk9m6z0vZYKvhgrJh0Ih9KS2OwmiBT271atNJ5yMxg0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku2/lF1+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku2/lF1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244FAC4CED0;
	Fri,  4 Oct 2024 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070155;
	bh=tWSO/MncUs1SQCjxuxhVbYn2mD412cgL14vVOxyUSgw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Ku2/lF1+yKZDF88sR/4OHYtFIFt1tWKzPPjHDafmvXmygyqjR4vMDDcp9MzxG7ccs
	 Bop1qbvkU/jTOMe5jKpV1QYzHhVPUiKOEAlROJzNDf38vAxJiZCjBGxyh9JTxmipjR
	 hY426tLKafe4o5vMgecESUG/EAGjWktFwwSh4+8oRWAyqtqnrXi1wA5UpUfzJscaUG
	 ZxeH8OHdHGbU7nDDoXMfH6+t1YqoHnVR3Qr22JnEaaJS94RU6pkgPyc4nwbJNXcJsS
	 rfW1eM6gn7Czt87iqu2o3yUT/qW2fzBkb7fyzAbW21Va6Mohe+0SUu31jfYvNpOg3f
	 Gok9490kW+dXA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Besar Wicaksono <bwicaksono@nvidia.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241003184302.190806-1-leo.yan@arm.com>
References: <20241003184302.190806-1-leo.yan@arm.com>
Subject: Re: [PATCH v4 0/5] perf arm-spe: Introduce metadata version 2
Message-Id: <172807015510.55364.1507347316107566234.b4-ty@kernel.org>
Date: Fri, 04 Oct 2024 12:29:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 03 Oct 2024 19:42:57 +0100, Leo Yan wrote:

> This patch series enhances Arm SPE metadata in the Perf file to a
> version 2 format and maintains backward compatibility for metadata v1.
> 
> The version 2 metadata contains a global structure with fields for
> metadata header version number, header size, CPU numbers. It also
> expands to store per-CPU metadata, which includes the CPU logical
> number in the kernel, MIDR, and capacity values associated with Arm SPE.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

