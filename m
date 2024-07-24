Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AA200B7;
	Wed, 24 Jul 2024 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721860812; cv=none; b=JUbHj2eMhXIeiogUG3lW7vnqm9oZTggSGYc+lHLwp5k8OtV/9A5jxNxOUvJXzE0N3lCHJy8+4LT6CCALO9zap3xzkGlTcM2GmqSxS4N8Vv05nAxPbOYr5VOPJr+T428Z0eJsQSBdHaMT3bY4xPWdiKCMsk/YHevTeY1C3Tx3W7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721860812; c=relaxed/simple;
	bh=tmlxpayuV3jDlFaqKj2rOtg1uM4wWdq0sjaX+JM1sxI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pmpyNMY1246FH3rlQ80Hgz/CJLJB/z5PIMvzdJS7Q5r2zB+EU+TbQqjSuNaopuKo1L1/wKFLgaRxS/b5oZLUPZ+X0Q/aQutASzesrhKDR6iCyJAkrmUkJZwUD1boc20iIN+rCipTJSgOvNhUpcRNRYfaunH+ZJgYclIXwRmlq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5ia4uTz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5ia4uTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE063C4AF0B;
	Wed, 24 Jul 2024 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721860812;
	bh=tmlxpayuV3jDlFaqKj2rOtg1uM4wWdq0sjaX+JM1sxI=;
	h=From:Date:Subject:To:From;
	b=F5ia4uTzRmPVqpaLW3g6dcbhas6Ipn6N7ZpKQfKJOVuc98EATLFqQcIDkYk9N+h/n
	 Pi0wqamDb99Py1LvtNjVpA8iYe7nk9ucl1OWhhFFzW/6dyBP9MLBbT3ZmXM/6stRwC
	 2i/7lQlDQ/9vbTqLwanxJrYb/wNUqmFIovaCA80oNrVmCpklgRylRVfXkJ8vktb0BW
	 Ngy/Ytu3sF3ohfVHCa2sdQ3kG72LbN5G/i+Aaen2WITfwGOI9xs4Ecyya1ccaj1bXN
	 dyYmSPvDFqOPEy8mDudsObPLVRh2h+P4/oR37Y5RN2Run5OGogP0pf2mrZ8qoSHdsK
	 ZR1277BAxZpag==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f01993090so250973e87.2;
        Wed, 24 Jul 2024 15:40:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIZF6Cn4OqaKyZFjdlnGitftyouGBfQdovGWYy5/4CYNfw+6BPWPLkknm3jRl8ZM/2GOzbFcv4m09eHcleg7n7H9OdQEwdTT2JiirXMfd95p1e7n9E7rBNuMJVIlroRSG9FPZDMkgWyxsaTSenMQ==
X-Gm-Message-State: AOJu0YzZ1OLOmw/JOEDQLRe24yaDO+zd7n3WAuSZzQdSzOWkdX8aEw7Q
	kZjvRdKFDggMfrLnqgCM/1RwvK8SxosfybITCDI1QHB2ro4ExHO4T7JGNxPn1aDWymfL93/dsNm
	SsaRqhYbZJY24DnMDZHZ16lQbLHI=
X-Google-Smtp-Source: AGHT+IGyylxLRvuCgajjGvnA6xRN/RXDpV4dAJUTt5Ifz5wL/0g5kY01ORv8ZrFhN/IpKLm2+0cO3ofS6jq824rR5Lk=
X-Received: by 2002:a05:6512:4002:b0:52c:dc25:d706 with SMTP id
 2adb3069b0e04-52fd609293bmr27117e87.52.1721860810236; Wed, 24 Jul 2024
 15:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Song Liu <song@kernel.org>
Date: Wed, 24 Jul 2024 15:39:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
Message-ID: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
Subject: Some unc_cha_tor_* events appear to be "not supported"?
To: Kan Liang <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, jonesz@meta.com
Content-Type: text/plain; charset="UTF-8"

Hi folks,

We noticed that some unc_cha_tor_occupancy and unc_cha_tor_inserts events
appear to be "not supported" and always counting zero (see an example below).
Is this a known issue? We are testing with 6.10 kernel and perf.

Thanks,
Song


[root@kerneltest008.05.atn6 ~]# ./perf list | grep
unc_cha_tor_occupancy.ia_hit_llcprefdrd
  unc_cha_tor_occupancy.ia_hit_llcprefdrd
[root@kerneltest008.05.atn6 ~]# ./perf stat -e
unc_cha_tor_occupancy.ia_hit_llcprefdrd -a -- sleep 1
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!
WARNING: event 'N/A' not valid (bits 10,12-13,15 of config1 '4b433'
not supported by kernel)!

 Performance counter stats for 'system wide':

                 0      unc_cha_tor_occupancy.ia_hit_llcprefdrd

       1.001680312 seconds time elapsed

[root@kerneltest008.05.atn6 ~]# grep "model name" -m 1 /proc/cpuinfo
model name      : Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz
[root@kerneltest008.05.atn6 ~]# uname -r
6.10.0
[root@kerneltest008.05.atn6 ~]# ./perf -vv
perf version 6.10.g0c3836482481
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ OFF ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
           libcapstone: [ OFF ]  # HAVE_LIBCAPSTONE_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ OFF ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
  dwarf-unwind-support: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
