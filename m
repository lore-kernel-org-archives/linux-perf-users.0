Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB81A711
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 17:32:32 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB21C4
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 10:32:30 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392HVDKj028187;
	Mon, 2 Oct 2023 17:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=lMTBvWh6BXl0H0dOoFosaN3gYDw0zHeocp9JxzRME7A=;
 b=IfaEMfDWNSyhmx7RaXYlhOtx8CKAh0aoydtZoWIi+I8EO1Nzm1S1fvtQa7FpfXpFekzs
 iTKIu+OpMh89KimAukIkCFUko2wLxJmIkj69UZI5gSDxLEuamZlrCWHHen8cIOh0SolS
 HoZUNJ+14fGLr+8d3ewG5+yW61gBkwPimhKbgl7B+VzYXZxMy2HaQrAVeZfYp9Ac2vCI
 SDkvknZNM0taZxlm5kpo49Y6MdTPfJFdaSZF/KnAe90y4b1rm4Evddc3w1H0ZHLCJqHL
 bx280xswvGtu169qe3pZCE+yyYrL5LYLX5nzwY2p0hj9Nh/ALhjXo6+rD8BoqcSScD8I zA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tg2at815c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Oct 2023 17:32:27 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 392HVX22029685;
	Mon, 2 Oct 2023 17:32:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tg2at814p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Oct 2023 17:32:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 392FXNHC017592;
	Mon, 2 Oct 2023 17:27:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0mu5s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Oct 2023 17:27:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 392HRM3J10093302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Oct 2023 17:27:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 123902004E;
	Mon,  2 Oct 2023 17:27:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBA2420040;
	Mon,  2 Oct 2023 17:27:19 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.171.16.145])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Oct 2023 17:27:19 +0000 (GMT)
Date: Mon, 2 Oct 2023 22:57:15 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v3 1/4] perf check: introduce check subcommand
Message-ID: <5x7ocxlhqfppdnimxvhsvieeiotjybqhoomk3kkodn2lerondc@vgrbhgpbv3rp>
References: <20230929055757.83174-1-adityag@linux.ibm.com>
 <20230929055757.83174-2-adityag@linux.ibm.com>
 <CAM9d7ciYngXfyVdPfnknkQLy-7oi0H=1Ufn9yKgp3h_MuAEb_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciYngXfyVdPfnknkQLy-7oi0H=1Ufn9yKgp3h_MuAEb_A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QrEGnMmD2eBp0lqJDVTG1EcNAUiZw-RB
X-Proofpoint-GUID: gV6pgZ6Eq7Xxja9SQCMWUXtbZ4RXZL5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 11:18:57PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Sep 28, 2023 at 10:58 PM Aditya Gupta <adityag@linux.ibm.com> wrote:
> >
> > Currently the presence of a feature is checked with a combination of
> > perf version --build-options and greps, such as:
> >
> >     perf version --build-options | grep " on .* HAVE_FEATURE"
> >
> > Instead of this, introduce a subcommand "perf check --feature", with which
> > scripts can test for presence of a feature, such as:
> >
> >     perf check --feature HAVE_FEATURE
> >
> > 'perf check --feature' command is expected to have exit status of 1 if
> > feature is built-in, and 0 if it's not built-in or if feature is not known.
> >
> > An array 'supported_features' has also been introduced that can be used by
> > other commands like 'perf version --build-options', so that new features
> > can be added in one place, with the array
> >
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >  tools/perf/Build                        |   1 +
> >  tools/perf/Documentation/perf-check.txt |  56 +++++++++++
> >  tools/perf/builtin-check.c              | 122 ++++++++++++++++++++++++
> >  tools/perf/builtin.h                    |  18 ++++
> >  tools/perf/perf.c                       |   1 +
> >  5 files changed, 198 insertions(+)
> >  create mode 100644 tools/perf/Documentation/perf-check.txt
> >  create mode 100644 tools/perf/builtin-check.c
> >
> > diff --git a/tools/perf/Build b/tools/perf/Build
> > index aa7623622834..a55a797c1b5f 100644
> > --- a/tools/perf/Build
> > +++ b/tools/perf/Build
> > @@ -1,5 +1,6 @@
> >  perf-y += builtin-bench.o
> >  perf-y += builtin-annotate.o
> > +perf-y += builtin-check.o
> >  perf-y += builtin-config.o
> >  perf-y += builtin-diff.o
> >  perf-y += builtin-evlist.o
> > diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> > new file mode 100644
> > index 000000000000..5cf6ab7df8c3
> > --- /dev/null
> > +++ b/tools/perf/Documentation/perf-check.txt
> > @@ -0,0 +1,56 @@
> > +perf-check(1)
> > +===============
> > +
> > +NAME
> > +----
> > +perf-check - check features in perf
> > +
> > +SYNOPSIS
> > +--------
> > +'perf check' [-q] [--feature]
> 
> I think it's better to say like below for later changes.
> 
> 'perf check' [<options>]

Sure, will make that change in V4

