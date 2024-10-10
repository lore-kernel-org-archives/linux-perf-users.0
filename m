Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAE1CDFC3;
	Thu, 10 Oct 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574453; cv=none; b=csHS+TrXR36koNVkWapqpoW5wnAxshgn03N1twCTD3yMASVcPnKxehHY8CQANPuBt0gyCYAXSO+LdI0N7obG0ASumHNBFErxesbmJdO0kchOsTQKMifv1+aCvX2Cd7LDThcwmMPr1lyHpBe0TdsYB6vxTeMAMEzIqt6vYFd/SCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574453; c=relaxed/simple;
	bh=/rdx2lmHwXayLf3Xya3v9K3O6//R9jM089t+Y/bxExM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OdXzUTlueUrjXQ+U4dfdB2T2p0ei2fdMW70sh/gfQ/ZKbU9ME+BzmTHnD6efK8OavCcXAAc/QTj/v8rqKMl5tiGxQnoQugkmEXSaQR9AWrFcHKh6Dkdg9om2OPeF2tp2lLGq0H4ILgH042jG4AOYhwd0mVmSFU1RjoMikZEWYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1wHW9/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1wHW9/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ECEC4CEC5;
	Thu, 10 Oct 2024 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728574453;
	bh=/rdx2lmHwXayLf3Xya3v9K3O6//R9jM089t+Y/bxExM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O1wHW9/SCg7bA6jlVYcbaMhZXzHM9quTw0U8tEj5Q8jv9dyhFPXh33G2ovYXPF+s4
	 6Ds+2+gXeIyBFtqbj4Ake38O1t5qw7TtgK0M+pxzRCg475S2ESPS6lHpV8TMe/FFPf
	 uvJf/Y5hh22pp76Ezac+d+ePebg6UCmgnpGl0UKy6RKFl4hb/sCvDGRATxiAsFMcFP
	 VCjvx+tpixJvLlJbCChfRUZRNx51bH85JqbCOnLt/TWhhxcijYt717zMDtAIY4g765
	 pdXqTL3OBQ/RgtrWqm/XPuHjZ+fKtwbljHxlGpOVHM+nweld2ib+rH169s58xGGd7b
	 F1z5BqYTeVZ/w==
Date: Fri, 11 Oct 2024 00:34:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Dima
 Kogan <dima@secretsauce.net>, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf probe: Generate hash event for long symbol
Message-Id: <20241011003408.f9bacf4e5899e88a94c3d7cd@kernel.org>
In-Reply-To: <20241007141116.882450-4-leo.yan@arm.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
	<20241007141116.882450-4-leo.yan@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 15:11:16 +0100
Leo Yan <leo.yan@arm.com> wrote:

> If a symbol name is longer than the maximum event length (64 bytes),
> generate an new event name with below combination:
> 
>   TruncatedSymbol + '_' + HashString + '__return' + '\0'
>     `> 46B        + 1B  +   8B       +    8B      + 1B   = 64 Bytes.
> 
> With this change, a probe can be injected for long symbol.
> 
> Before:
> 
>   # nm test_cpp_mangle | grep -E "print_data|Point"
>   0000000000000cac t _GLOBAL__sub_I__Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi
>   0000000000000b50 T _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzR5Point
>   0000000000000b14 T _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi
> 
>   # perf probe -x test_cpp_mangle --add \
>         "_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi"
>   snprintf() failed: -7; the event name nbase='_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi' is too long
>   Error: Failed to add events.
> 
> After:
> 
>   # perf probe -x test_cpp_mangle --add \
> 	"_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi"
> 
>   Probe event='_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi' is too long (>= 64 bytes).
>   Generate hashed event name='_Z62this_is_a_very_very_long_print_data_abcdef_91f40679'
> 
>   Added new event:
>     probe_test_cpp_mangle: _Z62this_is_a_very_very_long_print_data_abcdef_91f40679
>     (on _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi in /mnt/test_cpp_mangle)
> 
>   You can now use it in all perf tools, such as:
> 
>       perf record -e probe_test_cpp_mangle: _Z62this_is_a_very_very_long_print_data_abcdef_91f40679 -aR sleep 1

OK, personally, I recommend you to specify event name instead of generating
long event name in this case. But I understand sometimes this kind of feature
is good for someone.

BTW, I would like to confirm. Can't we demangle the symbol name and parse it?

Thank you,

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/probe-event.c | 42 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 71acea07cb46..bacd29b95c75 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2837,6 +2837,32 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
>  /* Defined in kernel/trace/trace.h */
>  #define MAX_EVENT_NAME_LEN	64
>  
> +static char *probe_trace_event__hash_event(const char *event)
> +{
> +	char *str = NULL;
> +	size_t hash;
> +
> +	str = malloc(MAX_EVENT_NAME_LEN);
> +	if (!str)
> +		return NULL;
> +
> +	hash = str_hash(event);
> +
> +	/*
> +	 * Reserve characters for the "__return" suffix for the return probe.
> +	 * Thus the string buffer (64 bytes) are used for:
> +	 *   Truncated event:  46 bytes
> +	 *   '_'            :   1 byte
> +	 *   hash string    :   8 bytes
> +	 *   reserved       :   8 bytes (for suffix "__return")
> +	 *   '\0'           :   1 byte
> +	 */
> +	strncpy(str, event, 46);
> +	/* '_' + hash string + '\0' */
> +	snprintf(str + 46, 10, "_%lx", hash);
> +	return str;
> +}
> +
>  /* Set new name from original perf_probe_event and namelist */
>  static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  				       struct perf_probe_event *pev,
> @@ -2844,7 +2870,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  				       bool allow_suffix)
>  {
>  	const char *event, *group;
> -	char *buf;
> +	char *buf, *hash_event = NULL;
>  	int ret;
>  
>  	buf = malloc(MAX_EVENT_NAME_LEN);
> @@ -2864,6 +2890,19 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  			event = pev->point.function;
>  		else
>  			event = tev->point.realname;
> +
> +		if (strlen(event) >= MAX_EVENT_NAME_LEN) {
> +			pr_warning("Probe event='%s' is too long (>= %d bytes).\n",
> +				   event, MAX_EVENT_NAME_LEN);
> +
> +			hash_event = probe_trace_event__hash_event(event);
> +			if (!hash_event) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			pr_warning("Generate hashed event name='%s'\n", hash_event);
> +			event = hash_event;
> +		}
>  	}
>  	if (pev->group && !pev->sdt)
>  		group = pev->group;
> @@ -2903,6 +2942,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  		strlist__add(namelist, event);
>  
>  out:
> +	free(hash_event);
>  	free(buf);
>  	return ret < 0 ? ret : 0;
>  }
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
