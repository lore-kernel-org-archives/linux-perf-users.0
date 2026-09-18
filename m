Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19337471277
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758538; cv=none; b=MDH469tbU5z2rN3M5uifNwY3y4IJ2AqBWvXhz+lirUqEScp64dETqVB37TK90yNbQjq8zuXR9ELGF4qPmSrwWbH9gr63APSsr9gFEpOwmneZ4N4IeCrdnBlxt4h+28/KFZnaJUxLfOtk1j2pSFa12L/BskiVsrkv93B+5MlDw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758538; c=relaxed/simple;
	bh=vtzHYOZsL+DsQ6OU9w78rV8QDnNXXiUdKTEDMcuSfOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oQA7yJJU9Sdb/lsCygtGB1XK1FjtBxn0N0k4iOIBCLT7+mBVOxyrH4JvrOZ6muI62bFsPF6gGZEFZ+TY5q2LxuNkH6E8c/BVa8RAwE+ewlsqNjKBHJeVlxpO9B8wjEPUcj0ybnaj6U06Yi/mpgsDXfcwguWbyNqnOkevERsw/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAO9a1HG; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAO9a1HG"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so6444895e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789758530; x=1790363330; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlR8Li9AQguqMj6ZVMr+f+KkK5/jHymLg1fc6OgUNdE=;
        b=tAO9a1HG7XGoxqkPakxi3HIQETvzhB6Mh5wmYoYTbJBS5K4++O6jVR8fhGXM2Z4YjE
         ikpKBFsKE3QJ5FoCH/6wmgZCTlJduc6RNSzwjJd7+8G9HOuHgdyrF0oD4NC2gAyrbQS/
         5Q63wh3DuniqtjfkcHorOr94t4no5mNREH21rK9ZUa/c2h8RWmAVerfc6eBYYzLK9HVm
         oEAOkE8jvshinrKvF6vdYyc/hReFGrbFZ8oUW9uiQFLwDo76tlJ8X5Bzt8I9X5U9Qs2G
         Nm+WuL/w0eXqXGSdcN56FJ526L9GQyKsXqRg0Oe2M9IJWZN5oJJeFBuD7gTtvXK03Wlg
         NmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789758530; x=1790363330;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KlR8Li9AQguqMj6ZVMr+f+KkK5/jHymLg1fc6OgUNdE=;
        b=oHfDOiKHFQ2pGWb6xzNxZTQ9H0MxQK8cSEoRqp/mUOLw2AUvrOFkiaiiUMhVc+C7+U
         oAv8s4D6jlW+3uCEW1uEKnONehByIKWXMs4H8ehi3NloIgQgZUtiVWl+L3GjcoFkk1CB
         GT0Gg6V5dP+M7MX9QeaLzGS84+vNX23x3StGgO/K3gIkV3sIATSdmUJuifsMGnFPMk+y
         kfEip3GOfjp72Y5MOuygySqw3OIJANIpZMFI68wCguwipYJu0ZzjmZmFoj+Pquw8w/jZ
         Y83fHekZrrI+OWUILMDyhh0U3taALcYiquZHYYN1BpRNgpMfcAeT8FXUfr1I07bpRRaj
         8nPw==
X-Gm-Message-State: AFuF++kxPF+xKRgoH8w++DPAsVEPK9n00DESlI3TEiko/9SWH5qlnm15
	4VQjlkntOrv1UaSGiG5nbQJh/ejPBo9cZYY9vP+Dd6YoeirLlkQ1CNxwNkhzy1PU
X-Gm-Gg: AYBFou3hzQRMOOt8ADJURLDH+smrK/LJ6SZciCJ7JO0trHbU2cAWzMOXGL1/810Vhhr
	1IbK+Cm8a+hWpzhH8ov6uJScGKlwtGZV7u7z9n8ccqDre/fapbIp3F2hwZ1tDKQ2ZWpO00xBFyn
	gCXfwcaawk52iS50F4ZZtjJOr74ZcRsbDdz7/LstCRFpen2aIY+CYvMtoIMvBRmcE8gxRHfoG1Q
	NlMLYf450jF0vkyL4CiwyB4LXvSFHmx50scZD/SO8D3nFqBsgiA+FH05m5lPpq8N53eywIPI/yv
	EWU6KhGuemPLBSXG2k/orop7sxEciIdNpfY/Ag1MOlTxREXU4nnpKulR0UlkwJiUUKaHf0F/lx3
	FVq247KsTwO33OvkmQZzmKakfxIgvkROvjZcftjULUerhj6ypTMjNL6ZEQFY2HskA/EvKPgTywl
	FVKnVpGpVf+NVwPad8gx63TVZIViM7IUbogMHNVPnV38dODggfToogKwD9pHLi5Ey1VQ0gDhHqq
	4Nh+Pxi49Ii/BhcWzTc00cUnxCE8IaEDQQ=
