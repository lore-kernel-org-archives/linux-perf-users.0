Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D893233D79;
	Fri,  8 Nov 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094400; cv=none; b=GMB2gAWTpXNVh3f0YLOmJPd7DGQb9KbYbNUpLAY3HZvmzuXb4/vdhlOYzo7eANNd6GrEUCktMvCfbbvwOiaF5gvhf+uJ6yG6Tp5+36xWizhJRlSTVUDwSeMCT3C8SQj6TXUxVHPmsrwqqbx1UId/DQWYdgQxe/FaY89KR2i/9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094400; c=relaxed/simple;
	bh=RWAq5imig5BuE8MxfYG/xvE+1GqF5fh4w63VKs/ZWHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHSevvyEH7VyBicSz/+22qdpbXaJa5v0IcFeDdDOUsrEIIJRimWsfky7zyI4sghW6niDndIbJbIEGSCLYf1LcOlogdAHEbNwmIdUCweXo4lxsv+lXYTm7a7ypD/yytNN3wJI8AIQPp+5+/y/qo86L2ILg480vsjaGYojGQ5Hz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6/Ihc48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6/Ihc48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D808C4CECD;
	Fri,  8 Nov 2024 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731094399;
	bh=RWAq5imig5BuE8MxfYG/xvE+1GqF5fh4w63VKs/ZWHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6/Ihc48ieuINEATziNvQd81JRPkICXfg2kTq7nE+vu5UdjR6pysh3jiDY94D1f/a
	 3wODXZEsvGdhCUFOm7vF+YWNV1m/h3aem4FVJUR+j/KmCGOgcq9Pd8dEHgOT+vAcG3
	 H1TYZ6jiLUaszKJO1Vkq1OiWv2LP3cJeJ9/vDcB5i04M4C0oPVgtb1XVpMCue6fqv/
	 zcfbbrf2H42FmDSuJ/eR82XD09dL1TCb6Df3SHTXkfyo4fAQirYFLBDaxOqLA2i3Xe
	 1IAa3sg4YYDaQYxge+hcMBYSNrNSwdkS46DwiXxnERCZShTbLMdxc9eQN3jEBcxa8E
	 jmb4TFHre0U5g==
Date: Fri, 8 Nov 2024 11:33:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 2/7] perf hwmon_pmu: Add hwmon filename parser
Message-ID: <Zy5nfflbnkoG2fGY@google.com>
References: <20241108174936.262704-1-irogers@google.com>
 <20241108174936.262704-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108174936.262704-3-irogers@google.com>

