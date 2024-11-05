Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBA21EBA09;
	Tue,  5 Nov 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832760; cv=none; b=DDMUMnngw3rUkKi0i+B9wOw1y5RDyXeyz/g7E6Sika44wfp2YQCDrWNZgD3JZ86SyvZVu4izcRBO0N3GmLKkt1ryM9TVIEljti/qE6JS3QJKbF8i6H989JGxr/dIWU3PlL3I33EyvLSjKNjd+usUwFxnDZKaOC0QUs0VhpjuRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832760; c=relaxed/simple;
	bh=PbzA6tBA7tp24gQ9EyUAG0z7pRLYge4MVlUArydjwn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjEZloEYm/glqQCgAdABvHJIdIqPHo39VX07R3YdYmqg1ARPdmoURN1TNOmN2hrXbKE/vz1TmUa5dTfVAmVp86azSFLv+CsjFoiOaKGpKZ+hQigQNbT9I4lQhUF78l2waRabgLl0B8bHaIIUd5cEYNqdT42StVnMF3XeE2B+3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpEusYYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpEusYYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2469C4CECF;
	Tue,  5 Nov 2024 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730832760;
	bh=PbzA6tBA7tp24gQ9EyUAG0z7pRLYge4MVlUArydjwn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpEusYYPfaNYutFnpxzsg6U0n//pbeMUX0FiPey9Efl2luYRPp+BGrJvP26TQXkRI
	 JurSs4FzJMbnewZH2Hk3oBDmhk3g2JwoL7dPIt56uCaBVA+yco0OS122XVvlH/HG37
	 lfcrVsYNelW1hJGbo3uQ9KBVo6ntVbM/3QCFnAjS9wAPkyRyW4PNlQoG8IweeCUCkt
	 tGyPxVSMOO2YW8OA+EmlXv5gtZWSmXFeEO8mEzAaaSsPbJuBwlVhe6vDKRklLsxYIv
	 NvSF7DT/tIINuy2cieL5ihcWGCJMX9txWdfUFO8GH4Z6eZXx/qoNBMHqYFQrBttRnW
	 hrtndSaVbQ4kA==
Date: Tue, 5 Nov 2024 15:52:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Benjamin Peterson <benjamin@engflow.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	howardchu95@gmail.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Subject: Re: [PATCH v3] perf trace: avoid garbage when not printing a trace
 event's arguments
Message-ID: <Zyppchn73qy-t7bc@x1>
References: <ZyV0a6e_46R9pmQw@x1>
 <20241103204816.7834-1-benjamin@engflow.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241103204816.7834-1-benjamin@engflow.com>

On Sun, Nov 03, 2024 at 08:48:16PM +0000, Benjamin Peterson wrote:
> trace__fprintf_tp_fields may not print any tracepoint arguments. E.g., if the
> argument values are all zero. Previously, this would result in a totally
> uninitialized buffer being passed to fprintf, which could lead to garbage on the
> console. Fix the problem by passing the number of initialized bytes fprintf.
> 
> Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
> Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> Tested-by: Howard Chu <howardchu95@gmail.com>

How did you guys tested this? Was this found by visual inspection alone?
It clearly is correct, but I had to use:

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e663be6f04e70640..a32eafd000fa99e6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3033,7 +3033,7 @@ static void bpf_output__fprintf(struct trace *trace,
 static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
 				       struct thread *thread, void *augmented_args, int augmented_args_size)
 {
-	char bf[2048];
+	char bf[2048] = "garbage";
 	size_t size = sizeof(bf);
 	const struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field = tp_format ? tp_format->format.fields : NULL;
@@ -3053,7 +3053,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		.show_string_prefix = trace->show_string_prefix,
 	};
 
