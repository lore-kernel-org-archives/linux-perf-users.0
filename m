Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370F2575B
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn0GNNcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DA1C433C8;
	Thu, 23 Nov 2023 14:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700748419;
	bh=7AjvflHZ4Q+tu2gcCZ/AZVRiLJFF8yXIkk94/htWwjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pn0GNNcfjUmL+7d0znpJmSBi5Yw0vWYwinKR+w0AGhbKoxycoTMusmCIXXBXUIBc9
	 h7Yf9xJY039OIOZ6p8D5yt3e8OOgA0zd5ODTk8hamd6R0xnJ5mlrY3RBVFmmxH5f/r
	 4ehKuQX3/03Jcjam0q+umi3OChh/oYL5y4x9CfRXMVJ9SS+UMl9vkfQTc7kJVQICGm
	 jrptxGUXHNOXYhPa6fzqWk51sQkS7kzX6LnpB5WAJAWhTsE0YGcN3IR+mlcmcQ00DC
	 1lOFwF7T7MpyfekIUrQAte4H/tXXFNX9oBNG0dmwgf0anY2w+w2UUXdwuQYmIc13xd
	 IxIbJnLu+oz7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B179E40094; Thu, 23 Nov 2023 11:06:56 -0300 (-03)
Date: Thu, 23 Nov 2023 11:06:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Tinghao Zhang <tinghao.zhang@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
	German Gomez <german.gomez@arm.com>, Leo Yan <leo.yan@linaro.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/8] perf tests: Reduce inexplicable test failures
Message-ID: <ZV9cgN3e7jWcRwlu@kernel.org>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123075848.9652-1-adrian.hunter@intel.com>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 23, 2023 at 09:58:40AM +0200, Adrian Hunter escreveu:
> Here are some small changes to help reduce inexplicable perf test failures.

Looks ok, applying to perf-tools-next, had to remove a patch adding a
new test, by Kan Liang, then reapply it on top of your series, git
managed to sort it out:

https://lore.kernel.org/r/20231107184020.1497571-1-kan.liang@linux.intel.com


- Arnaldo
