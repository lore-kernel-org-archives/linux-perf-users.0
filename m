Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C74968EB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871918; cv=pass; b=eMOgApLPy7r7RXen2c3tepIajnXrk10UKgNtqIRBKrQFEcve7dg7F7+0wRGrCTqb+D0XxiX7GblXkpCRiOpXGrwoRAUlZlTFBBRbYNi8ry8NvfHiZ3OlLH/HFG2x/Ldzz0a0yp9rhkZfQyZYLS0ALm7pmoS8T9ScCNlWoCP8qe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871918; c=relaxed/simple;
	bh=0dgwBSyY5kwnxQy2MvUtG+uRtBie81JFchBqXisMEdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj0gXXmGYcgEystB1pENoeVbJszXmHEXxvFZLYcc5tZIrZrsGR7ItWTSTxmtRNGBiM1cEkdR+82qgJ0izAIrd28foRT6S9E/ALo2OfPalurqaFj2OM7hIEq0wIYiGmCxKTtfyHhs5Ns3dCehM0XqHwtUIkEaLyilIpyry7KHTSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDa8+Gtc; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDa8+Gtc"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so401471cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 09:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790871915; cv=none;
        d=google.com; s=arc-20260327;
        b=X4q7Y2oIDK8YlQcdJAG45u8cBQPByhCUhkW378ooTZUa6pIfHf/7bIRnIKhv7M2Im5
         XGdq5RX4Ws5JX5agREFmLLaJFAkcQTzmilo/gGxyj3tePJRysw0RNKnOafICFMuZA0Z4
         gn7K+ebveqNLx7nddN7+AvPMvqipjq04R7ga/zto9TyPAUxAwCGJK+DvWt3uzW4W4SN/
         jYo0pxTodctJUHMF+FixCIqU302hYm/c71/D9s2W/C7JhoxWLKud5OeruPN/DJ7XjLBS
         mBLs3XVa2TFgfrbEpX1za0vqO4RABcvU+YcdaJvHdJMZDDVchYOdXOdhiCxqnx+pupOJ
         6NHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbdg8a5GCBabcFyDaNgExjUkDEX2FeQ8tqfqWqJxGjk=;
        fh=/D25SxqtEKbt7oH/0tXZOEHKTKQ3x0UkViJJL5/BACo=;
        b=rF5qxK4Urv/Lu4aBUIEzSVgez8Ws62ixDLI/WfDpQ7ATKzvvBMqBdzheEco9HRMRBN
         c0kQTmrEZhL3kSYu3YCjG4gt2OkYth4UD/pvM/qeAhB60GpyqbaNpGACg2zGlRoM/iGt
         8x35YeZx/wFm1o3lPt4RGev+znSpO77fcbqDWM+th4x/EBB9sxJ5vO3ChbPHaXX6ySq8
         qlwX5MOO/jVo+w5SS4uGcsdCJByaF8qC4ZeO9gxpclzUvQnyLZ1c4F+BxKWpjoRuLLws
         ipDwM0EKf0o1GVjHzdVb+g3hZjPJHl3TwBjwpDMAUA7qbE74GoQqYo3CO6xAVC1lUlAj
         oomQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790871915; x=1791476715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbdg8a5GCBabcFyDaNgExjUkDEX2FeQ8tqfqWqJxGjk=;
        b=fDa8+GtcoKBV4yQR030DcD8kgToU+0zuMwyJPPPSoWXlftX5/tQFndSYhy0JmV0Kg7
         nphPVi/deVXYjzbCld1NT5Mn+iISnzAoTHKFZxfm+EV9nWfL1ATD/KUNNkY06AbXdqfF
         G+RJpkfmCQKnxSxBczj9PHLEKj12HugHW8UKWChM7VHztC0IZRbP/hrXjgn9qpgTK7wK
         BIY+/KLYDKZ+wbdr+XW4N2YjJ9ahIqVy6WIXUrhyB1UZZaqa0BKwbcxKbHwFbjVywbgS
         xeZAHHM8w+LdfGLyxYhWrem+36pZn4tloO06z7i4EZww7rGC2G93i1tH7mCTi1cFULho
         c2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790871915; x=1791476715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbdg8a5GCBabcFyDaNgExjUkDEX2FeQ8tqfqWqJxGjk=;
        b=OwDLsKIntxCF5nIV0DjP3N1jmCwR9n6f1iL8m14n6Gk+lO0DMATuwwBjXBkRkzX3lP
         3ZmFlSiFWh7Crsx2ETu/qTLcX9DXr4QXKggryDyiuXrYeaabbhjrI2TBzKr3Fg8xhF5p
         ZufSEtLdonuvErvvPdHp8rqIiErGMfrVRLzNGhMWcLkG/TWiISqJfclk9UZzgXwN1dHV
         GkHFJl3dLPUtgHR5NtYB2qsofRBuIr3OBusntZqqtBXEuTk82GmsUolhmMtajfx0e9Yu
         FwyZFeTTzDjvBaZE2PNRcjNTaEAl2Ds0lxJ7IQQItIBAaNdYnXnCXpCu0wr1oo8vJaeo
         8Nbw==
