Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1659B71;
	Fri,  3 Jan 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922036; cv=none; b=hWLsGhWevNMwnWZA2nUNi83Pnli65RzaTPdzSs/ES2LiMApMNSQod1lM2kZWaswkM23qqKgv3FnUEekBqDxEZDuw5+o28BS8EFdnIVfKN8dCV6Zr6hajp024prfnTxoi14xpjpo2d7RtVYn9Srs4xxy1IoIzoPA45675kVSM5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922036; c=relaxed/simple;
	bh=E8LJpDYfeZi2P7m90MqY1U3yJGrtNPFNnNjlRvZewAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gep6d1qts0buv91MTbuQoSvylNS3lV56PqOPHV3yxWhsB5OD1YgPf9UOAIXxIayVbHn2KAdexccb2f/p7dXQBoi5yywZgymIDZ/gUlCn+otH4NQjq4PW05vgOKv1ON7upYvRT0UoY8tntzMwBaqfQN4FrSOKv5GVnoHmyCEu2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2hhgi/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2hhgi/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69100C4CECE;
	Fri,  3 Jan 2025 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735922035;
	bh=E8LJpDYfeZi2P7m90MqY1U3yJGrtNPFNnNjlRvZewAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2hhgi/Y1cpQITkj2Dvgr1Ru2I7Ray2bNgyiMUl87qQ8yGWEy74FJ5jUXU55IB7ui
	 8jKPVCjWBLKFxoKsBvyi5dBMHwqi2Y0mrrr4hScefaBZJl55s24LKuQsO9lY6Oo91q
	 Cyc8G2HhSfOEiT51DJd2N4m3DwMxVFbE7pOOjvp81e0hVZNBlYUmZq11/R8I52/7Ae
	 fXvtGt7OUFUPfgn+DE0r/0t2B8h7pccLbE9aj8hpTJJBZW3c2TqYoccmv8Z6F8KVw6
	 HUqtgfc/qmslmCP8qvSVdjqq2QWuYfq/9PUFQqJh7D+XsCS3+TKomS16l3idSuriHK
	 5HEUHjugI5zeQ==
Date: Fri, 3 Jan 2025 13:33:52 -0300
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
Message-ID: <Z3gRcBeuaQ16IQSO@x1>
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

Please also add a:

Closes: https://lore.kernel.org/lkml/Z3buKhcCsZi3_aGb@x1

So that further details are provided about what those asm symbols are.

- Arnaldo
 
> Thanks, I'll submit the other patch, that now doesn't need to go into
> the 6.13 window and thus can be added to the perf-tools-next branch,
> tomorrow.
