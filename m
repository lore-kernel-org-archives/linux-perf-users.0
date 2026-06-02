Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D393F1AB9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413972; cv=none; b=spDpkPK11piZqOoRWhbQrbIpz1IgkVD12In+EQORc0T+VF392L/evuAu0qrkMIiHa0kaIy25qyIo2ihPnQyG1G5nMXm/nKvw4T+zDLK6SpcXpNa3DPte4vatHB/iXPyihwC3eDBNDZ804PK6DbOrqEs2394O9FaS5UanHTkHVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413972; c=relaxed/simple;
	bh=AJ+cfGDfN/nv1QtOco5T/vUczZG+yKOvnd/MSYaYhLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxC0OmcoqhjE04WX62s1q7B4wldD0XXvXpqHlhn/uSJBNYX0nQ+UgkOOahPt9sOZjKPhYwF/LEGT4lLEFpQZZNR41zkW95hGvMkFvOzqLa4080cbSTd4+jt5BUWsm6UdNGC8ZBWL5aF7Q2ihO7lurkS32hirS0g/HtIqrTBqW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jV3tLdh5; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jV3tLdh5"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e4636205so12769462eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413969; x=1781018769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=if2KD53xtMqvcoFidrX8tSNh3zZDo7SrSprlPMzY0lU=;
        b=jV3tLdh53S6/psuxN5XoCrpRBTYhZqnep4LMGgeYNfGngb6NegJigv63DJ6QsnRLEg
         3+yAghUJpRV/+usJwDpBYuKcuMMv5XA7rCClPfwzlVl8JRbGQ/cmIS3rR8Gqw7H5WmVx
         J29lE7zZPSShztwVwR6JSB9XqXU1LaZtGoR3+usSYp2b3ol2urrn1WMgpPJf4kviS+SW
         R0aFkq2unmeBQuGEDO9C6EQBA4CyT2tYhVTA8zgAVvPS+L40C0xxdzGGsmIFSACe3kwM
         LhYU6/lhYw+7F5rwnvjJROjRwCHVGT6ZjwumFnwRDRKPtM+0UnAZPlI+ZgZZPNJLon2G
         NsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413969; x=1781018769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=if2KD53xtMqvcoFidrX8tSNh3zZDo7SrSprlPMzY0lU=;
        b=hpCt2BOsM/vwM79gna2iGTW0wiO9r1aBw5mJpdjYL1mzUVlN9nkPps/PtCvZe0vsTV
         hgT9+dNP9Jg7SqvmimBQU8Gu3dAUQj0dRQD9fkVxuNHwzwAZjOaHSHxaT4PrEu9ud/qA
         mtGn9VmJNX+YeCH80dBZ9Ig4ZzP+qfqPkB6LJuQzdILbLli1jnaD14h8VpKdbUrQAMiS
         4N2NjWYbesPPut/qtvA5X6FlFuyKajDNn7Z7gPZUeHiNCGRCV/qDunp3oFlIj8OrrYHV
         /2FIJPBBcNvLpoEl60SU7f6L0AihuCQep2LOFcspaxXEmHFnTtmeEMIVHGA7lNHTgEme
         aO4g==
X-Forwarded-Encrypted: i=1; AFNElJ8bu3uaNlwHs9zzuAtK33lwvzzM1C9dAzN3Fs+GnmOpPW58IrliStFRBC8Wn62S2pEZNh1V+LrSLrsINlznzwUF@vger.kernel.org
X-Gm-Message-State: AOJu0YySw6QNNYavKVnOzESlHTkkE+zN3va2rk1nASIGnjTdOyx1yFsy
	KNWXYxaigThBNvdHow6FUlLlsQe2Gf2IQUgJm12edJ2W9AA25+UcX72SiPrl+iXfg8Sek4FrAmQ
	37J5vE9+SHA==
X-Received: from dyce13.prod.google.com ([2002:a05:7300:724d:b0:2d7:e13b:ef99])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cc0e:b0:304:5a9c:6452
 with SMTP id 5a478bee46e88-304fa6800aemr7694858eec.17.1780413968876; Tue, 02
 Jun 2026 08:26:08 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:10 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-14-irogers@google.com>
Subject: [PATCH v12 13/19] perf lock-contention: Use perf_env e_machine rather
 than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
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
2.54.0.929.g9b7fa37559-goog

