Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD9227EAE;
	Thu, 22 May 2025 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932581; cv=none; b=XrU1oRYokhdWAwYS7fX5JrXGOsBsPkvqi8PGt2Xl/4R1Z40uqgsxcUXNrmFWRWFCskGqHinwuVvqxkdhcxuowOmTlwTRH/1rACwgTIaqSLcy7KEbwffnJVthAfqgXRarwaAZaN5c4XT7OCGHwWcvBPfz8DETofzqFXpfIWWflHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932581; c=relaxed/simple;
	bh=LP7ImiblbThAhgrPjhOSsoI6CFpyGCPkg+vE95DbX3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZdFQL6HhbZL0Z/hQd2h3i1nOrN0WeRnZg429aWIHBnEhcjqw21nJgD00MPxOuYRa4dbm4iddNakt2FGwLBVYCKeBeWIgusDaa1lkLzmvWg6jdVjW9VPbbuqNcgEoLBm8FPxiJ3cGH/mcc1zw8pXDwXe88XjXaJFFL5Kx+UbiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOOJskH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOOJskH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805E7C4CEE4;
	Thu, 22 May 2025 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747932581;
	bh=LP7ImiblbThAhgrPjhOSsoI6CFpyGCPkg+vE95DbX3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOOJskH+ALMUEVBISyhXWJQuT34ek29MKVCCCCj92Gn2G3lePbm6bKCvtCxSdxN8R
	 ODc/V5V6MC3cUgTR/VDg67fB+hUXdlvmpjRV7Wmpc4XaJ3oTF7ku412KLLcyb4umzY
	 E6mESzVODo0xKq95zQwa9i3yW+DzZkpoYRpXRg0i8c4uboT+fZ+/ACCS73Ooqia47v
	 Q+hfLcso4XfILh0S3GEDl3OMUeY2amaG161VGnZGA2Z8awhkI9WjwJGwCd7eDjokkp
	 fK7h/jptGeiDE2D4NrDe7eknkHKNMhULO1OR8uzN/hx8xiBRIwwM2NBSRPy9S5oj1p
	 UfsXHL3J9iCjA==
Date: Thu, 22 May 2025 13:49:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Add cgroup summary test case for perf trace
Message-ID: <aC9VoTL_Cv4R7J-j@x1>
References: <20250522142551.1062417-1-namhyung@kernel.org>
 <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoiZ2difXdPsjkdLikHTRwYROYUeuCdZ+gQ5uRfQ2rzwGQ@mail.gmail.com>

On Thu, May 22, 2025 at 08:33:16AM -0700, Howard Chu wrote:
> Hello Namhyung,
> 
> $ sudo /tmp/perf/perf test -vv 112
> 112: perf trace summary:
> 112: perf trace summary
> --- start ---
> test child forked, pid 1574993
> testing: perf trace -s -- true
> testing: perf trace -S -- true
> testing: perf trace -s --summary-mode=thread -- true
> testing: perf trace -S --summary-mode=total -- true
> testing: perf trace -as --summary-mode=thread --no-bpf-summary -- true
> testing: perf trace -as --summary-mode=total --no-bpf-summary -- true
> testing: perf trace -as --summary-mode=thread --bpf-summary -- true
> testing: perf trace -as --summary-mode=total --bpf-summary -- true
> testing: perf trace -aS --summary-mode=total --bpf-summary -- true
> testing: perf trace -as --summary-mode=cgroup --bpf-summary -- true
> testing: perf trace -aS --summary-mode=cgroup --bpf-summary -- true
> ---- end(0) ----
> 112: perf trace summary                                              : Ok

Thanks, tested and applied to perf-tools-next,

- Arnaldo
 
> 
> On Thu, May 22, 2025 at 7:25 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> >   $ sudo ./perf test -vv 112
> >   112: perf trace summary:
> >   --- start ---
> >   test child forked, pid 1018940
> >   testing: perf trace -s -- true
> >   testing: perf trace -S -- true
> >   testing: perf trace -s --summary-mode=thread -- true
> >   testing: perf trace -S --summary-mode=total -- true
> >   testing: perf trace -as --summary-mode=thread --no-bpf-summary -- true
> >   testing: perf trace -as --summary-mode=total --no-bpf-summary -- true
> >   testing: perf trace -as --summary-mode=thread --bpf-summary -- true
> >   testing: perf trace -as --summary-mode=total --bpf-summary -- true
> >   testing: perf trace -aS --summary-mode=total --bpf-summary -- true
> >   testing: perf trace -as --summary-mode=cgroup --bpf-summary -- true
> >   testing: perf trace -aS --summary-mode=cgroup --bpf-summary -- true
> >   ---- end(0) ----
> >   112: perf trace summary                                              : Ok
> >
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> 
> Thanks,
> Howard
