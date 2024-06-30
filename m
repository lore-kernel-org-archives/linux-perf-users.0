Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B423A29C
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719747449; cv=none; b=KkGc9ipxPjAR74HNP7svOXsM+vTGO1abem97JBdwvh8/6hINFMS1u8Ndu/oa/PRF90mrMOxMMs5uNQHPhcNat2hAghzxoAaN7lz2sBy0LfoVGB8wMpXA5npw045KmKh28GwVBaPgMM6UyhqqpVvCgs38SmrD+/YZw3qcbZc1uhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719747449; c=relaxed/simple;
	bh=zOSnSSqlMq6OAAWFd8hFfNefuAY7unhROG32ud3ayFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvhrsA/ny4hmiwaPd+8jNSA3ate7xv9artTguPPPz3pXYbNxWnmZaStAEzHUn4E6LpONG9J2cbZXYFPSCwFW+Izt3f1U1TBYYFa9ZaL0JvbIT8fauQHasPL9jbxtkGhIvnwWMAL3CkEHRNxuaV4dxenGV6gcvBpqnmBgoXcGjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bv5p9uad; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bv5p9uad"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UB0BPX030641;
	Sun, 30 Jun 2024 11:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=+bHO1RFs+3fEk2s+lVO4Au/sDXJ
	N5+/cjeh2X1vjbsA=; b=bv5p9uadgNytedyJDQdFK6Iz+L8ZMULH9EJLdln8wGO
	bc0CPmJx7xo5DsBWHiCMhK5mzQKtcZ0+pr5VLWcdGNE0P+xCMVTOm+Z30KlmZ8WR
	bVA0vUj6nbp2U/YfMsOfPXcmKltHSufBQVumtLvQkDbRT0NGxOlax2JHANAtvhCA
	GwPi6C3ipmNrNfIPI9c43wtqd7ir3Wr30zlQ9IrQE5lN+UnI34VFVTWac4OiOFiP
	lH3Ll0Vp0Jo1vnum4nbNryxeYIPsR1lvyIbuo4nAEVPxBUIqBM4Zn0eBrKapSPK0
	vp0/nPf9xNjFyJwCBi30ggWEPMdPDrLUa3od101iImw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40363cg1yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 11:37:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UBbLuT018788;
	Sun, 30 Jun 2024 11:37:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40363cg1yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 11:37:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45U9GF4h005945;
	Sun, 30 Jun 2024 11:37:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vktt6vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 11:37:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45UBbF8145810100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 11:37:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 821C720043;
	Sun, 30 Jun 2024 11:37:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A45920040;
	Sun, 30 Jun 2024 11:37:13 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.221.162])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 30 Jun 2024 11:37:12 +0000 (GMT)
Date: Sun, 30 Jun 2024 17:07:10 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v12 1/4] perf check: introduce check subcommand
Message-ID: <tylbo22m2koyrcypdykidcuzcwrtfqrzehcwwwmqkcqnbnhz2y@rnsy3gyfmzj4>
References: <20240628064236.1123851-1-adityag@linux.ibm.com>
 <20240628064236.1123851-2-adityag@linux.ibm.com>
 <Zn8C-XpC1beIRN8t@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8C-XpC1beIRN8t@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ENTkP5_Q2pTjEG8rw61Jm6zzJel2IpJe
X-Proofpoint-GUID: V2PP_D54UH1_c_uuEF1m8t9DKcmSshx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_09,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300089

Hi Namhyung,

> > +static const char * const check_subcommands[] = { "feature", NULL };
> > +static struct option check_options[] = {
> > +	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
> > +	OPT_END()
> > +};
> > +static struct option check_feature_options[] = { OPT_END() };
> 
> It should be OPT_PARENT(check_options) instead of OPT_END().

I did not know that. Thank you.

