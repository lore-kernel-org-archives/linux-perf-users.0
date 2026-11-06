Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793960613;
	b=aq6sDWrIOxltXx4KkBbgWxKcNkVi46KDqfdn8W44A3IBlgNYGFakOJPA+s0RN7lnEF3i
	 bt3NASRgVNbL89Eq9nNYAiY+HBEvGR2rZcnXBj5qx4o6MYGA2cUBlO4hD0q/wA7HcAd7w
	 6buhYWA/q3bJGVIfdK77S2MDIf0B5rkdh28EA/sQQA+SYCVO0jXVVCE8ZJMM0GxhueqSv
	 +5ddEdjUeCepaZiTWoyGSLjxkMsqMtDYRw6opD895Lcpo6ouepAbPsenZdlparIPMFwLH
	 njSpLhxSIqQp2CcGu/9wiSsIoX89XBhSoyfSt/YFrVq1Nqpf8aZuGivRe72C9D13CrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960613;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Content-Type:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=nrdTTujUxoUHK25/DPCOTtMUo3zRWiBHcYoy8Q677ZRMJr0tBnNFFk6VID4hLYzh9aN/
	 2H2gKdXmtWvz7toAZjgnrnUqrhK+6RIykB6n9VuV9QALtUSdkcBhtO7KiT+ba7ysnCNDG
	 6YcOkSkQaPoYcE/jfB2v9B+PnZhfwiM1jlJPcNW7vECVG9icGTQHzHxMIZLzU0GEB/NJE
	 +nOIzxQe07eExR6U5LRQKbrcPGFUcqBATIzyjipy2iD9Bl3yZMuDjbAtUMXhS59vDPl1w
	 0ULTbMvpGmb71zI4WpKPGfGiJWfqa6M8k1RwgQ2YIa3RgSezIOsQTdcGDO9X7vLEngw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BxMNcMM0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BQwCW4PV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E7606A331
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944E7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BxMNcMM0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BQwCW4PV
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67R68Q3243860
	for <linux-perf-users@vger.kernel.org>; Fri, 6 Nov 2026 10:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=Bx
	MNcMM07aCHejXMWv/5LIquefi6vnQd7ME6faVyyu+EpSXb3u41pxD5vofEeUxJiS
	Yr1503BYDm2/G7jJQBIp77gNlVBUHbEVb7+JLCD2aF9l5zfRq/QUOdoowDcqJB5A
	unJCi1ram8QL7SsAnMO2nCDP0kk2+pUandum2C7mvne65+T01ltfihkzVvwBFf/U
	Mk2APD9sByM3E6ecZ0Ou2ZB8Wna8ufOrdIHtuMR7Ud8lz2E/IRIWNiokS4R2+mXx
	+jo9wlAqS+U3wvj8sIgwDu1BjCHHoXyzGtZ7OUnaIMCWBNY2NLD2wup45pI7ZIZR
	KcGCpKXs06hK0j6rVjxw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa2a9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 10:23:31 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4ab90cdf747so1921648fac.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 02:23:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793960611; cv=none;
        d=google.com; s=arc-20260327;
        b=lYlj5vBdg+WLQTJBLFgajKGQM4ZrqAAcWVTrfa+Da57ISi9roWgAuizm/i8fg1c/d1
         4dBv4/KEUhHuqTydN+ANUiI8QmSmEa86XjteRmPVj/KlG5uajTXJUMybdiYCLssIxS6s
         V4/Wl3+G8ZThFg2rYwXc2GOYyMG1uqMQ+faXJqMEXeS3zIYtMk6WPADBoXf8n48tJkJu
         RVla1V3pdYSZj0mtgWSdrBD7/11vEW+jWsvT/yk1RDORAO7VQLOf4pxcyAOm0/GAF60w
         rhlClN8pqzx90Bdt7lATgts45w0vVYQcirYbPcued8N6GCowobrYiEStnG0x1rzK+ZeP
         6+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        fh=gIcXGLotfzO2ZmnEhSjFNq+ft2UaQ90WGwRr7ybmEa4=;
        b=Z/HdnwNewCepEUjTA4TV2HrQ6AJiL47+Uz2ZzfFAz6Bx+ztzMmbmiguhOmw5rdpFlq
         kcl0r9tUMNKBuiyiIKOo74LYdQuwP0MnHMmpPNEgX4SL5UR+otGRZ7LeEgjR460LQ9JS
         HxSK2FXr8E1dyIv7AZAkcwVwe13I+Bv38JRiKfi3cGUtyB5/3yfM+byrHMW4+7lojUTY
         dwXPXrzcvCluHeTazsR9OsCu5fRs+u+06kZ0F926ETaoi2BrfVhIOv1QDIirdf2gMsjl
         QzevleIxc1Gb0ZLA9kpYGU9kVjj+1K39NqtZGB14MsW0d3JvSefDpXonQdtbwfeIBWdA
         UDqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793960611; x=1794565411; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=BQwCW4PVqH2EeN5aBNA+elPwUNon3pVbl5wlwxoNSi9Q7p6/c81/wtgxWHzeRrpoC9
         CwRScRQLfsTtcxYwS+qTjC3/9+Rl7mzV3pHHPjB5RpDpdwqdmqro5CilATuJ3wwgBGkt
         9//j7cBqD5RpEC104JGR+7KUwdKWIVcAqm8YnsseiBjWvfQN9RRvC6yYt5W/w+3u386f
         pRb+x+lV28w2vwkGMHqfbodr0m//8jNr3PgKvW4nho0aeMUxE0qluX/ayc7otKC9bTYM
         CFmnIOBkTLELZg2PzXQeMckMOpAuXHtCbEK+BHl/Oy6dia+UOC7BCtGTF9JIMioaxxPx
         FIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793960611; x=1794565411;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=JGN4pU6BF01wyDPQnepaPLKcSXfcYMXTMl0i3d0YS/JI7kvg8Mv+Xdj2WVnAqjd2j3
         kQhZyfm1Pt1LMbzt6PPUEYW/oD501wgoOe9H3y3/j4aF6nFEJU12YIxn6JRC1uJ/g04T
         t4DXu7XYbxSIfeQiP117azGAZ3Jqn94P+aIYhh9Lj4/93zgLW8WgC09u5FvazCec8w0V
         /Nctcv5aWGOU0XgZ/HfZradCKHroJWBY5Rut6tV73dIYTPXLDq2fhZaKbfu6j7j51mg+
         zuMuttOrfZXKeaOx/k7R6RR+XiJCJDeEilK/KLEjVWERp/m05ay4vnVqyynjkStcyBU1
         5zyA==
