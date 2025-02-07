Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4051DE4CE
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970710; cv=none; b=fN+3Vh1iAYvjixHo1vj+JdcY9a534+wpwrUKsRAkB4VciDdU7omLVxxGcANs5wbDLnT/9SJymbkjb9pmmSFDQrQfSLio353rqRxoYPtPtn9lJPoQodnbjhI+j2cptBRE9l6RQBtjsqBmIsJCV4sL1aOnGq6XJZ4iQE9Vgij+k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970710; c=relaxed/simple;
	bh=ObEhRCyFV6ghYkayj4qkPZWcTOssCEFkt4QMyf1+G88=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XKSKuXCzIlHPlxD3nERc2rFl+EPjj12f698MVHi3cSTmko+HzyZvtW2zrP0AdLyRYrq8BcTlIfahCXedA+t0UULFY7BgIg6CGnlDXhEhcAUR7sIs2ksOe861x+j1UCq3zK5F9+bN6B6o3fdJwAenmFHEeeAAZGj+Mt0Tu/a1h3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YF4+1A2o; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YF4+1A2o"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e54da6701d2so3886929276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 15:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738970708; x=1739575508; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdb9tKccQmSzInyuTYu1/jMSVTG4YqjN0UDkWk/dVpA=;
        b=YF4+1A2o606w2PX0Tc14McR9bG0X29DR/20v16yuuxvC+6Xeu2rYZRdKQ5NSUsuzet
         wj4o0n5W6eRgRTt+8/pUEqI1QEDwh9g0ZGu4hIolXOFFBhWde6+YcRW7qYnar5jZdBfg
         cvzBso458wj5l8JQQgybFH7WYtsQFjv+ewfx19iEobSiSqAXy5DjOIhEaKAdKImtSAqh
         el/6YXiJUZedh0/NSbyxPyFCDEOc9GGC5UpGKQEhC9wsXuqq76WT3rAobfTm8GaGZbS+
         BMC9aY2BpyEvPzbyinzINscmUpjv/pilQ/MSePiVOQi/lB9IjkZ3U2o7n7xOQdj4EziS
         rggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970708; x=1739575508;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdb9tKccQmSzInyuTYu1/jMSVTG4YqjN0UDkWk/dVpA=;
        b=idmp3Huks7zr7SSAktkQpGo6+zS5GSKu6BqBnslKyjNPt5OWUuY/2p/DYWBX0+P9YR
         mzsXNEV4zcDS/lPx/4lO8igBjp3geMo6v2pbi29NSvvmc3XHPVIrLy7+kurwl35WmwGF
         b+l0vN+IjAL988XOigxts5HO1bqBZnhhtAu9c97pVDNKmwXLlEzRo5NRD3u8i68De5K1
         Toa0OhYZ0L5vAndJIzKEeVQocolte+monCZRGmZ5qJl//t8aUXDprn+GzsETiI2cVf37
         0emBxwl7UYuN/ImDYNp6uD1PMJuamWTj5AV41Q8RomCoFeTQM0PbHy0NydP8yJR/t5RE
         7W6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBT0191Ck0NSe6vgjlm0wXLciu6VLwnPCQqb5n3L+/8MQHXU7QCg5LNTygO21H0RtMv1NZUNlaT2yxP/V06z7J@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WhQAKnQxX5+/YuMZqTVq9p4zF4edvrc3DSdtLZeWj/11Z3lW
	4CThzv/hdtlLGR/ahVu+jtL/O2P2HQstTO2/5YdBjhYXbqXj3VTbnjNpklV4DmAxmrX/AssKSpK
	AlhsSjQ==
X-Google-Smtp-Source: AGHT+IERCib+1uyyjqUgaird04HbEnd296RFEB5jEzvAoiTwxBqmnTh0Azo5wFkQiLmJsdm2RtuNyjy39V4M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a5b:d04:0:b0:e5b:423e:4757 with SMTP id
 3f1490d57ef6-e5b4625ad03mr43743276.4.1738970707967; Fri, 07 Feb 2025 15:25:07
 -0800 (PST)
Date: Fri,  7 Feb 2025 15:24:46 -0800
In-Reply-To: <20250207232452.994822-1-irogers@google.com>
Message-Id: <20250207232452.994822-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207232452.994822-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v2 5/7] perf events: Remove scandir in thread synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>, 
	Jesper Juhl <jesperjuhl76@gmail.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This avoids scanddir reading the directory into memory that's
allocated and instead allocates on the stack.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 6923b0d5efed..2c1ba39dfdde 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -38,6 +38,7 @@
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 #include <api/fs/fs.h>
 #include <api/io.h>
+#include <api/io_dir.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -767,10 +768,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 				      bool needs_mmap, bool mmap_data)
 {
 	char filename[PATH_MAX];
-	struct dirent **dirent;
+	struct io_dir iod;
+	struct io_dirent64 *dent;
 	pid_t tgid, ppid;
 	int rc = 0;
-	int i, n;
 
 	/* special case: only send one comm event using passed in pid */
 	if (!full) {
@@ -802,16 +803,19 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
 		 machine->root_dir, pid);
 
-	n = scandir(filename, &dirent, filter_task, NULL);
-	if (n < 0)
-		return n;
+	io_dir__init(&iod, open(filename, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (iod.dirfd < 0)
+		return -1;
 
-	for (i = 0; i < n; i++) {
+	while ((dent = io_dir__readdir(&iod)) != NULL) {
 		char *end;
 		pid_t _pid;
 		bool kernel_thread = false;
 
-		_pid = strtol(dirent[i]->d_name, &end, 10);
+		if (!isdigit(dent->d_name[0]))
+			continue;
+
+		_pid = strtol(dent->d_name, &end, 10);
 		if (*end)
 			continue;
 
@@ -845,9 +849,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		}
 	}
 
-	for (i = 0; i < n; i++)
-		zfree(&dirent[i]);
-	free(dirent);
+	close(iod.dirfd);
 
 	return rc;
 }
-- 
2.48.1.502.g6dc24dfdaf-goog

