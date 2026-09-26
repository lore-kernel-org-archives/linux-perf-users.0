Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0454707A
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382193; cv=pass; b=g/SEuMIE6oxK6jnhDQFU8rmIkYA4ADSxQ5tyD7jqtXTLXhPyh+L+uFj0MrJ0z24lhJXHeKkNwZdSKrkIgWDFJ7PVvZvvyVKIuvVohclv5usnxiP/DyRFXlZGxmHOQl1d8q60K5Fu5IlEgoC9Hfsxl8xkBGBrFLayZrRxQTdxOz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382193; c=relaxed/simple;
	bh=s8QtNQAMIgIYUNQvXa+HdkZoVDS3z4Jc8WjRM/ok0kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gk40hvIiBrNgxjmj6FpLKkexJrJEtavimF8BgIsEM5FcJWuzH74LNpL7ySbhi/yUpOtDSPga/JI3to3ybNPDsxDO/AjQXF0eXVhpxZJIVvwPBPy218XVz2iMSQLJoMLcnhcmIjsPhxD0pFHNYZGxvmJx0/I2nRD/kRTJFn+htNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLSfpvcE; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLSfpvcE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53328262efbso2771cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 17:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790382191; cv=none;
        d=google.com; s=arc-20260327;
        b=ZetP2ZxHAU90Ua6+Dqu0/IDtoA1in9B0RZpM+7eOUYaypEfcmZqSj4brpH4I83bvt2
         FsBaffLYR/b5L5yQEZ0ZzNPLMLiA4VdLpQbqIJLOIn5wuHZHIhg22gVA7MdIx+k3gj/c
         wlDwpFB/6XEqtshbPKl/X3dnKwkXVFhl2oITONfIteaFRPgFm3GcNmZtlxhofeJr8Ait
         K1cYWM5x4aV58nc+PljyvTmSND5Sf6SEFJo5uoUqr/NlozoCbI4N4LvXCg5axKLLahkc
         BToCE2ND+jXd8bryvXtSb8xL/HhcE8Q/xYAFXARmoo9VGQ0KRwZ7JPTtCOU2lHtBX9wG
         fUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5vxdRphH3ondCoOrshI+pY0NPSCZ+h+CapfRN7m2+ak=;
        fh=P9hp7QXCirxtRY7SL8dZbiqf/8/ZvpPjGCC0pyD9yE4=;
        b=oaDWLqMh9vVGDNy1493PFmGRsC0mTwnVgursnpUZia7DiY3GCU5JBQ7iJ+9O7oJ13r
         M7BbYMhPvBv2bW40uuWo7nc3aLm6TlRASB+2cSFh0NOzpz/PYIwDjzmDn+RLYXfeBhmR
         Z01L95HS2Myx0aagLILs7wDeYW0VfpSRzJXSS3+gyq6qGXmRf4WD9Gh4/Ox2SRS87rCH
         6tprOBbVWqikqsOCHeoSsEjlVVwPpX1//QNmm3OTyK7aMD8td3teti0xQqLgv4VsPSp2
         mhqgAfIpULNs9PChnByk5TOFba41fuXZogh1XiCdZhMBBGyPUi0EJprefhXTRQZJ0XGg
         kVqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790382191; x=1790986991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vxdRphH3ondCoOrshI+pY0NPSCZ+h+CapfRN7m2+ak=;
        b=YLSfpvcEcqHyKdtGFQe8+S4ryepXocep6omll6/vrgdcGPUrxeBe8PnRsGX5aYTotV
         6axAy7evn6QmiJuQfSTydcqHKCjmwEqxyXIwvbyout/4KEMl05iDwbfE+BSuN+DhENug
         0VhL87RuKVKAr04adwOmkFrFqO1kdArGHF8QDX8DqL0dAQyP99YK/P6TlGvlsqQri2AQ
         RucGcJcOES6JJG36gzFl6VlYxUQYWZS/yAq9EUEfHI96BUcp3DeqUd32eEyGSzChaVi7
         gCT3a0RR240+ubLrYQQ/H4CbFRiPAiXarxDO2oMs9JstP4Q6qOq12TmwT8STO8r6hdIH
         rOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790382191; x=1790986991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vxdRphH3ondCoOrshI+pY0NPSCZ+h+CapfRN7m2+ak=;
        b=vyy09IK2hdPimKgPPIsmMPUKpRYYPKPLFjkB05zN13nXLAaX8ZFMSIe1CWklFaAYTJ
         u5gIKiJXClSymyAe0P6m2T1qHjYEjciHmhDPcFwAwFqVD4XJRElS12RYnH/e3JyMxH1a
         6Ui6WLz4gIVEpwnek1YEAA7sTF/eXT/fro/3EePKwTVHMoMwG6w6tcDnTlnBOsD0bbEB
         Zbg6ieKoMSJvVu5KXLv+5ZfxG5HE0VDqZUqZogtkmwr/LZP2g4WcXNlGHW8KsEykBblY
         gzsSQaJ+lscPaxCxzFEK8w8pQ8igLLNO9gYxRGcFpj+UPmjQxORLFmvblZ3exFM2cryH
         OIaA==
