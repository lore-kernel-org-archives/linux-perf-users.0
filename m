Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B386339382
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113507; cv=none; b=MU0ND9cehyP0Vui2XrJVkF0PIRxHRFHOINkzeGl21D9n/nmVAiTeHgY9aU1xasdfVHtGDYYS9pzKwmKVsuk9WHI0t+t1S4JW6WZQ5++NsVSupYxKmT83tREWiBMdbOVdk+48OpcWzJfIyj3LQv0YzAipeCGSf1YJfF/XvKMOZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113507; c=relaxed/simple;
	bh=fWw6GiIU8CABvJukJdo7JKK11CtZQOJh1D4bcAiS5oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8tR3tqQg/0r6HB2oDeWj7N68bFl68qR9Jte9DjLa06+aaUIO0rZSDzS/i90WKYWF9RCpP1osC9R7Q1Oh+HPkUY8E65Oago9fetNKJaH6isfappHUVVst5dlUo99cYwow7QCwzthTu1DE2o0456N8JDNcb1t1zSe8c2LwzUQr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A3DIqroh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A3DIqroh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ClhuT1412041;
	Fri, 7 Aug 2026 14:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wMdy6UI9FoPtTNYZS
	CylyZzzVUO3VyZ6XxEbtCJIqzo=; b=A3DIqrohTqa/9VDBsIySiXtaKr3ud9VeH
	m403xwok6d/9c4aDGAcLRnYOoxD0D6PQcn9eywSPI1m0uK3TqZ0j0n9+mQRiaDNY
	HgtUVAI/WLwcSVaaT67Ll0wHnJITPBhdLxDR7CCDrzhqRfhUlgexlmW8rE6XQeza
	RdrD+nWuBQMzwdUikYjduoqEq1lDweB71JCC9Gw3e/Mg9q+5CVOwBHxGy44RIKlK
	ywyMa+yrFteOOi5SD9DpHQDk7TeCeGAhT9lFem5bSahic0Dp1lp49jjJiKmOLnLg
	Rh1PqgO86C6zgU1/xIPMkhFw/R9R/pW284zbvvYXEy/xQ7eOhq3MQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02c7kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EQKOe008538;
	Fri, 7 Aug 2026 14:38:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyytxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Ec6ht50069974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:38:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 578A820043;
	Fri,  7 Aug 2026 14:38:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B19420040;
	Fri,  7 Aug 2026 14:38:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:38:03 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V5 5/6] docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event format entries for htm pmu
Date: Fri,  7 Aug 2026 20:07:33 +0530
Message-Id: <20260807143734.1224-6-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260807143734.1224-1-atrajeev@linux.ibm.com>
References: <20260807143734.1224-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75edd4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=c-k_eesrf3A5jvSTi5IA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX/uVEOjkC0KoB
 /Sxj71ILULZ9Y+o9T7uFNDVOqTWlrJoVguMbOdFdkWQlTdeTneDycd3EC9hR4lJDjGrq+sV/fvi
 RdqGyFoiUXn3ADLoJLSj5M1zUQdoSgY73X6UKf1Q04xjlTPywYgNqK1tvnBduumMqIcF/HhGaxH
 ayJCZsfLPU/vSoevBg/T9b+pMRKxIVJ6WVbopukyAQrgBFMHLNrgq1QL6gANfgYcIF/Zgc+5VTy
 FPyaEcgw0yJiAN4pGPOQT1f4Jv19DtEsrI8zrva27td31aRkG+TAv8T8qLd8dwaRUb7JgB6bk3C
 Ztl4UDSQo0CHKyaf5bJA8r7P+CZyuzWeI6QoSXICDyG2UBG4B8V1dXBCq4yNK1mHLzGqoda6/Av
 akHBUbgJB6GPFytGideJPwHsCEvfyvP2w3GEAbbfkXY+9X3ZgVquN4SiRSaGybQfIUZTnM4D2dp
 aQHrlalUG/Gcu2c4y6w==