X-Received: by 2002:a05:600c:c1c8:10b0:49e:81a7:9fbc with SMTP id 5b1f17b1804b1-49fc574aacbmr35802825e9.24.1789758530233;
        Fri, 18 Sep 2026 12:08:50 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0874c3sm20217525e9.14.2026.09.18.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 12:08:49 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id CE28FBE2EED; Fri, 18 Sep 2026 21:08:48 +0200 (CEST)
Date: Fri, 18 Sep 2026 21:08:48 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Please backport subset of 2f5d370dec3f ("perf test: Change all
 remaining #!/bin/sh to #!/bin/bash") for stat_bpf_counters.sh script to
 v6.12.y and older
Message-ID: <aq2MQLKmyrxkFd0Y@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

Recently for v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52 and
v7.2.6, the commit b02027776ac5 ("perf tests: Fix flakiness in BPF
counters test on hybrid systems") was backported, but it introduced
bash specific syntax.  For versions after 2f5d370dec3f ("perf test:
Change all remaining #!/bin/sh to #!/bin/bash") aka before v6.17-rc1
this is not a problem.

The proposed patch is a stable series backports specific one, as one
cannot simply backport 2f5d370dec3f ("perf test: Change all remaining
#!/bin/sh to #!/bin/bash") without picking as well some other context
related changes to make it possible. So I was proposing to only change
shebang to #!/bin/bash in stable series were it is a problem, as in
the stat_bpf_counters.sh script.

Regards,
Salvatore

From 1e3d5b5f62047b147428d20bf2cb794bb0bb300d Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Fri, 18 Sep 2026 20:48:59 +0200
Subject: [PATCH] perf tests: Change shebang for stat_bpf_counters.sh to
 #!/bin/bash

When commit b02027776ac5 ("perf tests: Fix flakiness in BPF counters
test on hybrid systems") was backported to several stable series
(v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52, v7.2.6) it
introduced specific bash syntax. For versions after 2f5d370dec3f ("perf
test: Change all remaining #!/bin/sh to #!/bin/bash") in v6.17-rc1 this
is not a problem as the shebang was already hanged to #!/bin/bash. For
the older stable series this introduced invalid syntax if #!/bin/sh is
not bash:

	$ sh -n tools/perf/tests/shell/stat_bpf_counters.sh
	tools/perf/tests/shell/stat_bpf_counters.sh: 12: Syntax error: "(" unexpected

	$ checkbashism tools/perf/tests/shell/stat_bpf_counters.sh
	possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh line 52 (bash arrays, ${name[0|*|@]}):
		base_instructions=$(perf stat --no-big-num -e instructions:u -- "${workload[@]}" 2>&1 | \
					awk -v i=0 -v c=0 '/instructions/ { \
						if ($1 != "<not") { i++; c += $1 } \
					} END { if (i > 0) printf "%.0f", c; else print "<not" }')
	possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh line 57 (bash arrays, ${name[0|*|@]}):
		bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions:u \
					-- "${workload[@]}"  2>&1 | \
					awk -v i=0 -v c=0 '/instructions/ { \
						if ($1 != "<not") { i++; c += $1 } \
					} END { if (i > 0) printf "%.0f", c; else print "<not" }')
	possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh line 68 (bash arrays, ${name[0|*|@]}):
		stat_output=$(perf stat --no-big-num \
			-e instructions/name=base_instructions/u,instructions/name=bpf_instructions/bu \
			-- "${workload[@]}" 2>&1)

Change shebang for the stat_bpf_counters.sh script.

No upstream commit exists for this change as for versions post 6.17-rc1
the scripts were converted to #!/bin/bash already.

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 76d4a7f15a43..c4f71bfc0fc6 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf stat --bpf-counters test
 # SPDX-License-Identifier: GPL-2.0
 
-- 
2.55.0

