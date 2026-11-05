Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793852615;
	b=UlHmCZS6BX+0Yn/x3QP+Drg2QwbdIFlo3Q/zM3WQK2P/e7u6wFc/TUcpKSJwrHW/IPcP
	 l1iejTZNHdlvVgTf9ZhiwUfpF9Bx3DqYkJOx0EwDj9ZAlYzDhxAMRzfNEvGYtN0HWvJCl
	 ysUuWKcOMLxvUEg9Zeg51QOf3E0BJed+l6oz/avxhknptkfCtj7AmP2C6BNUYsnGq8Hk5
	 ZVCOf6e226LmZ//m1P2rfdhKi+rWbIOGH/04eB/kEcgCku1D1Ex42Gxi1tYPm+FY6bAk9
	 U8453KeoEP9p3fX4UdpbCigX8cj/LEq/HBTk1Rd6/37RLU/eqiQWABRV+VQfXbYCWkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852615;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TzWGeqPdCO4a6Yj7IJgsCSuQh2JlB5bOyBkbwEHMPAA=;
	b=1IfBKZZ1mnQABMylTxDezs1jiyje/c+eyin9RROwYM9bGisClIfqYON1IYtqlYhuDKOT
	 pN5Bp/fCSUv//daRJ/LgaBivQPFkIAfJXIU1Z2Ah7SHw4MESx9roFO7eAUy3m0Xzrek6q
	 9xBMdvdRlf4KRhdwcy0SUJYwzUr0rtqwmk51wtwKtwFckjx+LGX2ig8kTCdChd3rPqJvm
	 pHE2PHPkySlyrxfqsxr9wqPk7xz/KGryLH16s0ei2U5SGD3OvhaT7nVX7nx10I8umUHFx
	 MT4GFTU2qilHeSa2sbrgNeERo5kEfDCBiB9+SsMu7jAAYy/3SgFguDzZx4XbLNFnp0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="L/hCHipz";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OFAVEZOf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C4606A329
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 04:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 823C4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L/hCHipz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OFAVEZOf
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A50opgu4021598
	for <linux-perf-users@vger.kernel.org>; Thu, 5 Nov 2026 04:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TzWGeqPdCO4a6Yj7IJgsCSuQh2JlB5bOyBkbwEHMPAA=; b=L/hCHipz8DV2scCA
	ZlTBzwS/oy6vjuK9KPpTQsuV0yL0tNoffThrgijI60/uNxRoKBLJijfrk2P7qvwt
	fIeVNtpfp8iQCfAKDAzYOe0vQcxBT4AfKL9CnsQkfmStU9SENEJGhGSdqUWlhVn4
	0+IKL3s+AXbiHQoYA5WhYZN36cnn8Ucji+wmLLVZlcDDJOnWiyztt4U3yXPX6+/l
	pA2cxdjtqzgj0ApbqoD+7XIbIUQYa5/XaWlTkYzAmoa0bGjilEWdjuQV5jcYct3N
	SH48HLupWAE61CcMyaerS+A8oOBxGnKOuE9L1z7THcMJuwZD4bL35NS3OVPz/f5/
	nghaYA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr284v8bb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 04:23:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b20a4b5f2bso1775447c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 20:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793852612; x=1794457412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzWGeqPdCO4a6Yj7IJgsCSuQh2JlB5bOyBkbwEHMPAA=;
        b=OFAVEZOftgHvd+WpgLSdlT/oKSlcWHfGh9kwPrB5d0fsiJFCsU3uqQu58+jwzyJD2S
         B5j2FSspFrMr1HSC6UREPmBaT9TkblaOFDZ09oTySH0zSIEv9qXeidipy03ec2FBzQ/e
         PosbRyHYizisFXKp8LZDi9mH+Xw/G6wls79MBGaOQ75W53Wf6N1U2kx7UvEX0w30K8Tf
         F7JyL3MYuSz2IjBpV7Iu5aep3T8UF55fnIDw+xYR6IjnTd5UHMrcfdmxsBEywyPgdKaF
         /rgK/NtvWAhcbsMQ2mIuguiiOS1e2aOT/CCRO3ZA+WYl3XkS7YX0EHiexXjRzXW+6jEg
         AARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852612; x=1794457412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TzWGeqPdCO4a6Yj7IJgsCSuQh2JlB5bOyBkbwEHMPAA=;
        b=PWn36uDihGXORMGMn7nvTsb/QAiGoIETIZJeUWu51/08/lL8Qm2X4ajswCCmA6xFmT
         0Is7Pqrl/m72JC7S87A5eDNu0SAvHDKkWKS6cySJ7+xP4Wm1ZX8AKdAWt3DILHFFssw4
         aA7Wr7As2OJHBI68A1Ms5a8CGpphPue/sYwPiOC+8hDvwT1zUzY5goHIttHCYDOlGe/c
         NeoThSX30hoADt6bEVCZFHbX83bssSZmhagJoB8QJFfjG2lbzTnc9Fso6DvILbYrXPiF
         J/3FihA5fjK7JD3UuXJyZPMQcwtMniPVIEtH7CqfIdSQk49aAS+S+UDmjOAlPxY9YwUK
         zWYg==
X-Forwarded-Encrypted: i=1; AKwUvBwfov/I+c00b5xIXCklcxjmjnbAvYUxrM/YCd2M/Niy6fKohsl7Cn1TkIBrecQyY80Foxse2B4TOcoNEnMlyDxb@vger.kernel.org
X-Gm-Message-State: APuU4Z/NTxVTsuWz14Bjlun0DtxOz1f4XFrVU5uOg2d3jCyamicQt/nl
	YzniUeMhuy/PebrViANCRCZiPlTtO4mpiGTufXjwir8/+p8qRT0pUN5vnqBVibbNmd153G6MVvU
	/g4jbex7bxyVdZPpWYZp6wBJSxhyLWHNWLv011bqH1Fji5fpoeM1ajcIQC3vQNeBIsnZfJSN3
X-Gm-Gg: AYBFou2nS/VEUB4ZEe1xgCb8/7DQP5SKTK3ZgpRn0+demogXylsKlEFlJa61ZWochWI
	fxozTsijnoDYvmUPZIlkbUV92SWWF+lkQc+uChfS3j6uLFMEHailqA7jnTRjP4vnr+3GxXKFKaW
	RNtvp6OPFp5DNiCLAPvvsqMsso5lFw3IQcsZI6xOUDb4g+AeGA9BrPUvuJRzNnOkVMSegEVPPV5
	GT3ipcSe0L152b+D2b1pv4ZfT6npiNkVvB5zR2uI0xq5sNdgGF78PUIJDZLNLDuuhneTNVXEErr
	so2L0HgsfEoPN7CdB16KT5SY2PIzsW3RSgXnMsooi4x00PoIvg9chF8JHYnFnXzqQuKGNPq/qVc
	nO05OuiEqccCqHLY65YMdDvtSD/5/UvlSd9T9XvkETprAlEZy5PReKmko0pTdyrfVDnS6b7Z/Pf
	nkV+UWdf/Do+abokgeJgU/hfNuf79kll/MnCo4q98dMy4HfbxlROEp2HbinvFom0TAxTSNZsJO
X-Received: by 2002:a05:7022:3a8c:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1ac4fa14bc6mr31325497c88.0.1793852611206;
        Wed, 04 Nov 2026 20:23:31 -0800 (PST)
X-Received: by 2002:a05:7022:3a8c:b0:14b:cf58:ce5e with SMTP id a92af1059eb24-1ac4fa14bc6mr31325455c88.0.1793852610327;
        Wed, 04 Nov 2026 20:23:30 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2c2ddsm12231381c88.10.2026.11.04.20.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:23:29 -0800 (PST)
Date: Thu, 5 Nov 2026 09:53:23 +0530
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, pjw@kernel.org, qingfang.deng@linux.dev,
        shuah@kernel.org, thecharlesjenkins@gmail.com,
        cp0613@linux.alibaba.com
