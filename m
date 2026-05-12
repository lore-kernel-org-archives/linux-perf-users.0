Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A5383C64
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622875; cv=pass; b=NZTJiLsdSRGxdVbVbveBBanBAMvuBuT4pQWivopBEeTrtF13d3iLX61CK3Op/aLqCT/NNGCTewoUmAYUbiumO6zUd2nUHrGWV2mmn77cdoyoBN5lwOnj0rlLE7l9cewD4V6zkqCtXGisqAPgllUVmpirS6wTs9yV1RNAGIgC8dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622875; c=relaxed/simple;
	bh=bzVhsH9+yVi9w0ir4R3MT7/TN6Qs26EGTv44LzjHZJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1VVKQF/0RU8GQ+NCDKDeDdKBy+Kxm62JuvtzvEE83i2GwWntr5vU2wAAjQLamJZlX8VEq2S/PkheijCilW/TlTN4H5yDhxCCTtotN+BPV0mdFIPcJ0QkmWdHwjWkCnj6ZVqlxhAASV0RB0tTui2zsUTTyh9Hld8jm0587fLox4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PxosJidX; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxosJidX"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132cccd3d77so159c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 14:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778622872; cv=none;
        d=google.com; s=arc-20240605;
        b=EnD8o74iraP26gn0tLHd9kAcA8jxnGcVsDkKmb8dlOsVu/j3+FagSXNHwQ8r+z3zjC
         jMrqbbt0XNUtrzQoLRLLMfvxtCsRmOLUePtm8NpB4+x5nTIK79E1ykEwfwpDiFbN3ETv
         NFmL9SUMBU/1+VAmOQH9dRKTCHkjGuvySPvRnP4+jYp9si8HXlcYs+5wRpEtfoLfhw7L
         N82dOeWkehah911terX50wF/FRvBjEaFdpbvYstypzL3jyfOcaUvi42zyHr8m/1i1ukS
         w46aI2uD8X9xs9Niv3n1ZuBRYTxZ884+ORrhGBvpqStSbr0jKWMrvdzaRgu7L//p78K7
         auSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gdN8kFNXUPj/HxDMY3ZzwkjdUXE+I3G25lEDAXWd1VQ=;
        fh=BatsI6EJwO4YHBCNRWHRUr3/WnZByq0FYZO7Cq2VEww=;
        b=DFYS7KmWzFkiCJwXLLF1hLdpJQ4kxZyiILrGbRc0sO0rge3mRckoEWbRL0OMWAt2Nf
         r6BDkgt9q+3yHAnYE9Faf8SFzOKi0PPZerH0ZkX8K9gEWIg0Eo9MafU+wH/FjOMHw0Pn
         cnnRdT2tXEd/gmrZ+Ps0luSJjxUw57R8NXQ96qP7SxB5fmSLEe0ikozQpuZ9XWFFruPU
         4ssaPmrB0H8AIoU6yIkxw2Csd5Z9oO6Op9F0yqN0FaBQkOe65nmqeCUVHmQ/NtelLRCV
         KU5P/p3j5tqbEDrKggiklBjJmjWUVrF8ue3mCQyYLw+MlzuHUkwQzq2hWdiO/evfXTPX
         hzCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778622872; x=1779227672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdN8kFNXUPj/HxDMY3ZzwkjdUXE+I3G25lEDAXWd1VQ=;
        b=PxosJidX5cgTn52RfYKbSaj2VbCeGEC7BWMWZIEKTs0u6mbt2uxVPnpNd/waCeSLbf
         ai4VskBNTEQiMN12dR4kwJ5gRC+AyeoIunzdOR+ixfAFWYyry4pEnOfuMbXAC/WYOlJG
         z09wdvlLbqwVZpBcXIveFeeNJvObbtBkpLQ5APFwhHSxqhEsBVCuij615Wk4SNs6GUaK
         TtLImr6w7TIwlsfy8PEt3ZqEj/N5PKQrzjHxXVt0WSHYj5IQukzVnan6CayLpfKunSJu
         j2OFuqvrYU/Xs2Zd44LHPp7rLbNYTB31sQugmnTGHC8r96Krbs5Xj/3vANRfiiuLd8hN
         ZPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622872; x=1779227672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdN8kFNXUPj/HxDMY3ZzwkjdUXE+I3G25lEDAXWd1VQ=;
        b=oYkKmCVuYu1ZY73L0zo17s6V+sXYbDQ9Eiq2B+bWNnauuaKnCbeg+HcBe8BlOKTB6O
         Lp55g7ywmVVLL7K+YdTLDf08eEz1zh+iYcWy7V6VLyV8EuS8S5bZNVDZQZ2rB62KDXN0
         UvbqgoOhr3zWK4yy8m47b9IciC/GbNOLXAURY4ViODh7HwGBCsiJABUBzeId1g3arJbC
         lW+4ZZaOKr/8umz97qUVx/uXXQAA6Xw39P4gVU/wAWBafX9qHVxZbuNsb1uRt/5f0SeE
         nTqkn70pJWyoufhDFRD3VlA6P+VaScAiCBADti2AcA9ltiD0qM4j7AkowODmVoLAPiiZ
         QoHg==
