Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AE33CD7
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2023 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isIs17Dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F5DC433C7;
	Thu, 23 Nov 2023 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700749889;
	bh=c7OkPUznAAchcebEgWWplu2JA5cYUW6AoggSDeYEnUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isIs17Dtqp+pc98n2d7ijWAn8hxjijg6LS2cnd/eWW9B8UNaPtGFGa6wDyi0dNoes
	 7rOXhM7yybPW2CXmIEPrz8ObL1t+vsePn7hxo9E28d/YyNKZ77xw1bfQr7FA6xp/9u
	 kF6KtDK6Lrm9K8/HZ+ryF/d6Jpw8BiFyXFoOqN8r8C0PZutmntxd4tOneh7NHCWlQx
	 VdLkH8qSot+BuMJW95lVx3/Pxm8AL3X3f0F7d9haY8QPu+5MPGM4Ry4UKYBP3O+dk4
	 ntKROYy9XQVsAxPC1bTx1Fa5wioCTYUkqRpakuLEXW72iXAnChWem++lHhBy+Fbr9B
	 7LOp9sts+vIxg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 7F73040094; Thu, 23 Nov 2023 11:31:26 -0300 (-03)
Date: Thu, 23 Nov 2023 11:31:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Bump minimum OpenCSD version to ensure a
 bugfix is present
Message-ID: <ZV9iPl0q5Clt9fNY@kernel.org>
References: <20230901133716.677499-1-james.clark@arm.com>
 <CAP-5=fUE2jVDXCMszLDTmrhJ67mXi68yt1581i9R42G80p=QsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUE2jVDXCMszLDTmrhJ67mXi68yt1581i9R42G80p=QsA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Sun, Sep 03, 2023 at 08:36:35PM -0700, Ian Rogers escreveu:
> On Fri, Sep 1, 2023 at 6:37 AM James Clark <james.clark@arm.com> wrote:
> >
> > Since commit d927ef5004ef ("perf cs-etm: Add exception level consistency
> > check"), the exception that was added to Perf will be triggered unless
> > the following bugfix from OpenCSD is present:
> >
> >  - _Version 1.2.1_:
> >   - __Bugfix__:
> >     ETM4x / ETE - output of context elements to client can in some
> >     circumstances be delayed until after subsequent atoms have been
> >     processed leading to incorrect memory decode access via the client
> >     callbacks. Fixed to flush context elements immediately they are
> >     committed.
> >
> > Rather than remove the assert and silently fail, just increase the
> > minimum version requirement to avoid hard to debug issues and
> > regressions.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

