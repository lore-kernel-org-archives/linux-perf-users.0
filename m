Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89516233134
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144548; cv=none; b=X/HFDw6IpgeWHwYWyUMyIRzrKNSlZEkkx1vZkG9P1i9P92KSEkgBE4SzQIsES9m9G1N4tseY2yCsKP8TmdQNTx8yUIDaBd1SH9jcObYDGSJDnV6iz/XrYLtgXwlT4H03Eq2oxI3SOghXqjVRDguT58Kj63KmJWd+IDwT0wJiyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144548; c=relaxed/simple;
	bh=ojqdFjfpOzgKZ/9nJ4wDUjptQFaL04I9xwgufbxsvO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FtUmkG3txFXEg2E4aCIz8m3Tu8Wos2o9LiDISaccOtnDY85M2UchrLw/koWcDdSXIjmCoAqeV3IIFhE9ynAmSnZlsjt4gibCH7ZEMwWCh+X8dDE3gl3NUGXLNmkt93HgRHmL7BxJ+FydfnHFHj8en4/GUNpPun5LVHvhgHEw5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4ICnn3a; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4ICnn3a"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-303b38ec2f6so3948696eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779144546; x=1779749346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mXObPWxU093Hrs6Zz/xsS5eb+P0/Hk3FQjwiJUB5pM=;
        b=b4ICnn3axxeN6U/GYQQKQGYj1llovtabr7Q6IK2ucgUa2oJNahzn+baYaJlPt85EFn
         8egQbISA/WLIN6laMQbJEmrA8DqvkVJh6fIY5LR306WXENts3Cbs8Glea5htdG/I0hFj
         L/IBUt5hxG4bjfQ78Jy5OmKjfcRF2pgVWpaTVaTnyLuF+iEDFT2yCjV5kQq+mrfwgUIS
         rwZRz8GdSODvFJrtJomv0mgOssgzF9SPrGhjKsWW6VYXrMq69g/vLEcPAs+4CHcuDj3c
         Y7UVLoUEFOH1WbfFuqkmMSSaM1XT4HUpfiOyNqjrA+VUUvG/zOXim0ZvGCl9nsYrlvia
         7v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779144546; x=1779749346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mXObPWxU093Hrs6Zz/xsS5eb+P0/Hk3FQjwiJUB5pM=;
        b=TI++GSMueWLDjGB9zlMqcvVtOW8KWZQpWLklQC4eoukdYbEICIgjz0d4G9owD7CMz8
         YP9XuFpbRK4Pmqd+88b9MdOpnbT2EUeZ1awX7ZQttVmzr6TvNd+D2GQGHp54RgR2m9g6
         hdB4wZuyS3814dYsQ7Za99HY8QO3vF2cwHfFGVaONxFAjM7Qf5l6obdTNFevNkfIwyjN
         HWE5QtuLUBkte3aKXJoMzFw2nVW1qLZ0rz76Dda8/QqLsxVV/NLhQHGWtIeXfYE04S5D
         rdMbPasJ2wtsIHRHTtcQxU63Ui8gfWNB7FT91zYkAXWR54ID07Q6Dk7PmTzxAoXLbljz
         AJsw==
X-Forwarded-Encrypted: i=1; AFNElJ+IU5lK8fe4jpXwb5R0KU/z6fi97/OS8n7wSCO3Q8epXDDJd9A6lhCSzNJTI4WCPRq0H2iyzbbKHSLnnxj/3uSK@vger.kernel.org
X-Gm-Message-State: AOJu0YwWk3En9wAY3hKKn7HBpTRs5MqGH3QrAC5VkRIvyjvx26jM9Tx0
	mUAfwaYrkWE/31liBawLlHOUa3a5PLBxjUF32xrmhV44Fbx1TTyXSj0sDSSXsrMzY/psAy59gRG
	5aqXrmg==
