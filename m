Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBD40C03;
	Wed,  4 Sep 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479581; cv=none; b=Mr9n2K+4UpHO32wm3/pCIg3R+7sKv9b935vB6wkQ8kwGX0vbAqjAfYQWGcDcqiA6N5AYEurQSGIhTAqyQrir8z77bNOrQhcjMGKpucjWgVNWRX+qoFceEHRnC0tWaT3wK5n5n6pr1P8JDIES1THcIrUpCZrNSxkVgoeCF+zjDuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479581; c=relaxed/simple;
	bh=tRHqcTJAzcDq3o691o5mb4w/s+P1W40s2PqLBV+FL0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/fviDEImLdQVKgv/IYtLcjw9370JE3m+NbopnST1koP1jbSvuzJx8dtK2rhoqRDjSkpz4VldLb+PSMeAPqrNZQBN/ks6VozXOAKotLf7JORxlkt4kobxV3pqA9uvCMt9Pzr0NZ5VzOgicD/mnx1o53IHgH/sRf8obViptz+qhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBmKGb66; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBmKGb66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF92C4CEC2;
	Wed,  4 Sep 2024 19:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725479581;
	bh=tRHqcTJAzcDq3o691o5mb4w/s+P1W40s2PqLBV+FL0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBmKGb66SfZlvMLh51y0bEqgUaSCtNLe7vbuIT5M3pWWdwbZkT/LrmEsR6izdhO3p
	 DCIOEG83bhSgwpGuImLWYkEs3Hji+Q8KEZvyxHevosaMQHoPhrilJell784JMKyImU
	 NJHsAGTvG6LiHvmQ4sq4rxVpDpiy/qzJaNEmYwHkS06B0EYW6Hr/2OYpg/FEE1Q7zt
	 rD59QbKxZad6hD4zdBla/+nluqCQbUeWiEvVrBT6S1NktVyat89zgg2AX6NCw33VtL
	 03P76s4adFNVYpCJWWNbXEMabSb/DX9okZnDSn5vGBY901knBsWHPo4R1IS/VnCGaz
	 0MkKU6v9v1FjA==
Date: Wed, 4 Sep 2024 16:52:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 6/8] perf trace: Collect augmented data using BPF
Message-ID: <Zti6mc3Lt5jC1owY@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-7-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240824163322.60796-7-howardchu95@gmail.com>

