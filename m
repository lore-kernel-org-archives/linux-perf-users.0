Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92A42EECA;
	Mon, 18 May 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108671; cv=none; b=hbdryAbMzZJpKEUjviYpSbwMLHEHs7QSmaAVat+3VTm8rYeNaClePcxPXIyp1arSv8m/Fa/5fZYdvwb/TIQb06qsjN8h+OstHj2ILgF/xPCh+aT4Ma0sM6kAS7qHUrMhA1TTgmooCW99Ya10n9WEfq5KTT27Bh5zXAFvvlumiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108671; c=relaxed/simple;
	bh=Qof0h8jYnHnNYcE9Sg1gUvSli2Vh68tyXlFtMXRYrlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hsr9UztlgYYRXX7+6vlMoZGSYOOJYQ3kLwrlFbnj5y5fdTVVAWnKxz07LlvlyZWF7LjKLtyVIsmkjwKGDVceXoPRoyZoG2KR5rv2GM/ljAifX1VirfOO/1FvqAzfG+mECXmO3OkSzcFDKnuYN1+s4mHJF4PD1RCfsOQziuGV8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fH7yEb59; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fH7yEb59"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HMQFew1497610;
	Mon, 18 May 2026 12:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5I+B7k/wq9Y1RLy/SJ9Ni645jAVmZXZq8+BIsyyoq
	LU=; b=fH7yEb59IMvDWMaw60lg6+ypBhBc8mW/6b8uat4FyKMnYa+UdOJ5TsTtM
	W1ttSCzyZumaKK/I7EjuCQmP3GIusAHfWcVe4s13hZg+Y38PuS1r+OYbuk7n8TrH
	cxmWuBK8Xd+nUGVFl7BCN+u7nOQZH5Sr6pZxgSG57yP/LH4dAzSXUv4KzrwvAVim
	UTle66TmWMXUBtYF0cXXPfS7JjFPdPzZM4hrUYNuh0xivx0tincCcIzmXfXPlw7+
	GKrOK/5I5rT8n1hqplFpaWaNh3hBlJW8TlWzrR2igby/ELzn6hYxU/a4xn+KkZUf
	bWQ4WpjNd0eCMyG76fmDAnmvZTavQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xr4ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:50:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ICd7Cn016691;
	Mon, 18 May 2026 12:50:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vp1mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:50:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IColTh41681366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 12:50:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FD3320043;
	Mon, 18 May 2026 12:50:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEAE520040;
	Mon, 18 May 2026 12:50:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.103.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 12:50:43 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf kvm stat: Add missing mappings for PPC kvm exit reasons
Date: Mon, 18 May 2026 18:20:38 +0530
Message-ID: <20260518125041.39286-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEyMiBTYWx0ZWRfX71z+J1ScWM0r
 0oF/hBJ5wUb0s+pBM+cjEkjLLSswqUBNYEmp2U5mlk/u/gdufj/a7zJegDXIUfjTJHwYz+FM0qI
 ck7UawDfcuRfQdGf3Vu8Ru7S5YtsspI4teq+Uhjbd9Ep8mIfmE+fcaDWpoZXrYvSaP/VaSmUVOq
 tfVXmjsRrh4I735l4Y+4KoP+TRr++9x68F8oTD5Pok79kTQ7vu12v6P5ig4G8fGoxVxTLhLr1p7
 yHIF8ptOlt+laWMqgB1/3ZewJBeal6TE2d3YRMkDMrYl15s45+wqoMe/JLhLdqBT01KLuOBOPBo
 nXmAolbqMgj+w6egRBE5hykt7vSasvcE6pfHZnF8aQGvxHnCrN7YhunLCO8MmbCFVBs/oOYoyjA
 /CmdahlN6N77QW4j2AxYGlQQV84W6SOjmZGt1ki81IWeCu7Ocju1nfII7EMPOPqlRiTy991xzpR
 79cE1sUDg+voRyW/hPg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0b0b2c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=el4MqSLvOoczSZ0XHlsA:9
X-Proofpoint-ORIG-GUID: xsC2vPiTFk-T6BhDwB98-HvXsW0Mw1sr
X-Proofpoint-GUID: wy86J7ddM2lOYHMDovAsaKX-5A8OmSCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180122

The macro kvm_trace_symbol_exit is used for providing the mappings
for the exit trap vectors and their names. Add mappings for H_FAC_UNAVAIL
and H_VIRT so that exit reasons are displayed as string instead of
vector numbers when using perf kvm stat.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Update the patch title and description to remove dependency on
another file trace_book3s.h

 tools/perf/util/kvm-stat-arch/book3s_hv_exits.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
index 2011376c7ab5..2688ca7d0399 100644
--- a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
+++ b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
@@ -26,8 +26,10 @@
 	{0xe00, "H_DATA_STORAGE"}, \
 	{0xe20, "H_INST_STORAGE"}, \
 	{0xe40, "H_EMUL_ASSIST"}, \
+	{0xea0, "H_VIRT"}, \
 	{0xf00, "PERFMON"}, \
 	{0xf20, "ALTIVEC"}, \
-	{0xf40, "VSX"}
+	{0xf40, "VSX"}, \
+	{0xf80, "H_FAC_UNAVAIL"}
 
 #endif
-- 
2.53.0

