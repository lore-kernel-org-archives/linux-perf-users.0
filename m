Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF314690E
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968381; cv=none; b=Rt1QbiS9e4Sy6r4JJQ+p/e9kGOEPX2CM1w25WZrpfKWzIolDVyYRiIVkE4XAWt4HNjdNWbG1V78i4gfXBcIZlEK93SqVJvX7hgEqJUsFrKgeaPXYC2uRsI0F+42ZQ6mdhJpxPylQtuvckJfUc+7/EEV1U67tHFg/XhqvSvbB0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968381; c=relaxed/simple;
	bh=QSzzoS14vis9dIlzEyaQe1hPLIfMWnirr9zB3yUAZLk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TOTeG90p1qHdoPYZKv0OKHDsbu8UVk2ZdAzrGYP5R7Et4szxrZObTUDPcTbVun1Kb94idYYEo0Vqy1/aLHHsstnn6ELrl7eaTAsrFQAQFqOAHfDIKpPCi5XmxEXy10/oRIWhEd2vZE7OyQHsVb+8TN2iX6RftxCG1aed0Pq4Mwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpPC+nHC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpPC+nHC"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff7eabfd94so53433287b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 16:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968378; x=1706573178; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbGGf59DA5QM5LIqtEUDehzpONrkGjjAENgF7jFRKl8=;
        b=UpPC+nHCQdCOlLooBJLVq3GMj0wxnKG3qiQ6zlfCVZIFwzTFOSEW1bSV7kZYOttOK4
         euGBwpgbe+ZzkNc6JImgQYqk+uQ837CIq75cqeU6EqmSkmVSnJZr/m+WxQn2KJr95KPB
         xijjmiPBPiaz8Vp4jHeB/BRxgPcCq/CtCEqxl7wTJkFNMfoP+hJ4IlhzyzgIIkS7hQpz
         g945mKYkZa+6DRZ+P+D17CiFlrzSvv0v89lEkA4KVJAcROd7CwZ+rQ4MPBV2w/2oCOsm
         xpc+hPzL3Y3/0NTfTvV9vBb76Q/k09RZEItKDjRi31allhCr6uLu1M5dG6Ioo323tp3a
         ddtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968378; x=1706573178;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbGGf59DA5QM5LIqtEUDehzpONrkGjjAENgF7jFRKl8=;
        b=a9wbxAK+NamBwpQwxe+kgcGnTik0kHCDwxtMuLyAfML4TmRLKS6En03/NLJocqlNpW
         SVqZeAMfbsDwTPTqPnAV22q6g+3Y6JD3xszZtR15baSC0RrXLgQE/2cogRlY6LtSBUQC
         vp+q7zlgG/4U+QApSzwOh+Cr7nYGnGCX69ywOHkfIF1ixVaWSmMm6TdFP2MNJ0w4SnBi
         hcdwCUMWEpbj66FTYbATfq1jjCqVEqBaH7F61Q1c/JWosMo6odOOyt4abU2RaXw7AGSe
         hZsjM50zc4WWWj8CcUi/qxFq4fs4zSm5a6uPL3yiDae6K5+MNLSZIIWfxiUEaHBUy9J8
         5f4w==
X-Gm-Message-State: AOJu0YyDULFsrkaP/i2q2rVGHZ83ZT5iWzdFX6CMMMq7RnEvmyFGCiNd
	gkeLd/MUyI1TdVmoGux+WOrYWNbO9XSSk/GJkzPXMVhGnJ6G9mDwmRrZO9DeQ7h/wj797v6UEG4
	uXeQKjg==
X-Google-Smtp-Source: AGHT+IFI9v9ErrrriPidwIImxOgMDIe4nG5RZVJxqXZFbvLOe/Avzwb/T5Juc7eC1YqaDNWzCNVV6o+VlJkw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6aba:f97a:4dc7:7e92])
 (user=irogers job=sendgmr) by 2002:a81:5709:0:b0:5f8:bd56:176f with SMTP id
 l9-20020a815709000000b005f8bd56176fmr2362476ywb.2.1705968378456; Mon, 22 Jan
 2024 16:06:18 -0800 (PST)
Date: Mon, 22 Jan 2024 16:06:02 -0800
In-Reply-To: <20240123000604.1211486-1-irogers@google.com>
Message-Id: <20240123000604.1211486-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 3/5] perf test: Workaround debug output in list test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Write the json output to a specific file to avoid debug output
breaking it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/list.sh | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 22b004f2b23e..8a868ae64560 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -3,17 +3,32 @@
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-err=0
 
 shelldir=$(dirname "$0")
 # shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
+list_output=$(mktemp /tmp/__perf_test.list_output.json.XXXXX)
+
+cleanup() {
+  rm -f "${list_output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
 test_list_json() {
   echo "Json output test"
-  perf list -j | $PYTHON -m json.tool
+  perf list -j -o "${list_output}"
+  $PYTHON -m json.tool "${list_output}"
   echo "Json output test [Success]"
 }
 
 test_list_json
-exit $err
+cleanup
+exit 0
-- 
2.43.0.429.g432eaa2c6b-goog

