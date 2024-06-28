Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527974D8C3
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556843; cv=none; b=qMEgSwQJdufnJ6KaZPX4Qk8qDsbQPK3Nuh8qHTiRVIqH+vh1WrWG/Qiag74ZtRmd5lxz29o4dk0MpiiSDYnjBmklU7j3ddmyQWjaERYkr8tLRh+2CLt9HSAtezMkTRdYCF+WYfaDHd50RU8CHHFFlxe/dS59OvD6YHKLlrsiDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556843; c=relaxed/simple;
	bh=txR8QYq6FUatnW7WruPjjnFKvMIZvzxdxfBBJpe1uQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp3SIQCpytcVWJKWsusY+k3FV84009+qJ1xSzzwPt4ttz8CFWYq0ENvKVUDH7S2Ctatt12FxE602d6/Uu7JiDquixyzlxG+n7cwbVpYvVCAwLTvzfia2vT5BcY7Iao7ztLIDdcOJFaOf1jzhG80OJGU30mS12DzwgeKsT/F3+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hNr9gsry; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hNr9gsry"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S6RkuK005170;
	Fri, 28 Jun 2024 06:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=NWlJXtrLksOSigSd2ai+39FFb4i
	bBX98sqKsTqo0z2Y=; b=hNr9gsryJD1m0PM3kx3T7M4hsnqSQVft9dk12aPNmML
	OIACov/SW2tL4Cz7M+ayRL7zVijUlmBTThG6Dj2RK9+RGmRDyluS8RHD7e3+c+er
	sxcaFfWMolgk0xo2hMdxkfLS6QzqQM3/i03RaLgJQbNcjoEEy07X46BSGSkzprOn
	WFu9JD2sYjK8LIbRZtMkuCJgeuQecx6X2SD088hNQxcByjyEeGYmQv5NcLab2Uk/
	uf+PWoRrQr0ilCviDQzQyCG58BQjXbmqc9+75eQpEOoWaWBczTTkYMneqzHrirs2
	h2mD+1/CDx+gysDWKwxgiph6R8tC1zur+9J4FAxwtmQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qga82tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:40:37 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S6ebAj024631;
	Fri, 28 Jun 2024 06:40:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qga82tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:40:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S5JVgo008184;
	Fri, 28 Jun 2024 06:40:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b176fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:40:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S6eUuN17695086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 06:40:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3F020040;
	Fri, 28 Jun 2024 06:40:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAB892004E;
	Fri, 28 Jun 2024 06:40:25 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.195.36.144])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Jun 2024 06:40:25 +0000 (GMT)
Date: Fri, 28 Jun 2024 12:10:20 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v10 1/4] perf check: introduce check subcommand
Message-ID: <2424jyv2kzzc5vt7gerol47ty5f7uwi53kh7v2snt53fnau73q@luajdbuzy4oc>
References: <20240626131638.597544-1-adityag@linux.ibm.com>
 <20240626131638.597544-2-adityag@linux.ibm.com>
 <Zn38qPXvOZjcaRh6@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn38qPXvOZjcaRh6@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WmUSM1XfBYo-JvTA-y2mMjsmSsv6Bn3Z
X-Proofpoint-ORIG-GUID: 13L_RBaSiqWHPsq9pRx_CL_aXPxn1shC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280045

Hi Namhyung,

On 24/06/27 04:58PM, Namhyung Kim wrote:
> > +--quiet::
> 
> Oh, I meant to have both -q and --quiet together.

Oh okay, got it, will keep it like this in v12:

+-q::
+--quiet::

> 
> 
> > +#define STATUS(feature)                                   \
> > +do {                                                      \
> > +	if (feature.is_builtin)                               \
> > +		status_print(feature.name, feature.macro, "on");  \
> > +	else                                                  \
> > +		status_print(feature.name, feature.macro, "OFF"); \
> 
> It'd be nice if you could align the trailing backslashes.

The alignment is getting messed up due to tabs I guess.
I will keep tab width as 8 (tabstop=8) and align accordingly.
Any other suggestions for ensuring alignment in future ?

> 
> 
> > +	feature_enabled = 1;
> > +	/* feature_list is a non-const copy of 'argv[1]' */
> 
> You meant argv[0], right?

Yes, and thanks for your patience pointing out these silly mistakes.

> 
> 
> > +#define FEATURE_STATUS(name_, macro_) { \
> 
> Align please.

Sure, will align.

Thanks,
Aditya Gupta

> 
> 
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
