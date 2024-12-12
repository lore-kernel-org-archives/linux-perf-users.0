Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF6168497;
	Thu, 12 Dec 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030546; cv=none; b=VP4LlyyHsXps+bQZmcCB+Li420qKvo8fhYm1dxqAxmvfCwdOp75dTLZBP8gxo/6KCmgpkAU9zapXm/tJT4/v0N8XCVAVAjpKOvnByZEZzIHWhVZTJraDtiXb9VMi/2/hkwBI+A44zRcwBAnne0vuGgcPC7582zLLKcjOCK9LhSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030546; c=relaxed/simple;
	bh=kRkVdoPHmcLpmA6X1tdcmAtJibqiAxWNVxaTgGQBGlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKjhp9C68vPg0QYTvEd6gKzf/MB6lND6AJoAFtedxjYfhgHbZ4bZvDTpoTKzIf7yn7ZeJ+gEA1jK9pLZPAH/oQb6YLAU+cUD4opL6yzP0r1/HYRFdswz1dVYiWdOmYMyXEt04i4IS1jSCIihN7xuL+xrnwQDPkgv/cFmPqHnPns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTP20oPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTP20oPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0217FC4CECE;
	Thu, 12 Dec 2024 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734030546;
	bh=kRkVdoPHmcLpmA6X1tdcmAtJibqiAxWNVxaTgGQBGlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTP20oPER8R1i0DhwDm0oUe9K27SlCk/i6CVDHlbIwJ/pGN9msukabZQPcxHhyUfI
	 CMKFZq9Uvxq1OR9z/18Y0rFbBLCTKlXOioOElJy8UCPn/0zZA5EPw/295G6zQsUEPc
	 PCpq6T264vWXRaxl4l2dhei7Z1RcaHL9LEgWgLfs4bBgf5LsUsFGnkV6m7c/J34gNN
	 1B0xynQr4V15DhPOd5wt2sxIV3y8fxWURjQJH5XiBB5H7WYmLBgNH9taTl6qs0Q+iN
	 52loKX+X31pAy0of/uBkRjy57V+3DSuJvNn1obCCf5Wo6XPDvn1hJiHVek2QYQOTk0
	 VNO6FPrv98/oQ==
Date: Thu, 12 Dec 2024 16:09:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] perf tests: Fix an incorrect type in
 append_script()
Message-ID: <Z1s0z6VdIIHRDcku@x1>
References: <20241115091527.128923-1-jiapeng.chong@linux.alibaba.com>
 <CAP-5=fXPe9277agFqyEQsOG8h_wM5zFh3Sz+NFpsacU+A5MOuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXPe9277agFqyEQsOG8h_wM5zFh3Sz+NFpsacU+A5MOuA@mail.gmail.com>

On Fri, Nov 15, 2024 at 10:57:59AM -0800, Ian Rogers wrote:
> On Fri, Nov 15, 2024 at 1:15 AM Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
> >
> > The return value from the call to readlink() is ssize_t. However, the
> > return value is being assigned to an size_t variable 'len', so making
> > 'len' an ssize_t.
> >
> > ./tools/perf/tests/tests-scripts.c:182:5-8: WARNING: Unsigned expression compared with zero: len < 0.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11909
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
