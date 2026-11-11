Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364418;
	b=Rg7PHO5icHtwEhJ9s32GPBQYdMpSaVvut8CBtCU7lIu+rbt6u/0y7MAttkacdDMGsYSe
	 DvuIg/ynzmMJ2Zz2g8YVIhzxs/Qfzs7dFzuD06zD431wbyISB8Ji5xqCWId1JDvsL7TJ5
	 nZUvklevOTzJn6VRbGOeShsz6mWjxhPNET+nY5c/JZ/YqiKJbMSHhZ3aqJ4WFFXDowb7i
	 WrZjKZkM8k6pgbsLFBujoEUhTYmUbNqGBUh7EFXvfT6mmr7NCD3XesbpPqZosQQWLsPUS
	 reU++k76xhRNRR7HIlKsSy7IROOthnWH/UGtyoHMpSDjjWDmKjJtYZRqjvmefhYO21Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s18d0QtUAH5SO1XlwoaKN258QqfdDcIgzB60hufTnb0=;
	b=s64oBM22z07Q9P0Yms6/cJ68Ddj2SxlCljkAx6V8oEERwTXJmi3PNR8CiKXdVWjX9vvg
	 dIjOL/TGfh/pHWvVTziLIVqpHIelkuf8cK8n+41pkzD5VS6m2sC01V8rVL/385S+qwpKu
	 FRS+5N5jKtJVMtnVisIw2zzRLfPqMXDYHpTHK5cm/5VBrf8b1BUi0KD+qOZ31uj/G7lcW
	 0NL2OIPNoinh+TIyw529iGyFxIXoBWRVFpudNdveOqZVa2jp8/4resQckMUr8F6TWnBDf
	 SS2gxh/QkSR5q6y9azzIelZ4lKDoNdj7HSa/BLlIv9K89j96Rz4iIslk3rsV2F30SsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPU37TsB;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12624606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12624606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPU37TsB
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-563a0462094so1382561b6e.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794364417; x=1794969217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s18d0QtUAH5SO1XlwoaKN258QqfdDcIgzB60hufTnb0=;
        b=TPU37TsBWhjAn+woivD6kvRf5j9T/wDRenHNZo/USasoDaW8ijLoHHy9339EKRiXUG
         2LxJI1zOZRwNBvFCnQFHLLc9WCbRwHW7+R/UXyodAbuThzicWhO4KqkaYKk0eke95xon
         y9/KTlLYGMu9sTFvZP/TlNmKn+X4hN3L48yMVvwKoiMDs5deNEBSGAlNjwwOvse2yGrh
         Ay/Iz47eTbEf71OdHCJCwDK70/F+oChWrqf0AVLYYjnf7j3LH9H+q9rf03xVih8BYbS0
         9uZ47C8g7DWX3YGF/fcdCHwe4Ej9IT+QWHvurwv6ebDrypk4PtDuIMtPKWeS1+gCunui
         MQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364417; x=1794969217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s18d0QtUAH5SO1XlwoaKN258QqfdDcIgzB60hufTnb0=;
        b=2bOuQY4DmTKVO7Ez6kraBRU3+sOtKl32hephHHo30A666soSrv/rpJgsthyYjW0+CR
         imSOCle/Sd1FsdmvESoMKEIvNGPySTnZfFpxjGqC3vARVyJAWfEzwyrLdaeHMa2kx7ue
         Ix1h3kHncStN6/XoMioWtdQ3v4OFrohPLxLkHNxu9rTI1luVkigV6mMXHIUdukezgbRY
         o2v/sJZKzHOAEg6CPjwXql/0r9QNS4O3Vnes4wvLrrN8n1mHH3AlFMZVey9A5IrF8x6e
         1ZrCp4KlE87zrYbw9kLdxLygLeFFhc2EOZt4sxxNHXJrgWRv8lQQ3ZHRSwkYrD8TiTJs
         aAwA==
