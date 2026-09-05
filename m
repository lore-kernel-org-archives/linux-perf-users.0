Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBBC378833;
	Sat,  5 Sep 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615829; cv=none; b=QFfRbALfJmeD+JSfUit9UIJKH2xjN8B+p51T0a2ghx9d2H4Q66lLam3h06NEBFlYXHkI2/qaICIJKnDzGZqB+m7g9SsMO7R6iR3BZnXf0z6q9ENmnjFe/yaHEOWHwdQV0s2w4nh0y8/T83t+/aHRnjr/p4Jy+9D3qjNL25LLorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615829; c=relaxed/simple;
	bh=qvcHCguQpdBUrPSb0sBgRuCWzDwRVhvoMIPvZ4e9Igs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIMo2a4seEkJzGBVG/mZMDMVmrLQ0JZwSFYS0FTzx8ppcH4X2nizJA3ufRCCOA9/LJtV0FoD19eoybv7rsXa4TFn/1esAuQ0AIlzl8eFSfAxNx5neGkyPl8Rmgst5KSYcI6Dh8TAZrwrYDvNewVW/0AgfuUXL4MBrfrtCiCTCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nmnRJw3Y; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nmnRJw3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dZ
	3ak0MZQGVE/7EAGjEDrOFT1fT6lEwINHAvDHJa5sc=; b=nmnRJw3YPaD7dPT+R1
	LQMy17GJvcOHzY/2FSBW73zHGsViv7BxIjaMwt0AC7wZobr7fEtAmF5EsBGwIBdm
	DyRmLyMfNzhRBTuFlyN0pFLc78eLvVQDYQRQ1j+lXwlCj8k/md/8nRllv7UJwfJM
	c89VghPFcwOz2hD/Mrk/p75/A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnVTl3HJxqo0uOAw--.16301S2;
	Sat, 05 Sep 2026 21:43:20 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Will Deacon <will@kernel.org>
Cc: "hpp.iscas" <hppiscas@163.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH] perf/marvell: cn10k_tad: Publish the OF module alias
Date: Sat,  5 Sep 2026 21:43:17 +0800
Message-ID: <20260905134317.67317-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wCnVTl3HJxqo0uOAw--.16301S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr47tr4UKr1rtw1UJr4fKrg_yoWfuFg_ur
	13XF40g3s5Kr1Dtw1jyr4rCryfKr17uFWDXrWvgrnYq34xXFnxArsFyrWxA3s0gr4jyFWD
	ZrWUWFyjqrW3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjbdbUUUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxRjmr2qcHHg9nwAA3k

The TAD PMU platform driver has ACPI and OF match tables, but only=0D
the ACPI table is published. A Device Tree platform device emits an=0D
OF modalias, so the ACPI alias does not select this module for it.=0D
=0D
Publish the OF table inside CONFIG_OF and retain ACPI support.=0D
=0D
Fixes: 036a7584bede ("drivers: perf: Add LLC-TAD perf counter support")=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/perf/marvell_cn10k_tad_pmu.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn=
10k_tad_pmu.c=0D
index 54909d0..301be4d 100644=0D
--- a/drivers/perf/marvell_cn10k_tad_pmu.c=0D
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c=0D
@@ -424,6 +424,7 @@ static const struct of_device_id tad_pmu_of_match[] =3D=
 {=0D
 	{ .compatible =3D "marvell,cn10k-tad-pmu", .data =3D &tad_pmu_data },=0D
 	{},=0D
 };=0D
+MODULE_DEVICE_TABLE(of, tad_pmu_of_match);=0D
 #endif=0D
 =0D
 #ifdef CONFIG_ACPI=0D

