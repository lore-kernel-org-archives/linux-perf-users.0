Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490983;
	b=gxrnEc4uTpzG/nZf7jZKHzBA7XVQHHjRS2LHO/Xk/u0kOjhAGrgJZRE+ypDoY2y6fsAO
	 OsmUplXAonHylDL/zkG1OFVW5qG2PgxFyG3IR4IGZ2kXZCw4GWlkuD8mzoDzq8WagnQGR
	 OJ7jNhWYIrJzp+42D4c69bPFOdrPkPaO7ph4faGomhmmpsfzoNGyQzP3Dj0P8hftnGkmf
	 SAfql+D2AroDPY3JAU0yUj3dFqqETrpSnOi4FE6JO3UIVZziVAhZiTTUB/FXf6MwNz4Qi
	 k3N/BpPwcQEv/kugdO3EUjHd6ixnHO7Yk9Q7u1c/ATTHCUofrJaSeEa4P1By3Mkn5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RC+AB1O9VAsGYWgvn7uFvsnrABTphbVpW5Y+d70Dgm0=;
	b=FNZBELVNUHBD54US8AnVqMe0K/w4f+e+p98uPemq3upobXRMqIlHH8Rg3ZhWld7y68gy
	 lxdrkon9+tceA3mXjvA7JHUO51E5s1uDO2fG7hG5sWsU2hLMJ9NJYhRZITDXxqo3KQdIz
	 ZhM8iNKbJxu7i5kM2HdFCWJ4YX6z/FNz2ZetmiUj4qjrrRpPo2H0HYisKgwPE/ppJVD5F
	 ZA8ijcNvypKeZnee5vRzgvIq+49Srbk3ERo+xlOlZur3VRKjZ5PpmdV1b37YC30qw/xZa
	 Kyo6dVIPOc27T1HCuuMOyV2hMnLtB0mPdSXrlXvfagae3kjtSz8LYLaNCAg76AppEkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Crcl1aDR;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4B606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF4B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Crcl1aDR
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-383ec96a7deso4580666eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490982; x=1796095782; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RC+AB1O9VAsGYWgvn7uFvsnrABTphbVpW5Y+d70Dgm0=;
        b=Crcl1aDR9pSf1cGXXszRl1+K00LhwKmkzhpxiGsLjo4LqmarP7RmJlUNh2epO1ip+b
         VVPxVmYx2HFGSGux2+YX14zevdxjVefedB3ladQPJ+0piaF9rgj3vnYhN29WZ2sOC+zh
         UeEbJfGisgjXICCLCqMO2MJFuDIMuPtTwlg+BwjCuEwby2PPDmuJI4D5ORqtx+MIEYhH
         hrjyabUYJt+iufpQ1jk4/cjJbxImGFRBAsICnFDmMt0zdlguK5+6bfjwuZqdBQNF2Oez
         I+0RxDoAaC7FA5DCjO9yOju7C1XC/3lOaC61GSeVwauEr9GgyGs1o+Gjd2GuA21lsh7Y
         9nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490982; x=1796095782;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RC+AB1O9VAsGYWgvn7uFvsnrABTphbVpW5Y+d70Dgm0=;
        b=zkULCqA4k3AvybMZRkyFmqwnGzWhQBWYHzwnr60ySkYmmSLHCJTfcyl2ZdzGnTdAxB
         hVTDlLQ2w9AXA8xqWprmzskBLvQH+FUIieT3RF83KfA4VHfRsW/NYVGTTJj1p0qpzhj0
         J9eAIWzdCwY+2ZvqSFd2Ep6ckZ2fQjRUKzeoUkzAWGDdJRu4Q+Za/N12vHlgALOsiZdN
         GAeQCAcWoDAInwEYNf9FzxABTjYZo4d829I4nwCOIZabNGW/ovNHBl1g2AKF6YLzz3p9
         Q87BZhPaMXP3RQqAaoC3XD9fkKzL1Y4bNwOZz3olq5aQCsQONR1zFzCxKHdvIglvqTQE
         +3iQ==
X-Forwarded-Encrypted: i=1; AL+hErEscGSxEuX1sjSO21oD+80PJ9sB6RLBVUkYThYR1vhkR+nmBdZ7yrBDJ6nXZ1DLJsxXntoDIi8Sr1eY4sWQcNLj@vger.kernel.org
X-Gm-Message-State: APuU4Z+5o56e+7ej2xvMf8eFX0VuA/8ZN7K9DNFTrbPd4fkwXtbzjnbB
	1LDNHS3VTrfQYF1EiMehgx54oce2c7t9xyKR3Olx3/+ecJucFwGM8ch0IVtSR1VXrPG43Z97/H9
	LeQ0OfsCNiw==