X-Forwarded-Encrypted: i=1; AKwUvBxyuASb0k/6n7G4FV3Es0htMRu0MpzN0VZdTD1J/mB2QViNlwQR8djlzqA8MKNrTXxeb8fkgusIV5jnJaQ2pxB8@vger.kernel.org
X-Gm-Message-State: AFuF++m8LHt38B+9JBv1/IY/Nbv4WLZbIsCpED2cuSbPnas/glYO8EwX
	3emA2mSdbetAhiKEc4IveW6R5lutHVEi1Wq1nBIRNWspFSMA2tuNsD2U/ItIjk2ooogmW6QBnRE
	5RrY6AupztB4V8STW7yWo4qF7mZAkvful+PI40ROK
X-Gm-Gg: AYBFou2xB4m7u09a3i11qjLjYlDwj3QpX5FC9LxcsboNKv4OAH71LRy5Z1Dx0jFuEig
	rWmSCX0L8bsrEJlx3MAoUeIzgj8HU9j0G0T4Msvv3PnW4bE6wFChG+5gPYyB/vQ4QukdHms+8S/
	CUuNzVHfMqp5As8mXZCKdpjNze3TJXgWSZhuhvSmJWbMcM5S2DL3+00/+rB4WTc4NAKciR9w5y6
	tAh99KwJwNzk6C8mOESzgjBWktOk9U9Ek5oOThrRNIc1hh/O67NdQGUkW3oHRG9gqCwoaAoMj9q
	t/DgP31A8EGjBVfmLN/L9LfFgVp7rCUBNpyb/W2KrK1FnA9elXBjWvM=
X-Received: by 2002:ac8:5c95:0:b0:532:eff9:ca08 with SMTP id
 d75a77b69052e-53320176517mr2292231cf.12.1790382190226; Fri, 25 Sep 2026
 17:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arb9OMEQ8HCcw-9O@x2>
