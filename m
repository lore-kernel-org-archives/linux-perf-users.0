Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395651DE1C
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790300; cv=pass; b=KA9sTLtQc9Sv4i7Hp32FHTnAadGX2H0fox5GRHBH5t7LJuf8zNIfXa9WtCNep5NWbgtV045Pe7WOPtZnZ5CHZ4J/XLSqZeUSwv4OWeKzUxEz8jYfo4U0PNYoU3pU99ni5c0eRbvxdu5fodZmULNDJdWE/4DlMzOB7+hOovIa78I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790300; c=relaxed/simple;
	bh=dTMeDWBANZwX4zFzq7MAqH9ZhFq7Chw/56eNHl++Lw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0lHZH9shSLFDHDb/k6GqsEvw/6uiXFFVQfsI9m+hflkb9t3lP71/bC3jb85i2ZRjpsbSfhnLmPzmfeVXiGQfmWuCnxhXPdQEvkBsIUd0RhTHHk4cqbQorr3uEncstLVyzhVc6raIf+NDutZAOwURovL/TxhUAgblw4cjGGKCRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEmEfaBd; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEmEfaBd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so6685ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 10:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790790298; cv=none;
        d=google.com; s=arc-20260327;
        b=n5q4XqYsAW+5ESuhprc0/9aBOGskBPJqqrcIM3qcMI+te8c4mJuHyYZwYDJVlFeq4v
         yE0TZMmzu2muEB8D70m1dnvh0yXiHGVq6LdkUr5QHVN3Lcb71Q0rcwFi1zWkPm/FstMl
         Mq8WQ5xZPvdmhfNt/9moArWqnkkyVWNLYmW0icookFpJe46KtJ/FQnKIts3iT8sTmgQZ
         ILrfMX+0ThYilY0GTEFUvczSoEOQ8a+YeNNuu0nh+FBq9iBpYp3m+lEkwmrYwsjfhZQK
         pwpDBm71OP7h7SQqS7bL4uyPQH6O9c84QcFJZEW2YZAtPCkezICMUa9RhoouOIZdDuTW
         MU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vngjmlHD1xi99YkDD1eun3vfRJyktfk498bj+4C7248=;
        fh=CRqBOSNf3FiTT9gZcBSmshpsfAK2yOtvFmVMH4DRqmM=;
        b=OS8ygXMju3CwW/GseNwgCnI4DKVsAwmyMe9AFE0GqPT66rD6MuClMdxQ4udmHLaI0R
         2eisRxZE3OqkubMWiiAQaWb0w7UaLi1QT5VDLs/Rk1z7ZVTc107LBBfmk0D/OEgV0a66
         3bJKf2JrS6dUNSWJR11yDiRGOMLm+e+Xv9BRDm1JmoSNFOdQrsXikIRnVZBXOhw/M+vO
         GV3Z94TMCzMYiBOi10lzUkkXtWyddZWJIqoCRq14QTYCIe5tjT3YBMn7i7DhdbB1VG+8
         Hn1+l7o7Xy72MzRZXbAdcrHLYoJDIYgLTvuOzLhfiDrUbXKSeCMTrFlHMPoKwPNOocOR
         B3eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790790298; x=1791395098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vngjmlHD1xi99YkDD1eun3vfRJyktfk498bj+4C7248=;
        b=aEmEfaBdRi1bvohp0k0CgcmSYMB9bBPTOVPMGa3b12RwXohDhrDrc4J7o+aKZ8nLg6
         NcMj0hmX3Hz1NmRspa/fQ3i1YimdscIwU0oQ0MOZUq5A7V9N+9NSPrCdIZcDXgiAcr8k
         ofCPvjpsBLstwl+jPw7xSv+IWy80ROBx9DJTZCvNcgwlbedt9SaVeNFiQ1DGZZ0lxC3n
         jwIzMA0WjjVZtergorxUoP1a20w0k3CPh6D/7lWiKlT1HOp0dXB9i/LY1awQdjf0Ri80
         3IatRmy11MqdJqMpJcjGIgr49F+UqVV2DfLXZep6Rt+omQ+02gXytBXUm0er9pAaFVeK
         NgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790790298; x=1791395098;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vngjmlHD1xi99YkDD1eun3vfRJyktfk498bj+4C7248=;
        b=v9iy5n3h0vBuPjNbTcYK4lEUmpCtwf8xKa9sWVr64AoWTlWx+R3oqsWqvaiVLb3+57
         4mOSMjbyva1XxIP6v2QseKPmsAgMUHC7I7tOubpHv9f2uUNbAKyT7DVh5P/sU2Gq3+eQ
         SnkunLMnhnQCBs/dVXOBNehBl246ptl0Vn9mj38S1Vb0ee8WlLFxqEFk/vwyfPak0PEI
         ygLQCAoJ4Dsh2upl7EdLy0CYx2vfcQg4UPKkoCdkxKy4CVzH8jJ802NHSDiS9rTq+O9/
         +p185yLhLThdnuN3O9I5dooSiIehVQLOBpc8BUkMx50fwl2WzmPsrhpGhdJaTXgNnFI/
         tYGQ==
