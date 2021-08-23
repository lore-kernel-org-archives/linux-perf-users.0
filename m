Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3DC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 17:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D52D613AD
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 17:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhHWRJP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230360AbhHWRJO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 13:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629738511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lxg//3eey4TUS/a3sz+07SLWq4shoABUaJ8HgvWL3kA=;
        b=V/KfwNWEcItAtsjg9sUAqcBRiCYke/UbxhRyfKJxtX6DqY6K8rbsLYjYQh2l+sa8S+I1+K
        4wtLkgMACFwtAqdtfz776yEg3vIRqV/IlOTRG6zwAZZ2LPbyvhcspde9m6GRL4ua8ImjVB
        2naV/Y6OfRNzGZnxZty2Rq6QYxhvi2U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-7nQiH2M2O72MV6SzZNaVeg-1; Mon, 23 Aug 2021 13:08:29 -0400
X-MC-Unique: 7nQiH2M2O72MV6SzZNaVeg-1
Received: by mail-wr1-f69.google.com with SMTP id p10-20020adfce0a000000b001572d05c970so3021891wrn.21
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 10:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=lxg//3eey4TUS/a3sz+07SLWq4shoABUaJ8HgvWL3kA=;
        b=b5pXQULOJF30ADf2XF+UuyXlwcM9ws5II4SCea2gn++QZfEHQ8t+3Fhko+LHQxMLL+
         cVAgFOQi72XNjGbxUeej9zpmiv7/G8Qk8HldvRzEh+erhXkBVWaScA3cY1/7976Dy2Oc
         CPgNmvFAwCWXM1Kyz7n8DV6fITl4oVLwBCX5eV+nRbqsQHZbXrPb/c92Ir2NGkjlMaRF
         mYnzlqtE6LxUpCpy4yuaV+v5vnCVr8fttfmescNUf3E9DNcFB+Q3MKwpc4yxNz3dZqao
         xBdmGpY5rj+Bz/NRQgTfq8ZHtIuGyyjMU9l0n/vSlm+ct8227fhsCJDiNdP21jQOYI5k
         m5sw==
X-Gm-Message-State: AOAM531LwiHZzDDCTqYxI1yyNOGN0r7f45jRwKsBDGMEAiLWM5EuOgJa
        u3f5nEbhAOSRamnEHYrDUZgrdaKj5iT1l8kUfwoJdzII8I0CF4OiJDriukyvd09kKro/rPxQCfO
        kbhr2lGLBYkTRkML3N+sMZ8ihQXxohQ==
X-Received: by 2002:a05:600c:2186:: with SMTP id e6mr1866568wme.71.1629738508639;
        Mon, 23 Aug 2021 10:08:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiSbMSRAVxD8kBhswAL0JoQgi00+ujYtI0IrE8IufaseRXpTKa3WcsJ4l0pg7mLFOg3BCf8w==
X-Received: by 2002:a05:600c:2186:: with SMTP id e6mr1866545wme.71.1629738508325;
        Mon, 23 Aug 2021 10:08:28 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id o21sm1578929wms.32.2021.08.23.10.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:08:27 -0700 (PDT)
Date:   Mon, 23 Aug 2021 19:08:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: intel_pt crash on alderlake
Message-ID: <YSPWCienSPEcvIbU@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

hi,
should intel_pt work on alderlake? I'm getting strange crash:
(cpuinfo and uname below)

	[root@intel-alderlake-m-02 perf]# ./perf record -e 'intel_pt//' --overwrit=
e=20
	perf: Segmentation fault
	Obtained 16 stack frames.
	./perf() [0x53b6eb]
	./perf() [0x53b7cb]
	./perf() [0x429b30]
	/lib64/libc.so.6(+0x37400) [0x7f7b144db400]
	./perf() [0x5a6fc8]
	./perf() [0x505caa]
	./perf() [0x4f39ca]
	./perf() [0x646879]
	./perf() [0x646b57]
	./perf() [0x646da0]
	./perf() [0x4f3eec]
	./perf() [0x42a533]
	./perf() [0x42a644]
	./perf() [0x42aa72]
	./perf() [0x42c915]
	./perf() [0x42ecc3]
	Segmentation fault (core dumped)


	[root@intel-alderlake-m-02 perf]# gdb ./perf
	GNU gdb (GDB) Red Hat Enterprise Linux 8.2-15.el8
	Copyright (C) 2018 Free Software Foundation, Inc.
	License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.ht=
