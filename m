Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD044FDE7E
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740452; cv=none; b=DPfO7Iq0KKgIaMkNxuAHVQpRgPovXPpNXMqXcTKzJ3UxdqbT5T1FUk9N0Ozpk8Mn+e5MS9Pj5Fpv7EeDsFQmux/HMjPBwfH6YCADU0QLu+QKs2NQS/d+Q6MWjsYXVTHF5x3SHZrtSj4IGkgwPDQAeTm4f5vW9/NBKTjtVm1El4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740452; c=relaxed/simple;
	bh=3qyDKSUHoAXJBVvMweoPwov6DmzqcY9odxEwkd1kTIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nnTJyhfQfqi9RXtWoAb5gfBDM/0DpqMXdNRsHecIWHywH32Otm0zHXIWxIlfzZi7P3vHb5sZriccaZehvMvMA/jliAuG2tut6RMcbXQlx43N9AJUBEEHnNXyptKwrWlKkfYqlcFl4sZczZ9hqigDWwIR78lmYNq3Vnx8nUqr6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7WU5ROP; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7WU5ROP"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39512608fb1so1899742a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740450; x=1790345250; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdvT9XF5drvxnf/MfPum/Gi0QBj0faFgeFxRBLMV2Co=;
        b=D7WU5ROPFGPm4qLpWKbljw9eTb2k+J39ay7cqI9AqBgMNDk9F2nHf4AL6XK2zaGVS+
         Gr2J9Y5GYZk5lW6XhjAxtAFJrle8mNpAVMwuYVxds3p2yWHfuPuhUq0xq0PLtr+Y3dIo
         YbzQv24f2hZqTeWqr4NYszZlkg5+C9C/Vex2sGkOByzngoMqHfFc8JixquLpyznRdM2b
         8iInw70kpfY5NSmEHc9lf0E768IF/LL+ZPBVMeDV34jKSwMaWXL2AWlgjqvioVGYeCha
         UC9gLgB8wpO9CReZaN5k1TMKFe2qIFrMnPWMSeIhZEH1hT9yEj3HWIFcpMm90vARqmWX
         vbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740450; x=1790345250;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdvT9XF5drvxnf/MfPum/Gi0QBj0faFgeFxRBLMV2Co=;
        b=MKbM8sZrk0bu9QPP82YMssnvnvMPmzcFhb0cYFKVXiO8LMZJaXqhWS/E2RfVwEPdbg
         YEmgD8SFT0b0WUfHzx+dWczx0QYOFg9zMs4KoUB/WEm4SLdfCWMprnI2AQzCcxU6sCFc
         cuSqgLZNGjesit8g7Pq+frDOufrzSzQvMVhznUjxIWl8WjdWhdrplNPI68oUP/wMvmAL
         OrLX06EF2u/kJyJ8/aWlAuI+dvstHqEgqnsJAA3wTI2WD9F1OEUmk++m9W+Xo5HlmLXZ
         5jcQqKS4sEX5MMwIKUj1sHhQx7iPxwuwsky7KrWsSEWmw8omWe/nhh4QDlRXxEodGKVn
         JmGA==
X-Forwarded-Encrypted: i=1; AKwUvByiogzcDwKHR6WieTNEIczF5jiHIVCmuHQ3ITKYsKLLtAtgRNexnAdW48HAOm3T/vB2KeQUDTEuBTx4NDF+vSMT@vger.kernel.org
X-Gm-Message-State: AFuF++kS/BcsLX0c4A4nSkIWcn+gol2pIDzFsr1DtWUU35cfqJmM2Yj1
	XFNs2UKvLwjNd6oKD2amqQNrzXJDNz+qzRqKEyOhDYfFhQT1brHe9pEqdrQXxffzL5ve2W0sVt2
	9bix6grUZWQ==
X-Received: from dyu6.prod.google.com ([2002:a05:693c:8106:b0:32b:7182:c3b7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50cb:b0:39b:370e:c807
 with SMTP id 98e67ed59e1d1-39e54ea68e7mr6597683a91.17.1789740449376; Fri, 18
 Sep 2026 07:07:29 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:53 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-11-irogers@google.com>
Subject: [PATCH v3 10/16] perf test common: Only disable probes in clear_all_probes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

clear_all_probes() began by writing 0 to
/sys/kernel/debug/tracing/events/enable, which disables every tracepoint
on the system rather than just the probes the probe tests created. When
tests run in parallel that also silences the events of any concurrent
perf record, perf trace or ftrace session, so unrelated tests lose the
events they are waiting for and fail.

The write cannot simply be dropped. Clearing kprobe_events or
uprobe_events is all or nothing: dyn_events_release_all() walks every
probe of that type first and returns -EBUSY without removing any of them
if it finds one that is still enabled, where enabled means TP_FLAG_TRACE
from tracefs or TP_FLAG_PROFILE from a perf session. A probe left enabled
through tracefs would therefore block the whole clear and leave stale
probes behind to collide with the next run.

Disable the probes and only the probes. The set to disable is taken from
the kprobe_events and uprobe_events listings rather than from a guess at
which groups perf uses, so it matches what dyn_events_release_all() is
going to inspect: a probe an unrelated session left enabled in, say, the
kprobes group would otherwise still abort the clear.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/common/init.sh | 33 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index cbfc78bec974..7c2ca74298ca 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -130,9 +130,40 @@ check_uprobes_available()
 	test -e /sys/kernel/debug/tracing/uprobe_events
 }
 
+# Disable every kprobe and uprobe event. The listings name each probe as
+# "TYPE:GROUP/EVENT ARGS...", for instance "p:probe/vfs_read vfs_read", and
+# events/GROUP/EVENT/enable is the switch for it.
+disable_all_probes()
+{
+	PROBE_SPECS=`cat /sys/kernel/debug/tracing/kprobe_events \
+		/sys/kernel/debug/tracing/uprobe_events 2> /dev/null |
+		cut -d ' ' -f 1`
+	for PROBE_SPEC in $PROBE_SPECS
+	do
+		case "$PROBE_SPEC" in
+			*:*/*) ;;
+			*) continue ;;
+		esac
+		PROBE_ENABLE="/sys/kernel/debug/tracing/events/${PROBE_SPEC#*:}/enable"
+		test -e "$PROBE_ENABLE" && echo 0 > "$PROBE_ENABLE"
+	done
+}
+
 clear_all_probes()
 {
-	echo 0 > /sys/kernel/debug/tracing/events/enable
+	# Disable the probes before removing them. Writing to kprobe_events or
+	# uprobe_events is all or nothing: dyn_events_release_all() walks every
+	# probe of that type first and returns -EBUSY without removing any of
+	# them if it finds one that is still enabled, which would leave stale
+	# probes behind to collide with the next run. That covers probes this
+	# test suite never created, so disable all of them and not just the
+	# ones in the groups perf uses.
+	#
+	# Only probes are disabled. Writing to events/enable would also silence
+	# the tracepoints of any perf record, perf trace or ftrace session
+	# sharing the machine, which breaks those tests when they run in
+	# parallel with this one.
+	disable_all_probes
 	check_kprobes_available && echo > /sys/kernel/debug/tracing/kprobe_events
 	check_uprobes_available && echo > /sys/kernel/debug/tracing/uprobe_events
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

