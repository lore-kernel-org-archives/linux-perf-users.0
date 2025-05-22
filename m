Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153119F11E;
	Thu, 22 May 2025 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953391; cv=none; b=TQX8Pz6OfMJ4J/c5eTiofYvWC0UqAA/IyiK2z+OEZva3wV2JWDM18rd0otbr9hms1LTNCu+BN0uJ0TGvCtfDO1gVrfC7C46kloZJy1YdF5B/461ksh4HlkOH4cO9oIropd3hnp7FJ5cdY60P7zWucApapQSVaPKiOjjimXDo2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953391; c=relaxed/simple;
	bh=Qvg4iUTtm4zd6EbKirV0GTSeIMaJ01ei9nusT4CHZuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS+Qltrg+SHPpV9AV0KM1EMDfSXSjM4aEAJJKaVECbu2YMJA/NwD0atCltZS5li1+o0pzlC/xLPxOJcp9xCXpbCdU4cAlkYIVZlbMn0TfkUWHL0dBvIfLYTiPiHduSGRBDeH+0Q9G1wo7SwSPwX8yOuauhdv8rrB0DdVzF0lltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+PqnprK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+PqnprK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833ADC4CEE4;
	Thu, 22 May 2025 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747953390;
	bh=Qvg4iUTtm4zd6EbKirV0GTSeIMaJ01ei9nusT4CHZuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+PqnprK2ewLx5zHhgVG/xaG4JcO23Bo2VoV2JnXId6j4x25KGGR2ZgEnaCNeZyM4
	 xcThQv0eVMxcKQtu50q5/M/ULZEJTTYtfWo/ROPPVUHfTKMeUPLQ9V+4ZNS5nT8X6f
	 +IZhQ1I2D0z5c+L2MXtmPV3iP3EiLR0YQg98AeEAsOpO/jkr0YZd+53Cn7enIvKcix
	 MbWWfp16onQKA3KpOH5aXMirQMgZP0qy/EwGNiXfkQbfoqwdJzSR3zpZyz0agkJwsz
	 EWtoKcMoV3ci/bsHGLxbe+qkF1BNDa7d5JJmtumaBqd4OVfqEFwW04ROamqOuAPZ7Y
	 yUP/RsZvHaZww==
Date: Thu, 22 May 2025 19:36:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Subject: Re: [PATCH v3 4/7] perf python: Add support for perf_counts_values
 to return counter data
Message-ID: <aC-m7G-AVJP6sDD3@x1>
References: <20250519195148.1708988-1-irogers@google.com>
 <20250519195148.1708988-5-irogers@google.com>
 <aC-jR0b3mji4oJ7Q@x1>
 <CAP-5=fXdpT3-=e4cqZN4fBJK1c4TnYC1ZVV5Q5zTjmf7T7Fffg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXdpT3-=e4cqZN4fBJK1c4TnYC1ZVV5Q5zTjmf7T7Fffg@mail.gmail.com>

On Thu, May 22, 2025 at 03:32:44PM -0700, Ian Rogers wrote:
> On Thu, May 22, 2025 at 3:20 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, May 19, 2025 at 12:51:41PM -0700, Ian Rogers wrote:
> > > From: Gautam Menghani <gautam@linux.ibm.com>
> > >
> > > Add support for perf_counts_values struct to enable the python
> > > bindings to read and return the counter data.
> > >
> > > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > > ---
> > >  tools/perf/util/python.c | 92 +++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > index ead3afd2d996..1cbddfe77c7c 100644
> > > --- a/tools/perf/util/python.c
> > > +++ b/tools/perf/util/python.c
> > > @@ -626,6 +626,92 @@ static int pyrf_thread_map__setup_types(void)
> > >       return PyType_Ready(&pyrf_thread_map__type);
> > >  }
> > >
> > > +struct pyrf_counts_values {
> > > +     PyObject_HEAD
> > > +
> > > +     struct perf_counts_values values;
> > > +};
> > > +
> > > +static const char pyrf_counts_values__doc[] = PyDoc_STR("perf counts values object.");
> > > +
> > > +static void pyrf_counts_values__delete(struct pyrf_counts_values *pcounts_values)
> > > +{
> > > +     Py_TYPE(pcounts_values)->tp_free((PyObject *)pcounts_values);
> > > +}
> > > +
> > > +#define counts_values_member_def(member, ptype, help) \
> > > +     { #member, ptype, \
> > > +       offsetof(struct pyrf_counts_values, values.member), \
> > > +       0, help }
> > > +
> > > +static PyMemberDef pyrf_counts_values_members[] = {
> > > +     counts_values_member_def(val, Py_T_ULONG, "Value of event"),
> > > +     counts_values_member_def(ena, Py_T_ULONG, "Time for which enabled"),
> > > +     counts_values_member_def(run, Py_T_ULONG, "Time for which running"),
> > > +     counts_values_member_def(id, Py_T_ULONG, "Unique ID for an event"),
> > > +     counts_values_member_def(lost, Py_T_ULONG, "Num of lost samples"),
> > > +     {NULL}
> > > +};
> >
> > So the above is failing on a aarch64 debian (rpi5):
> >
> > acme@raspberrypi:~/git/perf-tools-next $ dpkg -S /usr/include/python3.11/structmember.h
> > libpython3.11-dev:arm64: /usr/include/python3.11/structmember.h
> > acme@raspberrypi:~/git/perf-tools-next $
> >
> > Where it only has:
> >
> > acme@raspberrypi:~/git/perf-tools-next $ grep -r Py_T_ULONG /usr/include/
> > acme@raspberrypi:~/git/perf-tools-next $ grep -rw Py_T_ULONG /usr/include/
> > acme@raspberrypi:~/git/perf-tools-next $ grep -rw T_ULONG /usr/include/
> > /usr/include/python3.11/structmember.h:#define T_ULONG     12
> > acme@raspberrypi:~/git/perf-tools-next $
> >
> > while on fedora 42 x86_64:
> >
> > ⬢ [acme@toolbx perf-tools-next]$ grep -rw Py_T_ULONG /usr/include/
> > /usr/include/python3.13/descrobject.h:#define Py_T_ULONG     12
> > /usr/include/python3.13/structmember.h:#define T_ULONG     Py_T_ULONG
> > ⬢ [acme@toolbx perf-tools-next]$
> >
> > So I'm making it use the T_ULONG and others as all the other PyMemberDef
> > arrays in tools/perf/util/python.c, ok?
> 
> The fix makes sense to me. Checking the documentation it seems
> Py_T_ULONG is preferred:
> https://docs.python.org/3/c-api/structures.html#member-types
> perhaps we can add:
> ```
> #ifndef Py_T_ULONG
> #define Py_T_ULONG T_ULONG
> #endif
> ```
> so that we use the approach matching the documentation while fixing
> the RaspberryPi issue.

