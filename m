Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0429B23F;
	Tue,  5 Aug 2025 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754434694; cv=none; b=QL9HpfSu2UtH58pCSGHgDKOH8x2bebJJ9ZCyJXWzUnKrr11ERD3nIOV7u7bgrii4LnvC5ap1DmBAqUEaVP52IlF8z3/YFaR/ozm5iST0XJpDLDkOOjZBrmHY/e13SDPLoQ91WST8cXq8n/2rQh3lZJd/CvqVh7MakzfnOe8rfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754434694; c=relaxed/simple;
	bh=E4N4Ufuk1DIdYyoINIaGMG7JyQ9N0vJxC0DNXG8VBBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPvs6vAdUXMWyFo5mqh5taO7dKMotZTzOrNAFmNjBUrP//oea/bzyi4Xt31YU3C+uit4oAKJVFkku1bP8CkiDGwmG8tZcrOCRCFXGH3tOv63ztVDOg8j4I+tbpAUfvsHEQh55pRPstOiD31wCnNOl6MsCnk3OHBgE+NCnEWjiLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0IK7JzE; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0IK7JzE"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e75668006b9so4934977276.3;
        Tue, 05 Aug 2025 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754434692; x=1755039492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+g8mVNaa2FoDRR5TSD6hZjwgQU4vlwZ93hFUn6W02s=;
        b=j0IK7JzE3yVNk3IqcUkB+67L3Gau81hggnIOWPHu48+CYotmXHYAUyNLI2L0nh2m+l
         xuNXKpaEr2YEYuv6wcn+4Q2b0gVpeMa6+R3TcCH/HfLDfyGffTK9piLw17NrMl9cRwpd
         0Bxc2HCYVqvGcyEZaTc1ROmuyLEkqDtqrtPQt1MIDhy/3a8Vnhhbs+TQwlIzYUkK5GFy
         UeHi40VdQgTcJ1cb4LKt4uyP42+g4svHbO+gAnje+DPwURnw2j4O46CKpG/78QxZfyxd
         nCEIx7DODuzkwHcEuDoWHiDAB3FlgMBs9AcrT/xkjsgvTN0BLocEa2Vl9RPIHo9S4CAX
         vdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754434692; x=1755039492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+g8mVNaa2FoDRR5TSD6hZjwgQU4vlwZ93hFUn6W02s=;
        b=L/04JcwoJw+hUFc4LsKJNUBhwIshr824qlyXgpX/1s2QQlaMUfimihvG8/ii1sA4j5
         qnzsdrPUPct24lV+e00g9lGnGEjR71jynfja+r1O7autVqaoB/vQmyKkYzyAnNGDJJ/B
         CGmqBIQ8JmZlfcv4q9XVqNmbeivnfquKgqGbr1xh5BK55KHr9kUPeoylyR6ZJgtHKE00
         LG4e0xPQZyLmDa4ACWpfLpDfLAd2iySG3B9InsGWtdpLAtxxkwzrRbco1BoAW5/d2g4D
         mHsq0c5qqKy2ZUhg+DTXqB5B9xJDyT8JegqA/ywxt3+zlLbRQXJSv+Rrkv25V+cEyvs9
         6rWg==
X-Forwarded-Encrypted: i=1; AJvYcCVEuZTHV1wk42G31s2VffW/c3rzKCDaY399Bssa0Ngo38pmVGx+1LI7QmHUeRWECY8zi2lYnsVMRNexfIY=@vger.kernel.org, AJvYcCWRCjW7Fne/rPkG4BghiyHvwpt+d1Fpbkv7NUHKJ82XjCIv2vXIOKBKEziF5XOyufw0/xI/+vM9PGgDmuoV/Uea8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGbl9AN67MktZfC2qAlglanzLt0oVUYHlL0+BwFNRUxJSYX4+
	sVcJGDpWJTMFMOH2c2IKScCHEmeuqM1jKiQx6Pf+JfaqM1KEpcq2I3+687xzbFzu3RNt6baKGz1
	jzBr5DnAbozPDD7lTFIblqrAJLpOKZhg=
X-Gm-Gg: ASbGnctqC2R7/f93ez7DXgGdPJH8Hmia7DQ8y5Gogtdzcyho06kHiiBdMwsMDk1NFpq
	mt0g1eNGnfFUO0HlqzBKl4yqjJYO2H0BUuoZj3Qa03Y0prnL+AhyriLw42fI+8+xtRo+ycsf8We
	3TklkOLsTtlWA7R+nacMNLpgZBsktzfzEZFH3cJuXYwuCW4uJTULX8ssmFu7Ba85/UJhP0/PAEb
	Q1HBUH8
