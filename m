Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591D15B102;
	Sun, 18 May 2025 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747590709; cv=none; b=JATkO+VfwJPM4xtWlYqwvC6hwgzbRNcmUwq3Owj0mCk45GcnX0fMijSEx/ortET4xSAWh/z8a0NMSqzcPeZHuxpXLZ9yULZ40bFNrUOkAk9XhgxE3G7fP20sCfkdQjtUFnX/RQ6ncHioDT64SqKGdZHHjVM2t27sCmWbU3SG76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747590709; c=relaxed/simple;
	bh=SMiqwSNrbD6/e8s/PbJRcyKXJ/c2KljONFhW7rWYVfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9kSHjaU9+Pp5kr205D/0+19znv+ClAmCHA8hpyGUR2BglAb/NiVhNO1orSX5paP6eOaNPBkxkjkRzsTGG8ymeuB0GEyqyoWj7+mYebMZ+W/Rqq44bBFcvLBvVNe58zIiSJEQ0/+izyn2Om8s2446kxlc6GvemgxqILdZEXg97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+fNoLU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+fNoLU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82791C4CEE7;
	Sun, 18 May 2025 17:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747590709;
	bh=SMiqwSNrbD6/e8s/PbJRcyKXJ/c2KljONFhW7rWYVfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+fNoLU2V1/pzxDZavz7TjxQCEdvnahSqNOqjZ86ToAduPYig1hMToJnClvM6txe8
	 xSGpnmjyjjCWylLXGR1J0/q3zsLYxR+as0Y1PNbay03CkrZ48ZpEn6Lm+6EWpdNJNZ
	 FlniMLAQpJ5OT+98sj/dQexEwiRoiOeByXQsR4lpozzsD1lrhYDrYtOi34nRvX3uTi
	 9P0B+f2Vwvq6CF5wD5TabBbwUUbBCKY2sJy+O2PmEpmbC+y/kY07VxclVcN6JlmM4s
	 fPoVrgHUAXLq6n0CjzuIhzxi/RbaUd5PSysxjVYo4+CCYcWcM+9caXNoTNSivDCJkA
	 I456LbsoDAoXQ==
Date: Sun, 18 May 2025 10:51:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] perf test trace BTF: Use --sort-events in BTF
 general tests
Message-ID: <aCoeM4qTk5YnGIsT@google.com>
References: <20250517163230.1237469-1-howardchu95@gmail.com>
 <20250517163230.1237469-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517163230.1237469-6-howardchu95@gmail.com>

On Sat, May 17, 2025 at 09:32:30AM -0700, Howard Chu wrote:
> Without the '--sort-events' flag, perf trace doesn't receive and process
> events based on their arrival time, thus PERF_RECORD_COMM event that
> assigns the correct comm to a PID, may be delivered and processed after
> regular samples, causing trace outputs not having a 'comm', e.g.
> 'mv', instead, having the default PID placeholder, e.g. ':14514'.
> 
> Hopefully this answers Namhyung's question in [1].

Thanks, it makes sense.  Maybe it migrated to another CPU after exec.

> 
> You can simply justify the statement with this diff:
> 
> ---8<---

Please do not use this in the format patch emails.  This makes git treat
the following contents as commit body so it'll be added to the commit as
if it's a valid change.  Maybe adding some spaces at the beginning of
each line help.  But I think it's better if you publish it somewhere else
and add a link instead.

Thanks,
Namhyung

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index edab0ff60b3c..f042afed5b74 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4204,6 +4204,7 @@ static int trace__deliver_event(struct trace *trace, union perf_event *event)
>  {
>  	int err;
> 
> +	printf("[debug] deliver\n");
>  	if (!trace->sort_events)
>  		return __trace__deliver_event(trace, event);
> 
> diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> index 8aa456d7c2cd..76df9886429e 100644
> --- a/tools/perf/util/comm.c
> +++ b/tools/perf/util/comm.c
> @@ -213,6 +213,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
>  	new = comm_strs__findnew(str);
>  	if (!new)
>  		return -ENOMEM;
> +	printf("[OVERRIDE] old %s new %s str %s\n", old->str, new->str, str);
> 
>  	comm_str__put(old);
>  	comm->comm_str = new;
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2531b373f2cf..5a501fe304d2 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -578,6 +578,7 @@ int machine__process_comm_event(struct machine *machine, union perf_event *event
>  	if (dump_trace)
>  		perf_event__fprintf_comm(event, stdout);
> 
> +	printf("[debug] machine__process_comm_event\n");
>  	if (thread == NULL ||
>  	    __thread__set_comm(thread, event->comm.comm, sample->time, exec)) {
>  		dump_printf("problem processing PERF_RECORD_COMM, skipping event.\n");
> 
> Now, simply run this command multiple times:
>     $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
> And you should see two types of results:
> 
>     $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
>     [debug] deliver
>     [debug] machine__process_comm_event
>     [OVERRIDE] old :1221169 new mv str mv
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
> 	 0.000 ( 0.013 ms): mv/1221169 renameat2(olddfd: CWD, oldname: "/tmp/file1", newdfd: CWD, newname: "/tmp/file2", flags: NOREPLACE) = 0
>     [debug] deliver
> 
>     $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
> 	 0.000 ( 0.014 ms): :1221398/1221398 renameat2(olddfd: CWD, oldname: "/tmp/file1", newdfd: CWD, newname: "/tmp/file2", flags: NOREPLACE) = 0
>     [debug] deliver
>     [debug] deliver
>     [debug] machine__process_comm_event
>     [OVERRIDE] old :1221398 new mv str mv
>     [debug] deliver
>     [debug] deliver
>     [debug] deliver
> 
> Anyway, use --sort-events in BTF general tests to avoid :PID, a comm is
> preferred.
> 
> [1]: https://lore.kernel.org/linux-perf-users/Z_AeswETE5xLcPT8@google.com/
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> index e78e653fc8f1..a15cdb5fa309 100755
> --- a/tools/perf/tests/shell/trace_btf_general.sh
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -27,7 +27,7 @@ check_vmlinux() {
>  
>  trace_test_string() {
>    echo "Testing perf trace's string augmentation"
> -  output="$(perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
> +  output="$(perf trace --sort-events -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
>    if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
>    then
>      printf "String augmentation test failed, output:\n$output"
> @@ -38,7 +38,7 @@ trace_test_string() {
>  trace_test_buffer() {
>    echo "Testing perf trace's buffer augmentation"
>    # echo will insert a newline (\10) at the end of the buffer
> -  output="$(perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1)"
> +  output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
>    if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
>    then
>      printf "Buffer augmentation test failed, output:\n$output"
> @@ -48,7 +48,7 @@ trace_test_buffer() {
>  
>  trace_test_struct_btf() {
>    echo "Testing perf trace's struct augmentation"
> -  output="$(perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
> +  output="$(perf trace --sort-events -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
>    if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
>    then
>  	printf "BTF struct augmentation test failed, output:\n$output"
> -- 
> 2.45.2
> 