X-Forwarded-Encrypted: i=1; AKwUvByDdU4iqZFk/EIEJzkiQt96EXhwd0kWY7/7ddeacF0J79I5KP6jYpNhjLZpCDLnBDGBq2zNqFL+BpIHmEeRfHns@vger.kernel.org
X-Gm-Message-State: AFq9FYJE+GBV0vBeNc4HxggOg5t+19X3LfPXuK4DnzigS28yysLwvtBg
	itxpWgPfUlg1tEqgws+8PCTKNibexJ75hxQzr9wmLCaI8hOdBnKlmmzaZsoZHtM9wCvELfB2zES
	8CHzLNjnZU0NnH5cJrIO88W3bBB4qX29lEyENRw1m
X-Gm-Gg: AYBFou0thOeYu5lzB6sguSO2szOdJQ+vgORANEU/Cnyr3leWVUp9g9/yOsgNAR9b5jA
	bh3webUq2GJ/v/xV/3zWnLn6PCLwFIL0pe8L0wX2Q89Hn2+gUtHgwiJlgqkqb8cgBgFFTRUyqGn
	JG8wBvmuittxyqYXaoTtkLsGSmqXrklpboZnhajP88F7nkgEeIpyvFd5vXj6gpAMaS96yreZ5uJ
	qqyyp31p6EikL2Qi2nMgKWCmAhS1kW/iQ9jFvZfiWYvN/HjX9g4DLLaugKnmmXQ1ako5c8L89Q/
	zPi0rr2dS+NkQY8lqsjuVqOtFZPTsu44x1Rltx4Ur+0vmGO+L5tybdGqDqZQ7qjV7ercKoVoJvj
	ThVd+YIwkQw==
X-Received: by 2002:a17:902:e54c:b0:2df:96ca:d7c7 with SMTP id
 d9443c01a7336-2e301dece82mr251145ad.10.1790790297249; Wed, 30 Sep 2026
 10:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com> <20260930-perf_fix_pylint_errors-v2-1-945cd526576b@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-1-945cd526576b@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Sep 2026 10:44:43 -0700
X-Gm-Features: AclHuK8Q8xPg6i3xX-fz2gQbZHAvDFk-QDgWrco9bghsWQtgt8BR2aK1_aiIAF0
Message-ID: <CAP-5=fWco1iTWud2Z19bpBQMgNC1E6TcyZU6unjdZsi7NJgz1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf build: Build the Python extension before
 pylint consumers
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 6:11=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Pylint checks for tests and standalone Python scripts can run before the
> perf Python extension is available. On a clean parallel build, an import
> error can stop make before the extension is built.
>
> Run the script and test pylint checks in separate sub-makes after the
> language bindings are built. Keep their rules in the respective Build
> files so the perf and perf-test C sub-makes can compile concurrently with
> util and the Python extension. An isolated make perf does not need to
> build the extension just for these checks.
>
> Fixes: 8a54784e708b ("perf build: Add pylint build tests")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks Leo! Should we do the same thing for mypy and shellcheck? This
should help overall build performance.

Ian

> ---
>  tools/perf/Build         |  4 +++-
>  tools/perf/Makefile.perf | 15 +++++++++++++++
>  tools/perf/tests/Build   |  4 +++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Build b/tools/perf/Build
> index 8a0b5592a973384deafc5bb5cc7ed0cc91e0257e..09fd88f5aca54118a9b089e9c=
20124e23de77517 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -102,4 +102,6 @@ $(OUTPUT)%.pylint_log: %
>         $(call rule_mkdir)
>         $(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ =
&& false)
>
> -perf-y +=3D $(PYLINT_TEST_LOGS)
> +.PHONY: pylint
> +pylint: $(addprefix $(OUTPUT),$(PYLINT_TEST_LOGS))
> +       @:
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 0102c3468a0b79fb22966d8cbd8fa8525d2ff3ae..0eb4e7c29c400021907d3da71=
6bc4871f0df8d88 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -578,6 +578,7 @@ strip: $(PROGRAMS) $(OUTPUT)perf
>         $(STRIP) $(STRIP_OPTS) $(PROGRAMS) $(OUTPUT)perf
>
>  PERF_IN :=3D $(OUTPUT)perf-in.o
> +
>  export NO_JEVENTS
>
>  build :=3D -f $(srctree)/tools/build/Makefile.build dir=3D. obj
> @@ -633,6 +634,20 @@ $(SCRIPTS) : $(OUTPUT)% : %.sh
>  $(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
>         $(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
>
> +ifdef PYLINT
> +# Run Python checks after the extension is ready, independently of C bui=
lds.
> +all: pylint-perf pylint-tests
> +.PHONY: pylint-perf pylint-tests
> +
> +pylint-perf pylint-tests: | $(LANG_BINDINGS)
> +
> +pylint-perf:
> +       $(Q)$(MAKE) $(build)=3Dperf pylint
> +
> +pylint-tests:
> +       $(Q)$(MAKE) $(build)=3Dperf-test dir=3Dtests pylint
> +endif
> +
>  # These can record PERF_VERSION
>  perf.spec $(SCRIPTS) \
>         : $(OUTPUT)PERF-VERSION-FILE
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 8fecd539012429c0f517d95f145a91137333322b..05c545aac73232a322652a611=
9c3178f39b83145 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -119,4 +119,6 @@ $(OUTPUT)%.pylint_log: %
>         $(call rule_mkdir)
>         $(Q)$(call echo-cmd,test)$(PYLINT) "$<" > $@ || (cat $@ && rm $@ =
&& false)
>
> -perf-test-y +=3D $(PYLINT_TEST_LOGS)
> +.PHONY: pylint
> +pylint: $(addprefix $(OUTPUT)tests/,$(PYLINT_TEST_LOGS))
> +       @:
>
> --
> 2.34.1
>
