Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794250872;
	b=h/AxoPFoekxN0noZf/Hcr5qQtzkZLEayqesoPQbJxPLlrKWpMXVZuxP7Xdbcvq4v9l7K
	 kjChyV+TSPvi0t3YtPfgiCU+5LfbVtFckBUk5FdC8bzWRUkrYjSGP0F0epgGZTHviBwSX
	 PDvk8Ms07gMNZnTllzu/J1BFDoY5VcnP9TBfpuOVnJ6HeWlYN1xsHd1eyGALpZM485EVx
	 TVsEhr+Z/YvDYgab6Sv9GuMw29fu/g1wkbkAKfAT5bV7OlozpTFufpU58jXcSVQKBdrCX
	 lH9jMot14Fy2TmUuR+NsptCLv8WUmbXeaMuzMnLGx35TJFYv79OPGjntb/P9TCqPVqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oViOagL2ARZ2knSY6KlnC+xBVU/YJBbiMnxoNmoki80=;
	b=Qx7oAfgVe0dSnmgVXdQ0ZusubO9yQEWv642D+EYJ1IDKGzs5GnshSfcIrvkptlamkoou
	 6J5EEamRGyIvW55GJ1XMfwASTeXlEqK81byOpxnHxa1SL9X/sVuHgEbpl3Tv2sb0k3i7E
	 gMWu32DWyGghn0mutIY4RNdMvA+t6Zd2J0NM/vh4ZllLlTxe7ZLWfsGqNt1KV/5NA90aN
	 XCfGYlzvfSE5WBkNLJUDUafJd1n/g0hL8s00v0RCLGCvGMb0KRzpAoFcVm4PQs9WAhGi0
	 dBIEfIS2GbzdZ6vXaQHSgLkmMq5RtIXxvfSPiKQZ+Hl1BF3T4XUS0F4wSVq4DXUb7WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jzi0ciBj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B5606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 19:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 506B5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jzi0ciBj
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d581da0aaso126526466b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 11:01:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794250871; cv=none;
        d=google.com; s=arc-20260327;
        b=kH9pjq4AMRG5FPfs7xqATRE97F3BlU+8kpQ+oFCEy1IG3qymhAPD3tG6ATo7IGcNuz
         z8AXJnChqDVrl6nmCwa5X7l5U4XiASoHhLiX3ABzdXUQY4OV++VM+CLzaBrzIN4b/q2o
         DWnN/OZU4/TinKYnITR6gpVj1xc3UNjsc1lg7F+i0w5mBXFzch1VO0cKOQC3GuUARz5w
         duK+dYpEspEUjxkAi8uvYH/lHKReJ+8h2l6ojELHxX1OTuMSKwiWVEF/s3tZ3l6rtb7/
         2HQt3+8atJl8xtIXXabS7bBmTPvsPW2FQsCTUABGQf4E27DwQwYmHT9n31TOizoqNxgx
         xWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oViOagL2ARZ2knSY6KlnC+xBVU/YJBbiMnxoNmoki80=;
        fh=ldXhEPIb+Ntm3PCNm+tEpbnhp0i9vPKA/+e290WYWr0=;
        b=JQGnY+YEtX3F3Pq6G4/i3h+ghaQ7K3wHNYlOvWqRnJbZMBJiqUvDeqkXdIXXN/KDIU
         Yqv0eeIEJQypB9Jc3OkrE90mt/Ec/iRdthxYxReqw0zOCAmycDdV6C6jzfaqvTwkwKVN
         3or6GXnZWsMFnygT7H5OmIZk3TilV3xakj9iQsIOka+HUKpTW7nVnKdmyrMILW53qA94
         JQ33n+AkXwEuR0h50hRblIo3oeprwEU6LxUnSoCcBl0KoW4WnOsLGGXYQoXlkRfc3975
         E3FXxsZv9rvBG14Xlw3UFpCOHXby6bb74VYTqjBY5IO4VtrlHK4TUOoynlX3/EmhBXFj
         F1LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794250871; x=1794855671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oViOagL2ARZ2knSY6KlnC+xBVU/YJBbiMnxoNmoki80=;
        b=jzi0ciBjghjRkg5pAzrI0ojmRpaAYq8U+G7lTwFnefmPwMjEwT31nBsMHrraMdIN48
         h1jk5ocmP0AXkP33PXtlXEig/yLPesNff3wRQ5S31Kfz1G23tGecmh27o1BCz1BoMouX
         qVfgZRodtJKBqNzamsz8/CUPpy7KFt3oquP+Jgfu3yjTuXeyfA9Pjxe2ZWNK7SkdmBWY
         CGMWoegABV6JeaXHbc8WyX3D66Dp5Z9atRhiP7CEQrJEne2zC49aehY8trSxATFr15ov
         JqNoJac8PHdVHcqXIQYljR7pyXQUaOQe7l7f2YAOO5WWq2HOjClNe0ceGVCPAoqLWISo
         tE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794250871; x=1794855671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oViOagL2ARZ2knSY6KlnC+xBVU/YJBbiMnxoNmoki80=;
        b=aYRUeNvoaetgwHqMUUCzAh+bu2KsFNcWgP6O/SoCHqGh+aN7mu1QPqwQyLQWMIdF3l
         82IdbN/YtccjiZvAxWB2CV6FeToNqj0xwGiXilZjWY3I5i7YxmBix5px6FgHJNze+BSt
         tqrGolaAK0t09Sfi9Nh4VeynXozhtxmCLYyHosnCFa/HScDMEfJqDT1UziOpoaXnHc7w
         ZFT9ysm36LiBk1oM2jBbSnS5u4PMnaNsx60/pZYZwxcKk2QecrmVq1phSJQYkgRo2nC3
         LJQh6p4AVcEsO3DmNikWuWxiyW50NK+kDnau5TUHHpWMfmYOSPruYBwb1n3FeVLGElCM
         R/LA==
