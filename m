Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634080;
	b=mx4zILdmSdBYCSEWClclCIE1jU2fDRG7Kcq+RuaybtZXRibfWEpeGtKK7xg122kGXipP
	 Tvui0KLFd1GGE1x8UHvhfXs9Q6s5sb6buvLGLczOn4QzMYv+1wq1pnHN8UwhXSLapkGuJ
	 WsVMNWBTd98UteOmo2Lzo5v5liG2qeA45FL0/YmNc+tzehF5MwVMFLUuVuJ8NwBdS/sKM
	 2BBV2Cv7aWUBZUbsQs/V77dQmv9oUreCSPthrGyJ4pxDzn5tPZXgVMPd6Lie9PPKxxIue
	 HqnZ0gHKfn+6QtlDIwicDiNKGqpOgvcP85VMXzV0/qtsXO/GK9um2ObV/OjRvQwVKPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634080;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=uiPjq1P/e8OfOqAPwWMEmnQ66tBJyB5qUdr3khwA/mo=;
	b=0uO/gLNiFW8IIEk7lXVZEFSgZkbzwkWboRWBXT7tAdCsLm4GeOtDhVRctES+t9wjhkCd
	 wHGFAu+GDXJ0lHL4fFoIhF4AYiy9sSU8tbno+PaQN0tonihvTI97OKgwHRqobTfiCuhrH
	 iqiPt/RqTbyiv6/PJiiLOrwy3t1lPvDx1voLMIYtaeeXnzMbFIhMKoUDbJxiGz28aEPTf
	 5LrKXe04dMyL0fpzmlF3ReFjTnhdPhnEnnc0pDoTK2yrmiBCCSrsgTy0YlTb2WdCyGFuG
	 itxTCZ84KnE9FnkBUVTIbwELtIXMV9FWUGSPL0aBxZHzjY+QY1AZJWKzwNQ56GL/mJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebL04dBj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB4606A31E;
	Wed, 25 Nov 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebL04dBj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD501F000C0;
	Wed, 25 Nov 2026 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634079;
	bh=uiPjq1P/e8OfOqAPwWMEmnQ66tBJyB5qUdr3khwA/mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ebL04dBjlOHElSPUaWEaL1JBJUqfOHxCBZTmyGGIJLrqO6J4ADIJfA8ko83t4qYS2
	 2imGwFy8XBccQWrlzdUP2O/H5APmgt55vXv5P5gWRkILtXSJTaBRg0HFZIUVXrG6TH
	 R0DAea9uu5nB81FZ7+AZjFY7yCh37ADOr3maxX5het1Q7EltphdnkyJY6b3SF+MXJd
	 dUXIG5Dv0PEBu/tsLA4kJMupCVtI+Jd7uqBsm6/txqBSRZ6NVFshES3YLCQxIjXPVm
	 0MQsVDdI6V1G1axQ2LPT7clgU7zLgDcmCS6ie6k+ni5l8Zeu/uRJX+q33Ko3ti++vR
	 I1pMfDDf0oNxA==
Date: Wed, 25 Nov 2026 11:14:37 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Robert Walker <robert.walker@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf cs-etm: Initialize the Thumb instruction buffer
Message-ID: <awczncL6fSXxX9NZ@google.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
 <20261113-perf_fix_gcc15_failure-v1-1-eae592c5ff64@arm.com>
 <CAP-5=fXrP+FSmv35KgvwDkNED921X60W3BWiMYHmLV-AzSG4BA@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXrP+FSmv35KgvwDkNED921X60W3BWiMYHmLV-AzSG4BA@mail.gmail.com>

On Fri, Nov 13, 2026 at 08:30:59AM -0800, Ian Rogers wrote:
> On Fri, Nov 13, 2026 at 2:55 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > cs_etm__frontend_mem_access() can return zero or a short read without
> > fully initializing instrBytes. cs_etm__t32_instr_size() nevertheless
> > inspects its second byte. With CORESIGHT=1 and -O3, GCC 15.2.0 reports:
> >
> >   error: 'instrBytes' may be used uninitialized
> >
> > Zero-initialize the buffer to avoid reading uninitialized stack data
> > when instruction memory is unavailable and fix the build failure.
> >
> > Reported-by: Ian Rogers <irogers@google.com>
> > Closes: https://lore.kernel.org/linux-perf-users/20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com/T/#m64fb81c665214b79883d9be815b40ac5f6669628
> > Fixes: a7ee4d625ede ("perf cs-etm: Support for ARM A32/T32 instruction sets in CoreSight trace")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied this one to perf-tools-next, thanks!

Best regards
Namhyung

