Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E626AEA
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719745377; cv=none; b=HVbrcSTZHGsazEydPo4fNoljd6eAEkjvAtSGlMgBTwboeYWvsF7T3Qdx2M5rKvl5HwXd/Y+JDSZ4Hl8VMfjwyHZrAqJEdWDm/K1d57K0eIIWlHve7K+OkssKMvGhb+bVC5V7YjC40oxcYC53iCsiZbWe4vu8q4WmcqVZEIEt0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719745377; c=relaxed/simple;
	bh=pdl31phA4W64pt5pasr3hg8CcZ7EUL7wp7UWT8W/0FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dnVt5pf/0wc5ygL5icwgEQanUYo/Y33rb8SqwfVwne1VNBn0WfRKFsKXLAJIRw3fdMrObPe2ai+9DXtzZw1KH9Ba+N58hE3UyqrHj1PV5d6Y85gnOv+4ujeN4BgfmAXHk4nrCGrll5DxXLo4A0CKYyWR+boDmyfXGXVnMMGG0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G7kW7oSp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G7kW7oSp"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UAv0nm026362;
	Sun, 30 Jun 2024 11:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:content-transfer-encoding:mime-version; s=pp1; bh=B
	iBooGlZWKT5o5eRnRWdYGyE6+oM0Rakpkge87sdj3E=; b=G7kW7oSpCTsZ738Az
	Ol8U82TKBzamRSxjLFrrFXUgkg60fW6GDf8jdbzCQRPtaxyLYoISiaZRmI3+IURP
	rH0kx/tOhNSqSdZYDySfx5n+QUji0Yh9BS9I1QIBo/k07sP8VHDr3N1dQd1ePQjR
	TqKjkb1xWccvoNZEfjDPq2LKZiMHAemcS87nmUDHq1JKv1r1VdTjRQT+zdldo3oa
	DAQtQsIIl7n73jfv414gcvgaNgGAQ+Sv1H8MhO5qi2BAgsDsf0KXTXc0zc9XH03Q
	KzFdUL/2cHnIQqu8P6sCx17e8ZutFry8iL3oj4Tjd+2bT8bicZFfWz5Oq2GMzZkO
	fSqAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4035mvg1kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 11:02:52 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UB2pSV004337;
	Sun, 30 Jun 2024 11:02:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4035mvg1kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 11:02:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45U7jLYx024120;
	Sun, 30 Jun 2024 11:02:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya31g1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 11:02:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45UB2id456754626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 11:02:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB88920043;
	Sun, 30 Jun 2024 11:02:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B79D20040;
	Sun, 30 Jun 2024 11:02:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.221.162])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 30 Jun 2024 11:02:42 +0000 (GMT)
Date: Sun, 30 Jun 2024 16:31:58 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <plbg7naplxqb7lmjkgexfwdtf7ustmfn6wokhuazrkouk6o7eh@h2lnnzz7tzot>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1>
 <Zn7GsEKwLxn5bMyN@x1>
 <Zn7HtaJb3NL2k5YG@x1>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn7HtaJb3NL2k5YG@x1>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9sh81BhPW7ySCvk1IovyMwR9o3k2EbfR
X-Proofpoint-ORIG-GUID: VzqwvbU8thJWSv1LupbGgVjpaJRigEtd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_09,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=783 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300085

Hello Arnaldo,

> > > ⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
> > > 
> > >  Usage: perf check [<subcommand>] [<options>]
> > > 
> > >     -q, --quiet           do not show any warnings or messages
> > > 
> > > ⬢[acme@toolbox perf-tools-next]$
> > > 
> > > 
> > > I don't see a way to list what features can be tested against, would be
> > > great to have.
> > > 
> > > Also it just says that the usage is wrong, no indication as to why, I
> > > think this would be more informative:
> > > 
> > > 
> > > ⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
> > > Unkown feature 'libtrafs', please use 'perf check feature --list' to see which ones are available.
> 
> Or:
> 
> ⬢[acme@toolbox perf-tools-next]$ perf version --build-options

Sure, or we can continue discussion in the original thread where you
mentioned 'perf check feature --list'.

> perf version 6.10.rc1.g25cd7047ff7b
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>   dwarf-unwind-support: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>             libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
> ⬢[acme@toolbox perf-tools-next]$
> 
> I.e.:
> 
> Unkown feature 'libtrafs', please use 'perf version --build-options' to see which ones are available.
> 
> And while looking at it:
> 
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> 
> This looks wrong, no? Or at least confusing, have to check the source
> code...

Yes it is confusing. I don't have any knowledge on that macro though.
Will try to understand from git history.

> 
> Also:
> 
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT

Interesting, found this code in Makefile.config:

    ifndef NO_LIBNUMA
      ifeq ($(feature-libnuma), 0)
        $(warning No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev)
        NO_LIBNUMA := 1
      else
        ifeq ($(feature-numa_num_possible_cpus), 0)
          $(warning Old numa library found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev >= 2.0.8)
          NO_LIBNUMA := 1
        else
          CFLAGS += -DHAVE_LIBNUMA_SUPPORT
          EXTLIBS += -lnuma
          $(call detected,CONFIG_NUMA)
        endif
      endif
    endif

So, both 'numa_num_possible_cpus' and 'libnuma' define the same macro in
CFLAG: HAVE_LIBNUMA_SUPPORT

But then, both are not needed actually in, since either feature will
always have same status as the other feature.

Should I keep it ?

Thanks,
Aditya Gupta

> 
> - Arnaldo
> 
> > > ⬢[acme@toolbox perf-tools-next]$
> > 
> > Ah, to clarify, these comments are for the v12 series even being replies
> > to the v11 thread, I'll move to the v12 e-mail thread. Using b4 I got
> > the latest version, v12:
> > 
> > Cover: ./v12_20240628_adityag_introduce_perf_check_subcommand.cover
> >  Link: https://lore.kernel.org/r/20240628064236.1123851-1-adityag@linux.ibm.com
> >  Base: applies clean to current tree
> >        git checkout -b v12_20240628_adityag_linux_ibm_com HEAD
> >        git am ./v12_20240628_adityag_introduce_perf_check_subcommand.mbx
> > ⬢[acme@toolbox perf-tools-next]$        git am ./v12_20240628_adityag_introduce_perf_check_subcommand.mbx
> > Applying: perf check: introduce check subcommand
> > Applying: perf version: update --build-options to use 'supported_features' array
> > Applying: perf tests task_analyzer: use perf check for libtraceevent support
> > Applying: tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
> > ⬢[acme@toolbox perf-tools-next]$
