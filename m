Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F91489866;
	Thu,  1 Oct 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868757; cv=none; b=YEraOJUe6L1DuIhwfXDtsbgQd+lUbOV9yIXf98ozY9ZN+s6WzOvEGUvTtqAEK+AD6VNJYkeRFNRawPWXVz3ufcUrAvkcjysHNXM1QdoVKGLTnZLMCJEIk0oksutqY0vL1aA196lZR4K4snxINXY8QuUNSm6aASBS4Qvyzh2oXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868757; c=relaxed/simple;
	bh=MgSy1JGEr9GQ5cdFsgzcMRYgyAD3NCS+UpU86vzMn7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4CVxVoEJwWZgEZlJmnF1tR6+fxgAviy2zHvOTcCgc2ohPP2otKXonTJHjQ6EWdx3QtptZ9XX3R91tmKsie4xXybP6z7Sp0RXChvh4u8ugIKKz+8jIcDWP4cgL0cos0kW1mvhXXLLPiAZ3fI49gFVNJBvynPIcax+XJ/dyFfHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwHnIgpK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwHnIgpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AC51F000FF;
	Thu,  1 Oct 2026 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790868755;
	bh=XsTGhcW2BJRIT77mn6aghmJW2+X6SOLYothKvLoVsEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gwHnIgpKWK1Ai85udQQ6ZmXDTDqe6edUi61z3TOw793kieEfMxG6hwSEPoZp1xNsZ
	 4kAzOGFpd8M2M6Ge1BA0BWc/BuirIkk/cWXUHodRYqDn6q+Hue2sOv9d5C20Xb8dB3
	 LxuWy5Vwz9A6HQDHw6MBMSdeaQwj3vPRXhj2YkLomI8TfrTCIATcJ1CJs8Gm8+MG7N
	 E2m/aH0Rc2UG6MaFhHiYGe4n2mAUWiHAH52yfnHbfghyiWH+ToVNjP8wlITm1BAICl
	 +ioStruhFWGcvFVHaXANk+lrQjW6zpjcB9Yv1t8eSSYmSxBCXtwhNILEI1WQGIGfe1
	 MvzAs3NgXYzOg==
Date: Thu, 1 Oct 2026 17:32:30 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/26] perf trace: Copy sockaddr arguments by their
 length
Message-ID: <ar59DtUVE6dMPn3j@x2>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-7-irogers@google.com>
 <ar1fon_Z4uT3Cd22@x2>
 <ar2WYemXnrbDx-Il@google.com>
 <CAP-5=fVPANOdM5vFY93SCm=mN5Z1U+jMqa7s6piqgtAbUrCBbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVPANOdM5vFY93SCm=mN5Z1U+jMqa7s6piqgtAbUrCBbg@mail.gmail.com>

On Wed, Sep 30, 2026 at 11:01:01PM -0700, Ian Rogers wrote:
> On Wed, Sep 30, 2026 at 4:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Sep 30, 2026 at 09:14:42PM +0200, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Sep 28, 2026 at 11:25:45AM -0700, Ian Rogers wrote:
> > > > The BTF augmenter copies sizeof(struct sockaddr), 16 bytes, for the
> > > > sockaddr arguments of connect, bind and sendto, and runs before the
> > > > sys_enter_connect and sys_enter_sendto programs that copy their length.
> > > > An IPv6 address needs 24 or 28 bytes, so the rest was read from past the
> > > > payload, and now that the printers are bounded only its family is shown.
> > > >
> > > > Copy them as buffers sized by the length argument after them, up to the
> > > > 32 bytes augmented buffers are limited to. That holds an IPv6 address
> > > > and doubles the AF_LOCAL path shown.
> > > >
> > > > Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> > > > Assisted-by: Antigravity:gemini-3.1-pro
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/builtin-trace.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > > index 85db74965280..f94745a60f4a 100644
> > > > --- a/tools/perf/builtin-trace.c
> > > > +++ b/tools/perf/builtin-trace.c
> > > > @@ -4159,7 +4159,12 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
> > > >                             continue;
> > > >
> > > >                     bt = sc->arg_fmt[i].type;
> > > > -                   beauty_array[i] = bt->size;
> > > > +                   /* Copy a sockaddr as a buffer sized by the next argument, e.g. addrlen. */
> > > > +                   if (strcmp(name, "sockaddr") == 0 && field->next &&
> > > > +                       strstr(field->next->name, "len"))
> > > > +                           beauty_array[i] = -((i + 1) + 1);
> > > > +                   else
> > > > +                           beauty_array[i] = bt->size;
> > >
> > >
> > > Humm, I thought that this would be called in BPF handlers like:
> > >
> > > SEC("tp/syscalls/sys_enter_connect")
> > > int sys_enter_connect(struct syscall_enter_args *args)
> > > {
> > >         struct augmented_args_payload *augmented_args = augmented_args_payload();
> > >         const void *sockaddr_arg = (const void *)args->args[1];
> > >         unsigned int socklen = args->args[2];
> > >         unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
> > >
> > >         if (augmented_args == NULL)
> > >                 return 1; /* Failure: don't filter */
> > >
> > >         _Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr)), "sizeof(augmented_args->arg.saddr) needs to be a power of two");
> > >         socklen &= sizeof(augmented_args->arg.saddr) - 1;
> > >
> > >         bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
> > >         augmented_args->arg.size = socklen;
> > >         augmented_args->arg.err = 0;
> > >
> > >         return augmented__output(args, augmented_args, len + socklen);
> > > }
> > >
> > > And it knows how many bytes to read by looking at socklen
> > > (args->args[2]), i.e. not use the generic BPF handler that uses this
> > > beauty_array, because knowing how many bytes to read in this case is
> > > dynamic, varies with each syscall, according to one of its arguments :-\
> > >
> > > What am I missing?
> >
> > I think Ian's patch update the beauty map which is used by
> > augment_sys_enter() before tail-calling syscall-specific functions.
> >
> > It'd be great if we cover all syscalls in the BPF skeleton and switch
> > to the beauty-map and discard the functions.
> 
> Right, as Namhyung says, sys_enter() runs augment_sys_enter() before
> tail-calling syscalls_sys_enter, and only falls back to the tail call
> if augment_sys_enter() returns non-zero:
> 
>   if (augment_sys_enter(args, &augmented_args->args))
>     bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> 
> trace__init_syscalls_bpf_prog_array_maps() populates beauty_map_enter
> for every enabled syscall, even ones with a dedicated sys_enter_*
> program. In trace__bpf_sys_enter_beauty_map(), connect, bind and
> sendto's "struct sockaddr *" argument matched the struct branch, which
> looked up "struct sockaddr" in BTF and put bt->size (16 bytes) in
> beauty_array. So whenever BTF was available, augment_sys_enter()
> handled connect, bind and sendto by copying 16 bytes and returned 0,
> and sys_enter_connect / sys_enter_sendto were never tail-called.
> 
> beauty_array already supports dynamic lengths from another syscall
> argument: a negative entry -(j + 1) tells augment_arg() to read
> args->args[j] bytes (clamped to TRACE_AUG_MAX_BUF = 32), which was
> added for buffer arguments like write's buf/count. This patch uses
> that encoding for struct sockaddr * when the next argument is its
> length.

