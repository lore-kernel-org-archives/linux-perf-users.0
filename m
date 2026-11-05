Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793856807;
	b=pV5HFwGBfJiJP5Xx1zMCKgo2lcgfXVNAvmVrFmAAYgx4VDFcGXluy77QfxjgdiRPBdtV
	 SpdY+3eT209p9og3x91+kz4DB6dKtrf8uTIq5ONHr15ML2YK0DFi08EMBbBuNeTdmOJGt
	 NGgsdqiEcxI//MJTXLp7exKL5aZE+3lIKqmc2jr9kBpIM9vHZ1FSpodYMD/929FAbm9sB
	 8u8RdLaMAqGNBkXNAy2KMXfnYhxEYAGyGEpsFZPdOPgq6dx7dcK+Ap3PhaRMsUJCkxRVC
	 YSHbTLH47AeWjGTvc9UOPE3jGP9zdTlvmF6xnV595YCCmXv0tarVClMrHVVel8UifaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793856807;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mnfDP717xLwdYJ0ae4AGWYEs+tKg8ErO9fE7F09ythk=;
	b=fwF2Hs7t7E4YyG3/OV0xZ0dLqf6uUyiXarbUpYuq1r2Zrg752+APFF9Lh6VXWFfKJ3/S
	 YqF3jfbgiN+eKtYKWYxcJMz0nzoaM+FQZoG+XXzMogCrLZ9GGcyQWfTAKqVjE0OQF7Zqg
	 X0ZDEoaujsJ1vUNSFn2jpkvQLFBjLsRO51cdKe2X/ONosPtJYbfDHxRhg6f9rEYomXMnz
	 NPY2o2DB+zgPNghBjulGhsrxYrPFFL2F2nTAmHUjwHcQe7HNmdyX9Zp6G+IGpTg8h7Ee3
	 39E20Ok4//ignZvb4CTqi2Yj0+7vmHxuLPYrUQNso3NLMDsRvkq2glmPMAa97Nqq7vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VEyKhNh4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5abHxnb;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A79606A328
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 05:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42A79606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VEyKhNh4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5abHxnb
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A50oa8A4051648
	for <linux-perf-users@vger.kernel.org>; Thu, 5 Nov 2026 05:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mnfDP717xLwdYJ0ae4AGWYEs+tKg8ErO9fE7F09ythk=; b=VEyKhNh4XXvkgpDi
	OMY2Y+5ggSH1HM5rU4kWJvRos5uJxhl/RN4lJr52oZyv8/3b8UEtB4BwqGUafpyk
	1eutvG83UEqM2gScVG4kmNznp5PVhqbzgt5QKY6Pk80q7NhBTkWy8+R2RN2INifm
	g1gG87ueC1DtSMDD+5qzQWNyGRbyi7J2Dtcvv+u7g0Ki0ISj6YYV1Q8p3G6jRSPz
	9pY/6T6RMFQtDnQ+FctTMVy4H9OxY83zAfkvXZwpXX7t+xpZ7WW0tqD6BE2nass5
	+KuASWtbBJ7zFmT/7m0UWSSijVWPpPGKxO2LTBPBxRaTWEpxBp9LaEsBleP+er26
	2oZEwA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr8rv2svg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 05:33:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36de26cb4b3so865341eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 21:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793856805; x=1794461605; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mnfDP717xLwdYJ0ae4AGWYEs+tKg8ErO9fE7F09ythk=;
        b=L5abHxnbDd8SsTyHgMh5VAaOU8GbYOjmmrjIad9gINHFXB+OLBkmKmf3iWKW2ib3t5
         3WdPsH4mV5+nsjX0v+8pMp2776olDA/IErVHuGOYnyzWY5RFqWgAC6uiYy4R/S7ev9cw
         /GtvFZxyHLbICIQdfWaSf+2+IyKo3A7mgIS+YwtCcrrKz812j4A9z5yyHCGd085F/naZ
         2k9h1uXJeAfJfKz/76qVh2MRnUnWsq/xi8lE41mI/O97dITtF3Uoab8AHLvJf89l2Gy2
         OPSC3CD+zdLnITSpPConqCYMSQzZKhUbO4DI/nbQbd2FWTJ2NcFr/1ZlLTz1e6I/ZRkN
         JsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793856805; x=1794461605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mnfDP717xLwdYJ0ae4AGWYEs+tKg8ErO9fE7F09ythk=;
        b=YSogB2xlqCRSv2ELoIeNfUkwq/jRDzBBpBGCtARQFSUnDiZIT1SJKzx43D0IjDFZK/
         OU0Qc3EWcHdDoaMoYg7J2ZkQBGrmOm/Q6hOCj5lkLMA6dCJJ78LOlwttSzjsFtXysg5r
         2/w0zd5es+BLQVakG1e6TnDMtQchkKV6b/toxIK5l/Ox28dekKN7JMGkpb56S3YXaj+u
         Pyvf/c0bqgMaUdzZEqpJsfJ8YxvGu5UcZ4qOLrlzoCmp9F39HE/lYRf3/zE7BHHAGI7p
         epZHFsAqhuDO/vnomyVhE5+Y+/eBiB0PTmGqwFl3wud7NmLZ0CyjykmvapuIq8fkxRQ0
         XZaA==