> 
> > +
> > +static const char *check_usage[] = {
> > +	"perf check [<subcommand>] [<options>]",
> 
> You can leave this NULL and parse_options_subcommand() will fill the
> first element automatically using check_subcommands[].
> 
> Please see other commands like 'perf sched' how to handle this.

It doesn't seem to be working, hence added that check_usage in v12
itself.

    $ ./perf check
	Usage: (null)

    -q, --quiet           do not show any warnings or messages

    $ ./perf sched
	Usage: (null)

    -D, --dump-raw-trace  dump raw trace in ASCII
    -f, --force           don't complain, do it
    -i, --input <file>    input file name
    -v, --verbose         be more verbose (show symbol address, etc)

Debugging it further, this behaviour was changed in

    commit 230a7a71f9221: libsubcmd: Fix parse-options memory leak

Where the generated usage string is deallocated, and usage[0] string is
reassigned as NULL.

If expected behaviour was allocation of the usage string, it should be
okay for the buffer to not get deallocated for the entirety of the perf
process's lifetime right ?

Thanks,
Aditya Gupta

> 
> Thanks,
> Namhyung
> 
> 
> > +	NULL
> > +};
> > +static const char *check_feature_usage[] = {
> > +	"perf check feature <feature_list>",
> > +	NULL
> > +};
> > +
> > +struct feature_status supported_features[] = {
> > +	FEATURE_STATUS("aio", HAVE_AIO_SUPPORT),
> > +	FEATURE_STATUS("bpf", HAVE_LIBBPF_SUPPORT),
> > +	FEATURE_STATUS("bpf_skeletons", HAVE_BPF_SKEL),
> > +	FEATURE_STATUS("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
> > +	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
> > +	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
> > +	FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
> > +	FEATURE_STATUS("get_cpuid", HAVE_AUXTRACE_SUPPORT),
> > +	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
> > +	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
> > +	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
> > +	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
> > +	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
> > +	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
> > +	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
> > +	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
> > +	FEATURE_STATUS("libperl", HAVE_LIBPERL_SUPPORT),
> > +	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
> > +	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
> > +	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
> > +	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
> > +	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
> > +	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
> > +	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
> > +	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
> > +	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
> > +	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
> > +
> > +	/* this should remain at end, to know the array end */
> > +	FEATURE_STATUS(NULL, _)
> > +};
> > +
> > +static void on_off_print(const char *status)
> > +{
> > +	printf("[ ");
> > +
> > +	if (!strcmp(status, "OFF"))
> > +		color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
> > +	else
> > +		color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
> > +
> > +	printf(" ]");
> > +}
> > +
> > +/* Helper function to print status of a feature along with name/macro */
> > +static void status_print(const char *name, const char *macro,
> > +			 const char *status)
> > +{
> > +	printf("%22s: ", name);
> > +	on_off_print(status);
> > +	printf("  # %s\n", macro);
> > +}
> > +
> > +#define STATUS(feature)                                           \
> > +do {                                                              \
> > +	if (feature.is_builtin)                                   \
> > +		status_print(feature.name, feature.macro, "on");  \
> > +	else                                                      \
> > +		status_print(feature.name, feature.macro, "OFF"); \
> > +} while (0)
> > +
> > +/**
> > + * check whether "feature" is built-in with perf
> > + *
> > + * returns:
> > + *    0: NOT built-in or Feature not known
> > + *    1: Built-in
> > + */
> > +static int has_support(const char *feature)
> > +{
> > +	for (int i = 0; supported_features[i].name; ++i) {
> > +		if ((strcasecmp(feature, supported_features[i].name) == 0) ||
> > +		    (strcasecmp(feature, supported_features[i].macro) == 0)) {
> > +			if (!quiet)
> > +				STATUS(supported_features[i]);
> > +			return supported_features[i].is_builtin;
> > +		}
> > +	}
> > +
> > +	if (!quiet)
> > +		pr_err("Feature not known: '%s'\n", feature);
> > +
> > +	return 0;
> > +}
> > +
> > +
> > +/**
> > + * Usage: 'perf check feature <feature_list>'
> > + *
> > + * <feature_list> can be a single feature name/macro, or a comma-separated list
> > + * of feature names/macros
> > + * eg. argument can be "libtraceevent" or "libtraceevent,bpf" etc
> > + *
> > + * In case of a comma-separated list, feature_enabled will be 1, only if
> > + * all features passed in the string are supported
> > + *
> > + * Note that argv will get modified
> > + */
> > +static int subcommand_feature(int argc, const char **argv)
> > +{
> > +	char *feature_list;
> > +	char *feature_name;
> > +	int feature_enabled;
> > +
> > +	argc = parse_options(argc, argv, check_feature_options,
> > +			check_feature_usage, 0);
> > +
> > +	if (!argc)
> > +		usage_with_options(check_feature_usage, check_feature_options);
> > +
> > +	if (argc > 1) {
> > +		pr_err("Too many arguments passed to 'perf check feature'\n");
> > +		return -1;
> > +	}
> > +
> > +	feature_enabled = 1;
> > +	/* feature_list is a non-const copy of 'argv[0]' */
> > +	feature_list = strdup(argv[0]);
> > +	if (!feature_list) {
> > +		pr_err("ERROR: failed to allocate memory for feature list\n");
> > +		return -1;
> > +	}
> > +
> > +	feature_name = strtok(feature_list, ",");
> > +
> > +	while (feature_name) {
> > +		feature_enabled &= has_support(feature_name);
> > +		feature_name = strtok(NULL, ",");
> > +	}
> > +
> > +	free(feature_list);
> > +
> > +	return !feature_enabled;
> > +}
> > +
> > +int cmd_check(int argc, const char **argv)
> > +{
> > +	argc = parse_options_subcommand(argc, argv, check_options,
> > +			check_subcommands, check_usage, 0);
> > +
> > +	if (!argc)
> > +		usage_with_options(check_usage, check_options);
> > +
> > +	if (strcmp(argv[0], "feature") == 0)
> > +		return subcommand_feature(argc, argv);
> > +
> > +	/* If no subcommand matched above, print usage help */
> > +	usage_with_options(check_usage, check_options);
> > +	return 0;
> > +}
> > diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> > index f4375deabfa3..94f4b3769bf7 100644
> > --- a/tools/perf/builtin.h
> > +++ b/tools/perf/builtin.h
> > @@ -2,6 +2,22 @@
> >  #ifndef BUILTIN_H
> >  #define BUILTIN_H
> >  
> > +#include <stddef.h>
> > +#include <linux/compiler.h>
> > +#include <tools/config.h>
> > +
> > +struct feature_status {
> > +	const char *name;
> > +	const char *macro;
> > +	int is_builtin;
> > +};
> > +
> > +#define FEATURE_STATUS(name_, macro_) {    \
> > +	.name = name_,                     \
> > +	.macro = #macro_,                  \
> > +	.is_builtin = IS_BUILTIN(macro_) }
> > +
> > +extern struct feature_status supported_features[];
> >  struct cmdnames;
> >  
> >  void list_common_cmds_help(void);
> > @@ -11,6 +27,7 @@ int cmd_annotate(int argc, const char **argv);
> >  int cmd_bench(int argc, const char **argv);
> >  int cmd_buildid_cache(int argc, const char **argv);
> >  int cmd_buildid_list(int argc, const char **argv);
> > +int cmd_check(int argc, const char **argv);
> >  int cmd_config(int argc, const char **argv);
> >  int cmd_c2c(int argc, const char **argv);
> >  int cmd_diff(int argc, const char **argv);
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index bd3f80b5bb46..4def800f4089 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -52,6 +52,7 @@ static struct cmd_struct commands[] = {
> >  	{ "archive",	NULL,	0 },
> >  	{ "buildid-cache", cmd_buildid_cache, 0 },
> >  	{ "buildid-list", cmd_buildid_list, 0 },
> > +	{ "check",	cmd_check,	0 },
> >  	{ "config",	cmd_config,	0 },
> >  	{ "c2c",	cmd_c2c,	0 },
> >  	{ "diff",	cmd_diff,	0 },
> > -- 
> > 2.45.2
> > 
