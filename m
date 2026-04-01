Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D43368A5
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078580; cv=pass; b=QmqUOYoqi8vfF5CHzUpHsbVYpvwjMWDJrLZSW1ArjKTwMSx266AK8M2mMX1G+fogSXx9OXalEs7Cp2HnvGTJSBt+5n1TIhKaJrQSSGf9y1iX58ctpmepZqr2exSNsvePX1CqbaZB42P5q1hmaAXy9Iiye6nVJMGdHDHYd5KAJ3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078580; c=relaxed/simple;
	bh=v/hjP9BQwR4x506KC3ScYCypYf/C7TrNga4I+sT9Zcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuQrSTVZiZvbEp30vggxMhTnQ86N/6M6zH1Z710nb0K9xUALKJL05Nxc3QfhqDjK+cquITkXDrNXXd1LkWa1mRQLry0f0O9OFpeJssL6mOhLbsbBzIMVkqL4Pw4iJdhEOaRoSFEsuDKkVG9UBElbm5W5piM0U1TX5Or6OiffmiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxEx1CTo; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxEx1CTo"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1270fc2bdf2so3917c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 14:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775078578; cv=none;
        d=google.com; s=arc-20240605;
        b=QmnxwBSaZbLJpGLBoB+smSlZ96qZWjmfasN5RV4nupO9XydQ5FsHI1u06RR+6Y5rj2
         sUuTT8WCkCjUODilnRKe3NixXndTayeks7OKSQ7Mp31pUBnMixl9K39LqU620VaPF2nw
         HMRTQctId/j6QUuDooyxTAn8gZvUWw0RgKHJ3RCpgYlgn5gYMagnKAS5IPYNjZkAo/0J
         vePN/Y5wxQAa2zcCdaUbeqF0Njsz9Q/jtcTxXuI9Fn6o6tss8I8/4WRwoL7SNXma3JvH
         XHTga7wFLsh07NX1TNFQYh7UZmwtS/GxiM4ImUY0xSnN8XcR+Y0RNoi41PJnKmdzZeD6
         qDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YoqPR4NKUaW6WLG+YY9PKY6M0I4T0Ig/ih/ULvtYVZA=;
        fh=/d0h0ocrLpMcXLMufoW+icXq6M2TZBPIiDH/EUYnae8=;
        b=Ceu6YQdQNFASli8eY9Y56rt7j2+7D8Z3Z1uUYQ+03sX2xRd0+Qs/9VUIQDDO/yQACS
         mXFQE0VcScNnHYI/6/L1cq8vbbx2uGKMo+fE7PlRR0aiS7XOwrK1dGImru1Z23elnB6X
         HAymLKXnfeJHqJJA74LehyMlmD+Su4pYlbUs7ZxNsU38aDF9L8/TXZ6CThA/LxTVnWNl
         IG2SQyGmlmZJusbTaJ+BzlskAMwCSmNH7xZBmK6Uy0oGz/iHPOI7NOL9i/m1lsYqAylD
         2skGu6kBMZoNAMt3ZQD+QgBGJp7+fHRfhmJldjMTL3x/x/PVlqk7dyt7VDpiU9UVIuhB
         Cjkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775078578; x=1775683378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoqPR4NKUaW6WLG+YY9PKY6M0I4T0Ig/ih/ULvtYVZA=;
        b=MxEx1CToBMPDuYBRcGLLGWNVDHtGjMCx7MYGkf83/yYXZpy6FLkg4hbWa1gW9sCFEF
         9VyX90VN+OX7G9JwQY9Uiya6DCfVa4ud0IO0u1JvIaznxEymjxynG6HyORjbvg76aN/Q
         SJvLDeqaV+C/QtjAWNJ5fB50IlbTtWnYe7p4unlXi6R/ey/Wg8yPuGOaM7yK8VY4XGGX
         Gbl8RJlFZAl1EBrtDZ7y8GwiekHEsUp3UvQJxEoAYSm/p0M2d5bs7/06y3E1ZLpxngSJ
         rY0a8EIQtIBgj/y10GVlESjO/NcPJKbLfF8PQNFeTNRlxBHxr4v0nY0xlKSKG6UBpr4p
         O9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078578; x=1775683378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YoqPR4NKUaW6WLG+YY9PKY6M0I4T0Ig/ih/ULvtYVZA=;
        b=VzKDKlSInrNNEx+AIEI8RbbUp8JydSJClJWIfPrKqPtjkMB4ziy5lcqL3WGTDDidCR
         0q7vPVJFfVefoqt8VHZGzgi53U+6fIGvjl4JQ4L2KsDnqtD3xaGNkgUC9sndf7DZAowa
         sFMvIlzf30q+UzfF2ONZ2nIYy6yKIj3XjodJUyzHABUu6nGQPsERPe+wme//32L5QA53
         /eQX3C/BZ5/HjhMNBLb2lkJ0+olVpCLZbitEcfouuDFobUWQHdGmk10SA1pYKG0onzXY
         JChAdjjeEHuCKWpgv990T7UP28BP2xzf1+K9swhEg/RGY7cxbh1PqrQEQlnHKglRwvYX
         Mb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0L/Wd7P7/KsyIBDyu72hp8U34nkaBfRgYfajA7indwbOpDRj5hwczIPx5bqRz07Yme+eFIbbxxWtPNcdMIawc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11YTKou3u+smFGc09hmLaiZpg/GaMnH3wuo7C6zFIIePPnLxA
	BKbQF0qr+QZiUItEEouXhbmbCn5mapWS1nvvtyS/yqV1TKt+ZZAMg/ZLGXVJYf1DL4CRj8Ui74h
	hN8jH9WB6k9aMnf/lZbkgH1fqRw7ehCRaUNMfbyDK
