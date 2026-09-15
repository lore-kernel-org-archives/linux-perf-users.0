Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B238734A
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513726; cv=pass; b=h9jMDF3eLO68Qq6gIEW00GSGQhaZX4+nRoDqaRu+gU6NHruFTW7iuXuSi1Nmu32c1/RYKlmdy6wrFvPerJb/UUh8PIYhRhjYaxy3glWQLUwoKW5TEtLDYddsedAMIZaDBPkBbEJMqkJARvjjvVJD4qPxdpaSKgrLyMDFMeOVvq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513726; c=relaxed/simple;
	bh=KOUhTSeaiK/3e6yS6I0ed3hBCbUzC9LUyLBATohlb9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIRCAbGdj0gklCsFgvQQS0r3iPBCjVmNdiNozzE08uxGipUPFklIUBJixW8/BP/NXSxL6n4wB0aAGu4rDSAbKKRixHTqRzZYwVqRhxe8J7EDsoBHoc5G8VcKiEHZPZucGU0zJqzQvXwuTSSDHvvadslxft8JNBdloC7XXoXqt6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0s2XEK+; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0s2XEK+"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so54411cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 16:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789513723; cv=none;
        d=google.com; s=arc-20260327;
        b=XDIiMt6RKsVqqgc1J0i8EW+CJmv9xuwefaVUMsj8UtNWCj5fGFksWj/zzIjhU82aoH
         vT+gVr97oy9maPqsFeoL6tzWtvlHCTfdgUPllq/qBI30j64AykxEqcbtJRZOohGAEjN9
         Y2LTJZJJfOAtF4AYk7IUsfCcZ6i129Eln40vubMdmfaJEuNgwQ+V07XkUlqoxhcr3eP7
         oM2ZOPMCP2TKbZ1bL+rWOZ0FC0SpzAliMdqKEsi5/HJhzptI8JnReqeN6XMyoZIk1noq
         NEjf08XGxObusLDFv+63NWAhImLHmExzNRT74LqwPL8EQeLXvbXb79VaTzQbIaRnc+Cz
         W4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nXZV/vndv5wPvyFjhGHkBqgl7hDd9VEPk7jLPc3L5VU=;
        fh=i9k2xsml9N7skd4fFS35KekNaRFrXofnIKwePsHWM3A=;
        b=PzA4eAuXNsnNLb6WDYVEZHZPLC9OmXPSzKWDjSoommBUx3XKn+askjGAVG3GZ8+vvF
         xI4iFXNuX9oYcuyYTogWgvQcUxeSUaLk1qJuZNuw/P53hAI+yI3utDCxhJzpoSrAlUqz
         PpO2zwfTAAgFWHbwwawDJmPn+eeMcW5XnqiYNs4WffPUxlFJFtL8ZE33vlC9rihEobAr
         zBsws0MpHtI59339K+KoIFVef3R3r/g1VOLj2vbmlOXk9F5M09mtiAWRLjRViTZKwt9L
         ztKGyPuzrhFwIbZ9S9lo+QvWw0cacjfGYZzFjYcb/hZ/JLxtSFxRE1NLYjKD0pvN6PoI
         e6GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789513723; x=1790118523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nXZV/vndv5wPvyFjhGHkBqgl7hDd9VEPk7jLPc3L5VU=;
        b=A0s2XEK+7KdvH5wcbwooIEbSebOF0PeBe5dHI8wKa8yc7l6MV7GFRDy9KQsfAwtVm4
         /XVSkEsNGBF9wTC/oq7MYAkdWSCfa8QvBJq0Wiz/lz3R8vbMArX2mp2Va2jYlOnm6y15
         HhHiheRLhskEzroVyyyRO6Na6SERLaZpgScAOz/IK27qdrzO5M9O9tGvGvy2PjGQ4q6N
         qc/RDCYNKrhmk7fzxWfo9vZT8R5MwenTpCO114olNdg3yiyllblxtMpeP4mCtX6zrxS1
         N/Pk3887QDDO+SZoPWcMeRGmwG0KJozQNWAeeoAJ1LdSL5hIIgIg7HEATmpL9dSdxrpd
         RfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513723; x=1790118523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nXZV/vndv5wPvyFjhGHkBqgl7hDd9VEPk7jLPc3L5VU=;
        b=hNR3Nh1SDgoCMSm0jv+om8afXlFYU434JwPZuV4OgeQGIjIIljAVkUHby87nLg7h92
         KBfWdTvbJV1sft0f+u6XMTkOsITxDDxPxvZnqyX5gynJEr8lzciBsr/dMn2BlJjXq4SP
         YhVNAS8eUPK9n/TUJ8m/NYQNyu5j5JXzh+9+74ERdJl1Pwogg/VdJ+R6BQnFAV8zeSjo
         vhYs3p2mwTyMnsw9VTAdcv0IxF3qWGJepUP9wcbFflryZT3wp52SYHhZe9riCBqc9rD4
         66ngxNJDO8Cey0AQUK7ltY15xmk39VJB/IbYImw2odywYOIAjeM2Xd3M7BPeAaKhTJVk
         +RHg==