X-Forwarded-Encrypted: i=1; AL+hErE0r9XvHzXldiRoxLc/6YbJuok+d4gq3c+IgyIT6hbJYFonPZvcVTEarRRfokXpNDqtZKXmNPa3QoFMzVXcgRly@vger.kernel.org
X-Gm-Message-State: APuU4Z8TvymWJEd3OkiBOobdgixMsOmCYkg1Qh1AenOtgbDRzfoCjSUF
	XCYrsYj5y+RTf6YAB30dVI0IY2bIWr+X6V/hbqz8kt/hnWPvvg+XPgMD/uPXHZdYtniFdxuGljS
	QUoAM33SM762m+b+vyilfyRM6D4ITkz4Ej3SuPNL1
X-Gm-Gg: AYBFou0+FFPEdqoDnf8F1tgaIseXM6p9B9065eMDsGr2hINmGfAZ84AudF2UMWPvTTf
	yXQxcKG7ScX0NNugykFkNdWnZ1cv1nEUS6cVFB2USaVh40cdOfRoTQQQ1T/Qbiai2REIxMOOHF9
	wxj8DKC28kRto5QKfD7WdmTEHNc8fy/LoxkZN/MdNleHssXIPXhX3ZJcGExkZaQfU01XIVGamXX
	+et9it3xv5DCt1RipAJQCEZXOZFwgvh58fs7Sr/mm+0vG3fkK4wU5qpXzA90A2GfsLj7ZmDWytD
	Szp9WZFCSNsGFxHNh4PNJ+oobYuiXAipP3O7/2ywHmsgYxcL7tU8O9XtTRYpMzk38VGJIz0L3L1
	+D2zhnjCUZtJGQ83dbbW/yDcTJ9YBWjaFby6Vr9S1og5mX0Ym1GmbuvMZ9cdYr/RcAlWDMw==
X-Received: by 2002:a17:906:ee86:b0:c42:5363:38dc with SMTP id
 a640c23a62f3a-c5049569a47mr22222466b.25.1794250870067; Mon, 09 Nov 2026
 11:01:10 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018081452.1014460-1-lalitmaganti@gmail.com>
