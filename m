Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019406;
	b=rRwcCbVNG2lec3PsBJK5dc0mjIB82bzw2/wJwciJoiomMghL40nGGn7LRkAdWW4my1Le
	 cSdNh8GXT9To4/gvfE/KXesSOffF434a6Na7vGi1xduTLnp5EDgBoEkAO8ty+5x/Ocy2R
	 +NQrO3WbXrchj94ulPR8hfsqV129e57GjGe1r2kCPzSo7b02228XN8LU09NeOapjPCnbj
	 urQAyWzcHneKrt8Xf795P2WLKZ0xw3SWqFphQJD5P6Eu1PeQJX3eo1mhw58de2pufSxkm
	 QiOEx6qzF1BOFkz+ZQKULi3ufW1fgZfOn3NWXUifff6SVrb/cpea6x4JyoA8Nar5mAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=9rbmVMuhauk6RT7/BuxdWNH6HE9Yom6LLFGVubFIKV0=;
	b=zalbVu9HeHUO4zlnjk//8maRsxwIgWibA7+GF3LqwEuU9yJSwj0lhZaY2UaMabAvb427
	 hljCIfJBf4aYrR41YUZ412H62vdYzTP7ssvqF/wCwmEeqH+MfA/+dLYPLOv5uKquF5Wnz
	 lyYYaTQ4OGKkKr/0lGugqFaNfu/2kTyP7VWBka6CI3ER5Pi9wZmLqlnfE50plctSgWX8X
	 TJxCFGOrrY5SPzKRPaytywieHQdyBmyjMo2uJgasZINmkjn1fZl9HsS0weGw2Gxb9ToVM
	 1Y1bTtlj5xhcsw2CyUi9QWLaH8HeyxpgV1E0IgK553ydPnbQZGqLor4Za97XE5NKNBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nf5xowz6;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124B60A262B
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F124B60A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nf5xowz6
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492690dd5daso986735f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019396; x=1795624196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9rbmVMuhauk6RT7/BuxdWNH6HE9Yom6LLFGVubFIKV0=;
        b=nf5xowz6xs1fO/Cnu0hzoxhSwK/UFLTqaZ/uGmJ7CY7mKUl+LqlOOjfjp/HUU7wzqC
         vz7hZ9k5WMWKGXPvMH9Rv1Dk++lBeekD1c5jTyqqARVUfLDOidN3ilDCXUe/2dCQ8kYS
         8ALc8DV1jlse+zYHVe5Hf+imz7Y+zP/HxqIHaw05/wACvbZfORPxVTP9TORec8/qEhLG
         cKov3PEYmiLc74EKe6VmzxQXOGmuAMNz+AYrgLnX7jS7o2xWZbQPFfdueVxq7uqTxg7+
         N7NQLGoi6gqa+m0NkoA/uGJq6YvMTYDvCQpWvGCs+UPoG5PZp+QlLmXc6+s9NQs+dxuv
         OuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019396; x=1795624196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rbmVMuhauk6RT7/BuxdWNH6HE9Yom6LLFGVubFIKV0=;
        b=0+h3BCZK0KEyyOgltwUX8jX+JA6VHCLNQ1hIwPBNXwJqgpH2ufm+gkD9drPlKRyOJH
         jNYUzgNfm/OSMYuji3rbJqG8kQxxJw9A7/g4z5ufwcv0kBwdSGi/InKQZjHCtfi3/pWi
         IGc/hRzLkn1AuXgc0DhXJsOOkzMjEbKCQLgNYdGuz9lCJb2pBG+i3nKZdOgJ8NMjNELb
         MxoN+ShDIFdPF+Kg9+YASIyghxhoYGthyiafJb96cnJB+kSp0Ad+6hl7ettA+oa8cK4z
         Lnsn0DXuOfIm6wfO3ziiB819Tuy/afQq32KiQrTj0hAePyrTNhRsfnq7i39w28wcr7aK
         yvEA==
X-Gm-Message-State: APuU4Z+vayiTbjxy6364hlQp9QgOa3UBRs1yUK59PAPo8rBzxE8I7PL7
	TFXnTLBjjO4EIhdXJ15nTgspwbFueci9g5zifIl8O1sdp94VFHE1BLGry8YcQ5gQ9e0=
X-Gm-Gg: AZFdTZciQV+Zh2QDBll+bHh14pgKdyX0Ju5aJ5cnwUPs3bWhs+nGEe/VqF278HtsHSc
	gT1OCA+WbeOe2M2u9OTrjNOvIoRmp2T30dI+cFFvQZlMCU64tnjryMwN4khOU0cJt+XM/cBwCEN
	Lx0BK76CSj5TNq1az2ksE8ssF11lntT2TChjMPfzI7X1oE56VcH8DTzessoiy06io/bX1AZLEig
	+f8xXYm/t7iVZmq0BQweCMmBZEvuPGN5GBHM38blpGqL0oSF9Ji7k15Sk5/noxzUmyXGSYSpxIt
	MuVtt0/CCOf4Wvv/XYUz7+6+XBRoeWG7U1uMqu3LL46Ef5fGkMMz/pBcXtn8a8Ylgpa8UopJEIX
	bxMfiKWFJsqpVa4LsiyYxHExfWEOijh/bVkd0uSfoGw6BBCpqWywbQH61q2v2Y8mqnxztxuw1UC
	571+xxVp/mVYVMGOf1F59iMRMo1XZT7ohfpBAg1MVFELtNJ2bhLhcWV7RtdAfOB905rVuXCWCAJ
	FO6jlwiSMOh4tBPDwOs08C4UFxQoX8ZQAgkC2wb9BxA4sdFn7bQkKM3CzOoYWRxwd/PaSmsDXes
	RceQuwZUSCVfWwlw76uak0QSt56SC9g5
X-Received: by 2002:a5d:5888:0:b0:48f:bc59:ab9c with SMTP id ffacd0b85a97d-4a638338280mr6254961f8f.12.1795019396217;
        Wed, 18 Nov 2026 08:29:56 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:55 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:30 +0000
Subject: [PATCH 08/34] perf cs-etm: arm-spe: Use arch timestamp in HW
 tracers
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-james-coresight-jit-v1-8-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

To allow the JIT dump records to be correlated with the HW timestamp in
trace, set JITDUMP_USE_ARCH_TIMESTAMP.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c    | 5 +++++
 tools/perf/arch/arm64/util/arm-spe.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 84a5d7392a5f..809da6f1a892 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -909,6 +909,11 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 		goto out;
 	}
 
+	if (setenv("JITDUMP_USE_ARCH_TIMESTAMP", "1", 1)) {
+		*err = -errno;
+		return NULL;
+	}
+
 	ptr = zalloc(sizeof(struct cs_etm_recording));
 	if (!ptr) {
 		*err = -ENOMEM;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 8d6a2bde2892..53899c7de846 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -521,6 +521,11 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 		return NULL;
 	}
 
+	if (setenv("JITDUMP_USE_ARCH_TIMESTAMP", "1", 1)) {
+		*err = -errno;
+		return NULL;
+	}
+
 	sper = zalloc(sizeof(struct arm_spe_recording));
 	if (!sper) {
 		*err = -ENOMEM;

-- 
2.43.0