In-Reply-To: <arb9OMEQ8HCcw-9O@x2>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 17:22:58 -0700
X-Gm-Features: AclHuK8SuyjkasmI9lR5pJb6iJhVqre7T0KJavtfm9es-BYdBkoaqvOxxW2bfWs
Message-ID: <CAP-5=fX6+M8fKmSTzCy5HufEQf422h0vavTTb_RX3HYRYo8nfw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tools: Bump the minimum Python version to 3.9
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 4:01=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> perf's build only refused interpreters older than 3.6, the check added
> when jevents.py started using f-strings, and jevents.py carried a
> removesuffix() shim to stay usable on them.
>
> The kernel itself requires Python 3.9.x since 5e25b972a22be224 ("docs:
> changes: update Python minimal version"), so tools in the tree are
> expected to work with it, and staying compatible with older
> interpreters stopped paying off:
>
>  - the PEP 585 generics, list[...], used by the type annotations in
>    jevents.py and util/setup.py are only subscriptable from Python 3.9
>    and, being evaluated at import or definition time, they break the
>    build on RHEL 8's python3.6.8 with:
>
>    TypeError: 'type' object is not subscriptable
>
>  - ProcessPoolExecutor(initializer=3D, initargs=3D) requires Python 3.7, =
so
>    generating pmu-events.c fails there as well.
>
> Rather than spreading version guards and typing.List() workarounds for
> interpreters that cannot be supported anyway, make 3.9 the floor: check
> for it in Makefile.config, where the jevents generation check already
> lives, and drop the removesuffix() shim, since str.removesuffix() was
> added in 3.9.
>
> RHEL 8 is in feature freeze, so those wanting a new perf and its python
> features have to vendor a newer interpreter, just as
> Documentation/process/changes.rst already asks for the kernel itself.
>
> Tested with Python 3.9.22: perf builds, generating pmu-events.c and the
> python binding, with byte for byte identical output to the build made
> with the shim, while Python 3.8.20 and 3.6.15 are rejected with the
> "older than 3.9" error. vermin reports no perf build file as requiring
> more than 3.9, the only offender being the runtime script
> scripts/python/mem-phys-addr.py, which the build doesn't run.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/Makefile.config       |  8 +++++---
>  tools/perf/pmu-events/jevents.py | 16 +++-------------
>  2 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b288ae0191acf7ef..92ac7c620b3ccd49 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -885,10 +885,12 @@ ifneq ($(NO_JEVENTS),1)
>    ifndef PYTHON
>      $(error ERROR: No python interpreter needed for jevents generation. =
Install python or build with NO_JEVENTS=3D1.)
>    else
> -    # jevents.py uses f-strings present in Python 3.6 released in Dec. 2=
016.
> -    JEVENTS_PYTHON_GOOD :=3D $(shell $(PYTHON) -c 'import sys;print("1" =
if(sys.version_info.major >=3D 3 and sys.version_info.minor >=3D 6) else "0=
")' 2> /dev/null)
> +    # Minimum Python version, the same one the kernel requires, see
> +    # Documentation/process/changes.rst: jevents.py needs PEP 585 generi=
cs,
> +    # list[...] and friends, that are subscriptable from Python 3.9.
> +    JEVENTS_PYTHON_GOOD :=3D $(shell $(PYTHON) -c 'import sys;print("1" =
if sys.version_info >=3D (3, 9) else "0")' 2> /dev/null)
>      ifneq ($(JEVENTS_PYTHON_GOOD), 1)
> -      $(error ERROR: Python interpreter needed for jevents generation to=
o old (older than 3.6). Install a newer python or build with NO_JEVENTS=3D1=
.)
> +      $(error ERROR: Python interpreter needed for jevents generation to=
o old (older than 3.9). Install a newer python or build with NO_JEVENTS=3D1=
.)
>      endif
>    endif
>  endif
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 074daae5308b110b..296bf68d10810952 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -65,15 +65,6 @@ _json_metric_attributes =3D [
>  _json_enum_attributes =3D ['aggr_mode', 'deprecated', 'event_grouping', =
'perpkg',
>                           'default_show_events']
>
> -def removesuffix(s: str, suffix: str) -> str:
> -  """Remove the suffix from a string
> -
> -  The removesuffix function is added to str in Python 3.9. We aim for 3.=
6
> -  compatibility and so provide our own function here.
> -  """
> -  return s[0:-len(suffix)] if s.endswith(suffix) else s
> -
> -
>  def file_name_to_table_name(prefix: str, parents: Sequence[str],
>                              dirname: str) -> str:
>    """Generate a C table name from directory names."""
> @@ -214,9 +205,8 @@ class JsonEvent:
>        """Fix formatting issue for the desc string."""
>        if s is None:
>          return None
> -      return removesuffix(removesuffix(removesuffix(s, '.  '),
> -                                       '. '), '.').replace('\n', '\\n').=
replace(
> -                                           '\"', '\\"').replace('\r', '\=
\r')
> +      return s.removesuffix('.  ').removesuffix('. ').removesuffix('.').=
replace(
> +          '\n', '\\n').replace('\"', '\\"').replace('\r', '\\r')
>
>      def convert_aggr_mode(aggr_mode: Optional[str]) -> Optional[str]:
>        """Returns the aggr_mode_class enum value associated with the JSON=
 string."""
> @@ -641,7 +631,7 @@ static const struct pmu_table_entry {_pending_metrics=
_tblname}[] =3D {{
>  def get_topic(topic: str) -> str:
>    if topic.endswith('metrics.json'):
>      return 'metrics'
> -  return removesuffix(topic, '.json').replace('-', ' ')
> +  return topic.removesuffix('.json').replace('-', ' ')
>
>  def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> No=
ne:
>    if item.is_dir():
> --
> 2.55.0
>
