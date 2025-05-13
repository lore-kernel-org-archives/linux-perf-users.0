Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168B1F3FD0;
	Tue, 13 May 2025 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169019; cv=none; b=bnsSEJY6EL2l3YpJUHEvCr5bmvZtcr6O+L7A7i1XQ4iW6qYBtO0woFd+oVGEOrcSZDalsQRgq3VcMPT3MFBpG+XhNFobpkGNwdQTEi/lWVDYYPDWxVaZkRtdDuly0QCnjbaDqUZjElBj32NaOvgFRyxqTwjCSm0tHLeE6n2/A/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169019; c=relaxed/simple;
	bh=DlzoO2fu8n/uCk0v+sIlLnDoi+5ozdMq6NjBF4QfH1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtB32K8PjWYN///dyo2cZsWee5C2cq417lKhKOyeE3OSR5ElYKyF6B+ZakBpwgj7p9ptN0F/02E552IvpC6xrpxMV31DiVMQBYw3ctVrY+rkB/eMgaZoVEOF9/oq9HcvvRFVcVofsqYljq7/3fedYAzQavAPzEa5Yc+CeC7uc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMVckfZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMVckfZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE053C4CEE4;
	Tue, 13 May 2025 20:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747169019;
	bh=DlzoO2fu8n/uCk0v+sIlLnDoi+5ozdMq6NjBF4QfH1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMVckfZB1GImH8ldE/nI0p4bsH+Li/T8YfxZ8tGNw+iZrFpVEo5L83N+gosebCwZy
	 vZK7AJt/fK+w4af7Bu0ho/WkWpW5bouupmG8oPNjEbVz+XS48Z1VQxm4LxElMK/K3U
	 B83QtuQ5fLOuRBtfmZLVJgNfhPnacCBv/9DW8RYeSaKxs4Apiy6ey0XyDc56sYfTlN
	 HxikQju+Yd31QOjyHiL6192f9l9zZsKpI3hkj3Jeok17wNd9/0rZ/kCnKS6EQbmPox
	 JNduMBTvtJ4geQmGn+3IGDrKmy6Qsuq66iMny5b0+mWQgbOOEvJA7kM5zfAvVdruVh
	 uhbBi7FEFvTew==
Date: Tue, 13 May 2025 17:43:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: make -C tools/perf build-test failing on aarch64
Message-ID: <aCOu-CoYBcX3LNN8@x1>
References: <aB6vFFcRErPVt7p9@x1>
 <95bd54bf-09b7-4444-94a7-87ab9a3035e6@linaro.org>
 <de9470c6-de22-4136-b390-6dcc056495bd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de9470c6-de22-4136-b390-6dcc056495bd@linaro.org>

On Tue, May 13, 2025 at 11:05:16AM +0100, James Clark wrote:
> On 11/05/2025 18:46, James Clark wrote:
> > On 10/05/2025 2:42 am, Arnaldo Carvalho de Melo wrote:
> > >     I noticed that upstream is failing on aarch64:

<SNIP>

> > > I think this is related to:

> > > commit bfb713ea53c746b07ae69fe97fa9b5388e4f34f9 (perf-tools)
> > > Author: James Clark <james.clark@linaro.org>
> > > Date:   Thu Apr 17 14:55:50 2025 +0100

> > >      perf tools: Fix arm64 build by generating unistd_64.h

> > > Can you please take a look?

> > Hmm yeah looks like it's caused by that. I'm travelling tomorrow but
> > I'll try to take a look.
 
> Sent the fix, hopefully 3rd time lucky.

Thanks a bunch! It seems we will not need a 4th. :-)
 
> I know there is the build-test target but I had let my setup bitrot so I
> wasn't running it. I don't know if you have ever shared any of your docker
> containers that you use for build testing?

I keep them at:

https://github.com/acmel/linux-tools-container-builds

The README should be enough to get you going, if you find some
difficulty, please lemme know.

I use this since forever and made them available at github when Daniel
Bristot started maintaining his tools in the kernels sources, the idea
was for him to also use to test build his tools.

It'll be great if you find them useful and, better, wire it up to some
sort of CI you're using.

It does a subset of what 'make -C tools/perf build-test' does, but the
idea for them is to switch to do the full build-test target and also to
run 'perf test', that would be restricted to whatever perms a the
containers are given.

Nowadays with parallel 'perf test' and it having being polished to work
with less perms, that seems like a worthy goal to pursue.
 
> I will also try to get that target added to our CI. We're only running a
> normal build and then "perf test" there.

That will be really nice of you, wiring up these things so that when I
run it all goes as expected will be great!

- Arnaldo
