Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DA3090FB;
	Mon, 13 Oct 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372076; cv=none; b=uBR9kqsWDBWvgCYOCXh5t/eRjm5EIdkqiI8qYSQ9W8V3231QMy+mgJXOp9qNORJivHEMc1HaEoD/jnpv4aST7JbxD1fq8LTdEMSAeVlovd6KIf6GDHYZrT1PxRoSt3h1TfhT8Afzxr5pSFg7Fj1PdT5EFvvpl3bQ3FvdhEq/bLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372076; c=relaxed/simple;
	bh=Hz5zfGbrdk7r3/RJWa9oOO2sk21NzduvsKXxM+b+1A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLW4vsNYAwm5AtfxMBmmbX3vLVMij7WWNEv1mnIMBgsrJHI4JaOrrEilenyhJZ67WgZwdWaRTQRMHObcSHL4xJnsRHKIva9RcfR6tMKiVefhzV36FTykmoC1wATT2UVcJizAoTd3VuBVnjnpgFu6gni/jt2XvkoZ3tBcEAgEadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AE7A113E;
	Mon, 13 Oct 2025 09:14:24 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E857A3F738;
	Mon, 13 Oct 2025 09:14:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 17:14:29 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: hupu <hupu.gm@gmail.com>, namhyung@kernel.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via
 EXTRA_CLANG_FLAGS
Message-ID: <20251013161429.GE77665@e132581.arm.com>
References: <20251013080609.2070555-1-hupu.gm@gmail.com>
 <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>

On Mon, Oct 13, 2025 at 08:46:01AM -0700, Ian Rogers wrote:
> On Mon, Oct 13, 2025 at 1:08 AM hupu <hupu.gm@gmail.com> wrote:
> >
> > Hi Maintainer,
> >
> > I encountered some issues while cross-compiling perf (ARCH=arm64),
> > particularly when enabling the BPF option. During the build, Clang
> > fails to compile BPF programs due to missing header files. The
> > relevant error messages are as follows:
> 
> Thanks for reporting this issue! There has been some recent work in
> this area by Leo:
> https://lore.kernel.org/lkml/20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com/
> The patches are in Linux v6.18-rc1. Perhaps you could try repeating
> your build with this tree and reporting issues?

I am not 100% sure, could you execute install kernel headers and then
build perf ?

  make headers_install

Thanks,
Leo
