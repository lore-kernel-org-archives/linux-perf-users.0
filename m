Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4173D548;
	Wed,  5 Jun 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598841; cv=none; b=SpoaQrH/MK6Qb4sZ1xDeaX70nwWTkFv4tTa3vvxao+jkteR23cIgSbve3aUtgR/6b4A+VITSLGpvnexTWpWlUcuAVxIZvP0ufxxRZpQsA/8j1T3Rc4/SJr9g2mu2VQ/sIkHpt10QgZ9N+zaSNdx0KzKbD6XZGAb5tDS1bJD3yEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598841; c=relaxed/simple;
	bh=x3iiJL5LZiRgm4rUM3UVhOCzxFTRXajLnBCXgJZ+0nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr3vnnBgxxLs2+pv+gGJW/IK17f+YR73wBHdpN5bRMMWvqy8/r/s4xSpw58+Rzue4r+uplrXJNxBMduXJoq7e2XC1LzNX5W7LF30eVEQAgdNIcSOYbyKwptQfa/s1bgLZ+KrRnClPXV+Ea85j/vfffikYaNj/gCTWZKsIIoGDcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecknh+zL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecknh+zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DA1C32781;
	Wed,  5 Jun 2024 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717598839;
	bh=x3iiJL5LZiRgm4rUM3UVhOCzxFTRXajLnBCXgJZ+0nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecknh+zLlyLrTr/OqfXddwMQFkPWOMb8At0msdLtOGHDsRGXW3Fu+wy/hCKCdm68d
	 Md/ulMyYUlGRmBe9Ti9XbvhAvf3MMasX/npbYGOY2uQ49qPim0USXJlMLprGSSuP1m
	 5C323yCBFmd9bBWgfZa6eqcEccBrgKM1gNByZvSFpJ0kLjuZxnnzDOqU3puSFNOThg
	 t8jlqJmrJG6yGUox6+kQPiBbM+uQh31VFeMFv5YWKKrkhI+NcAFODGNIUkNggEF8rk
	 jA0PusXYXBTlmIUj59xH7XHYm12VTCYyRITmPY1Xrg0kEv/gfHb0Z+iDu93q3QXx/Q
	 6sxRMA3XKR09Q==
Date: Wed, 5 Jun 2024 11:47:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
Message-ID: <ZmB6dUas3ctzzDfL@x1>
References: <ZjssGrj+abyC6mYP@gmail.com>
 <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com>
 <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
 <ZkJK3x3zQ9a4wp8E@gmail.com>
 <CAP-5=fUh+GoqERAF-qf8zx4kwq2uzwR2Ugop5XOkPexYGAqF3A@mail.gmail.com>
 <CAP-5=fWXDPfNqLz6DHYe9+dev_e6X5TcTe_xzOOz27yDkT7o7A@mail.gmail.com>
 <CAM9d7ch5HTr+k+_GpbMrX0HUo5BZ11byh1xq0Two7B7RQACuNw@mail.gmail.com>
 <ZmAQfJ9C5fFQdjQM@gmail.com>
 <ZmARSXB0Wqp6wMpr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmARSXB0Wqp6wMpr@gmail.com>

On Wed, Jun 05, 2024 at 09:18:33AM +0200, Ingo Molnar wrote:
> > Yeah, this appears to be doing the trick here - judging by a couple of 
> > tries of interrupted builds:
> > 
> >    Tested-by: Ingo Molnar <mingo@kernel.org>
> 
> Specifically I also tested it on a failed tree, by merging in your fix the 
> build now progresses as expected. So this is fixed for good.

Hi,

	I put this together, can I keep it so that I have it in my next
perf-tools pull req for Linus for v6.10?

Cheers,

- Arnaldo

From ca9680821dfec73c9100860bda4fab1f1309722e Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 21 May 2024 10:07:40 -0700
Subject: [PATCH 1/1] perf bpf: Fix handling of minimal vmlinux.h file when
 interrupting the build

Ingo reported that he was seeing these when hitting Control+C during a
perf tools build:

  Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h. Stop.

The failure happens when you don't have vmlinux.h or vmlinux with BTF.

ifeq ($(VMLINUX_H),)
  ifeq ($(VMLINUX_BTF),)
    $(error Missing bpftool input for generating vmlinux.h)
  endif
endif

VMLINUX_BTF can be empty if you didn't build a kernel or it doesn't have
a BTF section and the current kernel also has no BTF.  This is totally
ok.

But VMLINUX_H should be set to the minimal version in the source tree
(unless you overwrite it manually) when you don't pass GEN_VMLINUX_H=1
(which requires VMLINUX_BTF should not be empty).  The problem is that
it's defined in Makefile.config which is not included for `make clean`.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Link: http://lore.kernel.org/lkml/CAM9d7ch5HTr+k+_GpbMrX0HUo5BZ11byh1xq0Two7B7RQACuNw@mail.gmail.com
Link: http://lore.kernel.org/lkml/ZjssGrj+abyC6mYP@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306964f..e6d56b555369581d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -214,6 +214,7 @@ NON_CONFIG_TARGETS := clean python-clean TAGS tags cscope help
 
 ifdef MAKECMDGOALS
 ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
+  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
   config := 0
 endif
 endif
-- 
2.45.1

