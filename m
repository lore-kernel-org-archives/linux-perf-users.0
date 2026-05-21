Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590813EA970
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385857; cv=pass; b=WB95lwgACtpbne5ryWeluf1Hm5nQijC1MG9PkfhmeaEzZwPS2lrtn4lnHM37DWm4vM3UHwnAAuNSss+N5ScW7EbHxyTx57qlV2g1qLf01zw6khKlgfrM2Ii1ghygyrX1H7EMvKhYitWprOhf/ZtntwNv/vsnTOHgRE/nfDJGRcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385857; c=relaxed/simple;
	bh=uZEmKQEPtBiulFq5qAYPUwHEbakFqp23BZT72IvQHOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfXa9n7xsj4Ck0DPGcGv5bKeB+s4YusvU5faIrvUKNelJLoHqOWh8W5RW3T+OhoojdrbyOc0YU4OsrBaBZaAN0yegMyvpq8q+r8bZgt+Le7MMcYoDciWVMHIGvh6Rp+2AqjA7pZsFXchUmBhjDUTPTWpkS9o2MQx5X1qoQNtymo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCxlMUHS; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCxlMUHS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba180a022dso85ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 10:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779385856; cv=none;
        d=google.com; s=arc-20240605;
        b=Yom7sdTvywU2tMl7z0ffygQFzEdEvIvcRwKe/LMEKl7PNw9fHscMECJSiDYMhaCqK2
         aEQsVBOKS1mdXjedsi6rIdBLP226+vl0qxu2OYBmSwG8xQe7PCN7inzowN113wRhJ3FD
         3MYnbsTij5I1JNKt2rnHzUG6ShSTYiekLJV6hlsxJkdVyb0KxfYUtgxq81I5By7hLzHN
         b6H8bUNoevKKgxvzoFOFcvenO5fz1HBbsUd5L/jGoftRlh4qRhWkwP8mEhgGs4LLJsjc
         ndjXcyfXjmB372Jf8anEIE/AEGTdVeCWRl99Scuss85hiekjEVyNZnxAFMx1zEPjUVsf
         SbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=207OftV959LjRYpr372rL5wikkcj8n/uFnR1W8tNHp0=;
        fh=hmpecbPvmRpGuRe7Bn9h9GRmW51UvzyfXdOlpWNA+sA=;
        b=kn3pv1gb3ClSdb4v23DhyyPI/kzV9ZNaLHGV73VqQ1cbhrY9vgXYv7z0Fl0hkcJDBW
         gyywS8R+W8yUs5cKSWrUxYN6QwU5M7XJIQwcrSgxK4WivlcUyhmeTSNha0fQ72tscmT5
         C6ao1Vz4PJh9700PEvvV31EcqdB4IifdTamGuPTvov+jlYAFKnepc+sgq8ViDARPBLhK
         MVLbn64fyU4WnuJGX3wTNpkBb73poq3O2ZwQRNnwXrVEfeflQyahFtwfmYAHkF5G4Rf1
         JwaKzRrltNkFicZOmXjdZmPEfkodRBc1WtDr4owx2cbWxV0slXZ9qQCV8go1lhmaeUxD
         TcXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779385856; x=1779990656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=207OftV959LjRYpr372rL5wikkcj8n/uFnR1W8tNHp0=;
        b=SCxlMUHSAPXlPlkqX/WpGsxAQT5sKPOoUHFBnj82G31PyQIBl7XkRRxt91QB5FY2K0
         9duKw4VdccWEhI3ZpLnMnHxUsgv6Pv0DtbllhfLyvxj5FphzD6g8ZzbFGmqVlIcPr8/k
         SkJaomPAPVuQdUi6gbPKj15xtjA4FUW9h0E4IqccBZ3Yc32pW0zz4XSB2YWrlY5X5v+Y
         c6RcTaU+M4lE3gIJBDsp58NBIqDv8FFa9OCrke7sIshMdNk4xeoAPAfEi6VTaVwA9bw9
         VcidS5/2b7xgbG8+IP0mVDTK20Zthau+peFWPI3qSzstc8wNL+YoJ1mKBf8bxEP/hWkW
         31RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779385856; x=1779990656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=207OftV959LjRYpr372rL5wikkcj8n/uFnR1W8tNHp0=;
        b=d/PmdhnfEVJodbiJNMFSKR3izCrha4yoj5OSSh8v1Q9+it+1ilxqndK9Tlzsw19g6q
         kqNmF+VBazZgxP5toeuF6recdlccw+xicACcThmsvZ04JwkRlBrT5zG/VSrgscF1ZVLQ
         WYmPBms6GkimpvD4uMIbDJEI3LzQQAuyOA/rFIEERwKj6q92tXUbH8i4PGG3+cVOx7xh
         N05FdRzcNKZt8Gv6TWpSmlULVmKlpUJo81sh4DSX4p8xKoKdv0kPW0aRCKnxLQjIGRpc
         94bnrDY7CfAcrYl79YGR3ErUFaLByO7bTEC3x8pOKkI25x8eB2pL+CLnHvyGdwgBm/XE
         TgZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+M70NlTwtS3h+H8kbmLMZSDC4N4XV803VW+LV88SZ59sIR3/3jfOjEKlxd53x02fvGEOvGCfHl+bVchULP+zam@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2S52bPLgW4Ouvv4S56BE8jq5+KrTkpL7OdzZ0Rs6wPvuJ4lk4
	H3x3Iv8ECag/femDt55449LcaqNYEWnwQpdhuE+RTreBgd+RandnWd1lm8ZevJvhyfqHZUzfYMS
	ZWEldRfWJ7xBEMULy9HGufq6BfJPRXTligy5PlquZ
