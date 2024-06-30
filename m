Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAE1E878
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719743459; cv=none; b=teybyb2cMjfQcv1s7IWzoM9qkr6taOS7zPauFxd1oIeu6aaLF2IUEWhEkt3cuDfxwBILSg6gAACZJmLgCueG8qaDa0RgNAiplJSt6wIX35lCuUl59uU8MdD5UppYqXCCMJkVWM3pe+6TEYo9WWP91PsSI9V65YV55R71k11PJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719743459; c=relaxed/simple;
	bh=fcAwDBjqd0WbbFMo63ghrKs/x6d3z8+mN5/WPE+0bfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udIVwJmhnAum+DhaNhpO+LAWHvvKNzMoqQNMVlrbSfYU1yD4fPgzGdNn1Z8E5k1Jn6IHqPAR289H+UYfLbptYWMJvauugaQoj/AETN0D+/rQZIjF/ynRyyJgkrzgr8I73qzN/GKtgoCV4utf6TSlytKv+uOh2YUrYyz5ZsZElRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YT5va5Cq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YT5va5Cq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UAT94G031209;
	Sun, 30 Jun 2024 10:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=H
	++R3ZSw8LmeOF4Y+jUtcfVae4M/4RyR901Q8hBEUjs=; b=YT5va5CqvrmCthJ3I
	7cFQixPLVvAQhpeaa9MN+ogOXjuv/fPiq5H3s3W8ZM34RcH/HfV5ngtff//fmSrH
	yP+V7c2DabPgFeLfa6/B8Ygl8EiVP3yfIxoON0NlXV8eLggEZ3Px9geYDATQGrWY
	i++uw30wbsdI18TJecicQ20UqoL9aQw4Diq7x+J1SCAKd/8imYCCunkx98X7PLXk
	BMPfLPj+hd3rCRxivgN0RM7+E/yhtes2ac8H23tkJjy/mjybYwT7scM5gpm0mtgq
	yV8YaR3o93hCDIzA3GsPH9/ChsIYbBo1/CEA9OkyHlnIZfzec6EEuI7yGbfXEmFd
	y8ieg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4035mv802v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:30:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UAUkWR001709;
	Sun, 30 Jun 2024 10:30:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4035mv802u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:30:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45U7Fd4e009529;
	Sun, 30 Jun 2024 10:30:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtm9gnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:30:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45UAUev947317298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 10:30:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF282005A;
	Sun, 30 Jun 2024 10:30:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1ABA20040;
	Sun, 30 Jun 2024 10:30:37 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.221.162])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 30 Jun 2024 10:30:37 +0000 (GMT)
Date: Sun, 30 Jun 2024 16:00:34 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <a5gkak2uawnvyytl2hhp4ku6jwlzged5jweof6mhbnbtjs5jz5@3lqyw7bhmkvz>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn7EvDbsnlbLXj4g@x1>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fTxGN-JMs5efIhDwWYiTvzlJj8M-fF5f
X-Proofpoint-ORIG-GUID: kzcSFXXjdRxrkpb0l2e0V6VEjPDKA2IE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=916 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300081

Hello Arnaldo,

Thanks for the many reviews you shared.

On 24/06/28 11:12AM, Arnaldo Carvalho de Melo wrote:
> Some minor patch format comments, the commiter could fix those up while
> applying, but I don't think its a strict req for merging the patch
> series:
> 
>   Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
> 
> Please capitalize the first letter in the summary sentence:
> 
>   Subject: Re: [PATCH v11 1/4] perf check: Introduce check subcommand
> 
> And when talking about some special name, quote it:
> 
>   Subject: Re: [PATCH v11 1/4] perf check: Introduce 'check' subcommand
> 

Sure, will update in v13.

> > <...snip...>
> >
> > +++ b/tools/perf/Documentation/perf-check.txt
> > @@ -0,0 +1,78 @@
> > +perf-check(1)
> > +===============
> > +
> > +NAME
> > +----
> > +perf-check - check features in perf
> 
> 
> perf-check - check if features are present

Will do

> 
> > +
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'perf check' [<options>]
> > +'perf check' {feature <feature_list>} [<options>]
> > +
> > +DESCRIPTION
> > +-----------
> > +With no options given, the 'perf check' just prints the perf version
>                                         subcommand

Sure, also since the statement is not true anymore ('perf check' does
not print the perf version now, only the command usage), how does this
sound ?

    With no subcommands given, 'perf check' command just prints the command
    usage on the standard output.

