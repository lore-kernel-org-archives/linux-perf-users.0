Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B9274658
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784962830; cv=none; b=IioFWCxCEBOD5wLzrfMy/TJ1seJ9Y6A5aPQrCSfEJf75GNNvB6HB7XsUWWPJOnInKD+/2/7L2S9HZMwAs37n9wJWF5O3nigC5xzfUbF0xTjdGW843UjDebJfJ+Fehn1CMnVdZkF4v7eTrUvI7vbKdPcsXEJc+IueI7WMjzIAaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784962830; c=relaxed/simple;
	bh=p1R2hQfdkdmqosVo4NtuQ1DEHzNvTC2MBtQNC28X5YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKP+4uFCdmcXVfETJmgCg7chxZ8SoLhfxcfg7+mcauPdxT7kxUTRzGjTc+7bWur1hKL0L1rbfQI1ASKhivOC+vc42hGOyZpqamJPt2D8iZsX4oe6nfHqqXojUj4/u5beXs5Zg49t4ymTMnhCvtvUglkmly8CYd/RxkpBYVI4pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PiPtDtAx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PiPtDtAx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P5Boa73873184;
	Sat, 25 Jul 2026 07:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=f2gRGvKVH0c42GH9S
	74LGxVFaeYxyB7tH0BQ3Gbc+Og=; b=PiPtDtAxySSLLmawGNS16mcJ1F5YOOwP5
	zn5cpI6E+Q/DLoHvfp2g4DVdoSkJjXxp2xhwexOvq7WXcSsVRmq66CDHPtEBXH2y
	mdwRxarzk793xT+gm8ymXaNxzLaeyBrY4vesnNVsxPMLXpf2X5V8FjM+nGDZ9d9Z
	TFsxJGuOrmOgofp0e3XgjiU/e+wmwr/SXIKoIKKWzD9MXpb3jcUS6Z0T1r54WWVN
	3S3I/0LSHJeY7LmmlsL/2cM61LbRwN3iITu98848vBSu4WHfNL36jfvOpA72Nv81
	kNet6GaTFiO6rggSIuoU2spaGr7vc2+KarvitJkzvoY2/C90a44KA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmjjj8uhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:00:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P6uiEF025843;
	Sat, 25 Jul 2026 07:00:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn59rfq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:00:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P70AoP50856360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 07:00:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1D9B20122;
	Sat, 25 Jul 2026 07:00:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CB542011F;
	Sat, 25 Jul 2026 07:00:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 07:00:08 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V3 5/6] docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event format entries for htm pmu
Date: Sat, 25 Jul 2026 12:29:41 +0530
Message-Id: <20260725065942.78839-6-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260725065942.78839-1-atrajeev@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX46GrsdpMFgNb
 NG71a5Rm7TckH005tkQdj4kZTO6yp6V5HwjpucdJC3VhB3zbvh7O7gfo3DhbfSqF7mLP+L4M3q5
 XxMJmif2KI9q4amKLI/eXsD14kiFudc=
X-Proofpoint-ORIG-GUID: jDDvgIe5d1wVpM0elCJ6oDJdzK5fQ7e6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX+p2+fYwyvFLo
 RgOeg/R+NqbPcxogVmOva7plzHLS/gtBsp2m/XTMg4Stf0IqaDEErPbR0jj5pEZzRYN0+BaNXvC
 YwXvHHBwQqyJ15dFG0gzqVIpHihNmHSt437ZzpVmAbEwnBH1uXE0Y0TDTSJvLx0/MMQ9NsnQ08u
 z7xRSEqJdf8+mnxi5YdUpK+oi190LcfbZOLY0wwAlctiZTheitorTv/YWV9aSkys3nobyTBxfFp
 ois09fTPxLwX029YkCs0ygX6+EVlQ8R8pj1IAdetEQxc6pnq2ZMqTTCzVnj11YHMKD7MdHhc5si
 Sf8vqwrLc5Pm9gsWb6ftVSkDF8zFXP8/5A3HM+8LxGFP6HrAYD6bt3xpn5epVX2bzEsSosK/CDy
 bfB10IAG58PNswbVS6D0DmLrfscwqbJkeekpuzdtZXv3KMo8yDhUXIj4RXXBsbAgGf4U1mBnpxT
 5+WU5Ztpii3SUIq7bog==
X-Proofpoint-GUID: jDDvgIe5d1wVpM0elCJ6oDJdzK5fQ7e6
X-Authority-Analysis: v=2.4 cv=TLp1jVla c=1 sm=1 tr=0 ts=6a645f01 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=c-k_eesrf3A5jvSTi5IA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250061

Add ABI documentation for the sysfs entries exposed by the "htm" PMU
under /sys/bus/event_source/devices/htm/.

Document the format attribute group, which describes the bit layout of
perf_event_attr.config accepted by the htm PMU:

  event            config bits  0-27  (composite: all fields combined)
  htm_type         config bits  0-3   (HTM_CORE=2, HTM_NEST=1)
  nodeindex        config bits  4-11
  nodalchipindex   config bits 12-19
  coreindexonchip  config bits 20-27

Document the events attribute group, which provides named aliases for
the two supported HTM event types.  Users can pass these names directly
to perf:

  # perf record -e htm/htm_core/ ...
  # perf record -e htm/htm_nest/ ...

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
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

 .../sysfs-bus-event_source-devices-htm        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
new file mode 100644
index 000000000000..1c3e17cb124c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
@@ -0,0 +1,34 @@
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
+                  htm_type        = "config:0-3"   - HTM type (HTM_CORE=2, HTM_NEST=1)
+                  nodeindex       = "config:4-11"  - node index
+                  nodalchipindex  = "config:12-19" - nodal chip index
+                  coreindexonchip = "config:20-27" - core index on chip
+
+                For example::
+
+                  htm_core = "htm_type=2"
+                  htm_nest = "htm_type=1"
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
-- 
2.43.0