I guess that clamp can be made bigger, 64 maybe? Applying the series
now.

Committer testing:

Is using BPF:

  root@x2:~# strace -e bpf perf trace -e connect,bind |& head -5
  bpf(BPF_TOKEN_CREATE, {token_create={flags=0, bpffs_fd=12}}, 8) = -1 EOPNOTSUPP (Operation not supported)
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffea3054260, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, core_relo_cnt=0, fd_array=NULL, core_relos=NULL, core_relo_rec_size=0, log_true_size=0, prog_token_fd=0}, 148) = 12
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffea3054390, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, core_relo_cnt=0, fd_array=NULL, core_relos=NULL, core_relo_rec_size=0, log_true_size=0, prog_token_fd=0, fd_array_cnt=0, signature=NULL, signature_size=0, keyring_id=0}, 168) = 12
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffea3053f80, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="libbpf_nametest", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, core_relo_cnt=0, fd_array=NULL, core_relos=NULL, core_relo_rec_size=0, log_true_size=0, prog_token_fd=0}, 148) = 12
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="libbpf_mmap", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0, map_extra=0, value_type_btf_obj_fd=0, map_token_fd=0, excl_prog_hash=NULL, excl_prog_hash_size=0}, 92) = 12
  root@x2:~#

And btf:

  root@x2:~# strace -e openat perf trace -e connect,bind |& grep "/sys/kernel/btf/vmlinux"
  openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 12
  ^C
  root@x2:~#

And copying the sockaddr parameters according to its addrlen or the cap
in the augmented bpf, that probably needs to be a bit bigger for local
sockets:

  ⬢ [acme@toolbx perf-tools-next]$ echo -n /var/run/.heim_org.h5l.kcm-soc | wc -c
  30
  ⬢ [acme@toolbx perf-tools-next]$ ls -la /var/run/.heim_org.h5l.kcm-socket 
  srw-rw-rw-. 1 nobody nobody 0 Sep 14 23:13 /var/run/.heim_org.h5l.kcm-socket
  ⬢ [acme@toolbx perf-tools-next]$ 

  root@x2:~# perf trace -e connect,bind --max-events 10
       0.000 ( 0.717 ms): pool-0/29901 connect(fd: 9, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-soc }, addrlen: 110) = 0
       3.733 ( 0.059 ms): pool-0/29901 connect(fd: 10, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-soc }, addrlen: 110) = 0
       8.859 ( 0.054 ms): pool-0/29901 connect(fd: 9, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-soc }, addrlen: 110) = 0
      10.880 ( 0.053 ms): pool-0/29901 connect(fd: 9, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-soc }, addrlen: 110) = 0
    1225.303 ( 0.081 ms): systemd-resolv/103685 connect(fd: 30, uservaddr: { .family: INET6, port: 53, addr: fd55:6f31:c26b::1, scope_id: 4 }, addrlen: 28) = 0
    1226.000 ( 0.046 ms): systemd-resolv/103685 connect(fd: 31, uservaddr: { .family: INET6, port: 53, addr: fd55:6f31:c26b::1, scope_id: 4 }, addrlen: 28) = 0
    1371.972 ( 0.055 ms): systemd-resolv/103685 connect(fd: 27, uservaddr: { .family: INET6, port: 53, addr: fd55:6f31:c26b::1, scope_id: 4 }, addrlen: 28) = 0
    1382.266 ( 0.260 ms): Socket Thread/2663038 connect(fd: 178, uservaddr: { .family: INET, port: 443, addr: 186.192.83.34 }, addrlen: 16) = -1 (unknown) (Operation now in progress)
    5003.508 ( 0.063 ms): pool-0/29901 connect(fd: 9, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-soc }, addrlen: 110) = 0
    5007.007 ( 0.054 ms): pool-0/29901 connect(fd: 10, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-soc }, addrlen: 110) = 0
  root@x2:~#