> > +on the standard output.
> > +
> > +If the subcommand 'feature' is used, then status of feature is printed
> > +on the standard output (unless '-q' is also passed), ie. whether it is
> > +compiled-in/built-in or not.
> > +Also, 'perf check feature' returns with exit status 0 if the feature
> > +is built-in, otherwise returns with exit status 1.
> > +
> > +SUBCOMMANDS
> > +-----------
> > +
> > +feature::
> > +
> > +        Print whether feature(s) is compiled-in or not, and also returns with an
> > +        exit status of 0, if passed feature(s) are compiled-in, else 1.
> > +
> > +        It expects a feature list as an argument. There can be a single feature
> > +        name/macro, or multiple features can also be passed as a comma-separated
> > +        list, in which case the exit status will be 0 only if all of the passed
> > +        features are compiled-in.
> > +
> > +        The feature names/macros are case-insensitive.
> > +
> > +        Example Usage:
> > +                perf check feature libtraceevent
> > +                perf check feature HAVE_LIBTRACEEVENT
> > +                perf check feature libtraceevent,bpf
> > +
> > +        Supported feature names/macro:
> > +                aio                     /  HAVE_AIO_SUPPORT
> > +                bpf                     /  HAVE_LIBBPF_SUPPORT
> > +                bpf_skeletons           /  HAVE_BPF_SKEL
> > +                debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
> > +                dwarf                   /  HAVE_DWARF_SUPPORT
> > +                dwarf_getlocations      /  HAVE_DWARF_GETLOCATIONS_SUPPORT
> > +                get_cpuid               /  HAVE_AUXTRACE_SUPPORT
> > +                numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
> > +                libaudit                /  HAVE_LIBAUDIT_SUPPORT
> > +                libbfd                  /  HAVE_LIBBFD_SUPPORT
> > +                libelf                  /  HAVE_LIBELF_SUPPORT
> > +                libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
> > +                libdw-dwarf-unwind      /  HAVE_DWARF_SUPPORT
> > +                libnuma                 /  HAVE_LIBNUMA_SUPPORT
> > +                libperl                 /  HAVE_LIBPERL_SUPPORT
> > +                libpfm4                 /  HAVE_LIBPFM
> > +                libpython               /  HAVE_LIBPYTHON_SUPPORT
> > +                libslang                /  HAVE_SLANG_SUPPORT
> > +                libtraceevent           /  HAVE_LIBTRACEEVENT
> > +                libunwind               /  HAVE_LIBUNWIND_SUPPORT
> > +                lzma                    /  HAVE_LZMA_SUPPORT
> > +                syscall_table           /  HAVE_SYSCALL_TABLE_SUPPORT
> > +                zlib                    /  HAVE_ZLIB_SUPPORT
> > +                zstd                    /  HAVE_ZSTD_SUPPORT
> 
> There are actually more features that are detected and that probably
> would be great to support:
> 
> ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/FEATURE-DUMP 
> feature-backtrace=1
> feature-dwarf=1
> feature-dwarf_getlocations=1
> feature-dwarf_getcfi=1
> feature-eventfd=1
> feature-fortify-source=1
> feature-get_current_dir_name=1
> feature-gettid=1
> feature-glibc=1
> feature-libbfd=1
> feature-libbfd-buildid=1
> feature-libcap=1
> feature-libelf=1
> feature-libelf-getphdrnum=1
> feature-libelf-gelf_getnote=1
> feature-libelf-getshdrstrndx=1
> feature-libnuma=1
> feature-numa_num_possible_cpus=1
> feature-libperl=1
> feature-libpython=1
> feature-libslang=1
> feature-libslang-include-subdir=1
> feature-libtraceevent=1
> feature-libtracefs=1
> feature-libcrypto=1
> feature-libunwind=1
> feature-pthread-attr-setaffinity-np=1
> feature-pthread-barrier=1
> feature-reallocarray=1
> feature-stackprotector-all=1
> feature-timerfd=1
> feature-libdw-dwarf-unwind=1
> feature-zlib=1
> feature-lzma=1
> feature-get_cpuid=1
> feature-bpf=1
> feature-scandirat=1
> feature-sched_getcpu=1
> feature-sdt=1
> feature-setns=1
> feature-libaio=1
> feature-libzstd=1
> feature-disassembler-four-args=1
> feature-disassembler-init-styled=1
> feature-file-handle=1
> ⬢[acme@toolbox perf-tools-next]$
> 
> We can get the ones not supported so far in a followup patch, if/when we
> agree it would be useful.

Yes, would be nice if the feature list covers most feature checks.
I will look into it and try to improve by v13, or will post a follow up
patch later to add these !

Thanks,
- Aditya Gupta

