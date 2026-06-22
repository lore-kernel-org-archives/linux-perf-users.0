Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0F3B6360
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136224; cv=none; b=iseP1ARDAK7BHI8xntWo3QgB1QFZa1QRekxVSnlGDZbxqunzl5zMARjZZ/r4mwh5O9P8lvRSLW6AAF9A3V1CHNHtPtImdnR+20Hr/IZ3RfbJ9QdGF0k5WBbtWVbjsdbivWvulgEtTBNE+NHRCFVFCbx4jHm8Wba6feFqJg2O2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136224; c=relaxed/simple;
	bh=8Gu2tJYFoyb5VwElQkcHWnUWNuKHdvLf5o6HzO83OjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IC+lR1E5EUSKhqx/Yv8Yink11Hf7U2iYxe3WlrwZaIZQ1gb2DAdx1LlgtsLApm1XpJy8F2kTPuJptNg4FcBJO0qFXFTs6W8r7OmpSTw9CrEPYeGMh81XH0PTa4+8vlZk8L7HFMTjU8wH/ICXlFwIe6E5G9Z36BTRdIXNRfGPM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXONoZqw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXONoZqw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8453a67659fso2373070b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136221; x=1782741021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsDqfnUc8Eb+3zE5VclFey58OVxE0obrmPbjDO3qhv8=;
        b=LXONoZqwb7cOj2OJ1Ka2srmuy8nUe9kRixfTbAMLzsgMpwr6kXSBBTOx/E1lEOhcZ8
         GaM7xWe4HFV1TeR1DAufLz2wsrJwGjHYj+RzmFLwbYoWi+zHc8qkDg/449CvN7GcDYyQ
         8H8YahA6xApxpQ1O6Ed5KIxzvgYCIDHR/nR3JGoC5gxhoAy59LsBBLLdU7PdiyB6gm8z
         HKxs36tJrwCOGHxRYVcTxFTY7f13hgDBI4yqDaDLZhMPyBVjnH2VetiUKQ8gKEwsRCaV
         BUwAA5Te3TUcuatUjrRoDjV0f9ZOMABzwDiarcPfkBJTOW8UK9YadcpS2APUoi/jnHnn
         yhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136221; x=1782741021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsDqfnUc8Eb+3zE5VclFey58OVxE0obrmPbjDO3qhv8=;
        b=Z60r9YKHImvYw9vXS8k/YJuQ5B5G0n4LpuTaDMoNbKyGEYfiwUGjmr1bYjg2BbCN4E
         cHj96qlyOR9ImJDJhgGvoYkXAyl4vNXm/UvEqeLfrjYpdHplTgR0guhMUOvlYlOtLO8r
         sRYCzzUw2FfDXOKrxkAMuQOVgt5H8KwUhoU0nLw3SjPlbiArBLfjJMk/0b1PQg1H1sjc
         gowyHkIIN6SOecc5vxN9QxU9X8HepRWozB7tQgNBT3281I5KjHlrxARHIXEUCSS5DinP
         i6qOxT85rWX8bwSEYimxdLQGI8x4X0loXYiZ6GiUs0qJbKA2ASlq+F+u0qXXY8ZjLyXQ
         mpnQ==
X-Gm-Message-State: AOJu0Yw+1dRz/2Q8fQnJuXCyd9ql1TiOZDREdlpjgmWVSy5g7VqXHFsc
	Z5RLb9s17iliE84edhGR7SGH3HXfWP49Px4QrahMvzcEla5NIja+UsdB
X-Gm-Gg: AfdE7ckzhZMeF2qjIsl7+k+P8Y5w2mlmsv9p/5oJkF8YcYLLMqttGWLigIEf/TtwWJd
	xi4rQpwEVJba74WbpbAZNTtu1trjc2yr9jtUklX/jFrD8BgceAQFcPmvsC2hzAhIarnEkdyGp1z
	xYYEIvjcGj9eeYsqHaNmMPuR/ZRrrq07VnzWI98bHAZBDeXB7E4wrzsQj1RSTCR4XcLvQMsR9nN
	LEAh0x2ZLXfpIkgPVQxIyvfYDN78tT5iNNS8gSWgGjXMBZNFPoldXVQMF+f7kv1ec01NCaTqMGC
	h61glErGAeNp8/awWWmHEE/ZVmuqJhSG1z/lcCnRdXBjZ3PU7ayPnO1nMhxJnRJo1zI+S4S+6lf
	HkA4ZXSWtbK1R0WK/yGuP0FjszFCyXhg/Laxu2ZvgwsR6cHWJnsd8AZ3rgYdTypd414BIWHU4cl
	dJsxi4F3H5iLC1PTSjsYZ74jjZTg==
X-Received: by 2002:a05:6a00:2d82:b0:842:2280:5386 with SMTP id d2e1a72fcca58-845507bcd5amr15524294b3a.16.1782136221256;
        Mon, 22 Jun 2026 06:50:21 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:47f:2522:acac:f810])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea146asm7606177b3a.43.2026.06.22.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:50:19 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	ravis.opensrc@gmail.com,
	akinobu.mita@gmail.com
Subject: [RFC PATCH 0/2] damo: support perf event configuration
Date: Mon, 22 Jun 2026 22:49:31 +0900
Message-ID: <20260622134933.35773-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims to make it easier to specify the perf event settings
proposed for DAMON by Ravi's hardware-sampled access reports patch set [1]
from the damo tool.

It consists of patches for the perf tool and the damo tool.

[1] https://lore.kernel.org/damon/20260529165640.820-1-ravis.opensrc@gmail.com/

* perf

Akinobu Mita (1):
  perf python: Add access to various members of evsel

 tools/perf/util/python.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

* damo

Akinobu Mita (1):
  damo: add --perf_event option

 src/_damo_fmt_str.py |   5 ++
 src/_damon.py        | 106 +++++++++++++++++++++++++++++++++-
 src/_damon_args.py   |  79 +++++++++++++++++++++++--
 src/_damon_sysfs.py  | 133 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 314 insertions(+), 9 deletions(-)

-- 
2.43.0

