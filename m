Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD9284B25
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390587; cv=none; b=uSc7bgFFaJgIPirLeGgtqyvrEZYVVAPkP41Pehu1JUID1MeoAoX3GQoakUgNjpdsYvUT3yyCYgWEG25dlw9hN/HC8ckqWrSO3UwEZVu4VRAlqjnD5vsi078JKjcRRyZekJJiVy9T+x/Kt/JGdQDbCNC8/8naCFJfD0/17Jars9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390587; c=relaxed/simple;
	bh=rdx3OV+nUN93GHAqETEZwEgh+ENPZq3ETzFi6DimpXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElXwVpTn9psi8sDQFGvwhU4UQPJ7NZgGhSpnf4GWRdd6ipOtBFF1QIJJestfqkwcpVKnZAw5Vq8xW9s8ZV5KqLMv2/lNdNr8zwTGwbSuePSJmYLWv4dU5PF03YUax2m2HDBEPYcJJDkcy78/MCya71MF5dSIuPtlNmyfYZPWDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q6AkNa4t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bjotwFKJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q6AkNa4t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bjotwFKJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6167pSCV2490642
	for <linux-perf-users@vger.kernel.org>; Fri, 6 Feb 2026 15:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lcs4pjDWug9NOgYAjE4oCiI3J7ua4/c74IiXacv+yFg=; b=Q6AkNa4tpF7NF+Z9
	LNSqfgkRZ5EHCySJQM+l+BsFwhdrdsUmh/9hTV1//IYJtkaHrqUvqt9Hk0INRxY9
	VVybfsKO/IzvtX/wgIGb5XSQkkOqsvBUqcmtSAj2kDDpLlLc3LXPP5L/atB2zd1a
	285+qX8bbUy7dTqos0lGzWF7wP0L3tWgxtlk4IWXehSX3/ORgD0nf7MREHbhfjln
	aQHKvb1eHaEcKdlYvpBncBWK1iOwtA/eQoHyjRrgdRP5bXMgvyTjCMsIdmfFqQN5
	HsjxgQv1b/PuvLQZbdJRTSsgFrrfIrxUrLISjKo1CM2uDDf/c5W9QvS/GVK/YBI6
	djLgpg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5c9c19se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 15:09:45 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66ad91bd85bso8715663eaf.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770390585; x=1770995385; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lcs4pjDWug9NOgYAjE4oCiI3J7ua4/c74IiXacv+yFg=;
        b=bjotwFKJB95/ETa0uS0LBRtKFGnGXzYjMrgRSb5sir0VRFBTbAUm4tGVrDR//B68uT
         d1gAuLmq3PwWWCalmhfGRdfcUC3aU4em+udLWUPzAcUcHlnKhwgIzWV+x505tcchCfdE
         3J6OpS8hIHSWze120RIJ8vaL4rMkeu8XqFGm092xBr9G9Su6LvKrSaOnhMjyCuesPkqO
         UvdZYMog/wgGNITbSpf/BOupBlMyEyDVlVXpcAkJEunevfElrKBrbNU7Hfz8ILQDUoeI
         Fa1X6ghcBDXyzzyiduuK4YT3aHC4gDm/xeDhq6uTlJsEGJ5M7zHifzCDTmUPQ+hr5Uln
         iakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390585; x=1770995385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcs4pjDWug9NOgYAjE4oCiI3J7ua4/c74IiXacv+yFg=;
        b=bA+nBXKJSZZs5Ls3wxgXRoVJu1rLBlHCiupM7ZBzEpF3poW652HZrq6JHQR+pWRzqd
         M28Rl26OZ110kFUDdbZDhFHoSrnOZX5mRdCWWj2igZFrdjIGSwEin2WoGL7HvwDCviFd
         tDLkGqpx7IIu2s6LPmMyhuWG0BPgEdPHvpyQzmzolJsewAkpWXibCr/YW3RNbrV2WW7l
         fW+6/NLJ2hriLPbmsEETYTY0y6FmKRrDcE/ShlLGeGyAucXN4ZtOp/HYvKJBmHnzFxUo
         Bd7CtftoPhKZG/O7TNiA7Ns+3f5RipzbPm1kQOe7RMwtWmJXuxn09opXw8ouHbwjs5De
         acZg==
X-Forwarded-Encrypted: i=1; AJvYcCVD/ACB9VDNWaiQTeOOQlfO5OBwcG+xnG1qRhIKmIjs1AhffC7TnadkIHu5+5vA261hKwomy8bsu3vRzDAamMtB@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6ndlMX1BFitXbDAaWua7SgJ3NXwvPfPQ0MP4D4pOIjbh1U5H
	AhNvedn4o+9g0n35266SOQqoXASkvkVev/voT3gT+7J+pwy0I6fdK0lRKAJsISN2xaEp/Z/P40Z
	zsz8xKqRZGSyNbG7A5OQY3mn6MEqjbpKyn0PpuAy7Or3NJKQKC5IJnz+SLyeUqVQcqZyaB6yI
X-Gm-Gg: AZuq6aI98DcjGq5/rokH7Z9W9C96FVEH8vpTXdlTE9YTaVNqwcF4oWtp9RPzW9nCbFk
	BX/fduQE1UPEg0JOnVipolxDZb2V1knfAYk9KHOAlLkasJEnksq+Y6gUvlJHXZ6LvQfDavCxVPi
	JyyVeKJut/mA43zLY9Wt9etyRN/THTn3CzMQd95Um17oNsF4eMBfjkG4bKyyEBppPn+3GpBJGai
	Q6EaoSVKGQJc9W/HDDlFT+b7H2ttN7QepVcsiPrR0tuqS0ViADM+700lElLPm6P+T74eoh3yFOf
	ygYe4N8olnSpFHN7MVQCSUpqqUIhothG4nNMm383TJga+uEHBNWWIoT4u5DbO1+YcwEet4QVnIS
	6ROjlDjBbeA9wmQiJlr0=
