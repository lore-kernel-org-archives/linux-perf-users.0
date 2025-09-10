Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919128EB;
	Wed, 10 Sep 2025 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467345; cv=none; b=fqhtzf8x0xrpmtZrylqFVMZNsmRkVt+v2wJfwt7D0y6hDzMreqR205MlI+WVD8bd6hdW29LH4mQ5jFwbu4vmxfRf7J7Oo1WdVQr51jpcV0uqvdbPxsSPnxzM/xB5pZEmanwtKkT0m4xTSA+HVCJRelIEfpiTekcB72M7noDWRe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467345; c=relaxed/simple;
	bh=p544tyskxhMXXHIGtIgpsGHuS7qiqPp4PGaGoTa2Ig8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bPJbJQQvlAfBHdcIWvK/OOw4Qf5l+3He2GhjbQVtNr6pbLn5Je/6sdLnMTVp4ol2+jv+XC2hNhLqkaph6Xuz5MBLKERwled/NrT3gvcm9Vb94jOhi4u59re/dQ6SyVF1oI11J0YPZXX/nG3h0iN5KtoSVXf6m5ZzttXaXeVYP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZxu1pNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZxu1pNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C29C4CEF4;
	Wed, 10 Sep 2025 01:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757467344;
	bh=p544tyskxhMXXHIGtIgpsGHuS7qiqPp4PGaGoTa2Ig8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZxu1pNY/OK3nNWHUTCV+REZCpAYaxASKOOnuamiyzTX5kvPS+GVxYDhvkj0NYomA
	 /IE6WP/GesSkuo9RXzqzoFHdAsVIV0V3zvEj5n7TCiT85bEnHNZ1aN8Yb10N8tQeZW
	 LGRTolUhFIRSXe+8j3KEHtk+/dsbO3CjQxCT+thuFLvKHeJKWJLvdkAK5vyk220zMV
	 5jnL8NCHFUzAUHw/WyD31qKvnZpZf+mIpYs85W3i68xTdCYhMrjQzjprJcSQUqtpLQ
	 ro0U4mz/UhZ7whjqYxZkP/YXt3oFUag2wEEfRtdRV+brrwzU4pWVBJGmoKTdzeMFIZ
	 zn4sw2XnfsdHA==
Date: Wed, 10 Sep 2025 10:22:18 +0900
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
Subject: Re: [PATCH v2 4/6] tracing: wprobe: Add wprobe event trigger
Message-Id: <20250910102218.a767c63f91e7b4dcb68144ee@kernel.org>
In-Reply-To: <175708432404.64001.2572289500054005289.stgit@devnote2>
References: <175708427997.64001.11661389635019507808.stgit@devnote2>
	<175708432404.64001.2572289500054005289.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Sep 2025 23:58:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> +static void wprobe_unregister_trigger(char *glob,
> +				      struct event_trigger_data *data,
> +				      struct trace_event_file *file)
> +{
> +	lockdep_assert_held(&event_mutex);
> +
> +	if (wprobe_trigger_exist_same(data, file)) {
> +		list_del_rcu(&data->list);
> +		trace_event_trigger_enable_disable(file, 0);
> +		update_cond_flag(file);
> +	}
> +
> +	if (data && data->ops->free)
> +		data->ops->free(data);
> +}

This function is wrongly free the passed trigger_data instead of
trigger_data on the event. The passed @data is a dummy data to
find the actual data from @file.
Thanks Jinchao to find it!

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
