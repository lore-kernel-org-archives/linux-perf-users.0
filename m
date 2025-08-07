Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391493FE7;
	Thu,  7 Aug 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597771; cv=none; b=lFP9vGx1ZiRaDbgGV75kso1iR9NIycL2KLIfQf3ZblxqEsOfr2dAMwJxSyyCdn4kK1LzDmVhtNVBlyF5aleBdix/U7OU9vbKTt/nURI0fjocv7LWPmNeZupSwVks0PfYP6PpAUnTs3KFnyzO7atpKfeM0vfbmN252SIW8KaVVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597771; c=relaxed/simple;
	bh=ycXHqE/+e5jbr/Du7ZL9FKcFJunnChGS2pIDIUwBxVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYjmzqQzmckgaSfhN3NYRDPy1lUihXj3ggM0AJuzK10mAjTWvvCVFw/fJbD4ih2hZ7DcTPbV+GQlS10F1wyPej7N/Hfy2Ol+SPqVMn4M1v+82l3sHXnGHdcIMVYCEUyS1xvjEs+5H0IKtw16MLFy3/RPk0PCnvA5QwYuC8IQT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxpzlAKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxpzlAKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E1CC4CEEB;
	Thu,  7 Aug 2025 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754597770;
	bh=ycXHqE/+e5jbr/Du7ZL9FKcFJunnChGS2pIDIUwBxVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxpzlAKUVLm0ERru7xlATFutELiBOEc6zZWWLh6jr5rNcgQhMZ3Za2gG+W8Q/zKCI
	 J6kp71mi07WODHBAGB/Bl0SBQwf3mo949uyyDJLFUuDOp2gZ8/pmaI+arWshHU3I70
	 KAH3L3jpqBKQhd6Ljtc7TPYa+/rLvqfJy57+F177c36GUuvHWYAXiEk5tehqZuDosd
	 obbJl3/uB8LDEIdFk4PV6NMVOyrpj8vJW+cA2flqXoPcEDEq4oHCQCoa4bR8X1Tr3f
	 QXgOdwlOt8I0TZhbGOZx/1qhufmZ6EGqGQQY9P3BLsv45wx8MBybBSo4p4AdKQRJBM
	 XgGHNMRp0dwOQ==
Date: Thu, 7 Aug 2025 17:16:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jakub Brnak <jbrnak@redhat.com>, peterz@infradead.org, mingo@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	howardchu95@gmail.com
Subject: Re: [PATCH] perf: use standard syscall tracepoint structs for
 augmentation
Message-ID: <aJUJh8oDaH-2Ptll@x1>
References: <20250806130017.541416-1-jbrnak@redhat.com>
 <aJPgNMi-6J2ewGza@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJPgNMi-6J2ewGza@google.com>

On Wed, Aug 06, 2025 at 04:07:32PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Aug 06, 2025 at 03:00:17PM +0200, Jakub Brnak wrote:
> > Replace custom syscall structs with the standard trace_event_raw_sys_enter
> > and trace_event_raw_sys_exit from vmlinux.h.
> > This fixes a data structure misalignment issue discovered on RHEL-9, which
> > prevented BPF programs from correctly accessing syscall arguments.
> 
> Can you explain what the alignment issue was?  It's not clear to me what
> makes it misaligned.

Yeah, mentioning a "misalignment" and then not spelling it out precisely
doesn't help.

Showing the pahole output of the expected structure layout in both
kernels and what was being used would help us to understand the problem.

For instance, here I have:

acme@x1:~/git/bpf-next$ uname -r
6.15.5-200.fc42.x86_64
acme@x1:~/git/bpf-next$ pahole -E trace_event_raw_sys_enter
struct trace_event_raw_sys_enter {
	struct trace_entry {
		short unsigned int type;                 /*     0     2 */
		unsigned char      flags;                /*     2     1 */
		unsigned char      preempt_count;        /*     3     1 */
		int                pid;                  /*     4     4 */
	} ent; /*     0     8 */
	long int                   id;                   /*     8     8 */
	long unsigned int          args[6];              /*    16    48 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	char                       __data[];             /*    64     0 */