X-Forwarded-Encrypted: i=1; AKwUvBxWsQ9hjLa0L+eguL7o/zsuStKOPQ4QJFaqQgS9pR0yGf8qPxMKQ706U2Z09U1kfV0SwYyepffv0sUgmJfyudht@vger.kernel.org
X-Gm-Message-State: AFuF++kYSxzl4yA+PDjvzoSVsuf8TxpqGDtnlQvHzJSBF4WD9DADVUL3
	Au5wC/CHlljtHSoifMd78UHlew9ZsJHrAF7XQxFSf9qxqwq15flT7pOJs6IhcoTCm5Be6UfhSER
	bez8f34C+HjO/ZlIuY/8YOBfuY/9l4lWokMLe2ukz
X-Gm-Gg: AYBFou2AyEPk3iD6NFQTsgc3UhA4dWdRdZyC9umStSZ9orshNFna7Px7EzgKfl9rhdE
	4I+uC9WE2ehcpCfTRJqQf9SOm+QKw1xCY3yyXOzgO3nYl99oEWjuzCZk2Sk6Xb7sUynFyZ9JsdC
	rQfXUZGs80O/guckEfdjSMnHJ/janGnNDCaqwpsQgXxpXZWJknikzg1MNVVgsavu13iuRwe1eHM
	q69FFDNYzWL0Rc8LS3F/UNG6rh8bU5sgP98tABBZSzJMm6EI7Fw9oKRmYwuf8SEPMtmyorpk4v2
	S+BWDMgkeboSpgT4cfA9ijbzfjYEbKx86HI7hWSBxd3jlvJSYfmNQ/Y=
X-Received: by 2002:ac8:7f09:0:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-5327f53205emr1735971cf.1.1789513722780; Tue, 15 Sep 2026
 16:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk> <CAP-5=fUy-hwmD2WXpmzJAE4k3U4WNYEezy3Dh1cVSFw_LPGJzw@mail.gmail.com>
In-Reply-To: <CAP-5=fUy-hwmD2WXpmzJAE4k3U4WNYEezy3Dh1cVSFw_LPGJzw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 16:08:31 -0700
X-Gm-Features: AcwNN1Wtp8dOgchZJHXl0So7z-gIbgSPFpF-r8lmQRpUWSedho2akDrRnSm_CxI
Message-ID: <CAP-5=fVJbFrR-uUWTSkx_CHqxagKWhbshWxQ2YD-_QANtUDdqw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix out-of-tree build of some tools
To: Ben Hutchings <benh@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:50=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, May 21, 2026 at 7:57=E2=80=AFAM Ben Hutchings <benh@debian.org> w=
rote:
> >
> > perf and rtla currently don't fully support out-of-tree builds, as
> > they may still create files in their source directory.  This series
> > fixes all the instances of this problem that I have found.
> >
> > Ben.
>
> Thanks for the cleanup! I ran Sashiko locally and it noted that we
> should also fix the clean steps to remove these files (I'll copy the
> full text below).
> Reviewed-by: Ian Rogers <irogers@google.com>

Hi Ben,

Did you make any progress on this? Checking upstream I don't see the
patches as landed and they look useful.

Thanks,
Ian