X-Forwarded-Encrypted: i=1; AKwUvByNeyT9r+izn80cAkqSlallITMw/f0qM75LGG55mlx8NZeeAJ7PXS/e5m7Y2ogcu75dWjTs+5OjymAs+s8KerC1@vger.kernel.org
X-Gm-Message-State: AFuF++lpFgliTm6VxEix2+xfe6G7niT6OXSel8+KAN77NAc2/1SWQhsu
	4hQRv4Jbf06MzyDUNrHCsS06rE6orncMgy1I0JZ9rSMGpziTadHWyYqRSYftYGs2am4leMC8s3t
	UV/8y5gTmTpSTwThDtZcS+dNuXOZNF0oc5cdNGvd9
X-Gm-Gg: AYBFou3Ot0kQtFukCVSzf4bwmfBsVsnxC4qSYjJuE0kyPdNlKSO7oo0ETSUOjcnXIyU
	LVVhDNDbbWB6ljPjJ4XSHHOzBz4Fh2rWOcpFKrPBSygYa8AAe9kQ1cgQRtjWrJEw2GukNkM675x
	QHerKeMzzRG6e6K0Ux5f4s3nCJZZKY4dweUFzBP367MX2sG5oSYVv/Sq5sVU/jUdu08fifa/RXb
	VCsklLm92oaje+ptQETcyYYybhtkzg6yGJMB7iGF65XY89iYiJJUCDpNKJ9+1RUTm+++eUr+0h0
	d3mu+0rLD1VSOI7F+jm2k2DLMmYfb5uRYqFU0vDpV3+7LvPVr1Lz01j/wNhW3/ZH
X-Received: by 2002:ac8:5ccd:0:b0:532:ad75:e432 with SMTP id
 d75a77b69052e-53388dc70aemr15514341cf.8.1790871914780; Thu, 01 Oct 2026
 09:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-james-perf-stale-python-build-v1-1-dd3b14644606@linaro.org>
In-Reply-To: <20261001-james-perf-stale-python-build-v1-1-dd3b14644606@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Oct 2026 09:25:02 -0700
X-Gm-Features: AclHuK_fw2PnQE0lbF_B_VTbCQ5lekCKf5AOeTJerQ2_L1zY0y03w5J85D9iSag
Message-ID: <CAP-5=fVsTGp+_gsk-yCiK58A7O3LuK0okOuHwuVr+xgiSHVGLQ@mail.gmail.com>
Subject: Re: [PATCH] perf python: Track linked libraries as extension dependencies
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 8:48=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Since the Python extension switched to linking perf libraries, setup.py
> only lists util/python.c as a source. The libraries are supplied through
> LDFLAGS, which setuptools does not consider when deciding whether the
> extension needs to be rebuilt.
>
> When a library changes, make invokes setup.py, but setuptools can skip
> the build and the recipe copies the stale cached extension back into
> python/. This leaves perf and its Python module running different
> versions of the same code.
>
> Pass the linked library paths to setup.py and declare them as Extension
> dependencies so that library changes trigger a rebuild. Include
> EXTRA_PERFLIBS in the shared library list so that both make and
> setuptools track those inputs as well, preserving the existing linker
> order.
>
> Fixes: 9dabf4003423 ("perf python: Switch module to linking libraries fro=
m building source")
> Assisted-by: Codex:GPT-6-Astra
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/Makefile.perf | 5 +++--
>  tools/perf/util/setup.py | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 7ceefc1da774..dbf7cceaa005 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -526,8 +526,8 @@ endif
>  EXTLIBS :=3D $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
>  LIBS =3D -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whol=
e-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
>
> -PERFLIBS_PY :=3D $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PE=
RFLIBS))
> -LIBS_PY =3D -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--n=
o-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
> +PERFLIBS_PY :=3D $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PE=
RFLIBS)) $(EXTRA_PERFLIBS)
> +LIBS_PY =3D -Wl,--whole-archive $(PERFLIBS_PY) -Wl,--no-whole-archive -W=
l,--start-group $(EXTLIBS) -Wl,--end-group
>
>  export INSTALL SHELL_PATH
>
> @@ -559,6 +559,7 @@ $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPU=
T)python')
>  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup=
.py python/perf.pyi $(PERFLIBS_PY)
>         $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
>          CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
> +         PYTHON_EXT_DEPS=3D'$(PERFLIBS_PY)' \
>           $(PYTHON_WORD) util/setup.py \
>           $(python_setup_quiet) build_ext; \
>         cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 8380980ade4c..3b6a59f66944 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -173,6 +173,7 @@ def main() -> None:
>      perf =3D Extension(
>          'perf',
>          sources=3D[os.path.join(src_perf, 'util/python.c')],
> +        depends=3Dshlex.split(os.getenv('PYTHON_EXT_DEPS', '')),
>          include_dirs=3D['util/include'],
>          extra_compile_args=3Dcflags,
>      )
>
> ---
> base-commit: 705da5b15ab89ba97b11eedbe507c2fd83d31cb9
> change-id: 20261001-james-perf-stale-python-build-d6b17da2f231
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