X-Gm-Message-State: APuU4Z9h+NvbIGUwiYxaxQjUTDYkPw8VcDxoiP9v2Q4xHwwvp1BHAN/c
	E0/IdHslztapCdsH+1l6q/kzfrleh0iU+BlEvBKnCmqoZEIqU+uUPq0xv9Z07XsC9S+K5tvX8Jm
	6A8U1RipVfab2/mk7uVnieiqs6PH/+jEGpG6P3L8l0g3XXE9ybg5+yVHAYNojTqrCIfmFmT5InC
	WORzH2BNxgoe2lVgwMcYS+6PCH98zhtqzmqfOPx7NizEKzI52V3AyAOYQ=
X-Gm-Gg: AYBFou3XKmSx3cP/BdGGBBoEqj/vsUHNKSfzBt2E9bZD1IazXI2/zDgIlkmLYKS0cxl
	pFTlkGkS+EA8riNh8WfgnVxV6IFqokcJUbUOpYDykqi8jXu4v3XCey9vyuepasF4XDEZ3Q3NZla
	yPogYyBqatqctxbsX2aF7KAPTmaslBm8yhso6P8W6KeBCG/MPe+YxXL9z+Bhc=
X-Received: by 2002:a05:6808:bd2:b0:4f5:214:fb96 with SMTP id 5614622812f47-567be70c834mr2969848b6e.42.1793960610880;
        Fri, 06 Nov 2026 02:23:30 -0800 (PST)
X-Received: by 2002:a05:6808:bd2:b0:4f5:214:fb96 with SMTP id
 5614622812f47-567be70c834mr2969843b6e.42.1793960610397; Fri, 06 Nov 2026
 02:23:30 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 15:53:18 +0530
X-Gm-Features: AclHuK_fScMZpdJKSmCOHXdKs3Q1qiGPSQ-2bj5UpxtXDcESJhtqBVwtHIyD1L8
Message-ID: <CAAFPZesg4yoa0EWMNJ4u-qJFu8GB11bKWYYF+CPRhRDQVmQxxg@mail.gmail.com>
Subject: 
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aedaaa3 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=tclcd6dtLQvEqt9_mmAA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22 a=xo5jKAKm-U-Zyk2_beg_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0MSBTYWx0ZWRfX1YapkT9XuIxq
 Z/shewOS35FCLTd11lHd4x1wfurJ/pRbUru5UfCrKh2V/JImk8pMHgE8R44N77K40bzAs3i7P7K
 7kvxTfY1fbCQsPcC93mKd74/X/2viU8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0MSBTYWx0ZWRfXyohoZD5kSL68
 q2BoTu6KWf/LNyQsJprBRXv5HWJwRBzJm6pgvhJKwW7Q2+PhW56QSc0HlUMZPvPxZKwEuooZqwf
 Bo54M0wbSdWE1a+3Nhya1/Tvo/DFhMe+7nDmUIJWnH9U1bHRtPmv5o3hC0u2yIQauv9KP4qR1hn
 S1j0SItD6WJSxLyTFHoXey+gJPy10cfg0kl67hGu225yDndowvY+zkNK9rTogdCcoGreWet8TdU
 n5ZFmq2aqHC26xucGbQ+NT1SEqrkGzhVGmcEjNXz2fJGC9hLqjlLrt1HDJ3R2iIi7UwCvXaIzHS
 gumRlxhSKIlNhkjlXI/Tbj0L77eFW9P9d7lee2+hg7wMxd9kU+kXAR5JGffPJ2DDagHGK/WLcz9
 Ji7SO0gnYUldhyXTp3dCuSHXJtDeDbsQqkZdztpyog2SPbaYj+dbQK39wlV02HVfPpLio3s6mrc
 R2ElR6FqrAdpQtkKlxg==
X-Proofpoint-GUID: 6WknpUVFRlcjxJvnoW2v2VtN___gX2UM
X-Proofpoint-ORIG-GUID: 6WknpUVFRlcjxJvnoW2v2VtN___gX2UM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060041


