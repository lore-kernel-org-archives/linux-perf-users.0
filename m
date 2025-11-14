Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DF1DB95E
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763162864; cv=none; b=MrNsexRKpJSuzE8kcr2JJmg2kNqwql1uMDV+/Z5VyxqZege2No0JnaMNrVX8Ck+dgbx23tlmDDKbxElWKtLi7E+wR5RnfOY+IDg/UmDdSFebaXb7+SGZOcrt4PVQVqske+Er0WpGe9N6+fD5FcAHgdV83qp5hsrvz2t+KnrfR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763162864; c=relaxed/simple;
	bh=g0H4y+6OIMOvABY1b0O60DWti7VVqpiof1utZpMzUgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAZ3o6zD+O6K+xSNxGUYti7KYKeO0h/1jARFBgFXKOBi8Mw0IEuZOTZQAceC9mFlj6m7xeHoXDRkUydCi3XkY4XnY4mENfsB2Xjp+ZGByhl4SLPz0RN+L3JGbSMYJskwKF4cnJIM9KnDod9kQveXzDMNpLSJk0SqTBiGZhF/qRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGgLVcBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGgLVcBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FE6C116D0;
	Fri, 14 Nov 2025 23:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763162864;
	bh=g0H4y+6OIMOvABY1b0O60DWti7VVqpiof1utZpMzUgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGgLVcBZ57egBBwV7QZ0v9Ji0pkV29gejcEWVIUiZBZeBmxg/OheAm2g3vMX3Iw13
	 VZbAAM9jH9QFcFdQxkzfNYvOqBwExI56TPHcC+iYIpHWZJunZ9YqxWsfofmwWeg5W+
	 5QuZMqdVV6KeNwMMYEo6eTyJ8XOKBYl1D1ANhChCZilKsl4NdWTuhfxrmgcTcNAjbL
	 FXYYo+oEpAwPLE5rNAlBe7o0oWQvAfrNyZlR3JmpoBueXeAS/9wmuNaEbzT/FgthQk
	 roUx3tJqeKCM81pQLLanbghfFwM6iXis415Unzvc+LS0Q/esZesu/I/PIq5TaEZ7nn
	 zxb/oFaNJFulA==
Date: Fri, 14 Nov 2025 15:27:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Pablo Galindo Salgado <pablogsal@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Add python JIT dump test
Message-ID: <aRe67vqAUlIEo90-@google.com>
References: <20251114092914.217533-1-namhyung@kernel.org>
 <20251114092914.217533-2-namhyung@kernel.org>
 <CAFjbc8FK_qs9XqMEf5k81VRNCNXSyda=VUSuJwp8LALOq8fGvg@mail.gmail.com>
 <aReBx2jFezxbhWt0@google.com>
 <CAFjbc8ENz1AhCH0MBMmcrJB34GvjWPjzV3i0PEfnsTAampe8-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFjbc8ENz1AhCH0MBMmcrJB34GvjWPjzV3i0PEfnsTAampe8-w@mail.gmail.com>

On Fri, Nov 14, 2025 at 10:27:43PM +0000, Pablo Galindo Salgado wrote:
> The version is likely the more reliable method, but you could use
> sys.is_stack_trampoline_active()
> in combination with the X option. For example:

My concern is platform support.  Is it available on ARM and others?

> 
> $ python -c 'import sys; print(sys.is_stack_trampoline_active())'
> False
> $ python -Xperf_jit -c 'import sys; print(sys.is_stack_trampoline_active())'
> True
> 
> If you get False even when passing Xperf_jit, then it is not supported.

I like this.  I guess it'll return False on unsupported archs.

Thanks,
Namhyung