ml>
	This is free software: you are free to change and redistribute it.
	There is NO WARRANTY, to the extent permitted by law.
	Type "show copying" and "show warranty" for details.
	This GDB was configured as "x86_64-redhat-linux-gnu".
	Type "show configuration" for configuration details.
	For bug reporting instructions, please see:
	<http://www.gnu.org/software/gdb/bugs/>.
	Find the GDB manual and other documentation resources online at:
	    <http://www.gnu.org/software/gdb/documentation/>.

	For help, type "help".
	Type "apropos word" to search for commands related to "word"...
	Reading symbols from ./perf...done.
	(gdb) r record -e 'intel_pt//' --overwrite
	Starting program: /root/linux/tools/perf/perf record -e 'intel_pt//' --ove=
rwrite
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib64/libthread_db.so.1".

	Program received signal SIGSEGV, Segmentation fault.
	0x00000000005a6fc8 in auxtrace_mmap__mmap (mm=3D0x7ffff7e9c060, mp=3D0x7ff=
fffff7588, userpg=3D0x7ffff7e0b000, fd=3D5) at util/auxtrace.c:133
	133             pc->aux_offset =3D mp->offset;
	Missing separate debuginfos, use: yum debuginfo-install brotli-1.0.6-3.el8=
=2Ex86_64 bzip2-libs-1.0.6-26.el8.x86_64 cyrus-sasl-lib-2.1.27-5.el8.x86_64=
 elfutils-debuginfod-client-0.185-1.el8.x86_64 elfutils-libelf-0.185-1.el8.=
x86_64 elfutils-libs-0.185-1.el8.x86_64 glib2-2.56.4-156.el8.x86_64 gmp-6.1=
=2E2-10.el8.x86_64 gnutls-3.6.16-4.el8.x86_64 keyutils-libs-1.5.10-9.el8.x8=
6_64 libbabeltrace-1.5.4-3.el8.x86_64 libbpf-0.3.0-1.el8.x86_64 libcap-2.26=
-4.el8.x86_64 libcom_err-1.45.6-2.el8.x86_64 libcurl-7.61.1-18.el8.x86_64 l=
ibffi-3.1-22.el8.x86_64 libidn2-2.2.0-1.el8.x86_64 libpsl-0.20.2-6.el8.x86_=
64 libselinux-2.9-5.el8.x86_64 libssh-0.9.4-3.el8.x86_64 libtasn1-4.13-3.el=
8.x86_64 libunistring-0.9.9-3.el8.x86_64 libuuid-2.32.1-28.el8.x86_64 libxc=
rypt-4.1.1-6.el8.x86_64 libzstd-1.4.4-1.el8.x86_64 numactl-libs-2.0.12-13.e=
l8.x86_64 openldap-2.4.46-17.el8.x86_64 openssl-libs-1.1.1k-4.el8.x86_64 p1=
1-kit-0.23.22-1.el8.x86_64 pcre-8.42-6.el8.x86_64 pcre2-10.32-2.el8.x86_64 =
perl-libs-5.26.3-420.el8.x86_64 popt-1.18-1.el8.x86_64 slang-2.3.2-3.el8.x8=
6_64 xz-libs-5.2.4-3.el8.x86_64
	(gdb) bt
	#0  0x00000000005a6fc8 in auxtrace_mmap__mmap (mm=3D0x7ffff7e9c060, mp=3D0=
x7fffffff7588, userpg=3D0x7ffff7e0b000, fd=3D5) at util/auxtrace.c:133
	#1  0x0000000000505caa in mmap__mmap (map=3D0x7ffff7e8c010, mp=3D0x7ffffff=
f7570, fd=3D5, cpu=3D0) at util/mmap.c:306
	#2  0x00000000004f39ca in perf_evlist__mmap_cb_mmap (_map=3D0x7ffff7e8c010=
, _mp=3D0x7fffffff7570, output=3D5, cpu=3D0) at util/evlist.c:807
	#3  0x0000000000646879 in mmap_per_evsel (evlist=3D0xf1c7d0, ops=3D0x7ffff=
fff7550, idx=3D0, mp=3D0x7fffffff7570, cpu_idx=3D0, thread=3D0, _output=3D0=
x7fffffff7480, _output_overwrite=3D0x7fffffff7484) at evlist.c:477
	#4  0x0000000000646b57 in mmap_per_cpu (evlist=3D0xf1c7d0, ops=3D0x7ffffff=