X-Proofpoint-ORIG-GUID: 18NBm6ne6EYWf7M0figDdMe-viIwCuZW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX1Z8vlle8553I
 6AuzgAcMWBeC7um+R7yA4HeOM4cxxCMFBEsS81TePTuTwE5cd4U512l//+fHJ86M+qJ/JtfL+Yq
 wLZQWuSpojmV2ByFA6Ium5bNQ9VM2rA=
X-Proofpoint-GUID: 18NBm6ne6EYWf7M0figDdMe-viIwCuZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

Add ABI documentation for the sysfs entries exposed by the "htm" PMU
under /sys/bus/event_source/devices/htm/.

Document the format attribute group, which describes the bit layout of
perf_event_attr.config accepted by the htm PMU:

  event            config bits  0-27  (composite: all fields combined)
  htm_type         config bits  0-3   (HTM_CORE=2, HTM_NEST=1, HTM_LLAT=3)
  nodeindex        config bits  4-11
  nodalchipindex   config bits 12-19
  coreindexonchip  config bits 20-27

Document the events attribute group, which provides named aliases for
the three supported HTM event types.  Users can pass these names directly
to perf:

  # perf record -e htm/htm_core/ ...
  # perf record -e htm/htm_nest/ ...
  # perf record -e htm/htm_llat/ ...

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V5:
- Document HTM_LLAT=3 in the htm_type format attribute entry.

Changes in V3:
- Fixed the format/ attribute table: the doc listed only the composite
  'event' attribute (config:0-27) but omitted the four individual
  format attributes (htm_type, nodeindex, nodalchipindex,
  coreindexonchip) that the commit message described and the driver
  exposes.  Added all four with their correct bit ranges and a
  'For example::' block showing htm_core and htm_nest mappings.
- Fixed the events/ example in the commit message: the previous example
  used format-group key=value syntax
  (htm/nodalchipindex=2,nodeindex=0,htm_type=1/) which conflates the
  format group with the events group.  The events group provides named
  aliases; the correct examples are 'htm/htm_core/' and 'htm/htm_nest/'.
- Fixed grammar: "Supported attribute are" -> "Supported attributes are".

Changes in V2:
- Updated the bit-range descriptions to match the V2 config layout:
  htm_type is bits 0-3 (was listed inconsistently in V1), nodeindex
  is bits 4:11, nodalchipindex is bits 12:19, coreindexonchip is
  bits 20-27.
- Added documentation for the events/ sysfs group which lists named
  events users can pass directly to perf.  This group was not
  documented in V1.
- Patch is now 5/6 instead of 4/5.

 .../sysfs-bus-event_source-devices-htm        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
new file mode 100644
index 000000000000..141fe8e9952b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
@@ -0,0 +1,36 @@
+What:           /sys/bus/event_source/devices/htm/format
+Date:           June 2026
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe the magic bits
+                that go into perf_event_attr.config for a particular pmu.
+                (See ABI/testing/sysfs-bus-event_source-devices-format).
+
+                Each attribute under this group defines a bit range of the
+                perf_event_attr.config. Supported attributes are listed
+                below::
+
+                  event           = "config:0-27"  - composite event ID
+                  htm_type        = "config:0-3"   - HTM type (HTM_CORE=2, HTM_NEST=1, HTM_LLAT=3)
+                  nodeindex       = "config:4-11"  - node index
+                  nodalchipindex  = "config:12-19" - nodal chip index
+                  coreindexonchip = "config:20-27" - core index on chip
+
+                For example::
+
+                  htm_core = "htm_type=2"
+                  htm_nest = "htm_type=1"
+		  htm_llat = "htm_type=3"
+
+What:           /sys/bus/event_source/devices/htm/events
+Date:           June 2026
+Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.ozlabs.org>
+Description:    Read-only. Attribute group to describe performance monitoring
+                events for the Hardware Trace Macro (HTM) trace. Each attribute
+                in this group describes a single performance monitoring event
+                supported by htm pmu.  The name of the file is the name of
+                the event (See ABI/testing/sysfs-bus-event_source-devices-events).
+
+                For example::
+			# perf record -e htm/htm_core/
+			# perf record -e htm/htm_nest/
+			# perf record -e htm/htm_llat/
-- 
2.53.0

