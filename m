Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E410E5;
	Wed,  5 Jun 2024 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550016; cv=none; b=pp01G8FJvOHLt5TwMryTgW9Tu+PlbBF+A57K5qwAtdIVGriGuGw0pWE/9dZfrjlVyjPph8FO/ZmEMRnD0DNry+y4A1yuq9Wnf4HINBkCYsAkMZCN9dyRJ2Vt4tU9src+S8ryzesjtKHXTn5rbo35JVW2keTOoB0/91PNqLkFAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550016; c=relaxed/simple;
	bh=x4BxyoF9F6Ak0GcMn2lPqfMoKDpF/r3bS+MlL3OmJ24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8P7jOVupGwZwwT4CURskzhjhUhCfPwBU3OZYBP6klaHcXVuRO5pGWDwurRuL4Xvg08622j0bCihxeQ9gVKHeDM/BPInNxmwsvAsNvzGResE9txOSM1d3h+IPxgMJ8rYcDnvCbA8BE2IHyJK9kAG5uMa9fmoCbvplqw1VNQzcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhbLvuIh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhbLvuIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA851C4AF08;
	Wed,  5 Jun 2024 01:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717550015;
	bh=x4BxyoF9F6Ak0GcMn2lPqfMoKDpF/r3bS+MlL3OmJ24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhbLvuIhdOv42eeo2YKCeeuhjX2xM0roczuIvj/qbnVubjTQsVC8c7s0l4/ASLCIz
	 9hlSDIfJU9AZL1cP7XWPlHSgRvOfBJmc5Z6Ib5zqR8AVGpIN0FlZlgufxepbvV0cp1
	 8BHPyJdg1h+yXpdZWYfNTY0u1Udvq93fe49BYynWUAh+bnsgXDC1AzTt2Gl0zRrE+N
	 JlBNJihalgMSxxQm1YZGD+AQM0ce3ru4WvGEnxuIAXtbInm1TST+7yjs963YVOFPC1
	 liB4Zj6FAFa/De4BiYSuefEU/4OCTO0+DytU9C/6nOx78rZUI0CffOZD/G0Da7EebW
	 hxI7CpLdVMt8w==
Date: Tue, 4 Jun 2024 18:13:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v7 1/4] perf report: Support LLVM for addr2line()
Message-ID: <Zl-7vorESdIgbwIG@google.com>
References: <20240526182212.544525-1-sesse@google.com>
 <CAM9d7cgf1ZqGGCHU=g8ksfigWhL-XPL4qJiHzz+EQ6vo5c8DyQ@mail.gmail.com>
 <ZlzYEp78ihsGeEEi@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlzYEp78ihsGeEEi@google.com>

On Sun, Jun 02, 2024 at 10:37:38PM +0200, Steinar H. Gunderson wrote:
> On Thu, May 30, 2024 at 09:58:09AM -0700, Namhyung Kim wrote:
> > Can you please add something to tests/mask so that
> > we can test the build with and without libllvm easily?
> 
> I have no idea what this is (it doesn't seem to be a file or directory).
> Do you have a pointer where I can get more information?

Sorry, it was tools/perf/tests/make (not mask).  We keep combinations
of build configurations and test it with `make build-test`.

Thanks,
Namhyung

