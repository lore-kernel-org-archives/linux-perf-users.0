Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703167;
	b=E39nrkhS8ixmD06rGR62eLzmgLSL92kUH4mF0SzV0T191N9qOP0E+4sB1JQqD8WE/vVs
	 XlR1xt0fc8tyMon5TzisrpKcZMUOHlyCGxSGHhriaQUUK4mjQLx36S9XGC4EzqWQEWYDT
	 izEJz62mMrijvP3EQoFcOizwoFgikNmIMaoJtOZF2N2UQ3g2ERqZLb9VjsMrrUBWPY7FG
	 NobOo8jmgwyTSEXNWUu7PP0sTRBUP7EOpUuDZMPlvzhILU5h/mC3do6w/9ZPr5YJgzY0Y
	 xKeoBhNpNXzMcigVyrA4jIBRS32PZxPzCGEFy5B6+siht1cnXFbWOYrZsLvyraEsSlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=In7taLgVFQA5m5lyqlspkXmcysL0qzWGD5dgQ5EARs8=;
	b=OgxykfbA+Y1U+qfndsHHHtRvBsY/9Tt1Ec42a7sVUPASOQFgLASoZzOE8pI8HqxtK6jn
	 Dch6OiOCSxPGPwpxvjjvYhwcPCw0JBGjWUTInM3Y7kDryP57GhSU+F52oGTl015z6LKXB
	 A52aM6Uc48hmaMi4LFRPXKg1W1pgaMXvAp7fj/vWaQMGrw0tcX1oC4DnsZN6jKzWxnoKW
	 qPrAhwhNitmvP7tA/JWuFLG9drYgS16dhmUQ5ZWDKENhcFehkLXrX2vzAf25FckCNdYp4
	 NSme4ZK9A1sW7pTzbiJcN3DvspgXpwVSq0LPk66ALVhakjN3tGQtq0jICD3hOO7opPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wY4VLEuA;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5D606A88C
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A5D606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wY4VLEuA
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67da3d03263so387461d50.1
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 16:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794703166; x=1795307966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=In7taLgVFQA5m5lyqlspkXmcysL0qzWGD5dgQ5EARs8=;
        b=wY4VLEuAA/KIJHVw2y14bVt/1IvnsO/2lsrfS8dK4/JtUzG3xMEW6snsr/3mCLEXD7
         /mJQynQBbXcOLNoWe8G4R7cHwLNgJ+XEkbok9KTiv7iB0AswS6KrWpmRRgN1R0kts5sM
         hkw65/63Aayu0Ktdr9sZk3nB7aNJRQ7ua3qC0jQBuvUgKUgNycGdIdUZVDo/qDV1t1/o
         iq2gM5zcEyGIov259kJSpHRB0K+hDEoSS6KbQT/khsZiv4SwtbyIPbo4iIWiQWJBL8bY
         cBB5gsSykgmAICevP72uRUoeEwN4wGdJ329zOmhH2UsGLFpIkFAV1RNmq1bRVYDtOdWK
         R/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794703166; x=1795307966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=In7taLgVFQA5m5lyqlspkXmcysL0qzWGD5dgQ5EARs8=;
        b=BlhuneYTUpzOiv8OirSFD7BS7uLVuxnahHgqzIAzkt1faZ0M2tRzVX4vXPMWuB2db7
         zUzjcf/Rsjfk+CmYnuf6vMcrQOql01SFAliZ8Lt9QXb5fg2jF50knyMiqFGjhWV2jZU+
         2QTJqm7k6aJs1O0MLy+lmEgqc69+gFdzR3uPbfJHD5hvIjYNbN+FEbG2KxucodYC8g1W
         04gKByfrX1bxfhc45XhC81/MZCahaSGTXWMpS8pP0Ht38T3Sz6AENKrcyTFUb42ny033
         UpBoz5ja4IqX+xP2uAzaj5HEqiiTKv492jrqwlifGP4/sCR5P+7hqG3AKBnzkWjKUa+P
         bBmg==
