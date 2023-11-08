Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49F328D2;
	Wed,  8 Nov 2023 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC5KrxqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2FBC433C7;
	Wed,  8 Nov 2023 20:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699476641;
	bh=Uelb5NqzbNEI8JHBq/JEHRinkFc436EpDrK/QpervBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC5KrxqXq7wg8Fj/wobOL+FxhDDXZBk40qTZq3I4E2DMTPCjFrnJgpDJ3f7BNIwYT
	 ECsz/29pIXsCQxEWlcPWXp/CFb5d+dTbBuyT9jXw6y7/k4G/7SCIdOjZhQJQKppC4d
	 TtHFTaTSgkWUSZtWJ9OQHjLoRdjgXf1jMbUdQHqLfCtD78hXMeI4p2384fLsOHxfIG
	 TfADaio/zYVIJV5GIkBHATgqBbgzw4z4mKMQeFQwkymPnLQlLWozZjmGO3dMXWVjEZ
	 BdlGBF8RRgknahAjOm6Cvxnz7rcFIKq0VR3C7EhLWWsHhn7K7jjeLOuDw3LjFloajb
	 EmsFg3DX3CT5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id E69F640094; Wed,  8 Nov 2023 17:50:38 -0300 (-03)
Date: Wed, 8 Nov 2023 17:50:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] perf test: Add option to change objdump binary
Message-ID: <ZUv0nsO19pFs0lXS@kernel.org>
References: <20231103113501.490012-1-james.clark@arm.com>
 <CAP-5=fWazX_q1W8HN7ErrRMB2bx5sz3x1V=+XqY7Hxx0jR0p9w@mail.gmail.com>
 <47e3d265-e48e-238f-7528-b0eb4c250cb1@arm.com>
 <ZUv0NKS7d4vYQMxy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUv0NKS7d4vYQMxy@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 08, 2023 at 05:48:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 07, 2023 at 09:37:32AM +0000, James Clark escreveu:
> > On 03/11/2023 15:41, Ian Rogers wrote:
> > > There is also "perf config" for things like this.

> > > Reviewed-by: Ian Rogers <irogers@google.com>

> > That seems a bit better for this use case so I added it in V2.
 
> Have you posted it?

Yeah, b4 found it, nevermind.

- Arnaldo
