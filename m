Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A57344F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302942; cv=none; b=onbqSA0c0nbhSMWtbnLHkGpAvvJHie0hI1yWslQYrzyY05wfMNBFD/jAhktrxcVPu4N8IughygBf7VQFXqTkH17u+pJZjyNgtbbdJtNEFPXKpHzbjC//l7WZeiFHvZ4l1JsgtLKMKpy+cvlL/Hc6gbys5Y1SAS+OqZ7rwUatPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302942; c=relaxed/simple;
	bh=adyKdTj6AADl7OhIOfYJ0CvpHK0GqcVxZNphsOU2vHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu5fHeFCrWVJZ5zyVirFr/ny1m2ngLxb+HS8dIce1d6d/9LyfUE7r+hr94UIxm9MYcxj2nzqYwR4rfDJb1E/+UJzzX9UAJX/MQC7rUYBpR2Pni5qJItQiAYlfWj8NFZWdx/s0xwrLwyGmrRtextInB8m7nCRSUAfUkep1lSW2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NB4rIKnR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NB4rIKnR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P7wTi8021242;
	Tue, 25 Jun 2024 08:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=TmW7MqOmeZvEB1w67x7wlJB+wvr
	G7vEgHG+a+MnsHNU=; b=NB4rIKnR19vvUfwlbFgG67lmQ71P5d692dn2MiZdO3s
	RkoJmJyKl0FhsXpJW/dEQ7KHHbVkmOT5p5xdD8dEHV4JclBTa0XMIUfGm/NzHQYJ
	GmVm1Zj4RxNc0lsexpHb88Uh9ojOn3VGolpcVM9E1rjooWiqEEAQv7uZ3lSVUFR+
	5ObkfBisvOKYg4sNN4E460tNKZsZQ2Smi14+tu151IEBiMme6wdZa32dgpvdo65R
	wGYqVrRPTK5/0+ws5DkgUeyYUzss1gVCx87V5wLMd6g195cq2/nEDlDNeqIB+oKf
	ZdLDQGkxIXkVVKWBd+V8oHQJz9GolzOj+SHewOh9+9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yysyk00vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:08:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P850rO031893;
	Tue, 25 Jun 2024 08:08:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yysyk00vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:08:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P5Xww3000428;
	Tue, 25 Jun 2024 08:08:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn34wpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:08:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P88nBJ13894006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 08:08:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C29120043;
	Tue, 25 Jun 2024 08:08:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B995120040;
	Tue, 25 Jun 2024 08:08:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Jun 2024 08:08:46 +0000 (GMT)
Date: Tue, 25 Jun 2024 13:38:43 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v9 1/4] perf check: introduce check subcommand
Message-ID: <wozejnobinf46nes752rb4kbk2qzsid47ftsfxv44v2a4kutsq@xt2zhttjsgv3>
References: <20240617065036.1194041-1-adityag@linux.ibm.com>
 <20240617065036.1194041-2-adityag@linux.ibm.com>
 <Znn3jpTqz-oFb0uB@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znn3jpTqz-oFb0uB@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: znZrWaSTU237nG3SLwtsOapU1WlXiXcI
X-Proofpoint-GUID: jGbyEzRCwxl8vEe_IKNgsRkMdPNsO_nR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_04,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250058

Hello Namhyung,

On 24/06/24 03:47PM, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Jun 17, 2024 at 12:20:33PM +0530, Aditya Gupta wrote:
> > <...snip...>
> > +OPTIONS
> > +-------
> > +-q::
> 
> --quiet::

Thank you, I will fix it.

> > <...snip...>
> >
> > +	feature_enabled = 1;
> > +	buf_len = strlen(argv[0]) + 1;
> > +	/* feature_list is a non-const copy of 'argv[1]' */
> > +	feature_list = malloc(buf_len * sizeof(char));
> 
> Can it be just strdup(argv[0]) ?

Sure, will directly use strdup in next version, it should be the same.

Thanks for the reviews, Namhyung.

- Aditya Gupta

> 
> Thanks,
> Namhyung
> 
> 
> > +	if (!feature_list) {
> > +		pr_err("ERROR: failed to allocate memory for feature list\n");
> > +		return -1;
> > +	}
> > +
> > +	memcpy(feature_list, argv[0], buf_len);
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
> > index f4375deabfa3..0cdb11b9efec 100644
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
> > +#define FEATURE_STATUS(name_, macro_) { \
> > +	.name = name_,                       \
> > +	.macro = #macro_,                    \
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
