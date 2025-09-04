Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514522C2343;
	Thu,  4 Sep 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976994; cv=none; b=hk6EMVJgs+NsdzsKydsQ2UpFNnNGHZh9aAQ0IqUBIKG2yjVpidg040HzYpFT5kOYJUGSva7SGOlDiJ3NfEqoRb43Pcq4oHeJIebt+Zt7IxN1b3kqZqxy6UdP3QzJhl0/Niamip8dyhkRWl3CAVlgkzd/0QHId+r6IXdYWz7hl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976994; c=relaxed/simple;
	bh=cL1nL8yxdfh4MeO0vTFBHBhjeSeXwUEbzSFnpkvqw90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sulk/JhHKSv8zOu8MLm995LorY54xfU/L+NIBuYfprSjsPvhO6GXMTejsOyxBZSTnT+DyxWN9S1lpIOJq4Yb2Qkv6hd715hEyf2mKwnsp7dLSzylJJqY7fiLfiG9ExwaPjS5jTkdcvz4PkEcKmerlU43/7wO0l9M+VKVOEI3Fyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWDcjjfa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWDcjjfa"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so5500105e9.0;
        Thu, 04 Sep 2025 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756976990; x=1757581790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=efuw0B0wZxUoEGTeuf9+BIFXghhpdqisLNXE4+ry2Xk=;
        b=lWDcjjfaW6QkW7+9/1iw2KYomEstql4l+CRqx/OrLRI1w5vCMFafMx1PU9LZblPrH+
         UUjX17RSDeoxjt/kkAWWbZfOddYhK8kt9z2gXmShUA9gigxbn6YUF45Atj3Pl0P4Ftqt
         7qBR0jJrprcxYbA6PJomDWoz+6gdKh44RPGUZsBlghoj2uDjNWlzFjm69lGXkPeQxhoX
         lLUn5+SpJrENs/S94hRJCQebwxmA3SilmXiXUDObIHtIF8RL7cJpBCoccsc0xzN1TEUx
         Eoi9jffs6oZr3A0xYmJxV+HaeFndlgWZK1S6bvNrewTrTAPHGVlajAdWyk8/CYiGD2/o
         4HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976990; x=1757581790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efuw0B0wZxUoEGTeuf9+BIFXghhpdqisLNXE4+ry2Xk=;
        b=wqLDoXqe/yIt03BGckRjclxP9Yz+x2n/dbP7lSF2uXpuMfTkGKSRDuceZbBGRa17+/
         ZNAhoemExyZYm/H0UxMxvio/i66WzDFh6BecYav/4F7B49amFi/+9df/j27N1E2yEblt
         Ndo6blagamoaYTSX/QyryVVb+eHW21L5tgOQDM6XHvgjB5Qw9LcKiI+3cAICSJtX4O9M
         gmtFr4TtNw2dS2tHAm/sPNr0ZKFS4Z0tXKZUJXo09R6MFlQ2kBpIGD0nJDzYuGAcZSJq
         ov+emIqWALWEcjhCVeH4mEWwyUl+708zFA8MBcafeFL7bMebQGCKTlaS0BBBltA4J1le
         DM+g==
X-Forwarded-Encrypted: i=1; AJvYcCU7vmbvmRmmwm1AmFxMzcKEa8E38Rs+zdzJSle+/mskFxvxW85m82N4ENYNCZ8/UU8aFQ1YMJJpN8JoMSo=@vger.kernel.org, AJvYcCWeld44KFpo/oI39wDYCUVPquFyzNFHKdsQy26nqKnnzhr3UQVOTQMC5KsU3Li/C83W4mAdr8epuG948fUx9eUKpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytIcIe67QVAdrHVvdhGKd05OcKH6oE5L98ZgtKyTvQ101MJKEi
	/YAlBPma5CAuNQXs0SFUv8qiZuzVSzaixO0FrAO8Qg09J9SD74r8OwRS
X-Gm-Gg: ASbGnctVmU+vmK7umGQ8USiuBiymd135nd04mE7XEuGesnLtSjC/2OkLE3EHVBNVZQB
	XlJNJ6IvmE4dtt11SgtEPep/Ft5f8nGIXB0HhVG2eUUP1nDR/tqa2Fqvyv19vyUNKBPOqZd2IjU
	gCSh6cL4wie5J4ve4Iu2J+6hOnV1MbJe1JMZbDKlIPPz+bxA86PW6HbiAEOYuvPKxzNcYrJEZjs
	ghuvaU0ldFpDPqZirwVef8QwQDbHnUXdwiVj5MtpqohONK6zIHmNuVqvn/7+4UMC8EiokdHhr2U
	J15KNDpvQl3I8+Q+w2RSpgL6w9nWtXUgcgjARLAakHA+9fom268e/hNEwEPhpY7/GNyFwhLniQM
	0Bz5/g2GO0cwFWpS/rVR22iYwi1nZsio=
X-Google-Smtp-Source: AGHT+IGe0zJR6YVP6t6Z+0JvVpiOQbWitSetUHbGA1LwBTKO24ex51i/jNJMmRq8ohz9YHPqIiHCtQ==
X-Received: by 2002:a05:600c:4fc9:b0:45d:cfc6:5166 with SMTP id 5b1f17b1804b1-45dcfc6564fmr18564055e9.23.1756976990380;
        Thu, 04 Sep 2025 02:09:50 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dd061ee2esm13647725e9.5.2025.09.04.02.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:09:49 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf python: Fix spelling mistake "metics" -> "metrics"
Date: Thu,  4 Sep 2025 10:09:04 +0100
Message-ID: <20250904090904.2782814-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a Python doc string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 47178404802f..779fe1280a56 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2187,7 +2187,7 @@ static PyMethodDef perf__methods[] = {
 		.ml_meth  = (PyCFunction) pyrf__parse_metrics,
 		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR(
-			"Parse a string of metics or metric groups and return an evlist.")
+			"Parse a string of metrics or metric groups and return an evlist.")
 	},
 	{
 		.ml_name  = "pmus",
-- 
2.51.0

