Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A91642B
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243372; cv=none; b=r9lD2d2+9MsFdkb1SdIcvN0hil6qNUoyaskxcQSGax6uQMGITssH40avFtzgM6IuHOSMyhbB6k7zP/G1XFkJNLCpP3M+WL2vqp1v/dwQU2b15fKUIXbs89nf5eJVr0hZDg1BScbOl7xh0IHyNOi0UJ5IrfRK3Z/w5e+fM/f05yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243372; c=relaxed/simple;
	bh=2TWe1UNhpYvuf5j0SyF5coluYqJTMzWLeUysaN7s6FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvzPSh6oYQ+iY7RLELDcu8cvse7zhFmi73NfugqHc2L7JmgmJ/NoTY97nn4zmNEbV6ZxvidKbXyX5J7kMfTw9xbRBmPo73HQoHOoFeqjP2zxPCFqKqrM5aw3mjnO54/Crb/LglYD8GKBN3ezMPye6I9Wh8CBRHM8zvyRd4clvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secretsauce.net; spf=pass smtp.mailfrom=secretsauce.net; dkim=pass (2048-bit key) header.d=secretsauce.net header.i=@secretsauce.net header.b=jkzjPxPk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YsT58xEl; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secretsauce.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secretsauce.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secretsauce.net header.i=@secretsauce.net header.b="jkzjPxPk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YsT58xEl"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9604D1800098;
	Tue, 16 Apr 2024 00:56:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 16 Apr 2024 00:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secretsauce.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1713243368; x=
	1713329768; bh=hJh6th9/C3UUAGnE7ZPlgNykPTHu/mKpm+LSnHt8N60=; b=j
	kzjPxPkCk2zbCJE1uHTsf/f6SvAoxSJHczUWXvtatMNop4XS6TiEfWxZ1dodR9PG
	ZBnS6sqN/FoN8n6loNdA1pDcbOqTqCpx5tWGLRGcj6wp57Sm+sB9KWkeX6lNT3F8
	NjkbgcPmpFAHYBUfkqJqpbPepW+zTxHsO+sZfryfH2Ksp+dCAvcj4g9mP3moF38R
	9xQ5lJf1EyWKgHxVRo7gBlWHfhPbQJo4tusfajLqu4kEhf/Yyu2Expg3/uFcl2rv
	v2U97UuH5S7/u+cvEiY/N2LWw4afzfiVWrfSggLntWs8eDaC9j+0XUbCTNZlaGfW
	nuq8EzInkVe2jXJEd3HQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713243368; x=
	1713329768; bh=hJh6th9/C3UUAGnE7ZPlgNykPTHu/mKpm+LSnHt8N60=; b=Y
	sT58xElDE6G/48yaVHZVeV7HLg69vJmc2onxAqoc48ASYbBV/upq21dDfNpC6laa
	ul/I+hkdMsQFgLRB8l1WX2cjSr0MKARYiLYcYciB3jE5H1zWFEKWnuLHkP8wbhtM
	a+rGB52VkEfkp+UrPDfpRkOR/XYf304TJlnxYaUz2a5E16rlSHsdcGEsRLxVj6jt
	gkQVbYItgi+tIX9Rq2p6NqweGKjnIbb5Gb1P278xMTSCs1nMVA6perB/ubDIvk3S
	wseYe4gaKyRW3ZM5EhrXYcAMAe//EwSZv7cM/OrEYY3HSlelcJpCfMAxaAbzPW2c
	nG6aGJy7joRODcEQEC/Rg==
X-ME-Sender: <xms:6AQeZmjVuwjBcGIjJ9iBLnQ-cZygLVxFq8GeTGtktgUyaYy0qw1JTg>
    <xme:6AQeZnBpi60cNaDc5kh6sRm4P3Qcg0l7wuSsIaEZ8_h54iansP2vireGS5Jmpc01L
    93EtY9Xm9p8r5is>
X-ME-Received: <xmr:6AQeZuHctm9qN5VW1uxwjaXebUXTwe03NDTenxRCMd-9YX4FEzD76-pd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeffihhmrgcumfhoghgrnhcuoeguihhmrgesshgvtghrvght
    shgruhgtvgdrnhgvtheqnecuggftrfgrthhtvghrnhepfefggfejudetheeiveehudfghf
    ehieekhfevvdfhhfekleeftdekuddutefhhfeknecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepughimhgrsehsvggtrhgvthhsrghutggvrdhnvg
    ht
X-ME-Proxy: <xmx:6AQeZvSdnd3UHIbjbrPi9O1PlSo5RnM1XF1daKYL_V3WnxmwDBqR2w>
    <xmx:6AQeZjw9OWmycwBxB9KvYxtNd22vD1wWRG6wyLwxXBL04YkW8rufWw>
    <xmx:6AQeZt6WmTZeRCFC0Cy7OCXsBtCoyOMEw5yV9PSECI5ezqNaVg2Lhw>
    <xmx:6AQeZgxCNkgudWdB_kCO-7asYHyK-5eIkii-h71iJ1R715dy3V2ItA>
    <xmx:6AQeZu814PcSWZCh3jrSq7pKnjIPHWM4pYRmb5HQe1Vg_Yw9jVclrZIk>
Feedback-ID: i3e8042a0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 00:56:07 -0400 (EDT)
From: Dima Kogan <dima@secretsauce.net>
To: linux-perf-users@vger.kernel.org
Cc: Dima Kogan <dima@secretsauce.net>
Subject: [PATCH 1/2] perf probe-event: un-hardcoded sizeof(buf)
Date: Mon, 15 Apr 2024 21:55:10 -0700
Message-ID: <20240416045533.162692-2-dima@secretsauce.net>
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

In several places we had

  char buf[64];
  ...
  snprintf(buf, 64, ...);

This patch changes it to

  char buf[64];
  ...
  snprintf(buf, sizeof(buf), ...);

so the "64" is only stated once

Signed-off-by: Dima Kogan <dima@secretsauce.net>
---
 tools/perf/util/probe-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a1a796043691..b9f678c3be4d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -235,7 +235,7 @@ static int convert_exec_to_group(const char *exec, char **result)
 		}
 	}
 
-	ret = e_snprintf(buf, 64, "%s_%s", PERFPROBE_GROUP, ptr1);
+	ret = e_snprintf(buf, sizeof(buf), "%s_%s", PERFPROBE_GROUP, ptr1);
 	if (ret < 0)
 		goto out;
 
@@ -2867,7 +2867,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 		group = PERFPROBE_GROUP;
 
 	/* Get an unused new event name */
-	ret = get_new_event_name(buf, 64, event, namelist,
+	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
 				 tev->point.retprobe, allow_suffix);
 	if (ret < 0)
 		return ret;
-- 
2.42.0

