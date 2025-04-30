Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E1265CCF
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035532; cv=none; b=dOz7iKaQiCVmdkigjIcdaBfu63LXh2ARPFzavUudMqYMLDuC2QWXoW2nukQTnyLwQqrmIG710ozzOAVAt+vZK/sLu187MqjyeuFP/6fMXg3Qop6yHImrr6zUt4yrvja2oth0T6O7gqftGbKbdk+1CEz1zl19J2+8DIRKT/wW7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035532; c=relaxed/simple;
	bh=FAztUQ/Qgmw1TxttHWQU7PuFGmCsSreDb+sjOFcGU8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k1ua9r2anoN+Zz1g6X2ou+uzd7LNegWHxEJehfOyUCsWEpLneE8M+bXvweG59slnu1b4Gr1obJDwQ39/QaYtrMr8va97IHQ/q6kFOoWNipwpdvShRjMmbmUCPaU7egxKX8iKKSIF/hmtnrpw9JIP55rlVqXefAElHrHbiLOXmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4F0Ez0q; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4F0Ez0q"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30870e7e4fcso126943a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035530; x=1746640330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZUtaXhFUgE5PXKn2aQb3TVIYmNfxUDXrZQfO0BiQpw=;
        b=r4F0Ez0qk4MB/f/4RZpQ7cjuyXwuXQWuLWgAO6rPns/0jg+uQExlacZ4WtjWMU+EhX
         RQCgaOSzz76cNjYRueeQe1CzXMtA532bAo9SK+4Noy/34JainbQBhXa2knx7GVSqkLKE
         TvSe7WsNjMrExEY/tKUEHWw3tU3Q8kFA7rDKlpx0pslAv3u+YqrtQ1Agez9iWK7OizYd
         CLsFPGJNPJwk987Vy+ailBqMtidOseVdGfTgbPgyzyHfGkrBysTAuzJhzKbRLiJQzubl
         dzWH6VNOoypIh2AyuV5V5Elh0t6e0ajMpTmsGC3BIvwCqULqg5wPIeeSh8/vvK8NIVAj
         dE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035530; x=1746640330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZUtaXhFUgE5PXKn2aQb3TVIYmNfxUDXrZQfO0BiQpw=;
        b=vwVU7E/+SQ1uJlkqAoI7yghpSGFLEFKJJ4JDtKhly8CpJC8d7jDRU0Gg1b+6/dCNn+
         wJHcRLyJSOPa1fIf2W2UHEr0Gryd+oyAp5cpj5zlEusJ7doCPBs0pxO/+kMSDkx5Zaft
         wiO3jdWpcosynCjN76RPleFTtO5q5+oX4qnfRp6NPG16BMNYco/ngGttiNWfpgnTZVxd
         dmubsVcg0oAKIaLlmPQK4PLUig6UGX41FD60YNc4Mb4VTkn6sNFb3qeIDsK9qn2DQpey
         iLstVXAYzp3GE5GplsEkn0Vpkvp0wtsuhi+bZusBqjgXDtOmVD0b6rwMoPUQaAykWa39
         OiWg==
X-Forwarded-Encrypted: i=1; AJvYcCXnb1syE0leaHnDrmvVTJNeF8AtET8VqFD1AZZ7vRoAP3Of40Jg0VN5u5ud+26LNHk2wsKJzIehhQwct+xjX/CR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZNSQ4ERJminUKt/05q2XVgu9g8/fH58bo+GEJj1Bk9sR998p
	9iY2bGWkWXMKkgeSngsEa2R/fjPYldfrj8h9l30/gibuQ3g/5YLod1Z/vcCaHluOFGSfMxuHb/u
	bWSmEng==
