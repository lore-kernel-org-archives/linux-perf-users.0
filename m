Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C116D9B8;
	Mon, 11 Nov 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335681; cv=none; b=TFeuQEYY0SJ6jtuG+zE5uJQcvSDF4YvwnSahqReD+miaqVEe9+9CjiyR+BXaboTtfemW+6qcnw+OrYBrPfUeTG5+IscgYGZt7DakxzJcNTuyZju3fgokZrff2pJAiRJAz4lDcYi/ICRYVoCsZPJTZGPYrZuCKtgZu9Y1ftkb9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335681; c=relaxed/simple;
	bh=VOJskPes35d/MDk8uVewPYUAlhDZ99HRMRkVQpprJ64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GHZJPePy4Itgy6UPuI2hgjjzmN4bNjnz+Mk5bAf26hd6AcU8q/+lizgFcUL2qYk2O0/ffXgr7b8TmJxlM4ubGGj2PlX1omStgTxFxP+vWiV+vR5o11oh7RGvw6QIGytJ6pgTesSxdZuJ54CN2mwzLe+ZHDzE22l8+XfZGBK3ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so6764599a12.2;
        Mon, 11 Nov 2024 06:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335678; x=1731940478;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz6uHalMmUiaUFgiKior+KaxTNmvWdbfrpj+EULzQ5Q=;
        b=IqRicIBM/KWhSADZCm8rAd2p/uzU3CFY6sf0hnygjN994XxoALAQx1ZxLnC+rx5OTh
         nx7pDxAsD2lvnmjBTG0HJJozQ2ALPaJeokehm6Gp14RJtwQZ/xt9CBQ14zFpviMQxAzC
         TwUAdghns5ViLM2WxVIjPhkAi2BtEXhbeKgc6tBkT/GB/CDGa4WVfnVxMpB9Em3OFlBT
         1D+Ver+ke/p2su8ArXBTYVpBvl7HG2CCV8TU4Ka3rpyshPeBqmTgJ6yW04/pWJcUgj1M
         Mqb/xyThT8QQpB9A8kkmY2Q4P+loD25ZfB4dDVk4+xiHPSoGGS38TZ4c1a6VfVA7xWxk
         7/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXbGBy9XR3Vnv4t08KpSv/Z/QSRQNyjAMqwyABYCQAQ/zRhTg6lxV4YzqrZ6LNKgmhoow0QE0LJCuI64N09yIG@vger.kernel.org, AJvYcCXp2evfG8ALI3v6/wJGycoYqsnnqGonrtNvUMK2ctCIB+rjDAQ6tGFN6VbfXli6jqaNPWsYEp4xy+Na/TgnU+12c9w2@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3GiKY7HsTdd4nCQCP/H5b44b/Ez38lipKInfvNqXvYvUUBmN
	pbyikwxB6GiIroAGD72/EbqI18m/TmdKGVNDhHp7UtEM3MqCmAL7
X-Google-Smtp-Source: AGHT+IHBvDYvseRFWb1bhjU2TZxmStwtfMLBxP+C1E1/LbVMrTP0tYJSHCmGBwbCfdHMRgkJtWDRwQ==
X-Received: by 2002:a05:6402:1ecb:b0:5cf:757:f493 with SMTP id 4fb4d7f45d1cf-5cf0a44193dmr10097302a12.24.1731335677556;
        Mon, 11 Nov 2024 06:34:37 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d4e0sm4998883a12.10.2024.11.11.06.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 06:34:36 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 Nov 2024 06:30:30 -0800
Subject: [PATCH v2] uprobes: Remove unnecessary RCU list traversal in
 filter_chain()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-rcu_probe-v2-1-a091b59b58b6@debian.org>
X-B4-Tracking: v=1; b=H4sIAAYVMmcC/x3MYQpAQBAG0KtM329bZlHaq0haazB/0Gyk5O7KO
 8B7kMVUMgI9MLk0674hkC8IaY3bIk4nBIIvfc3M7Cydw2H7KK4c22mOTRXbyCgIh8ms9391/ft
 +qUJph1sAAAA=
