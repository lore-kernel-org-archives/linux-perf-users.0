Received: from outbound.ms.icloud.com (p-west3-cluster4-host4-snip4-6.eps.apple.com [57.103.74.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A911E32CF
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624053; cv=none; b=kU28sXl1L+eNPZwK2f5hSjfWVRUjXcGKYNnbm7ehMhKOwua2YVk37Xa6yvG6MiHbAXjcqDym08Ww5m5DCSb+JwZZSGtPShxeiztxR9Uw76rX5z6li8r8PQ1hL9r/8nonXoMdMH+pqvPx8DcFz5l0vGPu+DNVdH47mfwZF+BUUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624053; c=relaxed/simple;
	bh=QgTCoX8qo/SLFHQ2dG8+BUWQyjIhaj/HhIl7y6MNAAk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=unarRtHF3q8n9RRexqRSoh2DZxJwEkV0Xewx44tZe23J5xG4G/8K1pcaJZefFgh5j9g0kQ+Z6AvrA7Gq3ExBm/s+mYLygRSTUCOr9vwGzjvcNe9qgD/W25m3VPT95jp8vn9nXPoEDZJnW8Zf2yuNQcLrgUPo324v0jUtu2Kknnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=FNXgeylu; arc=none smtp.client-ip=57.103.74.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="FNXgeylu"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id 71D261800135;
	Tue, 28 Oct 2025 04:00:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=XiKJhFcVH3GBeZzyLQX9HZdUzIp8uSwZB2eZvvT/sSk=; h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version:x-icloud-hme; b=FNXgeylunTt9jK0P2M0it3dMvrLXHyI25HfKp5rICPOjjmM0wufvRH/U5SsgfRjsrFxtvi47VmrofpXrva/nJ+Y6KhFdeztNWghiVkf19YUDhYyA6tbVC6EP0tDL+x9Y1Pg0u85qWBBP8l67yl+GaWbvxgxqxnE5FlajywsR8884OOYc1fCv4bDpwL/2OHxW3yahyAXtMy90PO696C6neByquoxryGPkA2ieXLqp5KWbR63APXSOK1G+RscmEK6jSiABTUh3KjMRdqQjjDzmbI3wgrVNvaIOvJlTm6so2i/z4fSQPHOVl77yxpcVnCs0S/sZeVWa9BW+BarD6Cqmpw==
Received: from [192.168.4.116] (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id 35A1D1800122;
	Tue, 28 Oct 2025 04:00:45 +0000 (UTC)
Message-ID: <6b7c6221032fe9ca888d9905479d0bd502f583f7.camel@icloud.com>
Subject: [PATCH 1/3] perf trace: Fix filter expansion length typo
From: Zoe Gates <zoe.blair.gates@icloud.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, 	irogers@google.com, adrian.hunter@intel.com,
 zoe@zeocities.dev, 	yujie.liu@intel.com, sandipan.das@amd.com,
 leo.yan@arm.com, 	linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 23:00:33 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: WPGfsYmprXv-07iSOgifEUNSLsakzONp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAzMyBTYWx0ZWRfXzuFq2uqQ87Ar
 CcfFup3OpQvNTdErZjXh8aav7njV91dyfhIckKXGVkGbiIVebyyaKGBRHZ2x99vlhL8DLj3RLV/
 gAs1mtYwzesRhkw6sg5OV9YL25Fa4jpHmDKo5TD+V5AKurPsF3sTY/21VgGN/ykGzu8Ek5aDDG6
 yXFzH3YlqcQk5xm2YqMYxXESjTSiyhr0mvZLSBTpcxOBEH+NBk19PtpbXEhu9HNoxlHksrvsd3S
 V7ND1ok7VVASoclLkY/gpTONxDIqpnNO2KseT8tUKyHHmWG4F0x3BRRAI/2HNPZzPpHq5kyco=
X-Proofpoint-GUID: WPGfsYmprXv-07iSOgifEUNSLsakzONp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280033
X-JNJ: AAAAAAABrRe3sbH4g6hZZm1ptChxtS25a0jbrbm/bKjXZQXPs0yXNerFrJcNbNRDIDTR24w2AwE5qlL6dAb+y5Q3CE3iUv3bXzYxlso+30YQ94O+hbdQxhzkiQ041uAfc64C6sjd/M1W8JMGPl336rAxJPyiqh8bt58U123OWx9t60Co3+69rfervJPa+kadI70HRtBNIRRkNUCve5mpjskJBvWVuKqiQHR0QOzWRpPfPuebRPfkKwxWK4Gp8GSqr0nlllEXBQ5imPBzqgYevopmXYD0kIM68c8Wh70UgrwW9L4LoUYzVIdY2Lmru6TLwAf4V3DgTncNMazzSTjFjGHvlbEY9HXXBSFrGSzQrWLo61uSrILuGI49fTEMudyZn/bDfv6GHvU80IgKBntrAJXU66363B2nRzVpzLlk8aFNB4g2la4EIZ46bUu6UGcirh/u1nNMIsdWxL92CEeSHx+V/Ooy6s3pkvI5aehFli9pJwzmzS6JKYo5Z7NZ04cnXEQX/8VFMveuE5mrNb4vz49t03PYOX7Vma7yRfObI1XgSz2J28hjLpumySAAz+QkEhH66XA25P+fzymmNAm4mX6XfC9QAE09EKK0PL2g8R/HuecXHiOhQph+aYSvONcT6nreyHvA7ZGfm1WDTILRRUQFSfLMzJjErLFl2/TCqapIXGnYTgmCKqtQRnb9G9W5+bVBmv6YEFACHTmcP4V391FqDCVr8mKBWzaINblgYe98SLXR8SR03BOwVAeZqws5/bXXXxZCAfpsmEObN7koz8lL8OFjYko9iJWHpdxzIzXl+U1LAmaimEn6JF0eEIyTobjmFwHUjuTRFzl5hOiKy4sSPi9z2QSkAhQKpIKhIESsWGs=

From 08185c5be135eb83194a49e593be9258cec78d77 Mon Sep 17 00:00:00 2001
From: Zoe Gates <zoe@zeocities.dev>
Date: Mon, 27 Oct 2025 22:14:24 -0500
Subject: [PATCH 1/3] perf trace: Fix filter expansion length typo

Keep the filter expansion helper readable by using
expansion_length everywhere and wrapping the scnprintf call.

Signed-off-by: Zoe Gates <zoe@zeocities.dev>
---
 tools/perf/Documentation/perf-script.txt | 2 +-
 tools/perf/builtin-trace.c               | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt
b/tools/perf/Documentation/perf-script.txt
index 28bec7e78bc8..e136ca35d380 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -262,7 +262,7 @@ OPTIONS
 	is printed. This is the full execution path leading to the
sample. This is only supported when the
 	sample was recorded with perf record -b or -j any.
=20
-	Use brstackinsnlen to print the brstackinsn lenght. For
example, you
+	Use brstackinsnlen to print the brstackinsn length. For
example, you
 	can=E2=80=99t know the next sequential instruction after an
unconditional branch unless
 	you calculate that based on its length.
=20
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c607f39b8c8b..ae5fabf91c96 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4291,7 +4291,10 @@ static int trace__expand_filter(struct trace
*trace, struct evsel *evsel)
=20
 				if (fmt->strtoul(right, right_size,
&syscall_arg, &val)) {
 					char *n, expansion[19];
-					int expansion_lenght =3D
scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
+					int expansion_length;
+
+					expansion_length =3D
scnprintf(expansion, sizeof(expansion),
+								   =20
"%#" PRIx64, val);
 					int expansion_offset =3D right -
new_filter;
=20
 					pr_debug("%s", expansion);
@@ -4303,7 +4306,7 @@ static int trace__expand_filter(struct trace
*trace, struct evsel *evsel)
 					}
 					if (new_filter !=3D evsel-
>filter)
 						free(new_filter);
-					left =3D n + expansion_offset +
expansion_lenght;
+					left =3D n + expansion_offset +
expansion_length;
 					new_filter =3D n;
 				} else {
 					pr_err("\"%.*s\" not found for
\"%s\" in \"%s\", can't set filter \"%s\"\n",

base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
--=20
2.51.1
