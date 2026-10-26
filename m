Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036750;
	b=IDzauucOL0Orje/jg4g3luN+utIwMniH7fH5CCylYHXGA/svuw68fYDwIq+WBiqLpS+v
	 uLy2r+lQlvUYwojikMZivjCCCJUAdaTBB1bLFv82t+FNrTQVw9y9/d1DrxWH+uNfYFxFR
	 Pw1pq8+sPPex+9jM9MsaylyPgm5iXFcF0WevOcnJpbyGHleEkKbEaLe/XV7+tBI0fiO7b
	 IdhY3/eXOBnSbn6avzK9tR3QU3+KX6dNe/XOnaWoSt6BKtUvzMQGhRFEm6BnBC291EZpg
	 TGPshlb/AHNOHW/XWpyY71VIB17oJjklS+mSlDoiTvMH6dcUyGskrDVCr0tPWSlFlbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036750;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=EkPvFgQc8FbM9LSXUf6KgPjczi0z70sToct6/kDqPXc=;
	b=HEuLAa5jr8xq29vM/b7/45QF2pJZcbk9Iz6+UWis6/E3ComwJOklP6NTfDEfeftHgrOs
	 yTIfw9EyiLluDSnGWreR8ivM6jkAWrjz5mtq/ZrsVktXdW9G2xF76C05AUJu3aaKOhRWm
	 s8WkbLJruqJm4Oedxg3C4Wi+uSJqKLRpITXovd7fghqUh5XwmiIEky7uIxUkSWkYUd6Wt
	 zgk1VfuOIaydkw0xusZRGy/gGlNeR/FHWF3PlSgv3VaStmMPbm0KGToHxCyup2EKcPnPB
	 oW2qAWrXeIQ+2qYNApLcWo7sVBOWmrH34qpNo6FF3+8lXoW4MPmSLZb9Im3WRLq7ULg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Hi90HxGm;
	arc=none smtp.remote-ip=209.85.210.228
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A6606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 17:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F3A6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Hi90HxGm
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so1340083b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036750; x=1793641550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EkPvFgQc8FbM9LSXUf6KgPjczi0z70sToct6/kDqPXc=;
        b=yuiS4xfW3YnLl078fnfrOkZs7cx3oc/buvAE+ZlkxK4Yo1Lrlp/IT1BqUWEGVMSMT/
         hyX/4GVZHCH3VjHSIR5FXHyZV8wicdoo868cZ8ZHoDLOpvyDNok3VWvExnMSz+GeAB6q
         9mXJHfMp3cQPrvw5inwuWhj7a1TkWQJHY0dTKFWVus7sG4h/fBJ5Nj2jKahHAeoBH/5h
         H7xToTFRfnfrPNzRBDKJGWwfSgUsZRVimoZEyFih5OM04QRrR3gXegelTAAifCvFOdPJ
         j4bsKNT4gvgnD9hHaCyegof6aYoKLG28NtQNA7KP21cr/2p62OmW64ybG0dudIeeLNlD
         +kUA==
X-Forwarded-Encrypted: i=1; AKwUvBwLbl6C9SR9I4JVWj1Nye8kLayvB3OR+h2JHxobh58O6X7SDGxT8fqF1eVi7dg5Cv9faA/s6GUJ1PfjMwCQHe2X@vger.kernel.org
X-Gm-Message-State: AFq9FYKKZJBN8EbJuX6p/qZFMl/HCNMu9G9tQ7ssr3L/u3W6Y3GU5lPy
	BsyQTiJMtR5hv0ITAAeAU3GLoXhO0P7TCLj4Xm+HL2AKtKTrwdRHnsP+DKZaSZlccPtuzoz+Dtc
	Qpc26NW0KDX7mvVEYDWATqVuRgom7BGBMWP/xy9neuZecTwy7sSVHDlf8Q0Ufp5ngHv/DER1gKo
	Nx4WjARrvNjUxzVXqikYLWnZI+0PCh9LSKgXMypf++deNf+ZNn+gURQBnt9VWi2h/lEI7k0Scwq
	SLZyuXK7RG3TujXg5qTHmeFc8LeBy4e
