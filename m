Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD68391842
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238239; cv=pass; b=aWeuf85oZu7FpxkDQavYwUgaI27X3T86lONGOjWtHeSpHcrN94oPXtDdSSi34M1aNzLfAlATdkbAJVs3Jzz22q/nDCO+q85yZgEz5F6FHZY9vXNqVQXAcl8pVPYGPgTLoEVquGT2IUlegXoS7sHfOywkGJEpH2eP2kqRf94KpJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238239; c=relaxed/simple;
	bh=gtEtA/1bnlJadumPvs7pL49nsw17aLwbOXX60YN3LT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYEn5qcTgelVjgTkGwDWSbb31FhpJx62dHFaKReBMpNWwUP1pavrizXlFMXcPiQ6RcwpBp5Be7U50vQUCt0xgUGiA9srx5ea2LQTPOD42NqrXwjBMBWPHx8TOpq48M+W8TLlqErc7Gvs2T7UCbNRubt7mT4u3D0B85b8WmYJHjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olJs7MxT; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olJs7MxT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c73cefe192so6805ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 11:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782238237; cv=none;
        d=google.com; s=arc-20260327;
        b=orvUtv677W+RN1t+TS3RN0Poifsv9kHEgP55qZxKVG+xKrVsAKEcrvQCNL4XEHyMg4
         qmZ0fMlXZz/6+EGgF6DpG+Sj1XLdJyPGZ6LwVpcftsxsYC/Q/AXGDo7s4XgnRaIHNBNC
         65YLtscIFJrY7ceKzAmZ7E+TXxa6hZiuxd2D9Ojpiw0KmvYi5cVE51sdx5zY7tBRvWAr
         LBgLQxJxxeiTN0d9ee6/Hflai8qBEylb8QoaJKyL9vNFlPCKw0teCQDjX6RRbvM2k5ZV
         ezRUJ2Eei0/OS9HA+xfuLoLMO+T7odAXJTsrdZvc4zqLzu/nOAIBEvDCXw3bgWJpe4LP
         jWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PYUZIf/xO4ROpWjr/J8Svhai5QstrZTR0FAs3E0usJk=;
        fh=btIjwof9Zf+GpEXwyju4w48bikhyQFY5j/bbdSUaDwk=;
        b=BlPC+xR+n5K0+a6OJmo522Xb9YNQJ8Cpx8/P5ma5bWU/h/qsPU2lH05aC/Xd2SynXB
         AvVrsACKZgxM0dDa3MCnFvpROd4Kvte9Gdlo4Chgiubu1vNPnLVvzT8UzG9vnm7iUUeJ
         GDCZTVKmzCNxDob6PL7s8tKedMpjiU5jVVJ1f/MO2Dm8zxgy2V7bYK2ICVmRhJyF65hc
         dj7qihi93o6tZIPEQ6HE8MHPShFCQ2w/aBMqezOhYRoW3k2EArGXJ+SZW70Nk54j0eui
         lm5AIWLjj6BYIIkOtwAFZmBspuYpFqySx+POzjHljPdvvT9vgee7WR06cGNbJdlbf1hc
         Wocw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782238237; x=1782843037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PYUZIf/xO4ROpWjr/J8Svhai5QstrZTR0FAs3E0usJk=;
        b=olJs7MxT34vyBiPdfxMt2cNht0UFfyYzhUwCyqXFxf238SJRDSTzjR66DtQaD83MfU
         IK/YTfebOkWpl/wX66Oj8z3fjbBjX7hXkn4/Apn+91Z2MWS+pSwU1c3v/jwAPv+ziqHl
         2sTZ62PGURTg3mgeR7NJ50Ot6mSmIp4PPSAFapmjIwtTf51cQe+oavMagAxPHwaVYClT
         QCD5oE0Fz1/NiE4muisPOgHrTGmWmmgDV+uV+yiLqKmvBkf855ADDOvJC51IavqfR94O
         v0Dv5sae2hAdL9X0rnN7efHND+D9aOLxShhfnanCEz7umVEfQxRIEpfEhIi8n4Hkt2jM
         hENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782238237; x=1782843037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PYUZIf/xO4ROpWjr/J8Svhai5QstrZTR0FAs3E0usJk=;
        b=Tb4LcIpJsjqB5ete9XrhWlRncO2lMnFtCdlToMtjyndKzBdO9q7YjruqBlQx3EZlFh
         tEiN/oo8OWTGectxpQdhRfAiMwtBP7PMwTJf4epMMkHZ2la/oYUUvMDti+p7h6VvDIIT
         oMbM+es0mN4b2Np43odJlJlH1czczRmRgXw0SA2j3umZFmozcrWko61KaJOpshYBquiC
         8I9Y+fmR1/hgTxiH0h3UQ4BSK0ukar/Z60ZAcOZMOpfRGRTlctibfSaNXcmySkcWOilE
         AWeyEesQQ+vtkN+iCDxlj7cqe1kwTSCJnPgWBMnhRNaQgsq/ilAvpfHaBeCJ6XxhF8EP
         3d7A==
