Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD9381B1F
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296873; cv=none; b=MJ3fZMy+Jy5sBhwpGYJcA4M9Us8tMVS+SUcRMLMQqpjel75Q2NXim5jnsfPqCSmEw+JTxJbbUsGHCWAk7qInFA7DEsb2ZsiajErPr223HVj1X0yLl7gIvYd/rUws5c5GIeJbzG5qaKbQj3sYEMmXJwHyUEhfYPPHV3AIeLm5L/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296873; c=relaxed/simple;
	bh=MFEe6LPphunpb6kkXYtvg8HS6T7M6CMwxT39S2tasIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XN0x7OFlDyRuS3apPUG7n2x4U2rg+U804GKYGLZ9Fwp33FexVbPXtwv0TmdhbrxluG5ELSJNzWM3aD+niNk6kw1gfRliAP9hBQb/APrX1YgNq9H8FhEjNInNK9tWaEVeoypVe4qfgd4L5H6/j8y8uW2bSLeSV/+jA5lGehhVOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIB4vflA; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIB4vflA"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137d003cf09so2041603c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296868; x=1780901668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMPK/u4znZdID92cCsTtghz3RJZxs3ue0UuQgkEbF/o=;
        b=KIB4vflAPJF26bbYF3f2nMtsxsjNRjUaIIGTYZxQ7YUCp6EKQtXUyDSIK/Z+Okvelg
         JKj6Oe0j7zSWaVo3lXgAiZw340yAx0OEyTeSRAmKGZxFdXUVZV9ZlueoPSORnlV616Kx
         fCOEfWiTWLbaZrTLoUcpb6B9heSGHsI69Mh6R9cBoxp5uNeJWqqYExdz8twNsSfFS+Pi
         qWraTpjp6OkILcrJyO2kFQzvxqXlBZxHUUQBswHPYEV6MxmuD0kuFI0DJ7PmS/LSac8C
         KXCrO2b1R3o5dcm5Gnu/RVNgOAWHCtfdc2TvyNLlV9M8hCBLkV70eMQO4um25Iw0Nyqh
         E68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296868; x=1780901668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMPK/u4znZdID92cCsTtghz3RJZxs3ue0UuQgkEbF/o=;
        b=f+l7FkbOJVG95VggDRzj2tt8+u2MvWgbxltUI7US9CNqbd3CH8C+B+ewWHDLbOtxUR
         PB0C2ybXbQjky2ZYqLxLMP1ljIPIdkp7nSeTlKMcxSjwHTl7Fl+KEfHnB86nlHW12HqW
         +Ig+/cQH+ef0M4XeQf+w2P5cKljM5EB4QtbYs/I0iVctgUWkHgnww0nyBMlvGqwcMV2V
         QhnaPrzPHueo+d/wQ6rx17+R6D6a8uMqfn3QxDHmXH1Q42vdIvckt9KozX4b0VLVNIdJ
         vYDTXeJBdxceqbbeRAZ7bdhlgA3eNjy9VXa5DCiQAQ4hhiNaJwc0vgyalmv0GWi1OEBX
         qmRg==
X-Forwarded-Encrypted: i=1; AFNElJ8AoqOfezFZa9xK7F93L959jLib1LXHKy4647lbMPH2b3tfB6blDWFlqqA4D3UU2+gkkxvmQ0dqz6Ysxs5f0LE+@vger.kernel.org
X-Gm-Message-State: AOJu0YxYHIyz166fUDePw+3g8vpO9rTa0eL4OvXzq56YQr959GNbZhpB
	kPeP7il4b5X23yGnMXKtejv4aKEmggB2IUG+24wnuyo14ZCfaUYhUubDDV8NWFspThY1F0UoEcY
	W+qXCmCEBzA==
X-Received: from dycnb7.prod.google.com ([2002:a05:7301:b07:b0:304:d169:68d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:100b:b0:304:d32e:65e5
 with SMTP id 5a478bee46e88-304fa4df7b1mr3917439eec.8.1780296867507; Sun, 31
 May 2026 23:54:27 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:56 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-8-irogers@google.com>
Subject: [PATCH v10 07/18] perf machine: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The arch string is derived from uname and may be normalized causing
potential differences meaning the ELF machine can be more
precise. Reduce the scope of machine__is as often it is better to use
a thread for the e_machine rather than the machine. Switch from string
to ELF machine constant comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 35 ++++++++++++++++++-----------------
 tools/perf/util/machine.h |  2 --
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e5d1e8b882a9..47be7a44a5f7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -9,6 +9,7 @@
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "evsel.h"
 #include "hist.h"
@@ -1627,10 +1628,24 @@ static bool machine__uses_kcore(struct machine *machine)
 	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL) != 0 ? true : false;
 }
 
+static bool machine__is(struct machine *machine, uint16_t e_machine)
+{
+	if (!machine)
+		return false;
+
+	if (!machine->env) {
+		if (machine__is_host(machine))
+			return e_machine == EM_HOST;
+		return false;
+	}
+
+	return perf_env__e_machine(machine->env, NULL) == e_machine;
+}
+
 static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
 					     struct extra_kernel_map *xm)
 {
-	return machine__is(machine, "x86_64") &&
+	return machine__is(machine, EM_X86_64) &&
 	       is_entry_trampoline(xm->name);
 }
 
@@ -2786,7 +2801,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 static u64 get_leaf_frame_caller(struct perf_sample *sample,
 		struct thread *thread, int usr_idx)
 {
-	if (machine__normalized_is(maps__machine(thread__maps(thread)), "arm64"))
+	if (thread__e_machine(thread, /*machine=*/NULL, /*e_flags=*/NULL) == EM_AARCH64)
 		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
 	else
 		return 0;
@@ -3157,20 +3172,6 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	return 0;
 }
 
-/*
- * Compares the raw arch string. N.B. see instead perf_env__arch() or
- * machine__normalized_is() if a normalized arch is needed.
- */
-bool machine__is(struct machine *machine, const char *arch)
-{
-	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
-}
-
-bool machine__normalized_is(struct machine *machine, const char *arch)
-{
-	return machine && !strcmp(perf_env__arch(machine->env), arch);
-}
-
 int machine__nr_cpus_avail(struct machine *machine)
 {
 	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
@@ -3197,7 +3198,7 @@ int machine__get_kernel_start(struct machine *machine)
 		 * start of kernel text, but still above 2^63. So leave
 		 * kernel_start = 1ULL << 63 for x86_64.
 		 */
-		if (!err && !machine__is(machine, "x86_64"))
+		if (!err && !machine__is(machine, EM_X86_64))
 			machine->kernel_start = map__start(map);
 	}
 	return err;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 048b24e9bd38..aaddfb70ea66 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -224,8 +224,6 @@ static inline bool machine__is_host(struct machine *machine)
 }
 
 bool machine__is_lock_function(struct machine *machine, u64 addr);
-bool machine__is(struct machine *machine, const char *arch);
-bool machine__normalized_is(struct machine *machine, const char *arch);
 int machine__nr_cpus_avail(struct machine *machine);
 
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
-- 
2.54.0.823.g6e5bcc1fc9-goog