X-Gm-Gg: Acq92OGks3y4E2VZ7OA9p5A9b7YR7TbQkzJTA9tXDP4bA4J7LD6AzrdMhAyp4k+I17N
	e+LDTcbjS7N9o31Ix7a4lrXDWnh091zgrvcfqDwBXKhDSelp0l4tMnfTCxpR8I1rIagRZzgA73e
	jKR5daMwIaBr0AZ/0Y3zA8BeLMYHLcNeqOf7okiZiN942Ddx7isMg0xAa6TyugyuvniQwzTR3Ap
	YmYuQx103InDSKFq0YmoEWJw49Y1hpRCb2OdwgYWfRTDs70MwPKP4/we3yDZios8EF/8BR1znrM
	kD4sm9ObHy5fdPZeg+JPnzKBPs99kZHkbeCS4syfzpTu5q9R
X-Received: by 2002:a17:902:f78f:b0:2bd:6dad:7ccc with SMTP id
 d9443c01a7336-2bea22258d8mr2812855ad.24.1779385855086; Thu, 21 May 2026
 10:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
In-Reply-To: <ag8X7gcDw6jpJsLq@decadent.org.uk>
From: Ian Rogers <irogers@google.com>
Date: Thu, 21 May 2026 10:50:42 -0700
X-Gm-Features: AVHnY4KHqHkaTccso9Ae1JwavhgkDWK8Q23HikysKTcCQJ7I9OB_ihLrUTe10XE
Message-ID: <CAP-5=fUy-hwmD2WXpmzJAE4k3U4WNYEezy3Dh1cVSFw_LPGJzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix out-of-tree build of some tools
To: Ben Hutchings <benh@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 7:57=E2=80=AFAM Ben Hutchings <benh@debian.org> wro=
te:
>
> perf and rtla currently don't fully support out-of-tree builds, as
> they may still create files in their source directory.  This series
> fixes all the instances of this problem that I have found.
>
> Ben.

Thanks for the cleanup! I ran Sashiko locally and it noted that we
should also fix the clean steps to remove these files (I'll copy the
full text below).
Reviewed-by: Ian Rogers <irogers@google.com>

