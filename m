Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE932C65;
	Wed,  8 Nov 2023 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgadgllr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE109C433C7;
	Wed,  8 Nov 2023 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699476535;
	bh=bAnaPB12EhMMxlOPREjkkP5xb54JhV/TtGOOJB6uzf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgadgllr5jTXFXidg1mZbniQ9QzWyHD0VkgNcAfMM50BAd76WfQ9jgO9vaD0wS5Lv
	 0Dq/cs9mvrHY8EeF6Yycz5jUeuv3D2o7MkliQoOY7SFyhMddkbqF9EtHmfmOSKX8Vg
	 isPNc0tLVeYMjQxXKNfvKXYMDo3iFUo8b46TT/WNmtpQmiCJN4gEqWCQOhmzw1ib7S
	 pipEly93WVHxWz+Y+yyJFnpilVahDEO9QyOpyva7Jd8QhWaD6rgkNU6AIuXBv93w/3
	 LVF6FYuFOqE3neMhzJHk2W9xlWHYfh8bYr9Z7vsYcSK78MkIeHSoFshkz8QEgVxwOp
	 HoBtXVrYv4m+g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8BAAA40A1E; Wed,  8 Nov 2023 17:48:52 -0300 (-03)
Date: Wed, 8 Nov 2023 17:48:52 -0300
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
Message-ID: <ZUv0NKS7d4vYQMxy@kernel.org>
References: <20231103113501.490012-1-james.clark@arm.com>
 <CAP-5=fWazX_q1W8HN7ErrRMB2bx5sz3x1V=+XqY7Hxx0jR0p9w@mail.gmail.com>
 <47e3d265-e48e-238f-7528-b0eb4c250cb1@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47e3d265-e48e-238f-7528-b0eb4c250cb1@arm.com>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 07, 2023 at 09:37:32AM +0000, James Clark escreveu:
> 
> 
> On 03/11/2023 15:41, Ian Rogers wrote:
> > On Fri, Nov 3, 2023 at 4:35 AM James Clark <james.clark@arm.com> wrote:
> > > 
> > > All of the other Perf subcommands that use objdump have an option to
> > > specify the binary, so add the same option to perf test.
> > > 
> > > This is useful if you have built the kernel with a different toolchain
> > > to the system one, where the system objdump may fail to disassemble
> > > vmlinux.
> > > 
> > > Now this can be fixed with something like this:
> > > 
> > >    $ perf test --objdump llvm-objdump "object code reading"
> > > 
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > 
> > There is also "perf config" for things like this.
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks,
> > Ian
> 
> That seems a bit better for this use case so I added it in V2.

Have you posted it?
 
> Thanks for the review.
> 
> James

-- 

- Arnaldo
