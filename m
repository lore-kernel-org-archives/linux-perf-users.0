Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D21319D8A7;
	Wed, 15 Oct 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520643; cv=none; b=AsDJRsLMhylZMeIj+IQlIZooF2hOvksNYCr7np0CzEXLVjkosZhalYikPJThLXYwyYlvcHFvDCoTz1xEkyQsU/suRmciOvfKSExXvaziFtLYjjrtXKWpJMu7FYhDbkmj2+uHug7LHnyf9wqMUu9fbKQCExJz258NF8vMCYmBhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520643; c=relaxed/simple;
	bh=L/zNEk9bn0tDLRCXSdg1Jppg2iskv6UAUr3H9yp4q+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHjRZ2Y05ulwqpQsMkx4Pp0Rkmcysf6Z/n+m3s0YPuspDM3AUUV5EBnCuUdkMD3ghWMLgcSNIgBKS2yvynUcZLSuatbDOK5EHW6PkjbO79BcO9BdybtZTEppfo1gkqF1oEMvqeiRsPsanKE2RausfcG94Xsy41EQDiLkXE2O1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BC9916A3;
	Wed, 15 Oct 2025 02:30:32 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 688043F6A8;
	Wed, 15 Oct 2025 02:30:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:30:37 +0100
From: Leo Yan <leo.yan@arm.com>
To: hupu <hupu.gm@gmail.com>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via
 EXTRA_CLANG_FLAGS
Message-ID: <20251015093037.GA109737@e132581.arm.com>
References: <20251013080609.2070555-1-hupu.gm@gmail.com>
 <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com>
 <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>

Hi hupu,

On Tue, Oct 14, 2025 at 10:31:55AM +0800, hupu wrote:

[...]

> > I am not 100% sure, could you execute install kernel headers and then
> > build perf ?
> >
> >   make headers_install
> >
> 
> I am currently building perf for arm64 in an Ubuntu environment using
> a cross toolchain, rather than compiling the entire perf directly with
> Clang. Clang is only invoked during the build process when the BPF
> option is enabled — as shown below where bpf is detected as on:

Have you installed the GCC cross packages ?

 $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
 $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cross
 $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross

My understanding is arm64 cross compilation tries to find headers in the
path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
distros).  After install GCC cross packages, the headers should appear
in the folder.

Thanks,
Leo
