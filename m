Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123686;
	b=bt1liqYKW3KqR8V54b7MpAjtP52LK0vqDfL+UPSXNp+MR19onJEtHyyE8ZVTGD7e2/Yg
	 D6p1wZLT64rUeOHFlm/ht9LcU3mstReXJFfh1unwBd0EndHaTDtELeclRDVhb0powB4yI
	 QYFh08uID+41wbBfGEkC22Fyeq8X6L2by6DjDZAyohUs/h73tkTieKb8veA8CX6PdfOb3
	 hHiRz7/o/IqaebImHCmxAxQ/m4WHksW9Vr52beZNrMCiLNfAPzmDhoDj4TG+OcVAvISJR
	 5UPPnkwKrPfqe3EwHBpEsArrj9xPqzmPVdW7ZcW3gCsus42DQF8B67cVIlLp1ajZ+Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123686;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qf21qFnnKkFheDYrcAwxOSDDxfaoF3chU6T/ZEWZIFI=;
	b=aOQu2Co6zwTiRn/NBb+yTR7Dl65tto09QXndqxHsoflxce6Cb1x+o5NC8HNU21sd62B+
	 8AwDYFqkE5tdpwvzldPyBMG6ahZPcdubrzYYUGt4RorHjyQ1w/WDfmNfkysoBgCYUNzi8
	 jeemtJv+1GH0xgV0aSSbmFIhoS5Bp/qqmdKAgYR72/uAtpT9uvYvGf7clQtbY+2iIA2kf
	 4r4FgV/VsVNBbIx/2zBDLnXqkzQCLEkKtzOVW9ld+s9NCx3KqhTqK9dIdupq6nxeUbtpd
	 Leyxo4pLTI7HbcDrTMGPX6RTRcuyLuycZBz70+zwgLlg1Yzu/uCUiTGvMTSOHIlKQXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEgaYiMi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378C606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEgaYiMi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F2E1F01828;
	Tue, 27 Oct 2026 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123686;
	bh=Qf21qFnnKkFheDYrcAwxOSDDxfaoF3chU6T/ZEWZIFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MEgaYiMiTEZY4+/EvFkL5m3YF8SEMh8r/aNBEadQtHF1asNhu8Ght+DFJ3hyqlCNu
	 I5Cr7rQNch9xDU5t6pNwOJwO40WSbXPmixhlS8/AchWbloEow118l6lubEFSn9j04q
	 SXo4ebNQQUlIC/Mj22USaRzdApWG9KawIcRxMRj+ncONFHB4Hr3DLcHhRrZeKeZLlv
	 4LxoNCsuEPjD4ssMlrFSbbMvOZaWNHjEka28SZAA3W/tNfRXsmRRTBdbq1yhA2WSx/
	 fqxicT19+fQxPkbj8B9qjfqnQES8S/X033tat7oytQSCGcnlJK9fBUWJfOVE3kQvYp
	 P+LbpeyDYhH2g==
Message-ID: <sashiko-outbox-186997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: perf: Describe the Broadcom
 BCM5301X AXI PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OkFSTSBQTVUgUFJPRklMSU5HIEFORCBERUJVR0dJTkc=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261027175124.3518239-2-florian.fainelli@broadcom.com>
References: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
 <20261027175124.3518239-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:54:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Describe one APB register window per AXI Trace Module. The counters are
> have no overflow IRQ.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027175124.3518=
239-1-florian.fainelli@broadcom.com?part=3D1

