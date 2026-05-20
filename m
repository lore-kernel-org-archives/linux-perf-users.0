Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A7344DA8
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305189; cv=pass; b=CgpqO20IPK3PaH0eZZ+gdxRFKb9mIwuQMYDaCYT8CvIyNubSLKMyd6p0W2vnnBLGpO5IJDHhQkqZCgzLS1yObM4CQVIOxcvXByfuGuzkroHXih1f0xXjMRpi2uWbOT/7sSnN1ZFKtaT1/oviIlfuyhLUoj70uosPmBPzMhKzxSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305189; c=relaxed/simple;
	bh=qD4zjqR71cAmnqhA0Byl9ekw4iJ46tVgtr4pZR7fKtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arZ20fXaRFzf9SzDnt6EL6oOuLYSE9bVH9SWZ3I3aDfie5jNCtN/ry46ZFjpxEzKkODihYNC0o2GYXp5NhxQkFf3ssIMIdGiTaiWe/9oGQlCELFX7NlvBgrfJJlF5y8UMSTBXjEpTM01zF70bHIjQU95bA4P0R1Ud/2Lhmqx2Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+JARkdc; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+JARkdc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso795ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779305185; cv=none;
        d=google.com; s=arc-20240605;
        b=goSVTQLZMzcafERMX3PjeFZu3YnV/brLGmt3CIBwB9Pnss2C/1pNzQs2HrOIGKQGVM
         7xhuKGCMxaxIJbr1boEd8EVpAdsNsZ0+c6dTNC8Ds/WhuslQ36X/oJ0L1mN9tDvPq0TK
         XKc/C7pgvaQ92eIEqwsbzhLnS5IL9+ruupgHOmWbkuDbPaDjzNC4sOM1FFKp/y7dJoJW
         TFUwCpk/3GMNKopSCQaOyeKpcgh+xR4xUTr/oEDcYNaqrqojcmssD1saak3OedDOekLR
         QbDriOOchIK2QqP8hJLD08sgaESASwpHQDcL89MVIi41sYksefmXdDtnkCNQ2WItvH7O
         gWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f8oxbNF76Lk1nHxYmTfh2u+8NskGsL2DlGTgej16hgA=;
        fh=1fa+rAbBiv+W4r3JpENB8x833rYld+1af8j/hSBoVlM=;
        b=llD8TCWLV8i4WbdwGb32c0wWIi8twJmXpTZd+MwKiiIDYEZe+8x6qZNZhmoxgJTd4V
         wIvJMDvY90wcx/WQ0S4ttCkpzgBNB9Nb5FLsD0IDEXWVLnBWSlSdBToGuow8rYIhnV4B
         /Vmdv8LrUM8ZXGd987Sd+xRunfeKhwIC0lF2ii+Qo+Uxv4tdzYuyz56V3Is+KRJlrGqa
         Pd6YhMouvu5FRFaXzATF9QEs5P67k0d/gtgKIEZ/2YmbOCGj/mF0n7CG3jLmHeoiKbYZ
         T7i8v39liYe1H0eVaIcRt1BbTblr+pnwv06VQYZ/ReSO+cO1WWMcDvprKhVHKGzTTlfh
         pUrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779305185; x=1779909985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8oxbNF76Lk1nHxYmTfh2u+8NskGsL2DlGTgej16hgA=;
        b=V+JARkdcrtiDbedf4s2urCq/cpOFUgAAXZ0YcDi+US2dogfo8HQ98zfyr8AZVBVr0B
         VZvf0wKLVm8L23dTiCixOR62p1jZ+0Ehe4YpjygCuk9SMYaOz2vmXRtx9qkWM/WohCmF
         qa0WiKbxuVuq4yBmH6yaeosq1dumve+bI7JIyeDgdtD6vK4Orz5kLmfGeGN3W50Ft0DR
         PK2nbLXgUWMaqxlJVNnPb7oWn1IVLvoAFvAn33LeouVfqR74WoEWKD8amIyj6B7OHBl2
         kugy/BMoaMBK5AJnM7vcT0zqECVtSSKme4SuuwCmATWtq6Lji2umf9NOfryCq9z+pNpq
         UqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779305185; x=1779909985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8oxbNF76Lk1nHxYmTfh2u+8NskGsL2DlGTgej16hgA=;
        b=o1UXyK/yUxYG+xyoF/vqs6P97+7dybxrVXd39oV5U2EIhoSsHtPNnT0nJinw2xvUnH
         Hi7hGBsuhjv2WKspToIZglwbcyQiiAGVLvUGepKfh5ykOt93RIONHAORfzca54y+8E1l
         scfdDcG5Qbl5byI8Ut/LPKhmVAC9XlDwzvBU9qkxNV0Tk3Kz3c4TjpDBQRHrX4ydkLJ0
         K7tPW7KtYzyoX4YhsvqT+/mQY7bGKBprGfoDC1IeYnJLaNjvFSmEUPwUcJRjkfkzq2qu
         bRAC9OOUQHBRBgGfVYUoaesrETfEfqHbUNn1eDhB/nuV+tIpcxidQBFpnY350LSDD29N
         X8hQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ar4kgPGBXwXMb7Y0jbSWpNEYcB+3etJVXQZdK0phvkIlS7PW4GpTBF1ZbHsPLQ282VpWaFmPPeic3dohUyD7l@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl334Kbszp619Bl5svY03RubuMSWGwNZMZWjK5Nx1ci+TL8bQx
	ERiUWu9iO02t9g0A8sp1ykAAWJ3OGAnEmSxVeCi86KfIiPKX+IoDjBsNAi5AL3BlNXL4k4zN00E
	wUT5u/vq+xpyhdOeTSwy+GaX7e1Ghw3OX55hRP+Wu
