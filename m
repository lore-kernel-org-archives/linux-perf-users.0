Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EED1993A3
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774471; cv=none; b=Q3TiI/rjbpXyT5fvWVnz7MbXRSOCITVdTEeTemZ5YSFc0KCrnCzHfrDxvhEgnYLxo92GRMAVDmH3RWPN0Ij4o3J+XYq0TGXdCYUekZoEXyed4OMQZdwNALhtL91e3n+RDzRlvpE0BLVMPLP/+PaPsPULB97trSLCDWq9pzExbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774471; c=relaxed/simple;
	bh=jR4luK8+IFd6VWu54V4hUotHm1xxpwamdd+wy2P7dK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DzX2IG5wwG5gwNDP5NRgjJ/p25v8PraNxMm4fiKCMyZvvEoKuWFQbsTqb6b0s7V/lD4zT5W34qxgNVAyKba+2IM8qpu8Unc4c0k+r9/noEb5ZsyOPFnJ/0tOI8YOr5d2Afc30I5vdnaQAF8uFqVNmWfvngDBrv7o6m8QCYSWWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+TjVcQx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+TjVcQx"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2164861e1feso14727255ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 12:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733774469; x=1734379269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DW8D+45b8xEbyPxEhPUcnEPnEVGFEjj4jIcIes+wDWg=;
        b=G+TjVcQxT5v+W/qoRzT3ZrJoQa/Et9Bk2PqnTLsLHMt/LIIYCuDfIMwEQBiujwLmah
         l2CgntpB5hQBDba1utz6zJlSlytboz+ICG6iC0hClH+uYOwJAqur1C6buDb6U58GzOXO
         T732l3j0YEUyKJbZD4h3DTSrqZaMYED7td2ltEIwJqGFub4hzHxjH79NfwFfOxvyqOwH
         xB+bjtLTfWHp3nFqWr8nkMBf9WnU/OPMXCmlVM+17Ks5SR0i5+voRCCQfpT9tt4UCI+0
         JDtZEQyL1mGSmfFobG/9izYlRvBGYu7Pe2KPs/u0NyP0De1vapIM01TQ4D7W2KwQyPK7
         kL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774469; x=1734379269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DW8D+45b8xEbyPxEhPUcnEPnEVGFEjj4jIcIes+wDWg=;
        b=wmZITLQRe/9vh5pUzgdCyAwNBlZ/24GceqqTL1eK4JZSZkpL0daaVFBzkrN5VqSPLf
         Sw+VKUo/L4XecKstWUDj1HiGyS6MYi8lVnWzyIYSsaOqieRg4+w840I6/uuTBnk0sIQZ
         aP/PaDCMa+baElSlwkUb1ykd6ELGzpxASsSurpqKivcJ0rSwwmymhtfWM3lQ2/vnhOJi
         ODchhMGsGJnmVJxfIWLTwyqlL/19egkCQwYsBToiC62oNqNmvtO9M9LgYb9lwMMUNjs+
         10GyRpVWyqeO/R6XnknOqoz3yViBfVaVlXaAxr8yAyicvR0LhBejCJFjEJTM8Jpje6mm
         A8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVpriRUGAxlDlmt5skD4uJDPdLUwyQKqhSJOswknPrp2VzWi+Tn41eCD/iBdZrX1yr6ZXIftr0mz2qpOKxL3h/O@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyFYLB8sYNtiE+B4XDMa8ggBZkzok86IiVNbveqvuUz496vZy
	cHgSwA7Fy6SQrEDmVFBVLnGsaWu6PSvfXZMLLTBxZcNPRZ4JHiSeveyngA4A9pUFY+OrjGsebLa
	Dxw==
X-Google-Smtp-Source: AGHT+IGZ2t3vSPZgRvKw/qvWh7sPSvOeQUeWjdJMWA4dXDyoTJuAiYU9MeWYDccdCS1GkVXMZoQl8TNVK58=
X-Received: from plru4.prod.google.com ([2002:a17:902:b284:b0:215:94db:1290])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b05:b0:216:386e:dbf
 with SMTP id d9443c01a7336-216386e11c2mr104336235ad.20.1733774468897; Mon, 09
 Dec 2024 12:01:08 -0800 (PST)
Date: Mon,  9 Dec 2024 12:01:01 -0800
In-Reply-To: <20241209200104.870531-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209200104.870531-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209200104.870531-2-ctshao@google.com>
Subject: [PATCH v4 2/3] perf lock: Fix the wrong name percpu-rwsem
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In `perf lock --help`, the name of `percpu-rwsem` should be
`pcpu-rwsem`. This patch fixes the naming in `lock_type_table`, and also
replaces the mismatched name `percpu-rwsem` before parsing it for
backward compatibility.

Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
percpu-rwsem`

Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7e36bbe3cb80..264acfa648e4 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1587,8 +1587,8 @@ static const struct {
 	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
 	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
 	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
-	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
-	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
+	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"pcpu-sem" },
+	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"pcpu-sem" },
 	{ LCB_F_MUTEX,			"mutex",	"mutex" },
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
 };
@@ -2365,7 +2365,11 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		/*
 		 * Otherwise `tok` is `name` in `lock_type_table`.
 		 * Single lock name could contain multiple flags.
+		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
+		 * For backward compatibility, we replace `percpu-rwmem` with `pcpu-sem`.
 		 */
+		if (!strcmp(tok, "percpu-rwsem"))
+			tok = (char *)"pcpu-sem";
 		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 			if (!strcmp(lock_type_table[i].name, tok)) {
 				if (add_lock_type(lock_type_table[i].flags)) {
-- 
2.47.0.338.g60cca15819-goog

