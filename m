Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8E347C7;
	Thu, 31 Oct 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402488; cv=none; b=VMoM+gbCiikWqaMe3EkmgqD9vc9x19W2Ii6YW8GrUL+RNiWyZn8HoLvUHgHFcl1b5oRFdF/IoYsqP3rrUX/1RxJ7Z0oQvfHYHLZDckMcso2BdwMfkaH8XmNC97iKdrhHbwQfGCBJ6KYl1cObTq80ZcgXzRG2vAd9602pA2yG158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402488; c=relaxed/simple;
	bh=dqd150MSKx2SBTWueiBk9xFBLjPz6rjwiqIyVTOFSac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCUtnF31tR8PTCmuiE5EmCbRMuvs3hM2AunSwxijlpKK/nZWCCx2VgxIUJ2vavP0r9jlQTTfvUMXBic4J0DPPAB0cEjWl/StjDZTTQotjW9hBW27zUzSliKU4BJFyDKFAIviZgNWGVVIADPsrXceaDegUPOJQ8ZQxYTA41Hp35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiMbIX9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiMbIX9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F60C4CEC3;
	Thu, 31 Oct 2024 19:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402488;
	bh=dqd150MSKx2SBTWueiBk9xFBLjPz6rjwiqIyVTOFSac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiMbIX9/fg6OxkrLYmNGr3Pd/RTnpiE/EXohTlGt7upybfvZyQa7r9AooFAM0+9Hh
	 lnBV/sdCL1xE8dRb0UdpUPrqRZYK9XHbtJJ2JF50nOmBhrzCbh9hBFc9S6O5o9ggg4
	 y+Rhv6FXjQymLU3IVDzH5Z9vObWIhm55y8f/DXEl6x9ydTkxedhb7zNDyP4R+Jma7O
	 qsg0N1OUGWDgDgOVI7kGqmgj/8aiOa2qXzPfAGYUVzqmWLTIF3s4xJyPX1LHGDD/i8
	 GtWmT4AadV9wq1+FDsTL5R95HuAPHgT30w9shZEiojvOdzhPy8uhtg10Odz2A6Pq1/
	 Hc/YXIGIFRQew==
