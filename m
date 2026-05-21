Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19C37E2F5;
	Thu, 21 May 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406998; cv=none; b=IbiDJnMnCw4QOf/tHVRgXOokoZLqDWD/meveMETX1ma6/FKkRnvhkzYmdnOlPTnRIkZsOnrH2NqIaLj5hdobt2z3AbsJrk6F2YYFmquq6Jzrgo3ypUo5ajIBEGgvo06sNO9dHZsOHUh8AwxmcShxYUMRIbVm4dguIuU9xTbeF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406998; c=relaxed/simple;
	bh=V1QY/WkT7rtMUlpp6NhejLtDoPJHmq3mLFUhByofCvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDKVLCK/LJooH71nNKeKnzc3I41d/G2X7QwqemjOKhsHBGgsfJHG8rDn4DMHncr5yiboOi+O7J/5IPhevonIZN2nRClDpCiV74vDIG6zYbKvgu6PAN6hdDKkY250gTAKhJnQ4jWIQbixmZBCA5VQvAw7eSmJ/Ybvjchc5dWK1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gREHVys/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gREHVys/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4271F000E9;
	Thu, 21 May 2026 23:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406995;
	bh=WM1znR6X8pBtxVeyvye2w1odsN4/TTlMb4NhLTbUm0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gREHVys/4KH72TyMKZhwZ8vSfUonyrDYQPSBsQiRPkbk83sSXvb2+1jyk1R3EF+AV
	 TdqGmrnFenWTKtSnq0c2WlHy+pwTwiWpWx00VpFpNqLsXkhMDYBZu3297TWbcmuVEi
	 YtSwSnndaZsVhPDiXLwqgllg4tX6TYZeHpfFqeH+nTXEcoqvX+hE3D/gIrV1jVklBI
	 tR3DZgM4RsjdMAueHggrsF1TRU8/fdLmvgY7m5cmQKAVfHwpIuy/mvZV4AatXbx3Uq
	 eDVi1tdfNmcmRgH+isjVLPSwe2/07STgwiy4FIQZG/ZWoCgW+Ywdl4uv1catshrE9w
	 9gKVLq1Mkj1sQ==
Date: Thu, 21 May 2026 20:43:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [FYI] [PATCH] merge resolution commit for perf trace beauty
 conflict
Message-ID: <ag-Yj3p4q0gag4tf@x1>
References: <ag88OnWBm2Ce6A2s@x1>
 <ag9G9nKxz8JsiUQc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag9G9nKxz8JsiUQc@google.com>

On Thu, May 21, 2026 at 10:55:02AM -0700, Namhyung Kim wrote:
> On Thu, May 21, 2026 at 02:09:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > Just FYI, this is the merge commit solving this conflict.
> > 
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > commit 86c8774ce08b931debdaa3f61f5a033639c183ca
> > Merge: f8d0db39bcc536ef 758c807bb943138f
> >     Merge remote-tracking branch 'torvalds/master' into perf-tools-next
> >     
> >     Fixup clash of:
> >     
> >       552636b9317c8a84 ("perf trace: Add beautifier script for fsmount flags")
> >     
> >     That went via Namhyung upstream and the following ones in the
> >     perf-tools-next tree:
> >     
> >       32969ef6e3e1979a ("perf build: Pre-generate BPF skeleton tooling during umbrella prepare phase")
> >       537609924c43715e ("perf trace beauty: Make beauty generated C code standalone .o files")
> >     
> >     This complements sent by Ian Rogers.
> 
> As long as you have this with Ian's fix,
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Yeah, that is the case, justg added your Acked-by, thanks for checking
and providing it!

- Arnaldo