X-Forwarded-Encrypted: i=1; AFNElJ+CKmQE8xN7QcZ1750JrR+kcHiRCCoauuUNsL9dH3AerTUhoy9HON+AVVHZXWGn4YBYVIMPpA1El6nPLtVQBCZF@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+e74pqWe0o68jXYy8AD55DqZwHfVSh29n8YqUiivnEtb7fR5
	UnaC+ULZZI6kgmEjQWDbm5NCeaWGysxjprNZRohqqkyCD2c0fVwvBf6hf4vWa9oNlSacbZCGz8b
	OGX8fP51MiOS9sTcbDJKJ/8DKDKB9K+Kbh3kYIMlW
X-Gm-Gg: Acq92OHH9RrMwMyus5Pm8hys5cjmkprwg+VIw+eOgu4a2eeTPcbUJemYA9bBc38SuME
	w06js0025mLshXE2mXrQiHTMrVYl7Hwu056dlSMUn+dvvafBJkzszhtr7kEGyNGxu4GHrun3tF1
	w2kP4sVWWHN2TqHI1hAuG5PTbpOmQwKDKvZU5qECxvkz884ANxQ8AN7Qg3jqLWZqNO+Th00uXJF
	JQlm5Y+SMxdFmUuyIrf9CT7Zx428R+wEGxLG8WxnzdPZTFJDAk/UBGrR5ebrZTEaydbidHpNZ9A
	qZRUKo+6ZtAKM5mixC0PVrVZxTwxvEpilTrpyVmNmeheTN88
X-Received: by 2002:a05:7022:1e10:b0:133:52da:cb5f with SMTP id
 a92af1059eb24-13489cafa5bmr33916c88.21.1778622870934; Tue, 12 May 2026
 14:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512194710.162215-1-mjeanson@efficios.com>
In-Reply-To: <20260512194710.162215-1-mjeanson@efficios.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 14:54:18 -0700
X-Gm-Features: AVHnY4JKrbDidfNEvacHWfbUO_d-oTQEObFIc2e2gbr_FCF3XP8tN8jxI2IbsrA
Message-ID: <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
Subject: Re: [PATCH] perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer
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

