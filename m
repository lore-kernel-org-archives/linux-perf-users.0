Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446126;
	b=B/2B4Wri0lFauhhzm9nyUwRclXoukIBI/LgJ6j61rPSZi7aQK0SaMvjhngmhA0KvHTeu
	 MLR3RGEfwtbvhqHkAwdpFI9KUutTHQmgHj9YlLjzMcReJP56Q6tO23uG9Z2esYxHNzE9m
	 7GpK0rvOfkRscf1B0vx5oolZdqNHzCzSz0JnM1Km29AYVqZne+/0LLxhYS4Zn4gBGr3mO
	 ty/97FgMULi+aSj8ZhhKsqep6+nOr0osS1qU9rNZyj8lxIuZTDxlOu42RKMN6yHtd9L82
	 NvIX4OHmmBilee3yl9OfUzceEGfoQvAWtskVZIhNpT/9s0SL7i2v33tVFKlHWBFdzFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8xH0foyL4r9PEu2rzsNYeY924b5ApOf8nN/pF0nQXrw=;
	b=EHdt4rMtpcr5JL5GPlA+DOSYNZiN9FzFEjrBxsvFzlBbRHIwwLpE9Hb2D+DP/kms6tpq
	 0HSic5SOlq55XTRfq6lj6fZrn4zN6VxeLbAUG6j8bbXjKoo67O4DZEZhyl9rR1bijzFzV
	 ZfcFwHjN6+1P7XlLzhMtWssYI2KXJVmerXtiaa+N1sgcYyqUIsi1BD4m5oPW7CMepXKPR
	 JoqQS2GSfWWAWVaK1PbLfWsjK8uYZjSExM0WV0bG1gsN5hDz9Y0tFvEHRnErQXyx0oUgI
	 LlxJupF5EKOTylmGxRpLsxfqpdHbHuMjCYf3gDFJYRo8lC7Ct5oN6nSFrC//u4k9vFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Qz/bM3lR";
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C816606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C816606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qz/bM3lR
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a2af4c8cbaso2917252c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794446125; x=1795050925; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xH0foyL4r9PEu2rzsNYeY924b5ApOf8nN/pF0nQXrw=;
        b=Qz/bM3lRWEjokeY44JlXjqPl4cEswls91MH6qoLcF8yZRzx5RwcwINymLxLdhbThyy
         miLtElbFgqLffdhp6gko/JOLMAIeCnd/2wcSMZp/R2Y3/9FOpgvO/8B1lCPEOtazC5w+
         L5E1zIzMTOaGegIKMwSPbtwAAWvcWr4p4NZEgDBGdxjX4o8Eo+y1L0O1FmitESRlhauv
         rBXG0S3nHWCjNQ+PHAJRjWETtlYFshowdcm0XRotxsGwOG65DGb4FBSpq+wCvXogisOD
         SrjCQ/SHAnjvh10B30e2VsaKkT6VTAOPJQP76uAdt7heJZ0Wg4o/IsMTO0N6COmxcLzp
         w7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446125; x=1795050925;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xH0foyL4r9PEu2rzsNYeY924b5ApOf8nN/pF0nQXrw=;
        b=cSeH60BBZf33VmnTtn5dTsAdx68bQQKrVGAGLohSt0rCR5ix3MqMro4njqPYuDVGyO
         KdqXoOSaorkdOcGftwlvfUPTtCc7s4SOQuKoAmk0W9YZTbwwnWy4sJBdQ/3A7mAswZ/Z
         G2Ban7WkF8FpaX9OHPOEfbnR2BajjJWOx31RcOWDv9adzcXjCVrX2JroFs7CNeESjG7w
         zTlrvIrmNhuxR4ev5Yym256rNcjMl/64Hp/3dIcJPOo5o/ye05nBwzbwQuQhnhsZ1TAt
         GzzlZYfwoS9KX2oNgiN2X7MrOBrhqSr1Gt1e60TwiPS9280Z1IhpebjyvWTADvlTLAlR
         UJHw==