Subject: Re: [PATCH v7 1/8] riscv: Introduce support for hardware
 break/watchpoints
Message-ID: <auwEu5UfYfmpZotP@hu-himchau-blr.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-2-himanshu.chauhan@oss.qualcomm.com>
 <CADRr4bczG1YpG0Z9nMzK=q8z0nXBrd8ALKsT8Pe-ZRmMf_dksQ@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADRr4bczG1YpG0Z9nMzK=q8z0nXBrd8ALKsT8Pe-ZRmMf_dksQ@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=JdQpPkKV c=1 sm=1 tr=0 ts=6aec04c5 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=qFFhO6GVNA_paomLZDcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: W7wAPyUmQlcN1FRGdu97-d9m5nYZ-0fp
X-Proofpoint-GUID: W7wAPyUmQlcN1FRGdu97-d9m5nYZ-0fp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAxNyBTYWx0ZWRfX8V22guL0Hxz5
 gXvHKi5nsnlvt1ofmCYkGq4+AgQap84nNCqMBeKK7c+uIxtUr3KqAccjN/dRDXX7POcOaCwLee3
 MX3oxvVzcjBHBdlFsA3KiExY8CqugJ89Dgw2pLUH0zDG4ju7lRj8rqMXHGhxhj4rMBS3xvjkM0O
 4/wi1em3p5x8XOoJiuN9RryLFBRuwodAbMnwQtBRd3tGPX95z5SF2CYjE8gTUGamaVhFKcA8eG5
 RA+oODMoJ1bOR1IGKgTsYwTnS8zaicQHIc04ZYXPbUFswFe0KyLDYMwCnyY7L5pOWri4isY6mhC
 KKTjCqv9zlZ6X7odIBF1MrsDeGuS27xRY3xu0rZk4vhyrHBB4LqNgGChwbkw5nfzbnH/OQ14ZW/
 pMQyNgPlknqvWBAMDCX6zujFUGTbDvLvCFqfCOr4Qr07Lc+sLP6gFUVJt8wJbR1b3gdclfjOn+6
 z9a/MkhKWzGvJmV6KlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAxNyBTYWx0ZWRfX5zXgDUJIjR+u
 y6NHj8Oj5rf8b2k1gsPz1yBC61/0/fI2BecuJaJ7idwC0tYeYFS/822T6Wh2/TbDr0xqaDOaN0u
 hqSEa0Vm2uI4uXF+gJ7iYJKHEgqrHvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050017

On Tue, Oct 27, 2026 at 01:58:53PM -0400, Jesse Taube wrote:
> On Wed, Sep 30, 2026 at 2:39 AM Himanshu Chauhan
> <himanshu.chauhan@oss.qualcomm.com> wrote:
> >
> > RISC-V hardware breakpoint framework is built on top of perf subsystem
> > and uses SBI debug trigger extension to install/uninstall/update/enable/disable
> > hardware triggers as specified in Sdtrig ISA extension.
> >
> > While handling breakpoints, trust the hardware record, (hit[0-1]) bits, when deciding
> > if a trigger fired, and by clearing it once it's been read.
> >
> > Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> > ---
> >  arch/riscv/Kconfig                     |   2 +
> >  arch/riscv/include/asm/hw_breakpoint.h | 312 +++++++++++
> >  arch/riscv/include/asm/kdebug.h        |   3 +-
> >  arch/riscv/kernel/Makefile             |   1 +
> >  arch/riscv/kernel/hw_breakpoint.c      | 746 +++++++++++++++++++++++++
> >  arch/riscv/kernel/traps.c              |   6 +
> >  6 files changed, 1069 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
> >  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d6c2dbf8455c..17fa7d4f9729 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -174,6 +174,8 @@ config RISCV
> >         select HAVE_FUNCTION_ARG_ACCESS_API
> >         select HAVE_FUNCTION_ERROR_INJECTION
> >         select HAVE_GCC_PLUGINS
> > +       select HAVE_GENERIC_VDSO if MMU
> The line above seems to be a rebasing artifact
>
Noted.