```
commit cf212be834ce6b0df5cccdbc4ad977a917ff8e48
   Author: Ben Hutchings <benh@debian.org>

   perf tools: Put Python egg info in output directory

   Installing the Python extension currently creates an egg-info
   directory in the source tree, preventing a fully out-of-tree build.

   Add the necessary runes to the setup.py comamnd line to relocate the
   egg-info directory in an out-of-tree build.

   > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
   > index fc92d6ceac5b..b9a9bdddb89a 100644
   > --- a/tools/perf/Makefile.perf
   > +++ b/tools/perf/Makefile.perf
   > @@ -905,7 +910,9 @@ install-bin: install-tools install-tests
   >  install: install-bin try-install-man
   >
   >  install-python_ext:
   > -       $(PYTHON_WORD) util/setup.py --quiet install
--root=3D'/$(DESTDIR_SQ)'
   > +       $(PYTHON_WORD) util/setup.py --quiet \
   > +               $(if $(OUTPUT),egg_info --egg-base $(OUTPUT)) \
   > +               install --root=3D'/$(DESTDIR_SQ)'

   This relocates the egg-info directory to the output directory, which
   helps keep the source tree clean. However, does the `python-clean`
   target need to be updated to clean up this directory?

   Currently, `python-clean` is defined as:

   python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r
$(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so

   Should we also clean `$(OUTPUT)/perf.egg-info` (or `perf.egg-info` for
   in-tree builds) to ensure `make clean` removes all generated python
   metadata? For example:

   python-clean :=3D $(call QUIET_CLEAN, python) \
                   $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so \
                   $(OUTPUT)perf.egg-info perf.egg-info

   commit dd754ea75966ec7ade41500afeb32d944f20a8f9
   Author: Ben Hutchings <benh@debian.org>

   perf tools: Put Python bytecode in output directory

   The PMU events are processed into C sources by Python scripts,
which
   normally results in writing bytecode for each module into the
source
   tree.  This prevents a fully out-of-tree build.

   To fix this, set $PYTHONPYCACHEPREFIX to relocate the bytecode cache
   directory in an out-of-tree build.

   > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
   > index fc92d6ceac5b..b9a9bdddb89a 100644
   > --- a/tools/perf/Makefile.perf
   > +++ b/tools/perf/Makefile.perf
   > @@ -400,6 +400,11 @@ PYTHON_EXTBUILD_LIB :=3D
$(PYTHON_EXTBUILD)lib/
   >  PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
   >  export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
   >
   > +# Put Python bytecode in output directory
   > +ifdef OUTPUT
   > +export PYTHONPYCACHEPREFIX :=3D $(OUTPUT)/__pycache__
   > +endif
   > +
   >  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r
$(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so

   Similar to the egg-info relocation, does `python-clean` need to
clean up
   the relocated `__pycache__` directory under `$(OUTPUT)`?

   If `PYTHONPYCACHEPREFIX` is exported to `$(OUTPUT)/__pycache__`, running
   `make clean` currently leaves this directory behind. Should we add it to
   the `RM` list in `python-clean`? For example:

   python-clean :=3D $(call QUIET_CLEAN, python) \
                   $(RM) -r $(PYTHON_EXTBUILD)
$(OUTPUT)python/perf*.so \
                   $(if $(OUTPUT),$(OUTPUT)/__pycache__)
```

Thanks,
Ian

> Ben Hutchings (3):
>   rtla: Fix output files in source tree
>   perf tools: Put Python egg info in output directory
>   perf tools: Put Python bytecode in output directory
>
>  tools/perf/Makefile.perf            |  9 ++++++++-
>  tools/tracing/rtla/Makefile         | 31 ++++++++++++++++++-----------
>  tools/tracing/rtla/tests/timerlat.t |  4 ++--
>  3 files changed, 29 insertions(+), 15 deletions(-)
>
