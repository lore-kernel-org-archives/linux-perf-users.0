Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA5145346;
	Wed,  6 Aug 2025 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754521654; cv=none; b=Hn25L8pUhkL1msBIjMS69vrcxmPEija5ZZcM/HHJpeqrxGelGDpk1jNwaoK/D/TISskfsySvuq0RnXuoMtg1z5Qf+k4kAOS9kdfSSmJRP4ewk8EgEKG9dJnG3fR+Ct08tD1I2wTb/axaz34daRO2ob3LdRhilj0JV5OuqzvkhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754521654; c=relaxed/simple;
	bh=cHHkNUdX5ABBCYVaM9AasQq9ZmnvcQpDHVK7JKWqoQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0KRaMjoqqsWo2uFi+UBA8kAAXmMPfTlypbmnZeYCmouVaoIygmk5c4INg4UrcY2zAKH8mN6+KUKZzCoi7kgebU/xjg4+nBm4uUTcvYIxm6edVig2cyZM2HYaqg6TXYESBxB/LMiGypOyVSitJzkvMOJr6jg41SnEamp/4Jqu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTtkFL18; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTtkFL18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7710DC4CEE7;
	Wed,  6 Aug 2025 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754521654;
	bh=cHHkNUdX5ABBCYVaM9AasQq9ZmnvcQpDHVK7JKWqoQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTtkFL18R44z5CUf7sVzjXDn+YngyQalSxISIw9wqSnncpR/KNuzXuxraK7inQtn2
	 MAIllp1RE+Zy6AWgKUNgdAa35rfQelX6ElvUaP0b+ntOLwxot35PE9J/Zu5NpTL99n
	 BSy66cINqcPf677vTmTxxbySkSGz6KPzREeGqm/SZKizMCd0FkviP6bQTRrj/nheAO
	 zV1qVuZUTQkT8vDYUefD6ywNb0J2qN9CIaBoCD05EOEGvOUlEiB4sEbeWuzUgnWAP2
	 CrpVepauIGIqPRhTl/Jmeso6sudtAI6rWdY7JrEoN0zb3X75EH8IOn1mf0mswsKLch
	 H0tK2EmddfqPw==
Date: Wed, 6 Aug 2025 16:07:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakub Brnak <jbrnak@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	howardchu95@gmail.com
Subject: Re: [PATCH] perf: use standard syscall tracepoint structs for
 augmentation
Message-ID: <aJPgNMi-6J2ewGza@google.com>
References: <20250806130017.541416-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806130017.541416-1-jbrnak@redhat.com>

Hello,

On Wed, Aug 06, 2025 at 03:00:17PM +0200, Jakub Brnak wrote:
> Replace custom syscall structs with the standard trace_event_raw_sys_enter
> and trace_event_raw_sys_exit from vmlinux.h.
> This fixes a data structure misalignment issue discovered on RHEL-9, which
> prevented BPF programs from correctly accessing syscall arguments.

Can you explain what the alignment issue was?  It's not clear to me what
makes it misaligned.