-	for (; field && arg; field = field->next, ++syscall_arg.idx, bit <<= 1, ++arg) {
+	for (field = field->next; field && arg; field = field->next, ++syscall_arg.idx, bit <<= 1, ++arg) {
 		if (syscall_arg.mask & bit)
 			continue;
 
@@ -3097,7 +3097,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%s", bf);
+	return printed + fprintf(trace->output, "printed=%zd, %s", printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,

To skip the first arg as a perf probe would still have one argument (the
probe addr), i.e.  what tracepoint did you use to test this that has all
its args as zeroes? If we really can generate something like that we
could use it in a 'perf test' entry.

And then come up with:

root@x1:/home/acme/c# cat loop.c 
#include <unistd.h>

static int function(int i, int j, int k, int l, int m)
{
	sleep(1);
	return i + j + k + l + m;
}

int main(void)
{
	unsigned long long total = 0;

	for (int i = 0; i < 3; i++)
		total += function(0, 0, 0, 0, 0);

	return total;
}
root@x1:/home/acme/c# cc -g -o loop loop.c
root@x1:/home/acme/c# perf probe -x ./loop function i j k l m
Target program is compiled without optimization. Skipping prologue.
Probe on address 0x401126 to force probing at the function entry.

Added new event:
  probe_loop:function  (on function in /home/acme/c/loop with i j k l m)

You can now use it in all perf tools, such as:

	perf record -e probe_loop:function -aR sleep 1

root@x1:/home/acme/c# perf trace -e clock_nanosleep,probe_loop:function ./loop
     0.000 (         ): loop/846057 probe_loop:function(printed=0, garbage)
     0.037 (1000.154 ms): loop/846057 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd43aaa290) = 0
  1000.232 (         ): loop/846057 probe_loop:function(printed=0, garbage)
  1000.253 (1000.123 ms): loop/846057 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd43aaa290) = 0
  2000.416 (         ): loop/846057 probe_loop:function(printed=0, garbage)
^Croot@x1:/home/acme/c#

Anyway, with your patch and this one on top:

⬢ [acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index de191ef425fe574a..5c9f3fdb9e5732f4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3033,7 +3033,7 @@ static void bpf_output__fprintf(struct trace *trace,
 static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
                                       struct thread *thread, void *augmented_args, int augmented_args_size)
 {
-       char bf[2048];
+       char bf[2048] = "garbage";
        size_t size = sizeof(bf);
        const struct tep_event *tp_format = evsel__tp_format(evsel);
        struct tep_format_field *field = tp_format ? tp_format->format.fields : NULL;
@@ -3053,7 +3053,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
                .show_string_prefix = trace->show_string_prefix,
        };
 
-       for (; field && arg; field = field->next, ++syscall_arg.idx, bit <<= 1, ++arg) {
+       for (field = field->next; field && arg; field = field->next, ++syscall_arg.idx, bit <<= 1, ++arg) {
                if (syscall_arg.mask & bit)
                        continue;
 
⬢ [acme@toolbox perf-tools-next]$

root@x1:/home/acme/c# perf probe -x ./loop function i j k l m
Target program is compiled without optimization. Skipping prologue.
Probe on address 0x401126 to force probing at the function entry.

Added new event:
  probe_loop:function  (on function in /home/acme/c/loop with i j k l m)

You can now use it in all perf tools, such as:

	perf record -e probe_loop:function -aR sleep 1

root@x1:/home/acme/c# perf trace -e clock_nanosleep,probe_loop:function ./loop
     0.000 (         ): loop/849218 probe_loop:function()
     0.033 (1000.109 ms): loop/849218 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7fffe6dc38e0) = 0
  1000.182 (         ): loop/849218 probe_loop:function()
  1000.200 (1000.142 ms): loop/849218 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7fffe6dc38e0) = 0
  2000.387 (         ): loop/849218 probe_loop:function()
  2000.413 (1000.151 ms): loop/849218 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7fffe6dc38e0) = 0
root@x1:/home/acme/c#

To see the zeroes:

root@x1:/home/acme/c# perf config trace.show_zeros=1
root@x1:/home/acme/c# perf trace -e probe_loop:function ./loop
     0.000 loop/849542 probe_loop:function(i: 0, j: 0, k: 0, l: 0, m: 0)
  1000.338 loop/849542 probe_loop:function(i: 0, j: 0, k: 0, l: 0, m: 0)
  2000.542 loop/849542 probe_loop:function(i: 0, j: 0, k: 0, l: 0, m: 0)
root@x1:/home/acme/c#

So,

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d3f11b90d025..5af55f4192b5 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
>  	}
>  
> -	return printed + fprintf(trace->output, "%s", bf);
> +	return printed + fprintf(trace->output, "%.*s", (int)printed, bf);
>  }
>  
>  static int trace__event_handler(struct trace *trace, struct evsel *evsel,
> -- 
> 2.39.5
> 