X-Received: from dybgk2.prod.google.com ([2002:a05:7301:182:b0:385:e49a:dd09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4301:b0:386:548e:e533
 with SMTP id 5a478bee46e88-386548ee6c3mr12731053eec.18.1795490981904; Mon, 23
 Nov 2026 19:29:41 -0800 (PST)
Date: Mon, 23 Nov 2026 19:28:59 -0800
In-Reply-To: <20261124032902.3859564-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124032902.3859564-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124032902.3859564-9-irogers@google.com>
Subject: [PATCH v9 08/11] perf session: Add dsos, machine, and perf_session shrinking
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add container-level shrinking helpers walking DSOs across a session's host
and guest machines:
- dsos__shrink(): Calls dso__shrink() and dso__try_evict() across all DSOs
  under dsos->lock, compacts the array when unreferenced DSOs are evicted,
  and calls malloc_trim(0) on glibc when memory was reclaimed.
- machine__shrink(), machines__shrink(), and perf_session__shrink():
  Shrink host and guest machine DSO collections.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c    | 50 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/dsos.h    |  2 ++
 tools/perf/util/machine.c | 29 +++++++++++++++++++++++
 tools/perf/util/machine.h |  3 +++
 tools/perf/util/session.c |  8 +++++++
 tools/perf/util/session.h |  2 ++
 6 files changed, 94 insertions(+)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 7a56577f4ec8..77f668d7557c 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -6,6 +6,9 @@
 #include "vdso.h"
 #include "namespaces.h"
 #include <errno.h>
+#ifdef __GLIBC__
+#include <malloc.h>
+#endif
 #include <stdlib.h>
 #include <string.h>
 #include <symbol.h> // filename__read_build_id
@@ -517,3 +520,50 @@ int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data)
 	up_read(&dsos->lock);
 	return err;
 }
+
+size_t dsos__shrink(struct dsos *dsos)
+{
+	unsigned int write_idx = 0;
+	size_t freed = 0;
+	bool any_removed = false;
+
+	down_write(&dsos->lock);
+
+	for (unsigned int read_idx = 0; read_idx < dsos->cnt; read_idx++) {
+		struct dso *dso = dsos->dsos[read_idx];
+
+		freed += dso__shrink(dso);
+
+		if (dso__try_evict(dso)) {
+			any_removed = true;
+			freed++;
+			continue;
+		}
+		dsos->dsos[write_idx++] = dso;
+	}
+
+	dsos->cnt = write_idx;
+	if (any_removed) {
+		if (write_idx == 0) {
+			zfree(&dsos->dsos);
+			dsos->allocated = 0;
+			dsos->sorted = true;
+		} else if (write_idx < dsos->allocated / 2) {
+			struct dso **shrunk = realloc(dsos->dsos,
+						      write_idx * sizeof(struct dso *));
+			if (shrunk) {
+				dsos->dsos = shrunk;
+				dsos->allocated = write_idx;
+			}
+		}
+	}
+
+	up_write(&dsos->lock);
+
+#ifdef __GLIBC__
+	if (freed > 0)
+		malloc_trim(0);
+#endif
+
+	return freed;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index cc7e3a42f9cb..de10a10de777 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -51,4 +51,6 @@ struct dso *dsos__find_kernel_dso(struct dsos *dsos);
 
 int dsos__for_each_dso(struct dsos *dsos, int (*cb)(struct dso *dso, void *data), void *data);
 
+size_t dsos__shrink(struct dsos *dsos);
+
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c206c26bd62..f4108cc725fc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -3438,3 +3438,32 @@ int machine__hit_all_dsos(struct machine *machine)
 {
 	return dsos__hit_all(&machine->dsos);
 }
+
+size_t machine__shrink(struct machine *machine)
+{
+	if (!machine)
+		return 0;
+
+	return dsos__shrink(&machine->dsos);
+}
+
+size_t machines__shrink(struct machines *machines)
+{
+	struct rb_node *nd;
+	size_t freed;
+
+	if (!machines)
+		return 0;
+
+	freed = machine__shrink(&machines->host);
+
+	down_read(&machines->lock);
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
+		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
+		freed += machine__shrink(pos);
+	}
+	up_read(&machines->lock);
+
+	return freed;
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 67d517742fb6..b42c363723c9 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -339,4 +339,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 int machine__hit_all_dsos(struct machine *machine);
 
+size_t machine__shrink(struct machine *machine);
+size_t machines__shrink(struct machines *machines);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4e11eabbbe6f..9f16bff1b72f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4270,3 +4270,11 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 	 */
 	return perf_env__e_machine_nocache(env, e_flags);
 }
+
+size_t perf_session__shrink(struct perf_session *session)
+{
+	if (!session)
+		return 0;
+
+	return machines__shrink(&session->machines);
+}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 05ea2c1ee8c9..cbea6792a008 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -211,4 +211,6 @@ int perf_event__process_finished_round(const struct perf_tool *tool,
 struct perf_env *perf_session__env(struct perf_session *session);
 uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags);
 
+size_t perf_session__shrink(struct perf_session *session);
+
 #endif /* __PERF_SESSION_H */
-- 
2.56.1.809.ga0b61035b5-goog