> > +       select HAVE_HW_BREAKPOINT if PERF_EVENTS
> >         select HAVE_IRQ_TIME_ACCOUNTING
> >         select HAVE_KERNEL_BZIP2 if !EFI_ZBOOT
> >         select HAVE_KERNEL_GZIP if !EFI_ZBOOT
> > diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
> > new file mode 100644
> > index 000000000000..a165bb9636de
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/hw_breakpoint.h
> > @@ -0,0 +1,312 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2026 Qualcomm Technologies, Inc.
> > + */
> > +
> > +#ifndef __RISCV_HW_BREAKPOINT_H
> > +#define __RISCV_HW_BREAKPOINT_H
> > +
> > +struct task_struct;
> > +
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +
> > +#include <uapi/linux/hw_breakpoint.h>
> > +
> > +/* Maximum number of hardware breakpoints supported */
> > +#define RISCV_HW_BP_NUM_MAX 32
> > +
> > +#if __riscv_xlen == 64
> > +#define cpu_to_le cpu_to_le64
> > +#define le_to_cpu le64_to_cpu
> > +#elif __riscv_xlen == 32
> > +#define cpu_to_le cpu_to_le32
> > +#define le_to_cpu le32_to_cpu
> > +#else
> > +#error "Unexpected __riscv_xlen"
> > +#endif
> > +
> > +#define CLEAR_DBTR_BIT(_target, _bit)  ((_target) &= ~BIT(_bit))
> > +#define SET_DBTR_BIT(_target, _bit)    ((_target) |= BIT(_bit))
> > +
> > +#define RISCV_DBTR_EXEC                BIT(0)
> > +#define RISCV_DBTR_LOAD                BIT(1)
> > +#define RISCV_DBTR_STORE       BIT(2)
> > +#define RISCV_DBTR_LDST                (RISCV_DBTR_LOAD | RISCV_DBTR_STORE)
> > +
> > +enum {
> > +       RISCV_DBTR_TRIG_NONE = 0,
> > +       RISCV_DBTR_TRIG_LEGACY,
> > +       RISCV_DBTR_TRIG_MCONTROL,
> > +       RISCV_DBTR_TRIG_ICOUNT,
> > +       RISCV_DBTR_TRIG_ITRIGGER,
> > +       RISCV_DBTR_TRIG_ETRIGGER,
> > +       RISCV_DBTR_TRIG_MCONTROL6,
> > +};
> > +
> > +/* Trigger Data 1 */
> > +#define RISCV_DBTR_TDATA1_DATA_BIT     0
> > +#if __riscv_xlen == 64
> > +#define RISCV_DBTR_TDATA1_DMODE_BIT    59
> > +#define RISCV_DBTR_TDATA1_TYPE_BIT     60
> > +#elif __riscv_xlen == 32
> > +#define RISCV_DBTR_TDATA1_DMODE_BIT    27
> > +#define RISCV_DBTR_TDATA1_TYPE_BIT     28
> > +#else
> > +#error "Unknown __riscv_xlen"
> > +#endif
> > +
> > +#if __riscv_xlen == 64
> > +#define RISCV_DBTR_TDATA1_DATA_BIT_MASK                GENMASK(58, RISCV_DBTR_TDATA1_DATA_BIT)
> > +#elif __riscv_xlen == 32
> > +#define RISCV_DBTR_TDATA1_DATA_BIT_MASK                GENMASK(26, RISCV_DBTR_TDATA1_DATA_BIT)
> > +#else
> > +#error "Unknown __riscv_xlen"
> > +#endif
> > +#define RISCV_DBTR_TDATA1_DMODE_BIT_MASK       BIT(RISCV_DBTR_TDATA1_DMODE_BIT)
> > +#define RISCV_DBTR_TDATA1_TYPE_BIT_MASK                \
> > +       GENMASK(RISCV_DBTR_TDATA1_TYPE_BIT + 3, RISCV_DBTR_TDATA1_TYPE_BIT)
> > +
> > +/* MC - Match Control Type Register */
> > +#define RISCV_DBTR_MC_LOAD_BIT         0
> > +#define RISCV_DBTR_MC_STORE_BIT                1
> > +#define RISCV_DBTR_MC_EXEC_BIT         2
> > +#define RISCV_DBTR_MC_U_BIT            3
> > +#define RISCV_DBTR_MC_S_BIT            4
> > +#define RISCV_DBTR_MC_RES2_BIT         5
> > +#define RISCV_DBTR_MC_M_BIT            6
> > +#define RISCV_DBTR_MC_MATCH_BIT                7
> > +#define RISCV_DBTR_MC_CHAIN_BIT                11
> > +#define RISCV_DBTR_MC_ACTION_BIT       12
> > +#define RISCV_DBTR_MC_SIZELO_BIT       16
> > +#define RISCV_DBTR_MC_TIMING_BIT       18
> > +#define RISCV_DBTR_MC_SELECT_BIT       19
> > +#define RISCV_DBTR_MC_HIT_BIT          20
> > +#if __riscv_xlen >= 64
> > +#define RISCV_DBTR_MC_SIZEHI_BIT       21
> > +#endif
> > +#if __riscv_xlen == 64
> > +#define RISCV_DBTR_MC_MASKMAX_BIT      53
> > +#define RISCV_DBTR_MC_DMODE_BIT                59
> > +#define RISCV_DBTR_MC_TYPE_BIT         60
> > +#elif __riscv_xlen == 32
> > +#define RISCV_DBTR_MC_MASKMAX_BIT      21
> > +#define RISCV_DBTR_MC_DMODE_BIT                27
> > +#define RISCV_DBTR_MC_TYPE_BIT         28
> > +#else
> > +#error "Unknown riscv xlen"
> > +#endif
> > +
> > +#define RISCV_DBTR_MC_LOAD_BIT_MASK    BIT(RISCV_DBTR_MC_LOAD_BIT)
> > +#define RISCV_DBTR_MC_STORE_BIT_MASK   BIT(RISCV_DBTR_MC_STORE_BIT)
> > +#define RISCV_DBTR_MC_EXEC_BIT_MASK    BIT(RISCV_DBTR_MC_EXEC_BIT)
> > +#define RISCV_DBTR_MC_U_BIT_MASK       BIT(RISCV_DBTR_MC_U_BIT)
> > +#define RISCV_DBTR_MC_S_BIT_MASK       BIT(RISCV_DBTR_MC_S_BIT)
> > +#define RISCV_DBTR_MC_RES2_BIT_MASK    BIT(RISCV_DBTR_MC_RES2_BIT)
> > +#define RISCV_DBTR_MC_M_BIT_MASK       BIT(RISCV_DBTR_MC_M_BIT)
> > +#define RISCV_DBTR_MC_MATCH_BIT_MASK   \
> > +       GENMASK(RISCV_DBTR_MC_MATCH_BIT + 3, RISCV_DBTR_MC_MATCH_BIT)
> > +#define RISCV_DBTR_MC_CHAIN_BIT_MASK   BIT(RISCV_DBTR_MC_CHAIN_BIT)
> > +#define RISCV_DBTR_MC_ACTION_BIT_MASK  \
> > +       GENMASK(RISCV_DBTR_MC_ACTION_BIT + 3, RISCV_DBTR_MC_ACTION_BIT)
> > +#define RISCV_DBTR_MC_SIZELO_BIT_MASK  \
> > +       GENMASK(RISCV_DBTR_MC_SIZELO_BIT + 1, RISCV_DBTR_MC_SIZELO_BIT)
> > +#define RISCV_DBTR_MC_TIMING_BIT_MASK  BIT(RISCV_DBTR_MC_TIMING_BIT)
> > +#define RISCV_DBTR_MC_SELECT_BIT_MASK  BIT(RISCV_DBTR_MC_SELECT_BIT)
> > +#define RISCV_DBTR_MC_HIT_BIT_MASK     BIT(RISCV_DBTR_MC_HIT_BIT)
> > +#if __riscv_xlen >= 64
> > +#define RISCV_DBTR_MC_SIZEHI_BIT_MASK  \
> > +       GENMASK(RISCV_DBTR_MC_SIZEHI_BIT + 1, RISCV_DBTR_MC_SIZEHI_BIT)
> > +#endif
> > +#define RISCV_DBTR_MC_MASKMAX_BIT_MASK \
> > +       GENMASK(RISCV_DBTR_MC_MASKMAX_BIT + 5, RISCV_DBTR_MC_MASKMAX_BIT)
> > +#define RISCV_DBTR_MC_DMODE_BIT_MASK   BIT(RISCV_DBTR_MC_DMODE_BIT)
> > +#define RISCV_DBTR_MC_TYPE_BIT_MASK    GENMASK(RISCV_DBTR_MC_TYPE_BIT + 3, RISCV_DBTR_MC_TYPE_BIT)
> > +
> > +/* MC6 - Match Control 6 Type Register */
> > +#define RISCV_DBTR_MC6_LOAD_BIT                0
> > +#define RISCV_DBTR_MC6_STORE_BIT       1
> > +#define RISCV_DBTR_MC6_EXEC_BIT                2
> > +#define RISCV_DBTR_MC6_U_BIT           3
> > +#define RISCV_DBTR_MC6_S_BIT           4
> > +#define RISCV_DBTR_MC6_RES2_BIT                5
> > +#define RISCV_DBTR_MC6_M_BIT           6
> > +#define RISCV_DBTR_MC6_MATCH_BIT       7
> > +#define RISCV_DBTR_MC6_CHAIN_BIT       11
> > +#define RISCV_DBTR_MC6_ACTION_BIT      12
> > +#define RISCV_DBTR_MC6_SIZE_BIT                16
> > +#define RISCV_DBTR_MC6_TIMING_BIT      20
> > +#define RISCV_DBTR_MC6_SELECT_BIT      21
> > +#define RISCV_DBTR_MC6_HIT_BIT         22
> > +#define RISCV_DBTR_MC6_VU_BIT          23
> > +#define RISCV_DBTR_MC6_VS_BIT          24
> > +#if __riscv_xlen == 64
> > +#define RISCV_DBTR_MC6_DMODE_BIT       59
> > +#define RISCV_DBTR_MC6_TYPE_BIT                60
> > +#elif __riscv_xlen == 32
> > +#define RISCV_DBTR_MC6_DMODE_BIT       27
> > +#define RISCV_DBTR_MC6_TYPE_BIT                28
> > +#else
> > +#error "Unknown riscv xlen"
> > +#endif
> > +
> > +#define RISCV_DBTR_MC6_LOAD_BIT_MASK   BIT(RISCV_DBTR_MC6_LOAD_BIT)
> > +#define RISCV_DBTR_MC6_STORE_BIT_MASK  BIT(RISCV_DBTR_MC6_STORE_BIT)
> > +#define RISCV_DBTR_MC6_EXEC_BIT_MASK   BIT(RISCV_DBTR_MC6_EXEC_BIT)
> > +#define RISCV_DBTR_MC6_U_BIT_MASK      BIT(RISCV_DBTR_MC6_U_BIT)
> > +#define RISCV_DBTR_MC6_S_BIT_MASK      BIT(RISCV_DBTR_MC6_S_BIT)
> > +#define RISCV_DBTR_MC6_RES2_BIT_MASK   BIT(RISCV_DBTR_MC6_RES2_BIT)
> > +#define RISCV_DBTR_MC6_M_BIT_MASK      BIT(RISCV_DBTR_MC6_M_BIT)
> > +#define RISCV_DBTR_MC6_MATCH_BIT_MASK  \
> > +       GENMASK(RISCV_DBTR_MC6_MATCH_BIT + 3, RISCV_DBTR_MC6_MATCH_BIT)
> > +#define RISCV_DBTR_MC6_CHAIN_BIT_MASK  BIT(RISCV_DBTR_MC6_CHAIN_BIT)
> > +#define RISCV_DBTR_MC6_ACTION_BIT_MASK \
> > +       GENMASK(RISCV_DBTR_MC6_ACTION_BIT + 3, RISCV_DBTR_MC6_ACTION_BIT)
> > +#define RISCV_DBTR_MC6_SIZE_BIT_MASK   \
> > +       GENMASK(RISCV_DBTR_MC6_SIZE_BIT + 3, RISCV_DBTR_MC6_SIZE_BIT)
> > +#define RISCV_DBTR_MC6_TIMING_BIT_MASK BIT(RISCV_DBTR_MC6_TIMING_BIT)
> > +#define RISCV_DBTR_MC6_SELECT_BIT_MASK BIT(RISCV_DBTR_MC6_SELECT_BIT)
> > +#define RISCV_DBTR_MC6_HIT_BIT_MASK    BIT(RISCV_DBTR_MC6_HIT_BIT)
> > +#define RISCV_DBTR_MC6_VU_BIT_MASK     BIT(RISCV_DBTR_MC6_VU_BIT)
> > +#define RISCV_DBTR_MC6_VS_BIT_MASK     BIT(RISCV_DBTR_MC6_VS_BIT)
> > +#define RISCV_DBTR_MC6_DMODE_BIT_MASK  BIT(RISCV_DBTR_MC6_DMODE_BIT)
> > +#define RISCV_DBTR_MC6_TYPE_BIT_MASK   \
> > +       GENMASK(RISCV_DBTR_MC6_TYPE_BIT + 3, RISCV_DBTR_MC6_TYPE_BIT)
> > +
> > +/*
> > + * mcontrol6 hit1:hit0 (ratified Debug spec v1.0). RISCV_DBTR_MC6_HIT_BIT
> > + * above is hit0 (bit 22); hit1 (bit 25) is not adjacent to it but combines
> > + * with it into a single 2-bit field, hit1 as MSB.
> > + */
> > +#define RISCV_DBTR_MC6_HIT1_BIT                25
> > +#define RISCV_DBTR_MC6_HIT1_BIT_MASK           BIT(RISCV_DBTR_MC6_HIT1_BIT)
> > +
> > +#define RISCV_DBTR_MC6_HIT_FALSE       0       /* trigger did not fire */
> > +#define RISCV_DBTR_MC6_HIT_BEFORE      1       /* fired before the instruction */
> > +#define RISCV_DBTR_MC6_HIT_AFTER       2       /* fired after, epc has moved past */
> > +#define RISCV_DBTR_MC6_HIT_IMM_AFTER   3       /* fired immediately after */
> > +
> > +#define RISCV_DBTR_MC6_GET_HIT(_t1)                                    \
> > +       ({                                                              \
> > +               typeof(_t1) __t1 = (_t1);                               \
> > +               (((__t1) & RISCV_DBTR_MC6_HIT1_BIT_MASK) ? 2 : 0) |     \
> > +                       (((__t1) & RISCV_DBTR_MC6_HIT_BIT_MASK) ? 1 : 0); \
> > +       })
> > +
> > +#define RISCV_DBTR_MC6_CLEAR_HIT(_t1)                                  \
> > +       ((_t1) &= ~(RISCV_DBTR_MC6_HIT1_BIT_MASK | RISCV_DBTR_MC6_HIT_BIT_MASK))
> > +
> > +#define RISCV_DBTR_SET_TDATA1_TYPE(_t1, _type)                         \
> > +       ({                                                              \
> > +               typeof(_t1) (td1t1) = (_t1);                            \
> > +               (td1t1) &= ~RISCV_DBTR_TDATA1_TYPE_BIT_MASK;            \
> > +               (td1t1) |= (((unsigned long)(_type)                     \
> > +                            << RISCV_DBTR_TDATA1_TYPE_BIT)             \
> > +                           & RISCV_DBTR_TDATA1_TYPE_BIT_MASK);         \
> > +               (td1t1);                                                \
> > +       })
> > +
> > +#define RISCV_DBTR_SET_MC_TYPE(_t1, _type)                             \
> > +       ({                                                              \
> > +               typeof(_t1) (mct1) = (_t1);                             \
> > +               (mct1) &= ~RISCV_DBTR_MC_TYPE_BIT_MASK;                 \
> > +               (mct1) |= (((unsigned long)(_type)                      \
> > +                           << RISCV_DBTR_MC_TYPE_BIT)                  \
> > +                          & RISCV_DBTR_MC_TYPE_BIT_MASK);              \
> > +               (mct1);                                                 \
> > +       })
> > +
> > +#define RISCV_DBTR_SET_MC6_TYPE(_t1, _type)                            \
> > +       ({                                                              \
> > +               typeof(_t1) (mc6t1) = (_t1);                            \
> > +               (mc6t1) &= ~RISCV_DBTR_MC6_TYPE_BIT_MASK;               \
> > +               (mc6t1) |= (((unsigned long)(_type)                     \
> > +                            << RISCV_DBTR_MC6_TYPE_BIT)                \
> > +                           & RISCV_DBTR_MC6_TYPE_BIT_MASK);            \
> > +               (mc6t1);                                                \
> > +       })
> > +
> > +#define RISCV_DBTR_SET_MC_EXEC_BIT(_t1)                        \
> > +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC_EXEC_BIT)
> > +
> > +#define RISCV_DBTR_SET_MC_LOAD_BIT(_t1)                        \
> > +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC_LOAD_BIT)
> > +
> > +#define RISCV_DBTR_SET_MC_STORE_BIT(_t1)               \
> > +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC_STORE_BIT)
> > +
> > +#define RISCV_DBTR_SET_MC_SIZELO(_t1, _val)                            \
> > +       ({                                                              \
> > +               typeof(_t1) (mcslt1) = (_t1);                           \
> > +               mcslt1 &= ~RISCV_DBTR_MC_SIZELO_BIT_MASK;               \
> > +               mcslt1 |= (((_val) << RISCV_DBTR_MC_SIZELO_BIT)         \
> > +                          & RISCV_DBTR_MC_SIZELO_BIT_MASK);            \
> > +               (mcslt1);                                               \
> > +       })
> > +
> > +#if __riscv_xlen >= 64
> > +#define RISCV_DBTR_SET_MC_SIZEHI(_t1, _val)                            \
> > +       ({                                                              \
> > +               typeof(_t1) (mcsht1) = (_t1);                           \
> > +               mcsht1 &= ~RISCV_DBTR_MC_SIZEHI_BIT_MASK;               \
> > +               mcsht1 |= (((_val) << RISCV_DBTR_MC_SIZEHI_BIT)         \
> > +                          & RISCV_DBTR_MC_SIZEHI_BIT_MASK);            \
> > +               (mcsht1);                                               \
> > +       })
> > +#else
> > +/* SIZEHI does not exist in the rv32 mcontrol layout; nothing to set. */
> > +#define RISCV_DBTR_SET_MC_SIZEHI(_t1, _val) ((void)(_val), (_t1))
> > +#endif
> > +
> > +#define RISCV_DBTR_SET_MC6_EXEC_BIT(_t1)               \
> > +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC6_EXEC_BIT)
> > +
> > +#define RISCV_DBTR_SET_MC6_LOAD_BIT(_t1)               \
> > +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC6_LOAD_BIT)
> > +
> > +#define RISCV_DBTR_SET_MC6_STORE_BIT(_t1)              \
> > +       SET_DBTR_BIT(_t1, RISCV_DBTR_MC6_STORE_BIT)
> > +
> > +#define RISCV_DBTR_SET_MC6_SIZE(_t1, _val)                             \
> > +       ({                                                              \
> > +               typeof(_t1) (mc6szt1) = (_t1);                          \
> > +               (mc6szt1) &= ~RISCV_DBTR_MC6_SIZE_BIT_MASK;             \
> > +               (mc6szt1) |= (((_val) << RISCV_DBTR_MC6_SIZE_BIT)       \
> > +                             & RISCV_DBTR_MC6_SIZE_BIT_MASK);          \
> > +               (mc6szt1);                                              \
> > +       })
> 
> I think all the bit field macros specific to DBTR should go in hw_breakpoint.c.
> I also think that we should omit the unused macros and simplify their
> readability.
> we can do that by omitting clearing/setting versions and just creating
> the values in
> the function with ORs. There is also already generic versions of these macros in
> include/linux/bitfield.h so i would change the macros above to use FIELD_MODIFY
> and FIELD_* if you do think the extra checks are necessary.
> 
> In my version I also simplified the macro code feel free to take it
> https://github.com/Mr-Bossman/linux/commit/d04552102c20542ce54eb4302c89919590c6081c

