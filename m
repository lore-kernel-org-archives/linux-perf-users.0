Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9C1CC16B;
	Tue,  1 Oct 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807885; cv=none; b=PEHT7f4U246RTQJapCd+fyyfZ9Et4B3PAf0c3DWGY48nDhsJbTVZD8JxNoHwG6MoSXJeRoiXAFPbE3Lm6vQeY2+ep93nEguzp1ptVBnphWTDSdNcAQW/PnLnVKNXD2yFGqPlE7389I27tsdXpBj4u8uI4dowhwXnatQ6xk8pjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807885; c=relaxed/simple;
	bh=GLAn/ZtWj2XvCyHbIePKftJAaszPcF3l8iV9kilIl0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR7c3/WYdEsdgEJu5VUai1TZQmhIYzbcN68FSuTVTJ6irM5plxYjYWvc7LMiUxY9VGz2JUmWOoLFCy03xJ7LBxKJhp2yFWCRCNkHTCX4yjV4mJBO32i2+VWLN+KYk3b0R2UWhPTnmSV0MkwWLj+3qKoTnEUK1LpspSHFWKEMPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpM66NYY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpM66NYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9650C4CEC6;
	Tue,  1 Oct 2024 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727807884;
	bh=GLAn/ZtWj2XvCyHbIePKftJAaszPcF3l8iV9kilIl0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpM66NYYhStxNDep7lbyEiSQjmxpxd1+CVTLf7aJS47rW1x2euCwnZN9drFR7nwU5
	 ddhI7h85wFghnO7ljFYig9LXbnQUVKvztQLbRyYZi2IsbxxE0ba5lwSkDGHLVyyt+x
	 AHLfxkbARlTwjEsUvSsXP6jIW6+ruLtsJd1SqM8/pOOw5/toov4Coy2TdKvliI9nLe
	 tSgBvwSnip8J3B4DCBiOuCNQhKX6YBZPuv3l6ny9oe5O+DuyYYcQm25cbspZIorWy3
	 hGK9zBQVHsVPuUSOjF5pYw+biMqDbSUIca2hq4uuRZjwhXg9+K+kNmrsMnd2TfWppT
	 lClaaNeaLG4mA==
Date: Tue, 1 Oct 2024 15:38:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Subject: Re: [PATCH RESEND v3 0/3] perf: build: Minor fixes for build failures
Message-ID: <ZvxBiXAgHuOleOWk@x1>
References: <20240919013513.118527-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919013513.118527-1-yangjihong@bytedance.com>

On Thu, Sep 19, 2024 at 09:35:10AM +0800, Yang Jihong wrote:
> Changes since v3:
>  - Add reviewed-by tag from Leo. (see Link[1])
>  - Resend the patchset with no code changes.

Thanks, applied the first two, the last one I had already picked a patch
from James with what seems a more appropriate Fixes tag.

- Arnaldo
 
> Link[1]: https://lore.kernel.org/all/b5688d4a-9389-4998-8031-3f002302311e@arm.com/
> 
> Changes since v2:
>  - patch1: change LIBDW_VERSION to follow up the style of
>    LIBTRACEEVENT_VERSION. (by Leo's suggestion)
>  - patch2: Use a new line for the -ldl dependency and with comment,
>    synchronize tools/perf/Makefile.config. (by Leo's suggestion)
>  - patch3: include header files in alphabetical order,
>    add reviewed-by tag from Leo. (by Leo's suggestion)
> 
> Changes since v1:
>  - patch3: Remove UTF-8 characters from build failure logs
> 
> Yang Jihong (3):
>   perf: build: Fix static compilation error when libdw is not installed
>   perf: build: Fix build feature-dwarf_getlocations fail for old libdw
>   perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
>     undefined
> 
>  tools/build/feature/Makefile | 5 ++++-
>  tools/perf/Makefile.config   | 7 +++++--
>  tools/perf/util/dwarf-aux.h  | 1 +
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.1