X-Forwarded-Encrypted: i=1; AL+hErFsML94/I1k0Uteov83jPjNHttSqmfZCYYsZ55J/gaS38DQ240pjtQVKOetxpYb6KG2XLaHABu7DDqQW0SrsDZ4@vger.kernel.org
X-Gm-Message-State: APuU4Z9V8EC4uTfr2NOzC3mCbNcgW5X79ZEcgzPOooCE7lRz02RSPqVK
	f/DRS8/aJxofiCnNMiTWSJ4h6b+RZS9RJffVeeFNFgi/LmUqY5gsACUbKPihpV/RECgtP87f+kz
	SlEDyqX1/wQ==
X-Received: from dlah8.prod.google.com ([2002:a05:701b:2608:b0:1b3:befc:72bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec86:b0:1b2:4998:a0df
 with SMTP id a92af1059eb24-1b3c0338950mr4348715c88.35.1794446124205; Wed, 11
 Nov 2026 17:15:24 -0800 (PST)
Date: Wed, 11 Nov 2026 17:15:10 -0800
In-Reply-To: <20261112011514.4032822-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022204627.1813821-1-irogers@google.com> <20261112011514.4032822-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112011514.4032822-2-irogers@google.com>
Subject: [PATCH v4 1/5] tools build: Fix version-ge3 and version-lt3 for
 <3-part versions
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, cupertino.miranda@oracle.com, 
	eddyz87@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	jose.marchesi@oracle.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

version-ge3 and version-lt3 concatenate their two arguments as
"$(1).$(2)" and parse fields $1..$6 with awk -F'.'. When $(1) is empty
or has fewer than three dot-separated components (for example GCC's
1- or 2-part -dumpversion output), fields $4..$6 shift across the
boundary between $(1) and $(2). In particular, calling version-lt3 with
an empty $(1) against "14.0.0" evaluates 0 < 0 and returns 0 (false).

Pass $(1) and $(2) as separate awk variables and split each into its own
array so missing components default to 0 without shifting fields across
arguments.

Fixes: a9b451509565 ("tools build: Add 3-component logical version comparators")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/scripts/utilities.mak | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/scripts/utilities.mak b/tools/scripts/utilities.mak
index d69d0345cc23..746aaf6e5145 100644
--- a/tools/scripts/utilities.mak
+++ b/tools/scripts/utilities.mak
@@ -186,7 +186,7 @@ _gea_err  = $(if $(1),$(error Please set '$(1)' appropriately))
 # was to check the flex version to see if we can use compiler warnings as
 # errors for one of the cases flex generates code C compilers complains about.
 
-version-ge3 = $(shell echo "$(1).$(2)" | awk -F'.' '{ printf("%d\n", (10000000 * $$1 + 10000 * $$2 + $$3) >= (10000000 * $$4 + 10000 * $$5 + $$6)) }')
+version-ge3 = $(shell awk -v v1="$(1)" -v v2="$(2)" 'BEGIN { split(v1, a, "."); split(v2, b, "."); printf("%d\n", (10000000 * a[1] + 10000 * a[2] + a[3]) >= (10000000 * b[1] + 10000 * b[2] + b[3])) }')
 
 # version-lt3
 #
@@ -196,4 +196,4 @@ version-ge3 = $(shell echo "$(1).$(2)" | awk -F'.' '{ printf("%d\n", (10000000 *
 # check the flex version to see if we can use compiler warnings as errors for
 # one of the cases flex generates code C compilers complains about.
 
-version-lt3 = $(shell echo "$(1).$(2)" | awk -F'.' '{ printf("%d\n", (10000000 * $$1 + 10000 * $$2 + $$3) < (10000000 * $$4 + 10000 * $$5 + $$6)) }')
+version-lt3 = $(shell awk -v v1="$(1)" -v v2="$(2)" 'BEGIN { split(v1, a, "."); split(v2, b, "."); printf("%d\n", (10000000 * a[1] + 10000 * a[2] + a[3]) < (10000000 * b[1] + 10000 * b[2] + b[3])) }')
-- 
2.56.0.567.gdb80ae8cd5-goog

