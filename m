Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341820E328;
	Sat, 17 May 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499563; cv=none; b=GfQOBrzKBKH1zVr/IYviLmnMd8Lk6hsucPwudtU1eKwvbmqwZb8jhOJJQuflPu2pFEqNP9Xe3woJVBmNCGU8mMA1CaAMv30iRwqP/q7nniYqGJlvgrimCPFxb7aKqYwNbSj50l/8tAPsQsJkWaOnd/oZnAlMiuQwGquIEQGJGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499563; c=relaxed/simple;
	bh=pM2afdtWvN63wnZ9N1Ue8glUb7E0MP5sU0X3dPkt0Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rE1Xj+30c1Knx2a/UMt0AEoyiOShNLA/KtgJLhPTN4eiQtOBjvk0uGzh2ErxlwtAV1Qsg0WGlXTaubt61M0MAo3QGyQIs7/yRjysHLFg4ncRGnxjqZlQ/kK2PnMYiYrjqWfmIt3cfn0c/PBdqSOKuO2E5/XqKjcVOvZ/K2iGLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOLJ5EGE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOLJ5EGE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7423fadbe77so3153079b3a.3;
        Sat, 17 May 2025 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747499561; x=1748104361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr6fiqTS4hy2eJG+DPR1iFk2n4/BwG2AsU5uh7Vgz78=;
        b=IOLJ5EGE/aJLUogx4zyMgyWH2CJUdGiFbUSphNf2MYfSYcgJAEctFS9otsBo6blgsz
         MJy/uEYxO1JPRM39l/jEM0b8wNBE+2zSWvh+12PzXmXCzDypKWn9Zh5VspQCEd2ZGZCx
         GzR/FtD1YhO0Yb25rgr4/KentEzGRwEGWB2j0iMeEeDuujncd1dTXT/1tZxIKUAp0U2o
         0a2lpldJoWpTzTbmbjtGaUWgsPrtY7p74gT+rPOvZJ+jwt4AtRdtQS+0uooyIbMZyvbk
         3QEu0Iuuxp/JSRIfyBAgo71a6HmjllNMoTa/qmCnJdV46cOD9cncD5U30fVbtY7HRgjJ
         9HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747499561; x=1748104361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr6fiqTS4hy2eJG+DPR1iFk2n4/BwG2AsU5uh7Vgz78=;
        b=HhShuaRRI3qi9H6jFvdotJ48ADgKTe6tXMlZxueQcWjF3/w5jUws2N34qfvM2SiEQO
         O58T8TbMDidGJnhmR1RxdFFGYwQYBR7ggPvQ3V016dRGApPkOd891zEWlakfIQEVVaTy
         atIHSS247Uw4bF+odl4kRYfnZz9STWzca+W8XiLK2n2oFVUr3rnsnOeANauYxGgKkO15
         /qndwLYGa01p7suuEcJTgb4tooEjhe9bOh0wU1lXt004WP+vJPTchl24G9K/gmkgeaJj
         83Tg1tVhBHLWz5fKaewzKxgiHldskgYtG51mRZ5230A/+jiOJC1XfsGdGRsS9QqE/pBr
         TP8A==
X-Forwarded-Encrypted: i=1; AJvYcCU7p6wmcSwlRhYdBP9Xgrodo9+NUglBiJLs1a8KlquXAO8QUFS4vsHCeo8faSaV5gJkcGk0k6L7ZkVpODE=@vger.kernel.org, AJvYcCUP4lrNu7OtxK3/cDMqunICdxhrFirF/JfFzJ/zqtfE6xSlTr2ciI1Tfe4whxIEZyJUExEhtFAQCVT5xSrT7G+l7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZoCYSDqwkkR9fjaHE/BmJL0Pu7e7xAHRyOe60KCTSIBAFUfJ8
	ddjCOsgZqv0iHxfEd9agt01tcwjGccuVdoVRPyAbfD1zsUiqEEDNbmyu
X-Gm-Gg: ASbGncttl0ntAySYFtjqC5JBpKv/Nmx5qXeWEBUvnq8iTQlfERdB46cn9tzd2pym/HO
	6mQq4yd06+78pQHjPp+JppBJFaXJTkgHDsRJdFRJ1uzQjrzLDngw1HtQerWR73MeM9+weh7YwEr
	kDXD3Mpga5CbAzp3wkUcOTnwLqtuHc7ZisrSNwuLJQDJSkxD1SaTKUTDZzhtrKv04eOVumpk2BX
	rauffPe8v28ekeZFp7sG4XbMM0CkVkjDW0KFXK6Fal+eFD6rRlVx5a1iS2uuiKaq8HVsoyRak23
	/e0aJTZUjb6bQI1yMUrbe7OSbDACuulNBY0DTsFxMcl60mdVviqBpwOToDfH9ornCPE/O188Ijk
	XA30EX706qEFjeN1tdcbQ
