Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364495;
	b=fwjCCZtgUn5xMoIyjyC8xporHo+D7Ixgdy/FF00c9Azl/CYKWeBauN+T3e3WwFFqlyzY
	 7RCMfge4wuVNczapOel4Lpyu4XhjHTvxOh6aH39dobTo01Z9IzShbs33ryrWuZf9YvuIi
	 /4+srp2FKC1bm2bi5IiywxcGC/8S8Lfz2NJhM7a1KXSmxbDXVgp1r9CQqpnflDUfsoiTD
	 lOJIeqQJ1nupEPMrNoWqAKffj6O41ksS64uWP029OAEDkdXrITLtOGPCvy+ecgq2KcOEw
	 YJmPSH8oOpR3YRpIAmc6KQh6qWdI95vklWAgt1Q59S8PpsOUjLBm1oLoZH5Ij/aH1mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZY/yXrMk9KshKJitniBsyfv4SHkHHsRLReltZI/KTmM=;
	b=EKj52vn8Du43EuzIxe4mC2rhak3h6hM+bP/q9QJH7g/4YhkW471l5BXaaYrqlQKlzOa5
	 TKnVdydtHX0KYofIsw0+puTQusr+gL+H3SaYT+z8uwanlzJBEYS9lXHiMnf2QlBWwumvU
	 KzbRMlR1aooZOuPGLZwEM4NwiFc21tKcrdhcR0trAE1oCJ2lg6dBdxDldFtEm9N8XJKzH
	 7rNIQcFycTggI+7GQ4taWTK8Xd7zWjuBoY4u6K6uU1ApgfgfSmamQxrfUduhpMXZ2oti0
	 12PRXvEAnHaAETXY64/lBBsqvdmuRe+ySvf+T4gLjoWeT9CH6Z4gcoPdS9TNWoDTtMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TAe1lMoJ;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92F606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA92F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TAe1lMoJ
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5524757eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794364494; x=1794969294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZY/yXrMk9KshKJitniBsyfv4SHkHHsRLReltZI/KTmM=;
        b=TAe1lMoJh46WtDwrffmktGuTNKEpSjONxHx7b6ts+iMpyQbXe7IrgEvNbgjuAJaerX
         fwK/004hKHG0ceE9Mf3xgOVUb2jjBzcIvs2i4fMOvTWQKCEz8aeSWN62jT+e8w9px7ng
         yCYoyWyEFaiI0zVJQVbEuDQcV2GbzClOoTb6Ssd8XCXwibQihSaNyigPMcs7TsZHUlfP
         nSu4beApA6PKG8qaG1tY3UJs2O1/dJJmDReK50xc4JDVJSQLn/VuCDtmDC2allGiItz7
         oh5x7wYZnoJtUYHxVBduJrv/Ct3N9fQroxcYxRyZecFyp4EJ34+3Rit+X7tOqZIs4Y1o
         b1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364494; x=1794969294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZY/yXrMk9KshKJitniBsyfv4SHkHHsRLReltZI/KTmM=;
        b=kHf7KSrqzDweLrpNTuTAvxm50IJ7Vgd1Z+3vNDWrPRzxIQ3l1JNbWy3z3Hn4Durrsm
         XsD2gKku4AROcgHCbiogtbsug7pmObj6DmcXcgtcJNxnJkvIuXLUXUVomItSL9kEY97k
         ouHQODnhokH1cicWuti+uVAGhjf9R+mLxyGNKQwYYqh925+qyqul0pPgrNdg0cyU36vx
         uyvqhBF7Cr2Hc8U8HKKe3tDYp9O3nM+9R6XXWKIobmfFy4DuEySKtHNavKBKqaIlWe+J
         mEC6bztnvN+zHoAK5xfmJZRJw1cxTFmzF35rwGHWneNwcs44SDy+iIMssi1ZRG4mBzP2
         /2aQ==
X-Gm-Message-State: APuU4Z9QxHKBQrAYe7nOujMQn1ywZL8+6cjcLU75tj6kdkQmHAUNUOqT
	33QEZXDhSFlzWwh7bcRBQoeldDMk+FLVLnn99HCwnN/WFGnkaUAEBPbHTbMXInC8
X-Gm-Gg: AYBFou14DAeGxfP8hIJGlrRWA6ffKdyCJ5bLXBWM28lWdJUFHOoVe3+6MyTsUZDWBN+
	uGWG8cwMrVLv8/gVXMJwt1Rdmk8WZvsJllpHVBFyNJCRZhK5MjTwyGWofLyN2etNWBYnVhamQtb
	YPafP/YX3wyWUyQmvOTM7VotPjMdLliY1bP3c23Iyv26NhM2i5YLshZjPiNqtFv1XU7t8Ez9/s9
	kqExfRLAs6ZF+QhGGMXyBuXCd8jhYIWYxcSVzKsw/ZZS3VyDgefARqhOztjQez2ybq64C+hX50l
	8bhisVUxzHhIH9PK6wdRJeblFV1foUxSCGYlNYtcQs7eiAkwh1qLTof7bu31wW9NvB1n99obcqC
	7uGlSeToQIgX/R+6oEk/mNbHNdBH18ZTuFpEsk8bLB1rfcIvpUjI3QjUXmo++a7kx9GGTfKYtYg
	c7wtLv4mhPOpEbWBO9EaSDmAjnT4i6+QPnpsQBXQ9pNxSr6QZ5hl8OL9ZHmQ0GN9/F39czc5EQM
	ZN9wYEAtdVuSsZAZqd+PWtwxU/Yyxb7bm7l6DD5dJhnrQuG3JSRE9fbxo4YmBNaIh7umkym2mpa
	Mhfu+/iESqmQrS0pji8B