	/* size: 64, cachelines: 1, members: 4 */
};

acme@x1:~/git/bpf-next$

And:

⬢ [acme@toolbx linux]$ pahole -C syscall_enter_args /tmp/build/linux/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o 
struct syscall_enter_args {
	unsigned long long         common_tp_fields;     /*     0     8 */
	long                       syscall_nr;           /*     8     8 */
	unsigned long              args[6];              /*    16    48 */

	/* size: 64, cachelines: 1, members: 3 */
};

⬢ [acme@toolbx linux]$

So yes, it is "aligned", the 'id' is the 'syscall_nr' and both are at
offset 8, then we have the syscall args starting at offset 16 in both
cases.

The layout for rhel9 then we see the issue, the id, syscall_nr, is at
offset 16, there is the misalignment:

sh-5.1# pahole -E -C trace_event_raw_sys_enter /usr/lib/debug/lib/modules/5.14.0-570.32.1.el9_6.x86_64/vmlinux
struct trace_event_raw_sys_enter {
	struct trace_entry {
		short unsigned int type;                 /*     0     2 */
		unsigned char      flags;                /*     2     1 */
		unsigned char      preempt_count;        /*     3     1 */
		int                pid;                  /*     4     4 */
		unsigned char      preempt_lazy_count;   /*     8     1 */
	} ent; /*     0    12 */

	/* XXX last struct has 3 bytes of padding */
	/* XXX 4 bytes hole, try to pack */

	long int                   id;                   /*    16     8 */
	long unsigned int          args[6];              /*    24    48 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	char                       __data[];             /*    72     0 */

	/* size: 72, cachelines: 2, members: 4 */
	/* sum members: 68, holes: 1, sum holes: 4 */
	/* paddings: 1, sum paddings: 3 */
	/* last cacheline: 8 bytes */
};

sh-5.1#

So if we always use 'struct trace_event_raw_sys_enter' from the
vmlinux.h generated from the BTF info and have it all as CO-RE enabled
(preserving the access index of fields, etc) it will work on any kernel
you install on machine.

Cheers,

- Arnaldo
 
