Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA622DFA2D;
	Mon, 24 Nov 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971619; cv=none; b=Zka3u4bVWHYIzOJJOGwXUCZYNCuC3Vv/UbDQMpmGV0t+7AAD48H95giiCPAkqxOpfh2UwznklpOz6RXsKf3D5gVT0pK65PqH5pd6oj++cLTzEU8ArvjMFXyvhwPbBmGIJZMR75lhbameHy71h2B+wrzeEh3YwVanWPL7yEfelwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971619; c=relaxed/simple;
	bh=F9uJWD3rUKowmv2igq5Yy2Vrg6075o+kqKNns1F/Yec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBkO1BIQbJWE/2RPJni7wOg8druzD47c3PfNyQDgXFlyDxvVrb9x/JyZlUwVrfytaN88be2EpHZWiKWe49TlRtzgxtHuyImEs7It3JfaatEEluxeedIJDioXNte243oFf+wZTi28wdrHAkxCfOv+kqC/UBmIxLeCTy/2scT4mfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=RBfdOTmj; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="RBfdOTmj"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=1437707645=ms@dev.tdt.de>)
	id 1vNRK8-003IZD-TZ; Mon, 24 Nov 2025 08:49:24 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vNRK8-0041zS-76; Mon, 24 Nov 2025 08:49:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1763970563;
	bh=7chVPCZERRAnG3trSITIQxhj4xyFY+6yUYn8lmvoLfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBfdOTmj+8JOvGg6/6Ihq0IVkSET84D7r3LOCtCHKxOGVuJz6crQhfl7ExY10gb83
	 dFTB3mV6edj+NJSkJB8n7nee7iE2pJbVOq6mBdlSiq6YFyaf5gt6qI7QeZaQRWFix3
	 3TI3MSfHlgv7ZyHThTAP7/hl4mtBpousDMpbN/fkq6fWWVeoaNg69SVDaWGhHSaqLI
	 teLkp1EEgeCbiFjRjHGCMbxjDXlfa1cyoaPEjiGKBe7tZV7lWFs+UUW+/0OG/QCscJ
	 QRp7jJhK3JWmQHHZAgxGbE+YaZdblYVpNTG7+Ole2vozx5Ju0CEVE3xoc3BXEae2Vn
	 G1yTl/B5H2a2Q==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id B59DF240042;
	Mon, 24 Nov 2025 08:49:23 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id AB516240036;
	Mon, 24 Nov 2025 08:49:23 +0100 (CET)
Received: from mschillerX13.tdtnet.local (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 84C0820807;
	Mon, 24 Nov 2025 08:49:23 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: tony.luck@intel.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, fe@dev.tdt.de,
	Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 1/3] perf/x86/msr: Add Airmont NP
Date: Mon, 24 Nov 2025 08:48:44 +0100
Message-ID: <20251124074846.9653-2-ms@dev.tdt.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124074846.9653-1-ms@dev.tdt.de>
References: <20251124074846.9653-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1763970564-7EEE10DE-D438690F/0/0

Like Airmont, the Airmont NP (aka Intel / MaxLinear Lightning Mountain)
supports SMI_COUNT MSR.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 7f5007a4752a..8052596b8503 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -78,6 +78,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_ATOM_SILVERMONT:
 	case INTEL_ATOM_SILVERMONT_D:
 	case INTEL_ATOM_AIRMONT:
+	case INTEL_ATOM_AIRMONT_NP:
=20
 	case INTEL_ATOM_GOLDMONT:
 	case INTEL_ATOM_GOLDMONT_D:
--=20
2.47.3