X-Google-Smtp-Source: AGHT+IFg0N6dq2zxHWgut+7y1R8svB6zqG3dJr0282Hw+KUWivPwpqKfasU09PkOT69V+O3g8rqbUIba1Xct
X-Received: from pjbsw7.prod.google.com ([2002:a17:90b:2c87:b0:2fc:3022:36b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c7:b0:30a:3e8e:ea30
 with SMTP id 98e67ed59e1d1-30a3f0b2b89mr638320a91.11.1746035530157; Wed, 30
 Apr 2025 10:52:10 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:24 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-37-irogers@google.com>
Subject: [PATCH v2 36/47] perf inject: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 11e49cafa3af..09a99cec8f78 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -390,7 +390,7 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
 		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
 		if (IS_ERR(event))
-			return PTR_ERR(event);
+			return (int)PTR_ERR(event);
 	}
 
 	return perf_event__repipe_synth(tool, event);
@@ -697,13 +697,13 @@ static struct strlist *perf_inject__parse_known_build_ids(
 {
 	struct str_node *pos, *tmp;
 	struct strlist *known_build_ids;
-	int bid_len;
 
 	known_build_ids = strlist__new(known_build_ids_string, NULL);
 	if (known_build_ids == NULL)
 		return NULL;
 	strlist__for_each_entry_safe(pos, tmp, known_build_ids) {
 		const char *build_id, *dso_name;
+		size_t bid_len;
 
 		build_id = skip_spaces(pos->s);
 		dso_name = strchr(build_id, ' ');
@@ -717,7 +717,7 @@ static struct strlist *perf_inject__parse_known_build_ids(
 			strlist__remove(known_build_ids, pos);
 			continue;
 		}
-		for (int ix = 0; 2 * ix + 1 < bid_len; ++ix) {
+		for (size_t ix = 0; 2 * ix + 1 < bid_len; ++ix) {
 			if (!isxdigit(build_id[2 * ix]) ||
 			    !isxdigit(build_id[2 * ix + 1])) {
 				strlist__remove(known_build_ids, pos);
@@ -732,10 +732,10 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 					       struct dso *dso)
 {
 	struct str_node *pos;
-	int bid_len;
 
 	strlist__for_each_entry(pos, inject->known_build_ids) {
 		const char *build_id, *dso_name;
+		size_t bid_len;
 
 		build_id = skip_spaces(pos->s);
 		dso_name = strchr(build_id, ' ');
@@ -743,7 +743,7 @@ static bool perf_inject__lookup_known_build_id(struct perf_inject *inject,
 		dso_name = skip_spaces(dso_name);
 		if (strcmp(dso__long_name(dso), dso_name))
 			continue;
-		for (int ix = 0; 2 * ix + 1 < bid_len; ++ix) {
+		for (size_t ix = 0; 2 * ix + 1 < bid_len; ++ix) {
 			dso__bid(dso)->data[ix] = (hex(build_id[2 * ix]) << 4 |
 						  hex(build_id[2 * ix + 1]));
 		}
@@ -1006,7 +1006,7 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
 	union perf_event *event_sw;
 	struct perf_sample sample_sw;
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	u32 pid = evsel__intval(evsel, sample, "pid");
+	u32 pid = (u32)evsel__intval(evsel, sample, "pid");
 
 	list_for_each_entry(ent, &inject->samples, node) {
 		if (pid == ent->tid)
@@ -1038,7 +1038,7 @@ static int guest_session__output_bytes(struct guest_session *gs, void *buf, size
 {
 	ssize_t ret = writen(gs->tmp_fd, buf, sz);
 
-	return ret < 0 ? ret : 0;
+	return ret < 0 ? (int)ret : 0;
 }
 
 static int guest_session__repipe(const struct perf_tool *tool,
@@ -1444,7 +1444,7 @@ static int guest_session__start(struct guest_session *gs, const char *name, bool
 
 	session = perf_session__new(&gs->data, &gs->tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	gs->session = session;
 
 	/*
@@ -1518,7 +1518,7 @@ static void guest_session__exit(struct guest_session *gs)
 static void get_tsc_conv(struct perf_tsc_conversion *tc, struct perf_record_time_conv *time_conv)
 {
 	tc->time_shift		= time_conv->time_shift;
-	tc->time_mult		= time_conv->time_mult;
+	tc->time_mult		= (u32)time_conv->time_mult;
 	tc->time_zero		= time_conv->time_zero;
 	tc->time_cycles		= time_conv->time_cycles;
 	tc->time_mask		= time_conv->time_mask;
@@ -1578,7 +1578,7 @@ static int guest_session__fetch(struct guest_session *gs)
 	hdr = buf;
 	ret = readn(gs->tmp_fd, buf, hdr_sz);
 	if (ret < 0)
-		return ret;
+		return (int)ret;
 
 	if (!ret) {
 		/* Zero size means EOF */
@@ -1590,7 +1590,7 @@ static int guest_session__fetch(struct guest_session *gs)
 
 	ret = readn(gs->tmp_fd, buf, hdr->size - hdr_sz);
 	if (ret < 0)
-		return ret;
+		return (int)ret;
 
 	gs->ev.event = (union perf_event *)gs->ev.event_buf;
 	gs->ev.sample.time = 0;
@@ -1603,7 +1603,7 @@ static int guest_session__fetch(struct guest_session *gs)
 	ret = evlist__parse_sample(gs->session->evlist, gs->ev.event, &gs->ev.sample);
 	if (ret) {
 		pr_err("Parse failed fetching guest event");
-		return ret;
+		return (int)ret;
 	}
 
 	if (!gs->have_tc) {
@@ -1982,7 +1982,7 @@ static int parse_guest_data(const struct option *opt, const char *str, int unset
 	tok = strsep(&s, ",");
 	if (!tok)
 		goto bad_args;
-	gs->machine_pid = strtoul(tok, NULL, 0);
+	gs->machine_pid = (u32)strtoul(tok, NULL, 0);
 	if (!inject->guest_session.machine_pid)
 		goto bad_args;
 
@@ -2535,7 +2535,7 @@ int cmd_inject(int argc, const char **argv)
 					     /*trace_event_repipe=*/inject.output.is_pipe);
 
 	if (IS_ERR(inject.session)) {
-		ret = PTR_ERR(inject.session);
+		ret = (int)PTR_ERR(inject.session);
 		goto out_close_output;
 	}
 
-- 
2.49.0.906.g1f30a19c02-goog

