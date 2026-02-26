Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22EC3A0B1C;
	Thu, 26 Feb 2026 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099581; cv=none; b=WMKmc8Gmg6bAPm0n8BSsXn1HeIYLldlPkXJFJ6WdC9AAMz427NpE/x4OA/d5nO9eAxId4kpThiVvIEZEBrisVDQEvvptcFhapYOEonfBwMLgtv8zS6RtzVprU7wJugPZaFpfOsWghZen9/Shk1uU17ISY9UQz0JMQOG9WJyhUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099581; c=relaxed/simple;
	bh=3NTbYflzIfff8v8pNcJLvVi7zioF4YCkw7CoH3YSHWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoizStPbmS8pWlKbxcw46WG6hNOEbU0O1juX0QClmlCSaiFhDPgUX3jr0jn0YdxUeAfdW3TC9asbaJDSVwVatfGrtlfwkPxTB5hyzeFms0dFY9XZvTvepYpk5mZ9GvchmnXJpFrIaj5UJYik8JI5PGf6A/t9z/EaHoG0O/Wnld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FCD21516;
	Thu, 26 Feb 2026 01:52:51 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AED43F62B;
	Thu, 26 Feb 2026 01:52:57 -0800 (PST)
Date: Thu, 26 Feb 2026 09:52:55 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf kvm stat: Fix build error
Message-ID: <20260226095255.GF4184494@e132581.arm.com>
References: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com>
 <aZ-oYb-FDLVT5MGq@google.com>
 <CAP-5=fVCdQZ584s_24wQc_+03xL2Npj2qDbqGSjE=Ms1-y8raQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVCdQZ584s_24wQc_+03xL2Npj2qDbqGSjE=Ms1-y8raQ@mail.gmail.com>

On Wed, Feb 25, 2026 at 10:36:26PM -0800, Ian Rogers wrote:

[...]

> Hmm.. it looks like something has gone screwy with the include paths.
> The header you've gotten is:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/include/uapi/asm/svm.h#n137
> rather than:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/arch/x86/include/uapi/asm/svm.h#n137
> where the value differs between -1ull and -1.
> 
> In Leo's change he has the include path as:
>   #include "../../arch/x86/include/uapi/asm/svm.h"
> 
> but I think that is off by one and should be:
>   #include "../../../arch/x86/include/uapi/asm/svm.h"

Sorry I did not check the header path carefully.  A bit thoughts:

The perf build will not include headers in relative paths as we
expected.

It tries to find headers with appending search paths.  As Ian said,
I saw .kvm-stat-x86.o.cmd that includes kernel headers:

  /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm/svm.h \
  /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm/vmx.h \
  /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi/asm/kvm.h \

I'd suggest a fix in Makefile as below.  The idea is to give priority to
the lower level folders under perf, so that headers in the deeper perf
directories are searched first.  This avoids searching any kernel headers.

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a8dc72cfe48e..47359f672b6a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -388,8 +388,10 @@ ifeq ($(DEBUG),0)
   endif
 endif

-INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
+INC_FLAGS += -I$(src-perf)/util/include
+INC_FLAGS += -I$(src-perf)/util
+INC_FLAGS += -I$(src-perf)
 INC_FLAGS += -I$(srctree)/tools/include/
 INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
 INC_FLAGS += -I$(srctree)/tools/include/uapi
@@ -403,9 +405,6 @@ INC_FLAGS += -I$(obj-perf)/util
 INC_FLAGS += -I$(obj-perf)
 endif

-INC_FLAGS += -I$(src-perf)/util
-INC_FLAGS += -I$(src-perf)
-
 CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_

As a result, I can get the search paths in .kvm-stat-x86.o.cmd:

  /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/asm/svm.h \
  /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/asm/vmx.h \
  /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/uapi/asm/kvm.h \

Please let me know if this makes sense.

Thanks,
Leo
