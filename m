Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3F38655B
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661982; cv=none; b=KTdJKqYgqjJRkKX2U+k9WXk5XBlDZ619RiehYPkzsXP4yduk+dtN2nt5FlbW37CEVVS3pQRmgBCewTzoOkXudXuJEZkAvnq5tBrJZvCnBTpPkWqw70yAaLQgCX6yPq3mqYqRWsdBWboq4ywXa1lLFVrrEac3jtIaiedO0YprXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661982; c=relaxed/simple;
	bh=yuMz0ge9CxROdg9d/rhENLUJSm7qK1HsPWBNR2i00as=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=GZY6qw3iUoIdwAhX+OSP6lmoU7PfzQYcGR8dnnIo57x5rUL96W3n4sRxc627D3MG0cJnB96nTvq1EIkYAaZzuZnprQjxElBDKjPTc+mFvIPz38Cs05XApcaQRWpY/CcKX35iAbf5Vji0sbgW4UAlbfEom2fbrBwdJDDLIeTt3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKyqsC/U; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKyqsC/U"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so804980a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661981; x=1784266781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXKB5RFSzGqwOKMw3ixSEVDUQBZ0n7Bw5ofVnr463o4=;
        b=ZKyqsC/U/uKSOGRr0FooOPFylWFEuIZgG+LbcS5aLiQTeA80xEHfIyFyGRcsf3e+eg
         OADU2jTOU9MI85J9bg7zcTfe4WGohYGvOqCmoQ3EnvQCrT/LwsbWCwUhxFZdSvfSIakw
         t75d0zfCcd9B8un8teC1QkijrdEaLrbZZjq4rSajxfHOYOFeH4bIZplmiFBTic+YWsK3
         kQLB+p+2wnhhOAdfnH5msX71LxNiPQHDXDnFXcgSYvuVtc+bbPBSa7DIOtcBGtcXu5S+
         fm6wh00rMuXIwgfNPUBWX6CFMLgDEDjwNYr+OdYiq+g1Otr7lpawZowszmjr02tMiUXH
         FF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661981; x=1784266781;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gXKB5RFSzGqwOKMw3ixSEVDUQBZ0n7Bw5ofVnr463o4=;
        b=R/9nLjtVwGS+Et2fXs/qnwdqOz+ERG68Ee4lROpVg3mKT7pK2KfFhPnoAjJ6WrsgHt
         mgWWexUKyvZcctK0FDmAAURMdeJvYKZf2LZWbyGkLa/rJkYL5MaHyye2FpALA3G4hQr7
         M4MQERWCvz8mApv31bnoW2XfdUd63klm2viClG5LWFQIeKyPyeRGSLLgXHgcPL7CnQsj
         72pf8dg1q3jFQvEK0PqsOrZ7w2pBlyixTsJ33mUHmTHB14sOfWP4Ux6pn5wm5qE35pWB
         KcgFMkYEbj8fPGTvvZi9VBuP4ZJGXTIBBdhqlN52hqUR7y4v1GtLb97w6T9+1lvNBdif
         dgqw==
X-Forwarded-Encrypted: i=1; AHgh+Rorhf4zeldIyuC6bFtj4o6LFnQFmC7IbUiGAxy6eKlteDtmxWw6+E2itc+7cgWnqlc8zB0EOPJqDToBfQAnldcC@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/85HjpmTTMqQjvS43fQFpYUaL9TjoXEqFQmoQ6CkANq41kcw
	ZMUXrik8Mw82thsnY16+2YEy8BNWiUjpF8q3ENdHQb/LcksDR0+Nt5DbZdLWutWjXTraECbRzuv
	G4YvEjmGYUQ==
X-Received: from dli7-n1.prod.google.com ([2002:a05:7022:287:10b0:13b:848c:abaf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918e:b0:3bf:7f0b:2f6e
 with SMTP id adf61e73a8af0-3c0bcbc9d49mr12541865637.46.1783661980778; Thu, 09
 Jul 2026 22:39:40 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:39:06 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053927.1864021-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf record: Fix teardown hang on system-wide
 multi-threaded sessions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiawei Sun <abyssmystery@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Under system-wide (-a) parallel streaming mode (--threads=3Dcpu),
background recording threads can be inundated by a continuous
firehose of hardware samples generated by the OS. In this state,
a background thread's local hit count remains unequal to its
sample count, causing it to bypass the blocking fdarray__poll()
call entirely on each iteration of its recording loop.

Because the termination check relies on the POLLHUP event status
populated specifically by fdarray__poll(), bypassing it prevents
the background thread from ever recognizing that its control pipe
was closed by the main thread. This traps the background thread
in an infinite recording loop, hanging the main thread indefinitely
as it awaits a termination acknowledgment that never arrives.

Ensure teardown completion by adding explicit evlist__disable()
calls in the main thread's cleanup paths at out_child: and
out_child_no_flush:. Additionally, patch fdarray__filter() to
respect the fdarray_flag__nonfilterable flag, preventing it
from incorrectly setting the background thread's control pipe
file descriptor to -1 and clearing its revents mask upon
processing termination POLLHUP signals.

Fixes: f94563fac269 ("perf record: fix poll storm when monitored threads ex=
it")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fd/array.c    | 6 ++++--
 tools/perf/builtin-record.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index ffe8272af59b..16a047f1906e 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -115,6 +115,9 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
=20
 	for (fd =3D 0; fd < fda->nr; ++fd) {
+		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
+			continue;
+
 		if (!fda->entries[fd].events)
 			continue;
=20
@@ -132,8 +135,7 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			continue;
 		}
=20
-		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
-			++nr;
+		++nr;
 	}
=20
 	return nr;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ebd3ed0c9b3e..d1276382b77a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2890,11 +2890,13 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
 		record__synthesize_workload(rec, true);
=20
 out_child:
+	evlist__disable(rec->evlist);
 	record__stop_threads(rec);
 	record__mmap_read_all(rec, true);
 	goto out_free_threads;
 out_child_no_flush:
 	/* mmap read already failed =E2=80=94 retrying would just fail again */
+	evlist__disable(rec->evlist);
 	record__stop_threads(rec);
 out_free_threads:
 	record__free_thread_data(rec);
--=20
2.55.0.795.g602f6c329a-goog

