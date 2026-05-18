Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3012C2349
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126161; cv=none; b=c/gua7CDwo0LoONay0wy74nM0NNH1mgH9kKsLEcgkZ7rLKnOwo7k29/5SuL5Oftl4JMPIbCG3K69wr1/Jj+Pi7HxrBHGhhNEgOiZKWD0hMDSFGjB1vD3Zyzlq3+8Ka4RGVZu2U81fkjk0iOLL4PnpJXCLMByjSkyKvCbtXI25ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126161; c=relaxed/simple;
	bh=1pK2kNDo7FlTcm5GFv1e1uqvoBNFJ5/Xo7pM5YWk7tQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hv/dw3w6eG/+9gmPlu8+hSz5PfLb5BV7M2qFIMBuubjO8b97x6TFCo6Wn7RxZ6vs9TOvsJOKi+KcHh1UeEBHx3HDojipXn+3nDptx8flI99cgKxBARpUIGHYNAzCWD9TlCcMvhgUaJMrkO+Q6iTlJPlUcjtY2zHkmXitt6Bpq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGPYhAbq; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGPYhAbq"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-303b38ec2f6so3479792eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779126159; x=1779730959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3s6gn9A6S+BcLCMtqy5uGUxbiN41eBzl4dIsLF5YNTg=;
        b=JGPYhAbqAJmHxcY7wZRDHKVR/KJQX7aXRIdu+3ouhjJ7F9vGqi89+4oNdlQ4oOOT+P
         ZuweU+6RTJcKhr4aTCevzeuH4q+f2Bc0xpO+3iRTul4HPn7NtEzQJe6Akl5WPtKvEmpz
         Xr8XCQBdwixKK5MLSxOmIlrs8Vu0O3JkMtHLpjaMZoZhTj0cQqsTMzRwOE+MYy22sjJm
         uwv9TV33neCQdvmC8oHkW2ehZ7OnZmX9pOn2j1NBd0IYR5T+de55L8+bvWnMA7PzwJSJ
         DG0eK4QpwKYN/oRQ5Nfj80MCJsgh//lZ5XVMsBpdAvE6n1c5GwBz+8dENvMDakaTzv19
         jLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779126159; x=1779730959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s6gn9A6S+BcLCMtqy5uGUxbiN41eBzl4dIsLF5YNTg=;
        b=QEQaknzUp04BrJq9ZYgJvE1DgIUduULodNRN0XYH/7rh8Vjm6UBqKVzcQLbvflTNqV
         b3ZkDh0uytCB119pZnm2psl/fQU1Lg8PX3v9nSXjTexYCa8oF8ChZQQF5xAaNLBVnknR
         ZCzRoxu9iR8b4BPgpMhV4jarReE2CNq8PRvO7pl1JFI6XpWTnQNOTaEGTY7cuX6hNIZg
         VJn9TmBbVfsjuhpfapj+kuwx37dqlEVPFBN9r4K8KffbWqWg2Qf0Ao5X6c/UDY0hnn69
         MK1Ebq/3CgxJ6WzrM0OIKw5eMvcUZjm4ryIjVsEYAtDf+HBQd0yExLPk+Byzk3++DvLk
         GoZg==
X-Forwarded-Encrypted: i=1; AFNElJ+QYhUexHypQYi9/6iCXyld7zUbqk5I6N6u3M89+S7cY/devBfSfr3T1g1E6anNRM5kHzf1ebrLAuKZZdBtHhHZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCbfRzmomkvOlIPNFABABB2Ur5ytAsi/Ahh/UwVzS7ytl72GE
	+MDQS1b9IN51mZlI632ZY6wLmtOBS4TpvFPiRabiKaEcc6uLGb/x3x/kBf9LCvbfbKMv/rPmq+J
	F150TPA==
X-Received: from dybor14.prod.google.com ([2002:a05:7301:1f0e:b0:2f2:fc0:8869])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e28b:b0:2c4:dd55:ffc1
 with SMTP id 5a478bee46e88-3039816dcfcmr6921674eec.2.1779126159239; Mon, 18
 May 2026 10:42:39 -0700 (PDT)
Date: Mon, 18 May 2026 10:41:23 -0700
In-Reply-To: <20260518174159.1177549-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518174159.1177549-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260518174159.1177549-2-ctshao@google.com>
Subject: [PATCH v6 2/2] perf evsel: Find process with busy PMUs for EBUSY
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
 tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..f6282099320e 100644
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
@@ -3969,29 +3970,61 @@ static int dump_perf_event_processes(char *msg, size_t size)
 				continue;
 			/* Take care as readlink doesn't null terminate the string. */
 			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
-				int cmdline_fd;
-				ssize_t cmdline_size;
-
-				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
-				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
-				if (cmdline_fd == -1)
-					continue;
-				cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
-				close(cmdline_fd);
-				if (cmdline_size < 0)
+				int fdinfo_fd;
+				ssize_t fdinfo_size;
+				char *line;
+				u32 perf_event_type = UINT32_MAX;
+
+				/* Let's check the PMU type reserved by this process */
+				scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
+					  proc_entry->d_name, fd_entry->d_name);
+				fdinfo_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+				fdinfo_size = read(fdinfo_fd, buf, sizeof(buf) - 1);
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
@@ -4109,7 +4142,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
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

