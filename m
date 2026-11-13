Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588138;
	b=kkEEBwJRgFOJfvHqLhiY5WEOnS+IgdseQbSJ5JGK/YqcUQQOZdgpJlBKRBIb/PS3SAb1
	 HtXH6rvTlqktPUzbqDNtbmUxVarcKnGizEXuxG3I1knf88lB3U3Q1V6lzEcRqZiH+IoG+
	 5IcHVPZpP0qRuf48RuWkaRoqfOaMeiBpoyZghStoOL03+7eJVKeruvPYqS3aBLRq0DCF0
	 /0hTraTLBZ6EvUrb4DlbaLYfSRTUZp9pbD8tZSzvXhXTYbF5VaoXM0iNESezi1HxvgU3D
	 yYP7fTYuZ9E+xBU4gMSaevoFTE7De91jz9CsHGHDncMNZRhC6LICHAUDCe+66HQ74Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=rDTLPla507EOtrS5G3hSHbXrnwat6DVdvRdqc4cmgbI=;
	b=r6pt41SRJ8k6Y+5gpAwdLxvF/ZnGSCA6/hqu505aaXXgVd7SeAuIqyU4avDiyrHCGUF4
	 2Z4aK9WhhPSzt/sC2+JUh2omN42k8dJ/2bLtztP54s/xLs+uP1ErwkTP77P9EWameN1xU
	 p8zttQ/TIv/tE/+B0tozLl1yVGHVG7PfTqL/MoSb4ukQhDtingItV7ouAGnSs4VORZlzi
	 UEjiKqB+hdAOJXEhiCly3t6YeyE30vSaRxr+jJCrXfZWgK1YYJyyeYcRc2scQfs51+2f8
	 4NAi9dxcfrUZsU40fSApTl5NHMhhJdel/CjCUWmo/k/fG/lr/GgsA0NO1A+Y30UyHgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GctDAgMT;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980C606BCAC
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A980C606BCAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GctDAgMT
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-378722fd4a3so1356060eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588137; x=1795192937; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rDTLPla507EOtrS5G3hSHbXrnwat6DVdvRdqc4cmgbI=;
        b=GctDAgMTeP3l9EaqInwGPLJMnRNGXqZEmICmcqt6CgxxyaKiO+4krHCcmemyQdwHw2
         NSXRJWiBkGQYO2R6cKSyWeEhfq8PlBIw5r/CUdQc8bkpZjydA2KlgO46l1CFROlFEVCk
         61yaF2KUB+MUXiJUifP+3vVjLYvcjsqhN6zdxFojiwtp6VZgeFQswvOzA2UuReDveE99
         8byMqhuET2vs3SJmiSLfQMOB9zBr6wQ2vABXQZnRuPiL/SBrU0aFBtrujfxvDXFL/PUe
         +PB9il1RVNek84d/lDV/mQhlALfNgOnxcM34n1oWCKfS9VGi/JgMaXYplHqAr0JR5Jqt
         zi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588137; x=1795192937;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rDTLPla507EOtrS5G3hSHbXrnwat6DVdvRdqc4cmgbI=;
        b=WN0b85FPbZNbZP9M+qSpIO0tbIk4ILNFNzSkPiBzAcekHB2UXwXhgHmMQ7ckqzeKlv
         ZO4bl7758JgExwWFYfmm9xJPN2KzRgFRiaG74kC/w4HzvEH57HVUGi3Fy3/lu0Hc4/JL
         lWPE4tCHFHVZF0py0s9HHUl2IS1L9Rnw9OZ8Gv3N91O6ZvsCYSPCGNJRFnxqPpYC3zOP
         975nY59LtvJyzgtLaa/k7cFhnNLr4SQ78Aj9eqhWj7YbqEKV9g9dulKJv0GX8DiUaqww
         4raKjr3CzHrUHheVzChAcfpa1qFBdg32kxMatOON9l7+Xc3+fD/wk5RZg/VNKWhPIiDb
         Atmg==