On Fri, Nov 08, 2024 at 09:49:31AM -0800, Ian Rogers wrote:
> hwmon filenames have a specific encoding that will be used to give a
> config value. The encoding is described in:
> Documentation/hwmon/sysfs-interface.rst
> Add a function to parse the filename into consituent enums/ints that
> will then be amenable to config encoding.
> 
> Note, things are done this way to allow mapping names to config and
> back without the use of hash/dynamic lookup tables.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/Build       |   1 +
>  tools/perf/util/hwmon_pmu.c | 142 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/hwmon_pmu.h | 111 ++++++++++++++++++++++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 tools/perf/util/hwmon_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1eedead5f2f2..78b990c04f71 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -83,6 +83,7 @@ perf-util-y += pmu.o
>  perf-util-y += pmus.o
>  perf-util-y += pmu-flex.o
>  perf-util-y += pmu-bison.o
> +perf-util-y += hwmon_pmu.o
>  perf-util-y += tool_pmu.o
>  perf-util-y += svghelper.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> new file mode 100644
> index 000000000000..ee5fb1c41da3
> --- /dev/null
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "debug.h"
> +#include "hwmon_pmu.h"
> +#include <assert.h>
> +#include <stddef.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/kernel.h>
> +
> +const char * const hwmon_type_strs[HWMON_TYPE_MAX] = {

Can we make this array static?  I don't think it's used elsewhere.

> +	NULL,
> +	"cpu",
> +	"curr",
> +	"energy",
> +	"fan",
> +	"humidity",
> +	"in",
> +	"intrusion",
> +	"power",
> +	"pwm",
> +	"temp",
> +};
> +#define LONGEST_HWMON_TYPE_STR "intrusion"
> +
> +const char * const hwmon_item_strs[HWMON_ITEM__MAX] = {

Ditto.

Thanks,
Namhyung


> +	NULL,
> +	"accuracy",
> +	"alarm",
> +	"auto_channels_temp",
> +	"average",
> +	"average_highest",
> +	"average_interval",
> +	"average_interval_max",
> +	"average_interval_min",
> +	"average_lowest",
> +	"average_max",
> +	"average_min",
> +	"beep",
> +	"cap",
> +	"cap_hyst",
> +	"cap_max",
> +	"cap_min",
> +	"crit",
> +	"crit_hyst",
> +	"div",
> +	"emergency",
> +	"emergency_hist",
> +	"enable",
> +	"fault",
> +	"freq",
> +	"highest",
> +	"input",
> +	"label",
> +	"lcrit",
> +	"lcrit_hyst",
> +	"lowest",
> +	"max",
> +	"max_hyst",
> +	"min",
> +	"min_hyst",
> +	"mod",
> +	"offset",
> +	"pulses",
> +	"rated_max",
> +	"rated_min",
> +	"reset_history",
> +	"target",
> +	"type",
> +	"vid",
> +};
> +#define LONGEST_HWMON_ITEM_STR "average_interval_max"
> +
> +static int hwmon_strcmp(const void *a, const void *b)
> +{
> +	const char *sa = a;
> +	const char * const *sb = b;
> +
> +	return strcmp(sa, *sb);
> +}
> +
> +bool parse_hwmon_filename(const char *filename,
> +			  enum hwmon_type *type,
> +			  int *number,
> +			  enum hwmon_item *item,
> +			  bool *alarm)
> +{
> +	char fn_type[24];
> +	const char **elem;
> +	const char *fn_item = NULL;
> +	size_t fn_item_len;
> +
> +	assert(strlen(LONGEST_HWMON_TYPE_STR) < sizeof(fn_type));
> +	strlcpy(fn_type, filename, sizeof(fn_type));
> +	for (size_t i = 0; fn_type[i] != '\0'; i++) {
> +		if (fn_type[i] >= '0' && fn_type[i] <= '9') {
> +			fn_type[i] = '\0';
> +			*number = strtoul(&filename[i], (char **)&fn_item, 10);
> +			if (*fn_item == '_')
> +				fn_item++;
> +			break;
> +		}
> +		if (fn_type[i] == '_') {
> +			fn_type[i] = '\0';
> +			*number = -1;
> +			fn_item = &filename[i + 1];
> +			break;
> +		}
> +	}
> +	if (fn_item == NULL || fn_type[0] == '\0' || (item != NULL && fn_item[0] == '\0')) {
> +		pr_debug("hwmon_pmu: not a hwmon file '%s'\n", filename);
> +		return false;
> +	}
> +	elem = bsearch(&fn_type, hwmon_type_strs + 1, ARRAY_SIZE(hwmon_type_strs) - 1,
> +		       sizeof(hwmon_type_strs[0]), hwmon_strcmp);
> +	if (!elem) {
> +		pr_debug("hwmon_pmu: not a hwmon type '%s' in file name '%s'\n",
> +			 fn_type, filename);
> +		return false;
> +	}
> +
> +	*type = elem - &hwmon_type_strs[0];
> +	if (!item)
> +		return true;
> +
> +	*alarm = false;
> +	fn_item_len = strlen(fn_item);
> +	if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm")) {
> +		assert(strlen(LONGEST_HWMON_ITEM_STR) < sizeof(fn_type));
> +		strlcpy(fn_type, fn_item, fn_item_len - 6);
> +		fn_item = fn_type;
> +		*alarm = true;
> +	}
> +	elem = bsearch(fn_item, hwmon_item_strs + 1, ARRAY_SIZE(hwmon_item_strs) - 1,
> +		       sizeof(hwmon_item_strs[0]), hwmon_strcmp);
> +	if (!elem) {
> +		pr_debug("hwmon_pmu: not a hwmon item '%s' in file name '%s'\n",
> +			 fn_item, filename);
> +		return false;
> +	}
> +	*item = elem - &hwmon_item_strs[0];
> +	return true;
> +}
> diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> new file mode 100644
> index 000000000000..df0ab5ff7534
> --- /dev/null
> +++ b/tools/perf/util/hwmon_pmu.h
> @@ -0,0 +1,111 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +#ifndef __HWMON_PMU_H
> +#define __HWMON_PMU_H
> +
> +#include <stdbool.h>
> +
> +/**
> + * enum hwmon_type:
> + *
> + * As described in Documentation/hwmon/sysfs-interface.rst hwmon events are
> + * defined over multiple files of the form <type><num>_<item>. This enum
> + * captures potential <type> values.
> + *
> + * This enum is exposed for testing.
> + */
> +enum hwmon_type {
> +	HWMON_TYPE_NONE,
> +
> +	HWMON_TYPE_CPU,
> +	HWMON_TYPE_CURR,
> +	HWMON_TYPE_ENERGY,
> +	HWMON_TYPE_FAN,
> +	HWMON_TYPE_HUMIDITY,
> +	HWMON_TYPE_IN,
> +	HWMON_TYPE_INTRUSION,
> +	HWMON_TYPE_POWER,
> +	HWMON_TYPE_PWM,
> +	HWMON_TYPE_TEMP,
> +
> +	HWMON_TYPE_MAX
> +};
> +
> +/**
> + * enum hwmon_item:
> + *
> + * Similar to enum hwmon_type but describes the item part of a a sysfs filename.
> + *
> + * This enum is exposed for testing.
> + */
> +enum hwmon_item {
> +	HWMON_ITEM_NONE,
> +
> +	HWMON_ITEM_ACCURACY,
> +	HWMON_ITEM_ALARM,
> +	HWMON_ITEM_AUTO_CHANNELS_TEMP,
> +	HWMON_ITEM_AVERAGE,
> +	HWMON_ITEM_AVERAGE_HIGHEST,
> +	HWMON_ITEM_AVERAGE_INTERVAL,
> +	HWMON_ITEM_AVERAGE_INTERVAL_MAX,
> +	HWMON_ITEM_AVERAGE_INTERVAL_MIN,
> +	HWMON_ITEM_AVERAGE_LOWEST,
> +	HWMON_ITEM_AVERAGE_MAX,
> +	HWMON_ITEM_AVERAGE_MIN,
> +	HWMON_ITEM_BEEP,
> +	HWMON_ITEM_CAP,
> +	HWMON_ITEM_CAP_HYST,
> +	HWMON_ITEM_CAP_MAX,
> +	HWMON_ITEM_CAP_MIN,
> +	HWMON_ITEM_CRIT,
> +	HWMON_ITEM_CRIT_HYST,
> +	HWMON_ITEM_DIV,
> +	HWMON_ITEM_EMERGENCY,
> +	HWMON_ITEM_EMERGENCY_HIST,
> +	HWMON_ITEM_ENABLE,
> +	HWMON_ITEM_FAULT,
> +	HWMON_ITEM_FREQ,
> +	HWMON_ITEM_HIGHEST,
> +	HWMON_ITEM_INPUT,
> +	HWMON_ITEM_LABEL,
> +	HWMON_ITEM_LCRIT,
> +	HWMON_ITEM_LCRIT_HYST,
> +	HWMON_ITEM_LOWEST,
> +	HWMON_ITEM_MAX,
> +	HWMON_ITEM_MAX_HYST,
> +	HWMON_ITEM_MIN,
> +	HWMON_ITEM_MIN_HYST,
> +	HWMON_ITEM_MOD,
> +	HWMON_ITEM_OFFSET,
> +	HWMON_ITEM_PULSES,
> +	HWMON_ITEM_RATED_MAX,
> +	HWMON_ITEM_RATED_MIN,
> +	HWMON_ITEM_RESET_HISTORY,
> +	HWMON_ITEM_TARGET,
> +	HWMON_ITEM_TYPE,
> +	HWMON_ITEM_VID,
> +
> +	HWMON_ITEM__MAX,
> +};
> +
> +/**
> + * parse_hwmon_filename() - Parse filename into constituent parts.
> + *
> + * @filename: To be parsed, of the form <type><number>_<item>.
> + * @type: The type defined from the parsed file name.
> + * @number: The number of the type, for example there may be more than 1 fan.
> + * @item: A hwmon <type><number> may have multiple associated items.
> + * @alarm: Is the filename for an alarm value?
> + *
> + * An example of a hwmon filename is "temp1_input". The type is temp for a
> + * temperature value. The number is 1. The item within the file is an input
> + * value - the temperature itself. This file doesn't contain an alarm value.
> + *
> + * Exposed for testing.
> + */
> +bool parse_hwmon_filename(const char *filename,
> +			  enum hwmon_type *type,
> +			  int *number,
> +			  enum hwmon_item *item,
> +			  bool *alarm);
> +
> +#endif /* __HWMON_PMU_H */
> -- 
> 2.47.0.277.g8800431eea-goog
> 
