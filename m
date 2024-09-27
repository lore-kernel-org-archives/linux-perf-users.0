Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E43218B;
	Fri, 27 Sep 2024 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468873; cv=none; b=kqJ8vuqwh+vav2NxI3xspBpYUw4IlVhUD7wOinm9c98+surpGsZyNdtzrXUpN6d1dW5dWvbJNaAOCcS6S5KMQvcMhGgXIkscagE+BeGQ/bD37ziFA5NbCBj5mj1LvES/LeWFZVjdkWMEGR0DLOvQFGM5Z4ZeE6j+YUrxkwpkokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468873; c=relaxed/simple;
	bh=nIUiDxgqflD2SH7nvjL7lUKBxvllcX5JqrcgK+ywIMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbZmaWbluZHHT/To43Sve0BvlTuJUT+L5mER3HhP6IjS4z9u8MFr6HTuA6EJjGammYAPl0PFsDYESxGNup5nf/atPUyhv8ML6zrgQJezf5gTzJw4Y+4jpTSROH+6MrUDsbtkGQ7k5CNUBINyVal5rhuBwUPne4S06izoeVJkbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1DoLdIQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1DoLdIQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718d91eef2eso1876682b3a.1;
        Fri, 27 Sep 2024 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727468871; x=1728073671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKsZoLSE8Uo83LAMVBiqpWixpej/X0Qxsd++nXnThvw=;
        b=T1DoLdIQl7wNwqizJAdb6GFuxSDzZ+JB+OSOSlpOl9l1PrcI5pVzO9aCNUx8gtzPV+
         nccHnDhzZ6c/88zMpPOHYA2WjHA9oZuYY+U1YrkvZnhmYu3E103tcSosangsgCfY4w3d
         fg/i0l0eWaE7687e2adb/kPeZZxxjCbdYl6GqsYVJroMtoCsIdyfChE5C9CwRzKdsRbb
         1cLRaI2NSfDkZexIOTgsxNP1ZlAT0OdgTP9pa/2Dack6iXlYmcDnNGaer52G/+X9BT6e
         DUiu/LwVz6/YLFf/YC25Ix9ozUWzT9FTJ6ePV+6Gi+ZYuj3Xy1nGShG1nBdMukhQnuW2
         DIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727468871; x=1728073671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKsZoLSE8Uo83LAMVBiqpWixpej/X0Qxsd++nXnThvw=;
        b=XMSVGarIiDFBTItBeW6RFALpHJM+fbK7NCJ9/f3V/VWFPMhatroy0Y29zwazIpaeUr
         qyt8iudfquOIprssZQntMAgRXT3WIKR4nZHxVIH31Qc85Q53u60YxOHsz1izpuVSNzss
         Nyb9whSokvHNMb9jZEziILGkaw5WlxGjb29HQZAMiK55BzCw9GfBDWDGRslzv1lWmQqK
         Fs3YBwfoCt+5eWBI7JybTwmOgtvMKMXu3yAjV4nYH8ujVbatQA/PeyivBFf311IOKuA7
         JtxeXKrg7ddDTmwh2uCo+2FPjvL9Pi+ZaXuEQXjQOleoVQTu6P6k7snQ50hZt/cglA85
         mvzg==
X-Forwarded-Encrypted: i=1; AJvYcCVKS2kO7R/MFH55cY2eWhTb5TOkCc3NzGUfTYIWaJPj0MSfN5TOQ4gL5yzcdqalWdjw2DRwIsHZ+Fb7A7E=@vger.kernel.org, AJvYcCVpGb0wNZ+ZdI5Wggb33IdqmZoGMridapsrYRX+BOosqP7oBdt/6QCnPofNpQYMhWNaptn3BOXI4p1is4ZGZJTSEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpCjF/r8XNYPZ2oon0R1qdRUK8mn3rp21B3Kt3sv48bE1CwNM
	k0G6Faj8PB5t0ZXgeNZgXXoOfP+3YevTWMF5JFXrXVCav30vL+uy
X-Google-Smtp-Source: AGHT+IGR8HfrA9zcE8hJGZd47QRkMo+fSaSORak8JzPEwKCORr3rbmc2RLaK7T+xvsudDocLOUlrjg==
X-Received: by 2002:a05:6a00:17a6:b0:719:110e:fc8f with SMTP id d2e1a72fcca58-71b1924fd3amr14000413b3a.1.1727468871384;
        Fri, 27 Sep 2024 13:27:51 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524c32sm1998410b3a.157.2024.09.27.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:27:51 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v6 1/8] perf evsel: Set off-cpu BPF output to system-wide
Date: Fri, 27 Sep 2024 13:27:29 -0700
Message-ID: <20240927202736.767941-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927202736.767941-1-howardchu95@gmail.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pid = -1 for off-cpu's bpf-output event.

This makes 'perf record -p <PID> --off-cpu', and 'perf record --off-cpu
<workload>' work. Otherwise bpf-output cannot be collected.

The reason (conjecture): say if we open perf_event on pid = 11451, then
in BPF, we call bpf_perf_event_output() when a direct sample is ready to
be dumped. But currently the perf_event of pid 11451 is not __fully__
sched_in yet, so in kernel/trace/bpf_trace.c's
__bpf_perf_event_output(), there will be event->oncpu != cpu, thus
return -EOPNOTSUPP, direct off-cpu sample output failed.

if (unlikely(event->oncpu != cpu))
		return -EOPNOTSUPP;

So I'm making it pid = -1, everybody can do bpf_perf_event_output()

P.S. In perf trace this is not necessary, because it uses syscall
tracepoints, instead of sched_switch.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index edfb376f0611..500ca62669cb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2368,6 +2368,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			test_attr__ready();
 
+			if (evsel__is_offcpu_event(evsel))
+				pid = -1;
+
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
-- 
2.43.0

