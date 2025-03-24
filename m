Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900A1EF092
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855706; cv=none; b=ZfdjgZzt1TAEhQ/aOP6IcoyLFVu91c2KqJObhA2Un4cwQ+4UYFagpYxi9giw4XXvAt9Z8irqE/5PHxJjdR6wVGVOnA/ZA6xnfx/UufiTrn2qjpdSAFSo3gzMYDkCyU8jgtTzEdVBMhACo4zRU+DT7IP2ecmpm2IZeA6oMdn4N+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855706; c=relaxed/simple;
	bh=0PuLW2FPtefhiw76QU+wIv2pk1vi0X0kvqP1oszrRx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pU3U+qNjTdOppY+Tc/IhC8ZdMgnEqhTYP1SAtsV5OAOcqUMLBN67/LK0In883JEGtyT1ostmnQ94xlaIbHh1ofSAWXi7Ib5M/wNAnxuYeAKuzKp+UrcxVYR4nnvGRharDOnM7yhRSUvVF1iyU9Y83F7Efj8mgp+MAjGgeIuQqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2KvQnzQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2KvQnzQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff69646218so13045286a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855705; x=1743460505; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShE09qRnaQIhfbh3jWHOYmVGf4wtxAeWzaDmf4WjLjo=;
        b=n2KvQnzQRElU9iRFYE3xFMLrTo4RgG+egkII90syM+zeeBXBiAoPU0778aH87YAxCS
         1WpaQRNaU0gWQc+xvyv6aQpmBCyTDT8+7TXOCxRUA7fWjUtc0eIvdZqa0AJadDIXQdfr
         hJ/d7VWnINk5PNI3D8Ll/rd95uZfCryq60V9eVcTUwIDnSP9Xr9JpfwmbrJLRTzcZ3+C
         eLCch8YDiFsUfFkT8W3EUCRf+MZRdELUW+8x+/H8zy1HIH/SaDQFqJYYtsromcufITEv
         IIGK/abMQKBA5sBk2aEPcSG8PxwbDf5Qp2zPPEDOgYD0tDE4kNKmHfujl0VOoRRn0eMK
         WYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855705; x=1743460505;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShE09qRnaQIhfbh3jWHOYmVGf4wtxAeWzaDmf4WjLjo=;
        b=NvFCdl3L8XnO69VY2wkD3YXMFRKhXIjz5f6y43jPozcJ1T8OlbhitRSVrttekkyxua
         uflZBdOnLeZDmPTF1IK9419w6y7q4Y7wK41zcZU2EjVGmTvlMBfnx3D3BzrbOFpP8od2
         0qJae42a9P1hwXc/Z1Izt+KnJ9NWya6I/qAH7zQle/5D2ZIqh/QZ86Puehh/DSmaY7tD
         xUhhFz7MNmkrBvKCgevJpgF6yACcYxB5jJo0hPpZ0K32/2IQvgXbb5avxTYtWhv3+Zwx
         8AxsUfMhS0toc+co/5ffnS3pqS8yKeWT/qIUr3HV6AALCE5Mr/3QQs8RyQW/kysbQSjG
         Ptrg==
X-Forwarded-Encrypted: i=1; AJvYcCV5++Vd+v31eihOsoawnesIlgkVFOm4iKJKD1HKKl5AHPb8zCVpDgkOLVOIlYZzlVdNRRtIJ/mM3YRfaxn3p+iS@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFD973EIENJqVgVRz3ro4yOKqCnyhNNTJh4Fw6css0OzMFq4Z
	M5OT/E396bCnMGzziHAdb8FfsuJshaPFWeyKnqqiNf0g5oPmKCQjdKqVFdLDWw1hCoLnccvkQct
	/Lsgp/A==
X-Google-Smtp-Source: AGHT+IGBJPlRZuMF/hNE2Ag6zo6DkH258TkFOSESeENLzqeDl5XLLkCm8BnoBOyMKFz6tnfDo0FI8glEBxUN
X-Received: from pfhq19.prod.google.com ([2002:a62:e113:0:b0:730:90b2:dab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748f:b0:1f5:a3e8:64c8
 with SMTP id adf61e73a8af0-1fe43435c04mr28981137637.36.1742855704576; Mon, 24
 Mar 2025 15:35:04 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:42 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-5-irogers@google.com>
Subject: [PATCH v1 04/14] perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The buffer holds the cpumap to pass to the perf record command, so
move it down to the perf record function. Make this function an evsel
function given the need for the evsel for the cpumap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index e218e435c1d7..13d70c6bd44b 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -82,12 +82,15 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 	return 0;
 }
 
-static int start_perf_record(int control_fd[], int ack_fd[],
-				const char *cpumap_buf)
+static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
 {
 	const char **record_argv;
 	int ret;
 	char buf[32];
+	char cpumap_buf[50];
+
+	cpu_map__snprint(evsel->evlist->core.user_requested_cpus, cpumap_buf,
+			 sizeof(cpumap_buf));
 
 	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
 
@@ -286,8 +289,6 @@ int evsel__tpebs_open(struct evsel *evsel)
 		return ret;
 
 	if (tpebs_event_size > 0) {
-		struct evlist *evsel_list = evsel->evlist;
-		char cpumap_buf[50];
 		struct pollfd pollfd = { .events = POLLIN, };
 		int control_fd[2], ack_fd[2], len;
 		char ack_buf[8];
@@ -304,10 +305,7 @@ int evsel__tpebs_open(struct evsel *evsel)
 			goto out;
 		}
 
-		cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf,
-				 sizeof(cpumap_buf));
-
-		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
+		ret = evsel__tpebs_start_perf_record(evsel, control_fd, ack_fd);
 		if (ret)
 			goto out;
 
-- 
2.49.0.395.g12beb8f557-goog