X-Google-Smtp-Source: AGHT+IEnshbv9S+bnG/n7yh+uM6sCkrBq6b6yVJDxZxpI8EdN48SF/yCU8aguToHY+XviQiLR5gEqYKauI9ZP+MIwFg=
X-Received: by 2002:a05:690c:9692:b0:71a:22e1:b351 with SMTP id
 00721157ae682-71bcc7fdfb5mr3417547b3.24.1754434692066; Tue, 05 Aug 2025
 15:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com> <20250725185202.68671-11-irogers@google.com>
In-Reply-To: <20250725185202.68671-11-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 5 Aug 2025 15:58:01 -0700
X-Gm-Features: Ac12FXzqO3egcG5PPOjSLcO5lg47ALbXMO-bE1XQlFWn0pImrBVibWS60O_GFbM
Message-ID: <CAH0uvojcQ69hn1auu_9qbc8d-Atcc_o9mL4D=EaicZ+ix4S9iQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/16] perf python: Add function returning dictionary
 of all events on a PMU
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 25, 2025 at 11:52=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Allow all events on a PMU to be gathered, similar to how perf list
> gathers event information.
>
> An example usage:
> ```
> $ python
> Python 3.12.9 (main, Feb  5 2025, 01:31:18) [GCC 14.2.0] on linux
> >>> import perf
> >>> for pmu in perf.pmus():
> ...   print(pmu.events())
> ...
> [{'name': 'mem_load_retired.l3_hit', 'desc': 'Retired load instructions..=
.
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/python.c | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index ddcb5d40ff14..d49b4401ab7e 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -660,6 +660,71 @@ static PyObject *pyrf_pmu__name(PyObject *self)
>         return PyUnicode_FromString(ppmu->pmu->name);
>  }
>
> +static bool add_to_dict(PyObject *dict, const char *key, const char *val=
ue)
> +{
> +       PyObject *pkey, *pvalue;
> +       bool ret;
> +
> +       if (value =3D=3D NULL)
> +               return true;
> +
> +       pkey =3D PyUnicode_FromString(key);
> +       pvalue =3D PyUnicode_FromString(value);
> +
> +       ret =3D pkey && pvalue && PyDict_SetItem(dict, pkey, pvalue) =3D=
=3D 0;
> +       Py_XDECREF(pkey);
> +       Py_XDECREF(pvalue);
> +       return ret;
> +}
> +
> +static int pyrf_pmu__events_cb(void *state, struct pmu_event_info *info)
> +{
> +       PyObject *py_list =3D state;
> +       PyObject *dict =3D PyDict_New();
> +
> +       if (!dict)
> +               return -ENOMEM;
> +
> +       if (!add_to_dict(dict, "name", info->name) ||
> +           !add_to_dict(dict, "alias", info->alias) ||
> +           !add_to_dict(dict, "scale_unit", info->scale_unit) ||
> +           !add_to_dict(dict, "desc", info->desc) ||
> +           !add_to_dict(dict, "long_desc", info->long_desc) ||
> +           !add_to_dict(dict, "encoding_desc", info->encoding_desc) ||
> +           !add_to_dict(dict, "topic", info->topic) ||
> +           !add_to_dict(dict, "event_type_desc", info->event_type_desc) =
||
> +           !add_to_dict(dict, "str", info->str) ||
> +           !add_to_dict(dict, "deprecated", info->deprecated ? "deprecat=
ed" : NULL) ||
> +           PyList_Append(py_list, dict) !=3D 0) {
> +               Py_DECREF(dict);
> +               return -ENOMEM;
> +       }
> +       Py_DECREF(dict);
> +       return 0;
> +}
> +
> +static PyObject *pyrf_pmu__events(PyObject *self)
> +{
> +       struct pyrf_pmu *ppmu =3D (void *)self;
> +       PyObject *py_list =3D PyList_New(0);
> +       int ret;
> +
> +       if (!py_list)
> +               return NULL;
> +
> +       ret =3D perf_pmu__for_each_event(ppmu->pmu,
> +                                      /*skip_duplicate_pmus=3D*/false,
> +                                      py_list,
> +                                      pyrf_pmu__events_cb);
> +       if (ret) {
> +               Py_DECREF(py_list);
> +               errno =3D -ret;
> +               PyErr_SetFromErrno(PyExc_OSError);
> +               return NULL;
> +       }
> +       return py_list;
> +}
> +
>  static PyObject *pyrf_pmu__repr(PyObject *self)
>  {
>         struct pyrf_pmu *ppmu =3D (void *)self;
> @@ -670,6 +735,12 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
>  static const char pyrf_pmu__doc[] =3D PyDoc_STR("perf Performance Monito=
ring Unit (PMU) object.");
>
>  static PyMethodDef pyrf_pmu__methods[] =3D {
> +       {
> +               .ml_name  =3D "events",
> +               .ml_meth  =3D (PyCFunction)pyrf_pmu__events,
> +               .ml_flags =3D METH_NOARGS,
> +               .ml_doc   =3D PyDoc_STR("Name of the PMU including suffix=
es.")

Pretty sure it's "General information about the PMU"

Thanks,
Howard
