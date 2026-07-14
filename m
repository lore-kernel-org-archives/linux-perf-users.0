Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE34279F9;
	Tue, 14 Jul 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018227; cv=none; b=gplWne0djxEdo5d1AxtHi9cT3Hw/w2vdcT62uojpz/kVGIlRKQVMIk2lotN6rdxt+S8r+TltJBiX/dVZxp+INzE9HZfMPyRaP9Jp+b8VZ7Qi/uj3y59mJ18UK6e72/kNg7COqEqfo0ScQWg0jsHO5MJAMWDIxvETdkYaTC9LZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018227; c=relaxed/simple;
	bh=2c9WEkCUcKYmrL5NlYbbccFwS1NH6yO/ARWIHOgZvvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtbwfN27TtypjfMrhBvAws/DcwpJp/GyDv4y/VO4X6Z7quXVBJaomEaZjBOTEmuZKrWDmEproN5XmU0opB3O7YScLJgHacUFbFp0frpPThGXhFO8fMvndy78K+LT5YJEl7JlVRsPGKL2Kta2Ul2ituS+gK91qs4ZDjX5FSr7skY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tsPv+BoD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tsPv+BoD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 807CA1476;
	Tue, 14 Jul 2026 01:36:50 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D1B03F7B4;
	Tue, 14 Jul 2026 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784018214; bh=2c9WEkCUcKYmrL5NlYbbccFwS1NH6yO/ARWIHOgZvvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsPv+BoDNhyja7+3RNAw6/UjvLAmmP3tWY+Zb59Mm5VjCEhNky+J4/Y7233j9KBOl
	 tm6BLy3eRdYDgfJEbI4pcq2i/Q3Hb1CweZE3pL679RTo3ZjDUw9WYt7mzJB7yTUpJH
	 rAbgvVua2FYwlnonOAOHiwjIbukV2qrM0Ok7GoXo=
Date: Tue, 14 Jul 2026 09:36:52 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf capstone: Fix build with Capstone versions before 6
Message-ID: <20260714083652.GD512733@e132581.arm.com>
References: <20260713-perf_fix_capstone_build-v1-1-796ea08c04db@arm.com>
 <alUi7RgZkINlZOKP@google.com>
 <20260713182133.GC512733@e132581.arm.com>
 <alVQY7uJzapcfDCr@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alVQY7uJzapcfDCr@google.com>

On Mon, Jul 13, 2026 at 01:53:55PM -0700, Namhyung Kim wrote:

[...]

> > Perhaps checking the Capstone version would be a safer approach?
> 
> I'm not sure.  IIUC RISC-V support was added to v5.0 and CS_MODE_RISCV_C
> was changed before v6.0 is out.  Do you build capstone from source or
> use a packaged version?

I checked Capstone source for two RISCV commits:

  ec6428f9 Refactoring the RISCV architecture to Auto-Sync on LLVM (#2756)
  b8fcf27b RISCV support ISRV32/ISRV64 (#1401)

  $ git describe --contains ec6428f92
  6.0.0-Alpha7~10
  $ git describe --contains b8fcf27b2
  6.0.0-Alpha1~513

This is why I concluded that v6.0 is the version start to support. I did
not build capstone from scratch but just use a packaged version.

Just remind, CS_MODE_RISCVC might break build when you work with the
latest Capstone, as it has been renamed to CS_MODE_RISCV_C.

Thanks,
Leo
