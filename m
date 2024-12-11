Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E691F0E53;
	Wed, 11 Dec 2024 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957375; cv=none; b=ThpDbYTFxKcqRz3xALEqlSh6kQPmJI29NStJrP9Cd5dsy/acsGbhkTDJui5nhw3fNonQFc2QhPyLIMLzpcIwR0drIUzUGiNs+0rTiHSSEPop/VPaRLrZvyMM55ENOCClXuidQ31GVDjpwpJpZPC3uvh+izuY+WuTSstOIh0dcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957375; c=relaxed/simple;
	bh=6xh0bVck0B8lgk6GVIh6/cpRZPxwDwkzpZZ20BQCKxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkVWCqq3rj+GcWZwux89X6OOmpC08or8vBeBkL9KdjHpaZmmoxChnzSI3t0fPFtLiiWCnwj6d46pb02uhsSaVniXB0JBzeTQ9WMk+XogU8bkpejatK/Q0wQOFJLyLdEFi07KUBHXpw4N18vknr31BYV0dIJaNKKt9jv9p7IYYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVqnlexa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVqnlexa"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72739105e02so5891b3a.0;
        Wed, 11 Dec 2024 14:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733957373; x=1734562173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NADZafaFYONt5GwVPkj5cWf8xMDXWYD7ZnFNifYBYQ=;
        b=KVqnlexaBSMUnkawmaTaW8tWDb7jAoPqGraWwycQJ2lbSzAZhQbcuNO6ehiA/RksHu
         zKc7T7XgpuUkbmpXnAIzGvqksf/6AyGYuAweDADyPQ1oh0NCeZ/Z5wEFCT0ZhJz8pO8s
         gCr+tdBs9g//ZgOoeSxaTla/d9SLuJ9u3xa9OLv2EYwrCeFoKfBYuKuYitc7ksuLNZDI
         sdwhzA17HMCg2uE0STHy9THpowTMrY5TSl7vUoXJZhG8XmSFR+S7bdHjqfllmkmZ54uA
         jTlOXb+Eh6yUHTKUSTKWzm3C08+3j77W+E5OiDP+FgysWNi4AGablplLHqfpD7PNc3gQ
         NXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957373; x=1734562173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NADZafaFYONt5GwVPkj5cWf8xMDXWYD7ZnFNifYBYQ=;
        b=E32bb6q1jrJz6vNrqsCIdAZ75FbYNxG1TlUjhjh8b5Oj4xqtkoR7ZOTeoqyAirDbuc
         J8hxthejhUO9oUn3Og67U7/BwJVjz+PfOWKtHjDJiw2wbLZe09snurypF7KtDUfXQUPW
         SCZUqWC7BvNzGLpWqGiVBCIt+7stO4DLJPHbxCxMOGUWo2mTultlVACIT0wKaCXWe6o5
         IXqQlBt6Bjo5KILirWm22wOGp9mZLqJbRWJN+9dtcP+Nnk5oJcCaZSpRYOzyzSzRdUNI
         WwXllPsWISrpVXk5xZyeMoyZ5hFD2ApCzE5uxcsYpTyRk2ptjy9LcE5Ike89VpATS5VT
         VAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9o+ekiXxfdRDGDUN0BvMAH/7aT6E/tBgW1na5yz0PMgjj0+NZQKu7boyyraxOLjEnQymTX5yrRo1WuAE=@vger.kernel.org, AJvYcCVAp620FIeNy1nTRVK6tpovrWLJD8FXff8U2N7qfFuq4Qs/7HtPPllcW9xVbhoVm08jQbm0G8Rrsj7xZ1+VVCNxLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBIFkXc8ZYkK3w5Mlfjt5R4mK/xPNnZW8WZQVjbfUHfyHuMXW
	0R6BSF7jxEpCCAzvZktXr4stXq/pgoldLQNSZtmNAoIFy5h1bZd2
X-Gm-Gg: ASbGncs3saE/lZ8dIDwxLbOuu5ig2NCjBdwNsoKy1t4WUhDlYfMyAqsb6guoDCSXfMh
	R+rUGUuX8N3z0+x3mJ8C7aTJXaSt5diBenlpSPB3fU3Cnq2mbom8pKsNANTjPIRtOlZrh2JXZFt
	29cpR4+ORtaie2zmPGay3D8zAvuco+BdH6rNKdheuy3/iZm/qOeFmBx5U4N7Q+gw9eggh0k72l4
	Fq3rpIOayqLM9DwNJwCBRRNWQDwjn9/xx2jocoR5jcBOoshLvbRIOscB/sYitaA57rdtoH4YUwB
	OQbyM8NFTA==
X-Google-Smtp-Source: AGHT+IE6JRcMt8xGs2Znrox1pvGoPsccgbYH3rKww9pfv+GXPlB/CeX0/bH7ritsRSmcW10Yf5q9lA==
X-Received: by 2002:a05:6a21:3985:b0:1e1:a56b:9d6f with SMTP id adf61e73a8af0-1e1ceb0a165mr1717863637.24.1733957373451;
        Wed, 11 Dec 2024 14:49:33 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-728e2520144sm3430506b3a.116.2024.12.11.14.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:49:33 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v3 2/2] perf docs: Add documentation for --force-btf option
Date: Wed, 11 Dec 2024 14:49:27 -0800
Message-ID: <20241211224927.968483-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211224927.968483-1-howardchu95@gmail.com>
References: <20241211224927.968483-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --force-btf option is intended for debugging purposes and is
currently undocumented. Add documentation for it.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/Documentation/perf-trace.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 6e0cc50bbc13..fb3d2af33844 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -241,6 +241,11 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	printing using the existing 'perf trace' syscall arg beautifiers to map integer
 	arguments to strings (pid to comm, syscall id to syscall name, etc).
 
+--force-btf::
+	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty
+	printers. This option is intended for testing BTF integration in perf trace. btf_dump-based
+	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
+	better pretty-print integer flags and struct pointers.
 
 PAGEFAULTS
 ----------
-- 
2.43.0

