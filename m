Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8151A6833;
	Sun, 15 Mar 2026 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773547334; cv=none; b=EaFXfYLKRdSWoi1gRMtXtWQ7GpgjUlXtNz6koA0nnHsRF6IyB2a88he4GAquFjOPcxTEmfl6ZhGVD3Z45KGPimxHVDHVTpSyNq1BEEO6tnvLun4MjPmYvcYNlLdkkJz63la0n7KVCU30VqBB8SeFOX/NFkn0bdTPrL3KHtf+kv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773547334; c=relaxed/simple;
	bh=mnvRgqCMTPe+vK15y8zjD3dv6JATqo8IfOcRbxBr0KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGHizx9nQYdHZxF/DfF3vNnqz5t8lOK11pIBT4AztXqmrmjPpl3GteE/csBm1waC8dmVTZ0DLeXNrNXU/zmPT6VVFOtKYgcKdVqtJWzjGDcnlEpiUI4jrlO6LdsOQDtBrH/26WkvUCpQEXngMQb/C8GdsmjeX6j14H4FAaB687g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=czNIHBoR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="czNIHBoR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62F2Qc1D2848797;
	Sun, 15 Mar 2026 04:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hTWcuz
	ds1n8FFg8NO7yxzEId6PqQHm6o2MECLc2TydY=; b=czNIHBoRufgvAvG/YQI8AP
	qRWcGQH4knYbSNu6aRM6znBBWg5ikaPFfP79ww+eCRItQratYM8vQLiqAQrqEll3
	vYGopsiIQ5kGPB9S2yDseY5AGGhfd1acTVwJQ+S448rDv/uxfL65sHeXYJ0cMbyt
	pQtcLf5EeS2xrBOH5pf1UkqtUnj3c5atix0ft8wzt27bIo26fWZU0+pSr4ggJ2Hi
	Ew9ncnsgDrxljbfd76FSXmzFwdXqi3id3Cgak0QTMgN5wwthODSVQ+RfDVcH5Eup
	1rhTThgYtzBNbj0D26594Pd8xx61ESnt0ctfFYwbcawUm4vBS5pyIHouOqyYm4lQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyd3b2e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 04:01:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62F0bPB1014033;
	Sun, 15 Mar 2026 04:01:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxrd61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 04:01:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62F41nve30474998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 04:01:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEAEE20077;
	Sun, 15 Mar 2026 04:01:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 704D02004D;
	Sun, 15 Mar 2026 04:01:46 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.97.251])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Mar 2026 04:01:46 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Viktor Malik <vmalik@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc, perf: Check that current->mm is alive before getting user callchain
Date: Sun, 15 Mar 2026 09:31:45 +0530
Message-ID: <177354720780.2367911.1351341217164691365.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309144045.169427-1-vmalik@redhat.com>
References: <20260309144045.169427-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PbPyRyhd c=1 sm=1 tr=0 ts=69b62f31 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=etsT2AeJg6oCEx13ZhEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d8Uzk7qQCadW--WcQSUXsaWxypy3lY1p
X-Proofpoint-GUID: AbUBTItSDXZtEu5mIf0Kd5vnv7kvz10k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDAyNiBTYWx0ZWRfX9ovaCLmW6oHQ
 oNGGo0nR5hOfK550IP7+VuWz69eQ6bZYsMdziImJy+va/14bfpooCoopba6/lgzGUXje+sBgnfn
 s074IzkQOmPXAk2U9bCmOZt27n8uJyio6e4G8NZ9HkK6WJ5sZruxeuFhCUp/CE1KVi9hC/gaUnC
 Ytw6HjSr1aw8ZheA6ChDjrT6qctOb0IS5ORVuCdzFsMbLSv2/LOBiV8Gw8txeGcefc7RNaISMxC
 hvaA5D5XOPJfRxwYCt/HEm0box+7o9t6zKPpGe4GAU+XiCFFHSy/kN/xgMP9cDV6EOQ759ez98A
 eWsRCjRT20agWlLjd5w3U/pkfgZ6Wa59STDDLQTRhyxj8KNNTyHfzTZynoB6XDrj8CMKrrAtkTQ
 R0OePw31Xp5USNuYgBuvwZA9MqOyjvDZCZTVM74vnrgCAUEpXWeZFcVosx2NSKGCBYTtA5Zq4uR
 rpfyxB9IcidDZsMKKBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603150026

On Mon, 09 Mar 2026 15:40:45 +0100, Viktor Malik wrote:
> It may happen that mm is already released, which leads to kernel panic.
> This adds the NULL check for current->mm, similarly to 20afc60f892d
> ("x86, perf: Check that current->mm is alive before getting user
> callchain").
> 
> I was getting this panic when running a profiling BPF program
> (profile.py from bcc-tools):
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc, perf: Check that current->mm is alive before getting user callchain
      https://git.kernel.org/powerpc/c/e9bbfb4bfa86c6b5515b868d6982ac60505d7e39

cheers
