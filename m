Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39643932E6
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627376; cv=none; b=RHRorWTRKA/NyKxtAe+f5Nikx9A8ODE7q50Jcz01QGCGeo5Zp6owbZQZgaK0Ua1TvlEmGM1x8r+Nn2t0WJz4gAPwQeITc3SpZ39Tx9qofCNYHnDtdYIRzS27Di0Uw0xCB3Gzkwbc3rzbY8LuHjUw9Du8jGk1y+ZQpMDNvrg4yUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627376; c=relaxed/simple;
	bh=lx7wyF3Qu/HpKTFDnfOd4iCQJKE+aEvsCq9kKuv30HU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kuk2O5vjuvdsbp1LF+0hssSpyoWKxek/q3luRRBXweH3g9t8Cb11WZFB++EmN5G79cr7s/m3HQvfcv9CMItV1Rat+ETot/zR1E7tZr22yW9GfRRA8TrJ0P0q//Jmz7QBj5x5trAOCUjIhzWFq1O+Ng9UkqdLgqVfZMra6B2mtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TiqMasi4; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TiqMasi4"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39d8646b10eso615043a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627374; x=1790232174; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDa4jCWG1HgPZsp/vqH9L8ol0+fyo/nirzG/z+7DOWE=;
        b=TiqMasi4FEpnpLyPFNAufz8q/Lc5FNSsQU/6rN4q3vtL7jika3+1/MLKGlNCo/135L
         tiMF7XgDJfv45e99eDW1oG8lIrsQAA0LmYpKgm7500xP5lSGQh4bk5S5ddnr/ZbKXZ99
         sRN13UoUOvCJ342NgXc2gOCQIo5sDtzZkMW6ci2nOPJSAg5V6//cnJy5/SuTVMTqbFP6
         ezg4wzKoaRqN29MihJGWslSDyOtXfjqdrxuWpqmQrJ9uBVJQWvf+z2dLfuxeJ9a9R0Vl
         ki3nSG4aIk0Spu2UTSMZyp1OTfmGLOPCppZnkSeJPlVx3eo8YkUepgUdQsXyOdU1N5l+
         eqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627374; x=1790232174;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDa4jCWG1HgPZsp/vqH9L8ol0+fyo/nirzG/z+7DOWE=;
        b=J+L1p+vStQT/bX0pIh72MqGczdNo59ZYwki3n5uvXrIKStbP3iNqKetODmnVNuMadf
         ogfJbAbrxyzwKOOzZ4uoZpgnowlnXnXngRP2jA8gW9hvHfkd9m+X5B4ry/R5C0AmAaOG
         2qOrKQCPdtcC4SlaZvH6ccdxIYd04Mkr8uqTByptvUmP1GRb/GMG7DSgh4jb/EyvuAKu
         kYZjOO9UDyyAW7Tx6gPwl0SEfMvZdzzh9sCMl76kYInFFGe3GQxbapVlUCNk2fzh2WQH
         yMtuxSEyjFolw2jlDKJCZGHc5FlXY5+Gb4BncMe7rZTDQ7WX13BlQpOl5MXPwXHwAsgm
         hbAg==
X-Forwarded-Encrypted: i=1; AKwUvBzoz7CTxG5rQkEKzKJ5loRIGASyVEZPzxeA9RQyTq+HuvIuxuiWM1NmubRGmH2GyaJuH4I1Kb8iUgZAew0HcHLB@vger.kernel.org
X-Gm-Message-State: AFuF++lHK6F8Zh0swrpLjQNacO632pjc+cK9W/zcepZjc0DzVG8L0ys2
	fB6CDg4YisUIL+ByowIx68Sn4MfD5APGo0xHNNRIkwPv46eAu/LBQxZmCXmTKyd4kjpsTrDP4hc
	QD8wbazlL+w==
X-Received: from dlbrl7.prod.google.com ([2002:a05:7022:f507:b0:143:94b1:ba45])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2803:b0:39d:ef3e:9035
 with SMTP id 98e67ed59e1d1-39e1e324463mr18457457a91.10.1789627373850; Wed, 16
 Sep 2026 23:42:53 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:25 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <fc961a7169e4c00c91cf543e5d505cc5deded5f6.1789626978.git.irogers@google.com>
Subject: [PATCH v1 03/13] perf trace: Do not set unaugmented BPF program on
 sys_exit map
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In trace__init_syscalls_bpf_prog_array_maps(), the BPF program array map
for sys_exit (syscalls_sys_exit) was populated with the result of
trace__bpf_prog_sys_exit_fd().

When a syscall had no specific exit augmenter,
trace__find_syscall_bpf_prog() fell back to unaugmented_prog
(syscall_unaugmented). However, syscall_unaugmented is a sys_enter
program that outputs enter arguments to __augmented_syscalls__.

As a consequence, when an unaugmented syscall exited, sys_exit
tail-called syscall_unaugmented, which interpreted the exit arguments as
enter arguments and emitted a duplicate, corrupt sys_enter event into
__augmented_syscalls__ right as the syscall completed.

Fix this by:
1. Returning NULL from trace__find_syscall_bpf_prog() when looking up exit
   augmenters and none is found.
2. Returning -1 from trace__bpf_prog_sys_exit_fd() when no exit program
   is present.
3. Only updating map_exit_fd when prog_fd >= 0.
4. Clearing err = 0 when trace__bpf_sys_enter_beauty_map() returns
   non-zero (indicating the syscall has no augmentable pointer arguments)
   before continuing the loop, so a trailing run of such syscalls (e.g.
   'perf trace -e close') does not leave err non-zero on return and abort
   the session.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index af9696aadaec..a68d34256996 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4117,7 +4117,12 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace __ma
 	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
 		 prog_name, type, sc->name);
 out_unaugmented:
-	return unaugmented_prog;
+	/*
+	 * Do not set unaugmented_prog for exit: syscall_unaugmented is a
+	 * sys_enter program that outputs enter arguments. Exit without a
+	 * specialized return augmenter returns 1 directly from sys_exit.
+	 */
+	return !strcmp(type, "exit") ? NULL : unaugmented_prog;
 }
 
 static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, int id)
@@ -4140,7 +4145,7 @@ static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int
 static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
-	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(unaugmented_prog);
+	return sc && sc->bpf_prog.sys_exit ? bpf_program__fd(sc->bpf_prog.sys_exit) : -1;
 }
 
 static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
@@ -4395,16 +4400,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
 		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
 		if (err)
 			break;
+		/* Only update the exit prog array map if an exit augmenter exists */
 		prog_fd = trace__bpf_prog_sys_exit_fd(trace, e_machine, key);
-		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
-		if (err)
-			break;
+		if (prog_fd >= 0) {
+			err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
+			if (err)
+				break;
+		}
 
 		/* use beauty_map to tell BPF how many bytes to collect, set beauty_map's value here */
 		memset(beauty_array, 0, sizeof(beauty_array));
 		err = trace__bpf_sys_enter_beauty_map(trace, e_machine, key, (unsigned int *)beauty_array);
-		if (err)
+		if (err) {
+			/*
+			 * Not a failure: the syscall just has no augmentable
+			 * arguments. Clear err, or a trailing run of such
+			 * syscalls, e.g. all of them for 'perf trace -e close',
+			 * would leave it set on return and abort the session.
+			 */
+			err = 0;
 			continue;
+		}
 		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
 		if (err)
 			break;
-- 
2.55.0.1082.g2b9226bbc0-goog

