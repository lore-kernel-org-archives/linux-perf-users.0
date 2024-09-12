Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BA1B373C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152796; cv=none; b=IqhsG6G5Me7HPM944Zpx44ev32t/qyTZtht5Is8AduNWNlx0IZzL8CnOPLt4h9bymUG6T+CLt5m5pYpjEoa3bB1PlSwnhvwcVy4NmCdosD9y+my3/OLzIMzq6InMOsmIzYezg4bAOu8nC21XJHFHD/X/jevZBIlHbU0+DNgOdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152796; c=relaxed/simple;
	bh=p4xexmsKTe2G/tMmBJkR0GrHj9NToKdM4scDhSzOI8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2xZoJpTDH0XM0e4KGqZ/0Kr3GfwNorl4zAkTYDI9l21hWVvA4Q+V4uKkfkEuaZi1xrZBSlHh7YPIDqA8tmgziyT6RbQ0+Fla/yW8Ha+p781mBwm48mHlnTDBMz8o/qT0vEIV8ULy9TxUP/EZtg5EHxagXNKhYLRERrgz/Dyjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXQ+YwNC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXQ+YwNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D861BC4CEC3;
	Thu, 12 Sep 2024 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726152796;
	bh=p4xexmsKTe2G/tMmBJkR0GrHj9NToKdM4scDhSzOI8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXQ+YwNCI3ZZHiHPOGX+g3Rx80I5uk0SBfSQeFbulGjQgE6baOiIoBtL92N1RIJHX
	 crVkkOC+z0tKvYgi++REi4J7enJQbhm7CxAWV6r5oF/KnoTw09aL66nMQcugjVlTxA
	 1zW7DrBsDlRUxYHUqbMY2+Edy9vW4iBafjjeRjXrzYG2HzbqMdI8YokT2mTFdQEvr0
	 Gne8aja4r9d1qQt3hwlTD58Z7dktzzg6U5tvVOAfO/HcPfzdqQdlWtyTRaMai7VtZe
	 KJ9Rnmi+qqcRK2b5G97MyRp2C7tiUT1uOPXVRlhy78R9FM/7aIally8lmz7h5/hOcy
	 YyLUrMvVmZUoA==
Date: Thu, 12 Sep 2024 11:53:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	namhyung@kernel.org
Subject: Re: [PATCH v1 01/10] perf: Avoid buffer overflow in python register
 interface
Message-ID: <ZuMAWC80LzQ0vsm_@x1>
References: <20240905015300.2124798-1-ak@linux.intel.com>
 <20240905015300.2124798-2-ak@linux.intel.com>
 <ZuLhk6yGrr2HET6d@x1>
 <ZuL83U3PsOl44bvJ@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuL83U3PsOl44bvJ@tassilo>

On Thu, Sep 12, 2024 at 07:38:21AM -0700, Andi Kleen wrote:
> On Thu, Sep 12, 2024 at 09:41:55AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Sep 04, 2024 at 06:50:09PM -0700, Andi Kleen wrote:
> > > Running a script that processes PEBS records gives buffer overflows
> > > in valgrind. The problem is that the allocation of the register
> > > string doesn't include the terminating 0 byte. Fix this. I also replaced
> > > the very magic "28" with a more reasonable larger buffer that should
> > > fit all registers. There's no need to conserve memory here.
> > 
> > I applied this one already.
> > 
> > But you used the wrong list address, perf-tools-users@vger, I'm fixing
> > this up now to linux-perf-users@vger so that the message reaches the
> > mailing list.
> > 
> > I waited a bit for reviewers but then realized the problem with the list
> > address when trying to use b4 to fetch it from lore :-\
> 
> I sent it twice. The second version had the right address.
 
I have tried to continue reviewing/processing the patch series from the
one without linux-perf-users@ on the CC :-\

> But you were in cc and got both versions, sorry.

Lets try to continue from here, I made some comments,

Thanks a lot for your work,

- Arnaldo
