Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79534372B58
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179383; cv=none; b=D2+SWZu288yt4I0aaRErFC1wTDC4oWo6lfEIjE0JV6AZ3H6r0bfeXGz4+vAFBpuzBd1Qbtmqj0CTJHJP6EmJGhpHTOf57j8ocYq/IR6FLsrdRXoZNWi6iQBSW7cZ+agfRyp0rUOzxo1hPrvhoBg4DmA7w/kANoPZ9qXIlS+zwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179383; c=relaxed/simple;
	bh=9UQ+mAHCmbD62qh1Ueqz3O7wcF6smtpul/ayAHwOJMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJGDZRjBBdaQ9r8esj/cC0DkftfZ++amzSqAcyMeVIgWOIschxWtlcbNquXOGp0IuZ4XcV4XB7r+6EC0igV0s/eTUGmX6ScCz4GNP1SKM1VeEKSnutZOyTgFPDMISsBFGgfoCbbQY/RxEZ8EBa0BGCzQdbavL3MFDWi9U8KuZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es2XzhIf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es2XzhIf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36535998b71so650250a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778179381; x=1778784181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bVOb7teSak4fsMnBroKa4foxmdWIqg6Zao3WbzrfFc=;
        b=Es2XzhIfjeA8WNz4XdGDeiYF+Z1GRBXlBkk9vTNPwpIO0X9kdXrBGoEK1yTPU5u56Q
         TOODIngp8koO9S7/Md+NPzRqSDxTVExQawRz/v3s5nlod52PrpKtYSfVhxT+RxIxuEW7
         aKdPY/xG0TdzHhFdEHN5fOPhl2NQkqOC9Ea/9A54mtr82+EMcmrpREI+7XKUSnk8nvpS
         HZlJl4vDfZ+CvW14af0jkbhkZimETek+uN4Dm4gkMmUT6etxu8HFqDkNWbZQ7LrgaRXU
         q/hiSawb1qMudyz0RuB579l18276rAXgzjYdZJAG7KpcIyGw4Ge0jQa8rz3CfOvRhZTc
         qvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179381; x=1778784181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bVOb7teSak4fsMnBroKa4foxmdWIqg6Zao3WbzrfFc=;
        b=TJYRyeMOpiDxgga0BkNwgrC8Nt/VvZ7kt45vfmQOOW+yU+PhdaM27LFiAU831ws7m5
         XtGqVlEAC2UhH77w2qKM6bQoZcNreAueEAAjCzQtnwU7lvFDtQY8hd5X92ThvTtEK9je
         MBduC8PZJHQHy3NfU9FrB/VFETxbPwE6wjOsqZtqmrptgeWFfdEOHf3RW/8uyM6EyJwT
         cCl8Br3T9kIiVieqak8ViCt+BfBKnqiDil25/F6ZhP39r4iaS4tNFsssThN5me3Zr/gZ
         Y98gBX/FCU779Qfy0e0M+cvUgw1vE7YLMIzfrr/oQ2hV6UFlMZ59YfGTxg8ekKX37pwC
         ozUQ==
X-Gm-Message-State: AOJu0Yy5Q+WPU8N5V20cJnwmXEqm9j30lOEvfCzAMLjFc8GYlZ1KJoWX
	D3/K2bJLzzW3VfqWS6D9PjwBCtRaBAze1ZqawTrVdf+YISvpnZU5Ud2G
X-Gm-Gg: Acq92OHAl74AXUcj+7YMzcXJh8fxAjKNjEXyV6fsWsJVa/MsTWiYoYnKYZ8HtFSwcBN
	YMztj/+PGbPruFFER3dV2Xi4176bH7w78GB0ZuUQ/L2nxiKfU3GUX0vpRI3yYKoL4yeSwB3uITZ
	7T1FXeREuZ55tuz+AU+kUbBhy0IpIuPYJMr5zSD8SrB+8Zqcimjt9FTKt3j+Y5op6QsQOcyLdqj
	9WLeWB7Cj4v5cWsSRn8CFvzZ8Z6vP+v5LLsYw5at7X5aoCCvVkvmi1XhlEHFA1a6ocvCaOLxV9k
	lyD/KLYRTfJEl9ZYZxgNstt89oWzBcOCMDOcRKRX3sZedpfv7der6btzwqdTdZeWd2oZFz0zolZ
	QUS0d6DeB+TwCRuoXKdeTtKlZydg9vOE094v2rvfba3KqFWGnTCh5saBP0KWxtqqtBk9b1y7SL4
	jIORDDTZBinWU2IXTRzVQ6FEco2A3L4YXpPmcWjcKIUg==
X-Received: by 2002:a17:90b:4fcd:b0:35d:a31e:6b04 with SMTP id 98e67ed59e1d1-366052d08cbmr3516766a91.3.1778179380759;
        Thu, 07 May 2026 11:43:00 -0700 (PDT)
Received: from archlinux ([205.254.163.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-366478fb189sm118708a91.16.2026.05.07.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:43:00 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH 2/2] perf build: compile BPF skeletons with -mcpu=v3
Date: Fri,  8 May 2026 00:12:38 +0530
Message-ID: <20260507184238.65280-2-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507184238.65280-1-suchitkarunakaran@gmail.com>
References: <20260507184238.65280-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lock_contention BPF program uses __sync_val_compare_and_swap()
to atomically update the max_time and min_time fields in
contention_data. This builtin lowers to the BPF_CMPXCHG instruction,
which is only available in BPF ISA v3. Without an explicit -mcpu flag,
Clang targets BPF v1/v2 by default on older toolchains (Clang < 18),
causing build errors when v3 instructions are emitted.

Add -mcpu=v3 to CLANG_OPTIONS, which is used exclusively in the BPF
skeleton compilation rule.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cee19c923c06..a9a8c84b6b00 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1195,7 +1195,7 @@ ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
-CLANG_OPTIONS = -Wall
+CLANG_OPTIONS = -Wall -mcpu=v3
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
-- 
2.54.0

