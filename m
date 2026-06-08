Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2D32B124
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935350; cv=pass; b=fAcB4/z40uu8EDga9XQKpP/hPizTizxg4Bqi9oaEp0/5mYIe+1+/+IbmELIN02THSuNO6L0R0h3rvJLxgNdU3/q2KkPtWG8+AmjSclCkETKyBL/LZ+OmEFRxzBlYBUzJFevt9c2FU/5fxEgLXi8YBj3Aw4t8PR6TxaAui7O9p8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935350; c=relaxed/simple;
	bh=UfyccPz7XMaFuqfX9CsxoNeHVO5PDqRYrMV6AX7Nuyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqXF+cQx4WWCasRv1s8dZ4cuJZv4MU2XccClpCT4V8nd0Gvp82BTZI0UBUT3zFWEBPPWmKHHWlX39DYvDwTLTL+Cu0Dc+h2+frntKRF6JUz/Do/g8sw9VQulo0fLLReBq2vbe3S+rfcQmGGhZaQnD7VR8hwMU/QVho77OElIpj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HFXHpy1w; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFXHpy1w"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2911f93cso326455ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 09:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935348; cv=none;
        d=google.com; s=arc-20240605;
        b=NSUVy22Z8WvH4BccIH1Svq4z4Df6H2b22CKdl+vyzjNURGCgkxnH7jYavJnbQHpARR
         idzlYd51nXUyzBn2cnm0UubztuCgCcEC9vh56t7OSYJVcWtFQ+7hqt0/33I0+U6+OFvF
         NJCtP8EWtycJlAr9LuXjdQ5HggZajzl1TL/z8Dcw9+CYijhJ9j9SkuV17s5X6F2/oRT5
         1sCqdX4ida0EECAVsu6g1+u+Ae/6RS5Ah1lAhb//wmPcgfAZHrCN/W62wxTcDF+SWSDg
         0gNnnj5KZVsJZgGPViO0bOHDRVBGI2L1TePF/V41ejzZ9f8qy8lqglh0Av6xI34OTiAl
         L0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VPuAE9xevULx2C5ubYrY88u35Y1rp22kBvo0VCdY6OU=;
        fh=Esvb5p3RQUzEZeaIcvXWNLTe+uRJ67Mge2YxhjskyJI=;
        b=lveKuiwa7Uou0PglTj51L9TwESgfqPyO+hzw2+W5tpJ3wqK4cliJxtbclB+XbPHSkR
         3sSoC6+5/zXlBXoKhlssFQ7iDAgsXq4u07K9SV8guqZ1A3WitUSgUISiwlOGckjLorcb
         /tEFB0ESMVoEHUSiW49UpozjFxzTeeTiQcc8FDMU8LkAGhE+sm4q9LrZRII38qSSGJCD
         hWOhkriGoM3YG5mM4pRuLFOQ0aVI96pEL8KqwRLm7lXICKiMTj/C8CtinVwLv1iSYUuZ
         kSfzNhD5CIYWqhotEPtxdPvySbduJ1ivRNuDsqOyXnbjJ8pmOmJ+hE/m6/OYytm9EJQD
         mifw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780935348; x=1781540148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPuAE9xevULx2C5ubYrY88u35Y1rp22kBvo0VCdY6OU=;
        b=HFXHpy1wO69/KRUlYXyGqYNr91ByiBVDs1gCT7d5RMzOrRE/v6428srmx4Qk1my2ik
         zEFctgGzPhHGPbPh0yOnmM4nJBlo0yEGSUEmRNegRcNvaqVpyRjp/zIt9KFAvXwzKGzJ
         y+43RdB5UlnggI7bOhcI25fjnS6amxfe0PP6ZjyjEErbH/ExPeJ6M6cDGC6/fFW9Q2vM
         1+7hwxcP5H39VHe9FRQLcmv7dsjsrQbK8G+YfSZGF4/ljmm9Dr2sg7wsBLO2s5tbjHy6
         GeQ0KJc+MHkM/cVSCE7p0mViS7BXa7upo/FDQtuelhWpR69Hee5vP7kva34YfFzKkp2I
         jc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935348; x=1781540148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VPuAE9xevULx2C5ubYrY88u35Y1rp22kBvo0VCdY6OU=;
        b=ZaEEkEY1VUVHQGGukUsyXjnJvbnAZQDvIYS7IKIzb7vUzxmoVN+/yDXc/xv6vK49U0
         NQPEV0c4tJS8Ok3TaqNRZGVhZgfiC7OsW0IkJS13SY8zrf6D8UbtBpDuIReVaoMKjzWF
         GUs2CRKx3xPb6k4+RhuYOHNYF9JPZsBKlWw6U1Kx+cPDgBDlcgt12skvmvonp6co09+e
         TupNq9txN0w/wPnmu+X+g0+giInUfRzmz+1kqOqj0twBs/wxb14soa4R50S/FbjDk3f8
         SetaC437Y6CNAcy+NGWt1C0PHE9gpD3WwymQ6oda2THk/eP3TuiBW4DlsgqRJ/pVTtpl
         8Uww==