X-Received: by 2002:a05:7022:1184:b0:1b2:6b1f:1d89 with SMTP id a92af1059eb24-1b3c0360627mr960969c88.36.1794364493779;
        Tue, 10 Nov 2026 18:34:53 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm11752369c88.4.2026.11.10.18.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:34:53 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/3] perf jevents: Name the metric when a MetricExpr is missing
Date: Wed, 11 Nov 2026 02:34:46 +0000
Message-ID: <20261111023448.1970467-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111023448.1970467-1-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
 <20261111023448.1970467-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

jevents.py reads each field it wants out of a JSON object by name, so a
MetricExpr key that is missing or spelled another way leaves the object
with a MetricName and no expression. Two different failures followed,
neither of which named the metric: the rewrite in _read_json_events_impl()
raised AttributeError on the None, and a metric that got that far reached
print_pending_metrics(), whose assert fired on it.

Raise in the reader instead, naming the metric, before either of them can
happen. The check is not inside the '-' test that decides whether a metric
takes part in the rewrite: a name with a dash in it can lose its
expression the same way.

Two smaller changes on the same path:

- An architecture standard table that does not parse now carries the
   reason in its message ("Failure processing '<file>' in '<dir>':
   <cause>").  The traceback used to end with the file name alone, and
   only the chained exception said why.

- A table that does not parse is reported on stderr with a "jevents:
   error:" prefix instead of on stdout, where it was mixed with the
   generated output.

And the output file is opened after the tables have been read, and not by
argparse, so a build that fails while reading them leaves a file the
caller named as it was instead of truncating it to the header.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/pmu-events/jevents.py | 35 ++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..86060a228b75 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -460,11 +460,17 @@ def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
     with open(path, encoding='utf-8') as f:
       events = json.load(f, object_hook=JsonEvent)
   except BaseException:
-    print(f"Exception processing {path}")
+    print(f'jevents: error: Exception processing {path}', file=sys.stderr)
     raise
   metrics: list[Tuple[str, str, metric.Expression]] = []
   for event in events:
     event.topic = topic
+    if event.metric_name and event.metric_expr is None:
+      # A MetricName without a MetricExpr leaves nothing to put in the
+      # generated tables, whether or not the name has a dash, so the build
+      # must not go on.  Name the metric instead of letting the table printer
+      # assert on the None.
+      raise RuntimeError(f'Metric {event.metric_name!r} has no MetricExpr')
     if event.metric_name and '-' not in event.metric_name:
       metrics.append((event.pmu, event.metric_name, event.metric_expr))
   updates = metric.RewriteMetricsInTermsOfOthers(metrics)
@@ -493,7 +499,7 @@ def preprocess_arch_std_files(archpath: str) -> None:
         if event.metric_name:
           _arch_std_events[event.metric_name.lower()] = event
     except Exception as e:
-        raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\'') from e
+      raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\': {e}') from e
 
 
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
@@ -1490,12 +1496,29 @@ such as "arm/cortex-a34".''',
       type=dir_path,
       help='Root of tree containing architecture directories containing json files'
   )
-  ap.add_argument(
-      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
-  ap.add_argument(
-      'output_string_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=None)
+  ap.add_argument('output_file', nargs='?', default=None,
+                  help='file to write the tables to, default standard output')
+  ap.add_argument('output_string_file', nargs='?', default=None,
+                  help='file to write big_c_string to when it is to be kept '
+                       'apart from the tables')
   _args = ap.parse_args()
 
+  # Opened here, and not by argparse, so that a failure before the tables are
+  # written cannot empty a file the caller named.
+  if _args.output_file in (None, '-'):
+    _args.output_file = sys.stdout
+  else:
+    try:
+      _args.output_file = open(_args.output_file, 'w', encoding='utf-8')
+    except OSError as e:
+      ap.error(f'argument output_file: {e}')
+  if _args.output_string_file == '-':
+    _args.output_string_file = sys.stdout
+  elif _args.output_string_file is not None:
+    try:
+      _args.output_string_file = open(_args.output_string_file, 'w', encoding='utf-8')
+    except OSError as e:
+      ap.error(f'argument output_string_file: {e}')
   _args.output_file.write(f"""/* SPDX-License-Identifier: GPL-2.0 */
 /* THIS FILE WAS AUTOGENERATED BY `jevents.py arch={_args.arch} model={_args.model}` ! */
 """)
-- 
2.53.0

