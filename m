Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC050126BE6;
	Thu,  7 Nov 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999792; cv=none; b=tj356MYXMI1n+HZtGwRsIcJbDFou5ebUMUOAXqhDpHKTQUPBCKl4cw2nQVlDOBS6votd2m63CaivuivSbyr7yr5aq/ZX3tYlc74VZCMdymtL7AkRAvSR+ORpl/mv7VLxllZJSlkl7xQw69D6+0YhqiDvsR9JZtOCP8Q1+UIx35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999792; c=relaxed/simple;
	bh=So1ItwFzTb3sOVIA2K0+hbsdqiPV9NaUSDc6GNfHju8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mMooXH8O398YQkLyWWB2/qMIUNoHjle0aSn9XV/DgUedzbsTxNl4EOVo9wAXug5o0/rpVcnVkDNgy6DAAc1nME0pNWUuJu6xu/1Kl7eu8s04PHk5wFeaBkLuBx+xc3mC32ntNmcoyZI2poWAhPa1SKOQzUZkG9afX0ZcUbDxxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so1820361a12.0;
        Thu, 07 Nov 2024 09:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730999789; x=1731604589;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c05AdoavVBEtEpntL9m9L//Xh/fyzArHkZId1csiUDM=;
        b=EjGp3QxJ2HKDDOdyFUJFRD/AoRwRUzpRGuinlWSu0GJ4d218RLrZmsZQBnQsYkMrIR
         RM7Nz+FG+oZODdxdHm5KZP2V+F774yJjbw8ZFd3wyuDUrDhyQcKQmzC6xoFH8BL4qoPr
         ZIO6bzCz4xMDCbxQ8TVlfcI8507nt+Ju0lDjcOOkjla3Ag2RgK4adyosRxqGnx+YNgvK
         3/tv+ZJIeeOKCf50OCWA7L0yXv/k9ONmD4kp5gL0PaJUhThskH0EdF0YlOJxvAdDMFip
         uaOOhRmryTKCmsAwhaFAd6NTXKJOCqTv0sGO9KGRwjZwYHEyOlLwfiaxILHsKE493vfc
         JlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU36yRrYv8qaf7pDyZqnARi8ZAFfUuI9YYRSjsSo7R7MmjlaaHEUB2xWsnMObAxblX2OPDdnyU57+Aty+U=@vger.kernel.org, AJvYcCVy/fYnUo6KTKt2MElosGo5Lst6NBdZL0ZxrbfP++ptjQ9uDThympHJjc9BAAlB3yJtLcD7vp+8gHOqL5ODEcZS8rA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9GK2JoZ2o3lu42NmbZrVnuYwbjfmuI4myRyxVqQxh2Fnh/4H
	gJaGLsm7/S3Cql+QEjFP5bZGLy8JZrFO3NG2jfkEXoRPMTxQILun
X-Google-Smtp-Source: AGHT+IFBp8GHOG1P851RY/sUXkxwli7d1MwxXtbYslYH/o9tZbi87es34ilrMyOQOBRJj3nvwY6SYw==
X-Received: by 2002:a05:6402:27c8:b0:5cb:7877:a633 with SMTP id 4fb4d7f45d1cf-5cf098cdc8amr144833a12.33.1730999788771;
        Thu, 07 Nov 2024 09:16:28 -0800 (PST)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7cafasm1001103a12.84.2024.11.07.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:16:27 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 07 Nov 2024 09:14:45 -0800
Subject: [PATCH] uprobes: get RCU trace lock before list iteration
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-rcu_probe-v1-1-0ca8cc2dedfb@debian.org>
X-B4-Tracking: v=1; b=H4sIAIX1LGcC/x3MSwqAMAwFwKuEt26hLeKnVxERP1GzUUlRhOLdB
 ecAk5FYhRMiZSjfkuTYEckbwrQN+8pWZkRCcKHw3lVWp6s/9RjZjryUpZvromkcDOFUXuT5r7Z
 73w9nmSCVWwAAAA==
X-Change-ID: 20241107-rcu_probe-bef660d84990
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=leitao@debian.org;
 h=from:subject:message-id; bh=So1ItwFzTb3sOVIA2K0+hbsdqiPV9NaUSDc6GNfHju8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnLPXq63gvad8/poLKw+za0lChnG2ApKpuihLRD
 uDhk9YbyxyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyz16gAKCRA1o5Of/Hh3
 bUBcD/4/xrsdxE/e65Z6mOBOIxcTav9O5oPUynAmzoQioBsUi958zhlLAlQ2ZmU6V026Rlf8zAu
 e8VQnwS04JaUP11KTXbPM0Y6d7XX5GjtTvBJ9MPaRr5s4PQV4d5d2WMy4Lmupi1HhBjSVE5nkc5
 x16hW0rS9TUvu0tCqbb7UqllOKNvGX9uR1IkFP8wXWAMiAmp+0xEuUMau51KHZerPfpJdl/9OoV
 TjzurblklxkHRa+BvLkVzBbaUFqfJKT+vsQuWKUhSxGRyx1Znned6mmlUpHZ0wNLWFemHifN4/o
 nIdyQ+6lkLjH8/SfKwmFJ6gnXhzD2N2CgUBckRE7rOH96VcFMvYaPaDgOd03XLuQbjYIzSbljja
 /OX+BtKQQphuAirWufKH/PcXQQaJ4LpoIWnJVFKBheEBGfQuFJe6YztyELKQaqbcP9Ue8VbeT30
 Q4VKMj8Ly7TN4ijHslvSxolLUnZOGfITuvr5jnQqlQOlopgNkxgYnRpx2q3l1u1ZFoUF9YEqhPN
 d5TsP7s70enuHnBlt+8h0BGH0UMfDrrRTPJFkC2poIThvlGVE92WeDyo+Vk7wuy3vU4nDJ2F2vI
 3d73wtjoUO/D13NjO2Y666FxZoIe85OmC3fvbmHSVlCttn1zUXMGzppyxAccqFjMb9YBLFxHoKw
 Yr6c2LOKfoZRu1w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Acquire RCU trace lock in filter_chain() to protect
list_for_each_entry_rcu() iteration, protecting the list iteration in a
RCU read section.

Prior to this fix, list_for_each_entry_srcu() was called without holding
the required lock, triggering warnings when RCU_PROVING is enabled:

	kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index fa04b14a7d72353adc440742016b813da6c812d2..afdaa45a43ac3948f7983175eda808c989e8738a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1103,11 +1103,13 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
+	rcu_read_lock_trace();
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
 	}
+	rcu_read_unlock_trace();
 	up_read(&uprobe->consumer_rwsem);
 
 	return ret;

---
base-commit: 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb
change-id: 20241107-rcu_probe-bef660d84990

Best regards,
-- 
Breno Leitao <leitao@debian.org>

