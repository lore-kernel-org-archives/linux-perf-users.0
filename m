Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC08D175A5;
	Thu, 15 Aug 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685807; cv=none; b=kVaYcohW84I+vr4N5bQM/6Zi524KoBPXVoAcf077z3aOtexUMMTl0RrAHQej04K+iOL8m7tQkKOn6gZ3Mm920yc2bDkYhuHwHycK6lsE8F3wMdPuW1Cwc9uy9M8VM+FeC/Y4hzbLtClMXp7sx15uKQVb/kqPMbAtku4a3mkZRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685807; c=relaxed/simple;
	bh=dJ6dwsc2te6C4fqphCuQO/mJgw1cnG5U9ZswITvx73k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd1HR5E45dMSWdaN+mfkFdiTteh4LQwNzqZm3Y/JVfVbz0smRJfi3jSt0/LP5V9szXElJxGnQRzTTlbwiMqJBE7Tqm7D4rCI0otQurIW74cXoTld13gZ0P1Pni4TMFT1xmosls32cRu10NALPulmJVsuWeagd+USy0iWA3unr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTv2CxDb; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTv2CxDb"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db1eb76702so297018b6e.0;
        Wed, 14 Aug 2024 18:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685805; x=1724290605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5rrF35FuSQmX3OBIO6C+kKuzZZYCa/QtNoSMLimFXA=;
        b=nTv2CxDbJOtzgxlYtmZy88KU9tuvXqUgpM8Qjx1gA+gUgCG5cz+ugA7pGkGRVaoRAj
         56GR/B6aKBI8QonYU0QJ4SmPF7RHfvWLowbZlG/iwCKXCYEFvWiRDjzum4LfP/XHzmq/
         AXMbqwKqBaXBsRmJm808J1Nf55agxxocm4L7U2y7nfd/95dXXaw//1/07i8Oiwb+wo8j
         22K0N15xk0v4GT7mAKhHbZfLzdXmou60UVBMsfv9UkI2VK/6CUwffqNWoJiwEzgR2CP3
         wqNyjFZwk9oH4DuhdqtrysMSNh6WH2kcICZ0SMulH5fYzmlKPsID5VMIOj3PdKiXUNpw
         BdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685805; x=1724290605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5rrF35FuSQmX3OBIO6C+kKuzZZYCa/QtNoSMLimFXA=;
        b=lxghxUjP/9QHvRlJ44AmnKLMX2o8PeYtvQFPeEuQGPAKk3ErFlIM3h/tkaQclM4U5k
         56TFJhHGm6cF1vvy+wyZ9eQFeZ6Z1K3R7GRsiLHEBsiD+SwNAHjUPJ4IilsyqJHs2urw
         dh8Phxe777kedlBdmSFujnxg+gLqsEDR1kQ5drjuL6tZWHtNIKbiIOcnAgo30tCUnUX+
         lX+xVgn2AKfCT0W4jtEzvJMU6wGSQWmgJ7efOF/gIbBhdPifSdVy9Irm9YE/M+BNKl+R
         G11CW3VtH4kiWxZyanxGiyfO3R4GQVDYk4//QXLIbVTgj9bHNmWMsW5RAjmxJeXCH7iT
         caHg==
X-Forwarded-Encrypted: i=1; AJvYcCVFX4hpz8XCSYJdWJi6GrBnoGAeDWSXKZlEVgsmUVEH0zh86iA3pYMRIR0+QLTBS1M74BAnXGxPqkYt4L0PV4MsYv+0gPltMIGpwtAWJ3e5qvvpfpUmNopISNLULDO9yayj3iwWaDpSLd/X8/YLfw==
X-Gm-Message-State: AOJu0YzoUZfAvJCDfrN8lDKuz7N14kHoDuRXV1qSWly0kTYEa7xhYHbT
	tFzfFA+3PURCj92lPezjEzUs/AMu8zXexiXDRhnk/kTj/E22Yxcz
X-Google-Smtp-Source: AGHT+IGEgh6F0/+r7yu/UnkU0eMUnFxU67aCH/qRaiCzOyup63Kb3A7OIjo12O+Jo9aua6d86r3FPg==
X-Received: by 2002:a05:6870:d29e:b0:25e:118e:ce89 with SMTP id 586e51a60fabf-26fe5a41ac4mr5740894fac.11.1723685804820;
        Wed, 14 Aug 2024 18:36:44 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:36:44 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] perf trace: Change some comments
Date: Thu, 15 Aug 2024 09:36:18 +0800
Message-ID: <20240815013626.935097-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change them from '//' to '/* */'

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d6ca541fdc78..97076b962688 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -957,17 +957,16 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
 	if (btf == NULL)
 		return false;
 
-	if (arg->fmt->type == NULL) {
-		// See if this is an enum
+	/* See if this is an enum */
+	if (arg->fmt->type == NULL)
 		syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type);
-	}
 
-	// Now let's see if we have a BTF type resolved
+	/* Now let's see if we have a BTF type resolved */
 	bt = arg->fmt->type;
 	if (bt == NULL)
 		return false;
 
-	// If it is an enum:
+	/* If it is an enum: */
 	if (btf_is_enum(arg->fmt->type))
 		return syscall_arg__strtoul_btf_enum(bf, size, arg, val);
 
-- 
2.45.2

