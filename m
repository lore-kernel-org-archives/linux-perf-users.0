Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC94D7D5C;
	Wed, 16 Sep 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580282; cv=none; b=s2rlB1fwRlhb1jjUUdxbSym5mXYcd5ugBlv435jdSlvtwfhq+vjrpUr6HyxTurBB1O0c42wwfUBu+Yx8i8NCvh4yYAn/He8X5MFK3jktUYkkmUbReaL3Hah3DifOQvypRM0xyg0drI+ZzkGes1mGaoCVmKvvGiqspbPWuErQRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580282; c=relaxed/simple;
	bh=KBCTpoXddPEBQASF0EkOURQ6hc0B0Nn6Gm7KcEgcJCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV4OuNM78fCkUpF8BPxrStU1/AjJhiRJAuG7cA+pQ8yI2FLxTBfgnYYuJ/fRfGPdHsDiuJ0jUiyBbJcNOudVBmVnGtfdDNYDFvYuY1RdArl+xIi9S1RCA/otRzMujR3CveEGrKDt3pHk3/okenvEDUyvMy+EzW8KEyLbDGMe6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwshFiJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwshFiJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70D41F000FF;
	Wed, 16 Sep 2026 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580275;
	bh=NjiQu1d/ioLIe0RIZP31gpzjmhAaKhSMxIvNddDeA38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NwshFiJhNz1xiYcjPeBFcQ4x4LPBSO0WwaTsoDMTMeNxZvUt4QG4mghQFKsjRMwoC
	 brUh5ED7od6Dwv3biSb5sOR/MTCYBhX/mXRv7DAzqTwI6k2Tb1BlhZMnT5Rw/4sXdj
	 cY3dxtURgrs9ErE1mtT6SKOWoAizXIKmPjoFm01sNhBo+eDTDNJQwIpoHbB8tLkPTi
	 8T1X4Pw71cKmelLXYWgL76PG2YReM9vFAX7feVV7zqFR0ocNJ2jL7x0VVHEO0kHAtK
	 kWLLczsugylwwvz45Y2OHjxKsympGrOLSt6cZKyPXu3pIIc5CcYSV2iMCyJgzuEoDo
	 1fu4cuZFizeJg==
Date: Wed, 16 Sep 2026 10:37:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/9] perf libbfd: Include the headers that are used
Message-ID: <aqrT8kgw9ob-ILOj@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-4-irogers@google.com>
 <20260916062233.192271F000FF@smtp.kernel.org>
 <CAP-5=fWNMrnB9KNjCGOc0A+kwvWWsxYc092x=q6CLK+-g3nwFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWNMrnB9KNjCGOc0A+kwvWWsxYc092x=q6CLK+-g3nwFw@mail.gmail.com>

On Wed, Sep 16, 2026 at 08:54:16AM -0700, Ian Rogers wrote:
> On Tue, Sep 15, 2026 at 11:22 PM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] perf libbfd: build failure on musl due to missing <stdarg.h>
> > --
> >
> > commit b4b64b7fbd73cf480fc5aaa2ad17802e8f46fbcc
> > Author: Ian Rogers <irogers@google.com>
> >
> > perf libbfd: Include the headers that are used
> >
> > This patch explicitly includes several POSIX headers directly into libbfd.c
> > instead of relying on indirect inclusions. It also reorders the includes to
> > group system headers before perf's own headers.
> >
> > > diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> > > index 131bfedf48cdf..1b23a261a9ced 100644
> > > --- a/tools/perf/util/libbfd.c
> > > +++ b/tools/perf/util/libbfd.c
> > > @@ -1,5 +1,19 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include "libbfd.h"
> > > +
> > > +#include <errno.h>
> > > +#include <inttypes.h>
> > > +#include <limits.h>
> > > +#include <stdint.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +
> > > +#include <fcntl.h>
> > > +#include <pthread.h>
> > > +
> > > +#include <tools/dis-asm-compat.h>
> >
> > [Severity: Low]
> > Does this inclusion order break the build on musl libc?
> >
> > Because <tools/dis-asm-compat.h> uses va_start and va_end in an inline
> > function, it strictly requires <stdarg.h>. Previously, this requirement
> > was satisfied implicitly because it was included later in the file, after
> > other headers provided the necessary declarations.
> >
> > Moving <tools/dis-asm-compat.h> higher up in the file exposes this missing
> > dependency, which will cause va_start and va_end to be undeclared in strict
> > environments like musl.
> >
> > [ ... ]
> 
> I don't plan to fix this as the issue is minor and relates to an
> include, not the code itself. The series has no other Sashiko
> feedback.
> https://sashiko.dev/#/patchset/20260916061218.3061216-1-irogers%40google.com

I think <stdarg.h> should be included by <tools/dis-asm-compat.h> then.
But it looks like a separate issue.

Thanks,
Namhyung

