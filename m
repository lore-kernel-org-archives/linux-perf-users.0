Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D26290083
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306618; cv=none; b=Xkm0p2YglOYq/xXZQycaVMNjYitdx6TEXvlWAmkTFBRDXdb9dEm4Ybjxad+5lnb32IIdGAox0V42PFd3IJn18utQLQL1b3SwTQo4hfd4J4jSmf44fnv2Sn+A8b1y3kFUF/aH0oc8nO+J7Inx3NG3Y+1N2jiXjGeU+PTx01mprgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306618; c=relaxed/simple;
	bh=+zDgHqHjon+MVPdXx/Sh4aANXSBT0gmB7cK1T8w0t/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=N0NOBfu+3XAf/Y23awAbZpRGDFCJXjQscVJPRamBjQiSl0Deb2Dur54eG8e3fCP5Jv5cbNDFImUj+4n6lxuHf33Vztl+5G7rTspdCVoRh/sPgaWULNzixqqWwW1afBy4T5bo59kYgxPPjzh37tWQO1EdSkJ5kygbiwmlFwMdsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9i1qRWm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9i1qRWm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd36189bso1332070b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306616; x=1744911416; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FGIMvAhuHqvN23UYt85wu5DsyHObAAdkXWC2SirunI=;
        b=L9i1qRWmMXHnUr1cVFD1KCbQnKN4T/qpa5sxzNcfTjpjkM0qkuplkhs7qQ3lkPculU
         MuX4fiZeD1r01/v5Fc2QXOoaYThAEb3+oiFz9GQ7OAGTrKpXHiEssHMFipPFJSfPXR+/
         k7pdXwe5ZKFMrog5205THx1h6lSb4fJ7lcMdidAbnxDJaHkLQvewXXZsadnYVc2JP87H
         yMOdw3vO83oxaY3YbBTLQmY3uJBI5CODIzy5IH8a595DmAc3e392wKzPKvggEr3Ufj6/
         TBbb7M5l/PCrnoeyozzBE9axpb98j2lPcskANnbepbKA7np1cnUgJamvmhBusS1mAoar
         qggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306616; x=1744911416;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FGIMvAhuHqvN23UYt85wu5DsyHObAAdkXWC2SirunI=;
        b=nE4Wg7dxGD+WZoJCycq4uhZsAqZCtjt7uec1uvWXWkc/Sdw8ViYoKTLW3WyjQeJKhi
         01lRI3ToM7ZeQSWdTKKONkB2C2lVoU8/cj22zdAzKesx5ZgKpeRR9qI5g9kDPXPErR69
         1dtdzWudHkGdLl/I3qcao/INdYS38JpYjFNyhQvIiiSMOIHGEN9HPBH+KgZ1W78yGwW4
         Cyo3VuHdDozdwi+iy8Hp33alFQTEcbHcM0Ig8ziQPJzusD+DX7qJyVutm9+bPSyXDSqu
         YcOm/h4s19m3haP+VdMHEOFCFONr+9KrNBt4/b7kOaU4wk1jjSYPsa3k5QGQi3ZfCZtk
         UFLg==
X-Forwarded-Encrypted: i=1; AJvYcCUtE0aOEVKUHV6SZDwXWlRZJXiNB0Ule9znjwv7R+enZwz5oeNiPPGtHXPhKFz5x4bMVKiP+wR+ZMKBNaVLfa91@vger.kernel.org
X-Gm-Message-State: AOJu0YworG13hBTEkHqu+V3vRJz2h2zyWrqFtZjS1mt8ehO+ZDukW5kj
	uOKgBxqkP/o2q2O89jefd5f0FT3H+QbxlHyIWPFUXz/dxzkISyV5hefpAU+G1e5w055ToLsiX1l
	L/UcnqA==
X-Google-Smtp-Source: AGHT+IGzwMbFnV9yTIRMoJtzlrbWMl3tKhbflByoyy/hN5H11hd+8SwOivTfc2zOtikUe4LcoWJ/l5j30Gk8
X-Received: from pfbfq2.prod.google.com ([2002:a05:6a00:60c2:b0:739:45ba:a49a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a0b:b0:736:2a73:6756
 with SMTP id d2e1a72fcca58-73bbf01e01cmr4994177b3a.21.1744306615869; Thu, 10
 Apr 2025 10:36:55 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:25 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-7-irogers@google.com>
Subject: [PATCH v2 06/12] perf record: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match. Ensure adding the BPF filter forces
system-wide.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..202c917fd122 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -173,6 +173,7 @@ struct record {
 	bool			timestamp_boundary;
 	bool			off_cpu;
 	const char		*filter_action;
+	const char		*uid_str;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	unsigned long		output_max_size;	/* = 0: unlimited */
@@ -3460,8 +3461,7 @@ static struct option __record_options[] = {
 		     "or ranges of time to enable events e.g. '-D 10-20,30-40'",
 		     record__parse_event_enable_time),
 	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
-	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &record.uid_str, "user", "user to profile"),
 
 	OPT_CALLBACK_NOOPT('b', "branch-any", &record.opts.branch_stack,
 		     "branch any", "sample any taken branches",
@@ -4196,19 +4196,24 @@ int cmd_record(int argc, const char **argv)
 		ui__warning("%s\n", errbuf);
 	}
 
-	err = target__parse_uid(&rec->opts.target);
-	if (err) {
-		int saved_errno = errno;
+	if (rec->uid_str) {
+		uid_t uid = parse_uid(rec->uid_str);
 
-		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
-		ui__error("%s", errbuf);
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", rec->uid_str);
+			err = -EINVAL;
+			goto out;
+		}
+		err = parse_uid_filter(rec->evlist, uid);
+		if (err)
+			goto out;
 
-		err = -saved_errno;
-		goto out;
+		/* User ID filtering implies system wide. */
+		rec->opts.target.system_wide = true;
 	}
 
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	rec->opts.ignore_missing_thread = rec->opts.target.pid;
 
 	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
 
-- 
2.49.0.604.gff1f9ca942-goog