X-Change-ID: 20241111-rcu_probe-0b8dfa53a8a1
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; i=leitao@debian.org;
 h=from:subject:message-id; bh=VOJskPes35d/MDk8uVewPYUAlhDZ99HRMRkVQpprJ64=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnMhX6bKP9iOggzHd/RX/p63dQ7cUQRyF3IYp5D
 P6ISBvalBaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzIV+gAKCRA1o5Of/Hh3
 bZV9D/9NyrwgdSUq68jZb34b+QkqCgJeNPE+XN77ppfanCvSWaD+8OZaYX3Y8Hre8hzFUT45OSJ
 EKOsCICA0d9OvcIraU3PzxC0CIPzaq/q22X3c/OQkcm34s067RT+8beix80Me1ilrR3XHNYLZUb
 TOOztKWcl8C/xn++0cHabrsTlaWO1kuitPNgvMtkIopw55B+1Qz1Hi8VxwlLKHZa8EjG9e4Zmn7
 7zuPM2cIKNAukIlj3AYe4jOcXlUMwzu1g9CM/I7HE3pT+k+rx3Q6SN47odccZO37CIdYzDOdgLn
 /YpCm/WT25/mc7ik9E7TRi/FiLJ53oHpgs+d6l3fCVubQ5v95o+RfwSlwCi+G5P4GeM0tkoH4C3
 pbXWXWFSXub6XZsxJb6Avyio5keMFtPtPstOgblUc5b1ZrLF9lB34/oWxlFaULT5kVdLqxn+zvG
 UWbMplKrUDcydjOiyf357yY5CJGeuP4wFN4J3X4KL8DxdUrQ6gsL22DH7A1jAAtl3LyG7w0n1th
 0AT/x69wkaJ3Yisb0maSgFa7Ehw833cl+Z3A0SCB5Jkk198wK8tNhEJw1BFESh5FbVr/9TqU5An
 YhjTcoqI2YiGwnX6EncrRRwVI2cg1Gv67ejP2vUFcuwmdcbeVTrtxaU09zDIcBscxSKVudAxXcu
 djTaaazZ32EZo1A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The filter_chain() function was using list_for_each_entry_rcu() to traverse
uprobe->consumers without holding an RCU read lock, causing warnings when
CONFIG_RCU_PROVING is enabled:

    kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!
        5 locks held by bench/182758:
        #1: ffff888603aaac90 (&uprobe->register_rwsem){+.+.}-{3:3}, at: uprobe_unregister_nosync+0x28/0xc0
        #4: ffff888603aaad28 (&uprobe->consumer_rwsem){++++}-{3:3}, at: filter_chain+0x20/0xe0

The uprobe->consumers list is actually protected by uprobe->consumer_rwsem,
which is already held when the list traversal begins. This means the RCU
primitive is unnecessary here - the rwsem provides sufficient protection
for the list traversal, as reported by Peterz.

Replace list_for_each_entry_rcu() with list_for_each_entry() since the
RCU read lock is not needed when accessing uprobe->consumers under the
protection of consumer_rwsem.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
Changelog:
v2:
 * Move away from the RCU primitive (list_for_each_entry_rcu) to the
   non-rcu one, since RCU is not needed here (Peter)

v1:
 * https://lore.kernel.org/all/20241107-rcu_probe-v1-1-0ca8cc2dedfb@debian.org/
---
 kernel/events/uprobes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4b52cb2ae6d620b2526de7e86291bdc137aa4f49..372fde678cefce72650b6c200ebea0093193ad6a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -934,8 +934,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
-				 srcu_read_lock_held(&uprobes_srcu)) {
+	list_for_each_entry(uc, &uprobe->consumers, cons_node) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;

---
base-commit: 774ca6d3bf24287ff60b7d6dd4171ebb6e47760a
change-id: 20241111-rcu_probe-0b8dfa53a8a1

Best regards,
-- 
Breno Leitao <leitao@debian.org>