In-Reply-To: <20261018081452.1014460-1-lalitmaganti@gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 9 Nov 2026 11:00:58 -0800
X-Gm-Features: AclHuK84cxOm-Fxk-JWgzwE7ADkWICNesE3jwY7PWhsZvhFOol869e0L2WP6QRQ
Message-ID: <CAG2KctpJogfGKwbXk0OUmawVR5o7EodACrk12Br9d4bis3wi_g@mail.gmail.com>
Subject: Re: [PATCH] perf python: Set up callchain parameters for sessions
To: Lalit Maganti <lalitmaganti@gmail.com>
Cc: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	james.clark@linaro.org, leo.yan@linux.dev, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 1:14=E2=80=AFAM Lalit Maganti <lalitmaganti@gmail.c=
om> wrote:
>
> perf.session never calls callchain_param_setup(), so callchains are
> resolved with callchain_param.record_mode left as CALLCHAIN_NONE rather
> than set from the sample type as in perf script and perf report.
>
> On arm64 this loses frames: when a sample hits a function before it has
> pushed its frame record, its caller is only in the link register, and
> recovering it needs record_mode CALLCHAIN_FP. Comparing the callchain of
> every sample with perf script, on a frame pointer recording of a
> two-thread workload on arm64, 4 of 4494 samples miss a frame, e.g.:
>
>   perf script: clock_gettime@plt <- now <- spin <- other_path
>   perf.session: clock_gettime@plt <- spin <- other_path
>
> Call callchain_param_setup() once the session is created and, as perf
> script does, again as attrs are processed, for pipe mode. With that,
> all callchains match perf script on arm64, for frame pointer and DWARF
> recordings, from a file or a pipe. On x86 they matched before and still
> do.
>
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
> ---
>  tools/perf/util/python.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 60dbe2dad5eb..92d18e24049d 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -4842,6 +4842,24 @@ static int __pyrf_session_tool__stat_round(const s=
truct perf_tool *tool,
>   */
>  static struct pyrf_session *pyrf_session__active;
>
> +/*
> + * In pipe mode attrs are only known once processed, so set up callchain=
s again,
> + * as perf script does.
> + */
> +static int pyrf_session__process_attr(const struct perf_tool *tool,
> +                                     union perf_event *event,
> +                                     struct evlist **pevlist)
> +{
> +       int err =3D perf_event__process_attr(tool, event, pevlist);
> +
> +       if (err)
> +               return err;
> +       callchain_param_setup(evlist__combined_sample_type(*pevlist),
> +                             perf_session__e_machine(evsel__session(evli=
st__last(*pevlist)),
> +                                                     /*e_flags=3D*/NULL)=
);
> +       return 0;
> +}
> +
>  static bool pyrf_session__check_not_busy(struct pyrf_session *psession)
>  {
>         if (pyrf_session__active =3D=3D psession &&
> @@ -5061,7 +5079,7 @@ static PyObject *pyrf_session__new(PyTypeObject *ty=
pe, PyObject *args, PyObject
>         psession->tool.ksymbol          =3D perf_event__process_ksymbol;
>         psession->tool.text_poke        =3D perf_event__process_text_poke=
;
>         psession->tool.build_id         =3D perf_event__process_build_id;
> -       psession->tool.attr             =3D perf_event__process_attr;
> +       psession->tool.attr             =3D pyrf_session__process_attr;
>         psession->tool.event_update     =3D perf_event__process_event_upd=
ate;
>         psession->tool.feature          =3D perf_event__process_feature;
>  #ifdef HAVE_LIBTRACEEVENT
> @@ -5139,6 +5157,8 @@ static PyObject *pyrf_session__new(PyTypeObject *ty=
pe, PyObject *args, PyObject
>                 PyErr_SetString(PyExc_OSError, "perf: symbol__init failed=
");
>                 goto err_out;
>         }
> +       callchain_param_setup(evlist__combined_sample_type(session->evlis=
t),
> +                             perf_session__e_machine(session, /*e_flags=
=3D*/NULL));
>         if (psession->symfs && !symbol_conf.symfs[0])
>                 zfree(&psession->symfs);
>
>
> base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
> --
> 2.56.0
>

I think we can add:
Fixes: 88439191ad5e ("perf python: Add callchain support")

But otherwise, looks good to me. I did a quick test on next-20261109
with an ARM64 Pixel device using a workload whose hot path has a leaf
function without a frame record, and got the expected results.

Reviewed-by: Samuel Wu <wusamuel@google.com>
Tested-by: Samuel Wu <wusamuel@google.com>
