Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203A5A79B;
	Thu,  1 Oct 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846366; cv=none; b=cJ0pX5vEvg+TDM/BxDMwZ84wf+oBxxRCNb3eW63gwC70rqh0gS1NmD8Z1eBKhFZeCCGK0hUGzx9LBjINZGMJ7S6MclJC06E7ZKiNMY+unHiT2rZpW3ycWveUpqbiKnLaOWF4XrpHnScMEOogB8+a+QqNeosGe1nbS8/wYXpl2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846366; c=relaxed/simple;
	bh=4RBwIr++Yl9TDg/DOmV0XfIAoON26aEenWCykA6bz7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et/1FxTWdhN2M9D/qaGOcJlI7w+rVC9ZB1/GCwDEJrF3/96XCxG0PSbvA056mLvqsTWT0eVkbnNzceB2ZINLZkkeJUAUzWCAbbIYAw8AdT4z2I9L+nuHIu+A3Bkhes97R4tBAX0/JGul0K3ufTexn7hvyPNtFBx4BAB1Ozv58cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRBctCWV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRBctCWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BC91F000FF;
	Thu,  1 Oct 2026 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846365;
	bh=IB/cldJEcsCChjuHmu5N7366XE75RvVggd3avYtDsrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRBctCWVe9GhpYruWKH35vFJnHCtb/Ex+CTIRHh1DHeFcT5PaJ6bm7Ug0KvYBvSiy
	 c2k2mKi81LZJSdisvlOobFdWP8SXo5droweS2PFxdz7YSTMRFJ98Hng1KAhGV/Fuih
	 Hh1x+0CD/ZadKpDhfRVsHJ+fPxNel7tmfXTn/jds8X2V8/b04FasImvoXHgxuuc0Bs
	 aNhGU1d16LpWGnxRwBhQR/PdSMzdemK6HJ9HdWn/yihUzDEv45pSU32/uiaoXbdUEx
	 FgQhfe0+DVxsYYNTySwfTsA3r+WPzHR6FSMmDa4Q4YZeXzxOXCDd4MPnoVpR7wvSn1
	 QDKVWHaKQmkOQ==
Date: Thu, 1 Oct 2026 11:19:21 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 4/5] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Message-ID: <ar4lmUdWLn60UJ-6@x2>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-5-acme@kernel.org>
 <ar4Kuy76IXbmCY2y@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar4Kuy76IXbmCY2y@z2>

On Thu, Oct 01, 2026 at 12:24:43AM -0700, Namhyung Kim wrote:
> On Wed, Sep 30, 2026 at 11:37:15PM +0200, Arnaldo Carvalho de Melo wrote:
> > +    set $perf_die_chain_i = 0
> > +    while $perf_die_chain_i < $perf_die_chain_n
> > +      # Pointer type DIEs have no DW_AT_name, so dwarf_diename() can
> > +      # return NULL: printf %s of it would error out and abort this
> > +      # batch script, handle it.
> > +      set $perf_die_chain_name = (char *) dwarf_diename($arg1)
> > +      printf "chain[%d] die=%p addr=%p cu=%p off=0x%lx tag=%d name=", $perf_die_chain_i, $arg1, $arg1->addr, $arg1->cu, ((Dwarf_Off) dwarf_dieoffset($arg1)), ((int) dwarf_tag($arg1))
> 
> Nit: can you please break this line?

Will do,

- Arnaldo