On Sun, Aug 25, 2024 at 12:33:20AM +0800, Howard Chu wrote:
> Include trace_augment.h for TRACE_AUG_MAX_BUF, so that BPF reads
> TRACE_AUG_MAX_BUF bytes of buffer maximum.
> 
> Determine what type of argument and how many bytes to read from user space, us ing the
> value in the beauty_map. This is the relation of parameter type and its corres ponding
> value in the beauty map, and how many bytes we read eventually:
> 
> string: 1                          -> size of string (till null)
> struct: size of struct             -> size of struct
> buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_ MAX_BUF)
> 
> After reading from user space, we output the augmented data using
> bpf_perf_event_output().
> 
> If the struct augmenter, augment_sys_enter() failed, we fall back to
> using bpf_tail_call().
> 
> I have to make the payload 6 times the size of augmented_arg, to pass the
> BPF verifier.
> 
> Committer notes:
> 
> It works, but we need to wire it up to the userspace specialized pretty
> printer, otherwise we get things like:
> 
>   root@number:~# perf trace -e connect ssh localhost
>        0.000 ( 0.010 ms): :784442/784442 connect(fd: 3, uservaddr: {2,}, addrlen: 16)                          = 0
>        0.016 ( 0.006 ms): :784442/784442 connect(fd: 3, uservaddr: {10,}, addrlen: 28)                         = 0
>        0.033 ( 0.096 ms): :784442/784442 connect(fd: 3, uservaddr: {10,}, addrlen: 28)                         = 0
>   root@localhost's password:     71.292 ( 0.037 ms): ssh/784442 connect(fd: 4, uservaddr: {1,{['/','v','a','r','/','r','u','n','/','.','h','e','i','m',],},}, addrlen: 110) = 0
>       72.087 ( 0.013 ms): ssh/784442 connect(fd: 4, uservaddr: {1,{['/','v','a','r','/','r','u','n','/','.','h','e','i','m',],},}, addrlen: 110) = 0
> 
>   root@number:~#
> 
> When we used to have:
> 
>   root@number:~# perf trace -e connect ssh localhost
>        0.000 ( 0.011 ms): ssh/786564 connect(fd: 3, uservaddr: { .family: INET, port: 22, addr: 127.0.0.1 }, addrlen: 16) = 0
>        0.017 ( 0.006 ms): ssh/786564 connect(fd: 3, uservaddr: { .family: INET6, port: 22, addr: ::1 }, addrlen: 28) = 0
>        0.263 ( 0.043 ms): ssh/786564 connect(fd: 3, uservaddr: { .family: INET6, port: 22, addr: ::1 }, addrlen: 28) = 0
>       63.770 ( 0.044 ms): ssh/786564 connect(fd: 4, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, addrlen: 110) = 0
>       65.467 ( 0.042 ms): ssh/786564 connect(fd: 4, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, addrlen: 110) = 0
>   root@localhost's password:
> 
> That is closer to what strace produces:
> 
>   root@number:~# strace -e connect ssh localhost
>   connect(3, {sa_family=AF_INET, sin_port=htons(22), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
>   connect(3, {sa_family=AF_INET6, sin6_port=htons(22), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=0}, 28) = 0
>   connect(3, {sa_family=AF_INET6, sin6_port=htons(22), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=0}, 28) = 0
>   connect(4, {sa_family=AF_UNIX, sun_path="/var/run/.heim_org.h5l.kcm-socket"}, 110) = 0
>   connect(4, {sa_family=AF_UNIX, sun_path="/var/run/.heim_org.h5l.kcm-socket"}, 110) = 0
>   root@localhost's password:
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20240815013626.935097-10-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 114 +++++++++++++++++-
>  1 file changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 0acbd74e8c76..f29a8dfca044 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -7,6 +7,8 @@
>   */
>  
>  #include "vmlinux.h"
> +#include "../trace_augment.h"
> +
>  #include <bpf/bpf_helpers.h>
>  #include <linux/limits.h>
>  
> @@ -124,6 +126,25 @@ struct augmented_args_tmp {
>  	__uint(max_entries, 1);
>  } augmented_args_tmp SEC(".maps");
>  
> +struct beauty_payload_enter {
> +	struct syscall_enter_args args;
> +	struct augmented_arg aug_args[6];
> +};

⬢[acme@toolbox perf-tools-next]$ pahole -C augmented_arg /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o 
struct augmented_arg {
	unsigned int               size;                 /*     0     4 */
	int                        err;                  /*     4     4 */
	char                       value[4096];          /*     8  4096 */

	/* size: 4104, cachelines: 65, members: 3 */
	/* last cacheline: 8 bytes */
};

⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ pahole -C syscall_enter_args /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o 
struct syscall_enter_args {
	unsigned long long         common_tp_fields;     /*     0     8 */
	long                       syscall_nr;           /*     8     8 */
	unsigned long              args[6];              /*    16    48 */

	/* size: 64, cachelines: 1, members: 3 */
};

So the entry has the theoretical max limit for the augmented payload
which would be 6 * sizeof(struct augmented_arg) + the common header for
tracepoints (unaugmented), a lot of space, but...

> +static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> +{
> +	bool augmented, do_output = false;
> +	int zero = 0, size, aug_size, index, output = 0,
> +	    value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> +	unsigned int nr, *beauty_map;
> +	struct beauty_payload_enter *payload;
> +	void *arg, *payload_offset;
> +
> +	/* fall back to do predefined tail call */
> +	if (args == NULL)
> +		return 1;
> +
> +	/* use syscall number to get beauty_map entry */
> +	nr             = (__u32)args->syscall_nr;
> +	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);

If we don't set up the entry for this syscall, then there are no
pointers to collect, we return early and the tracepoint will not filter
it and there it goes, up unmodified, if not already filtered by a
tracepoint filter, ok, I'll add these comments here.

> +	/* set up payload for output */
> +	payload        = bpf_map_lookup_elem(&beauty_payload_enter_map, &zero);
> +	payload_offset = (void *)&payload->aug_args;
> > +	if (beauty_map == NULL || payload == NULL)
> +		return 1;

We can save the lookup for payload if the one for beauty_map returned
NULL, I'll do this fixup.

> +	/* copy the sys_enter header, which has the syscall_nr */
> +	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));


> +	/*
> +	 * Determine what type of argument and how many bytes to read from user space, using the
> +	 * value in the beauty_map. This is the relation of parameter type and its corresponding
> +	 * value in the beauty map, and how many bytes we read eventually:
> +	 *
> +	 * string: 1			      -> size of string
> +	 * struct: size of struct	      -> size of struct
> +	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)

'paired_len'? Ok, 1, size of string or struct


Will continue the detailed analysis later, as I need to change the
existing BPF collector, before applying this, to match the protocol here
(that will always have the size of each argument encoded in the ring
buffer, easier, but uses more space).

- Arnaldo

> +	 */
> +	for (int i = 0; i < 6; i++) {
> +		arg = (void *)args->args[i];
> +		augmented = false;
> +		size = beauty_map[i];
> +		aug_size = size; /* size of the augmented data read from user space */
> +
> +		if (size == 0 || arg == NULL)
> +			continue;
> +
> +		if (size == 1) { /* string */
> +			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
> +			/* minimum of 0 to pass the verifier */
> +			if (aug_size < 0)
> +				aug_size = 0;
> +
> +			augmented = true;
> +		} else if (size > 0 && size <= value_size) { /* struct */
> +			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
> +				augmented = true;
> +		} else if (size < 0 && size >= -6) { /* buffer */
> +			index = -(size + 1);
> +			aug_size = args->args[index];
> +
> +			if (aug_size > TRACE_AUG_MAX_BUF)
> +				aug_size = TRACE_AUG_MAX_BUF;
> +
> +			if (aug_size > 0) {
> +				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
> +					augmented = true;
> +			}
> +		}
> +
> +		/* write data to payload */
> +		if (augmented) {
> +			int written = offsetof(struct augmented_arg, value) + aug_size;
> +
> +			((struct augmented_arg *)payload_offset)->size = aug_size;
> +			output += written;
> +			payload_offset += written;
> +			do_output = true;
> +		}
> +	}
> +
> +	if (!do_output)
> +		return 1;
> +
> +	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);

We end up pushing up to the ring buffer all the way to 
