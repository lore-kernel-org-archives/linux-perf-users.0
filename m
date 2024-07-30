Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E0184553;
	Tue, 30 Jul 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366873; cv=none; b=HdbTwdcMeJtUbFF1wPux2tVMpjiqwVDv5IsW5U6czJnawnGWkybW5DEH8VXxCRR/YYy3fogkoJ1hD2RmAHl5odYIQo98pnWb/RIDS4vhgi5x+sbV75VoSno0q3scJTaVKsjzwGe75WuNQuQNq24mM40/Gt9OyvzwBhhJyyfR78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366873; c=relaxed/simple;
	bh=1tJyfpMbGghKN9ldO7BTLcSzVAYT1DumAlavUyAZ4LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWgHT2iAb4PU9Z2Y4TMuuB9M0cmuI92RUkc2Q7JflFq7dWWSTIA7w7QBHnDZIiuwrt8wB7dsKB1clFIOSP+D9ps7XASaf/Wx/XkINo92542XDXItGzXkb7fA+GS5YHxQYm1x/H3TkMsvysMzQLPGLWFToxIhLxIKYZcPB8t67mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f01wbyER; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f01wbyER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F04C32782;
	Tue, 30 Jul 2024 19:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722366872;
	bh=1tJyfpMbGghKN9ldO7BTLcSzVAYT1DumAlavUyAZ4LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f01wbyERQ8AZpnUy0cOZkmTD2AbMQK6lsAK7KFBaZyb/VWUMwtCGMTej9k8LYos4N
	 8NyoMI6qaunhrjBzC+UJTKKquyWposT1Jkfg3niMCmK89i2BKbBYCtBjVoUAO9XpCB
	 QAPwQoMFX2icJtE0vjZGpHqax9KLf95CO17mB4wgZTLhPRd6622LwTU25kU/fh3J/I
	 6FLLmw1DS851Rff2W/KL5dYNeinWlDHd8GvlrsDwVxa8XkdvGz+deVrBgEDygR3RlQ
	 jKavAboA1MSWux+OXctoCm2ufKwM+jDltUfPTkj/67HlXufAXm1jNzxxdMQcdYcQ2i
	 yIlfe5oRsILxQ==
Date: Tue, 30 Jul 2024 16:14:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>, weilin.wang@intel.com
Subject: Re: [PATCH v1 1/1] perf test: make metric validation test return
 early when there is no metric supported on the test system
Message-ID: <Zqk7lIhoKHh0ZYGm@x1>
References: <20240522204254.1841420-1-weilin.wang@intel.com>
 <CAP-5=fUtp_vd=EeeesXPR=nsm0VOZoyXico=EVWobOEYsxq27g@mail.gmail.com>
 <CAP-5=fXOTmMyPx_tQPoCfCP35E1o6YSyZde58ojyU1PLJBt96A@mail.gmail.com>
 <CAP-5=fWu09Oy0bYjqW921NXgh33GOeCZ-J_tQ9PqPHT7XpY4DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWu09Oy0bYjqW921NXgh33GOeCZ-J_tQ9PqPHT7XpY4DA@mail.gmail.com>

On Tue, Jul 30, 2024 at 11:44:32AM -0700, Ian Rogers wrote:
> On Mon, Jul 15, 2024 at 3:25 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, May 24, 2024 at 6:26 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, May 22, 2024 at 1:43 PM <weilin.wang@intel.com> wrote:
> > > >
> > > > From: Weilin Wang <weilin.wang@intel.com>
> > > >
> > > > Add a check to return the metric validation test early when perf list metric
> > > > does not output any metric. This would happen when NO_JEVENTS=1 is set or in a
> > > > system that there is no metric supported.
> > > >
> > > >
> > > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Tested-by: Ian Rogers <irogers@google.com>
> >
> > Ping.
> 
> Ping.

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