Sure. I’ll move the DBTR encoding helpers local to hw_breakpoint.c and use FIELD_PREP()
for multi-bit fields, but I won’t adopt the older rewrite wholesale because the forthcoming
series has icount/hit-bit/RV32/single-step handling the patch does'nt cover.

> 
> > +
> > +struct arch_hw_breakpoint {
> > +       unsigned long address;
> > +       unsigned long len;
> > +       unsigned int type;
> > +
> > +       /* Trigger configuration data */
> > +       unsigned long tdata1;
> > +       unsigned long tdata2;
> > +       unsigned long tdata3;
> > +};
> > +
> > +struct perf_event_attr;
> > +struct notifier_block;
> > +struct perf_event;
> > +struct pt_regs;
> > +
> > +int hw_breakpoint_slots(int type);
> > +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
> > +int hw_breakpoint_arch_parse(struct perf_event *bp,
> > +                            const struct perf_event_attr *attr,
> > +                            struct arch_hw_breakpoint *hw);
> > +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> > +                                   unsigned long val, void *data);
> > +
> > +void arch_enable_hw_breakpoint(struct perf_event *bp);
> > +void arch_update_hw_breakpoint(struct perf_event *bp);
> > +void arch_disable_hw_breakpoint(struct perf_event *bp);
> > +int arch_install_hw_breakpoint(struct perf_event *bp);
> > +void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> > +void hw_breakpoint_pmu_read(struct perf_event *bp);
> > +
> > +#else
> > +
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> > +#endif /* __RISCV_HW_BREAKPOINT_H */
> > diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kdebug.h
> > index 85ac00411f6e..53e989781aa1 100644
> > --- a/arch/riscv/include/asm/kdebug.h
> > +++ b/arch/riscv/include/asm/kdebug.h
> > @@ -6,7 +6,8 @@
> >  enum die_val {
> >         DIE_UNUSED,
> >         DIE_TRAP,
> > -       DIE_OOPS
> > +       DIE_OOPS,
> > +       DIE_DEBUG
> >  };
> >
> >  #endif
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index ebe1c3588177..a4197c3c36e8 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -100,6 +100,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)        += mcount-dyn.o
> >
> >  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
> >  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
> > +obj-$(CONFIG_HAVE_HW_BREAKPOINT)       += hw_breakpoint.o
> >  obj-$(CONFIG_RISCV_SBI)                += sbi.o sbi_ecall.o
> >  ifeq ($(CONFIG_RISCV_SBI), y)
> >  obj-$(CONFIG_SMP)              += sbi-ipi.o
> > diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
> > new file mode 100644
> > index 000000000000..c2ab5e6008e7
> > --- /dev/null
> > +++ b/arch/riscv/kernel/hw_breakpoint.c
> > @@ -0,0 +1,746 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2026 Qualcomm Technologies, Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/hw_breakpoint.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/percpu.h>
> > +#include <linux/kdebug.h>
> > +#include <linux/bitops.h>
> > +#include <linux/cpu.h>
> > +#include <linux/cpuhotplug.h>
> > +
> > +#include <asm/sbi.h>
> > +
> > +/* Registered per-cpu bp/wp */
> > +static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[RISCV_HW_BP_NUM_MAX]);
> > +static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);
> > +static DEFINE_PER_CPU(raw_spinlock_t, ecall_lock);
> > +
> > +/* Per-cpu shared memory between S and M mode */
> > +static union sbi_dbtr_shmem_entry __percpu *sbi_dbtr_shmem;
> > +
> > +/* number of debug triggers on this cpu . */
> > +static int dbtr_total_num __ro_after_init;
> > +static int dbtr_type __ro_after_init;
> > +static int dbtr_init __ro_after_init;
> > +
> > +#define MEM_HI(_m)             (0UL)
> > +#define MEM_LO(_m)             ((unsigned long)(_m))
> > +
> > +static int arch_smp_setup_sbi_shmem(unsigned int cpu)
> > +{
> > +       union sbi_dbtr_shmem_entry *dbtr_shmem;
> > +       phys_addr_t shmem_pa;
> > +       struct sbiret ret;
> > +
> > +       dbtr_shmem = per_cpu_ptr(sbi_dbtr_shmem, cpu);
> > +
> > +       shmem_pa = per_cpu_ptr_to_phys(dbtr_shmem);
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
> > +                       MEM_LO(shmem_pa), MEM_HI(shmem_pa), 0, 0, 0, 0);
> > +
> > +       if (ret.error) {
> > +               pr_warn("%s: failed to setup shared memory. error: %ld\n",
> > +                       __func__, ret.error);
> > +               return sbi_err_map_linux_errno(ret.error);
> > +       }
> > +
> > +       pr_info("CPU %d: HW Breakpoint shared memory registered.\n", cpu);
> > +
> > +       return 0;
> > +}
> > +
> > +static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
> > +{
> > +       struct sbiret ret;
> > +
> > +       /* Disable shared memory */
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
> > +                       SBI_SHMEM_DISABLE, SBI_SHMEM_DISABLE, 0, 0, 0, 0);
> > +
> > +       if (ret.error)
> > +               pr_warn("%s: failed to disable shared memory. error: %ld\n",
> > +                       __func__, ret.error);
> > +       else
> > +               pr_info("CPU %d: HW Breakpoint shared memory disabled.\n", cpu);
> > +
> > +       return 0;
> > +}
> > +
> > +static void init_sbi_dbtr(void)
> > +{
> > +       unsigned long tdata1;
> > +       struct sbiret ret;
> > +
> > +       if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
> > +               pr_warn("SBI_EXT_DBTR is not supported\n");
> > +               dbtr_total_num = 0;
> > +               goto done;
> > +       }
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > +                       0, 0, 0, 0, 0, 0);
> > +       if (ret.error) {
> > +               pr_warn("Failed to detect triggers\n");
> > +               dbtr_total_num = 0;
> > +               goto done;
> > +       }
> > +
> > +       tdata1 = 0;
> > +       tdata1 = RISCV_DBTR_SET_TDATA1_TYPE(tdata1, RISCV_DBTR_TRIG_MCONTROL6);
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > +                       tdata1, 0, 0, 0, 0, 0);
> > +       if (ret.error) {
> > +               pr_warn("Failed to detect mcontrol6 triggers\n");
> > +       } else if (!ret.value) {
> > +               pr_warn("Type 6 triggers not available\n");
> > +       } else {
> > +               dbtr_total_num = min_t(unsigned long, ret.value,
> > +                                      RISCV_HW_BP_NUM_MAX);
> > +               dbtr_type = RISCV_DBTR_TRIG_MCONTROL6;
> > +               pr_warn("Mcontrol6 trigger available.\n");
> > +               goto done;
> > +       }
> > +
> > +       /* fallback to type 2 triggers if type 6 is not available */
> > +
> > +       tdata1 = 0;
> > +       tdata1 = RISCV_DBTR_SET_TDATA1_TYPE(tdata1, RISCV_DBTR_TRIG_MCONTROL);
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > +                       tdata1, 0, 0, 0, 0, 0);
> > +       if (ret.error) {
> > +               pr_warn("Failed to detect mcontrol triggers\n");
> > +       } else if (!ret.value) {
> > +               pr_warn("Type 2 triggers not available\n");
> > +       } else {
> > +               dbtr_total_num = min_t(unsigned long, ret.value,
> > +                                      RISCV_HW_BP_NUM_MAX);
> > +               dbtr_type = RISCV_DBTR_TRIG_MCONTROL;
> > +               goto done;
> > +       }
> > +
> > +done:
> > +       dbtr_init = 1;
> > +}
> > +
> > +int hw_breakpoint_slots(int type)
> > +{
> > +       /*
> > +        * We can be called early, so don't rely on
> > +        * static variables being initialised.
> > +        */
> > +
> > +       if (!dbtr_init)
> > +               init_sbi_dbtr();
> 
> dbtr_init should be attomic.
> I would put the following in init_sbi_dbtr.
> /*
> * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
> * Only proceed if this is the first CPU to reach this code.
> */
> if (test_and_set_bit(0, &dbtr_init))
> return;

Noted.

> 
> > +
> > +       return dbtr_total_num;
> > +}
> > +
> > +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
> > +{
> > +       unsigned int len;
> > +       unsigned long va;
> > +
> > +       va = hw->address;
> > +       len = hw->len;
> > +
> > +       return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
> > +}
> > +
> > +static int rv_init_mcontrol_trigger(const struct perf_event_attr *attr,
> > +                                   struct arch_hw_breakpoint *hw)
> > +{
> > +       switch (attr->bp_type) {
> > +       case HW_BREAKPOINT_X:
> > +               hw->type = RISCV_DBTR_EXEC;
> > +               RISCV_DBTR_SET_MC_EXEC_BIT(hw->tdata1);
> > +               break;
> > +       case HW_BREAKPOINT_R:
> > +               hw->type = RISCV_DBTR_LOAD;
> > +               RISCV_DBTR_SET_MC_LOAD_BIT(hw->tdata1);
> > +               break;
> > +       case HW_BREAKPOINT_W:
> > +               hw->type = RISCV_DBTR_STORE;
> > +               RISCV_DBTR_SET_MC_STORE_BIT(hw->tdata1);
> > +               break;
> > +       case HW_BREAKPOINT_RW:
> > +               hw->type = RISCV_DBTR_LDST;
> > +               RISCV_DBTR_SET_MC_LOAD_BIT(hw->tdata1);
> > +               RISCV_DBTR_SET_MC_STORE_BIT(hw->tdata1);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (attr->bp_type == HW_BREAKPOINT_X) {
> > +               /*
> > +                * Userspace debuggers can request execute breakpoints with
> > +                * bp_len == 2 for compressed/non-aligned instruction
> > +                * addresses. Program execute triggers with "match any size"
> > +                * to avoid missing valid instruction fetches.
> > +                */
> > +               hw->len = 0;
> > +               hw->tdata1 = RISCV_DBTR_SET_MC_SIZELO(hw->tdata1, 0);
> > +               hw->tdata1 = RISCV_DBTR_SET_MC_SIZEHI(hw->tdata1, 0);
> > +       } else {
> > +               switch (attr->bp_len) {
> > +               case HW_BREAKPOINT_LEN_1:
> > +                       hw->len = 1;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC_SIZELO(hw->tdata1, 1);
> > +                       break;
> > +               case HW_BREAKPOINT_LEN_2:
> > +                       hw->len = 2;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC_SIZELO(hw->tdata1, 2);
> > +                       break;
> > +               case HW_BREAKPOINT_LEN_4:
> > +                       hw->len = 4;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC_SIZELO(hw->tdata1, 3);
> > +                       break;
> > +#if __riscv_xlen >= 64
> > +               case HW_BREAKPOINT_LEN_8:
> > +                       hw->len = 8;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC_SIZELO(hw->tdata1, 1);
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC_SIZEHI(hw->tdata1, 1);
> > +                       break;
> > +#endif
> > +               /* Set to match any size */
> > +               default:
> > +                       hw->len = 0;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC_SIZELO(hw->tdata1, 0);
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC_SIZEHI(hw->tdata1, 0);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       hw->tdata1 = RISCV_DBTR_SET_MC_TYPE(hw->tdata1, RISCV_DBTR_TRIG_MCONTROL);
> > +
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_DMODE_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_TIMING_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_SELECT_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_ACTION_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_CHAIN_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_MATCH_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_M_BIT);
> > +
> > +       /*
> > +        * Match only the trigger's actual privilege-mode target. Setting
> > +        * both bits makes the kernel's own S-mode uaccess (e.g. SUM-enabled
> > +        * loads in strncpy_from_user()) spuriously fire a user-space watch.
> > +        */
> > +       if (arch_check_bp_in_kernelspace(hw))
> > +               SET_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_S_BIT);
> > +       else
> > +               SET_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC_U_BIT);
> > +
> > +       return 0;
> > +}
> > +
> > +static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
> > +                                    struct arch_hw_breakpoint *hw)
> > +{
> > +       switch (attr->bp_type) {
> > +       case HW_BREAKPOINT_X:
> > +               hw->type = RISCV_DBTR_EXEC;
> > +               RISCV_DBTR_SET_MC6_EXEC_BIT(hw->tdata1);
> > +               break;
> > +       case HW_BREAKPOINT_R:
> > +               hw->type = RISCV_DBTR_LOAD;
> > +               RISCV_DBTR_SET_MC6_LOAD_BIT(hw->tdata1);
> > +               break;
> > +       case HW_BREAKPOINT_W:
> > +               hw->type = RISCV_DBTR_STORE;
> > +               RISCV_DBTR_SET_MC6_STORE_BIT(hw->tdata1);
> > +               break;
> > +       case HW_BREAKPOINT_RW:
> > +               hw->type = RISCV_DBTR_LDST;
> > +               RISCV_DBTR_SET_MC6_STORE_BIT(hw->tdata1);
> > +               RISCV_DBTR_SET_MC6_LOAD_BIT(hw->tdata1);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (attr->bp_type == HW_BREAKPOINT_X) {
> > +               /* See rv_init_mcontrol_trigger() for rationale. */
> > +               hw->len = 0;
> > +               hw->tdata1 = RISCV_DBTR_SET_MC6_SIZE(hw->tdata1, 0);
> > +       } else {
> > +               switch (attr->bp_len) {
> > +               case HW_BREAKPOINT_LEN_1:
> > +                       hw->len = 1;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC6_SIZE(hw->tdata1, 1);
> > +                       break;
> > +               case HW_BREAKPOINT_LEN_2:
> > +                       hw->len = 2;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC6_SIZE(hw->tdata1, 2);
> > +                       break;
> > +               case HW_BREAKPOINT_LEN_4:
> > +                       hw->len = 4;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC6_SIZE(hw->tdata1, 3);
> > +                       break;
> > +#if __riscv_xlen >= 64
> > +               case HW_BREAKPOINT_LEN_8:
> > +                       hw->len = 8;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC6_SIZE(hw->tdata1, 5);
> > +                       break;
> > +#endif
> > +               /* Set to match any size */
> > +               default:
> > +                       hw->len = 0;
> > +                       hw->tdata1 = RISCV_DBTR_SET_MC6_SIZE(hw->tdata1, 0);
> > +               }
> > +       }
> > +
> > +       hw->tdata1 = RISCV_DBTR_SET_MC6_TYPE(hw->tdata1, RISCV_DBTR_TRIG_MCONTROL6);
> > +
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_DMODE_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_TIMING_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_SELECT_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_ACTION_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_CHAIN_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_MATCH_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_M_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_VS_BIT);
> > +       CLEAR_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_VU_BIT);
> > +
> > +       /* See rv_init_mcontrol_trigger() for rationale. */
> > +       if (arch_check_bp_in_kernelspace(hw))
> > +               SET_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_S_BIT);
> > +       else
> > +               SET_DBTR_BIT(hw->tdata1, RISCV_DBTR_MC6_U_BIT);
> > +
> > +       return 0;
> > +}
> > +
> > +int hw_breakpoint_arch_parse(struct perf_event *bp,
> > +                            const struct perf_event_attr *attr,
> > +                            struct arch_hw_breakpoint *hw)
> > +{
> > +       int ret;
> > +
> > +       /* Breakpoint address */
> > +       hw->address = attr->bp_addr;
> > +       hw->tdata2 = attr->bp_addr;
> > +       hw->tdata3 = 0x0;
> > +
> > +       switch (dbtr_type) {
> > +       case RISCV_DBTR_TRIG_MCONTROL:
> > +               ret = rv_init_mcontrol_trigger(attr, hw);
> > +               break;
> > +       case RISCV_DBTR_TRIG_MCONTROL6:
> > +               ret = rv_init_mcontrol6_trigger(attr, hw);
> > +               break;
> > +       default:
> > +               pr_warn("Unsupported trigger type\n");
> > +               ret = -EOPNOTSUPP;
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +/*
> > + * Read mcontrol6's hit1:hit0 field for trigger @idx. If either bit is set,
> > + * clear it in hardware (the Debug spec requires the trigger user to do
> > + * this; hardware only ever sets it). Returns the RISCV_DBTR_MC6_HIT_*
> > + * value read (RISCV_DBTR_MC6_HIT_FALSE if unimplemented or unfired).
> > + */
> > +static unsigned int mc6_read_and_clear_hit(int idx)
> > +{
> > +       union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
> > +       struct sbi_dbtr_data_msg *xmit;
> > +       unsigned long tdata1, tdata2, tdata3;
> > +       struct sbiret ret;
> > +       unsigned int hit;
> > +
> > +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> > +                             *this_cpu_ptr(&ecall_lock_flags));
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ, idx, 1, 0, 0, 0, 0);
> > +       if (ret.error) {
> > +               pr_warn("Failed to read trigger %d. error: %ld\n", idx, ret.error);
> > +               hit = RISCV_DBTR_MC6_HIT_FALSE;
> > +               goto out;
> > +       }
> > +
> > +       tdata1 = le_to_cpu(shmem->data.tdata1);
> > +       hit = RISCV_DBTR_MC6_GET_HIT(tdata1);
> > +       if (hit == RISCV_DBTR_MC6_HIT_FALSE)
> > +               goto out;
> > +
> > +       tdata2 = le_to_cpu(shmem->data.tdata2);
> > +       tdata3 = le_to_cpu(shmem->data.tdata3);
> > +       RISCV_DBTR_MC6_CLEAR_HIT(tdata1);
> > +
> > +       xmit = &shmem->data;
> > +       xmit->tdata1 = cpu_to_le(tdata1);
> > +       xmit->tdata2 = cpu_to_le(tdata2);
> > +       xmit->tdata3 = cpu_to_le(tdata3);
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UPDATE, idx, 1, 0, 0, 0, 0);
> > +       if (ret.error)
> > +               pr_warn("Failed to clear hit bits on trigger %d. error: %ld\n",
> > +                       idx, ret.error);
> > +
> > +out:
> > +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> > +                                  *this_cpu_ptr(&ecall_lock_flags));
> > +       return hit;
> > +}
> > +
> > +/*
> > + * HW Breakpoint/watchpoint handler
> > + */
> > +static int hw_breakpoint_handler(struct die_args *args)
> > +{
> > +       int ret = NOTIFY_DONE;
> > +       struct arch_hw_breakpoint *bp;
> > +       struct perf_event *event;
> > +       int i;
> > +
> > +       for (i = 0; i < dbtr_total_num; i++) {
> > +               event = this_cpu_read(pcpu_hw_bp_events[i]);
> > +               if (!event)
> > +                       continue;
> > +
> > +               bp = counter_arch_bp(event);
> > +               switch (bp->type) {
> > +               /* Breakpoint */
> > +               case HW_BREAKPOINT_X:
> > +               {
> > +                       bool hit = bp->address == args->regs->epc;
> > +
> > +                       if (!hit && dbtr_type == RISCV_DBTR_TRIG_MCONTROL6)
> > +                               hit = mc6_read_and_clear_hit(i) != RISCV_DBTR_MC6_HIT_FALSE;
> > +
> > +                       if (hit) {
> > +                               perf_bp_event(event, args->regs);
> > +                               ret = NOTIFY_STOP;
> > +                       }
> > +                       break;
> > +               }
> > +
> > +               /* Watchpoint */
> > +               case HW_BREAKPOINT_W:
> > +               case HW_BREAKPOINT_R:
> > +               case HW_BREAKPOINT_RW:
> > +               {
> > +                       unsigned long stval = args->regs->badaddr;
> > +                       unsigned long bp_start = bp->address;
> > +                       unsigned long bp_len = bp->len ?: 1;
> > +                       unsigned long bp_end = bp_start + bp_len - 1;
> > +                       unsigned long stval_end = stval + sizeof(long) - 1;
> > +                       bool hit = false;
> > +
> > +                       if (bp_end < bp_start)
> > +                               bp_end = ~0UL;
> > +                       if (stval_end < stval)
> > +                               stval_end = ~0UL;
> > +
> > +                       /*
> > +                        * Prefer tdata1.hit from SBI trigger readout whenever
> > +                        * possible. Fall back to address-based matching if HIT
> > +                        * isn't observed/supported.
> > +                        */
> > +                       if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL) {
> > +                               unsigned long tdata1;
> > +                               struct sbiret sret;
> > +                               union sbi_dbtr_shmem_entry *shmem;
> > +
> > +                               raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> > +                                                     *this_cpu_ptr(&ecall_lock_flags));
> > +                               shmem = this_cpu_ptr(sbi_dbtr_shmem);
> > +                               sret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
> > +                                                i, 1, 0, 0, 0, 0);
> > +                               if (!sret.error) {
> > +                                       tdata1 = le_to_cpu(shmem->data.tdata1);
> > +                                       hit = !!(tdata1 & RISCV_DBTR_MC_HIT_BIT_MASK);
> > +                               }
> > +                               raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> > +                                                          *this_cpu_ptr(&ecall_lock_flags));
> > +                       } else if (dbtr_type == RISCV_DBTR_TRIG_MCONTROL6) {
> > +                               hit = mc6_read_and_clear_hit(i) != RISCV_DBTR_MC6_HIT_FALSE;
> > +                       }
> > +
> > +                       /*
> > +                        * Sdtrig may report STVAL as the lowest accessed
> > +                        * address while the watchpoint can match a higher byte
> > +                        * in the same access.
> > +                        */
> > +                       if (hit ||
> > +                           (stval >= bp_start && stval <= bp_end) ||
> > +                           (bp_start >= stval && bp_start <= stval_end)) {
> 
> I think that using `abs_diff` here would be much less confusing.
> like so
> if (abs_diff(bp_start, stval) < bp->len)

The range check is intentional here. `stval` gives us the start/lowest address of the access, but the access
can cover more than one byte. The current code checks whether the access range overlaps the watchpoint range.

Using `abs_diff(bp_start, stval) < bp->len` only checks how close the two start addresses are. That can miss
an access which starts before the watchpoint but still reaches into it. For example, on RV64 an 8-byte access
starting at 0x1000 overlaps a 2-byte watchpoint at 0x1004, but `abs_diff(0x1004, 0x1000)` is 4, which is not
less than the watchpoint length 2. I will make the existing range-overlap check easier to read.

> 
> Thanks,
> Jesse Taube
> 
> > +                               perf_bp_event(event, args->regs);
> > +                               ret = NOTIFY_STOP;
> > +                       }
> > +                       break;
> > +               }
> > +
> > +               default:
> > +                       pr_warn("Unknown type: %u\n", bp->type);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> > +                                   unsigned long val, void *data)
> > +{
> > +       if (val != DIE_DEBUG)
> > +               return NOTIFY_DONE;
> > +
> > +       return hw_breakpoint_handler(data);
> > +}
> > +
> > +/* atomic: counter->ctx->lock is held */
> > +int arch_install_hw_breakpoint(struct perf_event *event)
> > +{
> > +       struct arch_hw_breakpoint *bp = counter_arch_bp(event);
> > +       union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
> > +       struct sbi_dbtr_data_msg *xmit;
> > +       struct sbi_dbtr_id_msg *recv;
> > +       struct perf_event **slot;
> > +       unsigned long idx;
> > +       struct sbiret ret;
> > +       int err = 0;
> > +
> > +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> > +                             *this_cpu_ptr(&ecall_lock_flags));
> > +
> > +       xmit = &shmem->data;
> > +       recv = &shmem->id;
> > +       xmit->tdata1 = cpu_to_le(bp->tdata1);
> > +       xmit->tdata2 = cpu_to_le(bp->tdata2);
> > +       xmit->tdata3 = cpu_to_le(bp->tdata3);
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_INSTALL,
> > +                       1, 0, 0, 0, 0, 0);
> > +
> > +       if (ret.error) {
> > +               pr_warn("Failed to install trigger\n");
> > +               err = sbi_err_map_linux_errno(ret.error);
> > +               goto done;
> > +       }
> > +
> > +       idx = le_to_cpu(recv->idx);
> > +       if (idx >= dbtr_total_num) {
> > +               pr_warn("Invalid trigger index %lu\n", idx);
> > +               err = -EINVAL;
> > +               goto done;
> > +       }
> > +
> > +       slot = this_cpu_ptr(&pcpu_hw_bp_events[idx]);
> > +       if (*slot) {
> > +               pr_warn("Slot %lu is in use\n", idx);
> > +               err = -EBUSY;
> > +               goto done;
> > +       }
> > +
> > +       /* Save the event - to be looked up in handler */
> > +       *slot = event;
> > +
> > +done:
> > +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> > +                                  *this_cpu_ptr(&ecall_lock_flags));
> > +       return err;
> > +}
> > +
> > +/* atomic: counter->ctx->lock is held */
> > +void arch_uninstall_hw_breakpoint(struct perf_event *event)
> > +{
> > +       struct sbiret ret;
> > +       int i;
> > +
> > +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> > +                             *this_cpu_ptr(&ecall_lock_flags));
> > +
> > +       for (i = 0; i < dbtr_total_num; i++) {
> > +               struct perf_event **slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
> > +
> > +               if (*slot == event) {
> > +                       *slot = NULL;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (i == dbtr_total_num) {
> > +               pr_warn("Breakpoint not installed.\n");
> > +               goto out;
> > +       }
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UNINSTALL,
> > +                       i, 1, 0, 0, 0, 0);
> > +
> > +       if (ret.error) {
> > +               pr_warn("Failed to uninstall trigger %d.\n", i);
> > +               goto out;
> > +       }
> > +
> > + out:
> > +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> > +                                  *this_cpu_ptr(&ecall_lock_flags));
> > +}
> > +
> > +void arch_enable_hw_breakpoint(struct perf_event *event)
> > +{
> > +       struct sbiret ret;
> > +       int i;
> > +       struct perf_event **slot;
> > +
> > +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> > +                             *this_cpu_ptr(&ecall_lock_flags));
> > +
> > +       for (i = 0; i < dbtr_total_num; i++) {
> > +               slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
> > +
> > +               if (*slot == event)
> > +                       break;
> > +       }
> > +
> > +       if (i == dbtr_total_num) {
> > +               pr_warn("Breakpoint not installed.\n");
> > +               goto out;
> > +       }
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_ENABLE,
> > +                       i, 1, 0, 0, 0, 0);
> > +
> > +       if (ret.error) {
> > +               pr_warn("Failed to install trigger %d\n", i);
> > +               goto out;
> > +       }
> > +
> > + out:
> > +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> > +                                  *this_cpu_ptr(&ecall_lock_flags));
> > +}
> > +EXPORT_SYMBOL_GPL(arch_enable_hw_breakpoint);
> > +
> > +void arch_update_hw_breakpoint(struct perf_event *event)
> > +{
> > +       struct arch_hw_breakpoint *bp = counter_arch_bp(event);
> > +       union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(sbi_dbtr_shmem);
> > +       struct sbi_dbtr_data_msg *xmit;
> > +       struct sbi_dbtr_id_msg *id;
> > +       struct perf_event **slot;
> > +       struct sbiret ret;
> > +       int i;
> > +
> > +       for (i = 0; i < dbtr_total_num; i++) {
> > +               slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
> > +
> > +               if (*slot == event)
> > +                       break;
> > +       }
> > +
> > +       if (i == dbtr_total_num) {
> > +               pr_warn("Breakpoint not installed.\n");
> > +               return;
> > +       }
> > +
> > +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> > +                             *this_cpu_ptr(&ecall_lock_flags));
> > +
> > +       id = &shmem->id;
> > +       xmit = &shmem->data;
> > +       id->idx = cpu_to_le(i);
> > +       xmit->tdata1 = cpu_to_le(bp->tdata1);
> > +       xmit->tdata2 = cpu_to_le(bp->tdata2);
> > +       xmit->tdata3 = cpu_to_le(bp->tdata3);
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UPDATE,
> > +                       1, 0, 0, 0, 0, 0);
> > +       if (ret.error)
> > +               pr_warn("Failed to update trigger %d.\n", i);
> > +
> > +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> > +                                  *this_cpu_ptr(&ecall_lock_flags));
> > +}
> > +EXPORT_SYMBOL_GPL(arch_update_hw_breakpoint);
> > +
> > +void arch_disable_hw_breakpoint(struct perf_event *event)
> > +{
> > +       struct perf_event **slot;
> > +       struct sbiret ret;
> > +       int i;
> > +
> > +       for (i = 0; i < dbtr_total_num; i++) {
> > +               slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
> > +
> > +               if (*slot == event)
> > +                       break;
> > +       }
> > +
> > +       if (i == dbtr_total_num) {
> > +               pr_warn("Breakpoint not installed.\n");
> > +               return;
> > +       }
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_DISABLE,
> > +                       i, 1, 0, 0, 0, 0);
> > +
> > +       if (ret.error) {
> > +               pr_warn("Failed to uninstall trigger %d.\n", i);
> > +               return;
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(arch_disable_hw_breakpoint);
> > +
> > +void hw_breakpoint_pmu_read(struct perf_event *bp) { }
> > +
> > +void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
> > +
> > +static int __init arch_hw_breakpoint_init(void)
> > +{
> > +       unsigned int cpu;
> > +       int rc = 0;
> > +
> > +       for_each_possible_cpu(cpu)
> > +               raw_spin_lock_init(&per_cpu(ecall_lock, cpu));
> > +
> > +       if (!dbtr_init)
> > +               init_sbi_dbtr();
> > +
> > +       if (dbtr_total_num) {
> > +               pr_info("Total number of type %d triggers: %u\n",
> > +                       dbtr_type, dbtr_total_num);
> > +       } else {
> > +               pr_info("No hardware triggers available\n");
> > +               goto out;
> > +       }
> > +
> > +       /* Allocate per-cpu shared memory */
> > +       sbi_dbtr_shmem = __alloc_percpu(sizeof(*sbi_dbtr_shmem) * dbtr_total_num,
> > +                                       PAGE_SIZE);
> > +
> > +       if (!sbi_dbtr_shmem) {
> > +               pr_warn("Failed to allocate shared memory.\n");
> > +               rc = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       /* Hotplug handler to register/unregister shared memory with SBI */
> > +       rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                              "riscv/hw_breakpoint:prepare",
> > +                              arch_smp_setup_sbi_shmem,
> > +                              arch_smp_teardown_sbi_shmem);
> > +
> > +       if (rc < 0) {
> > +               pr_warn("Failed to setup CPU hotplug state\n");
> > +               free_percpu(sbi_dbtr_shmem);
> > +               return rc;
> > +       }
> > + out:
> > +       return rc;
> > +}
> > +arch_initcall(arch_hw_breakpoint_init);
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index f8292adda099..1b9ccc0b6b8d 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -287,6 +287,12 @@ void handle_break(struct pt_regs *regs)
> >         if (probe_breakpoint_handler(regs))
> >                 return;
> >
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +       if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP)
> > +           == NOTIFY_STOP)
> > +               return;
> > +#endif
> > +
> >         current->thread.bad_cause = regs->cause;
> >
> >         if (user_mode(regs))
> > --
> > 2.43.0
> >
> 
