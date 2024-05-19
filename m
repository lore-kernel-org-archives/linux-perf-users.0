Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F642770C
	for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716142643; cv=none; b=kFmG+LFEHYMJydSCUCoA6QH/l58bh6lA8Hjl2qk19b8hNqIoBLwBh0fc4+bDEbozO7kKA6t8dm/IAVGVx2GZ4U7GQhAyGksljZWHfkqfmQDYqPk1PU7BaYv0H4VceDXrVZVD+fZptfNyyZoOz5qMRG1PjNO4Na73mkviv8lvYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716142643; c=relaxed/simple;
	bh=2s5g+zwfMTvziUNuBm+f7vvR7h8jdexplwL+ieGhwOU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=LphbM1OGNSufT5knZmAdLr73r6+sR/78sVxeyclzw4GBFMeeMZ27w7XeiELk+aaBRbye3eIhtJHSEzD3TZ/80Ffc/WICnIaN24752yT2asafykWf/jc9vrJej0LnxHXD/6gDyjdTtEJ4YUkOdzgLMmR5SZdowVo3iwdiUxV37K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mm7zhmJ+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mm7zhmJ+"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so23845028276.2
        for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716142641; x=1716747441; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EF57d/oSo3Tiz1+Ri035kfCFIPne1iVfqsIeBXpa+mA=;
        b=mm7zhmJ+Dn7S9KUFk/8y22EXpiq3lQgY89mQ3tj51qB42iZ3lA/MD7Vu5rVAzZ0AUQ
         mujjAhEGTnM3z7aULDG9KNk3sRsHZP73X+Fe8CsUw/P4v6Ntsx82aYRIiKXesl7EEPMp
         PxTmux3cePpZuiPfOQ1mMSsc+KvSXBvD0UQ1pV9Ou/FwZowOBmmB0+5EDppq4OijGio/
         DmKl6MoKbVI5E1uWT1uiZiORb/fmnVOHqNaiN1D4gkS0dRxP9GWQuffP8+/bpxSfCU+m
         2HqO+R43/8eBONn3Ue40HxBwvZ73tDjqzh3eHwo9xCufkK+jIASnxIOfJRAmqOAPdtaJ
         1SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716142641; x=1716747441;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EF57d/oSo3Tiz1+Ri035kfCFIPne1iVfqsIeBXpa+mA=;
        b=KsON9ifcwV7OlbWFAHxi5ZNOsMTKiB/XCRNHlSoaHVzPjQz4Lfjz5Yh1kh35+crvSy
         LG5kqukzWgjUCvdJdvGw12SvoQdCu/7KnDG+TMmYbAj1EFjLXapXqZbzmFdpeQexB7Y0
         3BR9gjlGEIKlVQGI30K1sC8ow/RzeLnpR1vbq+XaH0MSByud/DpfTKYkPVz6V7ZM0b1w
         H+aroVgrCVlIZjaxywo8JhX4s3Mqo03tk9PNwWa3XjgZQ+QVWEFllWpXw3fF3Bs+P6i3
         BpdPRgnplrH9/OrzPYq1mHc1Yz8T99JtNxOUidO4PtVfEcBqKLn+N1JRmX5a65BCpV69
         Ac3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx2KCnQCjOQsMKyGghUCnv0qRI4ixgvY0NklLMWBaIVm/PNBRkG6fkcHazrLtQhdyls5wQQa4os9Z8iRcwVvhBTX1rCRA3UclnbdOZ0ba7Og==
X-Gm-Message-State: AOJu0YxXX81yko6jM+j/A5OfDKjjB5Siqd56astvDxLuH0v85uIqHajt
	Wif6Zbn6oEFhsJESCDW2q8/uw8yFWfsHV+b8qLFy5uYrcMLCs4rgNVIZ27/P3XeS9pBK5HStc8a
	CPEsMfg==
X-Google-Smtp-Source: AGHT+IFX2CyWCwQfx/kdQYayR3AJIKR/mn3cf14Llmu17FFVI55/2e1typh2ueAzDGhVlMaDIzn64DxLf7cw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b6d:77c7:e6ad:c2a7])
 (user=irogers job=sendgmr) by 2002:a05:6902:114d:b0:df4:97ab:3673 with SMTP
 id 3f1490d57ef6-df497ab39b3mr1174299276.5.1716142641040; Sun, 19 May 2024
 11:17:21 -0700 (PDT)
