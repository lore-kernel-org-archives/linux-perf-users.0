Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91312D6E74
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459859; cv=none; b=QHrbVSAw+HhqGToJFNeLexE4FOYRf8Dh/2W1gUsG5ctJaK9oXa5ZyIcAFzIkx9WKWjsGcV773wHuV4+u5MhqeJvtQrhfoT6LW/GdCXO0SBMUdPALeiBqqo+eJPpDX3McvahC4LZh/CQEXwdCR253Obx7c7GY2zv0sW+IhGPD7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459859; c=relaxed/simple;
	bh=bd2hwAw71VOFoI0Xw0gcxKaG33cPyvb4DcRxQ/mCd6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ant4iaxGchsLDDdd9fABfkIh3y6H1/YGuwGjtoydF5lykxyzeHrVfrqiy3Wm5Yh7s8Voq3O6p73fOO0I4lQLNjQCv+Yii3y0yRgBN/Y8e5NP/Jxkl9/eF5JAVF0AZN/DP5wBrtjfntByoxvwvn9LY/sEPibtPsxUVfOTTmhaOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0Difkqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0Difkqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F36BC19422;
	Mon, 26 Jan 2026 20:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459858;
	bh=bd2hwAw71VOFoI0Xw0gcxKaG33cPyvb4DcRxQ/mCd6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0DifkquFnTbh/wX5mMKVZYuN29Y7VOoGc+c/BI1fWFAovhD7G3lC5BIMRoAswCf1
	 biyCoTPpHXyUzbTATEOFlZZbMfjUjrFKSGs/Ow2SVu/wuPR4znCRiYQo/bWjIWCJne
	 UPYuNV/12UqCbWqCAz1nmWLRcGIcC0LxJfnXMGk2ax5AA9Bmq8CcaCE2u41QtBR82e
	 KUlcRK7j9twscfEjXcr8gLAvUbLVVr0E5s/OoUs57dwG7d0udHzs39LPhgju8jP3b0
	 x57/YUvsCZJB8X6XUTF3/j9AAt+lNFzqf5qOFmeIegK5i1CTt1c5waMJYkI6fWVOUM
	 ksEm5g0P3vIDg==
Date: Mon, 26 Jan 2026 17:37:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Michael Petlan <mpetlan@redhat.com>, Jakub Brnak <jbrnak@redhat.com>,
	acme@redhat.com, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org
Subject: Re: [PATCH v5 0/7] Introduce structure for shell tests
Message-ID: <aXfQj5sIKtKWLeu3@x1>
References: <20251125155648.197527-1-jbrnak@redhat.com>
 <a5f59c64-0da-6928-7a9-c5b6c2be8ef8@redhat.com>
 <aXOh_4oN9P_Sxo8t@x1>
 <CAP-5=fU3Xi1CT+YsaY+7Akq2Afh6m4hUwU3SkJvKPM2s1oR0ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU3Xi1CT+YsaY+7Akq2Afh6m4hUwU3SkJvKPM2s1oR0ZA@mail.gmail.com>

On Fri, Jan 23, 2026 at 09:02:13AM -0800, Ian Rogers wrote:
> On Fri, Jan 23, 2026 at 8:29 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Jan 23, 2026 at 03:26:54PM +0100, Michael Petlan wrote:
> > > Hello Ian and Namhyung,
> > >
> > > kindly reminding this patchset. Could we get it merged soon please?
> > > Or is there still anything to address?
> > >
> > > Thanks in advance!
> >
> > Just test applied and it went cleanly, will try to review it after
> > lunch.
> 
> I think patch 4 has an issue as the clean up is in the wrong place.
> There are also some file descriptor leaks. Other than those happy to
> have my:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> on the series. Probably should get patch 4 fixed though.

Yeah, the first one I would fix myself, those leaks, but patch 4 needs
some more work, Michael, Jakub, can you please take a look and address
Ian review comments?

- Arnaldo