X-Forwarded-Encrypted: i=1; AKwUvBxfXnxAwie/OMazdHZHQebqPrFZbCnZ9Vf4x37j3snqzrNWDLJZAJFS6Sb+D+27Njl1ptaeKqHRcrI6Hk9MkDZV@vger.kernel.org
X-Gm-Message-State: APuU4Z+dNOJKFChQSPgaPmnYDdoMd1I4p4Gw1wi6Crodg2XxrgJJlwVC
	MtASLsvo3Q5Ryk3R4xekxl8guEaca/v1kPUcd+Q5mzjiUQbk6oDxxrEQBHJi8ySL7R8jFZ7jOGC
	FGxJ3L+cNGTmg0p6h3T/Gh1mH8ZB+W5ycWuUVdmmVlfs++/goo1utNsPAoIs4frOw845gu7zYiS
	Xv5lFe
X-Gm-Gg: AYBFou3SWegNfp3YJriaOq4vc/ekw2NEUljfVrlSi7Rov6wA6WVwDk+sX1iEAK+/ikB
	i+FlXXA4syVh/W5Z54LBw9O8rdje2ldMqHoyugJ+mchXuiKUPDLnaLG0/T4U1tc7c5mRJGwe5VE
	+mn8srWbkwWxuLGNDKXw12jzWlVlOHcFwbPoG1vpLi7RYQ7IQ9CNxZGObeCGFiGixa/1ws1Xmsk
	ut/9KG9NmFKIVgf6RAb+9EW2CX7+cEBH/QQ5BWbgmPjUZVbd6Czo/uMJsBhBPC1Dn+IZ1HGj2LS
	NvPlirq8nWv+O+TOb/JzojIiQ7IRDEMw3x9Tf1NnurfwLlSryP8Hobnu9K21zmC1j8kaeYsdG3R
	k/nQ0JnhDzbCFUxyea/1kprL8cNZSIkkP6OIUe3EofamXrmJ4cM41moJ8ADgCTpKWFeV9plYd/F
	2WIT431Wt1ypreFQ4pH0PfXbzbLrwqswgmBECfNxv8DHwL0jPxzSErewJs7Do8dbJZGPMjpBt0
X-Received: by 2002:a05:7301:db8a:b0:36d:394d:e690 with SMTP id 5a478bee46e88-36d395d342amr3970078eec.40.1793856804918;
        Wed, 04 Nov 2026 21:33:24 -0800 (PST)
X-Received: by 2002:a05:7301:db8a:b0:36d:394d:e690 with SMTP id 5a478bee46e88-36d395d342amr3970038eec.40.1793856804160;
        Wed, 04 Nov 2026 21:33:24 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm12148541eec.15.2026.11.04.21.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:33:23 -0800 (PST)
Date: Thu, 5 Nov 2026 11:03:16 +0530
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, pjw@kernel.org, qingfang.deng@linux.dev,
        shuah@kernel.org, thecharlesjenkins@gmail.com,
        cp0613@linux.alibaba.com