X-Gm-Gg: ATEYQzykH3Qeui12lqIiRBJjg+qkTlu6E9d64y1z3LHJ1afU7OZGg0pMOrU8Vlqu7If
	+9JqE/9XmquOrYqXOxdnkHNMdPtcH2v/RhSoD2lNoKoJD7PWTi/30heH04yxJzKHHN4q0U5/H1m
	bmUKum6IyWbxQZhuqw2jHqeBqnPywDtIpdba9z4dKpnS5USEyZ1ZGpQ1MyN3lZ8A3mN8BDJ++jc
	h9T+RxNuRRSDS25oXPYHRgwmQOUM5Am67R7+kb36GdbXTzXq9+bEmOn+jc89JTAvjsqh1gGLR3W
	89wrzFmNqy0wM/nT7wUx1d0ykERtZ4OGF+/v
X-Received: by 2002:a05:7022:4587:b0:119:e55a:808a with SMTP id
 a92af1059eb24-12bef3d1339mr34916c88.7.1775078576991; Wed, 01 Apr 2026
 14:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401210203.2150651-1-acme@kernel.org> <20260401210203.2150651-3-acme@kernel.org>
In-Reply-To: <20260401210203.2150651-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 14:22:44 -0700
X-Gm-Features: AQROBzBRS9EB2QnWbxUKzzaPhRXZ3Nr6PmoyJHxft2Rmgv0Q--vq3OTBnxa5lQs
Message-ID: <CAP-5=fVjHhO2AOUwByWw8a9PsE4C=HvzA9AZ4MLDkXJ3oTsL_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: Move tools/include/uapi/drm to tools/perf/trace/beauty/include/uapi
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:02=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> As it is used only to parse ioctl numbers, not to build perf and so far
> no other tools/ living tool uses it, so to clean up tools/include/ to be
> used just for building tools, to have access to things available in the
> kernel and not yet in the system headers, move it to the directory where
> just the tools/perf/trace/beauty/ scripts can use to generate tables
> used by perf.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

