Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431164C150B
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333381; cv=none; b=Yi0euF6owEt+CU8QXyCCbJshOhv9yskm65Iw7WrdvtJ10yrToyxmnGGaW10woK0wxfj4byPA4ivz3YCrIR3+E+0Gar4HM7RQNjQQ7k4SbSKEb9uhbrPv/XBuiFOUZq/n0FmBVhBbziO+wKC33G2k77dR8lZwf/h1KXbUvpi0/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333381; c=relaxed/simple;
	bh=97NQQC3/WTVDJcemG/52psXjaVaXYeIso9vmTnBCZkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oj+QofpHy9dc1Z2N8KMcfNa2Ff5jMrKGhIdPG7x+8VyYBqFTeVs1JEYMfMvJEYRT0hYeG06o7tzXf62tY+5R3mJwnwvZGhscvZ/LS8hne9By75ZDEkW73MowzCz949rfaoZxL0KcrzdfzbyKyOKaA5QZJXDQuu62jjB/S5krse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO8FMW6K; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO8FMW6K"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8a83d2706fdso8315987b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792333379; x=1792938179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pir2OTsfElPbyLhSz/zgq/UZasa9p7ofy3leqIvBpvQ=;
        b=YO8FMW6KH8xrYATSgPCFroj4lWbtK2x4RKA+YV1iDgdb4VabWnNq1FPodGAMzZopRW
         WzbSy0A/KPrkHYOIsbAmQayhREBfjDstZCb3r2BmjwZMYLGW+mVaRx2T0xD2Vf0KbRTf
         ZSiFb9xvhb9Vk0I7Qwf7hCLd/gHEadMTI3RbNNhmfClyLifpF0Hg42YRIcOxgpC5FHdX
         5/ZedifUKvC4HIFL/msgk87n3nHqoAPHEDE4bjS/g1Z8heKgsCc2QthrOxyaiymJyhha
         BhN7SkxsiNTpIciYQFxy2B6Aag4CCoskC0yg0rEh2FmbclY17maW093MHCM2A1ZL2vFu
         H8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792333379; x=1792938179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pir2OTsfElPbyLhSz/zgq/UZasa9p7ofy3leqIvBpvQ=;
        b=Eogm8uHsuIz+Nxg0OkYSy+DIoCIO+o+EhrE6M0LNL6dACDpz+opHvonyUUmbGCL/F1
         KRjdGYZHrkWYxhBaAkzhqF7E2YMVyyOEd5gO8J1R4goE2dpxDniuMvcPHG+/uhvsgUz8
         /dVudKise8A27w6igGAoXYckalsTmm7slFWH29AOWmUAtk5NM3g9pGD2iQK6aCTmPaF+
         Kr6MgujFN9J3vWfeYFzssWLkQdgTBXVwfaF+4IL/hWh32CioBVcHwFq7V2R/EpyWFJOy
         bdjG1/urPS2OIG8zjRqzPSMtJl21AK57rk07pdjsox4THg4b+0GLOunZdAjKS6DLm0Xd
         Ev0g==
X-Forwarded-Encrypted: i=1; AKwUvBxA+hnMMaSvjMZI+fayQMb0YiUVuGuOnm22ou9xKWobj+GR0BCj50Hb2UU5c8EIbuXyyypfw6cMiB3BmvXB2KWQ@vger.kernel.org
X-Gm-Message-State: AFq9FYInSN+hkdW93SPnE68/KkYZAxqIFmRUCZC/VTuBcwYqdSdbhwqZ
	ZoyMORFcBk0QiQyV/hWsh6DqUqInbhmbJYARH6clRTwbep6xyIBNf5HV
X-Gm-Gg: AYBFou3pJYqWvV9cz8S93+lsYVaQmZ9TfAipxFQADvvq1ox9/BmDZ7DDVI/9fzrE6R2
	aE4Yp3i+Od7+TtIzjurSOlK2q+WqREtP7OCc6xt2wNwpvg2tUYOjMfw2ARCYZDYQmanVKqf8yS7
	R4lv9DyJ/zXYRHDDyEcoJY0jM8eFfu5edQwyxRcwT7bWiKQMaPX+Otm2I0Ekb6gQzrL0FENLwPs
	h04Gb5ysgTsaRXY6fJtE0wolsB8D0F/pJ4aBrL08R/a3NRwsMYZEio0iHb113flv1+nVQ405JbH
	XnISNe2oO6Q4XK2RNZoA3eiYLaR3/hzIKoSN4MtfEackNvHQveh6YODX5+mdWSSwvBjkRWX8yIJ
	XvOFFYIR3H7VPgRM9Il+w+6itJSX/vt57Nz5Ok3siKqkY19LxHGQtCULP7n0GYQBZ8sAHy2EMop
	/7TxiYi/LvXL97CFn19NapzIZJf27J9S1lHYKvedWMxfHip4jfugXx6Rsp3gmleNo6mYV0Q3bpB
	r1PvMJp45bazFlWi2mP94SnznWFWSzWzFrDOhUXVjmYrV3Dy9B+D8Iv/2dwRyhXQgmh+uLnEDWp
	JfwnDvpatp5JUf6x3nZ/+6a435dA