X-Forwarded-Encrypted: i=1; AHgh+RoiwpcLixHJpM6CRoP4iR4aZQuFTLS3iqlceTGnWcSI2CvIqWiS8RJqdgQNbqFQHq7AOZVnx6IoCv+Y16+4xMXj@vger.kernel.org
X-Gm-Message-State: AOJu0YyGn18nRZcrqgn06zoC4zB2nzyyN4JN4IlXLLQUHlbmXLxWIWzH
	qTPuzoq5S9A77QF0eGPHV4pzI5Hz/DNuhC25aALgjmNoGKyP08adHgcUcT7158fMvYWR/qKvaEU
	681g7jmAkRIhCOGs9vP3I27T6ELsargse20wVGQXb
X-Gm-Gg: AfdE7cmxQQcFAxe4/WmBU36vbsv3HjTlYLHnazEQNcPSBPCMuMcsYF8VUr5BMXUJHTF
	2BOd8dn3LDygMvNUZMyyYQB5WM5r0hZ6ibh5ivZqzfbgsUdXjhEsxfbHHAmiR0HwU5HGxezOknO
	j56odZD/scPyiqhidM8Qlx6dNnyaMepFdq0u3XlyocouItX3L1neoSQur512FD9aW53LRwdgg5z
	sHihpR70NodbAW0YF/D2LvIdT2pHDdjPNTbB0N3mtC4VwT7m34dVddJ5CcrMP6qfvqSmIClpA==
X-Received: by 2002:a17:903:2441:b0:2c7:ba0d:dd4b with SMTP id
 d9443c01a7336-2c7e0967b17mr198555ad.29.1782238236327; Tue, 23 Jun 2026
 11:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622134933.35773-1-akinobu.mita@gmail.com> <20260622134933.35773-2-akinobu.mita@gmail.com>
In-Reply-To: <20260622134933.35773-2-akinobu.mita@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jun 2026 11:10:25 -0700
X-Gm-Features: AVVi8CesPbUpGDhyVpDgdk0MbQUWRo8HG5p-Gvg90gzS8O1Ugf19-59vTEDO9Yw
Message-ID: <CAP-5=fVyAskTbcB-pJbcNChq8GJnQ_098EfsnZzcO7O9A-8x4g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] perf python: Add access to various members of evsel
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, sj@kernel.org, 
	ravis.opensrc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 6:57=E2=80=AFAM Akinobu Mita <akinobu.mita@gmail.co=
m> wrote:
>
> This change is necessary to specify the same PMU event selection as the
> 'perf record' -e option from DAMON's userspace tools.
>
> For example, a Python script like the following will allow you to obtain
> the values to be set in the type, config, config1, and config2 members of
> perf_event_attr by providing a symbolic event name.
>
> import perf
>
> if __name__ =3D=3D '__main__':
>     evlist =3D perf.parse_events("cpu/mem-loads,ldlat=3D30/P")
>     for evsel in evlist:
>         print(f"{evsel}: type=3D{evsel.type} config=3D{evsel.config}",
>               f"config1=3D{evsel.config1} config2=3D{evsel.config2}")
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Thanks Akinobu! I agree we should expose more parts of the evsel
through the perf python API. I refactored this area recently so that
we could better support perf.data file usage (the session API).
There's a long series here that is merged enough to mean these changes
will need a refactor too:
https://lore.kernel.org/lkml/20260419235911.2186050-1-irogers@google.com/
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n2449

