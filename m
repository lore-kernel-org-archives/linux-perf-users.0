Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7D2E3700
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 05:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753507914; cv=none; b=VURa8oHv4YjWNdDTV4rEicIzESOiPGFinv5cXJHnQhJz3xkJxMx09Y/EUMsda/DPpqHqe5sJgW1AqtlOa/fu8PB9Nltfi0Luydc/1q/EeJeM/X+N+zy1MoNg2RZvuj50yCwIOFdK4/nXHLGe+IcnAk0CHmjuo5CUIb9w5A4+L3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753507914; c=relaxed/simple;
	bh=Iy1yw8CWIgVveBNANwjArq3dvgPTarQmDJ7wcwxTAaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWy40z5wp5pOmh4pdH5F/Kg5FYueKgt1n1siTAi1TgBMS0DKkeakvlIzgphZzQ6KJ4XV54xCCAyko2fsoPT9x78bIv1UVT/EFEhOi9Fq0PoLwXUXKB9AIetJTBzv9jirISpxjGgbbTQYKpPX/n/ieC6KXd7jKPc8v05WThedlKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWffwzJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWffwzJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56A8C4CEED;
	Sat, 26 Jul 2025 05:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753507914;
	bh=Iy1yw8CWIgVveBNANwjArq3dvgPTarQmDJ7wcwxTAaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWffwzJWD87CLWENzv+bPjLlwUQ1DcqOiLOBiDjhq1XdiQ+XpJztHroWJCtLfS6IO
	 ImFuK6ZN9l+OTc7NOd14p/khJuJYaCSw/pMzZ9wSi3WNb6gnHX+xh5kHO+9eQVDg7q
	 oJ6K8aQ8flExvLjwiHQVqIoPCkfRaDklCHkoqFs7AOQf6M/t3yQaBd8dVghmRzoRk4
	 ETB5PTxwEvw36p8Gdg2aFHYCQn0RY+aDLDlNVTtuVh+JtqShG91sz8TJ8akd7E20iM
	 ugP39Zn4RG/k9C1Fkh46bTLE5/5qucafXh+lkLSDLNzggjdYpo3gGnrTjXj0S9lL2B
	 +kgmvSQDjGf+A==
Date: Fri, 25 Jul 2025 22:31:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: adrian.hunter@intel.com, irogers@google.com,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/1] perf test: Ensure lock contention using pipe mode
Message-ID: <aIRoR6j1qAfytIPC@google.com>
References: <20250725170801.3176678-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725170801.3176678-1-japo@linux.ibm.com>

On Fri, Jul 25, 2025 at 07:08:01PM +0200, Jan Polensky wrote:
> The 'kernel lock contention analysis test' requires reliable triggering
> of lock contention. On some systems, previous benchmark calls failed to
> generate sufficient contention due to low system activity or resource
> limits.

Right, we need a reliable reproducer.

> 
> This patch adds the -p (pipe) option to all calls of perf bench sched
> messaging, ensuring consistent lock contention without relying on
> socket-based communication.

But I don't understand why pipe is different than sockets.  Can you
please elaborate?

Thanks,
Namhyung

