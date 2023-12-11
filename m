Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C25D53E34
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP5/9UhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D7C433C8;
	Mon, 11 Dec 2023 21:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702329061;
	bh=a+qGimpcS1XQx24G9vOBh4tKYNM6jWiH7OMmuzR5zQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dP5/9UhPVl6nKQWLoP7qog/NjAcRskX8/RsAWw+CIwmIyJMZ9tJCr9RdFNtnDQLOY
	 Y7YOYzsnlVI0dHl2jUPUrndGfTEQn+hDZ04rGdPtp25pZcI7fVrbaH8iOjm1NE8WFn
	 3RLq+qVENCKsKrekGqlO0FXZDmd5qnbQNWdePP0ZifyiS01IXcwjTB2v4UVhqHSnFJ
	 Hbrti4gmZrzDAwR9zPkGGLBwidIYlymY/85Q9I93F1Kknz8x18jt/bjitdEQxZhnAh
	 HsjVef6IknRW47P8UGWqOVFdxzrSGvC63F93BeX9TJf8o8P8lvjwbPw63+Phign5qv
	 pEj4JUMDSvYgw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 4F04B403EF; Mon, 11 Dec 2023 18:10:58 -0300 (-03)
Date: Mon, 11 Dec 2023 18:10:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: 'perf top' broken on intel hybrid systems
Message-ID: <ZXd64qLLDTEJjSmb@kernel.org>
References: <ZXNnDrGKXbEELMXV@kernel.org>
 <3a8c66ec-537d-4e29-bf08-226dd41b08aa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8c66ec-537d-4e29-bf08-226dd41b08aa@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Fri, Dec 08, 2023 at 02:39:37PM -0500, Liang, Kan escreveu:
> On 2023-12-08 1:57 p.m., Arnaldo Carvalho de Melo wrote:
> > 	So I finally got a recent Intel hybrid system:
> > root@fedora:~# grep -m1 "model name" /proc/cpuinfo
> > model name	: Intel(R) Core(TM) i7-14700K
> > root@fedora:~#
> > 	Most things work, but:

> > root@fedora:~# perf top

> > Error:
> > The cycles:P event is not supported.
> > root@fedora:~#
> > 
> > root@fedora:~# perf top -e cycles:p
> > Error:
> > The cycles:p event is not supported.
> > root@fedora:~# perf top -e cycles:pp
> > Error:
> > The cycles:pp event is not supported.
> > ^[[Aroot@fedora:~# perf top -e cycles:ppp
> > Error:
> > The cycles:ppp event is not supported.
> > root@fedora:~#
> > root@fedora:~# perf top -e cycles
> > Error:
> > The cycles event is not supported.
> > root@fedora:~#
 
> The error is because the perf top always tries to open an event on the
> user_requested_cpus, which are all CPUs by default.

But what is wrong with that for the default event, CPU cycles?

It should work for all CPUs, its the most basic event, right?

We should have a rough idea where CPU (no matter which CPUs) cycles are
being used.

- Arnaldo
