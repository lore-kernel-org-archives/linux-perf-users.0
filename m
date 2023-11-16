Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e4ka7DF8"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B90182
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 23:12:56 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG7Aojn017038;
	Thu, 16 Nov 2023 07:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=FbliIxJCmii/rlCSvRC5OvkVYXjrDcDqRMz3/H06XaI=;
 b=e4ka7DF8L6pn6AFRpCPMgnIowC5pkHTDONbZy4Eyqskdh6K0REQPkBLgJHVmRPEea9Oa
 iwN9vzX/u4/43/AU6PthC9G4kCrGm0hG8y9ig5pPx4I8sfmEaiys3nT2cpeCy1X+t8eL
 W0fIDVfGheItR1omfRa5KtPwO3LhAUHbSaM9Axw6TvGU5vdjt9XUPnef087EJBaBlFeO
 Je/wh91VHVODzVQoPwchj/BpnfAetvr4SMFiz5gdl4FOSdk/Q8dVJrXyU8oGkgeJ5Fm3
 s2CPpWBVX2RoixxlttFvqX9KiUT2uZKHihP84qK1vCUD570SaGIJ+3S7zCYKSSwMmW1D zw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ude4cgub8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 07:12:54 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AG7Bq95020525;
	Thu, 16 Nov 2023 07:12:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ude4cguaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 07:12:53 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG5Fn9A019663;
	Thu, 16 Nov 2023 07:12:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5kcj6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 07:12:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AG7Cntn3539516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 07:12:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 888112004D;
	Thu, 16 Nov 2023 07:12:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859962004B;
	Thu, 16 Nov 2023 07:12:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Nov 2023 07:12:47 +0000 (GMT)
Date: Thu, 16 Nov 2023 12:42:42 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v6 1/4] perf check: introduce check subcommand
Message-ID: <kp5ftxsenkywukvlpsd76xexfozlz7a7qsrbtrzqpukytc2gmo@e2xlbfgadhgn>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
 <20231021150526.2231803-2-adityag@linux.ibm.com>
 <ZU493oMRpGgNBrQV@kernel.org>
 <ZU4+3HxUMg7hW52e@kernel.org>
 <ZU5AcywaEAM1zUvG@kernel.org>
 <CAM9d7cjJckDtP8Xhw4fFc7gk98fQQbHQ2nBpoWcikUgASRHgUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjJckDtP8Xhw4fFc7gk98fQQbHQ2nBpoWcikUgASRHgUw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6-5OMTozaiWwNu3TLhqd31gZjhzxag8h
X-Proofpoint-GUID: RZIeR4241OhqIkEnGRBRPw9zy42zU8Pw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_04,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=786
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160055

On Fri, Nov 10, 2023 at 02:46:46PM -0800, Namhyung Kim wrote:
> On Fri, Nov 10, 2023 at 6:38 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Nov 10, 2023 at 11:31:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Nov 10, 2023 at 11:27:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Sat, Oct 21, 2023 at 08:35:23PM +0530, Aditya Gupta escreveu:
> > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> >
> > > > Right after applying this first patch:
> >
> > > > [acme@quaco perf-tools-next]$ m
> > > > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > > > builtin-check.c:53:56: error: expected ‘}’ before ‘;’ token
> > > >    53 |         FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
> > > >       |                                                        ^
> > > > builtin-check.c:29:47: note: to match this ‘{’
> > > >    29 | struct feature_support supported_features[] = {
> > > >       |                                               ^
> > > > make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/builtin-check.o] Error 1
> > > > make[3]: *** Waiting for unfinished jobs....
> > > > make[2]: *** [Makefile.perf:669: /tmp/build/perf-tools-next/perf-in.o] Error 2
> > > > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > > > make: *** [Makefile:113: install-bin] Error 2
> > > > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> >
> > > It was a simple error, please be more careful next time.
> >
> > > I'm testing the rest of the patchset now.
> >
> > Please resubmit when you address the problem fixed with this patch and:
> >
> > Mussing newline, why print the version again? What is that "perf check "
> > prefix for?
> >
> > [acme@quaco perf-tools-next]$ perf check --feature traceevent
> > perf check 6.6.rc1.g78fa196349bc
> > Feature not known: traceevent[acme@quaco perf-tools-next]$
> >
> > Why should we require "--feature"? The following format is descriptive
> > enough:
> 
> I thought we might want to extend the functionality of the check
> command later.  Maybe we can check how many perf counters
> are supported or which sysctl settings are affected and so on.
> 
> Maybe we need to make '--feature' option to a sub-command
> like `perf check feature xxx`.  So it cannot be mixed with others
> later.

True, 'perf check' is intended to be extended.
We can make it 'perf check feature libtraceevent', but any extra flags etc to
'perf check feature' can be equally verbose of what was intended to be a replacement
for 'perf version --build-options | grep "libtraceevent.*on"'

> 
> >
> > [acme@quaco perf-tools-next]$
> > [acme@quaco perf-tools-next]$ perf check traceevent
> > perf check 6.6.rc1.g78fa196349bc
> > [acme@quaco perf-tools-next]$
> >
> > So I had to go back and use:
> >
> > [acme@quaco perf-tools-next]$ perf -vv
> > perf version 6.6.rc1.g78fa196349bc
> >                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> >     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
> >             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> >     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >                libpfm4: [ on  ]  # HAVE_LIBPFM
> >          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> >          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> > [acme@quaco perf-tools-next]$
> >
> > To see (some) of the features, please add a:
> >
> > # perf check --list-features
> >
> > So that we can get that features array printed.
> >
> > Some other feature requests:
> >
> > [acme@quaco perf-tools-next]$ perf check --feature libtraceevent,libbpf_support
> > perf check 6.6.rc1.g78fa196349bc
> > Feature not known: libtraceevent,libbpf_support[acme@quaco perf-tools-next]$
> >
> > This should return true if both are available.
> 
> Sounds good.

Sure, I will do it next version.

> 
> >
> > Also, shouldn't be --quiet be the default since this is being designed
> > for use in scripts?
> 
> I don't know.. users might want to see the result instead
> of checking the return value.
> 
>      libtraceevent: [ on  ]
>     libbpf_support: [ OFF ]
> 

Thanks Namhyung for answering the questions while I was not active.

Thanks,
- Aditya

> Thanks,
> Namhyung