> ```
> commit cf212be834ce6b0df5cccdbc4ad977a917ff8e48
>    Author: Ben Hutchings <benh@debian.org>
>
>    perf tools: Put Python egg info in output directory
>
>    Installing the Python extension currently creates an egg-info
>    directory in the source tree, preventing a fully out-of-tree build.
>
>    Add the necessary runes to the setup.py comamnd line to relocate the
>    egg-info directory in an out-of-tree build.
>
>    > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>    > index fc92d6ceac5b..b9a9bdddb89a 100644
>    > --- a/tools/perf/Makefile.perf
>    > +++ b/tools/perf/Makefile.perf
>    > @@ -905,7 +910,9 @@ install-bin: install-tools install-tests
>    >  install: install-bin try-install-man
>    >
>    >  install-python_ext:
>    > -       $(PYTHON_WORD) util/setup.py --quiet install
> --root=3D'/$(DESTDIR_SQ)'
>    > +       $(PYTHON_WORD) util/setup.py --quiet \
>    > +               $(if $(OUTPUT),egg_info --egg-base $(OUTPUT)) \
>    > +               install --root=3D'/$(DESTDIR_SQ)'
>
>    This relocates the egg-info directory to the output directory, which
>    helps keep the source tree clean. However, does the `python-clean`
>    target need to be updated to clean up this directory?
>
>    Currently, `python-clean` is defined as:
>
>    python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r
> $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
>
>    Should we also clean `$(OUTPUT)/perf.egg-info` (or `perf.egg-info` for
>    in-tree builds) to ensure `make clean` removes all generated python
>    metadata? For example:
>
>    python-clean :=3D $(call QUIET_CLEAN, python) \
>                    $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so \
>                    $(OUTPUT)perf.egg-info perf.egg-info
>
>    commit dd754ea75966ec7ade41500afeb32d944f20a8f9
>    Author: Ben Hutchings <benh@debian.org>
>
>    perf tools: Put Python bytecode in output directory
>
>    The PMU events are processed into C sources by Python scripts,
> which
>    normally results in writing bytecode for each module into the
> source
>    tree.  This prevents a fully out-of-tree build.
>
>    To fix this, set $PYTHONPYCACHEPREFIX to relocate the bytecode cache
>    directory in an out-of-tree build.
>
>    > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>    > index fc92d6ceac5b..b9a9bdddb89a 100644
>    > --- a/tools/perf/Makefile.perf
>    > +++ b/tools/perf/Makefile.perf
>    > @@ -400,6 +400,11 @@ PYTHON_EXTBUILD_LIB :=3D
> $(PYTHON_EXTBUILD)lib/
>    >  PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
>    >  export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>    >
>    > +# Put Python bytecode in output directory
>    > +ifdef OUTPUT
>    > +export PYTHONPYCACHEPREFIX :=3D $(OUTPUT)/__pycache__
>    > +endif
>    > +
>    >  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r
> $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
>
>    Similar to the egg-info relocation, does `python-clean` need to
> clean up
>    the relocated `__pycache__` directory under `$(OUTPUT)`?
>
>    If `PYTHONPYCACHEPREFIX` is exported to `$(OUTPUT)/__pycache__`, runni=
ng
>    `make clean` currently leaves this directory behind. Should we add it =
to
>    the `RM` list in `python-clean`? For example:
>
>    python-clean :=3D $(call QUIET_CLEAN, python) \
>                    $(RM) -r $(PYTHON_EXTBUILD)
> $(OUTPUT)python/perf*.so \
>                    $(if $(OUTPUT),$(OUTPUT)/__pycache__)
> ```
>
> Thanks,
> Ian
>
> > Ben Hutchings (3):
> >   rtla: Fix output files in source tree
> >   perf tools: Put Python egg info in output directory
> >   perf tools: Put Python bytecode in output directory
> >
> >  tools/perf/Makefile.perf            |  9 ++++++++-
> >  tools/tracing/rtla/Makefile         | 31 ++++++++++++++++++-----------
> >  tools/tracing/rtla/tests/timerlat.t |  4 ++--
> >  3 files changed, 29 insertions(+), 15 deletions(-)
> >