X-Forwarded-Encrypted: i=1; AL+hErHZT+gMoznghpVHzNoN+R/6HFjvfc71aXHoPJ2ZZhnrOCDLAlG6xJic2TcOX6kCC/lsMBg0w3uW5ZfNbv4f7ti6@vger.kernel.org
X-Gm-Message-State: APuU4Z87iD4sStE7DQ4GfStsyWNyAJVUDYCpZy3GLPQRHih+nQ+ZbWbn
	GvWhHSfyTaVWGMmMoDRovjNiGYFk1p+hjzxMVnvCz2RqgjkYh5WhxeZjkW9o1LYh
X-Gm-Gg: AYBFou3ynKd8OHnwV2WGXSnvK+ZTweToHesbKF8Z2FGhBScR6GpO7DhdiIY0iAsVXkl
	ZrlM4KQob8/1MrNghI7f6eItcJUL3vQDzpm4dSCZB5zqaKe5oHd21HzntoIhivZpFn8Old11DRu
	fFAvdDOdIiJ5d4maxEZPO8wnPDut6+puy/YfewPssDcudiIn1GvsNVPOV1e0WlH3jEzwJUh6GwQ
	KkwWKlA81irXGwpz3wY90Du6DF2Yr8k1lTIA2MT0zu0tl8UKZ24GMffo2KOAdzY2ywcEhhtN2Dk
	Kz5DwtKVFfov7gzJJAUL/GbBSYCwQnqX8G1X+O034ig+4rh0OS6u6LrV4FcIOfybl5iDTwgCeYL
	WHsfpbAyd49YcVKOmDz1LTcpf2GWnVeslqKlbI/+AOIbs08ZWAqlh7OPF3U3JIBQ4n1JtoIhZRJ
	1ZFoVa17zOb/Hweb+xCn9cbgLsB5BIeTl5ULSrs161BQzUJzEK31hmfdAi/p/kfWVWmgIXQwm9w
	hCC2vnJofWqZ74DAmAtviBOLjdW8mu2K7TkqwiyhrGG4+gpRhYSLZcKrbyfGWEXleB9+6b42bMh
	q8Ez7gxCS8r4VnbCuMCwW9t49NN/5FYjXOpV6zA4ZARDG8sdsoHUXys/dx0PDU1V99B6xTynNAF
	PCvJCCMN8GvIyIAFzKBc7CaF8hLbN1R4p3B01vPDxtkwskXVR/atUMTxO9fLXtziKnQhPblSGxN
	jTcg==
X-Received: by 2002:a05:6808:138a:b0:567:e9b5:37b6 with SMTP id 5614622812f47-56b97c1742dmr835978b6e.41.1794364416881;
        Tue, 10 Nov 2026 18:33:36 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm4103177b6e.11.2026.11.10.18.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:33:35 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] perf: arm_v7_pmu: suppress -Winitializer-overrides for perf maps
Date: Tue, 10 Nov 2026 18:33:26 -0800
Message-ID: <20261111023326.70922-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The perf_map and cache_map arrays intentionally use a range initializer
to fill all entries with HW_OP_UNSUPPORTED / CACHE_OP_UNSUPPORTED, then
override specific entries with supported event codes. This is valid C99
designated initializer behavior (last initializer wins), but Clang's
-Winitializer-overrides warns about each overridden entry.

Suppress the warning around these array definitions using the kernel's
__diag infrastructure, since the pattern is intentional and widespread
across all CPU-specific perf map variants in this file.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/perf/arm_v7_pmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/perf/arm_v7_pmu.c b/drivers/perf/arm_v7_pmu.c
index a1e438101114..9ac28c8adf80 100644
--- a/drivers/perf/arm_v7_pmu.c
+++ b/drivers/perf/arm_v7_pmu.c
@@ -146,6 +146,15 @@
 
 #define SCORPION_ITLB_MISS				0x12021
 
+/*
+ * The perf_map and cache_map arrays use range initializers to fill all
+ * entries with HW_OP_UNSUPPORTED / CACHE_OP_UNSUPPORTED, then override
+ * specific entries with supported event codes. This is valid C99 but
+ * triggers Clang's -Winitializer-overrides.
+ */
+__diag_push();
+__diag_ignore_all("-Winitializer-overrides", "");
+
 /*
  * Cortex-A8 HW events mapping
  *
@@ -530,6 +539,8 @@ static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
 };
 
+__diag_pop();
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 
 static struct attribute *armv7_pmu_format_attrs[] = {
-- 
2.56.0

