Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C93A1DB;
	Thu, 12 Sep 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153101; cv=none; b=guRp2X1cYAoDYkx+QXHboII9CrS66QjTdcnfKHUwSUJVCjcsnLYotB+Avno394qYRA0UhP7dZHALcG0L8XvQd8d9pAbXb2io43SvpRKZw6PdJoKi2xs2D4+dYL/AXXZI1xXs3PRzYMwpa7Q/ZiS1ELzqLgw8lMg17UxZGgm9nHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153101; c=relaxed/simple;
	bh=0ZCvjbIDuXmVeY7i4CqypHwY7qxc4+dWoIzB5HcQtB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbWqXUezMvsR3JE4PplN3hnJUfCaqhzpRCMxJ/b1zQQwrnZr+kcTc/EGzgIxyJ/P7X0OQXRXYxBhX2vuT6XNRBntHJf6sHuqyiw11CL5882DrIPNX5iZ1n8krH+R0uSzoli0mHZSdStxYZuNwk3uu1+3bLvB65uN0YTwUQJzbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPct3WBg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPct3WBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726153100; x=1757689100;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0ZCvjbIDuXmVeY7i4CqypHwY7qxc4+dWoIzB5HcQtB8=;
  b=LPct3WBgrkzUGshRHvxwpTv8S7m0cRqH3PRzKRNBuMSmJPRB1gVo1S3g
   SjBKXRs7Q1e5tfkufF5JIXjmw69zWg+EOQugKfeE/fbrelIZJcUgLPiuP
   jUaHHyte75ZxxDcYFxM0ataN/sGS1NaMwSm5ToGYCQVhYvivABzUIuI/k
   KRQnI9yR7UNZy1Ye5xiJweDhvmM07/QdZ9x4ybk8BdqG3axaSgaRZmwDm
   M6TGR0oVmYccL8xpjA6QTBvhgUWL96BBqT+hiPgUl5IveyrZTp/2oP9YA
   Aifl1rQNBvSUGOmVOCbmSaqnr854Fn7EcshGP6pEE0wiuHXRmZG8D3H3z
   A==;
X-CSE-ConnectionGUID: cEVewmN1RReBRJJ4JHJI0Q==
X-CSE-MsgGUID: PbN2s72URtKzNgtFge4XoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35680065"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="35680065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:58:19 -0700
X-CSE-ConnectionGUID: T2m0SJ30RkqhYbBaJoYBNg==
X-CSE-MsgGUID: wsHaKjRvTBqkM++4izdQoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="68513357"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa008.jf.intel.com with ESMTP; 12 Sep 2024 07:58:20 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 39B703023B2; Thu, 12 Sep 2024 07:58:19 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Steinar H. Gunderson" <sesse@google.com>,
  linux-perf-users@vger.kernel.org,  Adrian Hunter
 <adrian.hunter@intel.com>,  Ian Rogers <irogers@google.com>,  Namhyung Kim
 <namhyung@kernel.org>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 02/10] perf: Support discriminator in addr2line
In-Reply-To: <ZuLj5o6FwBJsk_1x@x1> (Arnaldo Carvalho de Melo's message of
	"Thu, 12 Sep 2024 09:51:50 -0300")
References: <20240905015300.2124798-1-ak@linux.intel.com>
	<20240905015300.2124798-3-ak@linux.intel.com> <ZuLj5o6FwBJsk_1x@x1>
Date: Thu, 12 Sep 2024 07:58:19 -0700
Message-ID: <87plp8hqb8.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>
> I noticed that this is under:
>
> #elif defined(HAVE_LIBBFD_SUPPORT)
>
> That isn't built by default due to licensing issues, i.e. we only build
> it if BUILD_NONDISTRO=1 is selected on the make command line, see:
>
> tools/perf/Makefile.config +943

Yes I know. I ran into this when my perf report runs were suddenly incredibly
slow until I figured out how to set this flag.

It's sad how theoretical lawyerneering breaks perfectly fine code.

At least I'm fine with whatever legal risk this causes.


>
> And we have the patch below now, can we try to use it instead so that at
> some point we can remove the libbpf support?

I also support the external addr2line.

But yes need to support the LLVM version too. I'll look into that.

As a side note. I always disliked the LLVM dependencies, these
libraries/packages are gigantic and traditionally unstable in
interface. It would be better to use a sane small library as a
replacement like https://github.com/ianlancetaylor/libbacktrace

-Andi