The moving headers changes I think have been incorporated into your
clean up series. For the moving headers:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.perf                                  | 2 +-
>  tools/perf/check-headers.sh                               | 4 ++--
>  tools/perf/trace/beauty/drm_ioctl.sh                      | 2 +-
>  tools/{ =3D> perf/trace/beauty}/include/uapi/drm/drm.h      | 0
>  tools/{ =3D> perf/trace/beauty}/include/uapi/drm/i915_drm.h | 0
>  5 files changed, 4 insertions(+), 4 deletions(-)
>  rename tools/{ =3D> perf/trace/beauty}/include/uapi/drm/drm.h (100%)
>  rename tools/{ =3D> perf/trace/beauty}/include/uapi/drm/i915_drm.h (100%=
)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f7b936deeaa2cd7c..a560fbc847934fad 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -547,7 +547,7 @@ $(clone_flags_array): $(beauty_uapi_linux_dir)/sched.=
h $(clone_flags_tbl)
>         $(Q)$(SHELL) '$(clone_flags_tbl)' $(beauty_uapi_linux_dir) > $@
>
>  drm_ioctl_array :=3D $(beauty_ioctl_outdir)/drm_ioctl_array.c
> -drm_hdr_dir :=3D $(srctree)/tools/include/uapi/drm
> +drm_hdr_dir :=3D $(srctree)/tools/perf/trace/beauty/include/uapi/drm
>  drm_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
>
>  $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm=
_ioctl_tbl)
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 31826621eebdb003..c6b136fe8d13053d 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -6,8 +6,6 @@ NC=3D'\033[0m' # No Color
>
>  declare -a FILES=3D(
>    "include/uapi/linux/const.h"
> -  "include/uapi/drm/drm.h"
> -  "include/uapi/drm/i915_drm.h"
>    "include/uapi/linux/bits.h"
>    "include/uapi/linux/fadvise.h"
>    "include/uapi/linux/fscrypt.h"
> @@ -90,6 +88,8 @@ declare -a SYNC_CHECK_FILES=3D(
>  declare -a BEAUTY_FILES=3D(
>    "arch/x86/include/asm/irq_vectors.h"
>    "arch/x86/include/uapi/asm/prctl.h"
> +  "include/uapi/drm/drm.h"
> +  "include/uapi/drm/i915_drm.h"
>    "include/linux/socket.h"
>    "include/uapi/linux/fcntl.h"
>    "include/uapi/linux/fs.h"
> diff --git a/tools/perf/trace/beauty/drm_ioctl.sh b/tools/perf/trace/beau=
ty/drm_ioctl.sh
> index 9aa94fd523a9c2dd..f2f1a257bac8b41e 100755
> --- a/tools/perf/trace/beauty/drm_ioctl.sh
> +++ b/tools/perf/trace/beauty/drm_ioctl.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: LGPL-2.1
>
> -[ $# -eq 1 ] && header_dir=3D$1 || header_dir=3Dtools/include/uapi/drm/
> +[ $# -eq 1 ] && header_dir=3D$1 || header_dir=3Dtools/perf/trace/beauty/=
include/uapi/drm/
>
>  printf "#ifndef DRM_COMMAND_BASE\n"
>  grep "#define DRM_COMMAND_BASE" $header_dir/drm.h
> diff --git a/tools/include/uapi/drm/drm.h b/tools/perf/trace/beauty/inclu=
de/uapi/drm/drm.h
> similarity index 100%
> rename from tools/include/uapi/drm/drm.h
> rename to tools/perf/trace/beauty/include/uapi/drm/drm.h
> diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/perf/trace/beauty/=
include/uapi/drm/i915_drm.h
> similarity index 100%
> rename from tools/include/uapi/drm/i915_drm.h
> rename to tools/perf/trace/beauty/include/uapi/drm/i915_drm.h
> --
> 2.53.0
>