X-Forwarded-Encrypted: i=1; AL+hErFCfRFkzv9MbseIU4f2hqQPAUEANIsqoPEzimsRIfmTVw67T//XstYOyq2nsedKdwmwGuc9044KNeAuNwwPJql6@vger.kernel.org
X-Gm-Message-State: APuU4Z8wD9GaS6IMsN78RWZH5HhXEKthRQSKbwLTjeeeBG7X7Fw4QEsh
	ErFBqhFnm3vQe+NvyDmWJOB7y78hgmZOwnGZ/3YCMYZGbQQ42FoLy3Nzdxz2yonDQpXjnrVVJkI
	Y9/0CmMX5Ww==
X-Received: from dybrw2.prod.google.com ([2002:a05:7301:4e42:b0:37a:8a0f:3aba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:414d:20b0:36c:d1fe:84ce
 with SMTP id 5a478bee46e88-3796740e475mr2991962eec.33.1794588136311; Fri, 13
 Nov 2026 08:42:16 -0800 (PST)
Date: Fri, 13 Nov 2026 08:41:39 -0800
In-Reply-To: <20261113164152.2095566-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164152.2095566-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113164152.2095566-9-irogers@google.com>
Subject: [PATCH v13 08/21] perf dsos: Skip BPF and OOL DSOs in dsos__find_kernel_dso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Factor out dso__is_bpf_prog() from __map__is_bpf_prog() and update
dsos__find_kernel_dso_cb() to skip dso__is_bpf_prog(dso),
DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
In machine__process_ksymbol_register(), also check
event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF before setting
DSO_BINARY_TYPE__BPF_IMAGE for is_bpf_image() symbols prior to inserting
the DSO.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h     | 16 ++++++++++++++++
 tools/perf/util/dsos.c    |  3 +++
 tools/perf/util/machine.c |  9 ++++-----
 tools/perf/util/map.c     | 14 ++------------
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f6c60bafcde1..009bd3001ace 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -1022,6 +1022,22 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
 	return is_guest_kallsyms_pid_name(name);
 }
 
+static inline bool dso__is_bpf_prog(const struct dso *dso)
+{
+	const char *name;
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return true;
+
+	/*
+	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
+	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
+	 * guess the type based on name.
+	 */
+	name = dso__short_name(dso);
+	return name && !strncmp(name, "bpf_prog_", sizeof("bpf_prog_") - 1);
+}
+
 static inline enum dso_binary_type dso__dbginfo_type(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->dbginfo_type;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1574c8885d78..a7f6a98acbaf 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -475,6 +475,9 @@ static int dsos__find_kernel_dso_cb(struct dso *dso, void *data)
 	 * is_kernel_module() treats it as a kernel cpumode.
 	 */
 	if (!dso__kernel(dso) ||
+	    dso__is_bpf_prog(dso) ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__OOL ||
 	    is_kernel_module(dso__long_name(dso), PERF_RECORD_MISC_CPUMODE_UNKNOWN))
 		return 0;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5eb5efa4eb90..afb95b64bec4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -769,6 +769,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			dso__set_binary_type(dso, DSO_BINARY_TYPE__OOL);
 			dso__data(dso)->file_size = event->ksymbol.len;
 			dso__set_loaded(dso);
+		} else if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_BPF &&
+			   is_bpf_image(event->ksymbol.name)) {
+			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
+			dso__set_long_name(dso, "", false);
 		}
 
 		map__set_start(map, event->ksymbol.addr);
@@ -780,11 +784,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		}
 
 		dso__set_loaded(dso);
-
-		if (is_bpf_image(event->ksymbol.name)) {
-			dso__set_binary_type(dso, DSO_BINARY_TYPE__BPF_IMAGE);
-			dso__set_long_name(dso, "", false);
-		}
 	} else {
 		dso = dso__get(map__dso(map));
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d5319ffa88a7..5155c95df85d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -248,19 +248,9 @@ bool __map__is_extra_kernel_map(const struct map *map)
 
 bool __map__is_bpf_prog(const struct map *map)
 {
-	const char *name;
-	struct dso *dso = map__dso(map);
-
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return true;
+	const struct dso *dso = map__dso(map);
 
-	/*
-	 * If PERF_RECORD_BPF_EVENT is not included, the dso will not have
-	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
-	 * guess the type based on name.
-	 */
-	name = dso__short_name(dso);
-	return name && (strstr(name, "bpf_prog_") == name);
+	return dso && dso__is_bpf_prog(dso);
 }
 
 bool __map__is_bpf_image(const struct map *map)
-- 
2.56.1.703.gf848ed807c-goog

