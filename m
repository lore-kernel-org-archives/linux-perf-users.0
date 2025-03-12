Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFB2528E3;
	Wed, 12 Mar 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804559; cv=none; b=CWEV15QnCLZ/kh7jKMc3OwqhmCTXq50oGx2JtYWMNb0lYLiGnSmH1rwToKGHKBQF7SK4rpCGgrDp84L4E96FXHNHjPSBrD7xvQXOYTU6C9e5D6dPQFv8XJD3pnmao9/pwXlXIyTzTGFMuX/BdojjIAKGIt8/IOiX45WravIldxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804559; c=relaxed/simple;
	bh=iHo5ExaJ2LqEul81wloau7iQ+kJPX4ZrbOCEzg6taZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQuUusAS7YcCn4ni2cHxgM5RHvdbisZFI9Fn21DAFHRygjXcRvVtDDZddKP0Mr/cLUBfXJ1upkadYfE1gXPyIk9Drh8SIBoX8RJL94Tsv8DemTCUyNh9fd7rRC58M9QvyfG0K3ni2edNMWKcNoy6iXnXH36KGh04zwamOurhGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye/srddJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye/srddJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD33C4CEEA;
	Wed, 12 Mar 2025 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741804558;
	bh=iHo5ExaJ2LqEul81wloau7iQ+kJPX4ZrbOCEzg6taZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ye/srddJK1pVtsEJn4hjOMWovawxPpljK5BiJgL31SOiDO5Ny7ae0tWXshA+GwmMO
	 560lJZuwDJ72eIZ5KqiG8ERQ5UmGEwRSPNLQsvN+ZMo6xd21OdOgig5n1//M7O0Mgr
	 1aM0xjokHRrZaf7T+0q/FEeo3i/X7Lswvjmd5LfRze8Ywme2+Y9F1yml6n9hcIL5Td
	 78Ju110AIoUXU3iI0iIeOdGCVSQ4o/eCnH4Khi80v4bPLiexxnb+6LUvd6mCvmrD6m
	 S2Yp6zD0CBQlNIhpR7eGrQBjx8iiQtjBDCr6y9WnyYgZCt+ojpAe7bCeGSAXIw4lUU
	 nv/qOrBK/f1RA==
Date: Wed, 12 Mar 2025 15:35:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 3/3] perf python: Don't keep a raw_data pointer to
 consumed ring buffer space
Message-ID: <Z9HUCv0LO0lHz_pf@x1>
References: <20250312160651.280817-1-acme@kernel.org>
 <20250312160651.280817-4-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250312160651.280817-4-acme@kernel.org>

