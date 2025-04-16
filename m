Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D807207DE5;
	Wed, 16 Apr 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817331; cv=none; b=feAIBrvWLknkw3oq8PC20FjUzxyqxsMPLXsdLfm/U0uML3UgdIfkrMYCohfEQYp2741ZR4ujY6driYtpiCsbgdHoDMkovWpl7enGtLTZAI87a3y6Ieh7fpPMO0UpE7T/qJwuiJtHnNBMIXjxVLRmwY7jkA1PxqEkekqiotsIff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817331; c=relaxed/simple;
	bh=kUcLwlYlJfjnn4VvnlXL4MjUe8PfXD7bUmO0OiNmjvI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UJnRE5WyZLIWFQUnaA9thjcIcp+kwN/kuv2fiyq0IXeNr4NEkk4f06XgDH8MwcBz2XxS1CrrVjFoMmwZ162qL/rsReXMXfck/5x8wqrUGYqM+bteeuKeZ96WIHH/tQI2sRR7+0IkSphOKlgAplI6OFS7nurM61IMQcGNpbznlu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FhIrQWLO; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FhIrQWLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744817326; x=1745422126; i=markus.elfring@web.de;
	bh=Y9ve19JkjveFsFqfCSTPf1Qll+JvmiD7A2VvAMQXuos=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FhIrQWLO0Daw872shpuW1utsEXae3IwGCa8PRn+2bEzfDUMmruzvXuer4Kr0Z+iO
	 QN6sqvSogX90KEy+GV8fpHfWkDtX6HxciFMNRCTBSoHFSjExXqRDl6YX68KgwgcNg
	 FwDU3Oj2Zx6G9KSA2gKZZQ1BdFngrfamLb/t8L4tQR5TPZclrZkL9uY4JCCMEdFIi
	 sQRWqf4fbusXIEMw3IRRbtawBB3TMJ74Gnh0s951gg6sCT97rmTI9Nm8494fj7Ofu
	 oftCMWtlMsuCHy9Pf7UZSk5klEWVWHadVxHfOVQ08fONGoR9sDxHLLhc4w0QJZO9C
	 JdNMuGXWQVSurF5gAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1tzs212Bvf-00F6Ig; Wed, 16
 Apr 2025 17:28:46 +0200
Message-ID: <d4516add-45ad-412a-b9bf-ee21afae3da9@web.de>
Date: Wed, 16 Apr 2025 17:28:44 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
 Mark Rutland <mark.rutland@arm.com>, Suzuki Poulouse
 <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Chenyuan Yang
 <chenyuan0y@gmail.com>, Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] perf/thunderx2: Replace devm_kasprintf() call by
 devm_kstrdup() in tx2_uncore_pmu_register()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2orxDoFcZeWABEqYTXfmUT0qCBaa8P1eddz3r+RVltY4BcfGG6B
 Vr+WUH6usiKVdV4MHUhDg192g6PXWqKIbBWMd+acibmZLPFGsrKY4kk2JxHDdQt/gajKUJV
 q1hdqM9V8AUc8lmSAlAi33+XCFwpb783DKsXlfm1O68hmc7o63TQzS1ujdCySjdT/nslWNX
 kuY2YuW6jWSOtTuWldSKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fW9PoLHPsDQ=;KP97CRwQzqftHcOiCzPhXPUMPS9
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 16 Apr 2025 17:15:54 +0200

Use a devm_kstrdup() call instead of a devm_kasprintf() call
in this function implementation because only a single string
should be copied.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/perf/thunderx2_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 6ed4707bd6bb..f0d7d1f9948a 100644
=2D-- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -736,9 +736,7 @@ static int tx2_uncore_pmu_register(
 		.capabilities	=3D PERF_PMU_CAP_NO_EXCLUDE,
 	};
=20
-	tx2_pmu->pmu.name =3D devm_kasprintf(dev, GFP_KERNEL,
-			"%s", name);
-
+	tx2_pmu->pmu.name =3D devm_kstrdup(dev, name, GFP_KERNEL);
 	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
 }
=20
=2D-=20
2.49.0

