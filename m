Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3530D410
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278160; cv=none; b=cflNe94BTPOYkoduIq95muc5tK/FPHYCaDD4FcOMjr3VD3aZTxZn8JR6ZouG2LZy7x6wc8wG34szm6uLOh6DQS/qAww2p8jymGq0IpUb3jeDVVndbY4s2mA+5nT9LIdAydNw3td38QafkaQRDX++0QSNBw8u97UCbut8boTRyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278160; c=relaxed/simple;
	bh=52p9b+nQo+yvAqDpr5669J9XG+VGWdaPiIMRh7PK6nQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DmwFYMhIcxWV/TiSAkntGrCsx8xaCDgBXZ2cFBNSs6cOejYOkOdYKt6LsmVCAg3mg+nhnSAWG5cxn9wCBxbJHll2l0VhDszy+Puldyb7n/IRXD4wuwhgxI0w93pjGtkJ3iMoPH1kBlCyBSWA+C5mdH9PCf+9rvAiqAKcQWREhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcsxO/J2; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcsxO/J2"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137fe4a3640so987783c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278158; x=1782882958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOti1EXRsLraqqB7gzbno2f6V8lGYOEthZ7YUw5Cn+A=;
        b=mcsxO/J266M8m9VOq4ZDwvVBvDxePK9q3uhrLfCbcipkEThnAwuQNReL2TgEt7vfO/
         ePkwkYg/2RhrKlzO0039ffr1kEKAYr7TDro6NCtO0jp5I5ME9e2CKWUB6+HR+Ox1DKR4
         TkFzEtFuXkYMFMPqUtx4Xv9+Tc4dXDYIX2tvhh8BykOg0p0tjCCPE/h55jr0aQsAAMvW
         +pyiHXOlrhiECj/E2pzTHJhUJjpLiHMg+uWProp3DZ+N4yHciFiBNrPfNTANPzP/QmtN
         OgfEejyCoxavwDmvdq60EFmXyoAZtVjqb1CSlH4jutYEIoUNn09osqlTzttkNFp2XDUI
         6khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278158; x=1782882958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOti1EXRsLraqqB7gzbno2f6V8lGYOEthZ7YUw5Cn+A=;
        b=mNm1eSJetg9YjcMXi3n3dGr2JybJW/9jFK9eCocrdGyCTGJ8p/irfRI3rzW2Y8Nqhl
         xisWnQwI5v8nX0PEMPgiC/k7rWsfFIk6WKEnyfm/jf0slcXPYqqCDAAKixEgq1lqv3d3
         2mXVUjBuPMD4DPDb8XGjREGcyQf5zDlzGeR0kmlwmVK4pSiA9pXi+zphApU8JTgNOzs9
         Qer5tTW0dYUYJWnpYNrfen9YSkr2IMRAysZMHp7baBrJyVPUQx43ghC5ortAwBDrE6A5
         4/UwyPtwntCmeRC/HMLu41MNNT0fo1xdIrtR2B91+0T4UmPsKVFOAPmAPf0oDtDZup1M
         UYug==
X-Forwarded-Encrypted: i=1; AFNElJ9fLrp7Ry+00NfZlmJTfDgeiANOpRMhkDFjXznsov/Pkyaxq2NaPyvCn0Hwc5rKjFlBUyFmNDbYXq/NAfIONVR9@vger.kernel.org
X-Gm-Message-State: AOJu0YxupTGrVxxjA30lNuqWfNSZ4Wm6pIZFfBU/IB0N+MLwyar3HiZ9
	8iE9Ix4H5vBAKA2xknjidnlpdxdKLdadVgyThocBNzWaGuIKKXGMmcpYgontv9Bq+sQyiJ0sZGg
	qGgWFhvP/6Q==
X-Received: from dld35.prod.google.com ([2002:a05:7022:323:b0:139:ad3c:7d3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e10:b0:138:12fa:378d
 with SMTP id a92af1059eb24-139d0c76365mr1529122c88.22.1782278157984; Tue, 23
 Jun 2026 22:15:57 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:25 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-9-irogers@google.com>
Subject: [PATCH v2 07/16] perf test: Fix skiplist leak in cmd_test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in cmd_test() where skiplist was not freed on
exit paths.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 2ae828786c65 ("perf test: Allow skipping tests")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7e75f590f225..cf5625cf4f11 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -1781,9 +1781,12 @@ int cmd_test(int argc, const char **argv)
 	rlimit__bump_memlock();
 
 	suites = build_suites();
-	if (!suites)
+	if (!suites) {
+		intlist__delete(skiplist);
 		return errno ? -errno : -ENOMEM;
+	}
 	ret = __cmd_test(suites, argc, argv, skiplist);
 	free(suites);
+	intlist__delete(skiplist);
 	return ret;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

