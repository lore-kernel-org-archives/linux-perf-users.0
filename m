Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E4946C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645974; cv=none; b=nATf7aZPS5EyNG2kuXJhT5uF7yshifOuabLqYFslerFm0B1ZY7Ocz5oNUECU2lRfVAZE2sJzjc1cpRFsQHsmvWpB8+7GJhaCHVW+WMBjXDsDB+BELUA+eSMNVU73TTNp+rejsK66jVJckCwanbZAHcXVNR1kqbJIX48bnW/yKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645974; c=relaxed/simple;
	bh=qFkqK0FmK8/dwUjpue3QW10pnwVXEwCvVaukcqpHUmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VMVR7hnECDhGhOSB+R+V/XkTrj40krSh5qgKcw+7DW8uhBp3XxZRcyzWVxjkw1AIbWOHTiOR0GakBU48qRS4EPF+0vzEMu6Eph5P8K6LR5MuSMKkWqyLgFQNpV+ZbTXE6pL2KQOqK2XX/k2JKbXB3G8b78gqV7kn1WRiM1XQ7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIFk6/z3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIFk6/z3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E57CC2BCAF;
	Mon, 20 Apr 2026 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645974;
	bh=qFkqK0FmK8/dwUjpue3QW10pnwVXEwCvVaukcqpHUmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iIFk6/z3DtJEob6sB91zyUIdupRTEp6McUl9dVOfULN9iDBb1y5K/AoTCv1BMsLRq
	 E4RIZ1TC0x14osKaW94Kd00x619uw/OblrNCs82QBudr4znPhU6K+N5VP82ENcBtDg
	 S0KnQKqEzkP4xiVs0mPEuxZws75rYf40sZlZyrb52LsAEzbUrGJzM8+PnXdHBc8Gyh
	 rvo0ExVqbDyaX5ZtLO7AzHlECq/QWwmIl0O42HQoriKM2zXo7sDFyXLSaojd34UvGa
	 4J9YGYdRn01e7vwv1gMN337glYOXBuMjOMNucqXXXOQA80YoXeN0onKULqtkI2rmvg
	 v++Xx30SqvjyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/58] perf python: Use evsel in sample in pyrf_event
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-14-irogers@google.com>
References: <20260419235911.2186050-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:46:14 +0000
Message-Id: <20260420004614.9E57CC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Uninitialized memory dereference and memory corruption on erro=
r path.
- [High] Unbalanced reference count leads to Use-After-Free of evsel.
--

commit 9f11b0fde656e141e642877371cb83e3963c35bd
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event
   =20
Avoid a duplicated evsel by using the one in sample.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -274,7 +273,7 @@ static PyMemberDef pyrf_sample_event__members[] =3D {
> =20
>  static void pyrf_sample_event__delete(struct pyrf_event *pevent)
>  {
> -	evsel__put(pevent->evsel);
> +	evsel__put(pevent->sample.evsel);

This isn't a regression from this patch, but does pyrf_evlist__read_on_cpu()
take ownership of the evsel reference?

Looking at pyrf_evlist__read_on_cpu(), the evsel is retrieved using
evlist__event2evsel(), which returns a borrowed reference. However, this
destructor unconditionally calls evsel__put().

Since no evsel__get() is called when the python event is created, will every
garbage-collected sample event erroneously decrement the evsel's internal
refcount, potentially leading to a use-after-free while the evsel is still
actively used by the evlist?

>  	perf_sample__exit(&pevent->sample);
>  	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
>  }
[ ... ]
> @@ -1770,8 +1769,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct py=
rf_evlist *pevlist,
>  			return Py_None;
>  		}
> =20
>  		evsel =3D evlist__event2evsel(evlist, event);
>  		if (!evsel) {
>  			Py_DECREF(pyevent);

This isn't a regression introduced by this patch, but are we at risk of an
uninitialized memory dereference on this error path?

When a new pyrf_event is allocated with PyObject_New(), the embedded sample
struct is uninitialized. If evlist__event2evsel() returns NULL, this error
path calls Py_DECREF(pyevent).

This triggers the destructor pyrf_sample_event__delete(), which calls
evsel__put(pevent->sample.evsel) and perf_sample__exit(&pevent->sample).

Because pevent->sample was never initialized, could this pass uninitialized
heap garbage to evsel__put() and perf_sample__exit(), potentially causing
memory corruption?

>  			Py_INCREF(Py_None);
>  			return Py_None;
>  		}
> =20
> -		pevent->evsel =3D evsel;
> -
>  		perf_mmap__consume(&md->core);
> =20
>  		err =3D evsel__parse_sample(evsel, &pevent->event, &pevent->sample);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D13
