Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B72E401;
	Mon, 20 Oct 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968216; cv=none; b=LjaIUY2j0ForNEQ73ahhrEPeiexOEP9pkmZ7EGQCeBuV4g2q5Dpp2XyimbpTd3u0vXkpqrslpWwHrS8Fbf0qt3ByIxxgYRNR9w50FgN9E6R0EAHIZ8165MU92V0t/dms63krf09Rmn3Q1E+rKUl/FAMGBC0mqmIT+6eMs64mHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968216; c=relaxed/simple;
	bh=OvTOEHW5NYCElslWGm6mLmmNPYWdNchYHKB8AjYRknM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqD29OHQ3oaq8VJXYZJ6K36dG8FI1QxWHQIANeILNgHxPgKt77gkoPP6n0q7rXsNHM8Pn51IQeQVZwQCOpN5bCg5Maxs8Tx5zEdCuhD6pbg/+9Dpp280LUjLRxlzKFLxfB3JqHQj8B8TlywrGRUBOm88Y/NOF6hdrGUd74GUzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D991758;
	Mon, 20 Oct 2025 06:50:06 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E666C3F66E;
	Mon, 20 Oct 2025 06:50:13 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:50:12 +0100
From: Leo Yan <leo.yan@arm.com>
To: hupu <hupu.gm@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, jolsa@kernel.org, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: Re: [PATCH] perf build: Support passing extra Clang options via
 EXTRA_BPF_FLAGS
Message-ID: <20251020135012.GG281971@e132581.arm.com>
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com>
 <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com>
 <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>

Hi hupu,

On Mon, Oct 20, 2025 at 08:51:52PM +0800, hupu wrote:

[...]

> > To be clear, now we are not talking cross build for perf program or any
> > targeting a CPU arch, it is a build failure for eBPF program.
> >
> 
> I’d like to clarify the background and scenario once more:
> I’m building an SDK that includes a cross-compilation toolchain for
> the target architecture along with a copy of the kernel source tree.

I am not preventing to use toolchains in you mentioned SDK.  I just
prefer to give priority the headers provided by the kernel source.

Seems to me, a more reasonable series would be:

 - Fix the eBPF program build with using self-contained headers;
 - Extend to support external headers.

Thanks,
Leo