X-Received: by 2002:a05:6820:228a:b0:661:ae2:95fb with SMTP id 006d021491bc7-66d0d2faf29mr1460747eaf.75.1770390585140;
        Fri, 06 Feb 2026 07:09:45 -0800 (PST)
X-Received: by 2002:a05:6820:228a:b0:661:ae2:95fb with SMTP id 006d021491bc7-66d0d2faf29mr1460723eaf.75.1770390584637;
        Fri, 06 Feb 2026 07:09:44 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d391aeb93sm1202941eaf.8.2026.02.06.07.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:09:44 -0800 (PST)
Date: Fri, 6 Feb 2026 09:09:43 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Zong Li <zong.li@sifive.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        devicetree@vger.kernel.org, Yaxing Guo <guoyaxing@bosc.ac.cn>
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance
 monitoring
Message-ID: <xukccsqgwmagqq5egx7i4op6nfot3t3lusnaso4pfzcq5h6bfz@adsm5nusnocx>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
 <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
 <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
 <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
 <zzbwkazzgeovgmbvg4qnibipzsldqcjnw4axnxlamhgvcld4hs@4m4cc2ctuuvf>
 <752514AD54FA2A1B+513d6894-b3bf-44f3-bcc1-7d30f2642cc2@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <752514AD54FA2A1B+513d6894-b3bf-44f3-bcc1-7d30f2642cc2@linux.spacemit.com>
X-Authority-Analysis: v=2.4 cv=BbzVE7t2 c=1 sm=1 tr=0 ts=69860439 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=pGLkceISAAAA:8 a=gObE7mBVTb-_oU6ProoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: hMW_UKx7_1mdy8OtL2UxI1vhFYOahwbc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEwOSBTYWx0ZWRfX4+FnKh3Qf/+D
 dUZ4DsFFdw2+XfmTaQUcRfdweJ4OtYAM5RDMVQ5/uZvRoFj+EWOdVwBhV1/XOngispWKJ1ZvPsP
 1+dMAuZ+vA6kIzujy54KgTXskc3Jz7mtKnCLFYmFn+rrZ3fLxrHEiaRblszQwKz0JW0K4fqvLC6
 o+cchCL8USR1ngWYGBodvENC0bGoS5ygWGYXoionJJXTG6prXZNTgu0Mt1Il1LjFsw41bxONhmy
 0fQMexSAnz+rJ5WyuPAkZ1sVR99MHui/KGYuzzju/EDwEmJTKRVipW8xqGrbdtQvRmafeOpQNln
 WQRru7doDLAxm6x8pDuHIfaiytn1KWqnOmya6rkv7Bf+qa5/amOihGp772wymgIUAnAV1/4+P8K
 Wyr0lLiRsfRZeKZLFl42zK6kwYtJ6hG18AZ7BNSvL6LjoMplKr4ntiuU947MdouQTlnH6jP6vMi
 gb/QpqGBwyn49GRjOrw==
X-Proofpoint-ORIG-GUID: hMW_UKx7_1mdy8OtL2UxI1vhFYOahwbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060109

On Fri, Feb 06, 2026 at 11:42:39AM +0800, Lv Zheng wrote:
> On 2/5/2026 11:23 PM, Andrew Jones wrote:
...
> > Since Zong Li's patches were already on the list then your serieswould> at
> least discuss them in the cover letter, explaining why you've opted
> > not to adopt them. But, most likely some of the patches can be adopted,
> > so those should be extracted from Zong Li's work (with authorship
> > preserved) and based upon in order to respect that prior work.
> > 
> 
> You can see we have contacted each other in community, and decided to
> cooperate in this way to honor his contribution. But final decision is
> left for the community to decide:
> 
> From Zong Li:
> >> Of course, if the community would prefer to go your version, I’m
> >> perfectly fine with that as well.
> 
> We respect all contributions, We'll add the link in cover letter to the
> follow-up revisions, let me know if anything else should be done to the
> new revisions.

Just do all the communication before posting, allowing that communication
to be summarized in the cover letter and in any appropriate commit
messages so reviewers know what's going on. Also don't forget to CC
anybody previously involved to ensure they have a chance to chime in.

> 
> --------------------------------------------------------------------
> 
> And let me describe in details to compare the functionalities and
> addressed comments between what is provided by Joey and by Zong:
> 
> https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
> 
> There is no missing functionalities between the two approaches, I also
> checked the original Robin's comments, let me describe them in details:

My concern wasn't whether or not Robin's comments were addressed in this
posting (that's important, but not what I'm talking about). My concern
was that Zong Li's work wasn't addressed in any way, so appeared to be
a chance for duplicated efforts. Indeed his reply [1] indicates exactly
that and even that there is a third patch series being worked
independently. Please work out who and what patches are going to be
the focus going forward and describe that decision in the cover letter
for the next revision. And please don't forget to CC Zong Li and Yaxing
Guo.

[1] https://lore.kernel.org/all/CANXhq0oi9nE7ffLGsz5j8GnC1UDTD-4bE4cantRjW2fXHYrjHA@mail.gmail.com/

Thanks,
drew
