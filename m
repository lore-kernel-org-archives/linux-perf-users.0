Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AB32F759
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643218; cv=none; b=ZitHWViBPoT5uEC8T2CLVFAe5MYtybXcNpQz4L7ON7GlBVdks75Z1YYiLRjq4FBqL03gFeggbDb4fciGiDEBsDmtwf/3upB/X7+FU8admTZkv/qM+gjiYxzmSWbkUqBIcXrnPxCE+FCvR2b0MxQO9NbcjgZYYIsoK01Jepof3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643218; c=relaxed/simple;
	bh=uanSv0QbUJ6GOn5k5fmgpLM20nbrJwmOFgLpu4+ouGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=te/A72t/+vi0gSYp7agwOHe7Lj9DlTCzU5GA3YLl1gYQZh8CTQksKVcv+obFdSQbBo9o55bCzqaQGyjBaKutjbTTCI/XwwFsWerwLdA/gJ0H8Os7CJH+Lw+ZFW/Crdrc4fEPGDYASigig5uBaGUYyu35AFb+0ysNbMe4/6n6JhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdDZxeV8; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdDZxeV8"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd1c74508cso4860142eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643216; x=1777248016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ikbpQLcjy8rXKqk28ezhSZs+LZEfdIgVANBPq1Brw4=;
        b=qdDZxeV8VSoZppKfeZrHu9884wGXVpVZFWpAmsr51WPxRD0HZnN3d9SCbhy1xRKyV0
         Gja6AAK2c4JRQl14fDep18fuHyDg9xGuU6wXv32EhjKNLXYnQyzCPkxfPXFzU48IcgeR
         PP7ssEHMt7lbrxU7Le2/VzTJGPsGIvtgfVFLKZFOGt1dMTUVHQk4WpCUy8JLriw8cYtQ
         Qc1p1cMZGqDxwmf0yJhwzrEQJ5bR4c5OcFCdaVPTK+gG5c9Zd4WHOvrrcTL5IVpwZleG
         effEVa87V/9pJszig4goMybdveQfdiGbSJV4GjPfqZs1dboHG1tRiv5d9P0hGmy7MsYm
         MNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643216; x=1777248016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ikbpQLcjy8rXKqk28ezhSZs+LZEfdIgVANBPq1Brw4=;
        b=pb/bqEv8/AAuTbpnChHPWZ+LJEKwn/A4s78HFec1j2bEDdKYTpGNoThjlm2/HdlYCc
         8MLMlniziW7bHJb6gruuuFf7rt6jJEDE80z67K4nKseWDw8YcKbDXRm+x9VXTe/YOOXJ
         CSGUAJ1ub7Va6To1lAVK/1mfNskVRJ6HbNAui+35yqxlBsLiyfHRevaWayFFD5M8ttgt
         fqU26MalNJhdBPBWRdl3qQ036c0Z5OBqDwQcqfyOlOEqCXJ/jZi3ZeTFBoypUqarCgAU
         klaBNTP/SqB93CMoSjMsgU6XtDz5YkPuaL041S2w82YD4Zk49WEMS2oA5kboLTWCEY5D
         wQYg==
X-Forwarded-Encrypted: i=1; AFNElJ8j9+ktIiJQhXrzpy4fsXjxmvjf+R6DSRpsgo23/co9JAfIGDeVDcbXfk6XrgaS4tVy5u0agwuRxZ5byKI7R5CD@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7JFmy9LgauqQFM7VQejOcm7xrtUrZgf6r62RodSZUQ5Ij8W7
	wJ4ewSFEZtCHC9NNuY3AjBZ6Sw+gD1Sk4kBvwQShCok8LASV9gZHx6dy9FdoE+Xlqt9p3jsolvC
	j1mRX8CtXaQ==
X-Received: from dybfe3.prod.google.com ([2002:a05:7300:bf83:b0:2e6:1dc6:691e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:658a:b0:2e2:9c65:ef6c
 with SMTP id 5a478bee46e88-2e4646cdc9amr5580349eec.4.1776643215689; Sun, 19
 Apr 2026 17:00:15 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:36 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-25-irogers@google.com>
Subject: [PATCH v1 24/58] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
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

These scripts are standalone and not using the `perf script` libpython
support. Move to tools/perf/python in an effort to deprecate the
tools/perf/scripts/python support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/{scripts => }/python/exported-sql-viewer.py | 0
 tools/perf/{scripts => }/python/parallel-perf.py       | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename tools/perf/{scripts => }/python/exported-sql-viewer.py (100%)
 rename tools/perf/{scripts => }/python/parallel-perf.py (100%)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/python/exported-sql-viewer.py
similarity index 100%
rename from tools/perf/scripts/python/exported-sql-viewer.py
rename to tools/perf/python/exported-sql-viewer.py
diff --git a/tools/perf/scripts/python/parallel-perf.py b/tools/perf/python/parallel-perf.py
similarity index 100%
rename from tools/perf/scripts/python/parallel-perf.py
rename to tools/perf/python/parallel-perf.py
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