X-Google-Smtp-Source: AGHT+IH3Cnkw0BkKS37E/fvbvaTiH6Q3NfTFfO/wbE5+wRZnXJlUHyRfpuExd9vq8uz4zG6bMchDdg==
X-Received: by 2002:a05:6a21:3a45:b0:1f5:8dea:bb93 with SMTP id adf61e73a8af0-2170cb07df4mr11168676637.7.1747499561417;
        Sat, 17 May 2025 09:32:41 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb085ad4sm3330321a12.59.2025.05.17.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 09:32:41 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1 5/5] perf test trace BTF: Use --sort-events in BTF general tests
Date: Sat, 17 May 2025 09:32:30 -0700
Message-ID: <20250517163230.1237469-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250517163230.1237469-1-howardchu95@gmail.com>
References: <20250517163230.1237469-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without the '--sort-events' flag, perf trace doesn't receive and process
events based on their arrival time, thus PERF_RECORD_COMM event that
assigns the correct comm to a PID, may be delivered and processed after
regular samples, causing trace outputs not having a 'comm', e.g.
'mv', instead, having the default PID placeholder, e.g. ':14514'.

Hopefully this answers Namhyung's question in [1].

You can simply justify the statement with this diff:

---8<---
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index edab0ff60b3c..f042afed5b74 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4204,6 +4204,7 @@ static int trace__deliver_event(struct trace *trace, union perf_event *event)
 {
 	int err;

+	printf("[debug] deliver\n");
 	if (!trace->sort_events)
 		return __trace__deliver_event(trace, event);

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 8aa456d7c2cd..76df9886429e 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -213,6 +213,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
 	new = comm_strs__findnew(str);
 	if (!new)
 		return -ENOMEM;
+	printf("[OVERRIDE] old %s new %s str %s\n", old->str, new->str, str);

 	comm_str__put(old);
 	comm->comm_str = new;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2531b373f2cf..5a501fe304d2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -578,6 +578,7 @@ int machine__process_comm_event(struct machine *machine, union perf_event *event
 	if (dump_trace)
 		perf_event__fprintf_comm(event, stdout);

+	printf("[debug] machine__process_comm_event\n");
 	if (thread == NULL ||
 	    __thread__set_comm(thread, event->comm.comm, sample->time, exec)) {
 		dump_printf("problem processing PERF_RECORD_COMM, skipping event.\n");

Now, simply run this command multiple times:
    $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
And you should see two types of results:

    $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
    [debug] deliver
    [debug] machine__process_comm_event
    [OVERRIDE] old :1221169 new mv str mv
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
	 0.000 ( 0.013 ms): mv/1221169 renameat2(olddfd: CWD, oldname: "/tmp/file1", newdfd: CWD, newname: "/tmp/file2", flags: NOREPLACE) = 0
    [debug] deliver

    $ touch /tmp/file1 && sudo /tmp/perf trace -e renameat* -- mv /tmp/file1 /tmp/file2 && rm -f /tmp/file2
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
    [debug] deliver
	 0.000 ( 0.014 ms): :1221398/1221398 renameat2(olddfd: CWD, oldname: "/tmp/file1", newdfd: CWD, newname: "/tmp/file2", flags: NOREPLACE) = 0
    [debug] deliver
    [debug] deliver
    [debug] machine__process_comm_event
    [OVERRIDE] old :1221398 new mv str mv
    [debug] deliver
    [debug] deliver
    [debug] deliver

Anyway, use --sort-events in BTF general tests to avoid :PID, a comm is
preferred.

[1]: https://lore.kernel.org/linux-perf-users/Z_AeswETE5xLcPT8@google.com/

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index e78e653fc8f1..a15cdb5fa309 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -27,7 +27,7 @@ check_vmlinux() {
 
 trace_test_string() {
   echo "Testing perf trace's string augmentation"
-  output="$(perf trace -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
+  output="$(perf trace --sort-events -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
   if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
   then
     printf "String augmentation test failed, output:\n$output"
@@ -38,7 +38,7 @@ trace_test_string() {
 trace_test_buffer() {
   echo "Testing perf trace's buffer augmentation"
   # echo will insert a newline (\10) at the end of the buffer
-  output="$(perf trace -e write --max-events=1 -- echo "${buffer}" 2>&1)"
+  output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
   if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
   then
     printf "Buffer augmentation test failed, output:\n$output"
@@ -48,7 +48,7 @@ trace_test_buffer() {
 
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
-  output="$(perf trace -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
+  output="$(perf trace --sort-events -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
   if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,\}, 0x[0-9a-f]+\) += +[0-9]+$"
   then
 	printf "BTF struct augmentation test failed, output:\n$output"
-- 
2.45.2