X-Gm-Gg: AYBFou26uOunT5P56aZq2zQSI6m6TVrzr3gL5ldGY6DB79L+sMul4BNmwUpZoq/zMQ/
	OZxYhjgGLZuFN32Bo/fKFaaGwoc/bmlXwnBLYcLCVDpLWORAaLL1qXjXz3ZU8U6HLgWTjdoM3Nu
	TmtfBd5VLUtxXSv67d6VMa1Ktrr1QxYJa3MwP44kCm34zYo37VySYmIxsk/togjxXnOUc0FKS9W
	a/kNE7LaQqTY1OLC3khM8emfOHiRh6o+Ra4avWzmobtILEnj2FoR/wTARHar5+I3AXzEVQKKTvq
	MxgWji8GFsQhXtisj/sY/zsEmRhu3xqgEImXKAJMgQhOzDUbRSVOqAG1/xL3n7iup0HclQ2nRpI
	/EYxZuufWNk5Tq3HpjpplHVVwemSeRhVJlYV7Ik+djkXVNwicZKeX5XXArGF5i7WVNG0l93tshC
	SToMKjxzMDp0Qy/vbsoGY9Me7F2Qu+kN5MnTj+8NM9
X-Received: by 2002:a05:6a00:3406:b0:89e:db8c:7a39 with SMTP id d2e1a72fcca58-8a366994c2cmr5668522b3a.30.1793036749722;
        Mon, 26 Oct 2026 10:45:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8a36a8b9d0dsm60437b3a.6.2026.10.26.10.45.49
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:45:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-186c1aae818so2695332c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793036748; x=1793641548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EkPvFgQc8FbM9LSXUf6KgPjczi0z70sToct6/kDqPXc=;
        b=Hi90HxGmwFReqqAgsF/9ATlmlNRol5IUELd2Wm18czE0Jy0ZPhvjbR/u5wj6Dzc7XI
         WSXfWxXdgj1HUMHwAdAvMFtWkVoGKHXSaIo6/1G9kqhv7jhd/NUsPyFUx+CXYZCUr6kW
         t6eiGbJeCLhuc6loJ1tRJ+x4n/PZqfIcltju8=
X-Forwarded-Encrypted: i=1; AKwUvBwYVlsHmAva53OjPchQNKjeQA9Ganploh0ZujsSExpNPUhTOBuWlub9CaVfHjFHWL4rDIs1UWIFJlHMrXpAifL1@vger.kernel.org
X-Received: by 2002:a05:701b:230e:b0:167:d73a:e994 with SMTP id a92af1059eb24-1993658f1f8mr9164891c88.24.1793036747803;
        Mon, 26 Oct 2026 10:45:47 -0700 (PDT)
X-Received: by 2002:a05:701b:230e:b0:167:d73a:e994 with SMTP id a92af1059eb24-1993658f1f8mr9164844c88.24.1793036747049;
        Mon, 26 Oct 2026 10:45:47 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm25820555c88.1.2026.10.26.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:45:46 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andi Kleen <ak@linux.intel.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf print_insn: Include sys/types.h for ssize_t
Date: Mon, 26 Oct 2026 10:45:31 -0700
Message-ID: <20261026174535.3157580-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

print_insn.h declares fprintf_insn_asm() with an ssize_t return type but
does not include the header defining that type. This causes builds where
stdio.h does not provide ssize_t to fail when compiling util/print_insn.c:

  util/print_insn.h:21:1: error: unknown type name 'ssize_t'

Include sys/types.h so the header provides its own dependency for ssize_t.

Fixes: 218c200f677d ("perf script: Consolidate capstone print functions")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/util/print_insn.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index cefa5c5f246e..3de9438af9cd 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -4,6 +4,7 @@
 
 #include <stddef.h>
 #include <stdio.h>
+#include <sys/types.h>
 
 #include <linux/types.h>
 
-- 
2.53.0

