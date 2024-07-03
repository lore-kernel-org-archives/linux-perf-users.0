Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB58194C7D
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003654; cv=none; b=C6e8JdQDkJvaXxmFT/Cnb7BIKrNL1tG5TwqeIufXOF2wE3OfkxpJ7UmnRJZxdfs5rdFIUHPvutNu8W2Ce7Xp0Vv2EtUrJB0G1HKXKY6+VFPsRP4DBdbG+CEifQhQCXxXd2IrEzHv7A3pW0Ozggkkq4E/LwsCO8xw/HwzssZP2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003654; c=relaxed/simple;
	bh=lCUReg3/WIKYDhyXKZtjOFDQu5yxswkzLX+AAseY05Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmFifnB6Z1YP3sXuLV0IiNa2/lN/TMMI7BwrB2arVrx+0PAE1pROaXJYUimmgGgkW51QOtDvQRRpNC9hKQLH2KV+qrvKq6jMzUuFpeXS1A9kD0/MC3zkkeU9vsaQFFa3DW7WVSvefxTah9HJSkBPhE3A1HvW5ylR/jJc04qHEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=doAjeNJ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="doAjeNJ2"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463AUDgV007238;
	Wed, 3 Jul 2024 10:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=zrM72+X/FtaEtQY0Moh6jIzGFfB
	UureXsfJO75PnYFQ=; b=doAjeNJ28wnnCFz2fcMUBYrr1FFzZ8snmCmIrRggF6F
	h+GgjrSzfxOaDUQazobutjIfiOGzuJ+oq/+Zq4QsgQsHt3UqkaD92QsW1RcPwKYv
	FwrZh5I+ynWKbrSuByf+2LcuTgLfWAcNonvtqT++dArHIUcP5okZtEi4f148pMIr
	xmGt4tMA7Urcl6tLuAuP3hgxCqIMbSr4+XCfhnRmiQgEuTQ3UN1/9syXNVQ40KAt
	yhRb7WMsStCmZHZ0O8jf1mZIkLKD76dI6yvWbu2G2aksl8rkQSiN76sJiEMiDkvP
	T22XXL1DYMFW0unio0tinDcG8ScIkMrzBIwLd/mrrew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4054wx81am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 10:47:22 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 463AlMht000817;
	Wed, 3 Jul 2024 10:47:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4054wx81ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 10:47:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4637KdPc005948;
	Wed, 3 Jul 2024 10:47:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vkuabpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 10:47:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 463AlGJ954591938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 10:47:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EACD320043;
	Wed,  3 Jul 2024 10:47:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD7F520040;
	Wed,  3 Jul 2024 10:47:13 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  3 Jul 2024 10:47:13 +0000 (GMT)
Date: Wed, 3 Jul 2024 16:17:09 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v12 1/4] perf check: introduce check subcommand
Message-ID: <htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e>
References: <20240628064236.1123851-1-adityag@linux.ibm.com>
 <20240628064236.1123851-2-adityag@linux.ibm.com>
 <Zn8C-XpC1beIRN8t@google.com>
 <tylbo22m2koyrcypdykidcuzcwrtfqrzehcwwwmqkcqnbnhz2y@rnsy3gyfmzj4>
 <ZoSRiW1aVsV-xrur@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoSRiW1aVsV-xrur@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7lHwK3hge79rMtQfQxBjsMc_b0vePVkx
X-Proofpoint-ORIG-GUID: C7yri-GCBrILZ2zqWECpLlyR31SKjVlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030077

Hi Namhyung,

> > <...snip...>
> >
> > > > +static const char *check_usage[] = {
> > > > +	"perf check [<subcommand>] [<options>]",
> > > 
> > > You can leave this NULL and parse_options_subcommand() will fill the
> > > first element automatically using check_subcommands[].
> > > 
> > > Please see other commands like 'perf sched' how to handle this.
> > 
> > It doesn't seem to be working, hence added that check_usage in v12
> > itself.
> > 
> >     $ ./perf check
> > 	Usage: (null)
> > 
> >     -q, --quiet           do not show any warnings or messages
> > 
> >     $ ./perf sched
> > 	Usage: (null)
> > 
> >     -D, --dump-raw-trace  dump raw trace in ASCII
> >     -f, --force           don't complain, do it
> >     -i, --input <file>    input file name
> >     -v, --verbose         be more verbose (show symbol address, etc)
> > 
> > Debugging it further, this behaviour was changed in
> > 
> >     commit 230a7a71f9221: libsubcmd: Fix parse-options memory leak
> > 
> > Where the generated usage string is deallocated, and usage[0] string is
> > reassigned as NULL.
> 
> Ok, thanks for the investigation.  It's a bug then.
> 
> > 
> > If expected behaviour was allocation of the usage string, it should be
> > okay for the buffer to not get deallocated for the entirety of the perf
> > process's lifetime right ?
> 
> Right, it should not deallocate it in the parse_options_subcommand().
> I think we need to change the exit path of the commands to free the
> usage[0] manually.

Sure, I can implement that if you have things in hand, or I am fine with
you implementing it since you will already have an idea what to do.

Maybe `free(command_usage[0])` or something like
`parse_options_free_subcommand()` ?

Thanks,
Aditya Gupta

> 
> Thanks,
> Namhyung
> 
