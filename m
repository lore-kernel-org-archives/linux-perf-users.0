Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E801CDFD6;
	Fri, 22 Nov 2024 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313871; cv=none; b=pRb4oFeFaT0JX3fXtwA9I5I4c7nqt5KJDqCGhVAdRN8br7d3h45zWGPAB1pAqbFPueuBwhcBqSL6aShgBXRNHmo7Z/RYR70H0a5q9DhYVEyzI2NUYrIByzjV9b9B0ZgqJye3efiX2oo3lS+mZ4jf/pp0nF2HJAVvE5rEvbsFX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313871; c=relaxed/simple;
	bh=6hwKYHDOrM/LwHWY4msBD9He9un2OwrT1l9SqCndWaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GKkYVTvPNY9vVKncZfQODN7BiMQV43Y5cHgLDewG9aBjWzn3MbudzOpBPRhKqd2lmi/hPL9rthOUcUg82CqenzYc5q+SsPZURVlPhXpNCHnxKn+Zep8FWQ82y8cykTkpXxziYrXUFH7OqJVC5MgKFI22MDuKDuQne66/9IIP5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av4dvsh6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av4dvsh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA78C4CED2;
	Fri, 22 Nov 2024 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732313870;
	bh=6hwKYHDOrM/LwHWY4msBD9He9un2OwrT1l9SqCndWaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Av4dvsh65/V3zuMLkySKSHBWIgf4cQYUJOPy8CemS5JFy3vZwly/TjTbqKYnFFNlE
	 2xX5YcYqqZ+uJ6C7TMaU8NRihfgLtYXkcvAGvN2mcFgJpkAG3IwQ9C3XE2HP6KmJwj
	 HdcCaABVZsdYynZpsJmrQ1fxtdOqsfpNuchFnjrWc+nYy6CSuOO+tWQkrFax6fdqyH
	 BYbaOy97bdd9jKMNvv+b4L2f90adrbWaScyaQF7XIuodpBaG5FskkjPYYdfLA6EEF/
	 a3xS/RpA3yfAngCGckDf0MmedNxU4q0qPIHyQNUeWTdsySAkmLXGJlhzt97+up1XlL
	 6W6O0iL4lrIgA==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <ZzzoJNNcJJVnPCCe@x1>
References: <ZzzoJNNcJJVnPCCe@x1>
Subject: Re: [PATCH 1/1] perf tests hwmon_pmu: Remove double
 evlist__delete()
Message-Id: <173231387022.85365.16474276225290278801.b4-ty@kernel.org>
Date: Fri, 22 Nov 2024 14:17:50 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 19 Nov 2024 16:34:31 -0300, Arnaldo Carvalho de Melo wrote:

> In the error path when failing to parse events the evlist is being
> deleted twice, keep the one after the out label.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

