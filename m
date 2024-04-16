Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89E12E4A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243378; cv=none; b=jVfhxj757FJkb8fpVdBHSL95/2urU40TCAKhX9okkImL47YMuYwrRct47F6rkDt2cpHp1GQixwfEIwv9F6yTbxPA/o3KiKAIVaa+sky+SvWN6gfJpA28QDk1ZBsD8Z+zCCuUyWH8MOiLX5Ie47PpuZIXUAj9TX9bnVdMb7mFB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243378; c=relaxed/simple;
	bh=yKMAovenaSLAAE0in7HX32QD2ECPKevK841U2UMMqB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBcvRHvOYQPj4zT2+bTN3x81fEZdv33qTBfXX/SXldaZNqmxtHXCQAVnIqsGrGke6AfF1vL8FogUi+7R1QbQqoYLHdtYOA/4q8S6pdZFQ1wc3p5SGY947VpvJr0G6fc7N/9rw8EpRSUzr3v6zVkrwhnk8g/pst2qWxSSh/VnnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secretsauce.net; spf=pass smtp.mailfrom=secretsauce.net; dkim=pass (2048-bit key) header.d=secretsauce.net header.i=@secretsauce.net header.b=IxdN9H8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QE8KXf8q; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secretsauce.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secretsauce.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secretsauce.net header.i=@secretsauce.net header.b="IxdN9H8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QE8KXf8q"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 3F5D91C0016C;
	Tue, 16 Apr 2024 00:56:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 16 Apr 2024 00:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secretsauce.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1713243375; x=
	1713329775; bh=H4I2Eb1UN2/3y2R5LQ/QMBjwJz02J6aPbuElpLXRn1Y=; b=I
	xdN9H8qmdjFsYHdgHg5EQaTwraoY8cwBDxHSzqtpuFCfs7OuzEtDQtoeVTlT3qDz
	/Bj+uEQOyQWxdMvC+3aXXb+GZqW0zqWJAhUzA0h6iOlPc8VBcAlpxypnTZAnL3Tm
	Wq0sSLXBy8ToyZNrGjyuLGjs0+OupF46nCIr5/O9bgyI6Au26PKNhR8/nTYcjWeS
	Ncda8nSbmPm9b5KNIWtdDSKMyNeX3yG6eOaFv5gl/cTCLjGM5o/iB09Bs5MamltC
	euWW7VOIhBtGI5C7kpQSHZ2urRaltptOtxCoPCmAw/HL+ptyDPaC5HCAIyYCGmZk
	mvFEk9CGSY2UUF57CL9fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713243375; x=
	1713329775; bh=H4I2Eb1UN2/3y2R5LQ/QMBjwJz02J6aPbuElpLXRn1Y=; b=Q
	E8KXf8q9qQFzlBVWsVqiUBYqyBwhpjDc3BAp7v4aXmoFqkdcrZ/6fjbIkNg3TUol
	ZV3FY1r7askL3EceS5x1N82XykTiJlyKUe4ghtUJAeRLneozVnMto5j+PZ4T28Gk
	ebkvy7b590oVgcr4AytpeF1lDQUozYnTEe6ch2nuXTzYrevt+qde4ZE0JDySy5+X
	EgyvNVWfq63ovdWgpapXrWLvtrmQVxRl86izHPRZV/RxJLOHS1pptIzwBJ85zUky
	O2iaSxFCuYDNARe3Sa2TzimvUNjFTO8WBjzzDlxY04WBFW/f20WnTgV3Hea4h0+6
	ydG86zsS5s8sDBhZMrmKA==
X-ME-Sender: <xms:7wQeZrA2FzWIEVKu5Z14OYJDHw4Jp_a-2mqoxjpSO9a09MvWqqET5A>
    <xme:7wQeZhiFOsjZvJnNrOaVd9zvT6Ult602yeNoV99udkezZY8PyeGFOs7-PGVRU1fXD
    HHkTezAc05vztne>
X-ME-Received: <xmr:7wQeZmmT_k1PJ64tdFE1Zjx4UTuOTKhFRLF51KA5eB1KHgmCnBaJ8QKn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeffihhmrgcumfhoghgrnhcuoeguihhmrgesshgvtghrvght
    shgruhgtvgdrnhgvtheqnecuggftrfgrthhtvghrnhepfefggfejudetheeiveehudfghf
    ehieekhfevvdfhhfekleeftdekuddutefhhfeknecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepughimhgrsehsvggtrhgvthhsrghutggvrdhnvg
    ht
X-ME-Proxy: <xmx:7wQeZtyFhCW-Eg9mlaChJRKza2-3etRr8uB5Qjz8GI786nL9W-KjuQ>
    <xmx:7wQeZgRrxHRTm8rF1vzfwrYn5dOjtkzSLbkxZGLgo1uVstUgkxkaEA>
    <xmx:7wQeZgbFXdAJBvJFjD6YRDGTxfs5R0qRQCqZevf32IzqzpWLE3rcZw>
    <xmx:7wQeZhTZFT9qDHQ3ADnFm-HTrNhWmLmJsy4Hl4Kge9R7Q5oQMW6Vrg>
    <xmx:7wQeZrdUKLwR6AVRG1aN7amjVa3w7Oamn9eXMGNcQpsY09ewqapr4laU>
Feedback-ID: i3e8042a0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 00:56:15 -0400 (EDT)
From: Dima Kogan <dima@secretsauce.net>
To: linux-perf-users@vger.kernel.org
Cc: Dima Kogan <dima@secretsauce.net>
Subject: [PATCH 2/2] perf probe-event: better error message for a too-long probe name
Date: Mon, 15 Apr 2024 21:55:11 -0700
Message-ID: <20240416045533.162692-3-dima@secretsauce.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240416045533.162692-1-dima@secretsauce.net>
References: <20240416045533.162692-1-dima@secretsauce.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a common failure mode when probing userspace C++ code (where the
mangling adds significant length to the symbol names). Prior to this patch, only
a very generic error message is produced, making the user guess at what the
issue is

Signed-off-by: Dima Kogan <dima@secretsauce.net>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b9f678c3be4d..84665c56a045 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2758,7 +2758,7 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 	/* Try no suffix number */
 	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
 	if (ret < 0) {
-		pr_debug("snprintf() failed: %d\n", ret);
+		pr_warning("snprintf() failed: %d; the event name nbase='%s' is too long\n", ret, nbase);
 		goto out;
 	}
 	if (!strlist__has_entry(namelist, buf))
-- 
2.42.0

