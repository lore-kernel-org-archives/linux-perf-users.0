Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC9255F3F
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764888618; cv=none; b=Nfg5/2wKkJna5mfBBi0Tx2LOo4k1oaU2srn+HONxkMAdiaWvQqP/n4uMcBEOmWN6zrLsrYqNsWUzKDn6Phzop2Wcf4qCWkPy1xouRuk0D0Shf6lvpVDhf9Qtplzgkr790WGpiu8i/Ug5syaRUvN4D2bwC3huoVsn+7AarunZRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764888618; c=relaxed/simple;
	bh=G7pNIVhA1TXObmnFY7+cd5kvUOCU2C28ebfuPdpleTs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=kFI6WwvKWC6qQ2FHDGi6ULtQp+1shN5dNIORHdvWYo1dFZIRyNfz13CxoZ6aQthOjX6TxyoyDM6qU2BQUi13qRm2UAnMQ5Ujk79U2ILODN3vSR7kAKkTPhdkxM6rYpic9iiyaix7PN7RlZ3WcWrn89aZL75XeZJVy/Uut9dJQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JREAyvA6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JREAyvA6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so1973152a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 14:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764888616; x=1765493416; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7czelWahvvfZQW+IquXER+uuj/HdN565wv3OdCn5dY=;
        b=JREAyvA6ZXOMBqe5F6b5MSOySTlQYkksgcMt/Esdll5oMRU6I1O7zTih78Hm/btOVZ
         rPsGJWDBrkQ/KJD9C2OLIa/OeRnvwl17GH1bpE+SHEvi/hTFSJJ/xY+nERo1XqXjRcvr
         uNfeRiRcfWPPZozfArAhcMEtwF19/nlctwZy5uWbv/0tbK74andwjnrWhMtpjbRcsfJN
         4cvoUD/9sKsK5feVZvThW2PYWP4aOseYlKI9gZs2L7Y8gCPKvwCgSVbzYBn2BScwvS6u
         WOaGrUK0Vr8q20FKgujzN+X3NcCK4I8/Weai2oAxKBK6hbAzj5V9RlTwL1jezIz285jx
         gsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764888616; x=1765493416;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7czelWahvvfZQW+IquXER+uuj/HdN565wv3OdCn5dY=;
        b=izylMwO37ZU6In0FfoM2KM2Pp9c/MXi/CU/cAdM3oVPRFncQelfsRgckhapniaK65W
         zsti3lpjOvOuIumE8AYSzFKSXX9dTS/vK8j46dRjay5xhYQiS9nWbvi4JTUbCbk135bA
         bl/C86omuzLrw8oaVstDOCkLCMVNoM7VjUabwgj+komDZdaMPmFkdyuYy/E7f0veRYVk
         2e9AcpPP5Vcu4/suCaXZ/JD5gH2zXNCbuwCdCmh9WW607/FLwEYLXo8UbYkguq9UEgwn
         6UCwddDVbfsdewkb5XsP+fCH5cOk38UwAaKV7oKoJ/BZoDvjMeZUBlAOtpF3Zffo/YKT
         ICJg==
X-Forwarded-Encrypted: i=1; AJvYcCUXt3zYMsjTKcQNmmIGhpSUscc2g2UZtBjosC7135hor9EY1Jr5Ifd04NVsiyfYbkl309lBDGyav3QXSn/3Ya5+@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbe/w4zfI2S25quYOqKvYHvBFGDPEwQZuUghJMKEA5O+Hcsnb
	OmsHuci4sMddybHYmAcL04GG9g/DVXRJg15dYc6NI/Xg2Swv4XPmNHl7ZUsmAFBeX+EX1w3zb6n
	xvr+T6dvxeg==
X-Google-Smtp-Source: AGHT+IF4LXoJ/RAuWWGPBqFynKsnLj76Bs9RcAT/nfbbMG5XsBlJIfa+EcROyPzPTP/fvN9lhowgEtLXy7wb
X-Received: from dlbeg34.prod.google.com ([2002:a05:7022:fa2:b0:11d:fb52:5d8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6722:b0:11b:d561:bc10
 with SMTP id a92af1059eb24-11df0cae991mr5740247c88.41.1764888615673; Thu, 04
 Dec 2025 14:50:15 -0800 (PST)
Date: Thu,  4 Dec 2025 14:49:23 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251204224924.639406-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf tests kvm: Avoid leaving perf.data.guest file around
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure the perf.data output when checking permissions is written to
/dev/null so that it isn't left in the directory the test is run.

Fixes: b58261584d2f ("perf test kvm: Add some basic perf kvm test coverage")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
index 2fafde1a29cc..2a399b83fe80 100755
--- a/tools/perf/tests/shell/kvm.sh
+++ b/tools/perf/tests/shell/kvm.sh
@@ -118,7 +118,7 @@ setup_qemu() {
 		skip "/dev/kvm not accessible"
 	fi
 
-	if ! perf kvm stat record -a sleep 0.01 >/dev/null 2>&1; then
+	if ! perf kvm stat record -o /dev/null -a sleep 0.01 >/dev/null 2>&1; then
 		skip "No permission to record kvm events"
 	fi
 
-- 
2.52.0.223.gf5cc29aaa4-goog

