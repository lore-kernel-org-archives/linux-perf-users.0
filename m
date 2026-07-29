Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B633C18E
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345621; cv=none; b=SgYfeTsaI00sdV+kCmy5OvUdDgaBOSnUFAyU2iQU0+hXMIA9Mu9+1kXxH45zoVLPJvGag+2LE9hfKrfoLADKOvPZmHpC6xCJdVc1vSis/fh5u8vL/pZq+sOJVnMFsGrLGBx9stpoMr6FfcBV1NU4KfmKQnuhnV+12sevVI5/AQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345621; c=relaxed/simple;
	bh=UvjtAtSa87m2ze8Y24MDxL8m+ik8zBsXWnVO6FkGyV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0oIfEfIFoBlOtt8Ohc6jf4sxO1LMaqzReXwhbLDGX5jqvam8VcG31TuzprDUKfWBV2JvWItVZI96js0UrljzDKWJT90OjHZtgev3ut6aTbdB4YmNMzI1hF7R8lcRWHALXrQrtuqpd7NHPRHezocFQzu4ubf6SBxnlB2J2Tw320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TxBkxzc2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L0IdEFnB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TxBkxzc2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L0IdEFnB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF2wnA1700082
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 17:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hNEq0RGMM70aUC7lAd33dTKu9GtTLMxqmYAyHUnpT+g=; b=TxBkxzc2szBX1XnM
	VcOef+yzmNUb6dL8uB6Zro2pqGSCzeIfc+WBQ/JMTe5fEymVYYSJIVEEFfR0rmP4
	0kWu90VvM4ePy6ypIprdFR1ut1+SH78oghWUMz346fudMMXvYG0a4QBI//BA9XLZ
	WIJn55QOXKAhcn2r7rHRlqCRjodmmDfZzuQR+J5ijgv6WR5IdzUH9EUlSXbaFEtx
	HAyJ0DM/LqVevPo4lhfRe8WBSwMxoHdnQ7XxikzMwVelUmINAIcKkvbSh6SUyBeb
	CmOTV+wxXwQooKI/CNE3uvEqQDGpMfeQf+nxu1Ql4kRaUYK0iB3EYnOcUAw/jVQ2
	UnYNBA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj1rmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 17:20:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so22875795ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785345619; x=1785950419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hNEq0RGMM70aUC7lAd33dTKu9GtTLMxqmYAyHUnpT+g=;
        b=L0IdEFnB47DRFAchpAmGQbj2FMxyursisN1Jb5OBwKtrNOwmyIVOJh3dkDC3VFtcfn
         gxQUfYIMaQjZA7toA/AcHQvvGYLIfx9D04TkMpOpkPpxd5S/dvWI0SAhoOjJyP2YFxeO
         1EfdtguJOzTv6yrfnIJ2/nBQ9B8fw6X/34LO4Ui9RMPH6u3hfUr0Oh81Bun1AB5KBM1j
         luu8GSLnXWQVYxUr3gFlMtHF9YriUIi59Apvaenm26xRH2GP4k42yql2gIdqVSYxWc1H
         LwONAJmJwEm6gMOgP+82Vr5Ej6nkJiJErTdRaC9iY79MEEZyTVXuR+TQ/AOi3DHovrLA
         9aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345619; x=1785950419;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNEq0RGMM70aUC7lAd33dTKu9GtTLMxqmYAyHUnpT+g=;
        b=BOtq4kaCUXj4OBItDccDCW6+0M0BRANH8zEriHozmuwc6efShb8XLbIUd7O86G0pAQ
         N+SSzXYKzE8zgTpqP+jPIYSrR2YZryPx4U7Oef0dqjTUaWw6JjbKhycKdFfAm0Bka3MT
         7a6PbvuCiSRHXOU5yS/2RrIggaXzqZ9Hy90ehQrKeJ1ApS9RwopeP0cgFpLWDr/xU6ex
         q0zDZfIx6ZlYQYZG0BWzSQSGKOAxk6Oz0hEAHueinL2QrBDiHR6AUMWTzDQSgNJEXvPh
         PeWqhs1WFrhf+bYbNquemMzCODOPRjQ5BsCxHY7eup0q8m/oz8mnQJ30SOd6MsyM9xKt
         B06w==
X-Forwarded-Encrypted: i=1; AHgh+RrWJMWVNjp4a9Mk0gyJ2fHYUklu6+s0QXbmm5L2KNLDmshpBRlaXTQwCxq+l61CE0zbZy+NJpQm9Gwzjtng8LMv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Y1xAThmznf5i+iUO+U1tNkvpuU93i3p8+l9tcY5aZQafz3YJ
	7ydVjoYu/pRyTRQ0KBSQZzACIV/99z9t8bVUDfMy9Z9sSQiOYnvllM3FkwqnAmafsn4+fmZszcu
	zLUWnIPD2GysEfS2GkYM7dKus03IwJskHTfS+hc//pFfDiFgzsQaAuHDGF4AO7HvHzgQP2hBCeC
	2wdeZk