X-Gm-Gg: Acq92OEYstmlUWxdZ/oQPBNXY4GmtUlB7innSYc0A0XW7ihT7+vMBdf3ueMguwRoTwq
	TWDb2gRT+sKVZf2y0+085zV1U+Ypjsyf75zgShFSTnoPx8n3CzQs/LJfcoeyH4AzRuZWOyg6A+j
	bbWoLyAYMFWcIALqU6TPnMFTtceh6fp9egbsHnQpuhD3c7C0lw2uHwdKuREdgMIdkYI/09TEkyy
	cWEdL8drU3eZDzuUQcN7A4wmULJyVvOH2PJwezoWFlgCfrGUbPg2/gKXaLXjAK2yE15rwmAverq
	/EXjtYxgud9xo8l+VRa+SK4tDD2lL1h4xcjA8ZVRhBQFOLTq
X-Received: by 2002:a17:902:f54c:b0:2b8:e82d:ff7c with SMTP id
 d9443c01a7336-2be9f694900mr540005ad.9.1779305184745; Wed, 20 May 2026
 12:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512194710.162215-1-mjeanson@efficios.com> <20260520191452.218717-1-mjeanson@efficios.com>
In-Reply-To: <20260520191452.218717-1-mjeanson@efficios.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 12:26:13 -0700
X-Gm-Features: AVHnY4KIgCl8kHmjcMsZICOhLijp0JIvwsnXxvR7PDlIAZPCJ4TCmyyFPRTHocU
Message-ID: <CAP-5=fUehWvDZB+u1wYGMRa1WD8SUQMqzPqyQB4O78KBa43kOg@mail.gmail.com>
Subject: Re: [PATCH v3] perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer
To: Michael Jeanson <mjeanson@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:15=E2=80=AFPM Michael Jeanson <mjeanson@efficios=
.com> wrote:
>
> The 1.x branch of Babeltrace has been superseded by 2.x in 2020 and has
> been unmaintained since 2022, efforts have started to remove it from
> popular distributions.
>
> Babeltrace 2.x offers a very similar 'ctf-writer' library that can be use=
d
> with minimal changes for the '--to-ctf' feature and has been packaged
> since Debian 11 and Fedora 32.
>
> This patch replaces the 'libbabeltrace' build feature with
> 'babeltrace2-ctf-writer' using pkgconfig detection, adjusts the naming of
> the public headers and applies minor API cleanups.
>
> There is no changes to the output ctf traces, the ctf-writer API still
> implements version 1.8 of the CTF specification that can be read by
> either Babeltrace 1 / 2 or any CTF compliant reader.
>
> Also remove some ifdefs in the cli option parsing to allow printing the
> helpful error message with '--to-ctf' when built without babeltrace2.
>
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Derek Foreman <derek.foreman@collabora.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> Changes since v2:
> * Revert babeltrace 1 fallback
> * Rebase on perf-tools-next
> Changes since v1:
> * Keep babeltrace 1 support as fallback
> ---
>  tools/build/Makefile.feature                  |  5 +--
>  tools/build/feature/Makefile                  |  6 ++--
>  tools/build/feature/test-all.c                |  6 ++--
>  ...ltrace.c =3D> test-babeltrace2-ctf-writer.c} |  3 +-
>  tools/perf/Makefile.config                    | 27 +++++++--------
>  tools/perf/Makefile.perf                      |  2 +-
>  tools/perf/builtin-check.c                    |  2 +-
>  tools/perf/builtin-data.c                     | 18 +++-------
>  tools/perf/tests/make                         |  4 +--
>  .../shell/test_perf_data_converter_ctf.sh     |  8 ++---
>  tools/perf/util/Build                         |  2 +-
>  tools/perf/util/data-convert-bt.c             | 33 +++++++++----------
>  tools/perf/util/data-convert.h                |  4 +--
>  13 files changed, 53 insertions(+), 67 deletions(-)
>  rename tools/build/feature/{test-libbabeltrace.c =3D> test-babeltrace2-c=
tf-writer.c} (59%)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 0b7a7c38cb88..9e097144817e 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -113,7 +113,7 @@ FEATURE_TESTS_EXTRA :=3D                  \
>           gtk2                           \
>           gtk2-infobar                   \
>           hello                          \
> -         libbabeltrace                  \
> +         babeltrace2-ctf-writer         \
>           libcapstone                    \
>           libbfd-liberty                 \
>           libbfd-liberty-z               \
> @@ -162,6 +162,7 @@ FEATURE_GROUP_MEMBERS-libbfd =3D libbfd-liberty libbf=
d-liberty-z
>  # Declare list of feature dependency packages that provide pkg-config fi=
les.
>  #
>  FEATURE_PKG_CONFIG ?=3D           \
> +        babeltrace2-ctf-writer \
>           libtraceevent          \
>           libtracefs
>
> @@ -208,7 +209,7 @@ ifeq ($(feature-all), 1)
>    $(call feature_check,compile-32)
>    $(call feature_check,compile-x32)
>    $(call feature_check,bionic)
> -  $(call feature_check,libbabeltrace)
> +  $(call feature_check,babeltrace2-ctf-writer)
>  else
>    $(foreach feat,$(FEATURE_TESTS),$(call feature_check,$(feat)))
>  endif
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 1fbcb3ce74d2..7735e257c263 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -48,7 +48,7 @@ FILES=3D                                          \
>           test-pthread-barrier.bin              \
>           test-stackprotector-all.bin            \
>           test-timerfd.bin                       \
> -         test-libbabeltrace.bin                 \
> +         test-babeltrace2-ctf-writer.bin        \
>           test-libcapstone.bin                  \
>           test-compile-32.bin                    \
>           test-compile-x32.bin                   \
> @@ -301,8 +301,8 @@ $(OUTPUT)test-backtrace.bin:
>  $(OUTPUT)test-timerfd.bin:
>         $(BUILD)
>
> -$(OUTPUT)test-libbabeltrace.bin:
> -       $(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libba=
beltrace)
> +$(OUTPUT)test-babeltrace2-ctf-writer.bin:
> +       $(BUILD) # -lbabeltrace2-ctf-writer provided by $(FEATURE_CHECK_L=
DFLAGS-babeltrace2-ctf-writer)
>
>  $(OUTPUT)test-libcapstone.bin:
>         $(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcaps=
tone)
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index 1488bf6e6078..544563d62950 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -100,13 +100,13 @@
>
>  # if 0
>  /*
> - * Disable libbabeltrace check for test-all, because the requested
> + * Disable babeltrace2-ctf-writer check for test-all, because the reques=
ted
>   * library version is not released yet in most distributions. Will
>   * reenable later.
>   */
>
> -#define main main_test_libbabeltrace
> -# include "test-libbabeltrace.c"
> +#define main main_test_babeltrace2_ctf_writer
> +# include "test-babeltrace2-ctf-writer.c"
>  #undef main
>  #endif
>
> diff --git a/tools/build/feature/test-libbabeltrace.c b/tools/build/featu=
re/test-babeltrace2-ctf-writer.c
> similarity index 59%
> rename from tools/build/feature/test-libbabeltrace.c
> rename to tools/build/feature/test-babeltrace2-ctf-writer.c
> index 10bb69d55694..9c89082e9f88 100644
> --- a/tools/build/feature/test-libbabeltrace.c
> +++ b/tools/build/feature/test-babeltrace2-ctf-writer.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -#include <babeltrace/ctf-writer/writer.h>
> -#include <babeltrace/ctf-ir/stream-class.h>
> +#include <babeltrace2-ctf-writer/writer.h>
>
>  int main(void)
>  {
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a8dc72cfe48e..856d2831d53c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -195,14 +195,11 @@ endif
>  FEATURE_CHECK_CFLAGS-libdw :=3D $(LIBDW_CFLAGS)
>  FEATURE_CHECK_LDFLAGS-libdw :=3D $(LIBDW_LDFLAGS) $(DWARFLIBS)
>
> -# for linking with debug library, run like:
> -# make DEBUG=3D1 LIBBABELTRACE_DIR=3D/opt/libbabeltrace/
> -ifdef LIBBABELTRACE_DIR
> -  LIBBABELTRACE_CFLAGS  :=3D -I$(LIBBABELTRACE_DIR)/include
> -  LIBBABELTRACE_LDFLAGS :=3D -L$(LIBBABELTRACE_DIR)/lib
> +ifneq ($(NO_BABELTRACE2),1)
> +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> +    $(error Error: $(PKG_CONFIG) needed by babeltrace2 is missing on thi=
s system, please install it)
> +  endif
>  endif
> -FEATURE_CHECK_CFLAGS-libbabeltrace :=3D $(LIBBABELTRACE_CFLAGS)
> -FEATURE_CHECK_LDFLAGS-libbabeltrace :=3D $(LIBBABELTRACE_LDFLAGS) -lbabe=
ltrace-ctf
>
>  # for linking with debug library, run like:
>  # make DEBUG=3D1 LIBCAPSTONE_DIR=3D/opt/capstone/
> @@ -1058,15 +1055,15 @@ else
>    NO_PERF_READ_VDSOX32 :=3D 1
>  endif
>
> -ifndef NO_LIBBABELTRACE
> -  $(call feature_check,libbabeltrace)
> -  ifeq ($(feature-libbabeltrace), 1)
> -    CFLAGS +=3D -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
> -    LDFLAGS +=3D $(LIBBABELTRACE_LDFLAGS)
> -    EXTLIBS +=3D -lbabeltrace-ctf
> -    $(call detected,CONFIG_LIBBABELTRACE)
> +ifndef NO_BABELTRACE2
> +  $(call feature_check,babeltrace2-ctf-writer)
> +  ifeq ($(feature-babeltrace2-ctf-writer), 1)
> +    CFLAGS +=3D -DHAVE_BABELTRACE2_CTF_WRITER_SUPPORT $(shell $(PKG_CONF=
IG) --cflags babeltrace2-ctf-writer)
> +    LDFLAGS +=3D $(shell $(PKG_CONFIG) --libs-only-L babeltrace2-ctf-wri=
ter)
> +    EXTLIBS +=3D $(shell $(PKG_CONFIG) --libs-only-l babeltrace2-ctf-wri=
ter)
> +    $(call detected,CONFIG_BABELTRACE2_CTF_WRITER)
>    else
> -    $(warning No libbabeltrace found, disables 'perf data' CTF format su=
pport, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
> +    $(warning No babeltrace2 found, disables 'perf data' CTF format supp=
ort, please install libbabeltrace2-dev[el])
>    endif
>  endif
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 11b63bafdb23..ea830c07b952 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -79,7 +79,7 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_ZLIB if you do not want to support compressed kernel modules
>  #
> -# Define NO_LIBBABELTRACE if you do not want libbabeltrace support
> +# Define NO_BABELTRACE2 if you do not want babeltrace2-ctf-writer suppor=
t
>  # for CTF data format.
>  #
>  # Define NO_CAPSTONE if you do not want libcapstone support
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 3641d263b345..60437650c50f 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -43,7 +43,7 @@ struct feature_status supported_features[] =3D {
>         FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
>         FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
>         FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, li=
cense incompatibility, use BUILD_NONDISTRO=3D1 and install binutils-dev[el]=
"),
> -       FEATURE_STATUS("libbabeltrace", HAVE_LIBBABELTRACE_SUPPORT),
> +       FEATURE_STATUS("babeltrace2-ctf-writer", HAVE_BABELTRACE2_CTF_WRI=
TER_SUPPORT),
>         FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
>         FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
>         FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index 85f59886b5cf..d4fdb0d97a29 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -40,10 +40,8 @@ const struct option data_options[] =3D {
>                 OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>                 OPT_STRING('i', "input", &input_name, "file", "input file=
 name"),
>                 OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON=
 format"),
> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
>                 OPT_STRING(0, "to-ctf", &to_ctf, NULL, "Convert to CTF fo=
rmat"),
>                 OPT_BOOLEAN(0, "tod", &opts.tod, "Convert time to wall cl=
ock time"),
> -#endif
>                 OPT_BOOLEAN('f', "force", &opts.force, "don't complain, d=
o it"),
>                 OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
>                 OPT_STRING(0, "time", &opts.time_str, "str",
> @@ -65,29 +63,21 @@ static int cmd_data_convert(int argc, const char **ar=
gv)
>                 pr_err("You cannot specify both --to-ctf and --to-json.\n=
");
>                 return -1;
>         }
> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
>         if (!to_json && !to_ctf) {
>                 pr_err("You must specify one of --to-ctf or --to-json.\n"=
);
>                 return -1;
>         }
> -#else
> -       if (!to_json) {
> -               pr_err("You must specify --to-json.\n");
> -       return -1;
> -}
> -#endif
>
>         if (to_json)
>                 return bt_convert__perf2json(input_name, to_json, &opts);
>
>         if (to_ctf) {
> -#if defined(HAVE_LIBBABELTRACE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> +#if defined(HAVE_BABELTRACE2_CTF_WRITER_SUPPORT) && defined(HAVE_LIBTRAC=
EEVENT)
>                 return bt_convert__perf2ctf(input_name, to_ctf, &opts);
>  #else
> -               pr_err("The libbabeltrace support is not compiled in. per=
f should be "
> -                      "compiled with environment variables LIBBABELTRACE=
=3D1 and "
> -                      "LIBBABELTRACE_DIR=3D/path/to/libbabeltrace/.\n"
> -                      "Check also if libbtraceevent devel files are avai=
lable.\n");
> +               pr_err("The babeltrace2 ctf support is not compiled in. E=
nsure you have both\n"
> +                       "libbabeltrace2-dev[el] and libtraceevent-dev[el]=
 installed or set\n"
> +                       "PKG_CONFIG_PATH to find a local installation of =
those libraries.\n");
>                 return -1;
>  #endif
>         }
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 6587dc326d1b..cc0138fa6d67 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -93,7 +93,7 @@ make_no_libbpf            :=3D NO_LIBBPF=3D1
>  make_libbpf_dynamic :=3D LIBBPF_DYNAMIC=3D1
>  make_no_libbpf_DEBUG :=3D NO_LIBBPF=3D1 DEBUG=3D1
>  make_no_libllvm     :=3D NO_LIBLLVM=3D1
> -make_with_babeltrace:=3D LIBBABELTRACE=3D1
> +make_no_babeltrace2 :=3D NO_BABELTRACE2=3D1
>  make_with_coresight :=3D CORESIGHT=3D1
>  make_no_sdt        :=3D NO_SDT=3D1
>  make_no_libpfm4     :=3D NO_LIBPFM4=3D1
> @@ -170,7 +170,7 @@ run +=3D make_no_libbpf_DEBUG
>  run +=3D make_no_libllvm
>  run +=3D make_no_sdt
>  run +=3D make_no_syscall_tbl
> -run +=3D make_with_babeltrace
> +run +=3D make_no_babeltrace2
>  run +=3D make_with_coresight
>  run +=3D make_with_clangllvm
>  run +=3D make_no_libpfm4
> diff --git a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh b/too=
ls/perf/tests/shell/test_perf_data_converter_ctf.sh
> index 334eebc9945e..bc58a8dabf4c 100755
> --- a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
> +++ b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
> @@ -24,11 +24,11 @@ trap_cleanup()
>  }
>  trap trap_cleanup exit term int
>
> -check_babeltrace_support()
> +check_babeltrace2_support()
>  {
> -       if ! perf check feature libbabeltrace
> +       if ! perf check feature babeltrace2-ctf-writer
>         then
> -               echo "perf not linked with libbabeltrace, skipping test"
> +               echo "perf not linked with babeltrace2-ctf-writer, skippi=
ng test"
>                 exit 2
>         fi
>  }
> @@ -97,7 +97,7 @@ test_ctf_converter_pipe()
>         fi
>  }
>
> -check_babeltrace_support
> +check_babeltrace2_support
>  test_ctf_converter_file
>  test_ctf_converter_pipe
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index bcccad7487a9..782f208cf30f 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -233,7 +233,7 @@ perf-util-$(CONFIG_LIBUNWIND_X86)      +=3D libunwind=
/x86_32.o
>  perf-util-$(CONFIG_LIBUNWIND_AARCH64)  +=3D libunwind/arm64.o
>
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> -  perf-util-$(CONFIG_LIBBABELTRACE) +=3D data-convert-bt.o
> +  perf-util-$(CONFIG_BABELTRACE2_CTF_WRITER) +=3D data-convert-bt.o
>  endif
>
>  perf-util-y +=3D data-convert-json.o
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-con=
vert-bt.c
> index ba1c8e48d495..91d8cdc9e8c7 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -11,14 +11,13 @@
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
> -#include <babeltrace/ctf-writer/writer.h>
> -#include <babeltrace/ctf-writer/clock.h>
> -#include <babeltrace/ctf-writer/stream.h>
> -#include <babeltrace/ctf-writer/event.h>
> -#include <babeltrace/ctf-writer/event-types.h>
> -#include <babeltrace/ctf-writer/event-fields.h>
> -#include <babeltrace/ctf-ir/utils.h>
> -#include <babeltrace/ctf/events.h>
> +#include <babeltrace2-ctf-writer/writer.h>
> +#include <babeltrace2-ctf-writer/clock.h>
> +#include <babeltrace2-ctf-writer/stream.h>
> +#include <babeltrace2-ctf-writer/event.h>
> +#include <babeltrace2-ctf-writer/event-types.h>
> +#include <babeltrace2-ctf-writer/event-fields.h>
> +#include <babeltrace2-ctf-writer/utils.h>
>  #include "asm/bug.h"
>  #include "data-convert.h"
>  #include "session.h"
> @@ -121,13 +120,13 @@ static int value_set(struct bt_ctf_field_type *type=
,
>         }
>
>         if (sign) {
> -               ret =3D bt_ctf_field_signed_integer_set_value(field, val)=
;
> +               ret =3D bt_ctf_field_integer_signed_set_value(field, val)=
;
>                 if (ret) {
>                         pr_err("failed to set field value %s\n", name);
>                         goto err;
>                 }
>         } else {
> -               ret =3D bt_ctf_field_unsigned_integer_set_value(field, va=
l);
> +               ret =3D bt_ctf_field_integer_unsigned_set_value(field, va=
l);
>                 if (ret) {
>                         pr_err("failed to set field value %s\n", name);
>                         goto err;
> @@ -374,10 +373,10 @@ static int add_tracepoint_field_value(struct ctf_wr=
iter *cw,
>                                         data + offset + i * len, len);
>
>                         if (!(flags & TEP_FIELD_IS_SIGNED))
> -                               ret =3D bt_ctf_field_unsigned_integer_set=
_value(
> +                               ret =3D bt_ctf_field_integer_unsigned_set=
_value(
>                                                 field, value_int);
>                         else
> -                               ret =3D bt_ctf_field_signed_integer_set_v=
alue(
> +                               ret =3D bt_ctf_field_integer_signed_set_v=
alue(
>                                                 field, adjust_signedness(=
value_int, len));
>                 }
>
> @@ -471,7 +470,7 @@ add_bpf_output_values(struct bt_ctf_event_class *even=
t_class,
>                 goto put_len_type;
>         }
>
> -       ret =3D bt_ctf_field_unsigned_integer_set_value(len_field, nr_ele=
ments);
> +       ret =3D bt_ctf_field_integer_unsigned_set_value(len_field, nr_ele=
ments);
>         if (ret) {
>                 pr_err("failed to set field value for raw_len\n");
>                 goto put_len_field;
> @@ -500,7 +499,7 @@ add_bpf_output_values(struct bt_ctf_event_class *even=
t_class,
>                 struct bt_ctf_field *elem_field =3D
>                         bt_ctf_field_sequence_get_field(seq_field, i);
>
> -               ret =3D bt_ctf_field_unsigned_integer_set_value(elem_fiel=
d,
> +               ret =3D bt_ctf_field_integer_unsigned_set_value(elem_fiel=
d,
>                                 ((u32 *)(sample->raw_data))[i]);
>
>                 bt_ctf_field_put(elem_field);
> @@ -545,7 +544,7 @@ add_callchain_output_values(struct bt_ctf_event_class=
 *event_class,
>                 goto put_len_type;
>         }
>
> -       ret =3D bt_ctf_field_unsigned_integer_set_value(len_field, nr_ele=
ments);
> +       ret =3D bt_ctf_field_integer_unsigned_set_value(len_field, nr_ele=
ments);
>         if (ret) {
>                 pr_err("failed to set field value for perf_callchain_size=
\n");
>                 goto put_len_field;
> @@ -575,7 +574,7 @@ add_callchain_output_values(struct bt_ctf_event_class=
 *event_class,
>                 struct bt_ctf_field *elem_field =3D
>                         bt_ctf_field_sequence_get_field(seq_field, i);
>
> -               ret =3D bt_ctf_field_unsigned_integer_set_value(elem_fiel=
d,
> +               ret =3D bt_ctf_field_integer_unsigned_set_value(elem_fiel=
d,
>                                 ((u64 *)(callchain->ips))[i]);
>
>                 bt_ctf_field_put(elem_field);
> @@ -728,7 +727,7 @@ static struct ctf_stream *ctf_stream__create(struct c=
tf_writer *cw, int cpu)
>                 goto out;
>         }
>
> -       ret =3D bt_ctf_field_unsigned_integer_set_value(cpu_field, (u32) =
cpu);
> +       ret =3D bt_ctf_field_integer_unsigned_set_value(cpu_field, (u32) =
cpu);
>         if (ret) {
>                 pr_err("Failed to update CPU number\n");
>                 goto out;
> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-conver=
t.h
> index ee651fa680a1..a96240f15671 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h
> @@ -11,10 +11,10 @@ struct perf_data_convert_opts {
>         const char *time_str;
>  };
>
> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
> +#ifdef HAVE_BABELTRACE2_CTF_WRITER_SUPPORT
>  int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
>                          struct perf_data_convert_opts *opts);
> -#endif /* HAVE_LIBBABELTRACE_SUPPORT */
> +#endif /* HAVE_BABELTRACE2_CTF_WRITER_SUPPORT */
>
>  int bt_convert__perf2json(const char *input_name, const char *to_ctf,
>                          struct perf_data_convert_opts *opts);
> --
> 2.47.3
>
