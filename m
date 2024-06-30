Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDB137776
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744138; cv=none; b=gtBlvhpOEp72m3U16uMXHoefO9Xb4QkkDbHqRbHLWJddBcmRwElQ8/Jj9PntA7WBjeNRoqfCKKm/E94PSPyi/Whiyy4qn/A8R3ckF1mxxRtueZIOkBDlOF8aBQ/0XdVrhQ5kkzmAQUgYO0h8yrxfGjPqGKLrUa/wjdUlS4XF5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744138; c=relaxed/simple;
	bh=802Iu1tnUJsZuiWWLidhEzPWqOXJJjzxb2U/a3FVQHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=boM5U6cfKu2exBDQkEU4TuFaWvS1rhLVt9qfka8nbPqKcVDO6rhchnFI5rgq8cJHkoylLxe+VpG0+B+zREXs/HCtIptb5oIUDyOMydBX+wcXoesgdo1wC9gDgMcx3cMbTN8BqoeltL9Oa8jWSfuJPQoLJztNACsJAHx/QzLwsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m7MmpdUV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m7MmpdUV"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UAQpJm005456;
	Sun, 30 Jun 2024 10:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:content-transfer-encoding:mime-version; s=pp1; bh=x
	7li9Puk1RfWo2N65GjJGcWyPpqULnQ0x389r5utPCw=; b=m7MmpdUVakrOk8f8H
	7TXlSqW8FhHIFJDUuyocSs2FuxYHsC0+TbbdihRu5Y+XbwLd4F284JRah/hMUaOG
	5Yj4LMHakQFR8xkCLV24odUtOJvv0PMBycDsrlY4OwEY7E5qx9+zIea6yh0OMpgS
	hQuMD5cDSazoxhzZVAfakoNRusbvwhUbk93cS/5PsgHSRYCTBYsImMtehiFhKqYm
	pISlOroUG8zBmMn5jcJREsJCVP8XcX/NJh7JPqnEV6XWkDo74Sq7kjUeYltjlLUk
	Xs5BJchsRyHC/HMTgesIe1pnGU1yuTjojvzirQIhnPxwq9LIcBkFTG/po+L5gvmY
	E/c9w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4033vm875b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:42:12 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UAgBo2027342;
	Sun, 30 Jun 2024 10:42:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4033vm8759-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:42:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45U96nMS005942;
	Sun, 30 Jun 2024 10:42:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vktt19q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 10:42:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45UAg5FT21102928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 10:42:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 281EF2004E;
	Sun, 30 Jun 2024 10:42:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 847382004F;
	Sun, 30 Jun 2024 10:42:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.221.162])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 30 Jun 2024 10:42:02 +0000 (GMT)
Date: Sun, 30 Jun 2024 16:11:59 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <o6pryni4epn7y4nb7q3x3drkjk6grda52yyqajknlw25tjlnz6@u25jkrmap6ga>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn7FmltYgUzi6YvV@x1>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: esvEtL8JCfv58ErNNXtw1E-GBDWkGNhx
X-Proofpoint-ORIG-GUID: VT8OZ4z3kRJTRRBLnc5L58x5AKkDPYON
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
 definitions=2024-06-30_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxlogscore=975 impostorscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300081

Hello Arnaldo,

On 24/06/28 11:15AM, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 28, 2024 at 11:12:16AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Jun 27, 2024 at 03:36:41PM +0530, Aditya Gupta wrote:
> > > Currently the presence of a feature is checked with a combination of
> > > perf version --build-options and greps, such as:
> > > 
> > >     perf version --build-options | grep " on .* HAVE_FEATURE"
> > > 
> > > Instead of this, introduce a subcommand "perf check feature", with which
> > > scripts can test for presence of a feature, such as:
> > > 
> > >     perf check feature HAVE_FEATURE
> > > 
> > > 'perf check feature' command is expected to have exit status of 0 if
> > > feature is built-in, and 1 if it's not built-in or if feature is not known.
> > > 
> > > Multiple features can also be passed as a comma-separated list, in which
> > > case the exit status will be 1 only if all of the passed features are
> > > built-in. For example, with below command, it will have exit status of 0
> > > only if both libtraceevent and bpf are enabled, else 1 in all other cases
> > > 
> > >     perf check feature libtraceevent,bpf
> > > 
> > > The arguments are case-insensitive.
> > > An array 'supported_features' has also been introduced that can be used by
> > > other commands like 'perf version --build-options', so that new features
> > > can be added in one place, with the array
> 
> Now testing it with just this first patch applied:
> 
> ⬢[acme@toolbox perf-tools-next]$ perf check feature bpf
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> ⬢[acme@toolbox perf-tools-next]$ echo $?
> 0
> ⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
> 
>  Usage: perf check [<subcommand>] [<options>]
> 
>     -q, --quiet           do not show any warnings or messages
> 
> ⬢[acme@toolbox perf-tools-next]$
> 
> 
> I don't see a way to list what features can be tested against, would be
> great to have.

The feature list is actually same as 'perf version --build-options' as
you pointed out.

Should I have 'perf check feature --list', or 'perf version
--build-options' ?

If these build 'options' are all features only, does it make sense
replacing 'perf version --build-options' with 'perf check feature --list',
where the output will be exactly same ?

> 
> Also it just says that the usage is wrong, no indication as to why, I
> think this would be more informative:
> 
> 
> ⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
> Unkown feature 'libtrafs', please use 'perf check feature --list' to see which ones are available.

Ah, should use 'perf check feature bpf,libtrafs', then it should print
'Feature not known':

    $ ./perf check feature asdsaf
    Feature not known: 'asdsaf'

	$ perf git:(014587a4af6f) ✗ ./perf check feature bpf,libtrafs
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
    Feature not known: 'libtrafs'

The suggestion to mention how to list feature is nice.
Will add 'please use 'perf check feature --list' to see which ones are available'.

Will also print 'Unknown subcommand: bpf,libtrafs' to mention what went
wrong, instead of just usage.

Thanks,
Aditya Gupta

> 
> ⬢[acme@toolbox perf-tools-next]$
> 
> - Arnaldo