That can be done as a followup, as there are lots of preexisting usage
for struct method definitions.

- Arnaldo
 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > +static PyObject *pyrf_counts_values_get_values(struct pyrf_counts_values *self, void *closure)
> > > +{
> > > +     PyObject *vals = PyList_New(5);
> > > +
> > > +     if (!vals)
> > > +             return NULL;
> > > +     for (int i = 0; i < 5; i++)
> > > +             PyList_SetItem(vals, i, PyLong_FromLong(self->values.values[i]));
> > > +
> > > +     return vals;
> > > +}
> > > +
> > > +static int pyrf_counts_values_set_values(struct pyrf_counts_values *self, PyObject *list,
> > > +                                      void *closure)
> > > +{
> > > +     Py_ssize_t size;
> > > +     PyObject *item = NULL;
> > > +
> > > +     if (!PyList_Check(list)) {
> > > +             PyErr_SetString(PyExc_TypeError, "Value assigned must be a list");
> > > +             return -1;
> > > +     }
> > > +
> > > +     size = PyList_Size(list);
> > > +     for (Py_ssize_t i = 0; i < size; i++) {
> > > +             item = PyList_GetItem(list, i);
> > > +             if (!PyLong_Check(item)) {
> > > +                     PyErr_SetString(PyExc_TypeError, "List members should be numbers");
> > > +                     return -1;
> > > +             }
> > > +             self->values.values[i] = PyLong_AsLong(item);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static PyGetSetDef pyrf_counts_values_getset[] = {
> > > +     {"values", (getter)pyrf_counts_values_get_values, (setter)pyrf_counts_values_set_values,
> > > +             "Name field", NULL},
> > > +     {NULL}
> > > +};
> > > +
> > > +static PyTypeObject pyrf_counts_values__type = {
> > > +     PyVarObject_HEAD_INIT(NULL, 0)
> > > +     .tp_name        = "perf.counts_values",
> > > +     .tp_basicsize   = sizeof(struct pyrf_counts_values),
> > > +     .tp_dealloc     = (destructor)pyrf_counts_values__delete,
> > > +     .tp_flags       = Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
> > > +     .tp_doc         = pyrf_counts_values__doc,
> > > +     .tp_members     = pyrf_counts_values_members,
> > > +     .tp_getset      = pyrf_counts_values_getset,
> > > +};
> > > +
> > > +static int pyrf_counts_values__setup_types(void)
> > > +{
> > > +     pyrf_counts_values__type.tp_new = PyType_GenericNew;
> > > +     return PyType_Ready(&pyrf_counts_values__type);
> > > +}
> > > +
> > >  struct pyrf_evsel {
> > >       PyObject_HEAD
> > >
> > > @@ -1475,7 +1561,8 @@ PyMODINIT_FUNC PyInit_perf(void)
> > >           pyrf_evlist__setup_types() < 0 ||
> > >           pyrf_evsel__setup_types() < 0 ||
> > >           pyrf_thread_map__setup_types() < 0 ||
> > > -         pyrf_cpu_map__setup_types() < 0)
> > > +         pyrf_cpu_map__setup_types() < 0 ||
> > > +         pyrf_counts_values__setup_types() < 0)
> > >               return module;
> > >
> > >       /* The page_size is placed in util object. */
> > > @@ -1520,6 +1607,9 @@ PyMODINIT_FUNC PyInit_perf(void)
> > >       Py_INCREF(&pyrf_cpu_map__type);
> > >       PyModule_AddObject(module, "cpu_map", (PyObject*)&pyrf_cpu_map__type);
> > >
> > > +     Py_INCREF(&pyrf_counts_values__type);
> > > +     PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
> > > +
> > >       dict = PyModule_GetDict(module);
> > >       if (dict == NULL)
> > >               goto error;
> > > --
> > > 2.49.0.1101.gccaa498523-goog
