Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23517B425
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022733; cv=none; b=B9Jq6C5JROJcw63D30llbpNreska2JnzNQ0dcvq36OQ0kydhNUzDrAJrCTOWQAuLPYqMPAlm4/BLkNNKREaDZVZsZxdqy77gOXxILARGV92CqMlpgklqdkKY4LFrk8H96Duu/K7iUKkxMIkEl/al/x1rq1mNHPntJOfuYVpjc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022733; c=relaxed/simple;
	bh=M6LerUGQ/FegXHi0SxaTfjtXEbJdYcXQ+sl9wiXh/SQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o26nyB0Aru4niZC1Zjp2PpgNJ8qucDsKWnj/yO90fcrU5uiGvrxi6bB1B3cETnWHlxqukg15yA8VO7SMSMI5MU92JA0VeL7k8mwNO9/B7XiDcXxygdNbIE8LGbUzvvf9J9M8Ie+29BYznFdNXhi0ApTifJOafehifw/r+rOCCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YY4aStpi; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YY4aStpi"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so774944eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022732; x=1775627532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+JPhC0NfmjsreQ1S+6TmS21rrwcvm5mWtScohYKt4w=;
        b=YY4aStpiM/U9RYVlOTtSutUfCmdWmsnn7o4nWKGi49Ofr2iReqJfH40H6TRaY/77K9
         f4t6KnCY0sCdo6zt+gV1ooWipvTkGdxNlxcrcL8upaU16n6JF9Vc7sSsCjk8Gb8NPo1b
         EByH0hyyiol0EkEy7sJYuznCizgFMBun5ArKP2vqORf82dZ1+9lr0U4CU3oegGWHqM8o
         kyEqdHCo36HvyCYKJlZg6jvOyLRurG34glO2npB+r9VoggYuD6oPQL5KvA8A9cyVDOyU
         RKj1xKxRSG/0hDCJoQjhIAo+T0pNG2eauuTPV6KPlLIOWELF2WLAV3OmdMfPOy/cJvf/
         DPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022732; x=1775627532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+JPhC0NfmjsreQ1S+6TmS21rrwcvm5mWtScohYKt4w=;
        b=dSYwKIEJ9EZ4W90wcrIoMZbw/CWVn2UF/1oPk6bCXMcFPwhAZ+KPFdCXKglfh2GAhy
         48w5eVs2YEKliaFvxGN+rK4fTC3OV7Wt7/LTTG5/BQQ2lwre+3f95ks9AA3WtPq6igtJ
         2AfGsF9HxWacUHbxbFwgv1kY1Jxi4NwGRK3AmT8yRVSrAoh2Hy4AGPjVK1IVbJ3llCxf
         2XtjWAFwqA0UDge3DivGYP8IVLCLZ/ukE+8Pzbe7iKR5TNU4xN8jrDXwcEjGJ5dW46P3
         GxHy9nx1fssAAVg0CXA6AQMoh0aoeg3BRsxkxGECP/eiyH6JefUA2dZHKQWxLFXy7ts8
         jmIw==
X-Forwarded-Encrypted: i=1; AJvYcCUJEEMe9v+1miXsGfWULFyexl9PGZjpoczah3LCH4L5PIWmkRo2BPwpaBi8cMZd2j0xSNPwlb2MXU9g7N+/tlCK@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtpdHYKCN1keTY1kieKPPIMlIX+sFpmdJidrteCqSfWKzbJGP
	3ZhMLRNyXuaFo1TQP56fah11Wm58xZOShNK/0t6pd9+ArUgzMHWTzJ+KlUQ6KZqm455tvkNjbkE
	TkrEx/K24ow==
X-Received: from dybpk4.prod.google.com ([2002:a05:7301:4284:b0:2c5:c691:e8a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c1f:b0:2c4:8990:393a
 with SMTP id 5a478bee46e88-2c7bd4704ddmr3282942eec.19.1775022731687; Tue, 31
 Mar 2026 22:52:11 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:52:00 -0700
In-Reply-To: <20260401055206.43187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260401055206.43187-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401055206.43187-2-irogers@google.com>
Subject: [PATCH v3 1/7] perf clockid: Add missing include
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

clockid_t is declared in time.h but the include is missing. Reordering
header files may result in build breakages. Add the include to avoid
this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/clockid.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/clockid.h b/tools/perf/util/clockid.h
index 9b49b4711c76..33dbd8673c1c 100644
--- a/tools/perf/util/clockid.h
+++ b/tools/perf/util/clockid.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 #ifndef __PERF_CLOCKID_H
 #define __PERF_CLOCKID_H
 
+#include <time.h>
+
 struct option;
 int parse_clockid(const struct option *opt, const char *str, int unset);
 
-- 
2.53.0.1118.gaef5881109-goog

