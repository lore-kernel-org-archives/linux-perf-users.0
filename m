Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368676;
	b=TDbt4gRfoDUeBpVXXzigKAys/qQJVorGB2uAtvqazChNuGJwiJHmLTrIZrzrKHdjdf4P
	 ynpd0KDs30Z89Ir4QsZQO6fbRYp6IFjUIBNm9muYHULYoJEm+UxdpqpPVs04zchrkT/Jd
	 QxXuC+LdmJQWq+jWHS+xMnn6vsJDcgURs4BvChRS/OwGGwghig/7XjomwdpTKNaqr98rh
	 PSov3a8aIde64PMHfG80xIJKEeISbQQLTM7rT/ndyTf/T16vIUSBqle/CuQBzmEnpB619
	 iw2ggn+WlaxBfCGyvA3R2soMHcMb1nzPFYbt0+Y3vK/vO9kA5o/MOj24snBZ5XdMOEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7Rx2xMMXNqFSdZ4hSTTgyPdyZObPE5Ic1lNABuktusY=;
	b=Jzm6tFmK1yPY6qU0yt+96Yae3p1P1PaV0gltJ2mFkUvhjcaWGkaba+/kUMIuDjgWU5wh
	 BOTq0NVom1XuIWefQvq6pOitLICWLVA/S8ATh/rrzNY1ztup6UH5yAkqF4hzwXRxQU7GH
	 SyaeiGvPG/u2Jiyu5irz8pJE/0F1ano6EcKPtPVn+NV3isF0kjQY4AHuMLLgTSjZ2pK3r
	 0G7Le0RlUQ+60NeUVDggvyLDrTsV7HPD+mMpyHm7UhTDY6aT258lWOBqlodahfP7us6lX
	 d2fWyOmyqFMSYjiauH5wx5FKi7REevIBVwEazJ/gsHxyUdFXKMth0yNyg2Ab90/XCFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lIyqBdXK;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1E606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EC1E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lIyqBdXK
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2185840c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794368676; x=1794973476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Rx2xMMXNqFSdZ4hSTTgyPdyZObPE5Ic1lNABuktusY=;
        b=lIyqBdXKGql3khtJNo74Hqj4TjQMXuuoxuhrMpLFYWjnDtGb8b4AaaXgnFjsD32cUO
         dnt4b1XGFfw/q3SPZhnl4Myui4WbMv+Es2IswVTKSPfbg6jqmWQm/BqmjX4SB8p6CEI0
         Ogmg8yyzC/AlWcVbL0ML32c5HjiPzvp0vyVxrck36MfwfBxcc1xryewy0JbNVuNGYb2q
         CsU3rvFG4zL7scIGYU2C3N+svp9U8d33bp7zvZreYcS2EKZ+WZ2bL3WF617d+kb4xNcW
         H1VGxMeQfLJ+EtYXHiRa9ANbQB/ikMZG9+/1FXsIWt2LYqjcZoJ8pp/TiegEfcsyA6oI
         IOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368676; x=1794973476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Rx2xMMXNqFSdZ4hSTTgyPdyZObPE5Ic1lNABuktusY=;
        b=j+wMJ9c7Lba0+12VbARlpbA0oA5a8nnrXjFfqmenc/IogChRmrfXbTxTV2Zx8rLerQ
         HCrlwv6ON2yknaNcXuEvzzHuLKDXm2l6cHxavAIIVKzkrLyVcFHX6hqgV1oTvM9XXftR
         JAC6BQr5KcfFbh2160zhtI3BK0Qa6QX85Mm9zbMVm/wf5qBEZnZHtXgi7/IJl2E9yK2r
         /eW/mL0ns871zLkK1x5mxrBDQjZu9DqNFyJ0s6ey095aYJPkPmIp95IYeXJ4ZGPQ7bGp
         F2B3puPYhzXroEq40mgmJm/aibjR30lZwExdLbS9qTOaIa4i8rCOHZ/Fs3zCVyHj9e5b
         I4vA==
X-Forwarded-Encrypted: i=1; AL+hErEJv92z8VCVShpAAHuepSLGPZZ4hOn3zopUNsQvHeVUivrdyKvEWc7KvobdDH1SE924ztSiZ8dXoFfHOXqOpAwE@vger.kernel.org
X-Gm-Message-State: APuU4Z/KNSoxtAdCCGCeKePw32HargPgP92AKCNk3hWj8ciTHVzXXtL6
	XhayKeLZyXLV5z9G4Og4Mxwltyx3hHW0zRAqqLwWOjepgxbQon16xbZO
