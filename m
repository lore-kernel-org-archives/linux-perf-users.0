Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD61304980;
	Thu, 11 Dec 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449603; cv=none; b=MT0XXeWMIKzn3AIQpQG1aTF/fgPLnFuzrIb9tp9Lb/OH0O8Yfz1jsQDwHQy4g2+Nk+3XlqD5cdTaBQmN+MK3RM4Sqye5xlIR2NwUQAvLGSRruOFbp+zfNffFm9Eo6N8oOXt6ankbdH83Jar/MMmWoNovzqjokK0+Ft0ymCmxOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449603; c=relaxed/simple;
	bh=Jt7BSMaQBmg37w8DD4jeqFrNgJJzaDz4bKVHuPXOHys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtqii0oSJ7Sssz+G1UXL8idRURfo7H8UV2B6il5heFdGBPwjhC40ccaxrNs14Dr/ZMJHz4uI9kagXppsVUSHObqd4yWj3m0kftQqL31JYnijSYoA68ptm5nOVb2j4yy1guW/0hqf2eTlPuLiKO/DpiXfZ2aARJ06J5HiDZQ1zJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB82C175D;
	Thu, 11 Dec 2025 02:39:52 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 809823F73B;
	Thu, 11 Dec 2025 02:39:59 -0800 (PST)
Date: Thu, 11 Dec 2025 10:39:57 +0000
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
Message-ID: <20251211103957.GA4048253@e132581.arm.com>
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com>
 <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
 <20251125161026.GF724103@e132581.arm.com>
 <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>

On Wed, Nov 26, 2025 at 09:44:02PM +0800, hupu wrote:

Please don't spam on mailing list as you did. It is really bad practice.
You could find resources [1][2] to learn upstreaming and co-work on the
ML.

> The eBPF skeleton is compiled via clang --target=bpf, and its header
> file search paths mainly come from BPF_INCLUDE and TOOLS_UAPI_INCLUDE.
> It also uses '-idirafter' to include the host’s /usr/local/include and
> /usr/include directories in the search path. This process is not
> directly coupled with cross-compilation managed via pkg-config, which
> means PKG_CONFIG_SYSROOT_DIR does not affect how the skeleton resolves
> its headers.

Based on my limited knowledge, Clang does not provide its own headers.
It needs to rely on GCC's headers for compilation.  I do see the
Makefile does right thing for finding headers:

  Makefile.perf:1203: ***
  CLANG_SYS_INCLUDES=-idirafter /usr/lib/llvm-18/lib/clang/18/include
  -idirafter /usr/local/include
  -idirafter /usr/bin/../lib/gcc-cross/aarch64-linux-gnu/14/../../../../aarch64-linux-gnu/include
  -idirafter /usr/include/aarch64-linux-gnu
  -idirafter /usr/include

It is mess to add some random include paths and feed to clang.  We
already have provided a reliable way for building eBPF skelton program
- keep in mind, eBPF skeleton program is not any aarch64 cross
compilation, we just use clang for building bpf target.

My understanding is you don't have a sane setting up on your local
building env.

Thanks,
Leo

[1] https://static.linaro.org/connect/hkg18/presentations/hkg18-tr02.pdf
[2] https://static.linaro.org/connect/hkg18/presentations/hkg18-tr03.pdf
