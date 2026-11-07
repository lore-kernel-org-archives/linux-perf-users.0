Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794048546;
	b=zxoBa4RVHk+f6+gXuv624j+YuyiLO77zDx5KZQL/9xQ+u8al3qUyQutF2/ZVeDAtnFnZ
	 TH30viiGa8GxRTbRDlPi+F1XdO0k7aQvzGPVIwki4L8oE8fsJ9K4rO0phqPRsbJ25ZbCg
	 nymeHL2vVk8L4DIZlZzNaGuelo22D9l5nVenpVu+xQtztWjLmlnkHoO3f0pWzy9lrCi7j
	 ner/mTnwWyCsj+cSOtHoJztezDqJSWNR3w3xOWVDEL2R1UfYqSy6PxEpIM8/rM3k1p0At
	 G4C5aEBzTCc7tLTPO4BqjLoXfl7xZc2qO8ULaeXkB1S3asVG0LZcZHdbpeuyQmR0GWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048546;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vIYgct9FxdEdL8Nwdi7Ov80zcE71hXhp5102ksEy65Y=;
	b=saURBOVEUN+0f6zVXyTqPpMO+Qw2x/z4NOAw2IgF75n7sADlMrY4DQD8IdYMxvjbEj4v
	 VjOXFd0PU5mbnmMInczj2nP+Pq5o1ySxlbaRhLNnMQlCw6/Ld4tzpxXbisgvKW3YpYG5U
	 bHdOKAEf5721f6L7Urfm6LXYvcZfDrPnmSZ096X2bgII1DwUTU9j4j03lnRn+7yokTNSx
	 EsByugw2ajaL6uZ2n/t97PPA2ru4+CPO9n2p6JSAUBA6DGZWvyZ4Vm1N2co8xuBsYdq1t
	 zkbaKPTqePcrujcHCjca+q53P7Vb71PiRZEAL5dE5gHcjEq7TVO1j+rc17ATKSVNahA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7nBQC8k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C143606A333;
	Sat,  7 Nov 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7nBQC8k
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794048546;
	b=zT3PUvKOMnKur9dP6GlyhJNOc3I9UV39mCzo/q05/vQ5uChn/jfrTSmqnpS7Uterkpvw
	 X/3tV46CWzdkn8k9CTCHg7mkteMKCngf4lYAYtLD4pc8LRqT1Hzip9ppIjV6Wr2SzZ/Sx
	 DuZ7cSTFiUk7PD7Oc5V3030jTsuFosccpdoiSVSUyhVNmKOrqoI7cNaKo9obzIcXIiOjY
	 mK88Tl8v8i6q4hJDcGYxSeomx/Ds/3WS4yKD5ZFN/LDwA4LsnrY2nALn98+Fc54sGSjzE
	 mntkkrUmW6o+aY+z9hFnuMsXcfxE9Rl1sfFrzvTfJaMs4CkZhAMZe79UrYugOexjkwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794048546;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vIYgct9FxdEdL8Nwdi7Ov80zcE71hXhp5102ksEy65Y=;
	b=Jx7b1LlaXHaz3sIOre+IXcxdcdZtJOl7euTx6CNM8MRqhZcsq/2PBDHKNcs915DFKXLu
	 maW4ulDuzE+TD7JhDI2I9+1+IDj1mOVfk4iXG8/JAJy/Egy42QVk+WjlLdjVTS6HHfdIE
	 TlE6MfOZGmwvQfyU9rFCEoFWnpZzf5HjfUcKWXlM3y7k+O2BJVCxgk5xXKUjKdFzn7eIY
	 bpc/8fbKs3es71dtBua7idkCu/0niLZODonwENne6m5isg3fBbjH3Sqk3cBfRAEMFX856
	 3eHQsGO7NaG+W7VbOeMeZvguIVnhMJy6piayJh3M2Jh2+imDMI/cW+2ue0oaznxk3hA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0B3741F008A2;
	Sat,  7 Nov 2026 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048546;
	bh=vIYgct9FxdEdL8Nwdi7Ov80zcE71hXhp5102ksEy65Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Z7nBQC8kyTKj6pW+T/+5no8MU9flRduqht6Xe2Hg8h2v/Cwhgk2GjP7JKF9zibNd9
	 kTW6oPKjtsSbopQVY3UN33JBv+gKFn8mIYFT/g4qv3QeDlStOpoqMwQEdj7i3cr/2U
	 m/VUt/VSxt1eckFk56XnBu6JvasbWWHt+fLrAxJaqzT/3U7hPdxPRHyxX17pQ9ahsY
	 YDRefqVHqmrqU/hiHBV0v1FK/FNUSGng/gBW5SaO/55ybDlV0/wjt4x84Xuu4J7Oit
	 f3KMqx1ObVoe4WLhfEyQ0tBc9+WY75fxn39otEaYUO8Ayi7GFqZDzrvXKy/TdmPAuc
	 nbTwsJF551k3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 86F9D47B76;
	Sat,  7 Nov 2026 10:49:04 +0000 (UTC)
From: Myria Sarvay via B4 Relay <devnull+myrialsarvay.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 21:48:49 +1100
Subject: [PATCH v2 02/15] drivers/perf: apple_m1: Remove unused variables
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-m3-plus-pmu-events-v2-2-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
In-Reply-To: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>, 
 Myria Sarvay <myrialsarvay@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=myrialsarvay@gmail.com; h=from:subject:message-id;
 bh=EV9fXCfpL3fKlyENxSrnQelkd6v71gDBFcBUcbGRPcg=;
 b=kA0DAAoWUkRBGKit/ukByyZiAGrvAhuiEb8Z1U79UtMuB3jppw2vSZr9YBVd6ehn9EEHlYM5m
 oh1BAAWCgAdFiEELzVmK5MGgNJ1pkW0UkRBGKit/ukFAmrvAhsACgkQUkRBGKit/ulGHQD/ZBKe
 pqjGQ6JyFX3Qkph4r3K87D0/UipcTgbP1BRt11kBAOos0/WKS4V4c/u8rgoYM9oFAk67XawY2h1
 r7RuF9jcC
X-Developer-Key: i=myrialsarvay@gmail.com; a=openpgp;
 fpr=2F35662B930680D275A645B452444118A8ADFEE9
X-Endpoint-Received: by B4 Relay for myrialsarvay@gmail.com/default with
 auth_id=1027
X-Original-From: Myria Sarvay <myrialsarvay@gmail.com>
Reply-To: myrialsarvay@gmail.com
Content-Transfer-Encoding: 7bit

From: Myria Sarvay <myrialsarvay@gmail.com>

These variables are calculated elsewhere as well, remove the extra dead
code.

Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
Fixes: a639027a1be1 ("drivers/perf: Add Apple icestorm/firestorm CPU PMU driver")
---
 drivers/perf/apple_m1_cpu_pmu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 1f73c8a77462..de4026c63afd 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -421,13 +421,6 @@ static void m1_pmu_configure_counter(unsigned int index, unsigned long config_ba
 /* arm_pmu backend */
 static void m1_pmu_enable_event(struct perf_event *event)
 {
-	bool user, kernel;
-	u8 evt;
-
-	evt = event->hw.config_base & M1_PMU_CFG_EVENT;
-	user = event->hw.config_base & M1_PMU_CFG_COUNT_USER;
-	kernel = event->hw.config_base & M1_PMU_CFG_COUNT_KERNEL;
-
 	m1_pmu_configure_counter(event->hw.idx, event->hw.config_base);
 	m1_pmu_enable_counter(event->hw.idx);
 	m1_pmu_enable_counter_interrupt(event->hw.idx);

-- 
2.55.0


