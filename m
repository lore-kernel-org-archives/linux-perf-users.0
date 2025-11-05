Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351372D0298;
	Wed,  5 Nov 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370201; cv=none; b=GWYgEIAMeG+AphBJQdm3csknOPBYcMfSd9iUUE9SQaWMJfn6SCDLssMen1fO1jAC8ntzNtTZYY3JI9RwE11SZbsobbcDwvhmSiItmAf7NttGI429IvJTa8fZuUs1FIJ8lZ6dleBNwWdN092/G7T7k0XtC+i1h2LPtGm4j0Q8DuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370201; c=relaxed/simple;
	bh=K8tUqK/L0sDjmbzBhKdJCyVGcMFej5Qbb3vY1hiAR0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tb44E9gxjGEjYEAEc2pBAI3WlBLTNLbLvRXLrFRG3/750zibW7ER/c9+bRXvRWGG8T+bJdhOUgjQJCaGhngY+PJQTAQV3ZZIIDeGLzzkqUooa+DOdiPBRvcGK8QDSsddMuoHR6nL/GW/G2S54ArPZ36F6nq4aEv996FhxqihZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wt5eINtF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wt5eINtF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GHkjg023143;
	Wed, 5 Nov 2025 19:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yEvjRn76J02Ym++P5C4cVHTrG8RMeX5V/kjm0xyoQ
	PU=; b=Wt5eINtFCD2uiUeJ4qJA2XMlJbAChzdpD8loJ34WnSfGF9j7PP660Q8bp
	prUHEXIkRglJE3ciz5Y0hbbQlMhgUjuK1rSXX7aBxPXHPtXq5ZfK5aFCDcYJ5qRW
	yuHbQ4AbqIJaxs8E0QH3Rwz+obp/qmXqjhilZjoazVYun5MaKNeLJUNVaUrYL5ry
	LRnJhY0nBFCdCL+0u57DS7KL/Z9fr6irii8ZlBELkyYlc485MKv8HRNtnWvvu2BI
	0H1Zq5W2453VqkSvsFVJJ3hkvHZVjisgZgMCQwBv4yBD51x76uvkgWixxbZzYOpR
	Ok2meL/T+eCfgkzy9lvhvK25ZDMxg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q93a7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5G7Vbs021491;
	Wed, 5 Nov 2025 19:16:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjskja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 19:16:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5JGXxE38601026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 19:16:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 127732004B;
	Wed,  5 Nov 2025 19:16:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C23420040;
	Wed,  5 Nov 2025 19:16:32 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.135.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 19:16:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/5] perf jitdump: Fix PID namespace detection
Date: Wed,  5 Nov 2025 20:10:23 +0100
Message-ID: <20251105191626.34998-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690ba295 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=tx5xmjFgT45qxv5mxtEA:9 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: kdCZXqxewA3LZw2kN-LW9yDv65iPQ4cv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX8/orXbj7ynsA
 RiHvBgD5H3i2shUwsBj+9z/B/KGLeOyXCJWjr6UDR7GRlyeD95xbjI0dbJbxG/lDaqmPS0c2f2z
 5xhtp3belsPO0urvrx3xIi2r5qRuCigRV6L0K1FIfAjUFQXGYPWOnQbr1SmRTvJ7K0qXaxw0ReJ
 9odwPaY9XFAkc00lKk1sa69Cv8sTkQ+kb+ra79vmghnfZLlg6nJiklycEdHB/brFOgZP+P8Yey1
 OGkiTMfTV77ZHmSA0nYNG+dVxeutngOMd8v5d2CZmYswH9xB13y3TkLpgukhaar5/6/aCV/o9NR
 RVVlfwvtHh4MzWK00xD+Equz13VCckSTHiGXR4bdmNC2n+KXftxO5RtNoCz5OgIINcWlr5fu1FW
 UNnKnndIU4H8T6iRBYX6S4cAg3A2Wg==
X-Proofpoint-GUID: kdCZXqxewA3LZw2kN-LW9yDv65iPQ4cv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

Hi,

I ran into a problem with perf jitdump not working with still running
namespaced processes and started (very slowly) working on a series that
allows perf to record accurate PID namespace information [1] and use
that instead of resorting to guesswork.

However, I realized that at least short-term it's possible to fix the
existing heuristic, so I've created this series. Patch 1 is the fix.
Patches 2-4 are small changes to the existing test, and patch 5 adds
a test that reproduces the situation that I'm facing.

[1] https://github.com/iii-i/linux/commits/iii/wip/nspid/

Best regards,
Ilya

Ilya Leoshkevich (5):
  perf jitdump: Fix PID namespace detection
  perf test java symbol: Get rid of shellcheck warnings
  perf test java symbol: Extract LIBJVMTI detection
  perf test java symbol: Fix a false negative in symbol regex
  perf test java symbol: Add PID namespace variant

 tools/perf/tests/shell/lib/setup_libjvmti.sh  |  18 +++
 tools/perf/tests/shell/test_java_symbol.sh    |  39 +++--
 .../tests/shell/test_java_symbol_pidns.sh     | 135 ++++++++++++++++++
 tools/perf/util/jitdump.c                     |  27 +++-
 tools/perf/util/namespaces.c                  |   9 ++
 tools/perf/util/namespaces.h                  |   2 +
 6 files changed, 201 insertions(+), 29 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/setup_libjvmti.sh
 create mode 100755 tools/perf/tests/shell/test_java_symbol_pidns.sh

-- 
2.51.1

