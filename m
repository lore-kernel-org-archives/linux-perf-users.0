Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD3330667
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643183; cv=none; b=cuQs0U/bVSQx3N8rCyzBdDs9Tx/A0I78kaDrMDj0YfCLSjviMZZOZlNjXeSB8nKyB7XWCL24XP04iF3i6QBsrhMENE2FL+SbZIjlFdjg1CZvISXZKvaN2UiOoZIyNTBE1iD253nPcqc9YzUSwcPCpHy/dGRQ/NQvsxn2ewbMPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643183; c=relaxed/simple;
	bh=MYbaBZdF2szXUTr91I2JnUxwvjtyhIaIesW6fBwzvyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o5k21n2wBhE+K8Zny1pTr0GIi18/Xcs3j6PqdcX1BzIJ87ad8U999jw1hdT6eHWa+2dDMWOFzhqM4DgT2G9mzVd5fMo8SxM2tcbGL6/KlAal1oNMWOZEi2oR3f0+AwyfhFQgu8BeASa5aRXhrqx8tRbHfoxaFBjzFahrxb9Jcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fp3agAQL; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fp3agAQL"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2de07c12745so3214165eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643182; x=1777247982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZjDZVoxe8RTPl4BJOXVaOOB/rtV3dry0yYniop3k5Y=;
        b=Fp3agAQLLybDZkIfiav06z7Patia3u5EILHrGQhWoZUsozB5A1l68gDxBf1h0o1+22
         6gK8RJ/UngugW8wpi9YiIzaQXuqfljlEmCr7kC45iznsQs35XR7XQKcZg4bOqj35M3hB
         ER5USJmBf0zbPOldX4qabSvjFw47gLV1uYh/DmokNccLMzciKK0+O0syjO9gAg8wfu7k
         M93Uh73fJ8ERzeMcNsWXu7/uBk3XckZfYIdmowloS85RiQtTHytlW571GEJ/ewN/NVo5
         u8jgtimXYn4uVS3zoNsQ7JIDHcnKGCDfr6dyWv4gQ008U5QjFYnZx1nktfyggmv9Wu8B
         eSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643182; x=1777247982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZjDZVoxe8RTPl4BJOXVaOOB/rtV3dry0yYniop3k5Y=;
        b=c5g0ObbrG1W9atid51ugutZLfgt36dDth+0hDZXE6sDbsgOHPnIqvyhRoNZ+tPolYS
         GCs47S66sXWwUa09qXqySlHO85VYckkCUSZ6ligZI/aFGKm0wxuqoY3R0OkYBJv98lX6
         HTM8wh5JAGCXVjJA1LVINmx3LEvTPvQpZUcYSBixb0g5KEEd7psswRVlxAOUgKZ1IcHM
         TbMhAcWtsOAHec0vIxqpHUe4pLXE1MiJ95rQO+iK+Lvtc8ruzchbEcsddxdZj2FD76zb
         ctd06ZuyjbjuDT7yzQjSU8espA6oLRr2BgfS6lEeIVAfKjD3eibb4zM7EtUPV4JLztGD
         ZqJw==
X-Forwarded-Encrypted: i=1; AFNElJ8y57/fXaqBAJtMC6Oe2d48fAv/OEoKmekJYWGagDiVmiiI85G6pvb2kQITOF94GYRzx5XOg3kYUvylsfHDmNCo@vger.kernel.org
X-Gm-Message-State: AOJu0YxIS5rfcz9nBHpAFXqSf3P72xjeulVr2FFUm6lkwILGosTplFim
	HiIhIT7VNnDgNBzm5XIllHeJzex0nOWk545+PVGz67PbfG1Zr2C9sj5ev1I/TpKQEfuNt5XURB6
	iQ2gZsanmiA==
X-Received: from dycpq4.prod.google.com ([2002:a05:7301:fd04:b0:2df:6abf:7cee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc05:b0:2dd:6937:79b8
 with SMTP id 5a478bee46e88-2e466044724mr5912749eec.5.1776643181289; Sun, 19
 Apr 2026 16:59:41 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:21 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-10-irogers@google.com>
Subject: [PATCH v1 09/58] perf data: Add open flag
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid double opens and ensure only open files are closed. This
addresses some issues with python integration where the data file
wants to be opened before being given to a session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data.c | 21 ++++++++++++++++++---
 tools/perf/util/data.h |  4 +++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 94dc534a7386..9a7195c68a16 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -360,9 +360,16 @@ static int open_dir(struct perf_data *data)
 
 int perf_data__open(struct perf_data *data)
 {
-	if (check_pipe(data))
+	int ret;
+
+	if (data->open)
 		return 0;
 
+	if (check_pipe(data)) {
+		data->open = true;
+		return 0;
+	}
+
 	/* currently it allows stdio for pipe only */
 	data->file.use_stdio = false;
 
@@ -375,16 +382,24 @@ int perf_data__open(struct perf_data *data)
 	if (perf_data__is_read(data))
 		data->is_dir = is_dir(data);
 
-	return perf_data__is_dir(data) ?
-	       open_dir(data) : open_file_dup(data);
+	ret = perf_data__is_dir(data) ? open_dir(data) : open_file_dup(data);
+
+	if (!ret)
+		data->open = true;
+
+	return ret;
 }
 
 void perf_data__close(struct perf_data *data)
 {
+	if (!data->open)
+		return;
+
 	if (perf_data__is_dir(data))
 		perf_data__close_dir(data);
 
 	perf_data_file__close(&data->file);
+	data->open = false;
 }
 
 static ssize_t perf_data_file__read(struct perf_data_file *file, void *buf, size_t size)
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 8299fb5fa7da..76f57f60361f 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -50,6 +50,8 @@ struct perf_data {
 	const char		*path;
 	/** @file: Underlying file to be used. */
 	struct perf_data_file	 file;
+	/** @open: Has the file or directory been opened. */
+	bool			 open;
 	/** @is_pipe: Underlying file is a pipe. */
 	bool			 is_pipe;
 	/** @is_dir: Underlying file is a directory. */
@@ -59,7 +61,7 @@ struct perf_data {
 	/** @in_place_update: A file opened for reading but will be written to. */
 	bool			 in_place_update;
 	/** @mode: Read or write mode. */
-	enum perf_data_mode	 mode;
+	enum perf_data_mode	 mode:8;
 
 	struct {
 		/** @version: perf_dir_version. */
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