X-Forwarded-Encrypted: i=1; AL+hErECSCQtviUOQiNa+gBjmIOa2mTAd5YEK3NbayUO11uW1evGaXwDFaor4T03siBZXU+U+8hcgRmTwVOwfUN/94pA@vger.kernel.org
X-Gm-Message-State: APuU4Z+pSSAJ0cymPpLxX2EgBL15Vi0XNt1zfTO2Y2il9ZNwZcwpmCmC
	v/Xqt7sSgQPItTWYtGxVDjJdg5ZsY+NegPFYEbOgkbk1X7AziaThLSv6VA1rfoG7t+0=
X-Gm-Gg: AYBFou33MZEQZvk3rTzSsybpGNjKksyH2c8cZh57BkpjiG5zIyWvEn4vpztSuumDw3U
	zQpMh1egSoY5Ju8iSKoShOp/8LkD6QEkml8KuTm1jnbV4jEWzDGn2eJI96kPAWWcv5jUFPx5E02
	7sEGLa1fjsN3hL30nz3guEZYmqs0Vbw50s+ktBoghhDgj5AfmfpC2/J4cEpT1JHP//9N2SEmJRI
	uYTQ3sYRBh895IAvu961pSFgarWGf3Jvp/QXLNqpTudAC5I+hBYOPgBswZV74AvRfyC4wcYQawV
	U5KaRz36axQRGF+0/ohAchbpn2+U/O+irA0XBWQvfCa9NGQRAeLOei0CTYpDZQe8b/Q0xtCMjKc
	lnuubOyjMDsZENDhlIcLluGsUD6TwJCTjuPVybQuZDBteH8DjGTRFZBktATme1cfV8XeXDzSEae
	dkOhDDk2vxDVBiSBWM4HYMfYxl6ZsxxWlqyKJ7AySPYTceoM+/bmwFfRFHDzE10rEmagkUtCJa1
	iWBmuXZGDPmS9yXcv/N6e7SxFSYwZYxtfepoVwfJtGIhkXgJuVnMjguHBrUDXPudcNS+cWq9mfc
	17Llrmbruc7nGmC17T2rw97ePMJLzVTPQNqwbKr/EHuJYaW5Sf8JRO8M
X-Received: by 2002:a05:690e:4894:20b0:676:a43e:ea5d with SMTP id 956f58d0204a3-67d89716d43mr2084844d50.94.1794703165433;
        Sat, 14 Nov 2026 16:39:25 -0800 (PST)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm189602d50.19.2026.11.14.16.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:39:25 -0800 (PST)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: adrian.hunter@intel.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: [PATCH 2/4] perf python: Add clockid attribute to session
Date: Sun, 15 Nov 2026 00:39:14 +0000
Message-ID: <20261115003916.1873857-3-lalitmaganti@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115003916.1873857-1-lalitmaganti@gmail.com>
References: <20261115003916.1873857-1-lalitmaganti@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With perf record -k/--clockid, sample times come from the given clock
instead of the perf clock, and the clock is saved in the perf.data
header. perf.session doesn't expose it, so a script can't tell which
clock its timestamps are in.

Add a "clockid" attribute with the clockid_t from the header, or None
if the default perf clock was used.

Assisted-by: LLM
Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
---
 tools/perf/python/perf.pyi | 1 +
 tools/perf/util/python.c   | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index 5b68d70c5216..71bc7719ac5c 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -500,6 +500,7 @@ class session:
         ...
     e_machine: int
     is_64_bit: bool
+    clockid: Optional[int]
     def process_events(self) -> None:
         """Process all events in the session."""
         ...
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3ba3ce0e651c..274c66c28c1c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -5330,6 +5330,14 @@ static PyObject *pyrf_session__getattro(struct pyrf_session *psession, PyObject
 			return PyBool_FromLong(sizeof(void *) == 8);
 		}
 	}
+	if (!strcmp(name_str, "clockid")) {
+		/* The clockid_t of perf record -k, None for the perf clock. */
+		struct perf_env *env = perf_session__env(psession->session);
+
+		if (!env->clock.enabled)
+			Py_RETURN_NONE;
+		return PyLong_FromLong(env->clock.clockid);
+	}
 	return PyObject_GenericGetAttr((PyObject *) psession, attr_name);
 }
 
-- 
2.56.0

