Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349377;
	b=QreyinOf0qVShGm6XhPhGS6uGhIj5ujiMuGgTkqxQ/TlvW5rheUykPyJnEhhFrYfJX1b
	 sWG+WScvpwlem3kltNgRjAD3H9OgDIsHY8vZaTycaazmhkXuX/Vx1keV1t/UID1Tjj1bB
	 /U89ZM5RQPvrnEbRg4yj9VenQqPfzaXUGmu1hNBeCUqn7+TG1dSn8ojuJv39+MiWUPYEV
	 8L4TZZWMpg98OkOEe1APLILoH7SlBKyBTXibdYVC3uASUl17BVXoc1vS66NbcvxXUqlnn
	 +/ddgxtqz0gPFgp0XCY95jNEKIwdC3tn3X+rmkAxzVtc/QUkeq1N15s3gTqNjhI5LBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZY/yXrMk9KshKJitniBsyfv4SHkHHsRLReltZI/KTmM=;
	b=APZ6qZF8k6waO8pu9E687x32bq5OpmkaJj1Ft+hAAqHV2Wyttwpl/RhWgUTSxTX+GX8z
	 r+6koJSPYuRaziyqrCEjED6CjvaH7Uvq3SZh12rFWqgvfhG6LpVDm/+huGU6NJHp4Wbj6
	 Fh5IniN1XinyZJe4aEWEX+GHq0lrSQ/q4T9fUnisworULkuY+4EZ/XgG0H/vg1ZBAuHtn
	 XWjbGZF6m83En2h6b/HERf5cF6A0dif4baYKDuefzBu4mmMQjoAklA7T4snWaTJq7cZVZ
	 gAUakGPshrX1Za0rsVQ4Tbq+/hz5ei8A4/c7tdK9lBt98sN5Mg95IHQZbD2NvjZsmcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cs7rbqsT;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A3606A32D
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 540A3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cs7rbqsT
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37000e7234bso4901227eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349376; x=1794954176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZY/yXrMk9KshKJitniBsyfv4SHkHHsRLReltZI/KTmM=;
        b=cs7rbqsTIr2PcpfPqWX7xCXFi2IGJVT8V+lmpG9xUs1NLOO/p+v86woVPCeANzEjYg
         fXWFhrDbf5A07gj4wHUjp15xY6LKd/EoTTWe0SCXeXYnISWLxtzBkN5NYr9y7Viug9v9
         4upk8vfPAEHpWwJjVfgXs4fA0Ul3Y256RdriVapt/CiiMjAkXeozxiEXmJiAxOBxFq2k
         +olTw8satupFYatARmPjN/AzAcQyU54Iuw0P88Ht+5BIG+s2rpDwTtF8fNbVVy889DR1
         5nRr+RwGxMLADNdvlPMtI/9NnLba3mBuyNgL1VasKZi67Sh3ragvqvqJ5Df0RYcvOqCz
         JL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349376; x=1794954176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZY/yXrMk9KshKJitniBsyfv4SHkHHsRLReltZI/KTmM=;
        b=JsHen3aWjhMCyWW0uEXqaO/uoHMQ7vz5b6HIzYTeGRqXmyDwqttrrNbMlkM3OTKYKT
         ssReK1WRxafwFiaWBgUyFZgSl53CSD9buEIgNk5QhPxdCuN8r6xYzZ/tY9Gx3qotHNXa
         qV0ObTT4u8mOCrBTHwhId6iN1ob0lN2zPlPLe+hSwO4C+niU0RohTJOSW9+RshGnfIXn
         gfe6v82FwVQkdwIgn9bjFNsvZUhpmFhfy/qJj+ZyZJOwvoq2GAKJEW2wk6nnFCbjKQhx
         m60JKNujx4C0y1oz1OAsEsz8LbtWQTSWS/bTyoHW6JlAk2F6II5HRYyRPQeKJqzcz0F9
         NkbA==
X-Gm-Message-State: APuU4Z8DryvvxIDfoNe+C27yZtLyJAg4ElJMnbItBMgfpAwTUjt6MtJ7
	j6gC2dKDG5XOaiCXL0xb3R7+5iOTL//IjXbJi6l4B2XxqCPeA4i9GXo2qgU7/kCH
X-Gm-Gg: AYBFou01ugC4IyPOD5b/7WvLv1Uo+86wpX4orr//jihRZ3nIjK8D5uJ5bov/DIXi+hc
	WNT6iKsn+fhz4qYJ1pVxFIEvZsYoOzolZ/ZSc73eEZEiNMm6is2QjDij7F+4sG++XCAC36GrDho
	5Lk12ac6VqroumbytFdGqVDa1Dzuad5DjVoRORyigMkFtEDNh9AWVGrKqsd5GNyK4eiCqdfC5ml
	OBWPZ3Qyh2SVGIlPzAAHEcpZiQ5vkL5h0MbDgVvoS1azhCJkEW6psFVup400mRtzEj40L7P2U0A
	qF/gDo4gyR5rsq8G0OsE8Bx/LNDxqQuW6MgzrIiiBurxKCq31QIBxxdh+Y6/Cv/ke/mQX0YvQaG
	lZNGGiiENIV/mKaf0Xx6QVoULISaeuldAE7Xmixefc0Eg4Dg/htFPVQvhyG/jHuTuSr6N/xzUN/
	ZL2PG4kJizzIY7aH48XMAlfqnbjcss0U7FNXvxJiNR+897iBY4XTFpmd/z7q3hhfEeu0fLlHH93
	0xxLdsSZkJKLXdSNQXJRPGbQwxG3wgd9G2sMT16K/LH/Gnjo7vS0QwENSshXcwMWtntIQOgJ5Ud
	6VBTqlAdR/WZpkoXYg3f
X-Received: by 2002:a05:7300:7316:b0:372:b76a:6fba with SMTP id 5a478bee46e88-37686278be4mr1451750eec.14.1794349376287;
        Tue, 10 Nov 2026 14:22:56 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512b6asm9165030eec.10.2026.11.10.14.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:22:55 -0800 (PST)
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
Subject: [PATCH 1/3] perf jevents: Name the metric when a MetricExpr is missing
Date: Tue, 10 Nov 2026 22:22:48 +0000
Message-ID: <20261110222250.1864777-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110222250.1864777-1-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
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

