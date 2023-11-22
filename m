Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBAA4AF93
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeTRur9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E42C433C7;
	Wed, 22 Nov 2023 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700654172;
	bh=gcIvVi41TiyJFoCAf0hPX4QrNIjbM2fEg39e1k2zPfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UeTRur9HRU867a5vrzWtdMYaOxKNsKKQC+Fn2VgYaBrmnbh17GxEpVgybUrCUK/Yh
	 C49WykXj9WHZVav4xJtVcoxYvKd61JdP1z7yfGmrq7LPsVTP+qJ7OEHMc6T239akp4
	 CobKPWMU0cyWB+4+krxBOYP01kZVt/UDY+IOln9R/rOUL4axdwfVl4UbGZiFDSQZzV
	 aiH9PfHC416dOq749PZ+Jrsw908B8vKB2S306JV/bBKJW/u5/VRRzP+qPYvVCxvTPd
	 /98VXgdn+5/JKSIoJ1KqZWusnhcxhU7kQYvjlj+Q1Ag9DfXcN259l0Mpx4hVxml4g6
	 Y6sqhte2ddGsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id F403140094; Wed, 22 Nov 2023 08:56:09 -0300 (-03)
Date: Wed, 22 Nov 2023 08:56:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
	adrian.hunter@intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V2] perf test: Basic branch counter support
Message-ID: <ZV3sWeqnuEZYsTHA@kernel.org>
References: <20231107184020.1497571-1-kan.liang@linux.intel.com>
 <85aac482-2318-4fb5-be8a-b6d17e19407b@linux.intel.com>
 <CAP-5=fVqWc70w1twQdOK3u6dzS_u3ELAtcr--qmiP5x+vkbK+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVqWc70w1twQdOK3u6dzS_u3ELAtcr--qmiP5x+vkbK+w@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 20, 2023 at 04:22:24PM -0800, Ian Rogers escreveu:
> On Mon, Nov 13, 2023 at 8:12 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > On 2023-11-07 1:40 p.m., kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>

> > > Add a basic test for the branch counter feature.

> > > The test verifies that
> > > - The new filter can be successfully applied on the supported platforms.
> > > - The counter value can be outputted via the perf report -D

> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

> > Any comments for this patch?

> Confirmed the wildcard works as expected.
> Tested-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