> 
> > diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> > new file mode 100644
> > index 000000000000..da7ee93bbbf5
> > 
> > ...
> >
> > +struct feature_support supported_features[] = {
> > +       FEATURE_SUPPORT("dwarf", HAVE_DWARF_SUPPORT),
> > +       FEATURE_SUPPORT("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
> > +       FEATURE_SUPPORT("libaudit", HAVE_LIBAUDIT_SUPPORT),
> > +       FEATURE_SUPPORT("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
> > +       FEATURE_SUPPORT("libbfd", HAVE_LIBBFD_SUPPORT),
> > +       FEATURE_SUPPORT("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
> > +       FEATURE_SUPPORT("libelf", HAVE_LIBELF_SUPPORT),
> > +       FEATURE_SUPPORT("libnuma", HAVE_LIBNUMA_SUPPORT),
> > +       FEATURE_SUPPORT("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
> > +       FEATURE_SUPPORT("libperl", HAVE_LIBPERL_SUPPORT),
> > +       FEATURE_SUPPORT("libpython", HAVE_LIBPYTHON_SUPPORT),
> > +       FEATURE_SUPPORT("libslang", HAVE_SLANG_SUPPORT),
> > +       FEATURE_SUPPORT("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
> > +       FEATURE_SUPPORT("libunwind", HAVE_LIBUNWIND_SUPPORT),
> > +       FEATURE_SUPPORT("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
> > +       FEATURE_SUPPORT("zlib", HAVE_ZLIB_SUPPORT),
> > +       FEATURE_SUPPORT("lzma", HAVE_LZMA_SUPPORT),
> > +       FEATURE_SUPPORT("get_cpuid", HAVE_AUXTRACE_SUPPORT),
> > +       FEATURE_SUPPORT("bpf", HAVE_LIBBPF_SUPPORT),
> > +       FEATURE_SUPPORT("aio", HAVE_AIO_SUPPORT),
> > +       FEATURE_SUPPORT("zstd", HAVE_ZSTD_SUPPORT),
> > +       FEATURE_SUPPORT("libpfm4", HAVE_LIBPFM),
> > +       FEATURE_SUPPORT("libtraceevent", HAVE_LIBTRACEEVENT),
> > +
> > +       // this should remain at end, to know the array end
> 
> We prefer C-style comments using /* ... */.

Sure, will use /**/ form of comments in V4

> 
> > ...
> >
> > +int cmd_check(int argc, const char **argv)
> > +{
> > +       argc = parse_options(argc, argv, check_options, check_usage,
> > +                            PARSE_OPT_STOP_AT_NON_OPTION);
> > +
> > +       if (!quiet)
> > +               printf("perf check %s\n", perf_version_string);
> > +
> > +       if (check.feature)
> > +               return has_support(check.feature);
> 
> Oh, sorry for making you confused.  I think it'd be better to exit with 0
> for success and 1 (or other) for failure to conform to the shell
> convention.  You may invert the return value from the function.
> 

Sure, I had thought the opposite from past review, will invert the return
values in V4.

Thanks
- Aditya Gupta

> Thanks,
> Namhyung
> 
> 
> > +
> > +       return 0;
> > +}
> > diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> > index f2ab5bae2150..9f895981bc9e 100644
> > --- a/tools/perf/builtin.h
> > +++ b/tools/perf/builtin.h
> > @@ -2,6 +2,23 @@
> >  #ifndef BUILTIN_H
> >  #define BUILTIN_H
> >
> > +#include <stddef.h>
> > +#include <linux/compiler.h>
> > +#include <tools/config.h>
> > +
> > +struct feature_support {
> > +       const char *name;
> > +       const char *macro;
> > +       int is_builtin;
> > +};
> > +#define FEATURE_SUPPORT(name_, macro_) { \
> > +       .name = name_,                       \
> > +       .macro = #macro_,                    \
> > +       .is_builtin = IS_BUILTIN(macro_) }
> > +
> > +extern struct feature_support supported_features[];
> > +
> >  void list_common_cmds_help(void);
> >  const char *help_unknown_cmd(const char *cmd);
> >
> > @@ -9,6 +26,7 @@ int cmd_annotate(int argc, const char **argv);
> >  int cmd_bench(int argc, const char **argv);
> >  int cmd_buildid_cache(int argc, const char **argv);
> >  int cmd_buildid_list(int argc, const char **argv);
> > +int cmd_check(int argc, const char **argv);
> >  int cmd_config(int argc, const char **argv);
> >  int cmd_c2c(int argc, const char **argv);
> >  int cmd_diff(int argc, const char **argv);
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index d3fc8090413c..6514f4121c49 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -50,6 +50,7 @@ static struct cmd_struct commands[] = {
> >         { "archive",    NULL,   0 },
> >         { "buildid-cache", cmd_buildid_cache, 0 },
> >         { "buildid-list", cmd_buildid_list, 0 },
> > +       { "check",      cmd_check,      0 },
> >         { "config",     cmd_config,     0 },
> >         { "c2c",        cmd_c2c,        0 },
> >         { "diff",       cmd_diff,       0 },
> > --
> > 2.41.0
> >
