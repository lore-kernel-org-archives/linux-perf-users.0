Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E220C461;
	Tue,  7 Oct 2025 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860400; cv=none; b=NT+QGUQnNIBM8nqcWUATE2ZKZQJZKteqwm7ladNcbpbSShB4br2evtSREY6ZziYx6Hf9ZEfH451b3RvapY4vgaZAr5YtaJ6LwQTeFjSreWFHgQWGC4Rr78JVuPDs1/md17E3V5Q5SPCFIncVv0G0o1CJD9eRMq35Asfw5UOE3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860400; c=relaxed/simple;
	bh=T5eFI0cCUTX1tL5pFhdww2ZbEwXDTbJPOJ7jpuorc+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgZWg8EcYoRnX+SLQzePmT6yOpfYXSZusSpgSx7c1GX2XhMYddPSIFu6G16T+u7ayumTgrYy7b3KW4ycT+KKzj1Yc9w1kceUqwHAvaSSxsi1fITqp9YaGhyD30vP5JSlOAJ2xNafasjOhyaJtUdTBSBbtgQFhYCNKkqhMXneCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED742106F;
	Tue,  7 Oct 2025 11:06:29 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8823F738;
	Tue,  7 Oct 2025 11:06:37 -0700 (PDT)
Date: Tue, 7 Oct 2025 19:06:35 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/9] perf build: Support building with Clang
Message-ID: <20251007180635.GB77665@e132581.arm.com>
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
 <aOQPeqqFn0yxgC4h@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOQPeqqFn0yxgC4h@x1>

On Mon, Oct 06, 2025 at 03:50:34PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> I shed a tear ;-)
> 
> And thanks for fixing the ubuntu cross builds, I'll apply those patches
> you made available thru github,
> 
> Thanks a lot!

You are very welcome! And very appreciate you shared build container
scripts, this would be a big benefit for CI test! (I have enabled the
test on my local machine and works pretty well).

Thanks,
Leo
