Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BDEEC3
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764808511; cv=none; b=Z8obKZ+KNu8exzdT9Vq73uFicA+49X6d/b5TXsUPFTFltqqRltMEjftb3w4D/dP4yDF17MjgdwJrtG2FNRe/IlrY3UuQhqgEQmluIIqWbRcTrPzcwMP8wz888L+IrIE6SNikkEMleNYJUMX+04DRanRn6Sf/XZV5XP6ld7XNI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764808511; c=relaxed/simple;
	bh=qgzowlqvozrCdDlDBPM5DsRKNURP5c6NQbJd24LpgBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4K7zzSQVQNHCS9nGZVQsRpaA9i6t7+XCXRoZ7L3yAqKzgrRliiWwTNRJElbxRGTK+qQL/iCd2bNe75j5rS+FGc6iT2zNJWWXsopP9UF33KzswzhgdmPD3dqxYa8OVuyJy0lyKI8gXMA6QQBO2c1zkrqNKv2b+mrlfZBZhjO1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h977q/0H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h977q/0H"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295c64cb951so85745ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 16:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764808509; x=1765413309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8NxXfPbmZpTpe7Ihl25p9otWD958rJ0JpuGnfn0nEk=;
        b=h977q/0Hj8CwutoQ/JMmOldqtg3TzK5WKTvxid5W8wfAjwMZ05GRg80Px/zWdy8Bk4
         NWHqGL0yFh/ofJBsOHBxiCjQElCD3iCSxkRxQ7Ibn0Y/qW/AjQ9NK+EOB6a7WwonlyJg
         lO9LMHGVC6a9QZjP/aj5lrLf0AvDnAaQw+j+i3f6CFQVNjpNAQ5YJ0jtpohAYUrf8ndK
         0qvi5gjSIQmDqRp/r+obs13RpeJCEDx7agumCw7GcX8YtdflQMuFshAK4D9p+1o69z6c
         NsN6xCbhK3mam/ooFk7odwRXrtCwEBp8+5FXYoPwJyfzWqZiaSeeazJBz9Q8snSmGjYC
         TXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764808509; x=1765413309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8NxXfPbmZpTpe7Ihl25p9otWD958rJ0JpuGnfn0nEk=;
        b=KeS2D46QqhVRZKatXIhsMUKlEswuaOspeWbX84mt8PwZmyldB0W9UjtMJn1kdd2u8l
         SONCYCybGrgYRbqJWHpR5gq20yZXhPKfIFYzh2pWvcyyj2ovIc3rZJ6B2EqERVdVaacV
         NTEw/Ai/65EOepuadJ/XNv9LAIkTuWe6X6E035q1nin9cp+Q8tmdV7/Q3/jjum6vQjBU
         decQvda44Ki5xhMDffWjYAcmk/rSWD+SoalcTffH7WHVIrzLfofcAvy1tlq2vFC5co7w
         M+nd1+cul9aQKWXuWhu5+NdFKzz86Lm8bXg5zYFlNg2jBA5kE6urZRTULKs+KNMjUsfq
         pE2g==
X-Forwarded-Encrypted: i=1; AJvYcCU4ixl027fEdq3VVKgXOZF4QzWmtmxqszJ9gTs7UeglZs5fFMTrYvo0rhXWdudf59TlxJX9dFwFlptYSUP8+fGx@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHhnmt7FFsZA8ykLdSnaW9z1QGNdancoOE8AQlZ3yO41Mqn6S
	/GJFiZCCvs6JM/FBw1XG1vM+Tmdz1DgA3shKOwdbp8YWCz36WzcuHfETtPLhJiR4sk+CBpC54BZ
	uIM7sigL5c2sh0Xyda7fEViIiHowBwOin6v1nkCro
X-Gm-Gg: ASbGncuZ1xK2QpwyIwqBHpS9+wwYk4NO+4tXeAZv4tYfXw0c+UF/SxxHwt2zNP2Dg9X
	kcej8GK1fCDI/IfhjBeEYvS3yr3lL6uGWWzDlfE8PQ0okrNahd+LVcvj6pHHjAy6ho2xtx2Cvdy
	2yZw3ueWsvzVLtxFC51EfODgJotWwLiSmztc16TISSFJx+IYKhaHkUsgOoWa44r9feM7ZL8jlny
	d+oaFeMz3PqkrkL4FxBBkoJ9oA72orzRd7yyAmPQhXINmpqdfuMmB+csn0fgdzXDRAxlrEQ
