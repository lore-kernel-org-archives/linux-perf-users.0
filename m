Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28091F7569
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767801; cv=none; b=hd9u0ZwtO34nijZ3If0i6J/AA5KBtS/l6Poodlpr0J1yZf9mhuewsQjuWXBuJ0HTPGd7cTIpfO4AhWstAXQq1XG/Me0iZm/6Rj2twgrLB1VorM0PvIvqdI9WdxhGis7NWOqIn28C6fX+c+8bojxl3i48tWQGvUxTFhM1TAXMzVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767801; c=relaxed/simple;
	bh=uvhPGJ8aFyrj8sz3RY0F7uCaw7UwOHqluJDNG48CN5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ssfCM1YLTc0wNzsioz3oChrstSa3WAvSoNZ4CMxt42AP3lwhZHDJsV1SRJrLxrfZX+CdsMl2CM8HRVY1uk6sN5n7/dm5FZ5aonyTcXKfUA1bhScLLM4Yh0J/QpRSdEL/Hh3DnBiuh8C+UFZGIvjDekNC9FhpM3R8Vm0fUHYZFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ir6JcRfn; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ir6JcRfn"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8ccc7593so2441585c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767799; x=1778372599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5+XfQfSgM6vL4wGV0II5aik5OsLQWVkexovkX+K6RU=;
        b=ir6JcRfn+fI3ai2inAHCgum7TT4eeyhx3PV980fZlANonfV14RihGMmFt8cCq5A+b7
         aWB62sLS5UTdPl/M6RmEC7kRX8iwey9m/MkS2AHo+pwX985O5YUPUhHURsx4MbBctIXF
         PDuGtuzPRD4S38WP9edMgoXrV89OrAJIvzpixdkuK90L8Nxl4MB+NhbKSl7NWOSzm9iW
         PkowJUfQPINZY4G3die4va3o5pFo0SADrg015kJDlyZask3S1DsnTgW9gLXlwhUJgwBt
         5PDInkh0ASkkovqBaGQoMU8A1Yo4DZc2J3rudSCsRx22NEyy4RO4sxkhUW8fs7dEu3tH
         /3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767799; x=1778372599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5+XfQfSgM6vL4wGV0II5aik5OsLQWVkexovkX+K6RU=;
        b=VXqi4NgDaYUdMUsLovSu7gzxijlrOYUSSJsRVcjIi82ZKd1octhUDiyJ2iNtYv67I1
         Qe0VNP/wZ8ZHzM4MprAcQODZg+kiTVXtdMJtVffewzg39/jPq+cNpznEGAaB7nIMsMWW
         G1QlCQ+3+DHsyTvRyf7lFbwGUxtAec3cySWFKH3wscmtWrNh4n8l1GhHEoqh6ZgBNQrg
         jiGSMKzOL1uibz7m3ETTXUMwQ44Agrp1ajwoo9GYSUfdpKqsUI8q7O3sypaIyremoiHz
         LWUckzrKeGwInO/0K/kElcndjmu9RA9bYE1WiLoJ5GEOw+kELO+GKTN2JGXPklFxh5JH
         d+Sg==
X-Forwarded-Encrypted: i=1; AFNElJ/KOuyhpfvk5jRPyDObQ+WQCb6aa6Hhi6D7uUzA2MuqdQmGCQdMXyOWGe7bt3SCg6ctDLJK85lJwCONad+wYpd/@vger.kernel.org
X-Gm-Message-State: AOJu0YxHSWsZ03gO0s//3CNt56P8JCxfvyvhU7+wxd6+vGYguDQQxNcu
	E56rxa/IT7wb5F3GeSmwrT275pZae5IGwj7/ee41E28c9KlG85fvK5xR95z9Ik25A3Wn1RkMo9H
	KO+MK19gSjA==
X-Received: from dlbbo32.prod.google.com ([2002:a05:7022:43a0:b0:12d:b396:eadf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61e:b0:12a:6e97:c21f
 with SMTP id a92af1059eb24-12dfd71099dmr2240616c88.0.1777767798592; Sat, 02
 May 2026 17:23:18 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:43 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-14-irogers@google.com>
Subject: [PATCH v9 13/18] perf lock-contention: Use perf_env e_machine rather
 than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for powerpc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/lock-contention.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index 92e7b7b572a2..119a7206f3cd 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -104,7 +104,8 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 	struct map *kmap;
 	struct symbol *sym;
 	u64 ip;
-	const char *arch = perf_env__arch(machine->env);
+	uint16_t e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
+	bool is_powerpc = e_machine == EM_PPC64 || e_machine == EM_PPC;
 
 	if (list_empty(&callstack_filters))
 		return true;
@@ -125,8 +126,7 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 		 * incase first or second callstack index entry has 0
 		 * address for powerpc.
 		 */
-		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
-						(i != 1 && i != 2))))
+		if (!callstack || (!callstack[i] && (!is_powerpc || (i != 1 && i != 2))))
 			break;
 
 		ip = callstack[i];
-- 
2.54.0.545.g6539524ca2-goog

