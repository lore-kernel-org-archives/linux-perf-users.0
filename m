Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B51C6A3
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842265; cv=none; b=Kj09PCDWOmPhZ1iyocKXyMO3YajUqSyqFQ9XbEy4850IOKM3MDNr7TjbzDJrq7ZAVAI96xN5+3c8otELpIDXPa43aRxt44S3GNsRkx5a84qmGp/GfVlFaYWasqadP7MRLBd8i8xcNtNkPYm3ESuuQAq4C6+SAkoaoG4GxzJWJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842265; c=relaxed/simple;
	bh=lH5HflBC8pWb+z+Kv7k5EJDzEizYIwE8s7tE/0qlMFw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XY0FNwCNxNqTA+Lqy8LZeLzurT9dKUu2KvCQ7ZdmCrKwdT6TTxdcovL90/NPWjFTrBRusYy/tv32dv0sCY6XkeoU8FAWlQncUTs4bCIw1FhBdNXE/WtPTOcSZzxV4jc64X+AEw7EqmTwoXgjYQD8xIgjADotLrgbpu3fmL5y0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nf7CR8Xo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf7CR8Xo"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b13ce3daaso125028887b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Apr 2024 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713842262; x=1714447062; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nhUNWHd/vBo68/OMf2V7DkzBC0fWIc9SzssVfvUJw4=;
        b=nf7CR8XopxMclIE2aAo6VLB6BIWihGvzw/uabd4cnJ7bJsjSsmAuYNBRXjnJaEu0GJ
         KikY/t1NVSjoh9dVKst1rfHeoL0esicXCFf9VUUG+T/w0HTQsJIKupDyVa0GRlEllNWB
         Bj8zGGZImj0zf3j86m33gOeiYSwtMDDvQ+LsRERafwbyhKKNGNNaKGr/uYJ8ssGjzD0s
         bWCdCkLPNf536T3W1qSzodKq5SVzLeuIhln8Z25v8lfV3sYkZ/9wxe0P6ha7lR4WO1FC
         dnDiLKFdCQHDUJCPpqnP63dY3q5dEWG+y/4g1hM2SxIrTyi6+jiUGph5e8uJGdboSguE
         rDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842262; x=1714447062;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nhUNWHd/vBo68/OMf2V7DkzBC0fWIc9SzssVfvUJw4=;
        b=LFJnxlpCGr45gK5RVYfflt5LrrY9ccTTxvlv7nPlU+rAiP/NqyDrq/dtftIKdSXEFY
         k31TY5BqpNMUQqf3v9jOIbp6tAKewAIEwXlQBSdTeqI6nKXVUTZkxnjZ60pH6eoAFpgI
         AaszhBE+wE/x6ST4nOq1Ov2Z4JnnUX+8w4kq2FMJ1OX36p+1GmVJeTGx5mNiU2nwccTn
         7NOJYrCSO0EEVvbjP2n+IEOP2jV8Tk3y9Bycr+KCg94NA08qEWbCzYRFks2cdT3u1R++
         RJduqQHBYW7ZocKl3HQQwBYCBFaCdJqXUnZHtBD3vNv/KseprW7x0+noPOHJpXHLP+B0
         /qsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdJPEQoaw+v+d+m72XWoe1qLoK/RR97ZVoXz8Ki4mL8atST5nE+ANLqCYUSeTWGzACW/um/S9M3/WlAohoKOBv5K7HxYfOHIscwMWH2lCm+Q==
X-Gm-Message-State: AOJu0Yzo14sUZChKpJVMDmTOWq/t+lUuG1ZLebBO9/hLhm8phcWoP64L
	HZDIb+sKegTswqg82r9MTyftTtuihFEnkLA3wljSNYmHT4tVdVRjdrGLCAtgiiriVAd8aPKkldu
	ehk4IXw==
X-Google-Smtp-Source: AGHT+IHUb9CQO39gnMLndOg3/rTLB5xw24Gc5Hm+GfTLcEC7+RhHCe/Ji6Zw2FEV8Tag+UZIqiAVx4Y0hZQe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a0d:d48a:0:b0:618:931c:9a14 with SMTP id
 w132-20020a0dd48a000000b00618931c9a14mr2819322ywd.4.1713842262540; Mon, 22
 Apr 2024 20:17:42 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:17:15 -0700
In-Reply-To: <20240423031719.1941141-1-irogers@google.com>
Message-Id: <20240423031719.1941141-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423031719.1941141-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v2 2/6] perf Document: Capture that sysfs event names must be
 lower case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To avoid directory scans in perf it is going to be assumed that sysfs
event names are lower case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 77de58d03822..3e0100e9c664 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -37,6 +37,12 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		performance monitoring event supported by the <pmu>. The name
 		of the file is the name of the event.
 
+		As performance monitoring event names are case
+		insensitive in the perf tool, the perf tool only looks
+		for lower case event names in sysfs to avoid scanning
+		the directory. It is therefore required the name of
+		the event here is lower case.
+
 		File contents:
 
 			<term>[=<value>][,<term>[=<value>]]...
-- 
2.44.0.769.g3c40516874-goog