Date: Sun, 19 May 2024 11:17:16 -0700
Message-Id: <20240519181716.4088459-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] tools api io: Move filling the io buffer to its own function
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

In general a read fills 4kb so filling the buffer is a 1 in 4096
operation, move it out of the io__get_char function to avoid some
checking overhead and to better hint the function is good to inline.

For perf's IO intensive internal (non-rigorous) benchmarks there's a
near 8% improvement to kallsyms-parsing with a default build.

Before:
```
$ perf bench internals all
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 146.322 usec (+- 0.305 usec)
  Average num. events: 61.000 (+- 0.000)
  Average time per event 2.399 usec
  Average data synthesis took: 145.056 usec (+- 0.155 usec)
  Average num. events: 329.000 (+- 0.000)
  Average time per event 0.441 usec

  Average kallsyms__parse took: 162.313 ms (+- 0.599 ms)
...
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 53.720 usec (+- 7.823 usec)
  Average PMU scanning took: 375.145 usec (+- 23.974 usec)
```
After:
```
$ perf bench internals all
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 127.829 usec (+- 0.079 usec)
  Average num. events: 61.000 (+- 0.000)
  Average time per event 2.096 usec
  Average data synthesis took: 133.652 usec (+- 0.101 usec)
  Average num. events: 327.000 (+- 0.000)
  Average time per event 0.409 usec

  Average kallsyms__parse took: 150.415 ms (+- 0.313 ms)
...
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 47.790 usec (+- 1.178 usec)
  Average PMU scanning took: 376.945 usec (+- 23.683 usec)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 69 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index 84adf8102018..d3eb04d1bc89 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -43,48 +43,55 @@ static inline void io__init(struct io *io, int fd,
 	io->eof = false;
 }
 
-/* Reads one character from the "io" file with similar semantics to fgetc. */
-static inline int io__get_char(struct io *io)
+/* Read from fd filling the buffer. Called when io->data == io->end. */
+static inline int io__fill_buffer(struct io *io)
 {
-	char *ptr = io->data;
+	ssize_t n;
 
 	if (io->eof)
 		return -1;
 
-	if (ptr == io->end) {
-		ssize_t n;
-
-		if (io->timeout_ms != 0) {
-			struct pollfd pfds[] = {
-				{
-					.fd = io->fd,
-					.events = POLLIN,
-				},
-			};
-
-			n = poll(pfds, 1, io->timeout_ms);
-			if (n == 0)
-				errno = ETIMEDOUT;
-			if (n > 0 && !(pfds[0].revents & POLLIN)) {
-				errno = EIO;
-				n = -1;
-			}
-			if (n <= 0) {
-				io->eof = true;
-				return -1;
-			}
+	if (io->timeout_ms != 0) {
+		struct pollfd pfds[] = {
+			{
+				.fd = io->fd,
+				.events = POLLIN,
+			},
+		};
+
+		n = poll(pfds, 1, io->timeout_ms);
+		if (n == 0)
+			errno = ETIMEDOUT;
+		if (n > 0 && !(pfds[0].revents & POLLIN)) {
+			errno = EIO;
+			n = -1;
 		}
-		n = read(io->fd, io->buf, io->buf_len);
-
 		if (n <= 0) {
 			io->eof = true;
 			return -1;
 		}
-		ptr = &io->buf[0];
-		io->end = &io->buf[n];
 	}
-	io->data = ptr + 1;
-	return *ptr;
+	n = read(io->fd, io->buf, io->buf_len);
+
+	if (n <= 0) {
+		io->eof = true;
+		return -1;
+	}
+	io->data = &io->buf[0];
+	io->end = &io->buf[n];
+	return 0;
+}
+
+/* Reads one character from the "io" file with similar semantics to fgetc. */
+static inline int io__get_char(struct io *io)
+{
+	if (io->data == io->end) {
+		int ret = io__fill_buffer(io);
+
+		if (ret)
+			return ret;
+	}
+	return *io->data++;
 }
 
 /* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