X-Google-Smtp-Source: AGHT+IGtuTwFiqEVUPuFXsWaToyH66kacw06+zovttbjLZvSFsLj2aUpbFICoYLoW+5DcEZ1+naYSFaxz6aLt8bJaPw=
X-Received: by 2002:a17:902:e551:b0:290:cd63:e922 with SMTP id
 d9443c01a7336-29dacc202f9mr615265ad.15.1764808508741; Wed, 03 Dec 2025
 16:35:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203232924.1119206-1-namhyung@kernel.org>
In-Reply-To: <20251203232924.1119206-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 16:34:56 -0800
X-Gm-Features: AWmQ_blAzZW_jsMqIr61VwXVVoWBHwRZTdy5zFilIW7cQO8zIwuVd0klRVGDF00
Message-ID: <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
To: Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 3:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> It's used by bpftool and the kernel build.  Let's add a feature test so
> that perf can decide what to do based on the availability.

It seems strange to add a feature test that bpftool is missing and
then use it only in the perf build. The signing of bpf programs isn't
something I think we need for skeleton support in perf. I like the
feature test, could we add it and use it in bpftool? The only two
functions using openssl appear to be:

  __u32 register_session_key(const char *key_der_path)
  int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)

so we can do the whole feature test then #ifdef HAVE_FEATURE... stub
static inline versions of the functions game?

Perhaps we only need the bootstrap version of bpftool in perf and we
can just avoid dependencies that way. Looking at bpftool's build I see
that sign.o/c with those functions in is part of the bootstrap version
of bpftool :-(

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/Makefile.feature          | 6 ++++--
>  tools/build/feature/Makefile          | 8 ++++++--
>  tools/build/feature/test-all.c        | 5 +++++
>  tools/build/feature/test-libopenssl.c | 7 +++++++
>  4 files changed, 22 insertions(+), 4 deletions(-)
>  create mode 100644 tools/build/feature/test-libopenssl.c
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index fc6abe369f7373c5..bc6d85bad379321b 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -99,7 +99,8 @@ FEATURE_TESTS_BASIC :=3D                  \
>          libzstd                                \
>          disassembler-four-args         \
>          disassembler-init-styled       \
> -        file-handle
> +        file-handle                    \
> +        libopenssl
>
>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>  # of all feature tests
> @@ -147,7 +148,8 @@ FEATURE_DISPLAY ?=3D              \
>           lzma                   \
>           bpf                   \
>           libaio                        \
> -         libzstd
> +         libzstd               \
> +         libopenssl
>
>  #
>  # Declare group members of a feature to display the logical OR of the de=
tection
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 7c90e0d0157ac9b1..3fd5ad0db2109778 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -67,12 +67,13 @@ FILES=3D                                          \
>           test-libopencsd.bin                   \
>           test-clang.bin                                \
>           test-llvm.bin                         \
> -         test-llvm-perf.bin   \
> +         test-llvm-perf.bin                    \
>           test-libaio.bin                       \
>           test-libzstd.bin                      \
>           test-clang-bpf-co-re.bin              \
>           test-file-handle.bin                  \
> -         test-libpfm4.bin
> +         test-libpfm4.bin                      \
> +         test-libopenssl.bin
>
>  FILES :=3D $(addprefix $(OUTPUT),$(FILES))
>
> @@ -381,6 +382,9 @@ endif
>  $(OUTPUT)test-libpfm4.bin:
>         $(BUILD) -lpfm
>
> +$(OUTPUT)test-libopenssl.bin:
> +       $(BUILD) -lssl
> +
>  $(OUTPUT)test-bpftool-skeletons.bin:
>         $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
>                 > $(@:.bin=3D.make.output) 2>&1
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index eb346160d0ba0e2f..1488bf6e607836e5 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -142,6 +142,10 @@
>  # include "test-libtraceevent.c"
>  #undef main
>
> +#define main main_test_libopenssl
> +# include "test-libopenssl.c"
> +#undef main
> +
>  int main(int argc, char *argv[])
>  {
>         main_test_libpython();
> @@ -173,6 +177,7 @@ int main(int argc, char *argv[])
>         main_test_reallocarray();
>         main_test_libzstd();
>         main_test_libtraceevent();
> +       main_test_libopenssl();
>
>         return 0;
>  }
> diff --git a/tools/build/feature/test-libopenssl.c b/tools/build/feature/=
test-libopenssl.c
> new file mode 100644
> index 0000000000000000..168c45894e8be687
> --- /dev/null
> +++ b/tools/build/feature/test-libopenssl.c
> @@ -0,0 +1,7 @@
> +#include <openssl/ssl.h>
> +#include <openssl/opensslv.h>
> +
> +int main(void)
> +{
> +       return SSL_library_init();
> +}
> --
> 2.52.0.177.g9f829587af-goog
>
