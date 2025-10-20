Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9C7303A27;
	Mon, 20 Oct 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962794; cv=none; b=SF5yXY27zwdAxWfUWAkqhjxUW0+s2wfX9vsCRrMDHz/drJvpd63oFpV8pJXYJm0EWfDV6A7Ditgae3hSUnN6il29tFOX8C5VRUgiprW7UFpD+Rt6I8UodhU3afxxAAfr5qfeFc5ydNsVy0bEmFm3TNBapa04f7VS+MkLUu44MC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962794; c=relaxed/simple;
	bh=xiucUNFP5MWuohojeRMYflL1g5SM9B4vl+aqFxwQbHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjp1USBcqhX2XLYjEFTAg4wXdOomWIr4JhFb4ovzNHMsy5fteAPnMti4AIcUs2s3Ux0aJTz6MlWOKksXZNbVKOJ4+K6m9KkmIbIJCOScnhSueYTlA2ToqKkGydi7Rss/VuMljZM/kMiHvyaQF4uUwY48etIPcUNa3yU71H7zt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EF421007;
	Mon, 20 Oct 2025 05:19:44 -0700 (PDT)
Received: from [10.1.26.49] (e132430.arm.com [10.1.26.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A55443F63F;
	Mon, 20 Oct 2025 05:19:48 -0700 (PDT)
Message-ID: <8d15e5a6-e80a-4707-a43a-4cbb6d810222@arm.com>
Date: Mon, 20 Oct 2025 13:19:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] tracing: Check for printable characters when
 printing field dyn strings
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>
References: <20251015173214.760495866@kernel.org>
 <20251015173550.062240695@kernel.org>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20251015173550.062240695@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 15-10-2025 18:32, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the "fields" option is enabled, it prints each trace event field
> based on its type. But a dynamic array and a dynamic string can both have
> a "char *" type. Printing it as a string can cause escape characters to be
> printed and mess up the output of the trace.

We faced the same issue when converting trace.dat to other formats that distinguish
between a byte buffer and an actual string. The current solution we have is to
reserve "char []" for actual string and use "u8 []"/"uint8_t []" for byte buffers.

Obviously it does not solve the problem for existing events but that could be worth
establishing a convention like that for new code and support it in trace_output.c ?
Most uses of trace data beyond direct printing would require knowing the data schema
from the header info, so value-based criteria are typically not suitable for that.

> For dynamic strings, test if there are any non-printable characters, and
> if so, print both the string with the non printable characters as '.', and
> the print the hex value of the array.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/trace_output.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 97db0b0ccf3e..718b255b6fd8 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -950,7 +950,9 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
>   	int offset;
>   	int len;
>   	int ret;
> +	int i;
>   	void *pos;
> +	char *str;
>   
>   	list_for_each_entry_reverse(field, head, link) {
>   		trace_seq_printf(&iter->seq, " %s=", field->name);
> @@ -977,8 +979,29 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
>   				trace_seq_puts(&iter->seq, "<OVERFLOW>");
>   				break;
>   			}
> -			pos = (void *)iter->ent + offset;
> -			trace_seq_printf(&iter->seq, "%.*s", len, (char *)pos);
> +			str = (char *)iter->ent + offset;
> +			/* Check if there's any non printable strings */
> +			for (i = 0; i < len; i++) {
> +				if (str[i] && !(isascii(str[i]) && isprint(str[i])))
> +					break;
> +			}
> +			if (i < len) {
> +				for (i = 0; i < len; i++) {
> +					if (isascii(str[i]) && isprint(str[i]))
> +						trace_seq_putc(&iter->seq, str[i]);
> +					else
> +						trace_seq_putc(&iter->seq, '.');
> +				}
> +				trace_seq_puts(&iter->seq, " (");
> +				for (i = 0; i < len; i++) {
> +					if (i)
> +						trace_seq_putc(&iter->seq, ':');
> +					trace_seq_printf(&iter->seq, "%02x", str[i]);
> +				}
> +				trace_seq_putc(&iter->seq, ')');
> +			} else {
> +				trace_seq_printf(&iter->seq, "%.*s", len, str);
> +			}
>   			break;
>   		case FILTER_PTR_STRING:
>   			if (!iter->fmt_size)

--

Douglas
