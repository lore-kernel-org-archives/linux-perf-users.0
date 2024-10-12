Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF61B978;
	Sat, 12 Oct 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766328; cv=none; b=pvswZXBnGo6uRHNGvLXjS9mcaKnCQsWZEgw6nOcjM28/jBBUB/cqX+lx1lzJhWSyZwORIC8xmm5ls6PCQHQUrGrDNNXWKfV+xtU4OPTNCV8Fd5TSBEiIqnEwC5E/vygvlR3cBgIUa+SsvFm3ltEDE/wT1Rh9YbJkYpC2KlZqOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766328; c=relaxed/simple;
	bh=KoWpYjfSgjsxVdsNj8a688jDCeDuesQdzp11PyvM6lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kCSKO3g7SWuKW2Ogx3kBvwqkeEt4KlDBkgF3GLyNcaFhQR8dW38WPBgJtUM437Dp4f7QWu4MDthabA3LIuNQiNG7/2qtyk0n9F10+GvVLD0BZWZgcb4zNOLYoVMngOGtNfuI9r7prpRq8PXnrINKEWwRMsfkoVA7XWnIXKRo+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EE3DA7;
	Sat, 12 Oct 2024 13:52:35 -0700 (PDT)
Received: from [10.57.23.14] (unknown [10.57.23.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 052293F58B;
	Sat, 12 Oct 2024 13:52:03 -0700 (PDT)
Message-ID: <0e98dea9-cdd1-445c-813b-1fa652b72a7d@arm.com>
Date: Sat, 12 Oct 2024 21:52:04 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] perf probe: Improve log for long event name
 failure
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241012154428.888373-1-leo.yan@arm.com>
 <20241012154428.888373-4-leo.yan@arm.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241012154428.888373-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2024 4:44 PM, Leo Yan wrote:
> If a symbol name is longer than the maximum event length (64 bytes), the
> perf tool reports error:
> 
>   # perf probe -x test_cpp_mangle --add "this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
>     snprintf() failed: -7; the event name nbase='this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)' is too long
>     Error: Failed to add events.
> 
> An information is missed in the log that the symbol name and the event
> name can be set separately. Especially, this is recommended for adding
> probe for a long symbol.
> 
> This commit refines the log for reminding event syntax.
> 
> After:
> 
>   # perf probe -x test_cpp_mangle --add "this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
>     snprintf() failed: -7; the event name is too long (>= 64 bytes)
>       Try to set event with syntax "[GROUP:]EVENT=this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
>       Error: Failed to add events.

As the printed log is not suitable for all cases in this patch, please
ignore this patch and directly review version 3 for a updated log.

Thanks,
Leo

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/probe-event.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 224ec6818803..441daf4fb321 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2760,7 +2760,9 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
>  	/* Try no suffix number */
>  	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
>  	if (ret < 0) {
> -		pr_warning("snprintf() failed: %d; the event name nbase='%s' is too long\n", ret, nbase);
> +		pr_warning("snprintf() failed: %d; the event name is too long (>= %d bytes)\n"
> +			   "  Try to set event with syntax \"[GROUP:]EVENT=%s\"\n",
> +			   ret, MAX_EVENT_NAME_LEN, nbase);
>  		goto out;
>  	}
>  	if (!strlist__has_entry(namelist, buf))