> 
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  tools/perf/tests/shell/lock_contention.sh | 26 +++++++++++------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index 30d195d4c62f..2c2887b22407 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -44,7 +44,7 @@ check() {
>  test_record()
>  {
>  	echo "Testing perf lock record and perf lock contention"
> -	perf lock record -o ${perfdata} -- perf bench sched messaging > /dev/null 2>&1
> +	perf lock record -o ${perfdata} -- perf bench sched messaging -p > /dev/null 2>&1
>  	# the output goes to the stderr and we expect only 1 output (-E 1)
>  	perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
> @@ -64,7 +64,7 @@ test_bpf()
>  	fi
> 
>  	# the perf lock contention output goes to the stderr
> -	perf lock con -a -b -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
>  		err=1
> @@ -75,7 +75,7 @@ test_bpf()
>  test_record_concurrent()
>  {
>  	echo "Testing perf lock record and perf lock contention at the same time"
> -	perf lock record -o- -- perf bench sched messaging 2> /dev/null | \
> +	perf lock record -o- -- perf bench sched messaging -p 2> /dev/null | \
>  	perf lock contention -i- -E 1 -q 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] Recorded result count is not 1:" "$(cat "${result}" | wc -l)"
> @@ -99,7 +99,7 @@ test_aggr_task()
>  	fi
> 
>  	# the perf lock contention output goes to the stderr
> -	perf lock con -a -b -t -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -t -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
>  		err=1
> @@ -122,7 +122,7 @@ test_aggr_addr()
>  	fi
> 
>  	# the perf lock contention output goes to the stderr
> -	perf lock con -a -b -l -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -l -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
>  		err=1
> @@ -140,7 +140,7 @@ test_aggr_cgroup()
>  	fi
> 
>  	# the perf lock contention output goes to the stderr
> -	perf lock con -a -b -g -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -g -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
>  		err=1
> @@ -162,7 +162,7 @@ test_type_filter()
>  		return
>  	fi
> 
> -	perf lock con -a -b -Y spinlock -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -Y spinlock -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(grep -c -v spinlock "${result}")" != "0" ]; then
>  		echo "[Fail] BPF result should not have non-spinlocks:" "$(cat "${result}")"
>  		err=1
> @@ -194,7 +194,7 @@ test_lock_filter()
>  		return
>  	fi
> 
> -	perf lock con -a -b -L tasklist_lock -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -L tasklist_lock -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(grep -c -v "${test_lock_filter_type}" "${result}")" != "0" ]; then
>  		echo "[Fail] BPF result should not have non-${test_lock_filter_type} locks:" "$(cat "${result}")"
>  		err=1
> @@ -222,7 +222,7 @@ test_stack_filter()
>  		return
>  	fi
> 
> -	perf lock con -a -b -S unix_stream -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -S unix_stream -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] BPF result should have a lock from unix_stream:" "$(cat "${result}")"
>  		err=1
> @@ -250,7 +250,7 @@ test_aggr_task_stack_filter()
>  		return
>  	fi
> 
> -	perf lock con -a -b -t -S unix_stream -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -t -S unix_stream -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] BPF result should have a task from unix_stream:" "$(cat "${result}")"
>  		err=1
> @@ -266,7 +266,7 @@ test_cgroup_filter()
>  		return
>  	fi
> 
> -	perf lock con -a -b -g -E 1 -F wait_total -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -g -E 1 -F wait_total -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] BPF result should have a cgroup result:" "$(cat "${result}")"
>  		err=1
> @@ -274,7 +274,7 @@ test_cgroup_filter()
>  	fi
> 
>  	cgroup=$(cat "${result}" | awk '{ print $3 }')
> -	perf lock con -a -b -g -E 1 -G "${cgroup}" -q -- perf bench sched messaging > /dev/null 2> ${result}
> +	perf lock con -a -b -g -E 1 -G "${cgroup}" -q -- perf bench sched messaging -p > /dev/null 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
>  		echo "[Fail] BPF result should have a result with cgroup filter:" "$(cat "${cgroup}")"
>  		err=1
> @@ -309,7 +309,7 @@ test_csv_output()
>  	fi
> 
>  	# the perf lock contention output goes to the stderr
> -	perf lock con -a -b -E 1 -x , --output ${result} -- perf bench sched messaging > /dev/null 2>&1
> +	perf lock con -a -b -E 1 -x , --output ${result} -- perf bench sched messaging -p > /dev/null 2>&1
>  	output=$(grep -v "^#" ${result} | tr -d -c , | wc -c)
>  	if [ "${header}" != "${output}" ]; then
>  		echo "[Fail] BPF result does not match the number of commas: ${header} != ${output}"
> --
> 2.48.1
> 
