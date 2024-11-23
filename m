Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF3C148;
	Sat, 23 Nov 2024 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732323320; cv=none; b=c5f1/TjODuD2hFz+5y6QMufTpq8IEiUwqC/EhzayuNuX7WatcD2kZRcelP+o6gREZ5jSjuFSLQhLG8GuEdmyLTYU5rhWjZqVsGkBRSBXX03nmDF9r2o6hAUF1QAZn4k44p0N3Mo0IkGM6cJMAkzLnUdG9tA6s7gn9Jeh6vbYbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732323320; c=relaxed/simple;
	bh=PebzL4iJo4v3MPtoAbmSTmI6zAX4+ZAbZ67kw909KyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M91+fSAoML39xarmy+1Xk2rmUmaHCbjwPMQYriqTvGkdpLeayQdGC9W/Mu7ClQW/YIcl2XPyk6S39iHddihZz2mTbc+jTlrj7mN44E3WW3OKIXWbkF2rso9D8zLnLLqJ4BwG8lHYLwaKp8H9aNvy759kQK/N9ImEi/eclaglRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZQLJcLU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZQLJcLU"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fbc29b3145so1604596a12.0;
        Fri, 22 Nov 2024 16:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732323318; x=1732928118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejdsA3LiRT1wCslfDraOcPVuluASa+i3xrjQ0MCRvvA=;
        b=jZQLJcLUVb61JnhTn4JF0bXi1eZ0GZzo/1Ssi7qif8d4LVnoPBtsCTH+H1bojKDKl7
         67wSnTzq4mxoWptQVytriA13qn5gTixzw4nq7vD+8ExqntvP/V75WZ76dqp7WkaZEs1v
         jvxGpc9eCyX49DS3XjBJuwSOK81iPHBsZQqzgFUqAb297yeZAT4tklErq16ZZPvAcK3Z
         /Hl3J8YFw7+iooCYgLz3LwxaMuczy2GXAI9mjoDz0fMmcIQuJ87qT9X63vQBaD3jYkRe
         CbRX2T3gACTy14wuMFhBuH0+PihSAYSO4v4TO52wAEh1sIPBDomVs5qcbIxJp3ArSR4B
         aGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732323318; x=1732928118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejdsA3LiRT1wCslfDraOcPVuluASa+i3xrjQ0MCRvvA=;
        b=FT9ZUwbLPvVfnI2dOi4VknEOms4OwML+ZH42uMxr2QPJVC96Oc3PVhSq5w8EXY4/Uj
         M9hfYMDCUxQoDfO1AloMNM3bPqPK9d8PuTFJGuEMtfzA61bAOKtviQJlwRaUhGyH6pE+
         BOl+PQIFRh5NoQ+sYACrsh/Q+Fn4C5pjJhCch7R2dGHjH8czog5F/WXPP/B/xdey1Hak
         X/QLpkFmQpqSxWXfrkFxUjDiD/7Q7JyInhZObccOsCLZmJ8NYc6dxfib8OFuW9oqozXX
         WCNoG/Rz2mQ16WhflKWmq9h4Kq71AAqrjz0Kcf+KMewVFf3UEnccb25vw9UumCmLsRQp
         sTlg==
X-Forwarded-Encrypted: i=1; AJvYcCUxoEqQ8rd/JMqiZGCO0kVZS4t/6THIx7Unf6M6u0RRZMG1ndk28KVpquTefbdanW3LtLr1Hd8vniaMbSwlyr+q9Q==@vger.kernel.org, AJvYcCVq+OkmM4X1EEzc5Q0Ua+SXaXY3ySlfwbu+SQ2eEIxqvJ/t/dDvlU92TLfL3uvCjLdOqQ9IyodOOJmbfmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0XmJxcaMOYgXZttf5rNdq6SK5x8uzK7rxoboLEWjMLhP9we6R
	UEEJ5+t2TzDEO9PLBZkK5EUQlodoynivpXO29Crh0ZweX0a4c59hCu3ewz9u
X-Gm-Gg: ASbGncsKjphKSb7UhgMLdZ3RqDLPaNuwoTdiIcZbh7xVglkbs3lC9aswi7xcJlWnLHs
	KnrQID0rZ+6CLUAekL/VS0Zi0g3FqqsSH0PRC2sIrozsGlV8Q91tUxKr/ivssbaoNo5psQ7OFWK
	ym4Jp3yjA4lR/8u81thBE9D/V1H/cSZUXzedjY0xTe56VWzAkdx8QwZLy4UcpXZel+LkxGUNtk5
	uvzHN8zsbH7vbuqa1gKGoMISzM3d4jll6mrLIBTmDZNp4g3WIX1v1T54PN0+i3qf6SeWoJMDMZJ
	F7wwe5oT2ic=
X-Google-Smtp-Source: AGHT+IFECUQrY1PqQBjx6eZQTQWb31fPPRpP8glEu3Tcra629kQnFYugOKM53nHwXDr4ZCNRPfzHMg==
X-Received: by 2002:a05:6a20:244b:b0:1db:e327:dd82 with SMTP id adf61e73a8af0-1e09d5aff8amr7888595637.5.1732323318555;
        Fri, 22 Nov 2024 16:55:18 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e0fca304sm2082867b3a.175.2024.11.22.16.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 16:55:18 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 2/2] perf docs: Add documentation for --force-btf option
Date: Fri, 22 Nov 2024 16:55:11 -0800
Message-ID: <20241123005512.342079-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241123005512.342079-1-howardchu95@gmail.com>
References: <20241123005512.342079-1-howardchu95@gmail.com>
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
 tools/perf/Documentation/perf-trace.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 6e0cc50bbc13..529081599cc7 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -241,6 +241,9 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	printing using the existing 'perf trace' syscall arg beautifiers to map integer
 	arguments to strings (pid to comm, syscall id to syscall name, etc).
 
+--force-btf::
+	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty printers.
+
 
 PAGEFAULTS
 ----------
-- 
2.43.0

