Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10E19006F;
	Wed, 19 Mar 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408894; cv=none; b=WreJwewHeP7UXWMl28y9rFMFzl4f8kC0p9lPFXLTrX/ZEOlDnK/66kosdojeDBWXgVNLSKj3KrX3J/oMvE8/A0N8Ahh2+ZHAIOqoy3DGrLI0TLt+kp6v+nsgZywX5XirMfn/9xUfkEDkv4UzPaDWeONwSwb7B/AvFcIkOB6flsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408894; c=relaxed/simple;
	bh=Ufg8GgfPls9eB5l6C0aWTfvK3EcU0OB1yfTlfpi5B0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBGsamMj87WAyw3jHyU4PvLMZKAS/3hdzUob2axAc2RCct8dp0Xi1m914G3QZC6ingAEwR7t79fLokYTeqBA6vencsoV963eOXwLyaZ8iTDzVGMeqnIbJJaBTL/ax8SjRLVPjJ381EYafQlKVMuejxuA32kFFt21FpoA0MBjCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0C4B1063;
	Wed, 19 Mar 2025 11:28:18 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ACD63F673;
	Wed, 19 Mar 2025 11:28:10 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:28:06 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Restore {0} initializer since GCC-15
Message-ID: <20250319182806.GC3249206@e132581.arm.com>
References: <20250319110454.3230687-1-leo.yan@arm.com>
 <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
 <20250319133055.GA3249206@e132581.arm.com>
 <CAP-5=fUp492RATRhc-OmikK7knO+PUWAt6Z-60Cax0QOJPrFgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUp492RATRhc-OmikK7knO+PUWAt6Z-60Cax0QOJPrFgg@mail.gmail.com>

On Wed, Mar 19, 2025 at 08:26:10AM -0700, Ian Rogers wrote:

[...]

> > > Adding options that allow people to add more non standard code doesn't feel
> > > very portable or in the spirit of doing it the right way. Maybe there's an
> > > argument that it guards against future mistakes, but it's not mentioned in
> > > the commit message.
> >
> > I think Linux perf shares the same understanding with "we do expect
> > initializers that always initialize the whole variable fully" (quote
> > in [1]).  Furthermore, the reply mentioned:
> >
> >  The exact same problem happens with "{ 0 }" as happens with "{ }".
> >  The bug is literally that some versions of clang seem to implement
> >  BOTH of these as "initialize the first member of the union", which
> >  then means that if the first member isn't the largest member, the
> >  rest of the union is entirely undefined.
> >
> > So I think it is reasonable to imposes a compiler option to make
> > compiler's behavouir consistent.
> 
> We have encountered this problem, here is a fix for a case:
> https://lore.kernel.org/r/20241119230033.115369-1-irogers@google.com
> It would be nice if rather than -fzero-init-padding-bits=unions there
> were some kind of warning flag we could enable, or worse use a tool
> like clang-tidy to identify these problems. In the linked change the
> problem was identified with -fsanitize=undefined but IIRC perf didn't
> quit with a sanitizer warning message, just things broke and needed
> fixing.

I searched the GCC online doc [2], I found below options but none of
them is used for such kind of warning:

  -Wmissing-braces
  -Wuninitialized
  -Wmissing-field-initializers

For the "-Wmissing-field-initializers" option, it says "In C this
option does not warn about the universal zero initializer ‘{ 0 }’".

Linux kernel has added the "-fzero-init-padding-bits=all" option in
the commit:

  dce4aab8441d kbuild: Use -fzero-init-padding-bits=all

Maybe we can do the same thing for perf?  This could help developers
and maintainers avoid endlessly struggling with potential bugs caused
by "{0}".

Thanks,
Leo

[1] https://www.spinics.net/lists/netdev/msg1007244.html
[2] https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