f7550, mp=3D0x7fffffff7570) at evlist.c:550
	#5  0x0000000000646da0 in perf_evlist__mmap_ops (evlist=3D0xf1c7d0, ops=3D=
0x7fffffff7550, mp=3D0x7fffffff7570) at evlist.c:602
	#6  0x00000000004f3eec in evlist__mmap_ex (evlist=3D0xf1c7d0, pages=3D4294=
967295, auxtrace_pages=3D1024, auxtrace_overwrite=3Dfalse, nr_cblocks=3D0, =
affinity=3D0, flush=3D1, comp_level=3D0) at util/evlist.c:959
	#7  0x000000000042a533 in record__mmap_evlist (rec=3D0xc8b580 <record>, ev=
list=3D0xf1c7d0) at builtin-record.c:854
	#8  0x000000000042a644 in record__mmap (rec=3D0xc8b580 <record>) at builti=
n-record.c:881
	#9  0x000000000042aa72 in record__open (rec=3D0xc8b580 <record>) at builti=
n-record.c:963
	#10 0x000000000042c915 in __cmd_record (rec=3D0xc8b580 <record>, argc=3D0,=
 argv=3D0x7fffffffddf0) at builtin-record.c:1717
	#11 0x000000000042ecc3 in cmd_record (argc=3D0, argv=3D0x7fffffffddf0) at =
builtin-record.c:2897
	#12 0x00000000004d7143 in run_builtin (p=3D0xca33d8 <commands+216>, argc=
=3D4, argv=3D0x7fffffffddf0) at perf.c:313
	#13 0x00000000004d73b0 in handle_internal_command (argc=3D4, argv=3D0x7fff=
ffffddf0) at perf.c:365
	#14 0x00000000004d74f7 in run_argv (argcp=3D0x7fffffffdc4c, argv=3D0x7ffff=
fffdc40) at perf.c:409
	#15 0x00000000004d78c3 in main (argc=3D4, argv=3D0x7fffffffddf0) at perf.c=
:539
	(gdb) p *pc
	$1 =3D {version =3D 0, compat_version =3D 0, lock =3D 2, index =3D 0, offs=
et =3D 0, time_enabled =3D 0, time_running =3D 0, {capabilities =3D 26, {ca=
p_bit0 =3D 0, cap_bit0_is_deprecated =3D 1, cap_user_rdpmc =3D 0, cap_user_=
time =3D 1,=20
	      cap_user_time_zero =3D 1, cap_user_time_short =3D 0, cap_____res =3D=
 0}}, pmc_width =3D 48, time_shift =3D 31, time_mult =3D 2663050159, time_o=
ffset =3D 18446743875728538161, time_zero =3D 18446743981699475147,=20
	  size =3D 96, __reserved_1 =3D 0, time_cycles =3D 0, time_mask =3D 0, __r=
eserved =3D '\000' <repeats 927 times>, data_head =3D 0, data_tail =3D 0, d=
ata_offset =3D 4096, data_size =3D 524288, aux_head =3D 0, aux_tail =3D 0,=
=20
	  aux_offset =3D 0, aux_size =3D 0}
	(gdb) p *mp
	$2 =3D {mask =3D 4194303, offset =3D 528384, len =3D 4194304, prot =3D 3, =
idx =3D 0, tid =3D -1, cpu =3D 0}
	(gdb)=20


any idea? thanks,
jirka


----
[jolsa@krava linus-pure]$ cat /proc/cpuinfo=20
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 142
model name      : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
stepping        : 10
microcode       : 0xea
cpu MHz         : 2100.000
cache size      : 8192 KB
physical id     : 0
siblings        : 8
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx p=
dpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopo=
logy nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx s=
mx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe po=
pcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch=
 cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi fl=
expriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms=
 invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv=
1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp md_c=
lear flush_l1d
vmx flags       : vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb f=
lexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple shado=
w_vmcs pml ept_mode_based_exec
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf=
 mds swapgs taa itlb_multihit srbds
bogomips        : 4199.88
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

[root@intel-alderlake-m-02 linux]# uname -a
Linux intel-alderlake-m-02.ml3.eng.bos.redhat.com 5.14.0-rc6+ #1 SMP Fri Au=
g 20 09:27:39 EDT 2021 x86_64 x86_64 x86_64 GNU/Linux