X-Received: by 2002:a05:690c:4006:b0:8ac:dbb9:21fd with SMTP id 00721157ae682-8b0f22086damr12437907b3.104.1792333379250;
        Sun, 18 Oct 2026 07:22:59 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net. [108.93.236.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e594ffb8sm30563517b3.44.2026.10.18.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:22:58 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 18 Oct 2026 10:22:05 -0400
Subject: [PATCH v3 5/5] alpha: fill in pc for software event samples
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-alpha-perf-regs-v3-v3-5-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=97NQQC3/WTVDJcemG/52psXjaVaXYeIso9vmTnBCZkE=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKuXONcK7Wis8H+2r5HL58k7JufOsNhRhv/IY8CXg2Rx
 uPxR9PvdXxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw10jMZGS4dVtUWvL
 1T3X5SqNueO28NogWdll7zO/HgZFXFA6dXs/Yy/LPTPbtTc81Ut/KbkoyP7yoKbGf5WWK8r/6U+
 PG/KZ/OTeICAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Context switch and tracepoint events have no trap frame, so perf builds
one with perf_fetch_caller_regs(). Alpha does not define
perf_arch_fetch_caller_regs(), which leaves that pt_regs zeroed, and
these samples report pc as 0.

Record the caller's address as pc. The zero ps already marks the frame
as kernel mode, and pt_regs has nowhere to keep sp, so pc is all that
can be filled in.

perf_fetch_caller_regs() gets that address from CALLER_ADDR0, which
alpha defines as 0 when CONFIG_FRAME_POINTER is disabled. Finding the
level zero return address does not need a frame pointer, so make
alpha_ftrace_return_address0() available in both configurations. Only
ftrace_return_address(n) still depends on frame pointers.

Reported-by: Magnus Lindholm <linmag7@gmail.com>
Suggested-by: Magnus Lindholm <linmag7@gmail.com>
Closes: https://lore.kernel.org/all/CA%2B%3DFv5S8-Zk8-LUpZnWiBfTGSQXthepmRc_-a9O%2BpEPmVW0mRA@mail.gmail.com/
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/asm/ftrace.h     | 5 ++---
 arch/alpha/include/asm/perf_event.h | 7 +++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/ftrace.h b/arch/alpha/include/asm/ftrace.h
index 7ec44134c804..5b75a294a7c9 100644
--- a/arch/alpha/include/asm/ftrace.h
+++ b/arch/alpha/include/asm/ftrace.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_ALPHA_FTRACE_H
 #define _ASM_ALPHA_FTRACE_H
 
-#ifdef CONFIG_FRAME_POINTER
-
 static void *alpha_ftrace_return_address0(void)
 	noinline notrace;
 static void *alpha_ftrace_return_address0(void)
@@ -13,6 +11,8 @@ static void *alpha_ftrace_return_address0(void)
 
 #define ftrace_return_address0 alpha_ftrace_return_address0()
 
+#ifdef CONFIG_FRAME_POINTER
+
 /*
  * __builtin_return_address() requires a constant integer argument.
  * Keep this as a macro so the value is seen at the callsite.
@@ -21,7 +21,6 @@ static void *alpha_ftrace_return_address0(void)
 
 #else  /* !CONFIG_FRAME_POINTER */
 
-#define ftrace_return_address0 0UL
 #define ftrace_return_address(n) ((void)(n), 0UL)
 
 #endif /* CONFIG_FRAME_POINTER */
diff --git a/arch/alpha/include/asm/perf_event.h b/arch/alpha/include/asm/perf_event.h
index 5996e7a6757e..72536566014a 100644
--- a/arch/alpha/include/asm/perf_event.h
+++ b/arch/alpha/include/asm/perf_event.h
@@ -1,4 +1,11 @@
 #ifndef __ASM_ALPHA_PERF_EVENT_H
 #define __ASM_ALPHA_PERF_EVENT_H
 
+/*
+ * Software events have no trap frame, so perf_fetch_caller_regs() fills
+ * in a zeroed pt_regs. A zero ps already means kernel mode; only pc is
+ * missing.
+ */
+#define perf_arch_fetch_caller_regs(regs, __ip)	((regs)->pc = (__ip))
+
 #endif /* __ASM_ALPHA_PERF_EVENT_H */

-- 
2.55.0

