Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fp0kRtgZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B8F192
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 23:12:15 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG7BGRv010692;
	Thu, 16 Nov 2023 07:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=uschxzA9WJL2+sjXqRBiWusJT5oUaSLNXxRFI7y65zA=;
 b=Fp0kRtgZ7uhHaoH2SRJUW/mFNa/4+NDgDsCL4q8CE449W6tvAffcBWDGfedapbx+7rPJ
 qbaJmUlYnuz8dxe7b9VHnXr6kyuKd+JXYhQPrlU5OJIzc9zsDdBsTr2gNdzuTPRfJMvi
 H4oisB3OmhriZNPUtva3wBgII8EwzX0tllcy/ngY9ppEGhuomDLsfYcNW6jN9JSs1jGd
 FmZ0I3aSwtZuYNpjB/TeE9d2UJ1TrCoRyCcWPjXlhjvDKdY6izTO1haM7YaLcuTSl3qi
 SoM/NanYfiehmMTmq/+YpfUa4OqVaTuOUXujuhmtk+7RsuIfEW8GI7rZRdTrpx0+Yl/o IA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uddpf9g8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 07:12:12 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AG7CBTI018029;
	Thu, 16 Nov 2023 07:12:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uddpf9der-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 07:12:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG5Hji7019745;
	Thu, 16 Nov 2023 07:06:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5kchd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 07:06:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AG76ZLp62914862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 07:06:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39C32004E;
	Thu, 16 Nov 2023 07:06:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 962422004B;
	Thu, 16 Nov 2023 07:06:33 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Nov 2023 07:06:33 +0000 (GMT)
Date: Thu, 16 Nov 2023 12:36:28 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v6 1/4] perf check: introduce check subcommand
Message-ID: <k45gzpnpkqbmkthhgj2gdnvddnmwk53qjwu2dztdloj6b5hka4@vqdibzxgpj27>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
 <20231021150526.2231803-2-adityag@linux.ibm.com>
 <ZU493oMRpGgNBrQV@kernel.org>
 <ZU4+3HxUMg7hW52e@kernel.org>
 <ZU5AcywaEAM1zUvG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU5AcywaEAM1zUvG@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VRtg8W9S4sHWms9rv1WrX7QcmOgka9Pu
X-Proofpoint-ORIG-GUID: vTyLUZs1WcrGM018LQdZS7IGbZxTepRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_04,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=860 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160055

On Fri, Nov 10, 2023 at 11:38:43AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 10, 2023 at 11:31:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Nov 10, 2023 at 11:27:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Sat, Oct 21, 2023 at 08:35:23PM +0530, Aditya Gupta escreveu:
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>   
> > > Right after applying this first patch:
>   
> > > [acme@quaco perf-tools-next]$ m
> > > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > > builtin-check.c:53:56: error: expected ‘}’ before ‘;’ token
> > >    53 |         FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
> > >       |                                                        ^
> > > builtin-check.c:29:47: note: to match this ‘{’
> > >    29 | struct feature_support supported_features[] = {
> > >       |                                               ^
> > > make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/builtin-check.o] Error 1
> > > make[3]: *** Waiting for unfinished jobs....
> > > make[2]: *** [Makefile.perf:669: /tmp/build/perf-tools-next/perf-in.o] Error 2
> > > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > > make: *** [Makefile:113: install-bin] Error 2
> > > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>  
> > It was a simple error, please be more careful next time.
>  
> > I'm testing the rest of the patchset now.
> 
> Please resubmit when you address the problem fixed with this patch and:
> 
> Mussing newline, why print the version again? What is that "perf check "
> prefix for?

Sure, I will send a V7 with the problems fixed.

> 
> [acme@quaco perf-tools-next]$ perf check --feature traceevent
> perf check 6.6.rc1.g78fa196349bc
> Feature not known: traceevent[acme@quaco perf-tools-next]$
> 
> Why should we require "--feature"? The following format is descriptive
> enough:
> 
> [acme@quaco perf-tools-next]$
> [acme@quaco perf-tools-next]$ perf check traceevent
> perf check 6.6.rc1.g78fa196349bc
> [acme@quaco perf-tools-next]$

This was done, so that the proposed 'perf check' command could be extended
in future for other usage also, and not just for checking if a feature is
available or not

In initial versions of this patch series, it was implemented also
'perf build --has libtraceevent', though with discussions, we arrived at a new
sucommand 'perf check', and checking if a feature is enabled is done just
with a flag 'perf check --feature', so that 'perf check' can be extended in
future.

> 
> So I had to go back and use:
> 
> [acme@quaco perf-tools-next]$ perf -vv
> perf version 6.6.rc1.g78fa196349bc
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
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> [acme@quaco perf-tools-next]$
> 
> To see (some) of the features, please add a:
> 
> # perf check --list-features
> 
> So that we can get that features array printed.

This is already there in 'perf version --build-options' command. And that is the
command which was being used by scripts to check if a feature is enabled or not.

> 
> Some other feature requests:
> 
> [acme@quaco perf-tools-next]$ perf check --feature libtraceevent,libbpf_support
> perf check 6.6.rc1.g78fa196349bc
> Feature not known: libtraceevent,libbpf_support[acme@quaco perf-tools-next]$
> 
> This should return true if both are available.

This can be done. Sure.

> 
> Also, shouldn't be --quiet be the default since this is being designed
> for use in scripts?
> 

It will mostly be used by scripts only, but still if used as a command by any
user, it's intended that they also see whether feature was enabled or not,
instead of relying on the exit code.

Thanks for your reviews, and fixing the mistake I made.

Thanks,
- Aditya Gupta

> - Arnaldo
>  
> > - Arnaldo
> > 
> > diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> > index 1183983e4352798d..1502804780507b5d 100644
> > --- a/tools/perf/builtin-check.c
> > +++ b/tools/perf/builtin-check.c
> > @@ -50,7 +50,7 @@ struct feature_support supported_features[] = {
> >  	FEATURE_SUPPORT("zstd", HAVE_ZSTD_SUPPORT),
> >  	FEATURE_SUPPORT("libpfm4", HAVE_LIBPFM),
> >  	FEATURE_SUPPORT("libtraceevent", HAVE_LIBTRACEEVENT),
> > -	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
> > +	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL),
> >  
> >  	/* this should remain at end, to know the array end */
> >  	FEATURE_SUPPORT(NULL, _)
> 
> -- 
> 
> - Arnaldo
