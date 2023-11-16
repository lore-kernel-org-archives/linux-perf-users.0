Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TyPzeKbG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9819B
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 22:52:24 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG6mRSq011191;
	Thu, 16 Nov 2023 06:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=ON8uwaEsXMFU89oLOtW5XuocTcZZveB+szj0nXIsuGw=;
 b=TyPzeKbGRXy5plQV8cozs812jju4wVDsJVmvODX6pGwv6wpFoRv6+V5/ZieGtom5IY0t
 ZlmkyHraBF2LbR/B8kbQL7IEce1hXwfqz6a8GQntkR71X4HvzPv6ffPNkGNR1DQwTwGw
 PBnQB4/jydmRcj1rHXmM7R1u+72bUATQzbjyZ7KZEoNqHwrS2w8sSSwlmXo6FusWAqKS
 enHldIyp1NPeyAkj9Irm+ufz7nv9SbKaERbHhnIF/jUSuqDFclhHudy0Rjgvn32jGAVZ
 wqg+Eo8sslwrZTdPgjIR0yG9IeO8FUe8/WhY8TDDtusy844IIdtaQdczZJbXLIBPK1YI xA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uddn9rvbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 06:52:20 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AG6c4Q0029115;
	Thu, 16 Nov 2023 06:52:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uddn9rvb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 06:52:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG5LUSJ010595;
	Thu, 16 Nov 2023 06:52:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxt59y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 06:52:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AG6qGSs41419220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 06:52:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EAFB20043;
	Thu, 16 Nov 2023 06:52:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4037420040;
	Thu, 16 Nov 2023 06:52:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Nov 2023 06:52:14 +0000 (GMT)
Date: Thu, 16 Nov 2023 12:22:08 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v6 1/4] perf check: introduce check subcommand
Message-ID: <nqr6glszgzn5jglb5va2t4pedcrztevenzqmtybyild2sxn2wn@4jxgjtfvbajv>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
 <20231021150526.2231803-2-adityag@linux.ibm.com>
 <ZU493oMRpGgNBrQV@kernel.org>
 <ZU4+3HxUMg7hW52e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU4+3HxUMg7hW52e@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YDxjM_9M9hLArvJTgBcTwk8xWblF5HNf
X-Proofpoint-GUID: QSMcOht25pIMox5xE8CV38Mqz_SXP_Yr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_04,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0
 suspectscore=0 mlxlogscore=600 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160052

Extremely sorry for the delayed reply, I was on leave. Around this time, we have
a major festival in India, so was on a long leave.

On Fri, Nov 10, 2023 at 11:31:56AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 10, 2023 at 11:27:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, Oct 21, 2023 at 08:35:23PM +0530, Aditya Gupta escreveu:
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>  
> > Right after applying this first patch:
>  
> > [acme@quaco perf-tools-next]$ m
> > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > builtin-check.c:53:56: error: expected ‘}’ before ‘;’ token
> >    53 |         FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
> >       |                                                        ^
> > builtin-check.c:29:47: note: to match this ‘{’
> >    29 | struct feature_support supported_features[] = {
> >       |                                               ^
> > make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/builtin-check.o] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > make[2]: *** [Makefile.perf:669: /tmp/build/perf-tools-next/perf-in.o] Error 2
> > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > make: *** [Makefile:113: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> 
> It was a simple error, please be more careful next time.
> 
> I'm testing the rest of the patchset now.

Thank you. I will be more careful next time.

> 
> - Arnaldo
> 
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 1183983e4352798d..1502804780507b5d 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -50,7 +50,7 @@ struct feature_support supported_features[] = {
>  	FEATURE_SUPPORT("zstd", HAVE_ZSTD_SUPPORT),
>  	FEATURE_SUPPORT("libpfm4", HAVE_LIBPFM),
>  	FEATURE_SUPPORT("libtraceevent", HAVE_LIBTRACEEVENT),
> -	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
> +	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL),
>  
>  	/* this should remain at end, to know the array end */
>  	FEATURE_SUPPORT(NULL, _)