X-Forwarded-Encrypted: i=1; AFNElJ9aO2wlvQr/1IOh3UUGjmmVYQqbC2QpeniCRGGjyd8glszdGCUzXZUke/YNL8xEoLHLOvJ7TOwlxeZj6rvoQHmY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jX/sq11qNJbF6q/8dNGp/U33NGscSj406kjgzPcO4kdtjmma
	otxA4ZFGuqBPtMHhXu4TUpwhIvcnVQaPgnc4li6/4B7nu7P3fltWXKNMR674ovqD+ALMKvtdd6J
	mUQb+40uvQdweCg5/MK5j2qF9W/ZwwxW40fC4ZFcK
X-Gm-Gg: Acq92OEkf1Y7y4mSxPG9lsRH3d1jQfV2K1Bqs4uGIY/MxEfLt1twhRhc7HNZIkx6bzM
	n491ZEFPIyk9putUwcDWy3HcPjagARzLPSzUvIMjph2u3/CIj8I1b3nllssNmjN7XV0WIvSKu+H
	T9jKKMDWJl3qiSD6XXCDYaZsTZ88mHa8fntc8j0202jjzqXQeFPORUhOiGLATPHgdx/vXtR05oj
	TMT9Z+gxjvHFpYIOeYCajefsidzX18/yxoPNx12Z/E0q2mcMf4uVUiG9QzE/uFjEZ7mZ2BGpdBy
	fnQOso+6qOBMxCujKtr/KxMVpr31Ral+2GTbzVBdvUIfei4=
X-Received: by 2002:a17:903:2443:b0:2bf:3741:5b76 with SMTP id
 d9443c01a7336-2c1eaeabb39mr5355455ad.3.1780935348034; Mon, 08 Jun 2026
 09:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608160613.3153795-1-jremus@linux.ibm.com>
In-Reply-To: <20260608160613.3153795-1-jremus@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 09:15:36 -0700
X-Gm-Features: AVVi8CdytsE0TQnaskL17Ae0TWXhEEH9L-yb9YiJo2zMpDQFcF7_C_uMnsAviNc
Message-ID: <CAP-5=fVWuGKVT+g7RVkQy3zYYWVnHs7Ar76e+-RCJe0ZoZVsug@mail.gmail.com>
Subject: Re: [PATCH v2] perf build: Respect V=1 for Python extension builds
To: Jens Remus <jremus@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jan Polensky <japo@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:06=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> wr=
ote:
>
> Make util/setup.py respect the verbose build flag (V=3D1) by conditionall=
y
> passing --quiet only when not in verbose mode.
>
> This eases debugging of Python extension compilation issues and aligns
> with the existing perf build system behavior.
>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>
> Notes (jremus):
>     This patch applies on top of the perf-tools-next tree:
>
>       git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git  master
>
>     Changes in v2:
>     - Rebase on perf-tools-next tree. (Ian)
>     - Use descriptive variable name python_setup_quiet. (Ian)
>
>  tools/perf/Makefile.perf | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 76b35ac19acb..137fc4386625 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -401,6 +401,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>
>  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so
>
> +ifneq ($(quiet),)
> +python_setup_quiet=3D--quiet
> +endif
> +
>  # Use the detected configuration
>  -include $(OUTPUT).config-detected
>
> @@ -752,7 +756,7 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/=
python.c util/setup.py $(PE
>         $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
>          CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
>           $(PYTHON_WORD) util/setup.py \
> -         --quiet build_ext; \
> +         $(python_setup_quiet) build_ext; \
>         cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
>
>  python_perf_target:
> @@ -1158,7 +1162,7 @@ install-bin: install-tools install-tests
>  install: install-bin try-install-man
>
>  install-python_ext:
> -       $(PYTHON_WORD) util/setup.py --quiet install --root=3D'/$(DESTDIR=
_SQ)'
> +       $(PYTHON_WORD) util/setup.py $(python_setup_quiet) install --root=
=3D'/$(DESTDIR_SQ)'
>
>  # 'make install-doc' should call 'make -C Documentation install'
>  $(INSTALL_DOC_TARGETS):
> --
> 2.53.0
>
