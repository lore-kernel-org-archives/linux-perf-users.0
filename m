Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A62FD7B1
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505463; cv=none; b=ehwvW3FYjNYS5gW8WoULGOQ6N5CVqtKSfVsZZfPpjN2n8sQmNn26Poruny9q4ixNEoZCYEAVkSGcsJVl9/Er9r1Jnmf2WktH6Q5rJ5UlsaKVlWRCaQ0dIUiyXpiPibfeApopfBcRcTShsqGSCm7Ztyf121DHK1gwQ2mc/jvuVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505463; c=relaxed/simple;
	bh=WekSfGriGt93pmZYw2hzEJz2kN7BGEHbUEL85lBDZTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sgXRaW9Wub0dVruWNeu1vMb+YXAjhrBrl3k7IxndOpzgx79KKi9VhEkUvPot8+s6XWunL8miB3fiPd74gNZyAJHrBTG3jHXxjs18Shx7HAeO9I5nPpY2/fBC+J+vy4O+S6IVSWCH2xwRIDonhZH5dlpS1pb7Dv0tuzXLLA9ccxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTtNQ+S+; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTtNQ+S+"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so65811665ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789505461; x=1790110261; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KE/SmdG1WCHfb0EnIYsMzOMU1C1bEjt9QH54u0K4M7A=;
        b=sTtNQ+S+tV7g2JXS3lKmoCPeTc3O5JmoQDhlDxTFexcddDPdvEwHN7DH5BKGu1fSil
         I+qCZlcK5dwXwEBagSOYFwhfdxNb6pyLH2EoXbehfAHQsPYCSkOLcouCiPhXpkioIbki
         NCxhss88JwgrrvtFYOj3gC2SC2G274Kb1bJjVa6CdTueAQ5QAdm5GpXn+x/6IpWDaCLk
         ovbSxG+sS1u3cXfgJ8k0M3nrdEbGGPOZ0a4i5XC4exc47AX0QRrJgZmQzexmBGxsFuRC
         zwy5MS1gJsnlly0fxSdYsEw0zaVYfpkeVQkcPtuUnFUmsK+pTq4FsCEeTu/vtplIRP8h
         gXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789505461; x=1790110261;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KE/SmdG1WCHfb0EnIYsMzOMU1C1bEjt9QH54u0K4M7A=;
        b=Z4Gfbfbq3z3kepQZj/MCv3739QdZL1QDEZ8itGInEljb2BEbtrjGXmgxZ0+foJWiW9
         1vLBaTqFg/CZtpb/86ecZVho8oP4FOP+ZDuJA2XRJOzBxpgat+UAVV0zdbkwoposb9tE
         s+gp8iLJc4aIFmHR4UVqtd/oP84aX3vFaU6sbwQgOTHXurXCf1PdJY1niHruZRC336k5
         Y/LXyNWTJaqsWP20yKMUIXSWwxT4E/BNl9oO2qcmmoDy07rTCzc86A9r+FFGvXcjNi/f
         Z6wlST/DQGNRRnvcmyJ+qCuTjY3YsFCV8Bc1+UN9vKnDMiqmbW38mEBIwGelEvuI8BXc
         9OsA==
X-Forwarded-Encrypted: i=1; AKwUvBxPuvisgQ7IJAZjDmj1tmB6XK+CCOE+QmVJK1CSTU/KVmiGkP3Ih2av3QzOwtI1bFLzoSPU3wO/yOUseDmmKm1n@vger.kernel.org
X-Gm-Message-State: AFuF++njNX58jwwM3EccvzX4vnU+vkbzExtG+hEMVIuIc4fCV/oLQESN
	VzeqpDJaVuZZgDwnrzg5WeaRdV8qt1zrbJX+ec/YBGy0pzLD5357dV5WUzuGBPkmcB3fSxOVD4o
	ZW7/ToA==
X-Received: from plgy12.prod.google.com ([2002:a17:903:22cc:b0:2dd:1daa:a60c])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22d0:b0:2d8:d4d3:da4d
 with SMTP id d9443c01a7336-2dd6c70ac50mr187737775ad.17.1789505460705; Tue, 15
 Sep 2026 13:51:00 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:49:51 -0700
In-Reply-To: <CAP-5=fVzG-2oJ1gN=s-W+2r58k8P4M-E3r8aP9zJ2aK_w-K9vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fVzG-2oJ1gN=s-W+2r58k8P4M-E3r8aP9zJ2aK_w-K9vQ@mail.gmail.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915204951.2935261-2-ctshao@google.com>
Subject: [PATCH v9] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
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
Assisted-by: Gemini:gemini-3.1-pro-preview
---
v9:
  - Rebased onto perf-tools-next
---
 tools/perf/util/evsel.c | 69 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b44fd880d2d5..f3f5519d0d3d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4354,8 +4354,11 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }

