Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8603DCDAA
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793744; cv=none; b=izlWGvSTcVAwDsuW+yF58gzCcso146O6Mi19GVb+XpZMkBwvW8elQlke9cJiIBQYoHjcV6TlsiHYKFiVQkWIAdbqdHB5y9J8S8j6bMg448hcI0Jwo1oyl4TXjRsFKhFRcB6Ym1DhjyFNRhbH9h03P6HkQyBH4hg213pFAoS8saM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793744; c=relaxed/simple;
	bh=P/pKdRei8jx/tOTQrB/qlG1u0fUwu1fbJ6Xbz+8xctA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KidyacV69Iyt4Et4X2ul4OaaIZwKB17/ylHHpRvKYPy44euLS7DrbdWzv7kyChJFJy+F5PMVP7Z6GJxSW8+FLtxbM7yWRArMWfbWpgNShUvCYZdxC/oFQKQEzouRCSzWzN4NdeU8+4SDI8jOMqEIOl3bvA6XgWlQZMASN3PvG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvWhGL4c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvWhGL4c"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so35943345e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779793742; x=1780398542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spKmw6C/CWUs2h7LttH1c5jMAcdZbJ142k6ouAspZZU=;
        b=WvWhGL4c0pMrSicwbyxAiuAUf3rX2D0vzkc1Ho12wQMUK6WmmRh3dAYVE1wpt/0CVW
         v7VMkYfBGmupdJJa8iHngQxDNN1W3DR+aIBq2xLE2lriQX/SQYXCabPjp8m92JPI9cLx
         essan4WAD8RT5cp2YB3xTCQmCQkfruwF7SOhZ7kOja275sPbySs+DuidRprU8L9yjD6v
         0m0A3Ey85pu/Svl8sLyE0B1gYsLoTGO2XtAleobWCthNHSladn6a3M35s1/kG/nfOEvw
         tOQnuuIvTg1fp2Qs9fL+LxQb6WJzYjodew40bBZbF7ljDKxu99wluWSU98zDpGaqrPF+
         N1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779793742; x=1780398542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spKmw6C/CWUs2h7LttH1c5jMAcdZbJ142k6ouAspZZU=;
        b=V58lb76S2QyaFu9gr5QkHy5rx/eIOAifjy+9DjVLPVx6SKqn6QJI2+K4+h8Cq+dSs0
         ENZNrcGrvZaU96ziszTT8vkpnjtC6ob7AD9G2ZHxSMwhMOvw9SLPD4xM6Fr7tnRL1YT8
         FcQ4NWvhopXGc0H/HXlta/+t8Mli9tEgkwcFnHIzZAJ5rVCvKMl5nURp6Vmq+15R1yu3
         kgbqa7Hp5TwwSC8O4UltkBBL7/VhUCncvTqvpDPvN0mUDtLu2XYn2Ec+fLE843WUIIWH
         BgWYZ181+IFJdrFSbBTmUA5NQJihDZtdR9GFZaV7Op/ZHuXkAfhWW1unrczEN+uSdphO
         2ERg==
X-Gm-Message-State: AOJu0Yw+BYLDxCIf13EM8ixHFQeF6puNF+evzFprCkgDqNT85k8Ux3in
	Fd33CozPtBndW4YXRrZFasJOq9zX3LQBB08VnAseuVr3NL6N6UzIeI/hO7IQymPL
X-Gm-Gg: Acq92OFcfwBxFMeF8oDQ5BKkVvRpM+4MLANRxuhe6cwGAwVOtJ9Y+09nXX+9yvROORP
	YInIgDHZa4V9DmiF2PesHydbVDdh7xJhoTbZhjIOR8qL7Hnadnds+brM+viA96PV5tO9H3D1kMA
	uLYkmCKwfD7r8vtcgmM+Nq2kkmeqVL40KSTWUE8flYp4EM9MCFAjC5voMk4n1acrMqvwverZ/Be
	/8ftA9DSR2VSZPpwoZr7kWqe03mLTnP5GZMYn/WnbyXgDWpk8EbxshvtF+BWQmA/X4+mVoh12Vl
	dIOTVfbLlzLIE0mXoJe6KgXO79smDaVUASqq+CLN86myEil7JMmy+MeKz9cUU80av8UkcVjOk12
	+WvMwnEYkVzyaGgAv9jzh/bwx+hO9avx3TKyDmkoC8KQHaQwJEgElOEzpDb3avYYv9VhAFG5QIB
	epwWxPzVJta2R1BDfoZprunR28mAXZtcJ7LNyT+BON1YSKwmiHdALlmJFuNwsiIOmgF3xufb4xe
	t0wDDqIlP00+k5mFQKAbkyzBdJ2SA==
X-Received: by 2002:a05:600c:698d:b0:490:601f:d77b with SMTP id 5b1f17b1804b1-490601fd94amr185023605e9.0.1779793741571;
        Tue, 26 May 2026 04:09:01 -0700 (PDT)
Received: from MiguelMartnGil.uab.cat (wifixm-si-gw.uab.cat. [158.109.94.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm354162835e9.8.2026.05.26.04.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:09:01 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Mart=C3=ADn=20Gil?= <miguel.martin.gil.uni@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	=?UTF-8?q?Miguel=20Mart=C3=ADn=20Gil?= <miguel.martin.gil.uni@gmail.com>
Subject: [PATCH 1/1] perf util: fix perf_exe() buffer write past end
Date: Tue, 26 May 2026 13:08:52 +0200
Message-ID: <20260526110852.7259-2-miguel.martin.gil.uni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526110852.7259-1-miguel.martin.gil.uni@gmail.com>
References: <20260526110852.7259-1-miguel.martin.gil.uni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

perf_exe() passes len to readlink() and then unconditionally writes a trailing NUL at buf[n]. If readlink() returns len, the write lands one byte past the buffer.

Read at most len - 1 bytes and keep the existing NUL termination. Also guard the fallback path for tiny buffers so copying "perf" cannot overflow.

Signed-off-by: Miguel Martín Gil <miguel.martin.gil.uni@gmail.com>
---
 tools/perf/util/util.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 25849434f0a4..2c2a5c449ffd 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -419,11 +419,21 @@ int perf_tip(char **strp, const char *dirpath)
 
 char *perf_exe(char *buf, int len)
 {
-	int n = readlink("/proc/self/exe", buf, len);
+	int n;
+
+	if (len <= 0)
+		return buf;
+
+	n = readlink("/proc/self/exe", buf, len - 1);
 	if (n > 0) {
 		buf[n] = 0;
 		return buf;
 	}
+	if (len < (int)sizeof("perf")) {
+		buf[0] = '\0';
+		return buf;
+	}
+
 	return strcpy(buf, "perf");
 }
 
-- 
2.43.0