The main change I made was avoiding copying evsels in the python API,
as it adds many complications, and switching to reference counting.
This means the Python `evsel` can no longer directly access inner
variables and now requires an indirection. So in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n2290
```
static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void
*closure __maybe_unused)
{
struct pyrf_evsel *pevsel =3D (void *)self;

CHECK_INITIALIZED(pevsel->evsel, "evsel");

return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.config);
}
```
Note how it is `evsel->core` rather than `evsel.core` as it was before.

I believe you can copy-paste the code and tweak it for config1 and
config2, but I'm afraid the previous evsel_attr_member_def approach
won't work.

Thanks,
Ian

> ---
>  tools/perf/util/python.c | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cc1019d29a5d..3f108b405ee3 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1241,11 +1241,60 @@ static PyMemberDef pyrf_evsel__members[] =3D {
>         evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute sample=
_type."),
>         evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read_f=
ormat."),
>         evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_ev=
ents."),
> +       evsel_attr_member_def(config1, T_ULONGLONG, "attribute config1.")=
,
> +       evsel_attr_member_def(config2, T_ULONGLONG, "attribute config2.")=
,
>         { .name =3D NULL, },
>  };
>
>  static const char pyrf_evsel__doc[] =3D PyDoc_STR("perf event selector l=
ist object.");
>
> +static PyObject *pyrf_evsel__get_freq(struct pyrf_evsel *pevsel, void *c=
losure)
> +{
> +       return PyLong_FromLong(pevsel->evsel.core.attr.freq);
> +}
> +
> +static PyObject *pyrf_evsel__get_exclude_kernel(struct pyrf_evsel *pevse=
l,
> +                                               void *closure)
> +{
> +       return PyLong_FromLong(pevsel->evsel.core.attr.exclude_kernel);
> +}
> +
> +static PyObject *pyrf_evsel__get_exclude_hv(struct pyrf_evsel *pevsel,
> +                                           void *closure)
> +{
> +       return PyLong_FromLong(pevsel->evsel.core.attr.exclude_hv);
> +}
> +
> +static PyObject *pyrf_evsel__get_precise_ip(struct pyrf_evsel *pevsel,
> +                                           void *closure)
> +{
> +       return PyLong_FromLong(pevsel->evsel.core.attr.precise_ip);
> +}
> +
> +static PyGetSetDef pyrf_evsel__getset[] =3D {
> +       {
> +               .name   =3D "freq",
> +               .get    =3D (getter)pyrf_evsel__get_freq,
> +               .doc    =3D PyDoc_STR("freq"),
> +       },
> +       {
> +               .name   =3D "exclude_kernel",
> +               .get    =3D (getter)pyrf_evsel__get_exclude_kernel,
> +               .doc    =3D PyDoc_STR("exclude_kernel"),
> +       },
> +       {
> +               .name   =3D "exclude_hv",
> +               .get    =3D (getter)pyrf_evsel__get_exclude_hv,
> +               .doc    =3D PyDoc_STR("exclude_hv"),
> +       },
> +       {
> +               .name   =3D "precise_ip",
> +               .get    =3D (getter)pyrf_evsel__get_precise_ip,
> +               .doc    =3D PyDoc_STR("precise_ip"),
> +       },
> +       { .name =3D NULL, },
> +};
> +
>  static PyTypeObject pyrf_evsel__type =3D {
>         PyVarObject_HEAD_INIT(NULL, 0)
>         .tp_name        =3D "perf.evsel",
> @@ -1255,6 +1304,7 @@ static PyTypeObject pyrf_evsel__type =3D {
>         .tp_doc         =3D pyrf_evsel__doc,
>         .tp_members     =3D pyrf_evsel__members,
>         .tp_methods     =3D pyrf_evsel__methods,
> +       .tp_getset      =3D pyrf_evsel__getset,
>         .tp_init        =3D (initproc)pyrf_evsel__init,
>         .tp_str         =3D pyrf_evsel__str,
>         .tp_repr        =3D pyrf_evsel__str,
> --
> 2.43.0
>
>