-static int dump_perf_event_processes(char *msg, size_t size)
+static int dump_perf_event_processes(const struct evsel *evsel,
+				     char *msg, size_t size)
 {
+	const struct perf_event_attr *failed_attr = &evsel->core.attr;
+	u32 target_pmu_type = evsel->pmu ? evsel->pmu->type : UINT32_MAX;
 	DIR *proc_dir;
 	struct dirent *proc_entry;
 	int printed = 0;
@@ -4386,6 +4389,15 @@ static int dump_perf_event_processes(char *msg, size_t size)
 			continue;
 		}
 		while ((fd_entry = readdir(fd_dir)) != NULL) {
+			const char *target_lnk = "anon_inode:[perf_event]";
+			size_t target_lnk_len = sizeof("anon_inode:[perf_event]") - 1;
+			char fdinfo_buf[1024];
+			int fdinfo_fd;
+			ssize_t fdinfo_size;
+			char *line;
+			char *saveptr;
+			u32 perf_event_type = UINT32_MAX;
+			u32 pmu_type = UINT32_MAX;
 			ssize_t link_size;

 			if (fd_entry->d_type != DT_LNK)
@@ -4394,12 +4406,51 @@ static int dump_perf_event_processes(char *msg, size_t size)
 			if (link_size < 0)
 				continue;
 			/* Take care as readlink doesn't null terminate the string. */
-			if (!strncmp(buf, "anon_inode:[perf_event]", link_size)) {
+			if (link_size != (ssize_t)target_lnk_len ||
+			    strncmp(buf, target_lnk, target_lnk_len))
+				continue;
+
+			/* Let's check the PMU type reserved by this process */
+			scnprintf(buf, sizeof(buf), "%s/fdinfo/%s",
+				  proc_entry->d_name, fd_entry->d_name);
+			fdinfo_fd = openat(dirfd(proc_dir), buf, O_RDONLY | O_NONBLOCK);
+			if (fdinfo_fd == -1)
+				continue;
+			fdinfo_size = read(fdinfo_fd, fdinfo_buf, sizeof(fdinfo_buf) - 1);
+			close(fdinfo_fd);
+			if (fdinfo_size < 0)
+				continue;
+			fdinfo_buf[fdinfo_size] = '\0';
+
+			line = strtok_r(fdinfo_buf, "\n", &saveptr);
+			while (line) {
+				if (sscanf(line,
+					   "perf_event_attr.type:\t%u",
+					   &perf_event_type) == 1) {
+					/* continue parsing */
+				} else if (sscanf(line,
+						  "pmu_type:\t%u",
+						  &pmu_type) == 1) {
+					/* continue parsing */
+				}
+				line = strtok_r(NULL, "\n", &saveptr);
+			}
+
+			/* Report the process which reserves the conflicted PMU. */
+			/* If fdinfo does not contain PMU type, report it too. */
+			if (perf_event_type == failed_attr->type ||
+			    pmu_type == failed_attr->type ||
+			    (target_pmu_type != UINT32_MAX &&
+			     pmu_type == target_pmu_type) ||
+			    (perf_event_type == UINT32_MAX &&
+			     pmu_type == UINT32_MAX)) {
 				int cmdline_fd;
 				ssize_t cmdline_size;

-				scnprintf(buf, sizeof(buf), "%s/cmdline", proc_entry->d_name);
-				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY);
+				scnprintf(buf, sizeof(buf),
+					  "%s/cmdline",
+					  proc_entry->d_name);
+				cmdline_fd = openat(dirfd(proc_dir), buf, O_RDONLY | O_NONBLOCK);
 				if (cmdline_fd == -1)
 					continue;
 				cmdline_size = read(cmdline_fd, buf, sizeof(buf) - 1);
@@ -4410,10 +4461,12 @@ static int dump_perf_event_processes(char *msg, size_t size)
 				for (ssize_t i = 0; i < cmdline_size; i++) {
 					if (buf[i] == '\0')
 						buf[i] = ' ';
+					else if (!isprint((unsigned char)buf[i]))
+						buf[i] = '.';
 				}
-
 				if (printed == 0)
-					printed += scnprintf(msg, size, "Possible processes:\n");
+					printed += scnprintf(msg, size,
+							     "Possible processes:\n");

 				printed += scnprintf(msg + printed, size - printed,
 						"%s %s\n", proc_entry->d_name, buf);
@@ -4535,7 +4588,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			msg, size,
 			"The PMU %s counters are busy and in use by another process.\n",
 			evsel->pmu ? evsel->pmu->name : "");
-		return printed + dump_perf_event_processes(msg + printed, size - printed);
+		return printed + dump_perf_event_processes(evsel,
+							   msg + printed,
+							   size - printed);
 		break;
 	case EINVAL:
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
--
2.55.0.1032.g73a4cd73de-goog

