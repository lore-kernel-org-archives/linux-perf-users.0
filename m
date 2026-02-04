Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1E42315F
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770230387; cv=none; b=Uhd3AclH6s2j/J+rFcEjsNNpZ1iNJeWAgTAOPpJwLzWHtiazsAddUenZ8QNIPQa3TzEMkE49dhyWrcdHR5SASBYJxlErjZQ5UHam7Sbe8fL1r1s49cNAkv13ChwhxyH77N5RIBTWdhWATS+OzaJcJHzOF7VjyYk5Lowx9WoWuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770230387; c=relaxed/simple;
	bh=4xHL8leDKCLz6JEsceKtUmCPHoByynQNq65Q405b+EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKn645OQn7/WmpLr7PP1xkjX9RddEdfaEKbmDSRF3yKrWvbiDPXGNRtkZ0NzYNgLRmc/ZqPC+eRMHGEsC6TOops4Gzt9uyZ8Lz3Dntvn+RyFOV8Ul7nEK7JdVNj+Kx9I/LF57TmK9bXoNQtOy8Yh7PXbQu97nyObZU2NayoTraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VsWk7wql; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bisoZdio; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VsWk7wql";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bisoZdio"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614EGLkm926387
	for <linux-perf-users@vger.kernel.org>; Wed, 4 Feb 2026 18:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I1Ej76cz71aZvXkYw99NqdEA
	d6dQhn3hI8uMX6IFc2o=; b=VsWk7wqlkw6gDKSyQDZyl6ZypAYi3bN6sGNiUk+K
	I3gipjoxIWCkPAsT7Ko5OCYT8tAXiBBHRx+4JX7Q4CjA0CU/Sr+pmNZDP71LPQR8
	UTp0eekjVMab+8ODgqgrJIUnEfRXBLzjLK3Vkw8y5SK+rxZHrcoWAFe0dVwi2FCA
	2+ukxmOEiwjdMRACDzBkry5EG1JL3ieU/51HH+cQkBe1bMCbDOxCKCv7qMU029DK
	H3aHq2XTUVxGaN8bD90tNJW8qeGxsq4GLLM1ru44v69RZad7uYLcRElryHnYsPOE
	U7Fh7aOmErfL8wGB6OUd0vP55aC7ltAwrR/T2wLkOMjkvA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c47qv8x0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 18:39:46 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-124a978ba9bso273850c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770230385; x=1770835185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1Ej76cz71aZvXkYw99NqdEAd6dQhn3hI8uMX6IFc2o=;
        b=bisoZdioyUQM//MiIwNg1Ddx5FIiBp67+PeAqOwLRlX47eS7vBZiO3FdRT8/b7CsId
         EJaAxewDzp4MMixoHXJgQev5vFmOCXCFDuKaQK8THEBKCTj5JThYZ16f2/YfYoSBdJbe
         cty04V/vWlgwiMNUMS1fU2LYQWBa1cKcoCp13I+ZAUV2p0FSHJb2HHgIwVG/6ERKnBnr
         RIZEPGndEnFH0Aqb69G9gPcfDHMxUZHmp91GgFNKLCwbjEYGWNhFsXjZLrquP0m/CWIV
         1AG1Q/rFLHRE5ygzJbMsKhzY+y+Cj2Q/iCKVwlWzmpzc6jRzKAgGGVJmtRbcPOKiFYLl
         i/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770230385; x=1770835185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1Ej76cz71aZvXkYw99NqdEAd6dQhn3hI8uMX6IFc2o=;
        b=IUzquGlcozkvyTBncKR0VwJ2XS49RFVu/ZPyuCF8UKvK69McXCP+Kx46TYcSbVrDZk
         ng0on9WeLGao6j+RT5zvGw29jqA0d+mOo7dRFWP9bzqXH2pYzU6YFtgP539gjCAB9cws
         F5zqX+nGCG312Bv7n+XuHBksJ2gNvjlWbbpfoMduu8kRV3oRft/yCGmvgd78VU5spUse
         dJNl1ME13Vmz5CW5hRi/V6q5hZKeN1viQfjONOcD0eu0bB2rnLqSDKo/82ugxPH7QECA
         XR9vMRvltnmKk41C36zrAkitTOyyOZNg1w6C7AlV9hPoFpgGwD4v32p2Z7KXSD/dZk3F
         K/BA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/65j8jO+aWWVAkswWZHhvLDkVtuxIdMHDf5Jke6sUqVlXgqaXSkwtGXBNw1sZlZz3n9bH8oJDUSeuVShgKzk@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2LK7h3tjEVMlU3B187zZuWc9NHWF1HLVpUgLxEFrzLC1+VsI
	rPbdtTEvuQw1JaoaOiV3xdiARNJMUBFulCsifpbDPVDLVu7Qn3HY6T7tpPeCnavaZiry0ZOV8PX
	nS3yoz39FXX93V2zEDdKjL7MZZHvrNWrgFhibHWZJp66ezlFdJh5O0PRkrFoueodDvp5fgkyk
