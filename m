Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721B35DA5B;
	Wed,  1 Apr 2026 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080200; cv=none; b=qGfogU1Swm4ilvXj1cuinRNpSzcAveSuYJD7nV1OQ4wwPdNa/sWpGNT0KQRJElQUHTvmPRMqp5PpUp2HL2QEGgW+BoeTOoWh/nywAsjqy0qHXVSvbU41I7scgiduHghPtQ31ZoYi1inRkgavSXcPZmftc3MnBTIoNJxN4phtfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080200; c=relaxed/simple;
	bh=J+LqJMvCH7fmz72O/MmBteBlArSxtO0Iy0z9bXPSiZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBWNg3lZJM6QYw01UpZGGD5Q9mTuRHWs1R+TUL8fQqq4sflzFs3yTNtRizhiAghGuStthv9nLOj4UVS9/NWAa8KioqbB8NzJ8gjg6411XHTZI6yXqVxU0bLBZ9+GsFOHuIk3Mk82r6X4MPQfA/p3/GujfKAXZglSHYFoR+RxECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEHKuOeC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEHKuOeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478DFC4CEF7;
	Wed,  1 Apr 2026 21:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080199;
	bh=J+LqJMvCH7fmz72O/MmBteBlArSxtO0Iy0z9bXPSiZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEHKuOeCKTaAG37RdL594Pz8NVsPgMncATwmImG4CMhBmhO9MUx65gZMvYH58FE5/
	 Zvp6cEsUgwbPiX19yH4gQFXhDfE/TVS+3o6z2W8I8LbE59nr6aTHWexEn41DupDWpE
	 5vV/paliRVOINSWdsOeICXdnsRzUJrJWQ2Y9PwmcqSTMuCRzkzaeo5iYZ7aR22PSfi
	 V9e9YKMUclbJzrmsK1vDDvzgD+P38P7On4CsftDQPrau/vPFYZgtOBntBCCYzptxb1
	 rvE9XdQ7Jf4vpeLb8jLXHcRsiQpJHvFQTQ2V6mtkcQJUDgPVQCfNfVyCWq0DwlO5oG
	 3NcsMgMWOJC2w==
Date: Wed, 1 Apr 2026 18:49:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/2] tools: Move tools/include/uapi/drm to
 tools/perf/trace/beauty/include/uapi
Message-ID: <ac2TA7R-OyHWaxhB@x1>
References: <20260401210203.2150651-1-acme@kernel.org>
 <20260401210203.2150651-3-acme@kernel.org>
 <CAP-5=fVjHhO2AOUwByWw8a9PsE4C=HvzA9AZ4MLDkXJ3oTsL_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVjHhO2AOUwByWw8a9PsE4C=HvzA9AZ4MLDkXJ3oTsL_g@mail.gmail.com>

On Wed, Apr 01, 2026 at 02:22:44PM -0700, Ian Rogers wrote:
> On Wed, Apr 1, 2026 at 2:02 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > As it is used only to parse ioctl numbers, not to build perf and so far
> > no other tools/ living tool uses it, so to clean up tools/include/ to be
> > used just for building tools, to have access to things available in the
> > kernel and not yet in the system headers, move it to the directory where
> > just the tools/perf/trace/beauty/ scripts can use to generate tables
> > used by perf.
> >
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The moving headers changes I think have been incorporated into your
> clean up series. For the moving headers:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

I see, I didn't cleanup the 000*.patch files from a previous pull req
:-\ So ended up resending them.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/Makefile.perf                                  | 2 +-
> >  tools/perf/check-headers.sh                               | 4 ++--
> >  tools/perf/trace/beauty/drm_ioctl.sh                      | 2 +-
> >  tools/{ => perf/trace/beauty}/include/uapi/drm/drm.h      | 0
> >  tools/{ => perf/trace/beauty}/include/uapi/drm/i915_drm.h | 0
> >  5 files changed, 4 insertions(+), 4 deletions(-)
> >  rename tools/{ => perf/trace/beauty}/include/uapi/drm/drm.h (100%)
> >  rename tools/{ => perf/trace/beauty}/include/uapi/drm/i915_drm.h (100%)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index f7b936deeaa2cd7c..a560fbc847934fad 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -547,7 +547,7 @@ $(clone_flags_array): $(beauty_uapi_linux_dir)/sched.h $(clone_flags_tbl)
> >         $(Q)$(SHELL) '$(clone_flags_tbl)' $(beauty_uapi_linux_dir) > $@
> >
> >  drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
> > -drm_hdr_dir := $(srctree)/tools/include/uapi/drm
> > +drm_hdr_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/drm
> >  drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
> >
> >  $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index 31826621eebdb003..c6b136fe8d13053d 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -6,8 +6,6 @@ NC='\033[0m' # No Color
> >
> >  declare -a FILES=(
> >    "include/uapi/linux/const.h"
> > -  "include/uapi/drm/drm.h"
> > -  "include/uapi/drm/i915_drm.h"
> >    "include/uapi/linux/bits.h"
> >    "include/uapi/linux/fadvise.h"
> >    "include/uapi/linux/fscrypt.h"
> > @@ -90,6 +88,8 @@ declare -a SYNC_CHECK_FILES=(
> >  declare -a BEAUTY_FILES=(
> >    "arch/x86/include/asm/irq_vectors.h"
> >    "arch/x86/include/uapi/asm/prctl.h"
> > +  "include/uapi/drm/drm.h"
> > +  "include/uapi/drm/i915_drm.h"
> >    "include/linux/socket.h"
> >    "include/uapi/linux/fcntl.h"
> >    "include/uapi/linux/fs.h"
> > diff --git a/tools/perf/trace/beauty/drm_ioctl.sh b/tools/perf/trace/beauty/drm_ioctl.sh
> > index 9aa94fd523a9c2dd..f2f1a257bac8b41e 100755
> > --- a/tools/perf/trace/beauty/drm_ioctl.sh
> > +++ b/tools/perf/trace/beauty/drm_ioctl.sh
> > @@ -1,7 +1,7 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: LGPL-2.1
> >
> > -[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/drm/
> > +[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/perf/trace/beauty/include/uapi/drm/
> >
> >  printf "#ifndef DRM_COMMAND_BASE\n"
> >  grep "#define DRM_COMMAND_BASE" $header_dir/drm.h
> > diff --git a/tools/include/uapi/drm/drm.h b/tools/perf/trace/beauty/include/uapi/drm/drm.h
> > similarity index 100%
> > rename from tools/include/uapi/drm/drm.h
> > rename to tools/perf/trace/beauty/include/uapi/drm/drm.h
> > diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/perf/trace/beauty/include/uapi/drm/i915_drm.h
> > similarity index 100%
> > rename from tools/include/uapi/drm/i915_drm.h
> > rename to tools/perf/trace/beauty/include/uapi/drm/i915_drm.h
> > --
> > 2.53.0
> >