> > This change also aims to improve compatibility between different version
> > of the perf tool and kernel by using CO-RE so BPF code can correclty
> > adjust field offsets.
> > 
> > Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> > ---
> > The issue was encountered on RHEL-9 by failing trace enum augmentation tests.
> > 
> > Before change:
> > 113: perf trace enum augmentation tests:
> > --- start ---
> > test child forked, pid 92876
> > Checking if vmlinux exists
> > Tracing syscall landlock_add_rule
> > [syscall failure] Failed to trace syscall landlock_add_rule, output:
> > 
> > ---- end(-1) ----
> > 113: perf trace enum augmentation tests                              : FAILED!
> > 
> > After change:
> > 113: perf trace enum augmentation tests:
> > --- start ---
> > test child forked, pid 98369
> > Checking if vmlinux exists
> > Tracing syscall landlock_add_rule
> > Tracing non-syscall tracepoint timer:hrtimer_start
> > ---- end(0) ----
> > 113: perf trace enum augmentation tests                              : Ok
> > 
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 58 ++++++++-----------
> >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    | 14 +++++
> >  2 files changed, 37 insertions(+), 35 deletions(-)
> > 
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index cb86e261b4de..de397b3b0776 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -60,18 +60,6 @@ struct syscalls_sys_exit {
> >  	__uint(max_entries, 512);
> >  } syscalls_sys_exit SEC(".maps");
> >  
> > -struct syscall_enter_args {
> > -	unsigned long long common_tp_fields;
> > -	long		   syscall_nr;
> > -	unsigned long	   args[6];
> > -};
> > -
> > -struct syscall_exit_args {
> > -	unsigned long long common_tp_fields;
> > -	long		   syscall_nr;
> > -	long		   ret;
> > -};
> > -
> >  /*
> >   * Desired design of maximum size and alignment (see RFC2553)
> >   */
> > @@ -115,7 +103,7 @@ struct pids_filtered {
> >  } pids_filtered SEC(".maps");
> >  
> >  struct augmented_args_payload {
> > -	struct syscall_enter_args args;
> > +	struct trace_event_raw_sys_enter args;
> >  	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
> >  };
> >  
> > @@ -135,7 +123,7 @@ struct beauty_map_enter {
> >  } beauty_map_enter SEC(".maps");
> >  
> >  struct beauty_payload_enter {
> > -	struct syscall_enter_args args;
> > +	struct trace_event_raw_sys_enter args;
> >  	struct augmented_arg aug_args[6];
> >  };
> >  
> > @@ -192,7 +180,7 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
> >  }
> >  
> >  SEC("tp/raw_syscalls/sys_enter")
> > -int syscall_unaugmented(struct syscall_enter_args *args)
> > +int syscall_unaugmented(struct trace_event_raw_sys_enter *args)
> >  {
> >  	return 1;
> >  }
> > @@ -204,7 +192,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
> >   * filename.
> >   */
> >  SEC("tp/syscalls/sys_enter_connect")
> > -int sys_enter_connect(struct syscall_enter_args *args)
> > +int sys_enter_connect(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const void *sockaddr_arg = (const void *)args->args[1];
> > @@ -225,7 +213,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
> >  }
> >  
> >  SEC("tp/syscalls/sys_enter_sendto")
> > -int sys_enter_sendto(struct syscall_enter_args *args)
> > +int sys_enter_sendto(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const void *sockaddr_arg = (const void *)args->args[4];
> > @@ -243,7 +231,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
> >  }
> >  
> >  SEC("tp/syscalls/sys_enter_open")
> > -int sys_enter_open(struct syscall_enter_args *args)
> > +int sys_enter_open(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const void *filename_arg = (const void *)args->args[0];
> > @@ -258,7 +246,7 @@ int sys_enter_open(struct syscall_enter_args *args)
> >  }
> >  
> >  SEC("tp/syscalls/sys_enter_openat")
> > -int sys_enter_openat(struct syscall_enter_args *args)
> > +int sys_enter_openat(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const void *filename_arg = (const void *)args->args[1];
> > @@ -273,7 +261,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
> >  }
> >  
> >  SEC("tp/syscalls/sys_enter_rename")
> > -int sys_enter_rename(struct syscall_enter_args *args)
> > +int sys_enter_rename(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const void *oldpath_arg = (const void *)args->args[0],
> > @@ -304,7 +292,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
> >  }
> >  
> >  SEC("tp/syscalls/sys_enter_renameat2")
> > -int sys_enter_renameat2(struct syscall_enter_args *args)
> > +int sys_enter_renameat2(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const void *oldpath_arg = (const void *)args->args[1],
> > @@ -346,7 +334,7 @@ struct perf_event_attr_size {
> >  };
> >  
> >  SEC("tp/syscalls/sys_enter_perf_event_open")
> > -int sys_enter_perf_event_open(struct syscall_enter_args *args)
> > +int sys_enter_perf_event_open(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const struct perf_event_attr_size *attr = (const struct perf_event_attr_size *)args->args[0], *attr_read;
> > @@ -378,7 +366,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
> >  }
> >  
> >  SEC("tp/syscalls/sys_enter_clock_nanosleep")
> > -int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
> > +int sys_enter_clock_nanosleep(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const void *rqtp_arg = (const void *)args->args[2];
> > @@ -399,7 +387,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
> >  }
> >  
> >  SEC("tp/syscalls/sys_enter_nanosleep")
> > -int sys_enter_nanosleep(struct syscall_enter_args *args)
> > +int sys_enter_nanosleep(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args = augmented_args_payload();
> >  	const void *req_arg = (const void *)args->args[0];
> > @@ -429,7 +417,7 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
> >  	return bpf_map_lookup_elem(pids, &pid) != NULL;
> >  }
> >  
> > -static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> > +static int augment_sys_enter(void *ctx, struct trace_event_raw_sys_enter *args)
> >  {
> >  	bool augmented, do_output = false;
> >  	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> > @@ -444,7 +432,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> >  		return 1;
> >  
> >  	/* use syscall number to get beauty_map entry */
> > -	nr             = (__u32)args->syscall_nr;
> > +	nr             = (__u32)args->id;
> >  	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);
> >  
> >  	/* set up payload for output */
> > @@ -454,8 +442,8 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> >  	if (beauty_map == NULL || payload == NULL)
> >  		return 1;
> >  
> > -	/* copy the sys_enter header, which has the syscall_nr */
> > -	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
> > +	/* copy the sys_enter header, which has the id */
> > +	__builtin_memcpy(&payload->args, args, sizeof(struct trace_event_raw_sys_enter));
> 
> I think we prefer sizeof(*args) than sizeof(<type-name>).

yeah, please change it to that idiom, I understand that is how it was
before, and thus is unrelated to this patch, but it is a good time to
fix it since you're touching this line.

> 
> >  
> >  	/*
> >  	 * Determine what type of argument and how many bytes to read from user space, using the
> > @@ -515,14 +503,14 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> >  		}
> >  	}
> >  
> > -	if (!do_output || (sizeof(struct syscall_enter_args) + output) > sizeof(struct beauty_payload_enter))
> > +	if (!do_output || (sizeof(struct trace_event_raw_sys_enter) + output) > sizeof(struct beauty_payload_enter))
> >  		return 1;
> >  
> > -	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
> > +	return augmented__beauty_output(ctx, payload, sizeof(struct trace_event_raw_sys_enter) + output);
> 
> Ditto.
> 
> Thanks,
> Namhyung
> 
> >  }
> >  
> >  SEC("tp/raw_syscalls/sys_enter")
> > -int sys_enter(struct syscall_enter_args *args)
> > +int sys_enter(struct trace_event_raw_sys_enter *args)
> >  {
> >  	struct augmented_args_payload *augmented_args;
> >  	/*
> > @@ -550,16 +538,16 @@ int sys_enter(struct syscall_enter_args *args)
> >  	 * unaugmented tracepoint payload.
> >  	 */
> >  	if (augment_sys_enter(args, &augmented_args->args))
> > -		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> > +		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.id);
> >  
> >  	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
> >  	return 0;
> >  }
> >  
> >  SEC("tp/raw_syscalls/sys_exit")
> > -int sys_exit(struct syscall_exit_args *args)
> > +int sys_exit(struct trace_event_raw_sys_exit *args)
> >  {
> > -	struct syscall_exit_args exit_args;
> > +	struct trace_event_raw_sys_exit exit_args;
> >  
> >  	if (pid_filter__has(&pids_filtered, getpid()))
> >  		return 0;
> > @@ -570,7 +558,7 @@ int sys_exit(struct syscall_exit_args *args)
> >  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
> >  	 * unaugmented tracepoint payload.
> >  	 */
> > -	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
> > +	bpf_tail_call(args, &syscalls_sys_exit, exit_args.id);
> >  	/*
> >  	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
> >  	 */
> > diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > index a59ce912be18..b8b234726863 100644
> > --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > @@ -212,4 +212,18 @@ struct pglist_data {
> >  	int nr_zones;
> >  } __attribute__((preserve_access_index));
> >  
> > +struct trace_event_raw_sys_enter {
> > +	struct trace_entry ent;
> > +	long int id;
> > +	long unsigned int args[6];
> > +	char __data[0];
> > +} __attribute__((preserve_access_index));
> > +
> > +struct trace_event_raw_sys_exit {
> > +	struct trace_entry ent;
> > +	long int id;
> > +	long int ret;
> > +	char __data[0];
> > +} __attribute__((preserve_access_index));
> > +
> >  #endif // __VMLINUX_H
> > -- 
> > 2.50.1
> > 
