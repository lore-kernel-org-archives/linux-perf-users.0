Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2C18E1F;
	Wed, 15 Oct 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532910; cv=none; b=D1qJd2gAbhf0P3yGGswHrLXW11S/iPtUAJh85cCSI4twNJKuBYcKHjl1/7CD0VMhcHjfX5pL0Clurf/C0PZaDerhLoRqOQNjZIVvKF6TF/bq7vu+PehqBetaUdRm0pJxSYI/0vYdFuIw7X79WIyQnS91qaeHsviwntToJD2CMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532910; c=relaxed/simple;
	bh=M7LZgsYmGKbke5vycr30e2TEGISa8Z8kXhYk9qYJvko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru07dGU9HQpBoIVG4ZZMEcwKZHti/srxTFT01nZaYaUzy0ZjNp3ojd19TPLjJNt9uP/rC13V84P5dQaq8rUk4IDkgjJLdYZZrvPsBFcgQQbAQXiGjZanJROz64HAaifiS6qMxNrdhNh+s4cf/UEBmJZ8wEavufXPAHKLHwbyoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 008CE106F;
	Wed, 15 Oct 2025 05:54:59 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CAF43F6A8;
	Wed, 15 Oct 2025 05:55:06 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:55:04 +0100
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
Message-ID: <20251015125504.GC109737@e132581.arm.com>
References: <20251013080609.2070555-1-hupu.gm@gmail.com>
 <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com>
 <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com>
 <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>

Hi,

On Wed, Oct 15, 2025 at 07:47:04PM +0800, hupu wrote:

[...]

> I hadn’t installed the packages you mentioned earlier, but after
> running the installation commands you provided, I was indeed able to
> successfully build perf.

Great!

> In fact, I’m currently working on creating an SDK package, which
> includes a cross-toolchain that I built myself using crosstool-NG. My
> initial idea was to install certain third-party libraries (such as the
> packages you mentioned) into the cross-toolchain’s sysroot directory.
> With this approach, even when developing on different host machines,
> we could simply specify the header search path (pointing to the
> cross-toolchain’s sysroot directory) during compilation, and the build
> should succeed without requiring any additional package installation
> on the system.
> 
> Based on this, I think allowing users to extend some options via
> EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
> However, this is just my personal thought and might not be entirely
> correct, so I’d like to hear your advice.

In the end, it is up to your target.

- If you just want an enviornment for cross build (no matter arm64 or
  other archs), my preference is to rely on multi-arch packages.

  For example, you can install arm64 version's packages on a Ubuntu
  x86_64 system.  The benefit is you don't need to maintain any
  toolchain/packages, all are prepared by distro. See [1] for details.

- If you are working on a build system (like buildroot or OpenEmbedded)
  for releasing a SDK. In this case, I agree that we should include
  headers and libs provided by the SDK.

Either way, I don't think EXTRA_CLANG_FLAGS is right thing to do, as
this flag is only for Clang and it does not cover any case for lib
linkage.  For SDK case, please check if PKG_CONFIG_SYSROOT_DIR and
PKG_CONFIG_LIBDIR are helpful (The doc [2] records info for these
variables, but I never verified it).

Thanks,
Leo

[1] https://github.com/perfwiki/main/blob/main/docs/arm64-cross-compilation-dockerfile.md
[2] tools/perf/Documentation/Build.txt