X-Received: from dycoh22.prod.google.com ([2002:a05:7301:da16:b0:2ed:b77f:b02a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e7a2:b0:2ea:b85c:153d
 with SMTP id 5a478bee46e88-303986948camr7032909eec.27.1779144545297; Mon, 18
 May 2026 15:49:05 -0700 (PDT)
Date: Mon, 18 May 2026 15:47:48 -0700
In-Reply-To: <20260518224819.1247382-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518224819.1247382-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260518224819.1247382-2-ctshao@google.com>
Subject: [PATCH v7 2/2] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It parses fdinfo with PMU type, comparing with the event which failed to
open, and report the processes causing EBUSY error.

Testing cycles and intel_pt//

  $ ./perf stat -e cycles &
  [1] 55569
  $ ./perf stat -e intel_pt// &
  [2] 55683
  $ ./perf stat -e intel_pt//
  Error:
  The PMU intel_pt counters are busy and in use by another process.
  Possible processes:
  55683 ./perf stat -e intel_pt//

Only perf with intel_pt was reported.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/evsel.c | 80 ++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..1f120c27e5d7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3928,7 +3928,8 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
-static int dump_perf_event_processes(char *msg, size_t size)
+static int dump_perf_event_processes(const struct perf_event_attr *failed_attr,
+				     char *msg, size_t size)
 {
 	DIR *proc_dir;
 	struct dirent *proc_entry;
@@ -3969,29 +3970,64 @@ static int dump_perf_event_processes(char *msg, size_t size)
 				continue;
 			/* Take care as readlink doesn't null terminate the string. */
 			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
-				int cmdline_fd;
-				ssize_t cmdline_size;
-
-				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
-				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
-				if (cmdline_fd == -1)
+				int fdinfo_fd;
+				ssize_t fdinfo_size;
+				char *line;
+				u32 perf_event_type = UINT32_MAX;
+
+				/* Let's check the PMU type reserved by this process */
+				scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
+					  proc_entry->d_name, fd_entry->d_name);
+				fdinfo_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+				if (fdinfo_fd == -1)
 					continue;
-				cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
-				close(cmdline_fd);
-				if (cmdline_size < 0)
+				fdinfo_size = read(fdinfo_fd, buf, sizeof(buf) - 1);
+				close(fdinfo_fd);
+				if (fdinfo_size < 0)
 					continue;
-				buf[cmdline_size] = '\0';
-				for (ssize_t i = 0; i < cmdline_size; i++) {
-					if (buf[i] == '\0')
-						buf[i] = ' ';
+				buf[fdinfo_size] = '\0';
+
+				line = strtok(buf, "\n");
+				while (line != NULL) {
+					if (sscanf(line,
+						   "perf_event_attr.type:\t%u",
+						   &perf_event_type) == 1)
+						break;
+					line = strtok(NULL, "\n");
 				}
 
-				if (printed == 0)
-					printed += scnprintf(msg, size, "Possible processes:\n");
-
-				printed += scnprintf(msg + printed, size - printed,
-						"%s %s\n", proc_entry->d_name, buf);
-				break;
+				/* Report the process which reserves the conflicted PMU. */
+				/* If fdinfo does not contain PMU type, report it too. */
+				if (perf_event_type == failed_attr->type ||
+				    perf_event_type == UINT32_MAX) {
+					int cmdline_fd;
+					ssize_t cmdline_size;
+
+					scnprintf(buf, sizeof(buf),
+						  "%s/cmdline",
+						  proc_entry->d_name);
+					cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+					if (cmdline_fd == -1)
+						continue;
+					cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
+					close(cmdline_fd);
+					if (cmdline_size < 0)
+						continue;
+					buf[cmdline_size] = '\0';
+					for (ssize_t i = 0; i < cmdline_size; i++) {
+						if (buf[i] == '\0')
+							buf[i] = ' ';
+					}
+
+					if (printed == 0)
+						printed += scnprintf(
+							msg, size,
+							"Possible processes:\n");
+
+					printed += scnprintf(msg + printed, size - printed,
+							"%s %s\n", proc_entry->d_name, buf);
+					break;
+				}
 			}
 		}
 		closedir(fd_dir);
@@ -4109,7 +4145,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			msg, size,
 			"The PMU %s counters are busy and in use by another process.\n",
 			evsel->pmu ? evsel->pmu->name : "");
-		return printed + dump_perf_event_processes(msg + printed, size - printed);
+		return printed + dump_perf_event_processes(&evsel->core.attr,
+							   msg + printed,
+							   size - printed);
 		break;
 	case EINVAL:
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
-- 
2.54.0.746.g67dd491aae-goog

