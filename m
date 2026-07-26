Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AC37EFEC;
	Sun, 26 Jul 2026 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109244; cv=none; b=HHYTMh6058+DsM8fSsrHYkPM+U/1KxYvdrSM2nvpMx3zD2WNXc/Iq2PC819iYHLvdml3CW2YDa21ImHfuzBuCZYKuno20OITEXqYgJkdeZgT4hd9w5R6iRsuPknGU1QMJ1QxXoEbvk2tLBCKX7Fsg32iHQkjmdzmBW9tf3sws5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109244; c=relaxed/simple;
	bh=vJ8IsKAFFbggJ01bSz0W92y7CoWgBeJmuB6XB610xW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAysTQVqBuzGA4qE1al/RM/h4YJMt83gZK/1DjEkeqH5z/N/X3r9IbvKOKYu2eEFxxHSPLNv6A17jRpnRMNAeppESTN2PtJw3j54qa6w8uW/sWL16RwfbihwuQ/h3D+R5FgyLQQU4LtNdwApwdpcnekXRc2faHawsnpK/xKctwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fio6pTEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fio6pTEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1661F00A3A;
	Sun, 26 Jul 2026 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109242;
	bh=9ztu+IlC6acr52KFlHiLCfnZZA2r1L/m6OnyVS03TEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fio6pTEEj4l/SI717nSjhMlEk7+5ORLr6crtpIItSxP5Ftl1yZQAs+OeEnjfncE+B
	 SUeHh/DdQJbeJiCjx7S/u1PUay9UPLJU7/w4B6MAHz0XAmYlIunjB1cNNOplP5DhXa
	 bnym8+hUwoWwL3lbkrVoybEKSu9+pRMkxXBPiC4cMYF8CBTDhWEC6+QFs9igbuq1Qn
	 joUxx3n9A7eZ8Hy866gdECmhZkQhw1kENCb09qqf6chj6AxSSsCBKz4OB8lqfztYtz
	 PJLi5Ar9ZmHJ/BwNvzcfZpuJ8b7o4qAzZ8fsNEsks+U0N0eLsh+xIePUY8wMSSr+Z3
	 iMhPXE3n77FjA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: [PATCH 7/8] perf machine: Free scandir entries in guest kernel map creation
Date: Sun, 26 Jul 2026 20:40:13 -0300
Message-ID: <20260726234014.63111-8-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726234014.63111-1-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

machines__create_guest_kernel_maps() calls scandir() which allocates
both the namelist array and each individual dirent entry.  The code
frees the namelist array but not the individual entries, leaking memory
proportional to the number of directories under guestmount.

Free each namelist[i] after it is no longer needed.

Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Zhang, Yanmin <yanmin_zhang@linux.intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1700130adedb3a89..48c4b963e8097f4a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1256,6 +1256,7 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 		for (i = 0; i < items; i++) {
 			if (!isdigit(namelist[i]->d_name[0])) {
 				/* Filter out . and .. */
+				free(namelist[i]);
 				continue;
 			}
 			errno = 0;
@@ -1265,6 +1266,7 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 			    (errno == ERANGE)) {
 				pr_debug("invalid directory (%s). Skipping.\n",
 					 namelist[i]->d_name);
+				free(namelist[i]);
 				continue;
 			}
 			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
@@ -1272,9 +1274,11 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 				 namelist[i]->d_name);
 			if (access(path, R_OK)) {
 				pr_debug("Can't access file %s\n", path);
+				free(namelist[i]);
 				continue;
 			}
 			machines__create_kernel_maps(machines, pid);
+			free(namelist[i]);
 		}
 		free(namelist);
 	}
-- 
2.55.0