X-Gm-Gg: AZuq6aKRqRW4hD1PlKrF9mu5ljWoA6kQegmJf8mJoqOKYuJhJsvcF6Ab0K50grSmG3K
	Y5Uohw7wcOBsypYrNMwhqHpG0jM34GzFE6INkf7T+Nm40uwZj7wumShH7X9/WHTL4NsnCx9XWl8
	ZrUY6uGbwtaz7tZY0ydFdMu/GkJedq0+3T5lJTCFXQfOvE03r0U8mQOzRTeA6y8i2cpUDqcfJvy
	3tnaTCAZ2A2wf4aG+mof732PtTzgTjalaTUUVG4qeh/w+pzyPtmXtj+LPHmxPhbuYE17M1babwL
	Is6Eq17sIOkA/lyZd5Tiot9Nb9Mkdy/zsp53oC8EKTbgEvlgKR7hC3k8OKE6UiqfKCSw6MNrgvF
	6VTIeeWiuNizPrhDG+5o=
X-Received: by 2002:a05:7022:b91:b0:124:a610:62f6 with SMTP id a92af1059eb24-126f48e2d5amr1318242c88.44.1770230385417;
        Wed, 04 Feb 2026 10:39:45 -0800 (PST)
X-Received: by 2002:a05:7022:b91:b0:124:a610:62f6 with SMTP id a92af1059eb24-126f48e2d5amr1318219c88.44.1770230384803;
        Wed, 04 Feb 2026 10:39:44 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f5030e22sm2666926c88.10.2026.02.04.10.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 10:39:44 -0800 (PST)
Date: Wed, 4 Feb 2026 12:39:41 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        spacemit@lists.linux.dev, devicetree@vger.kernel.org,
        zong.li@sifive.com
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance
 monitoring
Message-ID: <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
X-Authority-Analysis: v=2.4 cv=GaEaXAXL c=1 sm=1 tr=0 ts=69839272 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=NEAV23lmAAAA:8
 a=lv0vYI88AAAA:8 a=ZVKkqgoUvZHFR46stTEA:9 a=CjuIK1q_8ugA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=oJz5jJLG1JtSoe7EL652:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-GUID: CnekBJZTPghQW7C4d77scvb2QAmFkj4C
X-Proofpoint-ORIG-GUID: CnekBJZTPghQW7C4d77scvb2QAmFkj4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDE0MiBTYWx0ZWRfXxPWMhBiiGFXC
 q8h608cNyAM4pprOMgqgf8Y0SKFMNoMCvzQ9uwEFogy4zO7QJSPpJYPTvXQ1wsvHig5a7kB92nk
 OVTg8ExBUEfFW5sSLtoQenN3eN1cIXYt9umLb/FwM/HlBTKjcavdXLTfsWBPOcZ+tMFOdqMWM0r
 HIRq9fX+sDLYU0kwNyaycHEet4BHJ26cmWDHj8vxjVDZRq+dL7J+ISQNZcSOkvqLNAeeilVmEAo
 YOPGsFPBZ16mjxihOV3xBV9/WcfPe5bLeQlU0kn44BsU2G5Q7awI36ANXs+zSj64cnr6yD/IMb0
 jblIGuTwAIKDOYcQ7nTQbC5hloUss5P8qZBY5VJ6KyEzDb7TudQwawIDtcefn2+mV4diAeA2QSu
 K3pPF3v9hgF+DEdYFp00pTKbMIV6ccoVARfHIdkBgouCQHXNjP1bm/NOw1e+c67W90XH+3aIDEQ
 Xw2b6gtfhreQ29obzQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040142

How does this relate to 

https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/

From a quick skim it looks like there's plenty of overlap.

Thanks,
drew


On Wed, Feb 04, 2026 at 05:09:01PM +0800, Lv Zheng wrote:
> From: Jingyu Li <joey.li@spacemit.com>
> 
> Introduces perf-based HPM driver for RISC-V IOMMU, enabling performance
> monitoring capabilities.
> 
> Note that the RISC-V IOMMU HPM module uses COUNTER_MAX-1 as a static
> counter index of HPMCYCLES, and 0~COUNTER_MAX-2 as the dynamic counter
> indexes of other HPMEVENTS in order to correctly index into IOHPMEVT and
> IOHPMCTR registers that have already been defined in the iommu-bits.h.
> However the users treat 0 as the index of HPMCYCLES and 1~COUNTER_MAX-1 as
> the indexes of other HPMEVENTS, thus care should be taken in dealing with
> counter indexes between userspace and kernel space.
> 
> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> Link: https://github.com/riscv-non-isa/riscv-iommu
> ---
>  drivers/iommu/riscv/Kconfig          |   9 +
>  drivers/iommu/riscv/Makefile         |   1 +
>  drivers/iommu/riscv/iommu-bits.h     |   6 +
>  drivers/iommu/riscv/iommu-hpm.c      | 843 +++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu-pci.c      |  13 +-
>  drivers/iommu/riscv/iommu-platform.c |   8 +-
>  drivers/iommu/riscv/iommu.h          |  42 ++
>  7 files changed, 919 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iommu/riscv/iommu-hpm.c
> 
