Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AF385D6E;
	Mon,  1 Jun 2026 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299220; cv=none; b=OTk5lbMw0auF0+VcHicQGjmOch10cQMOZ1P53lXHwVfign8qRdXTNzH3hhnfPNSyYwV7ypNW1rYW+U8IUHjgJM919vUp2ED0d6JwqGl47DRdriyto1rs/v0RBpNzYL+Q8Gwd75KmLLVKDOUflzAiuuCnUIMz6wop3uTxPCu4veI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299220; c=relaxed/simple;
	bh=uS8SVGAcwmWAVe8/w13kUsNvmpdPZ7XOzo21Ab+ySqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEZXjRHWPjwCW/mFc07sR1zg03Csa7XzBkHysoCamNsADHy/S5Dv2pB3LKNYBEHNERXaINkWzNBPXPbugvz1ezgZxgwf75TrLvV2cXRm4Z0vkx5mCzT+l4cPCC4ga3jzvBdeUCldnY/3wqB0MGDNMtMwT1TiweOfkSixWDzgtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=L70mGwZ6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L70mGwZ6"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLpD8M1007224;
	Mon, 1 Jun 2026 00:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ysX8HVe5tI0y8KixQmCJcom7R
	XVurl7yJ/4ljZeiGh8=; b=L70mGwZ6ZGH172jiqSkJmz3SG+Rgeg8CYOf3PraLU
	LIvQebe793ffoClrtnrdt2K9wg2alXjDJnjN1Z3pUXNY05xMHt7gVeruAdVZHjVI
	nAcPgCFOlY41CCJ5+RiM2F7Bne2Z7UeA9JJUKzObvObysCUUKTzDbtuzihWoWpc7
	6turwA6d+gOB+GW5L7dEIZ7gzROhF4PDdHsEOboEN8wfKYEz1L/eaAW1B3PT1WLv
	fN/MTxs0E+s7jZhHllL1oZh/vR8JfoFfjwu5QxdP9R2UC2qT/n+CBpOh/oFHBKhM
	ju7wZel9jurM/PHR28sy9YieaOK+b9Csan53isklEfKuw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4efw8hw76b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 00:33:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 00:33:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 00:33:31 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id ECE8F3F7082;
	Mon,  1 Jun 2026 00:33:28 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v8 3/3] perf: marvell: Cancel CN10K DDR PMU hrtimer on device remove
Date: Mon, 1 Jun 2026 13:03:18 +0530
Message-ID: <20260601073318.7098-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260601073318.7098-1-gakula@marvell.com>
References: <20260601073318.7098-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA3NSBTYWx0ZWRfX2k8a47EXMGhQ
 x3VEZO9QbSoe8fgA5vxrxQH8ATjXXakMeA7G/1nNomco3kkBzpMIici4EWLcq+Um95gA96TFJ3g
 /C66ZaMGhLsYt1DnZ6s724EVuhAxvzv+wz1mahfW1RKELqb1URRd1dLuqREhKPAdb69HiMNCq5W
 h2FTVEG9FSfJUARQi0FxA+ih9uK+c7fvUPt2eLCMLhbDcl5I2/nTmQ0XBM3yzgFkMvG3r82y2ri
 tNE/DDwiQeUlfRYLgKZIx8UjIjrABGKfYn/hWXN2Xh19Olsh8leRtNEciD9D4XpwBsDG5G923Vo
 JEJ+3KP9pdWOwI30hOuwYQeWS/3sFRUDYPj7fzoa7fxr7OTfywPVaOb6QFpL9ix3uV4SDC0qvg/
 GOxRZkDbeRu5ckO1WAS/5k0JYp+IC76IRfrI9bGYOEsPfXMTPoid2ne2zZTJKC4/ZaVb6vXSwbo
 Zjekkc81U4FhfW3EgYg==
X-Proofpoint-GUID: stzZQ0fRULCmDkINP2iZGQPWSZN_R5e5
X-Proofpoint-ORIG-GUID: stzZQ0fRULCmDkINP2iZGQPWSZN_R5e5
X-Authority-Analysis: v=2.4 cv=F99nsKhN c=1 sm=1 tr=0 ts=6a1d35cc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=u0CBKMH8rBo-bx1LD9MA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01

cn10k_ddr_perf_remove() did not cancel the poll hrtimer before returning.
If the device was unbound while perf events were still active the timer 
callback could run post-free.

To fix the issue by adding hrtimer_cancel() in remove().

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---

Changes in v8:
- perf: Cancel poll hrtimer in cn10k_ddr_perf_remove() to avoid use-after-free
  on device unbind (pre-existing for CN10K/Odyssey).

 drivers/perf/marvell_cn10k_ddr_pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 6f638dfe829b..9c82bf4ee2c4 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -1284,6 +1284,12 @@ static void cn10k_ddr_perf_remove(struct platform_device *pdev)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = platform_get_drvdata(pdev);
 
+	/*
+	 * Cancel the poll timer before further teardown so the handler
+	 * cannot run after this function returns.
+	 */
+	hrtimer_cancel(&ddr_pmu->hrtimer);
+
 	cpuhp_state_remove_instance_nocalls(
 				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
 				&ddr_pmu->node);
-- 
2.25.1