X-Gm-Gg: AYBFou1/qQ9bFcJVdRjAj9C853tjLYv6J0eN16B6gSfozl4t4TB5sL45KhhOzPgtQ3U
	N66tL7BoqWtWu+kf5YxmoNLIznv/LMfXhK2rDsvk49jRoK/F68EVoXPId33gOZnr2UV0h3U4R2d
	5nhF2br+Fr/iKjXDtWePd/9b4nlh46ZyWQAcNBX5uEBfiH4fkJ4ps/c3do2mu4O9SpVqV3+XxYy
	d54/4fn0sHDB8m4zro7ak0tfuxltWviAijh6G1FuwVfpWkyls8PvVJHqAqT4oGc8vJTQVj3J0QW
	dafBr+iKSKDyp1pASQfe/4NDoW+koM5XeDGCnL0GoWBRpT5iHMH2rB398xh7nHJin5HdciTLYoh
	2r33OxEm48k2vpN6VO+3FxhmRjTlZUSn7KJyKoTRL/8L37CQB7rcm95lYcO4ddyFGUUc6Bepv2E
	6RoCM/BUo8B2OyIy58VfpyGVLaURgDc0UA+9CMV0lm92sHUbqywNiEbVRepip6sqp3EYjkhctxx
	eHQafjg1d7f1i/PfWJiadsKPlD4t5C0iPc71ZbwhHgT8R+uogWRbJYdo4l9+4J6/Chbp3NUowsI
	BQYqd5GDsNuWi8h9hzFF
X-Received: by 2002:a05:701b:261c:b0:1b2:46ca:242e with SMTP id a92af1059eb24-1b3c02f34camr1200137c88.14.1794368675565;
        Tue, 10 Nov 2026 19:44:35 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc09sm23664862c88.10.2026.11.10.19.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:44:35 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v3] arm64: perf: Drop the example the userspace counter section points at
Date: Wed, 11 Nov 2026 03:44:32 +0000
Message-ID: <20261111034432.2020955-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111023550.1971639-1-takano32@gmail.com>
References: <20261111023550.1971639-1-takano32@gmail.com>
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

Documentation/arch/arm64/perf.rst points at
tools/perf/arch/arm64/tests/user-events.c, in the text and in the link
target, but that file is not in the tree and no commit in the history
leading to this base has added one.

The section already describes how to use the libperf helpers and points at
tools/lib/perf/tests/test-evsel.c as the example, so the sentence that
sends the reader elsewhere is redundant.  Remove it and the link target
rather than pointing at another test, and move the instruction for running
the example into the How-to section, next to the reference it belongs to.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: drop the reference instead of pointing it at another file, and move
    the instruction for running the example into the How-to section.
v3: the v1 history moves here, so the commit log is the change alone; the
    sentence about the missing file is stated once.  Raised by Sashiko.

 Documentation/arch/arm64/perf.rst | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
index 997fd716b82f..5b9cc2aeb642 100644
--- a/Documentation/arch/arm64/perf.rst
+++ b/Documentation/arch/arm64/perf.rst
@@ -131,7 +131,12 @@ changed.
 
 The userspace access is supported in libperf using the perf_evsel__mmap()
 and perf_evsel__read() functions. See `tools/lib/perf/tests/test-evsel.c`_ for
-an example.
+an example, which can be built and run from the source tree:
+
+.. code-block:: sh
+
+  make -C tools/lib/perf make-tests
+  tools/lib/perf/tests-static
 
 About heterogeneous systems
 ---------------------------
@@ -140,14 +145,6 @@ only be enabled when the tasks are pinned to a homogeneous subset of cores and
 the corresponding PMU instance is opened by specifying the 'type' attribute.
 The use of generic event types is not supported in this case.
 
-Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
-can be run using the perf tool to check that the access to the registers works
-correctly from userspace:
-
-.. code-block:: sh
-
-  perf test -v user
-
 About chained events and counter sizes
 --------------------------------------
 The user can request either a 32-bit (config1:0 == 0) or 64-bit (config1:0 == 1)
@@ -160,8 +157,6 @@ userspace must treat the upper 32-bits read from the counter as UNKNOWN. The
 and should be used to mask the upper bits as needed.
 
 .. Links
-.. _tools/perf/arch/arm64/tests/user-events.c:
-   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
 .. _tools/lib/perf/tests/test-evsel.c:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
 

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

