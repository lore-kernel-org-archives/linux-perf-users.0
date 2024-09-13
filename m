Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71941DA318;
	Fri, 13 Sep 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234828; cv=none; b=ju1PfsUtqhSpFX+1zmAh89+e61kOEKOvEVSKOkgJ7nLeJAuer/kJW9sdaoidWfGo76bVXu+ANKeW3XvNq4C0x3so0QwKeUHrTSNI5qN8xZVpFZCWGjPik41ZjnvmSgDgkywqmqUxLj/wXxPnGUrdqno85oX0aftBVc/Uy1X+n8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234828; c=relaxed/simple;
	bh=bhIGK7IxpvydMuPCGAEAoxNOfP77EmoHF2/LU4/piIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6Ql6PBf66ATmvzzoa74gShkJ+49SbUQ7XBepi0GEZUYLfPU0c9KZzrH2uawhjhEgDZA9P/IieCXqq/Q8p61bWcBzTxhTLNQD163vKtdM86do7AmR6ciRRGwYx2oS6fseF+O7c21wvwDtpvmZls9qYxJPrCBy7+dbJaQ/GxRgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7649213D5;
	Fri, 13 Sep 2024 06:40:55 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2624D3F73B;
	Fri, 13 Sep 2024 06:40:23 -0700 (PDT)
Message-ID: <cfcacd5c-797e-4190-bf31-5aeaf1675f11@arm.com>
Date: Fri, 13 Sep 2024 14:40:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] perf scripting python: Add function to get a
 config value
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-4-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240912151143.1264483-4-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/24 16:11, James Clark wrote:
> Warning: EXTERNAL SENDER, use caution when opening links or attachments.
> 
> 
> This can be used to get config values like which objdump Perf uses for
> disassembly.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>   .../perf/Documentation/perf-script-python.txt |  2 +-
>   .../scripts/python/Perf-Trace-Util/Context.c  | 11 ++++++++++
>   tools/perf/util/config.c                      | 22 +++++++++++++++++++
>   tools/perf/util/config.h                      |  1 +
>   4 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
> index 13e37e9385ee..27a1cac6fe76 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt
> @@ -624,7 +624,7 @@ as perf_trace_context.perf_script_context .
>    perf_set_itrace_options(context, itrace_options) - set --itrace options if they have not been set already
>    perf_sample_srcline(context) - returns source_file_name, line_number
>    perf_sample_srccode(context) - returns source_file_name, line_number, source_line
> -
> + perf_config_get(config_name) - returns the value of the named config item, or None if unset
> 
>   Util.py Module
>   ~~~~~~~~~~~~~~
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> index 3954bd1587ce..01f54d6724a5 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> @@ -12,6 +12,7 @@
>   #define PY_SSIZE_T_CLEAN
> 
>   #include <Python.h>
> +#include "../../../util/config.h"
>   #include "../../../util/trace-event.h"
>   #include "../../../util/event.h"
>   #include "../../../util/symbol.h"
> @@ -182,6 +183,15 @@ static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
>          return perf_sample_src(obj, args, true);
>   }
> 
> +static PyObject *__perf_config_get(PyObject *obj, PyObject *args)
> +{
> +       const char *config_name;
> +
> +       if (!PyArg_ParseTuple(args, "s", &config_name))
> +               return NULL;
> +       return Py_BuildValue("s", perf_config_get(config_name));
> +}
> +
>   static PyMethodDef ContextMethods[] = {
>   #ifdef HAVE_LIBTRACEEVENT
>          { "common_pc", perf_trace_context_common_pc, METH_VARARGS,
> @@ -199,6 +209,7 @@ static PyMethodDef ContextMethods[] = {
>            METH_VARARGS, "Get source file name and line number."},
>          { "perf_sample_srccode", perf_sample_srccode,
>            METH_VARARGS, "Get source file name, line number and line."},
> +       { "perf_config_get", __perf_config_get, METH_VARARGS, "Get perf config entry"},
>          { NULL, NULL, 0, NULL}
>   };
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 7a650de0db83..68f9407ca74b 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -912,6 +912,7 @@ void set_buildid_dir(const char *dir)
>   struct perf_config_scan_data {
>          const char *name;
>          const char *fmt;
> +       const char *value;
>          va_list args;
>          int ret;
>   };
> @@ -939,3 +940,24 @@ int perf_config_scan(const char *name, const char *fmt, ...)
> 
>          return d.ret;
>   }
> +
> +static int perf_config_get_cb(const char *var, const char *value, void *data)
> +{
> +       struct perf_config_scan_data *d = data;
> +
> +       if (!strcmp(var, d->name))
> +               d->value = value;
> +
> +       return 0;
> +}
> +
> +const char *perf_config_get(const char *name)
> +{
> +       struct perf_config_scan_data d = {
> +               .name = name,
> +               .value = NULL,
> +       };
> +
> +       perf_config(perf_config_get_cb, &d);
> +       return d.value;
> +}
> diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
> index 2e5e808928a5..9971313d61c1 100644
> --- a/tools/perf/util/config.h
> +++ b/tools/perf/util/config.h
> @@ -30,6 +30,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
>   int perf_default_config(const char *, const char *, void *);
>   int perf_config(config_fn_t fn, void *);
>   int perf_config_scan(const char *name, const char *fmt, ...) __scanf(2, 3);
> +const char *perf_config_get(const char *name);
>   int perf_config_set(struct perf_config_set *set,
>                      config_fn_t fn, void *data);
>   int perf_config_int(int *dest, const char *, const char *);
> --
> 2.34.1
> 
