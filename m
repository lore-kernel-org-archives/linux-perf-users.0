Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DA38D3F0
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793743; cv=none; b=cWDzw4It4P/WXCH48OqWlBQDj+tAWvYXrG7tgWIoKcjixvm5cNwoGbUdGwBbV87odefXUixRUjFHc0d/kIkPpDkyq9Hfr2Qf04kYwhFlCNgzx3cAaiMiHn7GWFgKl/rJp8fS/r7V4vcxID3pYyjD6Pa8w06YDHgNE4jDBlDZews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793743; c=relaxed/simple;
	bh=G+SaZtsPGICMMRXKLkXkaXrOj8OjEwMS59vMa1iZH5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YYuxgF/BBWVhh1rKyB2VDnBh/Ze+FgK1MMMPZFLZ1UXIMHbMnBvp94pEkklHt8+Apmyk0FJBuk4yI2u8x34gqkFocWeCoNSJaPuD5QOv4dC61EDWy2buxTYVRzKmoNoNUGP2fXtDs/aykkgp7UrebimjFn+aoCX+xgHfk0O3dhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMgHPqG6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMgHPqG6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49040362e4aso48469085e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779793741; x=1780398541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MAzFpkY1EBbeS/4IQl63G444h7xlLlXRk2dpumz+FI=;
        b=sMgHPqG6ZIGFWbGT+Wz8v10pmxv53foTp6awAQH4OyMna6nvuYM/gWwE2GoXnQzio4
         S1hPEUsEF24NW54MtvHTco1bC7e66Jr9Te1eCQY4Rc5tmGLsTfYO4LSobh/iICj7P+4b
         v6TKKEsS/pZoX2YyOiOzvqkg87PA0eXzaExeyoFvtmAHdtC+3+z5kW3YaCB5J3+yynOr
         u2wieZCqqeo3oJw1NlAvyL8MtUajVHKOBpvUa1VNz/X3vxSzcIvl59TOPJiJ8V2WkWLq
         /CsOww73Uq1xNb1/ZnKu1+WKGM1qkWV+O3OTpEyOZuI3rue6Lw+/Pt5Y03AwvRUIeEZJ
         PsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779793741; x=1780398541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MAzFpkY1EBbeS/4IQl63G444h7xlLlXRk2dpumz+FI=;
        b=mPYYk80MtYHYyh6jDbCG9YNZ7hJn4hbTECuxHm+ouC/DMFeFDPoIkLKdck9secCLbR
         AZW6d/OnMbSdZbIfxF8Rc7iSPNgmg1n5ar3WPaguEdVE6EBgLHjEuxWYEkCn435Q/mLM
         WHs2MuzYxJ2EFauKhPmH82KWB+0FWbT9k20l7CPbDRJ3rhR/ND9rn2LuT1Qsgpw6j88R
         hdemRLvx09XvDKr8AqwQ8XjW3PykrPWoby0cvTca4EdZfEE4kzzoW8wThdu0eW5/lRlu
         dFjwDZabEaL2IsJRU6NVy7IRn9RK9PZXdHkn7n/dORecc6Bq7Xd49cfn25l/ri2vUPo1
         ngtQ==
X-Gm-Message-State: AOJu0YxNFGj3ksr/+NGN1nrPZI6fmjVaNu+GUUgFczUcOzFIhFPqGoXP
	PJuUtxoziliz0FOV+ZJVQlUfQF9zzPTcHmnrfVUfeQ03hdMqFV71XkGqjmfYphUY
X-Gm-Gg: Acq92OEZhAJocIPXdGQWteHES4AVZJbXwZo7/0KoDNIq2WjfTNRDsT0pa68cOuJTY1C
	/m051ep5Xj2VBqbL7Z7wpZmixSogkf4jIDL88HePqt0SRd3Ci2HET2MFjTuHqvPBysGcfAZdFMh
	9Mh/I+fAAIQIMg11zoIz7k3E9BBmUIB1hRjcshJFmBETrA686VdBiP+SWzqTZyE0jerUlpJSmPr
	lEGsqnyWWdom0Elry15pRgv3CQveq03/ChM7TppJ2vEBTvYHLjJ6BoWDMvRl0LkOiZpw4uoflop
	yksttuB4Eflv/CNjd3RnWp+GRjDzqNQBg8WVDeIMjzibGrZYOnFmYa9kiKkMhh5n5uaJgcwxHEt
	H9zTKY6P8f0Nwdo3WTeF/2WZTfEzMNSVbfU38BqibkFwfYs/In771DPoMcZ7MNEQja3JK+kHDTi
	zfrcumm1k8apmwduFUO9qo/5WEd+otjTdYMXx4/cM/rSk3zEhvyGzFO/3RPC2GWWvZWmvpNgfLQ
	ZYu6djPhwLmtJQgK9Dp3Q66x8TYhXQVDJB3a58w
X-Received: by 2002:a05:600c:c8d:b0:490:6869:46d2 with SMTP id 5b1f17b1804b1-490686947f8mr105465335e9.0.1779793740399;
        Tue, 26 May 2026 04:09:00 -0700 (PDT)
Received: from MiguelMartnGil.uab.cat (wifixm-si-gw.uab.cat. [158.109.94.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm354162835e9.8.2026.05.26.04.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:09:00 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Mart=C3=ADn=20Gil?= <miguel.martin.gil.uni@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	=?UTF-8?q?Miguel=20Mart=C3=ADn=20Gil?= <miguel.martin.gil.uni@gmail.com>
Subject: [PATCH 0/1] perf util: fix out-of-bounds write in perf_exe()
Date: Tue, 26 May 2026 13:08:51 +0200
Message-ID: <20260526110852.7259-1-miguel.martin.gil.uni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

perf_exe() currently passes the full buffer length to readlink() and then
unconditionally appends a trailing NUL at buf[n].

When readlink() returns exactly len bytes, the NUL store lands one byte past
the end of the caller buffer.

This series fixes it by reading at most len - 1 bytes and keeping explicit NUL
termination only within bounds. It also hardens the fallback path for tiny
buffers so copying "perf" cannot overflow.

Miguel Martín Gil (1):
  perf util: fix perf_exe() buffer write past end

 tools/perf/util/util.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.43.0
