Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52133C2F;
	Thu, 20 Mar 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483212; cv=none; b=pCQwwHiYxesaFDB2966viVcNczEEu5BB0fjX5gysOWIkpym4y3eNE9ilx3WjTEpQW4DskMyXGTFGoOxR7Uve2BKCj4+Ne/D6O1iAp4CMMsDWloVNhrDzHAc7+ajLvBW8kGNuM6zFDDJazIH3+j9mTxCwYOtp3BOu+UPZqPWEUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483212; c=relaxed/simple;
	bh=g0pGFfqdoGk8/qnpgAwUuJueUP/NWk07NhDLR62Jedk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoxLtt8w3Ybn2ZWgDw+YYyjiKpDBVvMkbiLHoEv/zbbocpmrY4978+xnz8hCK/qqnVHjFf5ol+V69bPzINCvuliUJug9e7LjGncTAzBpVHMXQmr6jNSZ8XvHZ17paMtWXtAPmww81GQEb27kPWriM0RVgVePFo4dqaMJ9RFqExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F15106F;
	Thu, 20 Mar 2025 08:06:57 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7793F3F673;
	Thu, 20 Mar 2025 08:06:49 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:06:45 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf build: Use -fzero-init-padding-bits=all
Message-ID: <20250320150645.GD3249206@e132581.arm.com>
References: <20250320105235.3498106-1-leo.yan@arm.com>
 <06233fa3-0663-4861-8fd0-ca30806d38a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06233fa3-0663-4861-8fd0-ca30806d38a3@linaro.org>

On Thu, Mar 20, 2025 at 11:46:03AM +0000, James Clark wrote:

[...]

> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -323,6 +323,8 @@ FEATURE_CHECK_LDFLAGS-libaio = -lrt
> >   FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
> >   FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
> > +# Explicitly clear padding bits with the initializer '{ 0 }'
> > +CORE_CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
> >   CORE_CFLAGS += -fno-omit-frame-pointer
> >   CORE_CFLAGS += -Wall
> >   CORE_CFLAGS += -Wextra
> 
> I don't think this makes its way to libperf. I don't have a compiler that
> supports it, but "-std=gnu11" is in CORE_CFLAGS and that's not there on any
> libperf compile commands so I'm assuming CORE_CFLAGS is only local to Perf.

Indeed.  Thanks for pointing out.

Since the commit 91009a3a9913 ("perf build: Install libperf locally when
building"), though the CORE_CFLAGS is appended to LIBPERF_CFLAGS, the
later is never populated to libperf.

I can add the compiler option into tools/lib/perf as well, and remove
the unused LIBPERF_CFLAGS variable.  This can allow the libperf to be
built independently from the perf tool.

To be honest, I am a bit concerned this is still insufficient as Perf
also links other libs (e.g. libbpf).  Another option is to place the
compiler option into tools/scripts/Makefile.include, something like:

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 0aa4005017c7..86d1a318a9f6 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -40,6 +40,18 @@ EXTRA_WARNINGS += -Wwrite-strings
 EXTRA_WARNINGS += -Wformat
 EXTRA_WARNINGS += -Wno-type-limits

+try-run = $(shell set -e;               \
+        if ($(1)) >/dev/null 2>&1;      \
+        then echo "$(2)";               \
+        else echo "$(3)";               \
+        fi)
+
+__cc-option = $(call try-run,\
+        $(1) -Werror $(2) -c -x c /dev/null -o /dev/null,$(2),)
+cc-option = $(call __cc-option, $(CC),$(1))
+
+CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
+

Thanks,
Leo
