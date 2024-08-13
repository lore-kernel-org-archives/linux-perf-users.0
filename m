Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74546282E5;
	Tue, 13 Aug 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574165; cv=none; b=MNUVQBB/zpYvofzeJwbSDrywD09y0LrNvSz0mrR8b+vz1iCw/UJX737VBBh59GnocCix4FjGrYnWTJrIspKenHatp0NECBVwX+51pE4Z9vCddk44b08hVZeDVFEn8i+/dPsNIZRwMSGtbW/9LbwM/CSdxIIBqN16VOU/TBd4qPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574165; c=relaxed/simple;
	bh=yfUAgiTSwF682SRGuBBXsp3ylCMHuyTpDZ5JNiWv+S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqzdRBriiOegvuks9IaG+P85kGC8fdl0VBEWyqTr7oUhq73d+TjlXCxXgjD0UAhJlaOeLUkpfLNhxzG0BXE8ZnuQKSMqfe9plBVdjlPzxEVvfg4EdRjqB3/d9X9LrpU1iRwfx9P/E617/nsRj6CaGszfG/8yo4dZt5T+E0p6VzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUQrPrBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUQrPrBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50009C32782;
	Tue, 13 Aug 2024 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723574165;
	bh=yfUAgiTSwF682SRGuBBXsp3ylCMHuyTpDZ5JNiWv+S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUQrPrBmzQ2mIJ4GKpuL8plOLMpwQHkGPHKU49RDayR+5REELr0yz0B2UFikeZS/4
	 um3A4IoMmkMFLjvhBqRPvS6iFYvTnA9hw1hAShS4oZa6B2CzXTMCOKroUL8XNo8DeU
	 Goj6mfRfxaixL/bThlDcdk1fLyuw/ddTSUdmFYsHg9OQNCYqLL5lhnZ5wj04icha3N
	 RAxAvTHcqYGfrdJEWjUyxG9yVUEDd7ykWER3aC0qPrrqDpMEnfMmMPLp/ctLMs2COu
	 N4ZglYYHMQrvonmlhBqLjq/Ga3WO/VfgWaok5A157ENBKIENvRurm8EMbBhApRwU00
	 fwNRTlq78L9IQ==
Date: Tue, 13 Aug 2024 15:36:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Wang, Weilin" <weilin.wang@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS counting
 mode
Message-ID: <Zrunkf8jyqummurt@x1>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-9-weilin.wang@intel.com>
 <Zrq11fq_F9vImsQh@x1>
 <Zrq2IoAgopw1NbbA@x1>
 <CO6PR11MB5635B87159218287A4E8108CEE862@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAP-5=fX9pLRig7qJ+6Wk1g9ysDUDDKXMbo4s1GYvz28iAPs1iA@mail.gmail.com>
 <Zrulm_giiqaFP1li@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zrulm_giiqaFP1li@x1>

On Tue, Aug 13, 2024 at 03:27:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Aug 13, 2024 at 10:48:21AM -0700, Ian Rogers wrote:
> > On Tue, Aug 13, 2024 at 10:18 AM Wang, Weilin <weilin.wang@intel.com> wrote:
> > > I just checkout the code and tested it. The failure is caused by a seg fault on a
> > > perf_tool struct that is not initialized correctly. I think this is related to the patches
> > > on struct perf_tool in this branch that applied right before the tpebs patches.
> 
> > > I was able to fix the seg fault by adding the perf_tool__fill_defaults() back. Since
> > > Ian updated the code to replace this function, I think I need some advice on how
> > > to use the new code to initialize perf_tool correctly here. Should I call the
> > > perf_tool__init()?
>  
> > Yep. If you've added or refactored a tool struct the intent now is
> > that you call perf_tool__init then override the functions you want to
> > override. I don't mind to rebase those changes over your changes,
> > Arnaldo if you want to drop those changes.
> 
> So I'm adding the patch below, which should be enough, right?

Everything is in tmp.perf-tools-next, will move to perf-tools-next at
the end of the day/early tomorrow, after the container build tests
finish.

- Arnaldo