On Tue, May 12, 2026 at 12:47=E2=80=AFPM Michael Jeanson <mjeanson@efficios=
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
> No changes to the output ctf traces, this API still implements version
> 1.8 of the CTF specification that can be read by either Babeltrace 1 / 2
> or any CTF compliant reader.
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
> ---
>  tools/build/Makefile.feature                  |  5 +--
>  tools/build/feature/Makefile                  |  6 ++--
>  tools/build/feature/test-all.c                | 13 ++------
>  ...ltrace.c =3D> test-babeltrace2-ctf-writer.c} |  3 +-
>  tools/perf/Makefile.config                    | 28 ++++++++--------
>  tools/perf/Makefile.perf                      |  2 +-
>  tools/perf/builtin-check.c                    |  2 +-
>  tools/perf/builtin-data.c                     | 18 +++-------
>  tools/perf/tests/make                         |  4 +--
>  .../shell/test_perf_data_converter_ctf.sh     |  8 ++---
>  tools/perf/util/Build                         |  2 +-
>  tools/perf/util/data-convert-bt.c             | 33 +++++++++----------
>  tools/perf/util/data-convert.h                |  4 +--
>  13 files changed, 55 insertions(+), 73 deletions(-)
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
> index 1488bf6e6078..145abdee049d 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -98,17 +98,9 @@
>  # include "test-sched_getcpu.c"
>  #undef main
>
> -# if 0
> -/*
> - * Disable libbabeltrace check for test-all, because the requested
> - * library version is not released yet in most distributions. Will
> - * reenable later.
> - */
> -
> -#define main main_test_libbabeltrace
> -# include "test-libbabeltrace.c"
> +#define main main_test_babeltrace2_ctf_writer
> +# include "test-babeltrace2-ctf-writer.c"

So I still think the comment about libbabeltrace is probably valid:
most distributions won't have it by default, so a separate test is
likely better than testing with test-all. You also need to update
FEATURE_TESTS_BASIFEATURE_TESTS_BASIC.

>  #undef main
> -#endif
>
>  #define main main_test_lzma
>  # include "test-lzma.c"
> @@ -178,6 +170,7 @@ int main(int argc, char *argv[])
>         main_test_libzstd();
>         main_test_libtraceevent();
>         main_test_libopenssl();
> +       main_test_babeltrace2_ctf_writer();
>
>         return 0;
>  }
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
> index 15fbba9f4ca8..f2f5051c94e3 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -196,13 +196,13 @@ FEATURE_CHECK_CFLAGS-libdw :=3D $(LIBDW_CFLAGS)
>  FEATURE_CHECK_LDFLAGS-libdw :=3D $(LIBDW_LDFLAGS) $(DWARFLIBS)
>
>  # for linking with debug library, run like:
> -# make DEBUG=3D1 LIBBABELTRACE_DIR=3D/opt/libbabeltrace/
> -ifdef LIBBABELTRACE_DIR
> -  LIBBABELTRACE_CFLAGS  :=3D -I$(LIBBABELTRACE_DIR)/include
> -  LIBBABELTRACE_LDFLAGS :=3D -L$(LIBBABELTRACE_DIR)/lib
> +# make DEBUG=3D1 PKG_CONFIG_PATH=3D/opt/babeltrace2/(lib|lib64)/pkgconfi=
g

Delete?