On Wed, Mar 12, 2025 at 01:06:51PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> When processing tracepoints the perf python binding was parsing the
> event before calling perf_mmap__consume(&md->core) in
> pyrf_evlist__read_on_cpu().
> 
> But part of this event parsing was to set the perf_sample->raw_data
> pointer to the payload of the event, which then could be overwritten by
> other event before tracepoint fields were asked for via event.prev_comm
> in a python program, for instance.
> 
> This also happened with other fields, but strings were were problems
> were surfacing, as there is UTF-8 validation for the potentially garbled
> data.
> 
> This ended up showing up as (with some added debugging messages):
> 
>   ( field 'prev_comm' ret=0x7f7c31f65110, raw_size=68 )  ( field 'prev_pid' ret=0x7f7c23b1bed0, raw_size=68 )  ( field 'prev_prio' ret=0x7f7c239c0030, raw_size=68 )  ( field 'prev_state' ret=0x7f7c239c0250, raw_size=68 ) time 14771421785867 prev_comm= prev_pid=1919907691 prev_prio=796026219 prev_state=0x303a32313175 ==>
>   ( XXX '��' len=16, raw_size=68)  ( field 'next_comm' ret=(nil), raw_size=68 ) Traceback (most recent call last):
>    File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 51, in <module>
>      main()
>    File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 46, in main
>      event.next_comm,
>      ^^^^^^^^^^^^^^^
>   AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
> 
> When event.next_comm was asked for, the PyUnicode_FromString() python
> API would fail and that tracepoint field wouldn't be available, stopping
> the tools/perf/python/tracepoint.py test tool.
> 
> So if the event is a tracepoint, copy the raw_data before consuming the
> ring buffer for the event.
> 
> This is similar to what was done in e8968e654191390a ("perf python: Fix
> pyrf_evlist__read_on_cpu event consuming"), but wasn't when adding
> support for tracepoints in bae57e3825a3dded ("perf python: Add support
> to resolve tracepoint fields"), fix it.
> 
> Fixes: bae57e3825a3dded ("perf python: Add support to resolve tracepoint fields")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/python.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index f9491b6699764fbc..e1bd8143296385fc 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -4,6 +4,7 @@
>  #include <inttypes.h>
>  #include <poll.h>
>  #include <linux/err.h>
> +#include <linux/string.h>
>  #include <perf/cpumap.h>
>  #ifdef HAVE_LIBTRACEEVENT
>  #include <event-parse.h>
> @@ -38,9 +39,16 @@ struct pyrf_event {
>  	PyObject_HEAD
>  	struct evsel *evsel;
>  	struct perf_sample sample;
> +	/** @raw_data_copy: read_on_cpu consumes rb, may be overwritten at get_tracepoint_field */
> +	void *raw_data_copy;
>  	union perf_event   event;
>  };
>  
> +static void pyrf_event__delete(struct pyrf_event *pevent)
> +{
> +	zfree(&pevent->raw_data_copy);

There is a leak here, tp_free() should be used, I'm checking also
reference counters to events, etc.

- Arnaldo

> +}
> +
>  #define sample_members \
>  	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),			 \
>  	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
> @@ -94,6 +102,7 @@ static PyTypeObject pyrf_mmap_event__type = {
>  	.tp_doc		= pyrf_mmap_event__doc,
>  	.tp_members	= pyrf_mmap_event__members,
>  	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
> +	.tp_dealloc	= (destructor)pyrf_event__delete,
>  };
>  
>  static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
> @@ -129,6 +138,7 @@ static PyTypeObject pyrf_task_event__type = {
>  	.tp_doc		= pyrf_task_event__doc,
>  	.tp_members	= pyrf_task_event__members,
>  	.tp_repr	= (reprfunc)pyrf_task_event__repr,
> +	.tp_dealloc	= (destructor)pyrf_event__delete,
>  };
>  
>  static const char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
> @@ -158,6 +168,7 @@ static PyTypeObject pyrf_comm_event__type = {
>  	.tp_doc		= pyrf_comm_event__doc,
>  	.tp_members	= pyrf_comm_event__members,
>  	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
> +	.tp_dealloc	= (destructor)pyrf_event__delete,
>  };
>  
>  static const char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
> @@ -190,6 +201,7 @@ static PyTypeObject pyrf_throttle_event__type = {
>  	.tp_doc		= pyrf_throttle_event__doc,
>  	.tp_members	= pyrf_throttle_event__members,
>  	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
> +	.tp_dealloc	= (destructor)pyrf_event__delete,
>  };
>  
>  static const char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
> @@ -225,6 +237,7 @@ static PyTypeObject pyrf_lost_event__type = {
>  	.tp_doc		= pyrf_lost_event__doc,
>  	.tp_members	= pyrf_lost_event__members,
>  	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
> +	.tp_dealloc	= (destructor)pyrf_event__delete,
>  };
>  
>  static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
> @@ -255,6 +268,7 @@ static PyTypeObject pyrf_read_event__type = {
>  	.tp_doc		= pyrf_read_event__doc,
>  	.tp_members	= pyrf_read_event__members,
>  	.tp_repr	= (reprfunc)pyrf_read_event__repr,
> +	.tp_dealloc	= (destructor)pyrf_event__delete,
>  };
>  
>  static const char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
> @@ -295,11 +309,14 @@ static PyObject*
>  tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
>  {
>  	struct tep_handle *pevent = field->event->tep;
> -	void *data = pe->sample.raw_data;
> +	void *data = pe->raw_data_copy;
>  	PyObject *ret = NULL;
>  	unsigned long long val;
>  	unsigned int offset, len;
>  
> +	if (data == NULL)
> +		return ret;
> +
>  	if (field->flags & TEP_FIELD_IS_ARRAY) {
>  		offset = field->offset;
>  		len    = field->size;
> @@ -346,6 +363,11 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
>  	field = tep_find_any_field(tp_format, str);
>  	return field ? tracepoint_field(pevent, field) : NULL;
>  }
> +#else // HAVE_LIBTRACEEVENT
> +static bool is_tracepoint(const struct pyrf_event *pevent __maybe_unused)
> +{
> +	return false;
> +}
>  #endif /* HAVE_LIBTRACEEVENT */
>  
>  static PyObject*
> @@ -369,6 +391,7 @@ static PyTypeObject pyrf_sample_event__type = {
>  	.tp_doc		= pyrf_sample_event__doc,
>  	.tp_members	= pyrf_sample_event__members,
>  	.tp_repr	= (reprfunc)pyrf_sample_event__repr,
> +	.tp_dealloc	= (destructor)pyrf_event__delete,
>  	.tp_getattro	= (getattrofunc) pyrf_sample_event__getattro,
>  };
>  
> @@ -407,6 +430,7 @@ static PyTypeObject pyrf_context_switch_event__type = {
>  	.tp_doc		= pyrf_context_switch_event__doc,
>  	.tp_members	= pyrf_context_switch_event__members,
>  	.tp_repr	= (reprfunc)pyrf_context_switch_event__repr,
> +	.tp_dealloc	= (destructor)pyrf_event__delete,
>  };
>  
>  static int pyrf_event__setup_types(void)
> @@ -478,8 +502,10 @@ static PyObject *pyrf_event__new(const union perf_event *event)
>  
>  	ptype = pyrf_event__type[event->header.type];
>  	pevent = PyObject_New(struct pyrf_event, ptype);
> -	if (pevent != NULL)
> +	if (pevent != NULL) {
>  		memcpy(&pevent->event, event, event->header.size);
> +		pevent->raw_data_copy = NULL;
> +	}
>  	return (PyObject *)pevent;
>  }
>  
> @@ -1020,6 +1046,14 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
>  
>  		err = evsel__parse_sample(evsel, event, &pevent->sample);
>  
> +		if (is_tracepoint(pevent) &&
> +		    pevent->sample.raw_size > 0 && !pevent->raw_data_copy) {
> +			// No need to check here, only when get_tracepoint_field gets
> +			// called, if ever, then it can fail getting the value for
> +			// a tracepoint field.
> +			pevent->raw_data_copy = memdup(pevent->sample.raw_data, pevent->sample.raw_size);
> +		}
> +
>  		/* Consume the even only after we parsed it out. */
>  		perf_mmap__consume(&md->core);
>  
> -- 
> 2.48.1
> 