Subject: Re: [PATCH v7 7/8] perf tests: add noinline to __test_function
Message-ID: <auwVHAC4iPfdXD4c@hu-himchau-blr.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-8-himanshu.chauhan@oss.qualcomm.com>
 <CADRr4bctCf-7xBER1G2vqtQm2Nda+h222UzYShMQXw+rtBwPzA@mail.gmail.com>
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
In-Reply-To: <CADRr4bctCf-7xBER1G2vqtQm2Nda+h222UzYShMQXw+rtBwPzA@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=Vtm2kO2n c=1 sm=1 tr=0 ts=6aec1526 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=3ntduUHgHJ2MHpqTwYcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAyMSBTYWx0ZWRfX9rEOT6n2287O
 Pb1D7QVvgGcZEOIQgC/u1NVrkRvm0CB3uGpRUpdVzswyWIYzZs19X/DtWDWTzpjdImCAZbLo+f6
 MdusOzt+bk6cp0mnfQGSn1Mhs7r+/YU=
X-Proofpoint-ORIG-GUID: gchUYMwUjxtwsZAULzuRaTLXp788fX70
X-Proofpoint-GUID: gchUYMwUjxtwsZAULzuRaTLXp788fX70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAyMSBTYWx0ZWRfXxV020y+oJxAp
 RlYbg0EL3HfKbr8mrOJldauzZ08sEXgmdePktiW/f5K30kk8ZncHAkDjPsetDX7QpO0RRbn52pu
 i7DJIxS0cVy2dWuemMUhcnQZmvPYN4qg6OErFY6KZyBbAgni1Q9r5oRDyjB42FalLCRam0L6OYu
 hTyzge29LlCgeXH7luROX1WjQhlnuPR8fE3yhofw3kMlZuqDiplr0N3nMVVmyQuZKZKySytcGA7
 zOKShhWO+3kX5NlT9jq2GnIpKWBlBq0DxjOdY93TO/16KNeZKiIWERzNgWxm6AsUJr1N2M9Tyip
 kDXxKWhwam0aN+vGbe4rnC5sFHevGMumpFxifmsUqLRxfBR3PdPVIjQC7BgX+y/VVKtzH0xptjc
 MEOmi2qay7hx0/Aa6Iruj6C0sxfV8zYieV+yenP3EgRRUCg0m8CYVAVyEnvmdZZdVPISJpwEQh1
 KcGV6ywdKc0XwCuj8bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050021

On Tue, Oct 27, 2026 at 03:52:20PM -0400, Jesse Taube wrote:
> On Wed, Sep 30, 2026 at 2:40 AM Himanshu Chauhan
> <himanshu.chauhan@oss.qualcomm.com> wrote:
> >
> > In the breakpoint signal handler test, a breakpoint is set on
> > __test_function. Compiler may optimize and inline __test_function.
> > This causes failure in the test.
> >
> > Add noinline to __test_function so that it is not inlined.
> >
> > Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Reviewed-by: Jesse Taube <jtaubepe@redhat.com>
> 
> I would resend this to the perf list and not in a patch set as it is a
> separate fix.
perf list is already in the To: list

Regards
Himanshu

> 
> There is also another fix to data_breakpoint.c‎ that i have been
> meaning to send here:
> https://github.com/Mr-Bossman/linux/commit/db4faa52a66f6b7265cd397a2d44d7d38c3fdfb7
> 
> Thanks,
> Jesse Taube
> > ---
> >  tools/perf/tests/bp_signal.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> > index f580ba7486b1..cc4a27224884 100644
> > --- a/tools/perf/tests/bp_signal.c
> > +++ b/tools/perf/tests/bp_signal.c
> > @@ -54,7 +54,7 @@ asm (
> >         "ret\n"
> >         ".popsection\n");
> >  #else
> > -static void __test_function(volatile long *ptr)
> > +static noinline void __test_function(volatile long *ptr)
> >  {
> >         *ptr = 0x1234;
> >  }
> > --
> > 2.43.0
> >
> 