X-Gm-Gg: AR+sD11QquwV0AmeTPx/g7LJVBNeraZgpV5f4N+CN26o1OnlFTMjIarDC8QqbXNxy5T
	sYryDLc6cbSCHEEAtaMl6TqGP4KsrDlAc5955KawEOnzRdgOWYLuv2NmnRvSL9IcyzaZxXlK4It
	H3nrLKdLx0vS2QZMT+leTFqT8AUwA8MAsYON+aKC3dCn6YT3kKAUFsOukcP58JsiyGOQ1MNee+B
	HzVWe94RlOKdcKyX1v72Fa+tWRrN0A6+b9JtZnL0h638kkvtHNtbJORo6x4G4ujHjysfTF6TMRQ
	Lq/eWtOu8rcuCi0jP+ponHVaoLm65mUaIi5RFNJ+eHTki2cuHYNYeTfZ6Pc8D/KRfC47cdmhQ7R
	FT8R+ZvkC2samHnyQ88E2C5D4Gw==
X-Received: by 2002:a17:902:ebc2:b0:2cc:6817:d9bc with SMTP id d9443c01a7336-2d015f31b41mr85103695ad.38.1785345618626;
        Wed, 29 Jul 2026 10:20:18 -0700 (PDT)
X-Received: by 2002:a17:902:ebc2:b0:2cc:6817:d9bc with SMTP id d9443c01a7336-2d015f31b41mr85103435ad.38.1785345618079;
        Wed, 29 Jul 2026 10:20:18 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b15f77sm12873275eec.4.2026.07.29.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:20:17 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:20:14 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
        ilkka@os.amperecomputing.com, leo.yan@arm.com
Subject: Re: [PATCH v2 1/5] perf/arm-cmn: Rename filter variables for
 clarity
Message-ID: <20260729102014.000019ea@oss.qualcomm.com>
In-Reply-To: <ae87ea9530b3c2073874035a244f34baf7915def.1785252273.git.robin.murphy@arm.com>
References: <cover.1785252273.git.robin.murphy@arm.com>
	<ae87ea9530b3c2073874035a244f34baf7915def.1785252273.git.robin.murphy@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a6a3653 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=vzhER2c_AAAA:8 a=kl2wRD5OMsbQT1A7C-gA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-ORIG-GUID: tnRZM4WoiWe5S0sa64lSuxtR-TjWYN9M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNCBTYWx0ZWRfX5jySitZ5S7CD
 GNw3proCbm2TGxZ/JMGNFcWvVT20J9o3pi5OQawFfT7huLkcsoKbf5eCN1Z47hAaHZaENRWO3dx
 IkXM+CR9vo7r8njojCzSa+fE1VdjzJfxffZA63y1EFjwa91QaoM0KF3uN17uhhznGmZxUgIzOYC
 0Es8sdr8r+iTA+u2qstC30oMMMSzZlGUcJv/hDRS77jx4b2VHiX8+Qva8xO8qnfeR0yOiH+NVhZ
 /11WMbMzAAWYvrW3Nk9QipTg6iEXDTPD6snf29bB+n2XX/fj6Zg1g5PAXefgjn+k1H9uK3bmqhT
 cqn2804VQ6bIH3qMvoaMtIuzpT5kBaYf0EkI6sWFxzYWh2PbClVg2iLIDmTsRnPKfD1HLDSKgQX
 2PvDZh8e5ix+deYUyB/rExMH7DlF9yv976bQ+nlzY5lbNrmPo1qV7vKs8siwikO7gahfAf1iMg5
 w4528EZATBqSYHsJciA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNCBTYWx0ZWRfX8ZXGnNzQBrsk
 iM50f4lALOjztLn9cYFHj3MZs90fznWh/OX5X7LjCnSdAIHFuc74htu1LyNxoXNmBXVOArrX9TW
 yiE548baB6wVbgHjPxd2WKdKbEYvF9g=
X-Proofpoint-GUID: tnRZM4WoiWe5S0sa64lSuxtR-TjWYN9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290134

On Tue, 28 Jul 2026 16:59:21 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> CMN has already grown many more event-specific filters than the original
> Occupancy ID, but since they are all independent of each other we've
> just overloaded them onto the same name. Before we add yet more, and
> they begin to overlap, rename all our "occupid" variables to "filter" so
> that things can be a bit clearer and more consistent (but leaving the
> format attribute itself, to avoid UAPI concerns).
Hi Robin, 

Drive by review... I'm a bit confused. 
The print out change isn't a ABI change?  I'd at least mention what changes
around that in the commit message.

Jonathan

> 
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: No change
> 
>  drivers/perf/arm-cmn.c | 53 ++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 50402bc4a21d..2a8a67da72c3 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
...

> @@ -709,8 +709,8 @@ static ssize_t arm_cmn_event_show(struct device *dev,
>  				  eattr->type, eattr->eventid);
>  
>  	if (eattr->fsel > SEL_NONE)
> -		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,occupid=0x%x\n",
> -				  eattr->type, eattr->eventid, eattr->occupid);
> +		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x\n",
> +				  eattr->type, eattr->eventid, eattr->filter);

Changing the format of this smells like ABI change to me.

>  
>  	return sysfs_emit(buf, "type=0x%x,eventid=0x%x\n", eattr->type,
>  			  eattr->eventid);