> +
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
> @@ -1058,15 +1058,15 @@ else
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
> +    CFLAGS +=3D -DHAVE_BABELTRACE2_SUPPORT $(shell $(PKG_CONFIG) --cflag=
s babeltrace2-ctf-writer)
> +    LDFLAGS +=3D $(shell $(PKG_CONFIG) --libs-only-L babeltrace2-ctf-wri=
ter)
> +    EXTLIBS +=3D $(shell $(PKG_CONFIG) --libs-only-l babeltrace2-ctf-wri=
ter)
> +    $(call detected,CONFIG_BABELTRACE2)
>    else
> -    $(warning No libbabeltrace found, disables 'perf data' CTF format su=
pport, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
> +    $(warning No babeltrace2 found, disables 'perf data' CTF format supp=
ort, please install libbabeltrace2-dev[el])
>    endif
>  endif
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f7b936deeaa2..1f4e84a8472e 100644
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
> index 3641d263b345..e9d14a960a03 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -43,7 +43,7 @@ struct feature_status supported_features[] =3D {
>         FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
>         FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
>         FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, li=
cense incompatibility, use BUILD_NONDISTRO=3D1 and install binutils-dev[el]=
"),
> -       FEATURE_STATUS("libbabeltrace", HAVE_LIBBABELTRACE_SUPPORT),
> +       FEATURE_STATUS("babeltrace2-ctf-writer", HAVE_BABELTRACE2_SUPPORT=
),
>         FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
>         FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
>         FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index 85f59886b5cf..260d74476439 100644
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
> +#if defined(HAVE_BABELTRACE2_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>                 return bt_convert__perf2ctf(input_name, to_ctf, &opts);
>  #else
> -               pr_err("The libbabeltrace support is not compiled in. per=
f should be "
> -                      "compiled with environment variables LIBBABELTRACE=
=3D1 and "
> -                      "LIBBABELTRACE_DIR=3D/path/to/libbabeltrace/.\n"
> -                      "Check also if libbtraceevent devel files are avai=
lable.\n");
> +               pr_err("The babeltrace2 support is not compiled in. Ensur=
e you have both\n"
> +                       "libbabeltrace2-dev[el] and libtraceevent-dev[el]=
 installed or set\n"
> +                       "PKG_CONFIG_PATH to find a local installation of =
those libraries.\n");
>                 return -1;
>  #endif
>         }
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 6587dc326d1b..04f9b686cec0 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -93,7 +93,7 @@ make_no_libbpf            :=3D NO_LIBBPF=3D1
>  make_libbpf_dynamic :=3D LIBBPF_DYNAMIC=3D1
>  make_no_libbpf_DEBUG :=3D NO_LIBBPF=3D1 DEBUG=3D1
>  make_no_libllvm     :=3D NO_LIBLLVM=3D1
> -make_with_babeltrace:=3D LIBBABELTRACE=3D1
> +make_with_babeltrace2 :=3D BABELTRACE2=3D1
>  make_with_coresight :=3D CORESIGHT=3D1
>  make_no_sdt        :=3D NO_SDT=3D1
>  make_no_libpfm4     :=3D NO_LIBPFM4=3D1
> @@ -170,7 +170,7 @@ run +=3D make_no_libbpf_DEBUG
>  run +=3D make_no_libllvm
>  run +=3D make_no_sdt
>  run +=3D make_no_syscall_tbl
> -run +=3D make_with_babeltrace
> +run +=3D make_with_babeltrace2
>  run +=3D make_with_coresight
>  run +=3D make_with_clangllvm
>  run +=3D make_no_libpfm4
> diff --git a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh b/too=
ls/perf/tests/shell/test_perf_data_converter_ctf.sh
> index 334eebc9945e..65d49a10c028 100755
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
> +               echo "perf not linked with libbabeltrace2-ctf-writer, ski=
pping test"
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
> index bcccad7487a9..7f3b67c8eeab 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -233,7 +233,7 @@ perf-util-$(CONFIG_LIBUNWIND_X86)      +=3D libunwind=
/x86_32.o
>  perf-util-$(CONFIG_LIBUNWIND_AARCH64)  +=3D libunwind/arm64.o
>
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> -  perf-util-$(CONFIG_LIBBABELTRACE) +=3D data-convert-bt.o
> +  perf-util-$(CONFIG_BABELTRACE2) +=3D data-convert-bt.o
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

This is cool, I'm surprised at how non-invasive the change is. I'd
done a similar thing but keeping both babeltrace 1 and 2. I'll post my
WIP in reply just as a heads up, but I have to do much more heavy
engineering.

Thanks,
Ian

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
> index ee651fa680a1..d174e6f2729d 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h
> @@ -11,10 +11,10 @@ struct perf_data_convert_opts {
>         const char *time_str;
>  };
>
> -#ifdef HAVE_LIBBABELTRACE_SUPPORT
> +#ifdef HAVE_BABELTRACE2_SUPPORT
>  int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
>                          struct perf_data_convert_opts *opts);
> -#endif /* HAVE_LIBBABELTRACE_SUPPORT */
> +#endif /* HAVE_BABELTRACE2_SUPPORT */
>
>  int bt_convert__perf2json(const char *input_name, const char *to_ctf,
>                          struct perf_data_convert_opts *opts);
> --
> 2.47.3
>
