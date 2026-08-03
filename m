Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933222571A0;
	Mon,  3 Aug 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718328; cv=none; b=a/HruugkMZSu/SjcKAxLDHIhiSywRVJrgfRV3ufA0tI7uYQHef4iIImmbxPsMnqpKPD+oFKWupbuNgKPy5HVplzve0OaebqWJdVPpcjqDaWtZtMABWNtutJO6KwlTPI7z7WTEwh6TAivMo5UhaSAfgN1PKB5jgilyQaOsvK8FjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718328; c=relaxed/simple;
	bh=uWEInhO7shXwx4VB2iAZk/NprwRvqYHoQSDlBFjCF0Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qzYCLqSstF/8HVVrHHT65agE1caWbLxmlrpchwIxYHxNaVeGgxg9ukg+Op9O7UP1yU6U8M3BFFUxP6CtrumhA4Ealj29VTVv5Js2/8Xq4kpoqhhjYSiOvzVzsWhEIXhfKBK9DIEuvP+fmWe4KToIcTYfBUpgqzKx3jsm1Di8Huc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYa127XI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYa127XI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB2B1F000E9;
	Mon,  3 Aug 2026 00:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785718327;
	bh=5FVnlOSd1v9C4sUZR1eg963cdHAOaz4d6tFY0CF5mPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NYa127XI8WJh7R5C2zr8TVnMQUnPmgf0lp1vNUvV3WZxbzseKYcUxPFdXa1CdK/e/
	 pZAe37jH3Y9o1IbIILObyjpU7p+Se/ALcuGjbMWIFHGzU7i2VcrUBh2mC35GUmhEyx
	 PIenH7+TH4kPFYw9kar+PT6ZJl3sJdJYmAuju4L5TbnTWvJzLg0YRpdSekvXOT+cqX
	 mBaP0jN6URNtJXJolbHXjzadjnZ8H2Y3COvHX2rd3OAef8CQLuH4sauIAN6JsrL6Xw
	 Jzbr4btnkikrdyZ4x5yPEgvI4G0zhJ3pla81u+6sR6Z0ia8xiwgu0h852NQ2PwHDzA
	 g0Rc0F4dDVGiA==
Date: Mon, 3 Aug 2026 09:52:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 08/11] tracing: wprobe: Add wprobe event trigger
Message-Id: <20260803095201.72a9f322b65acf240f050329@kernel.org>
In-Reply-To: <178565879572.714490.13763586507727190682.stgit@devnote2>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
	<178565879572.714490.13763586507727190682.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 17:19:55 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add wprobe event trigger to set and clear the watch event dynamically.
> This allows us to set an watchpoint on a given local variables and
> a slab object instead of static objects.
> 
> The trigger syntax is below:
> 
>   - set_wprobe:WPROBE:FIELD[+OFFSET][:COUNT] [if FILTER]
>   - clear_wprobe:WPROBE[:FIELD[+OFFSET]][:COUNT] [if FILTER]
> 
> set_wprobe sets the address pointed by FIELD[+offset] to the WPROBE
> event. The FIELD is the field name of trigger event.
> clear_wprobe clears the watch address of WPROBE event. If the FIELD
> option is specified, it clears only if the current watch address is
> same as the given FIELD[+OFFSET] value.
> COUNT is the max number of activating trigger.
> 
> The set_wprobe trigger does not change the type and length, these
> must be set when creating a new wprobe.
> 
> Also, the WPROBE event must be disabled when setting the new trigger
> and it will be busy afterwards. Recommended usage is to add a new
> wprobe at NULL address and keep disabled.
> 
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v11:
>   - Use new modify_local_hw_breakpoint_addr() API.
>   - Add tracepoint_synchronize_unregister() in wprobe_unregister_trigger()
>     and parse error path.
>   - Safely check tw->bp_event for NULL in trace_wprobe_update_local() to
>     prevent race conditions.
>   - Use event_trigger_data::private_data_free.
>   - Add count option support.

Oops, I made a mistake on this count support.

> +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *glob, char *cmd,
> +				    char *param_and_filter)
> +{
[...]
> +	/* count is optional, "unlimited" by default */
> +	count_str = strsep(&param, ":");
> +	if (count_str) {
> +		long val;
> +
> +		if (strcmp(count_str, "unlimited")) {
> +			if (str_has_prefix(count_str, "count="))
> +				count_str += 6;
> +			if (kstrtol(count_str, 0, &val) < 0)
> +				return -EINVAL;
> +			wprobe_data->count = val;
> +		}
> +	}

This handles count option, but

[...]
> +	ret = event_trigger_parse_num(param, trigger_data);
> +	if (ret)
> +		return ret;

Here we parse the count again. However, this trigger_data->count
is ignored.

I think the new wprobe_trigger_data->count is redundant. it should
use trigger_data->count.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