> This change also aims to improve compatibility between different version
> of the perf tool and kernel by using CO-RE so BPF code can correclty
> adjust field offsets.
> 
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
> The issue was encountered on RHEL-9 by failing trace enum augmentation tests.
> 
> Before change:
> 113: perf trace enum augmentation tests:
> --- start ---
> test child forked, pid 92876
> Checking if vmlinux exists
> Tracing syscall landlock_add_rule
> [syscall failure] Failed to trace syscall landlock_add_rule, output:
> 
> ---- end(-1) ----
> 113: perf trace enum augmentation tests                              : FAILED!
> 
> After change:
> 113: perf trace enum augmentation tests:
> --- start ---
> test child forked, pid 98369
> Checking if vmlinux exists
> Tracing syscall landlock_add_rule
> Tracing non-syscall tracepoint timer:hrtimer_start
> ---- end(0) ----
> 113: perf trace enum augmentation tests                              : Ok
> 
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 58 ++++++++-----------
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    | 14 +++++
>  2 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index cb86e261b4de..de397b3b0776 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -60,18 +60,6 @@ struct syscalls_sys_exit {
>  	__uint(max_entries, 512);
>  } syscalls_sys_exit SEC(".maps");
>  
> -struct syscall_enter_args {
> -	unsigned long long common_tp_fields;
> -	long		   syscall_nr;
> -	unsigned long	   args[6];
> -};
> -
> -struct syscall_exit_args {
> -	unsigned long long common_tp_fields;
> -	long		   syscall_nr;
> -	long		   ret;
> -};
> -
>  /*
>   * Desired design of maximum size and alignment (see RFC2553)
>   */
> @@ -115,7 +103,7 @@ struct pids_filtered {
>  } pids_filtered SEC(".maps");
>  
>  struct augmented_args_payload {
> -	struct syscall_enter_args args;
> +	struct trace_event_raw_sys_enter args;
>  	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
>  };
>  
> @@ -135,7 +123,7 @@ struct beauty_map_enter {
>  } beauty_map_enter SEC(".maps");
>  
>  struct beauty_payload_enter {
> -	struct syscall_enter_args args;
> +	struct trace_event_raw_sys_enter args;
>  	struct augmented_arg aug_args[6];
>  };
>  
> @@ -192,7 +180,7 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
>  }
>  
>  SEC("tp/raw_syscalls/sys_enter")
> -int syscall_unaugmented(struct syscall_enter_args *args)
> +int syscall_unaugmented(struct trace_event_raw_sys_enter *args)
>  {
>  	return 1;
>  }
> @@ -204,7 +192,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
>   * filename.
>   */
>  SEC("tp/syscalls/sys_enter_connect")
> -int sys_enter_connect(struct syscall_enter_args *args)
> +int sys_enter_connect(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *sockaddr_arg = (const void *)args->args[1];
> @@ -225,7 +213,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_sendto")
> -int sys_enter_sendto(struct syscall_enter_args *args)
> +int sys_enter_sendto(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *sockaddr_arg = (const void *)args->args[4];
> @@ -243,7 +231,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_open")
> -int sys_enter_open(struct syscall_enter_args *args)
> +int sys_enter_open(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *filename_arg = (const void *)args->args[0];
> @@ -258,7 +246,7 @@ int sys_enter_open(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_openat")
> -int sys_enter_openat(struct syscall_enter_args *args)
> +int sys_enter_openat(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *filename_arg = (const void *)args->args[1];
> @@ -273,7 +261,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_rename")
> -int sys_enter_rename(struct syscall_enter_args *args)
> +int sys_enter_rename(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *oldpath_arg = (const void *)args->args[0],
> @@ -304,7 +292,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_renameat2")
> -int sys_enter_renameat2(struct syscall_enter_args *args)
> +int sys_enter_renameat2(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *oldpath_arg = (const void *)args->args[1],
> @@ -346,7 +334,7 @@ struct perf_event_attr_size {
>  };
>  
>  SEC("tp/syscalls/sys_enter_perf_event_open")
> -int sys_enter_perf_event_open(struct syscall_enter_args *args)
> +int sys_enter_perf_event_open(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const struct perf_event_attr_size *attr = (const struct perf_event_attr_size *)args->args[0], *attr_read;
> @@ -378,7 +366,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_clock_nanosleep")
> -int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
> +int sys_enter_clock_nanosleep(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *rqtp_arg = (const void *)args->args[2];
> @@ -399,7 +387,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  }
>  
>  SEC("tp/syscalls/sys_enter_nanosleep")
> -int sys_enter_nanosleep(struct syscall_enter_args *args)
> +int sys_enter_nanosleep(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args = augmented_args_payload();
>  	const void *req_arg = (const void *)args->args[0];
> @@ -429,7 +417,7 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>  }
>  
> -static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> +static int augment_sys_enter(void *ctx, struct trace_event_raw_sys_enter *args)
>  {
>  	bool augmented, do_output = false;
>  	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> @@ -444,7 +432,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  		return 1;
>  
>  	/* use syscall number to get beauty_map entry */
> -	nr             = (__u32)args->syscall_nr;
> +	nr             = (__u32)args->id;
>  	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);
>  
>  	/* set up payload for output */
> @@ -454,8 +442,8 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  	if (beauty_map == NULL || payload == NULL)
>  		return 1;
>  
> -	/* copy the sys_enter header, which has the syscall_nr */
> -	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
> +	/* copy the sys_enter header, which has the id */
> +	__builtin_memcpy(&payload->args, args, sizeof(struct trace_event_raw_sys_enter));

I think we prefer sizeof(*args) than sizeof(<type-name>).

>  
>  	/*
>  	 * Determine what type of argument and how many bytes to read from user space, using the
> @@ -515,14 +503,14 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  		}
>  	}
>  
> -	if (!do_output || (sizeof(struct syscall_enter_args) + output) > sizeof(struct beauty_payload_enter))
> +	if (!do_output || (sizeof(struct trace_event_raw_sys_enter) + output) > sizeof(struct beauty_payload_enter))
>  		return 1;
>  
> -	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
> +	return augmented__beauty_output(ctx, payload, sizeof(struct trace_event_raw_sys_enter) + output);

Ditto.

Thanks,
Namhyung

>  }
>  
>  SEC("tp/raw_syscalls/sys_enter")
> -int sys_enter(struct syscall_enter_args *args)
> +int sys_enter(struct trace_event_raw_sys_enter *args)
>  {
>  	struct augmented_args_payload *augmented_args;
>  	/*
> @@ -550,16 +538,16 @@ int sys_enter(struct syscall_enter_args *args)
>  	 * unaugmented tracepoint payload.
>  	 */
>  	if (augment_sys_enter(args, &augmented_args->args))
> -		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> +		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.id);
>  
>  	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
>  	return 0;
>  }
>  
>  SEC("tp/raw_syscalls/sys_exit")
> -int sys_exit(struct syscall_exit_args *args)
> +int sys_exit(struct trace_event_raw_sys_exit *args)
>  {
> -	struct syscall_exit_args exit_args;
> +	struct trace_event_raw_sys_exit exit_args;
>  
>  	if (pid_filter__has(&pids_filtered, getpid()))
>  		return 0;
> @@ -570,7 +558,7 @@ int sys_exit(struct syscall_exit_args *args)
>  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
>  	 * unaugmented tracepoint payload.
>  	 */
> -	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
> +	bpf_tail_call(args, &syscalls_sys_exit, exit_args.id);
>  	/*
>  	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
>  	 */
> diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> index a59ce912be18..b8b234726863 100644
> --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> @@ -212,4 +212,18 @@ struct pglist_data {
>  	int nr_zones;
>  } __attribute__((preserve_access_index));
>  
> +struct trace_event_raw_sys_enter {
> +	struct trace_entry ent;
> +	long int id;
> +	long unsigned int args[6];
> +	char __data[0];
> +} __attribute__((preserve_access_index));
> +
> +struct trace_event_raw_sys_exit {
> +	struct trace_entry ent;
> +	long int id;
> +	long int ret;
> +	char __data[0];
> +} __attribute__((preserve_access_index));
> +
>  #endif // __VMLINUX_H
> -- 
> 2.50.1
> 
