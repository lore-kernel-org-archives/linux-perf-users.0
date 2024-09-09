Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772FC18CBF8;
	Mon,  9 Sep 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920102; cv=none; b=jel7jyNqLUQTtGrV0tinpJY3WZTYRj0uMHWnbSMx3MtMPWy30GNM+N6KnqEmU16YeabaKGwWgDh+iEnPnvLy0W8sv4GhtkgkxyQV+XyhM6R8akycgHt6PWFHLliI4eOjDIjtP74zUUjRsFVehI2Z7Uz8IvPsyxDVgOi3JTyojdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920102; c=relaxed/simple;
	bh=+QxgqF22cxpoyxbylAX9gfzWwRk23UVbo3Xt4IxsV28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1gNxKsLmqHk0nvtac8ibeniMXgTv0eSKk8PY0rWY2t+8j1YYsoYeU8JzRFUAtKfzbrLdThHfzD3y3VZrx9E8cRtXlViTNUzfxHNe7v/uMatBXLQajbpPf/fM85YxAW+bYYZpiUTkZQiTanIEtOpGmvWaS9Vf6VyJ+amIRCh+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKCggPLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKCggPLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520F4C4CEC5;
	Mon,  9 Sep 2024 22:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725920101;
	bh=+QxgqF22cxpoyxbylAX9gfzWwRk23UVbo3Xt4IxsV28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKCggPLjTJ+KmZ3SEUMPjdizREbsFITwqrkukiBbKWj2b6gFdTRjp4dIgBxXO1qGc
	 e7gaMLcD10eT7uHIkAONO0RZJUCD1toK4S/uMMGOb2NrsCKnejED0N7PKe6SQhrmsl
	 6JhcqWW3cazVjPqq+VdZSX+T2EAsWn89xW3jpE8Xr2KvPcixUWOaP2w6lPn3c1uzMu
	 3dxKsiYikMjLKAnwcblYduU9r7BWVqzIcmrEOZ6kzHl9VzJbxIn9XlcXhkYnAC99By
	 sMbWmaL33VBNkROwy+wetQQULfS9bIpjsSUVHL1H6nULYGY4r+M6I7NYwEj1szLf7S
	 rU+ZpcmS5vOQA==
Date: Mon, 9 Sep 2024 19:14:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Howard Chu <howardchu95@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 1/2] perf trace augmented_syscalls.bpf: Move the renameat
 augmenter to renameat2, temporarily
Message-ID: <Zt9zYiI3haweX4Jn@x1>
References: <20240906195020.481841-1-acme@kernel.org>
 <20240906195020.481841-2-acme@kernel.org>
 <CAP-5=fXjGYs=tpBgETK-P9U-CuXssytk9pSnTXpfphrmmOydWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXjGYs=tpBgETK-P9U-CuXssytk9pSnTXpfphrmmOydWA@mail.gmail.com>

On Mon, Sep 09, 2024 at 10:05:57AM -0700, Ian Rogers wrote:
> On Fri, Sep 6, 2024 at 12:50 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > While trying to shape Howard Chu's generic BPF augmenter transition into
> > the codebase I got stuck with the renameat2 syscall.
> >
> > Until I noticed that the attempt at reusing augmenters were making it
> > use the 'openat' syscall augmenter, that collect just one string syscall
> > arg, for the 'renameat2' syscall, that takes two strings.
> >
> > So, for the moment, just to help in this transition period, since
> > 'renameat2' is what is used these days in the 'mv' utility, just make
> > the BPF collector be associated with the more widely used syscall,
> > hopefully the transition to Howard's generic BPF augmenter will cure
> > this, so get this out of the way for now!
> 
> Should any of this be captured in a comment next to the code?

Probably, just in a hurry now, making this comment for you not to think
I'm ignoring yours
 
> > So now we still have that odd "reuse", but for something we're not
> > testing so won't get in the way anymore:
> >
> >   root@number:~# rm -f 987654 ; touch 123456 ; perf trace -vv -e rename* mv 123456 987654 |& grep renameat
> >   Reusing "openat" BPF sys_enter augmenter for "renameat"
> >        0.000 ( 0.079 ms): mv/1158612 renameat2(olddfd: CWD, oldname: "123456", newdfd: CWD, newname: "987654", flags: NOREPLACE) = 0
> >   root@number:~#
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!

- Arnaldo
