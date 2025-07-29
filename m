Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B628B7D4
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787007; cv=none; b=kV/4BnSboieRDewNigz6zeO4Slr/LeWxaUP3DHBSWss6H96Sba4+/KgPmQCorClqkmbMYRND8cG8Cj8jQLBbdv0LaQaQvgVd4N8+CWqA45QDMItqnhmvybQ6H/y6j0n/0+y9xNJd2Bq0xUgrbWtLmobpXdefTh+J8QkKLvyXTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787007; c=relaxed/simple;
	bh=ErfwFjuvkuFvBGTqBIboCqX0y6LDYlVCBaPZDoPYhSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HU3UG1fTVEIVjj9/8Q+tQFqzPIYJJqzqKDw1go/Y+fYFcrIqo2hFKrYZA69s9IYeuwQISavidae4ebNexzYWKUKfVSBuLdjWhW3QLS1A06H7q8hmlhonh2g1Zxjk9Jfo253AeZvsTij0bEjKcFTnSl6O9I09rNHLRtPhb46OSRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NpXNdgK7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NpXNdgK7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4Yvjh021860;
	Tue, 29 Jul 2025 11:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Wfe6Nv3z4EzlwZdg/HXGhdwWA3JktQqP+Rrm84IjO
	N8=; b=NpXNdgK7knxDvJelTOw7Ho75Z7Fnyy2ZtGjFbKtFePsI8KUdkn/kgJfiE
	87QFqhFJjINcUaaukqo0zHcDRjOzQctsQopky3ZNa7M3Innsnj/S5ZtlXv6dKNHi
	JMAy9j2EfRAo0Pg7vaCH9CDgB+emO59lI4ry1RfyWcyiPeHNkIa9QeGe+1XDhp1g
	fahT5tcV7j0NGx3Imqg8jZ2A0S7UyY5DJ9DRSxjiCUWirxrfx4RlACRz8MlLh7z7
	QfxxQogOoRaCiNLQG3NVJwYBOt92lKFy8XY6Xr0Aj5bSHBzFbMyjK21VuA4+NzLP
	qr+q1f/gDfR6hoPafq+BLMxuUJGtw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemp4qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 11:03:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56TAudXn024066;
	Tue, 29 Jul 2025 11:03:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemp4qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 11:03:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T89KRA017955;
	Tue, 29 Jul 2025 11:03:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859btj6u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 11:03:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56TB3Ak748234884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 11:03:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BA020043;
	Tue, 29 Jul 2025 11:03:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC14F20040;
	Tue, 29 Jul 2025 11:03:09 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 11:03:09 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
        tmricht@linux.ibm.com (Thomas Richter)
Cc: linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/1] perf tools: Avoid auto-complete failure if sysfs events are missing
Date: Tue, 29 Jul 2025 13:03:08 +0200
Message-ID: <20250729110308.3675428-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OtVNiUs5kK8hi9reHPKJAuyQnFHFnV20
X-Proofpoint-GUID: YRKcAssx4YwfbOjHrd_8SqdeHsWIje76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4NCBTYWx0ZWRfX4riRtbJ0It0U
 gqBT0U4EDWxCgYwadUWvZZw2kRWYKGI9Cz88m/e4KyYURdEA7RRu3y7nM5yGq6Jrh/UP8TwCDS/
 DfurQfW3aQ24FqCvxMgcuopPbmVr9j/1A4/JTlEgUvMvdusmKZ03ERth4vlq4pYXMwGjSv6LyYk
 BicvzvQ1gwuojB7MOxjIj626Zk/Grpr+SV8yg40Aa7ZAiYfZkDPpRntwamCLiLTqotano3h24qx
 0KFb6+7555xQioY74gGh9/jvC4l4bwn+i28jghOpyDN+05ipZdVT52+DVF2GfG5TcO4IzWKCTot
 NDqZ4+9anAnHWd+mfg/NG8d5e0oxVh8b6zvCz8j0+B55O/2vc4Wv+I8wzXH3A1uAov8NSeEXp6a
 BHu+1S/J1/+NbGAXgy2mjh50h9J3GY05z+zZasxQTAGR5dvwsQw4I2Lagy123t/gc850G/lZ
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=6888aa73 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=mufVlS5tXNwLyvRRo2MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=469 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290084

Using current auto-complete script result in the following error
on systems where /sys/bus/event_source/devices/cpu/events is absent:

    [root@localhost perf]# perf top -e
    ls: cannot access '/sys/bus/event_source/devices/cpu/events': No such file or directory

Fix this by skipping lookup if the directory does not exist.

Replaces: aIRnJDMRNO8olMdD@google.com
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
Changes since v1 (Thanks Namhyung):
- Changed commit tittle.
- Removed arch specific handling and test for sysfs events.

 tools/perf/perf-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 69cba3c170d5..1a91b9399f94 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -168,11 +168,11 @@ __perf_main ()
 		local cur1=${COMP_WORDS[COMP_CWORD]}
 		local raw_evts
 		local arr s tmp result cpu_evts
+		local sysfs_events=/sys/bus/event_source/devices/cpu/events

 		raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
-		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
-		if [[ `uname -m` != aarch64 ]]; then
-			cpu_evts=$(ls /sys/bus/event_source/devices/cpu/events)
+		if [[ -d "$sysfs_events" ]]; then
+			cpu_evts=$(ls "$sysfs_events")
 		fi

 		if [[ "$cur1" == */* && ${cur1#*/} =~ ^[A-Z] ]]; then
--
2.48.1

