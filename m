Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F891B6525;
	Mon,  9 Sep 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891140; cv=none; b=FFQPuB+im/8kmkZ3J+ZBqtAtHZCg4UE34iSYEBiisGrLVQf5w5s9Lm3PnKCHn+6xGuH9bj2dhk4+6a2M5sLGH3zukARzvHNJCIwa3Ykq4KeNyFPZbFesMXQfxNvOjU6owlp4/GnCmOVWctYa3COG7f0Aj4gSqEsNSK2vZk5lTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891140; c=relaxed/simple;
	bh=2xd3wQ/NueB3kxlSC5iCarCunjipWxBqOIs9PiTiWvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7N3kvOHt9o/G4E5kZHtGTKyevOwvg1qCGfk4DKu9KXj6tyTBqww5oih9ibYuPDTzFmF5oBjzeyV7TVQbjNGYkMEWJCqgRB5scAxfY/1QY+4H1Y1lSbF00zmFJVZarfd/rZUYlb2Hj3J0dl8ei65/YUIxDVYGz+jdiEWgp4JNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LcSVUFD/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LcSVUFD/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489C9bps022933;
	Mon, 9 Sep 2024 14:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=9
	ZczSfYUjvO7oMlcF3bhQ9xFSEwr3GkvyMyzM23IvmI=; b=LcSVUFD/C/Mh+Fk61
	G6SHGv2CsBGZXoUhTaON9wL164RPsVin4yyViaB6Tf8vvW6QfHMxBSx/YB7yQ9Ui
	kMTdbnFsugxuia5VSgA+nWrAVEXEjHBhPNWcEyTsFVI8sJB4TkGFG/ViuWcWyfez
	W3DCFknIrCys4cWOz6rtg8CnpQqB7ZwiMNWEG1gu3OsU/jXonvMdaAu7XOCbgi2N
	vVBs3xvuE7G0T/3UtWvNtJVw1E1g1DB1IS1GzZ/5GV1MZf4bWzjXewVd4G3QPkQZ
	REWwh0qK8iW4DWOv2MSRWiCWjKYgIWtL1AvFj7f72EZ65Y+F182V5ixaJ+QzbEAz
	O4Kog==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejaa8xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 14:12:06 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489EC69t025699;
	Mon, 9 Sep 2024 14:12:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejaa8xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 14:12:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489BNJPY019891;
	Mon, 9 Sep 2024 14:12:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25ppsgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 14:12:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 489EC29h43385272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 14:12:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D20C320040;
	Mon,  9 Sep 2024 14:12:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B78120043;
	Mon,  9 Sep 2024 14:12:02 +0000 (GMT)
Received: from [9.171.92.41] (unknown [9.171.92.41])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Sep 2024 14:12:02 +0000 (GMT)
Message-ID: <b2d634a5-0a28-4044-b654-74607c457dab@linux.ibm.com>
Date: Mon, 9 Sep 2024 16:12:02 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf namespaces: check newns before free
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903091208.7152-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20240903091208.7152-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -TixvDzcUUkzd9vaSKfKyoK3qj9X3fJ2
X-Proofpoint-GUID: 8pPxGMPaS3c0-BdxZhBKTbCCp1C0bqik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_06,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=701 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090113

On 9/3/24 11:12, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Since newns can be NULL, check it before free
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/perf/util/namespaces.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index cb185c5659d6..49e20e0a567a 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c
> @@ -135,7 +135,8 @@ int nsinfo__init(struct nsinfo *nsi)
>  			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
>  
>  out:
> -	free(newns);
> +	if (newns)
> +		free(newns);
>  	return rv;
>  }
>  

Ins't zfree() to proper function to use? Also zfree() calls free()
from the C library which can handle a NULL pointer?

Just my opinion.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

