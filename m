Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4751C9B8C;
	Thu, 10 Oct 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576934; cv=none; b=Z8BaE+cJpcB13Yb0pd6Zy+x+lzz6oYTzrFuAaMlvKN6ucIR8vHuIg0ml7OpOUWE4kXS+kHEOhecGHG96nJtry1/XOfG916hueWCvw0mRcUibKEC2SkHgWwa1Ggpm/sSndaOa2QDbXd+9RpVSznRYS5K2hJ1Zih+PkQkHMMTSOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576934; c=relaxed/simple;
	bh=zrNx/YeB8J2J0TssxNZYPtIbOPuOqKNmsER4e59KXvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO5lW9tIM5vjcR8y/v3IXkIXtWwYBCRGDVzTzifb5M98I5rfZykLGBhwGTlHAkNaWvIU+5pwm70QjioylAUtIEYxIG0cPhLgdMSmrSaqA/5fewwIk3Ki5vVRMILtAwTxhOAkEAxixzQcwYJqBeUMMpmmepIcawH6vH3VPUFb7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGMRR69X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGMRR69X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF102C4CEC5;
	Thu, 10 Oct 2024 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576934;
	bh=zrNx/YeB8J2J0TssxNZYPtIbOPuOqKNmsER4e59KXvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGMRR69XF40rX13zQMVEO0upjxZU6sEChNiQ05ApqpqrgDsSgjC2fzcKUjhVNPYOL
	 djdHZ2HAb2m72QFJwabP4PQYLdJppUmplGgOTigaxzbyRK165tAPw762+KkLhTbBza
	 735GEAweS69mfJfCWcLsGRt3hj2Nv1HSZK9df/jx3RPu75ewm7nBu4acVuQEwOiuNj
	 nivPNngdASB//3U3Ec/AsO0I7P3fwPORVJuYGfzh+wa0Irsi4/d/EmrCmIzFRys8cU
	 D85KO33HFA1pCVTpaBpJwRzUEHyrG8UKPWZqAfjXa0TQ7aD6uWyiumzr6QiRlbEbuN
	 zFZ3501s4FE3g==
Date: Thu, 10 Oct 2024 09:15:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
Message-ID: <Zwf9o6YwL-Q1Q7WK@google.com>
References: <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
 <CAH0uvogXyYP1LqF3fbjZGHHDL6BFZ2ZKu5JAASnK_brgnymf0w@mail.gmail.com>
 <CAH0uvohEozKixjDM9_jJ5FFxYK7agsqVO-BrAsm=4hCTDQAx2A@mail.gmail.com>
 <9bbfe425-1f2b-4846-a5a3-a31618742e9a@oracle.com>
 <CAH0uvojJ1rME4hb6NfrA4NPj2XmGMDLOLP3wEbHh8B5-qWGvFQ@mail.gmail.com>
 <CAH0uvohW7_st0i=ek8rc_SucuQEQUgs+fWt12cc3jqiYfxAjmw@mail.gmail.com>
 <ZwcnVKn3wVSSMcaL@google.com>
 <CA+JHD93JgJL_4GJFcFUNu-FpNfFOoyDRJ7QuvO82M8G1EwM5pQ@mail.gmail.com>
 <bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org>
 <5f3f55a8-a378-4e16-8e5b-6fff329e75fd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f3f55a8-a378-4e16-8e5b-6fff329e75fd@linaro.org>

On Thu, Oct 10, 2024 at 10:11:35AM +0100, James Clark wrote:
> 
> 
> On 10/10/2024 10:00 am, James Clark wrote:
> > 
> > 
> > On 10/10/2024 2:20 am, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Oct 9, 2024, 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > 
> > > > On Tue, Oct 08, 2024 at 12:27:24AM -0700, Howard Chu wrote:
> > > > > Hi Alan, Arnaldo and James,
> > > > > 
> > > > > This problem was solved in [PATCH 0/2] perf trace: Fix support for the
> > > > > new BPF feature in clang 12 (Link:
> > > > > 
> > > > https://lore.kernel.org/linux-perf-users/20241007051414.2995674-1-
> > > > howardchu95@gmail.com/T/#t
> > > > ),
> > > > > sorry I forgot to cc you two.
> > > > > 
> > > > > Alan's thought was correct. Thank you so much! :)
> > > > 
> > > > It'd be great if any of you can test this change.  Now I only have
> > > > machines with clang 16.
> > > > 
> > > 
> > > I'll test this tomorrow.
> > > 
> > > - Arnaldo
> > > 
> > > > 
> > > > Thanks,
> > > > Namhyung
> > > > 
> > > > 
> > > 
> > 
> > Tested with clang 15:
> > 
> > $ sudo perf trace -e write --max-events=100 -- echo hello
> > 
> >    0.000 ( 0.014 ms): echo/834165 write(fd: 1, buf: hello\10, count: 6)
> >                                             =
> > 
> > Tested-by: James Clark <james.clark@linaro.org>
> > 
> 
> Should have left this tag on the actual patch. Will re-post it there.
 
Right, thanks for taking care of this!
Namhyung

