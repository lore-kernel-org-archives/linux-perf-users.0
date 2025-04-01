Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F8225785
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531953; cv=none; b=LcIDxQ4inzWdvb8+TqY0XCFKNLWgvdWv08cwTUA9rhJ9ABq6keAO/A5guCc8J8tsslE8h7o1C4V1NlKgrNW4o+BxOMXgrZ2IqomWbnFsMYehNNb3woXWdJ3XrpMm1vWyAUzyxvkSuQ849O5DO8XqwY2h/wGSAvIFIv4vP7kCJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531953; c=relaxed/simple;
	bh=jNRHk+HoP4LC7aVMHfDNdLRSleTyuQPlCBkTlkM17/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bKAkeBy3C46TR8MToK/sowwwcclRlDfCJAbaj3cDjIf09ua/GOFjQ8BQRdAWU2ktH7pqEIKDghxgqWGHu+tWDdueD6VDMY3q6r40FKBNmlG+2UYcePZVvJJLIsEMN83YfQNPeMXdwu0sSlYRf49pifqJaiqBin1T6XoMWYtzvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZAL0I5V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZAL0I5V"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242ce15cc3so109584665ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531951; x=1744136751; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KR8kCL7xwq040/uGoJTgKcPRCll2n3dLmKu7Yyfytk4=;
        b=OZAL0I5Vh5pH7sRW+IHFGAHSxo+YguZKtm+OtFOqIGyCsZmBTloOPvvWazpRjfpzKk
         gyTElXirTYGmhSMZpnYwgKy6iH4n+VRuNsc1eZDBgvsnkgHOUaq9vuajqIPX/Rca8YPS
         RBSQ5A1QgSntWGKtC+WB6eb9yiWy5TINSf32yhA0Q2uL2PSQ9ziVDPlovluTqexY0FU4
         zPQRpa9D9dKSTctwbFWQeapVrJIl8aKf9VBH+3+rTTbNQ+KCBAkQz/7KUsmuMUctucNA
         KZCaCBy50d0p6B6RSNGDS/zkQ2kS7eNAmcmetI+bymx5yur8+MzTlwozu16Q5NxYp8I0
         p1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531951; x=1744136751;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR8kCL7xwq040/uGoJTgKcPRCll2n3dLmKu7Yyfytk4=;
        b=OqipqUuGo66LrDggItf36oNMzRY12T+268kRDt5V+h6wW/3B4ugla8cKZDkPbw2mfM
         QtfQRmh+5EnJIqyprpO/OI3Z0ylAiVbie0LdCqFQYuTleEtCGXF42QXOK+oatTVdH/WT
         e+jzIAb+SAGnZV1MKfbl9MiQqIJb778ruzgTj3exuhphWD0ic3b/xKXiNmZRaNXq9WXN
         zs9lZeHjU6o89Kn6qg1uH9tYQMomjBi2q1Jx2ZtNVa3YDcHx5xt3fm/RpLsJix/Nifdi
         XKySVTV4fPEdw7v8dbT2rOfFXVgFDPE3kJtrJp0QzRAuGlxwacfa0XNijO+0Q63PliLn
         yueQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1DTW1TdfyVGqyrefuOtWT5BgytH0EIOhKgmff8lE8kMAVwlDcWM2PKXjCyrc502rPoSjKorI5gN/8IaKX0YwD@vger.kernel.org
X-Gm-Message-State: AOJu0YypnHm47wDFvHTRU+r9gLjme5KMUr8x+nMC7dycHhhpVYoV/0OL
	Ldtvf8JE442AlfFmbt4EytxeUKN3QOHLgHkZhguwqX2LdayPJRm9Dx5IVILutIzssl59ePmfBxG
	WsffvGw==
X-Google-Smtp-Source: AGHT+IEPqgz+rFeXBdNtdF9MopmgtL+fIX9Z60fCNyZbM/1JhnyjvKKLZ8SDjN8bE87gqdGCj1ypt69T/4tz
X-Received: from pfblb4.prod.google.com ([2002:a05:6a00:4f04:b0:730:96d1:c213])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54a:b0:223:432b:593d
 with SMTP id d9443c01a7336-2292f9f3b90mr199136565ad.42.1743531951082; Tue, 01
 Apr 2025 11:25:51 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:35 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-38-irogers@google.com>
Subject: [PATCH v1 37/48] perf inject: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
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
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
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
2.49.0.504.g3bcea36a83-goog

