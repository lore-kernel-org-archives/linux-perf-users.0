Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2034A1A;
	Thu,  9 Jan 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457429; cv=none; b=ie8VMi+zGdhbyiagrtdAJUU37xYkUZaIq7yaJbcXKFmT08/6Xl5a/h8B0eLff9zTI9jY1YFEg/OqelLpr2Pp13F8XjWzdJ/p2hlDfRWimMigfr/csqP8eyswZ+Qrf5jSyTWEyu/OI5tlH2Is6+9XE79XG8k2dk5hSiJ7VaVX3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457429; c=relaxed/simple;
	bh=UMr+xJwW/kFfm1aAzQV98x8XnolYnrlaynxp2asnV1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWt0/x600dP4JcrZ38fn8rIzQO/ikmvmxrMhHoTr6HlwKdmVlt1tTgE6rkcKPqzJvKofPsoPybmZ+zf8ca56J7ku3zMdQXyftTopMpa92oCqM98dSNsKaeQshBkkvyEe4XS5zX6F5tYPaLiC2WTcXhK2TPNIH/tdAW5YPIT57YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISrd3bTe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISrd3bTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA543C4CEDF;
	Thu,  9 Jan 2025 21:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736457429;
	bh=UMr+xJwW/kFfm1aAzQV98x8XnolYnrlaynxp2asnV1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISrd3bTeGPpOSDa0GWCdEHhWg26f0Lmz7oy1LotBdAtfSHU9m+i/V4nQBWD/rTs2p
	 nRstm5ATcQAUO7kCn9DBZyCYN6VPxHGYXjEbZz68qegQTlNIzI3pv7gsTtW/aKYLeJ
	 XI94eBPzmHe+xne/U7tGxyiZ6XpIs2P0/arXQnMDZlllmctnuJ5No81iw56pOk2SHm
	 812sWLpb5wnDoSwp+C4SyUvCn5s4hvL5PQJjqqb029TRCl5FtAFQZYUpXWYQQxGGTc
	 DOOmnZ6cb4o9A6ZxrSRYKsHUESvs43nW2MTHpK8/mSqSynnmXXyedeXc+S/oPf3IuO
	 vijWPAGRVw1hw==
Date: Thu, 9 Jan 2025 18:17:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf top reports not being able to resolve kernel symbols
Message-ID: <Z4A80o7shniaixby@x1>
References: <Z3bd2uCdo2EAMSnG@x1>
 <Z3boDyuus0fiGcok@x1>
 <Z3buKhcCsZi3_aGb@x1>
 <Z3b-DqBMnNb4ucEm@google.com>
 <Z3c6cwACnzku_ntQ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3c6cwACnzku_ntQ@x1>

On Thu, Jan 02, 2025 at 10:16:35PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 02, 2025 at 12:58:54PM -0800, Namhyung Kim wrote:
> > On Thu, Jan 02, 2025 at 04:51:06PM -0300, Arnaldo Carvalho de Melo wrote:
> > > So there are symbols that are not being resolved anymore that were
> > > before your patch, namely:
> 
> > > arch/x86/entry/entry_64.S
> 
> > > nmi_no_fsgsbase:
> > >         /* EBX == 0 -> invoke SWAPGS */
> > >         testl   %ebx, %ebx
> > >         jnz     nmi_restore
> 
> > > nmi_swapgs:
> > >         swapgs
> 
> > > nmi_restore:
> > >         POP_REGS
>  
> > Sorry about that, maybe I should've done this instead.  Can you check
> > if it works correctly?
> 
> Its late here, but basic test shows samples being resolved to
> nmi_restore, when using the TUI 'perf top' interface and pressing / to
> ask for samples resolved to samples with 'nmi' on its name, several
> other such routines appeared on the radar, including:
> 
> Samples: 2K of event 'cpu_atom/cycles/P', 4000 Hz, Event count (approx.): 496683332 lost: 0/0 drop: 0/0
> Overhead  Shared O  Symbol
>    0.05%  [kernel]  [k] ct_nmi_enter
>    0.04%  [kernel]  [k] local_touch_nmi
>    0.01%  [kernel]  [k] ct_nmi_exit
>    0.01%  [kernel]  [k] nmi_restore
>    0.00%  [kernel]  [k] nmi_handle
> 
> [1]+  Stopped                 perf top
> root@number:~#
> 
> So:
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> And preliminarly:
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Applied.

- Arnaldo
