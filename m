Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983B176ABE;
	Fri, 12 Jul 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802814; cv=none; b=iWHmu9HNSkC5+eKQofY/5flxQhqA6zRETKZ3hfbyTWDbMsnY13VKwfKgp/dmWKQ9hNqdrJMCKEOXdhsSOK+TcYu3AATZcAEtF36+LHyagXLzdnY6JkyWgVUKruYwek9FhRZh2i7y0wm5m6+FtBDy8yuw/rTbA7e7GrRjSuyK83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802814; c=relaxed/simple;
	bh=bI2ezQh2M3Ni7Iiyoa9aHW8MY1yWFJgdpTY+fceKi40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y21Qs8/wgF7nNWSzpauAzLxBPz1/TOzfEL2PqSwT/xj7QV1S9pL++jcV/q5fxC3Z9S3m2LHxg+PPHMr+EOkehlPrYubb1bKdURxxoyQ8/N8GPZGtyOceP1/cKde80E7U742gdWlXkhgu4lvyau2Pj3AlxT8yjDigxIoduTfAgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNpQ6meE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNpQ6meE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F55C32782;
	Fri, 12 Jul 2024 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720802814;
	bh=bI2ezQh2M3Ni7Iiyoa9aHW8MY1yWFJgdpTY+fceKi40=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GNpQ6meEAK6RcDPsD0PWUCWKTxyZRPVFh8RKGZ6up53eZa6Rca5suH67yLXud05Ia
	 gj7Jw9WrmegWJQ32UknOHn5GZlozl6VGuTc3Liq37N7/YcbHsQsniu2WoI8iVnwKDo
	 fe3eD0UuDnuEE3uYU9EVa0lP/exAbITVHInKxajx76Zt796y/dbqMPPphl6qkYleua
	 3H+Mga7aM0rMrTEo6hoXtvi6ne6mJS90hVUnaYHM2eZmWOA0+3o7qOleuhl/8BY1br
	 S6gmJm6l3EXmh2BtXJX6m6DaBKewkohCCMhrVQegxjOumBXd2tCzkb7BOJjNYE8M4c
	 qFg5115H8M2GA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yunseong Kim <yskelg@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v1] perf dso: Fix address sanitizer build
Date: Fri, 12 Jul 2024 09:46:52 -0700
Message-ID: <172080280090.2773964.7861842320285043565.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240704011745.1021288-1-irogers@google.com>
References: <20240704011745.1021288-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Jul 2024 18:17:45 -0700, Ian Rogers wrote:

> Various files had been missed from having accessor functions added for
> the sake of dso reference count checking. Add the function calls and
> missing dso accessor functions.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
