Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647898F5C;
	Fri, 23 May 2025 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748036185; cv=none; b=T93id8u3yJvsRpLLExC8OOXOnqizfkwcD1va9GQZfTmhl1bb2GQMaCtSb1oZ1bmVhmaEzVvvH1jB/aUmtctaoyxTzBmK6Zitde3LWYR2cGIPX6ZNu2ZO1eCLzTDFT2lkZiGdovFUxFyQ76/j4p7eUSdILsWtiatHbEmDQFzNvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748036185; c=relaxed/simple;
	bh=Ms3TTJ8nkVYnRSxV222T+cB9moNyejBFtBngZsyvv0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMO+mZy6OWzQ1amOSzrVptrlNvuRSVkZFbuJ0CyngNMTi39t0eNxCDVmEzJnkNMrVQ7go38Ku87LuCnDB70LP77RLLVVWQPVP44/AcaURIYa1ndBJwmyv+TmV1B7axyz9NjJq9TI5nO3DtJlqKh4qXHsl6n+nYdAESKwjQ0Arv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP7X0feS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP7X0feS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7667EC4CEE9;
	Fri, 23 May 2025 21:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748036184;
	bh=Ms3TTJ8nkVYnRSxV222T+cB9moNyejBFtBngZsyvv0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uP7X0feSQaiwkuCaRQKGAVR8Li8reG0AERaZaL8C6pn17M0DVVzlAKKHZQm270kZv
	 96wTpd3RDicJAPBgh0265dX2JFJQVB6403aSAoiP0TL65XMQNDzzpJpU6CjmIdvPyj
	 vP+nDTJgHzuIOn+OK6k+XzOPxVpePB6/GaGvtNdpBhaUWvOymIq4rEebzANpmPdcDk
	 i5hst/uxeNvM1In7VINDVFQp2hw/SMGpJs/C2aAPKBBcpEOBGixlRPwwkaImkZRuoo
	 v6nup+nwczuK8Q8L6iile9vjladhqKTy1PQFaiGHwii4qILrLVN2nlR/oTg7kxhNj1
	 NfGFMyRJAD2Jg==
Date: Fri, 23 May 2025 14:36:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf test: Support arch-specific shell tests
Message-ID: <aDDqV7opuG26U6WU@google.com>
References: <20250522171044.1075583-1-namhyung@kernel.org>
 <CAP-5=fXDaKueO9HE-Gr3Q7R6qm2EjwnL845nh7R2OU+DCfrhyA@mail.gmail.com>
 <4763aca8-a140-4291-b12e-e03cc0d82bdd@linaro.org>
 <aDCncXryXGaOuDNl@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDCncXryXGaOuDNl@x1>

On Fri, May 23, 2025 at 01:50:57PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, May 23, 2025 at 11:48:26AM +0100, James Clark wrote:
> > On 22/05/2025 9:09 pm, Ian Rogers wrote:
> > > On Thu, May 22, 2025 at 10:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > This is a preparation for shell tests belong to an arch.
> 
> > > I keep repeating that I don't like arch and I think ideally we'd be
> > > getting rid of the C arch tests. I just sent out a patch doing this
> > > for 1 test:
> > > https://lore.kernel.org/lkml/20250521165317.713463-2-irogers@google.com/
> > > We should be able to make perf, tests, etc. dependent on a PMU rather
> > > than an architecture. This means that running perf built for ARM will
> > > be able to do things running on an instruction emulator on x86. It
>  
> > In this case for Arm SPE and Coresight you can only generate trace by
> > running on a full model or a real CPU, so I'm not sure if we could ever get
> > close to running on just an emulator.
>  
> > > means the tool, the kernel APIs, etc. are generic and new
> > > architectures like RISC-V can test things. It means cross-platform
> > > (record on 1 machine type, report on another) can work without
> > > tripping over load bearing architecture ifdefs. It means that we
>  
> > I have thought about adding some generic decoding side tests for SPE and
> > Coresight, but couldn't really get past the fact that you need to put the
> > trace dump _and_ the binaries traced into the git repo.
> 
> So, we could have some .perfconfig setting that states the user wants to
> auto-download the tracefiles if not present locally.
> 
> If not available locally and not explicitely authorized via
> "test.coresight_traces_download=yes" or some more suitable name, then it
> would skip the test and show as the reason the lack of needed trace
> files, with a hint about how to enable it, something like:
> 
> 176: Coresight hw trace decoding      : Skip   (Enable fetching via 'perf test test.coresight_trace_download=yes')
> 
> We are already auto-downloading debuginfo files (not the whole packages,
> just for the needed build-id) in some cases, like:
> 
> root@x1:~# pahole --running_kernel_vmlinux
> /usr/lib/debug/lib/modules/6.13.9-100.fc40.x86_64/vmlinux
> root@x1:~#
> root@x1:~# time perf probe -L icmp_rcv > /dev/null
> 
> real	0m2.046s
> user	0m1.550s
> sys	0m0.486s
> root@x1:~#
> 
> But if I move that file:
> 
> root@x1:~# pahole --running_kernel_vmlinux
> /usr/lib/debug/lib/modules/6.13.9-100.fc40.x86_64/vmlinux
> root@x1:~# mv /usr/lib/debug/lib/modules/6.13.9-100.fc40.x86_64/vmlinux ~
> root@x1:~# pahole --running_kernel_vmlinux
> vmlinux
> root@x1:~#
> 
> Oops, it searches the current directory too ;)
> 
> root@x1:~# mkdir hideout
> root@x1:~# mv vmlinux hideout/
> root@x1:~# pahole --running_kernel_vmlinux
> pahole: couldn't find a vmlinux that matches the running kernel
> HINT: Maybe you're inside a container or missing a debuginfo package?
> root@x1:~#
> 
> Now:
> 
> root@x1:~# time perf probe -L icmp_rcv | head
> 
> Takes a while, in other term:
> 
> root@x1:~# ps ax|grep 'perf probe' | grep -v grep
> 1755681 pts/13   S+     0:00 perf probe -L icmp_rcv
> root@x1:~# 
> root@x1:~# perf trace -p 1755681 --summary sleep 10s
> 
>  Summary of events:
> 
>  perf (1755681), 4756 events, 100.0%
> 
>    syscall            calls  errors  total       min       avg       max       stddev
>                                      (msec)    (msec)    (msec)    (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- ---------     ------
>    poll                 606      0  9645.195     0.000    15.916   757.894     16.65%
>    write                580      0    17.904     0.004     0.031     0.237      3.41%
>    recvfrom            1191    374     8.380     0.001     0.007     0.083      3.58%
>    sendto                 1      0     0.026     0.026     0.026     0.026      0.00%
> 
> 
> root@x1:~#
> 
> root@x1:~# perf trace -p 1755681 -e write --max-stack 16 --max-events 1
>      0.000 ( 0.103 ms): perf/1755681 write(fd: 5, buf: \219*\0\26\230\1\11\136\4\0\0\192\0\5'g\0\0\150\1pid\0p\1487\172h\0\0\1, count: 10157) = 10157
>                                        syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
>                                        syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
>                                        syscall_exit_to_user_mode ([kernel.kallsyms])
>                                        do_syscall_64 ([kernel.kallsyms])
>                                        entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
>                                        __GI___libc_write (/usr/lib64/libc.so.6)
>                                        chop_write.lto_priv.0 (/usr/lib64/libcurl.so.4.8.0)
>                                        <invalid> (inlined)
>                                        inflate_stream (/usr/lib64/libcurl.so.4.8.0)
>                                        <invalid> (inlined)
>                                        cw_download_write (/usr/lib64/libcurl.so.4.8.0)
>                                        <invalid> (inlined)
>                                        <invalid> (inlined)
>                                        Curl_readwrite (/usr/lib64/libcurl.so.4.8.0)
>                                        multi_runsingle (/usr/lib64/libcurl.so.4.8.0)
>                                        curl_multi_perform (/usr/lib64/libcurl.so.4.8.0)
>                                        perform_queries (/usr/lib64/libdebuginfod-0.192.so)
>                                        debuginfod_query_server_by_buildid (/usr/lib64/libdebuginfod-0.192.so)
>                                        open_debuginfo (/home/acme/bin/perf)
>                                        __show_line_range (/home/acme/bin/perf)
>                                        show_line_range (/home/acme/bin/perf)
>                                        __cmd_probe (/home/acme/bin/perf)
> root@x1:~#
> 
> Those <invalid> ones...
> 
> unwind: curl_multi_perform:ip = 0x7f6e7ab33464 (0x4e464)
> unwind: access_mem addr 0x7ffe829cec08, val 2b324d40, offset 1480
> unwind: access_mem addr 0x7ffe829cec30, val 7ffe829d01f0, offset 1520
> unwind: access_mem addr 0x7ffe829cec10, val 2b32b9e4, offset 1488
> unwind: access_mem addr 0x7ffe829cec18, val ffffffff, offset 1496
> unwind: access_mem addr 0x7ffe829cec20, val 0, offset 1504
> unwind: access_mem addr 0x7ffe829cec28, val 0, offset 1512
> unwind: access_mem addr 0x7ffe829cec38, val 7f6e7b326c5f, offset 1528
> unwind: perform_queries:ip = 0x7f6e7b324b2d (0x5b2d)
> unwind: access_mem addr 0x7ffe829d01c8, val 7ffe829d0260, offset 7048
> unwind: access_mem addr 0x7ffe829d01f0, val 7ffe829d0320, offset 7088
> unwind: access_mem addr 0x7ffe829d01d0, val 0, offset 7056
> unwind: access_mem addr 0x7ffe829d01d8, val 0, offset 7064
> unwind: access_mem addr 0x7ffe829d01e0, val 2b2db8c0, offset 7072
> unwind: access_mem addr 0x7ffe829d01e8, val 2b324d40, offset 7080
> unwind: access_mem addr 0x7ffe829d01f8, val 6792ef, offset 7096
> unwind: debuginfod_query_server_by_buildid:ip = 0x7f6e7b326c5e (0x7c5e)
> unwind: access_mem addr 0x7ffe829d02f8, val 2b2dace0, offset 7352
> unwind: access_mem addr 0x7ffe829d0320, val 7ffe829d05b0, offset 7392
> unwind: access_mem addr 0x7ffe829d0300, val 0, offset 7360
> unwind: access_mem addr 0x7ffe829d0308, val 2b2dace0, offset 7368
> unwind: access_mem addr 0x7ffe829d0310, val 0, offset 7376
> unwind: access_mem addr 0x7ffe829d0318, val 0, offset 7384
> unwind: access_mem addr 0x7ffe829d0328, val 67aaff, offset 7400
> unwind: open_debuginfo:ip = 0x6792ee (0x2792ee)
> unwind: access_mem addr 0x7ffe829d0588, val 0, offset 8008
> unwind: access_mem addr 0x7ffe829d05b0, val 7ffe829d0620, offset 8048
> unwind: access_mem addr 0x7ffe829d0590, val 0, offset 8016
> unwind: access_mem addr 0x7ffe829d0598, val 2b2dace0, offset 8024
> unwind: access_mem addr 0x7ffe829d05a0, val 0, offset 8032
> unwind: access_mem addr 0x7ffe829d05a8, val 0, offset 8040
> unwind: access_mem addr 0x7ffe829d05b8, val 67b0ea, offset 8056
> unwind: __show_line_range:ip = 0x67aafe (0x27aafe)
> unwind: access_mem addr 0x7ffe829d05f8, val 0, offset 8120
> unwind: access_mem addr 0x7ffe829d0620, val 7ffe829d1180, offset 8160
> unwind: access_mem addr 0x7ffe829d0600, val 7ffe829d06a0, offset 8128
> unwind: access_mem addr 0x7ffe829d0608, val 8, offset 8136
> unwind: access_mem addr 0x7ffe829d0610, val 2b2d74d0, offset 8144
> unwind: access_mem addr 0x7ffe829d0618, val 6df140, offset 8152
> unwind: access_mem addr 0x7ffe829d0628, val 4979b3, offset 8168
> unwind: show_line_range:ip = 0x67b0e9 (0x27b0e9)
> unwind: no map for 7ffe829d1158
> unwind: access_mem 0x7ffe829d1158 not inside range 0x7ffe829ce640-0x7ffe829d0640
> unwind: no map for 7ffe829d1180
> unwind: access_mem 0x7ffe829d1180 not inside range 0x7ffe829ce640-0x7ffe829d0640
> unwind: no map for 7ffe829d1160
> unwind: access_mem 0x7ffe829d1160 not inside range 0x7ffe829ce640-0x7ffe829d0640
> unwind: no map for 7ffe829d1168
> unwind: access_mem 0x7ffe829d1168 not inside range 0x7ffe829ce640-0x7ffe829d0640
> unwind: no map for 7ffe829d1170
> unwind: access_mem 0x7ffe829d1170 not inside range 0x7ffe829ce640-0x7ffe829d0640
> unwind: no map for 7ffe829d1178
> unwind: access_mem 0x7ffe829d1178 not inside range 0x7ffe829ce640-0x7ffe829d0640
> unwind: no map for 7ffe829d1188
> unwind: access_mem 0x7ffe829d1188 not inside range 0x7ffe829ce640-0x7ffe829d0640
> unwind: __cmd_probe:ip = 0x4979b2 (0x979b2)
>      0.000 ( 0.102 ms): perf/1755681 write(fd: 5, buf: \197\10\17K\137\0\0\0\9ops\0\197\11#y\4\1\0\8\1\176+E\0\197\12\15]\0\0, count: 16384) = 16384
>                                        syscall_exit_to_user_mode_prepare ([kernel.kallsyms])
> 
> 
> Anyway, I'm digressing, I need to make this auto-download similar to
> what I proposed above for the coresight traces needed by the tests you
> think about adding for decoding in all platforms, which I encourage you
> to do.
> 
> > Not only would this benefit testing on other arches like you say, but
> > it would also lock down that decoding of a known file doesn't regress
> > which we can't currently do by generating new trace every time the
> > test runs.
> 
> Right.
>  
> > If we ever added this they would be separate tests though so they could go
> > in the top level folder, where the ones in the arch folder would continue to
> > do record and decode. Maybe naming the folders by PMU could work, but you
> > could also have both PMU name and arch name folders like:
>  
> > Recording/requires hardware:
>  
> >   tools/perf/arch/arm64/tests/shell/cs_etm/
>  
> > Cross platform decode tests:
>  
> >   tools/perf/tests/shell/cs_etm/
>  
> > Which would mirror how the source files are currently laid out:
>  
> >  tools/perf/arch/arm/util/cs-etm.c
> >  tools/perf/util/cs-etm.c
> 
> Yeah, I think we can experiment with this and take advantage of the
> effort Namhyung already put into this, and then revisit later, after
> trying this for a while.

I'm ok with sending v2 removing arch shell tests.  Actually it'd be
simpler.  Let me know which way you prefer. :)

Thanks,
Namhyung

> 
> Ah, finally:
> 
> root@x1:~# time perf probe -L icmp_rcv | head 
> <icmp_rcv@/root/.cache/debuginfod_client/aa3c82b4a13f9c0e0301bebb20fe958c4db6f362/source-d5d23b89-#usr#src#debug#kernel-6.13.9#linux-6.13.9-100.fc40.x86_64#net#ipv4#icmp.c:0>
>       0  int icmp_rcv(struct sk_buff *skb)
>          {
>       2  	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
>          	struct rtable *rt = skb_rtable(skb);
>          	struct net *net = dev_net_rcu(rt->dst.dev);
>          	struct icmphdr *icmph;
>          
>          	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
>       8  		struct sec_path *sp = skb_sec_path(skb);
> 
> real	9m20.630s
> user	0m5.427s
> sys	0m2.127s
> root@x1:~#
> 
> And now:
> 
> root@x1:~# pahole --running_kernel_vmlinux
> /root/.cache/debuginfod_client/aa3c82b4a13f9c0e0301bebb20fe958c4db6f362/debuginfo
> root@x1:~#
> 
> Also:
> 
> root@x1:~# file /root/.cache/debuginfod_client/aa3c82b4a13f9c0e0301bebb20fe958c4db6f362/debuginfo
> /root/.cache/debuginfod_client/aa3c82b4a13f9c0e0301bebb20fe958c4db6f362/debuginfo: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=aa3c82b4a13f9c0e0301bebb20fe958c4db6f362, with debug_info, not stripped
> root@x1:~# file hideout/vmlinux
> hideout/vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=aa3c82b4a13f9c0e0301bebb20fe958c4db6f362, with debug_info, not stripped
> root@x1:~#
> 
> root@x1:~# sha256sum /root/.cache/debuginfod_client/aa3c82b4a13f9c0e0301bebb20fe958c4db6f362/debuginfo hideout/vmlinux
> 6e998df9b235ed50ea4d7c6d997450cb7bd6691537e525f002630ae123bc0084  /root/.cache/debuginfod_client/aa3c82b4a13f9c0e0301bebb20fe958c4db6f362/debuginfo
> 6e998df9b235ed50ea4d7c6d997450cb7bd6691537e525f002630ae123bc0084  hideout/vmlinux
> root@x1:~#
> 
> But:
> 
> root@x1:~# rpm -qf /usr/lib/debug/lib/modules/6.13.9-100.fc40.x86_64/vmlinux
> kernel-debuginfo-6.13.9-100.fc40.x86_64
> root@x1:~# rpm -V kernel-debuginfo-6.13.9-100.fc40.x86_64
> missing     /usr/lib/debug/lib/modules/6.13.9-100.fc40.x86_64/vmlinux
> root@x1:~#
> 
> Lets fix this:
> 
> root@x1:~# mv hideout/vmlinux /usr/lib/debug/lib/modules/6.13.9-100.fc40.x86_64/vmlinux
> root@x1:~# rpm -V kernel-debuginfo-6.13.9-100.fc40.x86_64
> root@x1:~#
> 
> Cheers,
> 
> - Arnaldo