Date: Thu, 31 Oct 2024 16:21:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 02/21] perf python: Constify variables and parameters
Message-ID: <ZyPYtE3dGYUFReVQ@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-3-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:33PM -0700, Ian Rogers wrote:
> Opportunistically constify variables and parameters when possible.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 55 +++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 02279ab4967c..13dad27169a0 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -62,7 +62,7 @@ struct pyrf_event {
>  	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
>  	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
>  
> -static char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
> +static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
>  
>  static PyMemberDef pyrf_mmap_event__members[] = {
>  	sample_members
> @@ -77,7 +77,7 @@ static PyMemberDef pyrf_mmap_event__members[] = {
>  	{ .name = NULL, },
>  };
>  
> -static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_mmap_event__repr(const struct pyrf_event *pevent)
>  {
>  	PyObject *ret;
>  	char *s;
> @@ -106,7 +106,7 @@ static PyTypeObject pyrf_mmap_event__type = {
>  	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
>  };
>  
> -static char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
> +static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
>  
>  static PyMemberDef pyrf_task_event__members[] = {
>  	sample_members
> @@ -119,7 +119,7 @@ static PyMemberDef pyrf_task_event__members[] = {
>  	{ .name = NULL, },
>  };
>  
> -static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_task_event__repr(const struct pyrf_event *pevent)
>  {
>  	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
>  				   "ptid: %u, time: %" PRI_lu64 "}",
> @@ -141,7 +141,7 @@ static PyTypeObject pyrf_task_event__type = {
>  	.tp_repr	= (reprfunc)pyrf_task_event__repr,
>  };
>  
> -static char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
> +static const char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
>  
>  static PyMemberDef pyrf_comm_event__members[] = {
>  	sample_members
> @@ -152,7 +152,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
>  	{ .name = NULL, },
>  };
>  
> -static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_comm_event__repr(const struct pyrf_event *pevent)
>  {
>  	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
>  				   pevent->event.comm.pid,
> @@ -170,7 +170,7 @@ static PyTypeObject pyrf_comm_event__type = {
>  	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
>  };
>  
> -static char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
> +static const char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
>  
>  static PyMemberDef pyrf_throttle_event__members[] = {
>  	sample_members
> @@ -181,9 +181,10 @@ static PyMemberDef pyrf_throttle_event__members[] = {
>  	{ .name = NULL, },
>  };
>  
> -static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_throttle_event__repr(const struct pyrf_event *pevent)
>  {
> -	struct perf_record_throttle *te = (struct perf_record_throttle *)(&pevent->event.header + 1);
> +	const struct perf_record_throttle *te = (const struct perf_record_throttle *)
> +		(&pevent->event.header + 1);
>  
>  	return PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
>  				   ", stream_id: %" PRI_lu64 " }",
> @@ -201,7 +202,7 @@ static PyTypeObject pyrf_throttle_event__type = {
>  	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
>  };
>  
> -static char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
> +static const char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
>  
>  static PyMemberDef pyrf_lost_event__members[] = {
>  	sample_members
> @@ -210,7 +211,7 @@ static PyMemberDef pyrf_lost_event__members[] = {
>  	{ .name = NULL, },
>  };
>  
> -static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_lost_event__repr(const struct pyrf_event *pevent)
>  {
>  	PyObject *ret;
>  	char *s;
> @@ -236,7 +237,7 @@ static PyTypeObject pyrf_lost_event__type = {
>  	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
>  };
>  
> -static char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
> +static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
>  
>  static PyMemberDef pyrf_read_event__members[] = {
>  	sample_members
> @@ -245,7 +246,7 @@ static PyMemberDef pyrf_read_event__members[] = {
>  	{ .name = NULL, },
>  };
>  
> -static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_read_event__repr(const struct pyrf_event *pevent)
>  {
>  	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
>  				   pevent->event.read.pid,
> @@ -266,7 +267,7 @@ static PyTypeObject pyrf_read_event__type = {
>  	.tp_repr	= (reprfunc)pyrf_read_event__repr,
>  };
>  
> -static char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
> +static const char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
>  
>  static PyMemberDef pyrf_sample_event__members[] = {
>  	sample_members
> @@ -274,7 +275,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
>  	{ .name = NULL, },
>  };
>  
> -static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
>  {
>  	PyObject *ret;
>  	char *s;
> @@ -289,13 +290,13 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
>  }
>  
>  #ifdef HAVE_LIBTRACEEVENT
> -static bool is_tracepoint(struct pyrf_event *pevent)
> +static bool is_tracepoint(const struct pyrf_event *pevent)
>  {
>  	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
>  }
>  
>  static PyObject*
> -tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
> +tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
>  {
>  	struct tep_handle *pevent = field->event->tep;
>  	void *data = pe->sample.raw_data;
> @@ -384,7 +385,7 @@ static PyTypeObject pyrf_sample_event__type = {
>  	.tp_getattro	= (getattrofunc) pyrf_sample_event__getattro,
>  };
>  
> -static char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
> +static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
>  
>  static PyMemberDef pyrf_context_switch_event__members[] = {
>  	sample_members
> @@ -394,7 +395,7 @@ static PyMemberDef pyrf_context_switch_event__members[] = {
>  	{ .name = NULL, },
>  };
>  
> -static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent)
>  {
>  	PyObject *ret;
>  	char *s;
> @@ -474,7 +475,7 @@ static PyTypeObject *pyrf_event__type[] = {
>  	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
>  };
>  
> -static PyObject *pyrf_event__new(union perf_event *event)
> +static PyObject *pyrf_event__new(const union perf_event *event)
>  {
>  	struct pyrf_event *pevent;
>  	PyTypeObject *ptype;
> @@ -542,7 +543,7 @@ static PySequenceMethods pyrf_cpu_map__sequence_methods = {
>  	.sq_item   = pyrf_cpu_map__item,
>  };
>  
> -static char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
> +static const char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
>  
>  static PyTypeObject pyrf_cpu_map__type = {
>  	PyVarObject_HEAD_INIT(NULL, 0)
> @@ -611,7 +612,7 @@ static PySequenceMethods pyrf_thread_map__sequence_methods = {
>  	.sq_item   = pyrf_thread_map__item,
>  };
>  
> -static char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
> +static const char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
>  
>  static PyTypeObject pyrf_thread_map__type = {
>  	PyVarObject_HEAD_INIT(NULL, 0)
> @@ -795,7 +796,7 @@ static PyMethodDef pyrf_evsel__methods[] = {
>  	{ .ml_name = NULL, }
>  };
>  
> -static char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
> +static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
>  
>  static PyTypeObject pyrf_evsel__type = {
>  	PyVarObject_HEAD_INIT(NULL, 0)
> @@ -1078,7 +1079,7 @@ static PySequenceMethods pyrf_evlist__sequence_methods = {
>  	.sq_item   = pyrf_evlist__item,
>  };
>  
> -static char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
> +static const char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
>  
>  static PyTypeObject pyrf_evlist__type = {
>  	PyVarObject_HEAD_INIT(NULL, 0)
> @@ -1100,10 +1101,12 @@ static int pyrf_evlist__setup_types(void)
>  
>  #define PERF_CONST(name) { #name, PERF_##name }
>  
> -static struct {
> +struct perf_constant {
>  	const char *name;
>  	int	    value;
> -} perf__constants[] = {
> +};
> +
> +static const struct perf_constant perf__constants[] = {
>  	PERF_CONST(TYPE_HARDWARE),
>  	PERF_CONST(TYPE_SOFTWARE),
>  	PERF_CONST(TYPE_TRACEPOINT),
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
