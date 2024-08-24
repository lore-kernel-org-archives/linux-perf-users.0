Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731131EA80;
	Sat, 24 Aug 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517209; cv=none; b=m3L+MDkhTmynSAgvHn+3VBDcjXStaXzE5ArqZEu/i6gY8B3wbZKY0W75g7/rv+rIx9B5AfO7yb2vtss92lHgGoQxDNElVxlE6LQy1ejB2R+OW4ThMUdUprfmjszxN4WJ+4eq8YKr8aUURtr8ItM29JcuggIvIyyEZJWdSaEodfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517209; c=relaxed/simple;
	bh=K1AcK+9B/Tb73ATtysp3FqULVVAazCOHSIcyqd7KzdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLoEv5HqxYWFZa5sti1ocO/t7p4DRaYp+rKmP7ekRy2etXyKUpwDJmzLYrsHGNOPX2sCdAwa/fqJIRI02jFtBBBRLifgN/HwfkfFAhtWi8gMkP7zqTLZLKffV5qRh5KqpmaZwrJqQoKDbShyoFGz5WpVgqK0a25H5FmWl+I+ukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hrg02yrd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrg02yrd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d439583573so2140603a91.3;
        Sat, 24 Aug 2024 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517207; x=1725122007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/7R6ApBvV0rZZ+MrCemqX674AF4jV7exYsBY/ANicw=;
        b=Hrg02yrdOZJTbHs17+S2u2rCeIoLHGWdwVFVALW+0XH78Ig6IzV2mXBLMPoM/YjnDd
         uHltg7jKGV0cYpvykvqPuqAhsDRpuBWTV8s/xNm6v3nQ2NB1bmdFUNTgFi9PhnecFVza
         9ZFo7yhIhr8Vrpea2Xyqopzj9QyWAk/krJ8tlNbF4n3iAU3IVAL1ZRLrZwbeSkcGHQWL
         NywNdrRJHH+jit2VgSSy2IFhsIJ40vLeS5QzBEineWWv18XJW3AXlKwJ87IOA0LglsYm
         ALI3QbgrtugygqFE+/e4R2Trx6c6DqIX+cl7Eu8o/WWj6CSDBqdjBmKSIFYxfh+snY98
         AZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517207; x=1725122007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/7R6ApBvV0rZZ+MrCemqX674AF4jV7exYsBY/ANicw=;
        b=gvmklJrA7bkgyxSOqKvGQSFdPt6+8uaVvCEpqzXHgQHy4m8qTj55A1zLEhUkk4KFE2
         j/ANcAN1wWTrQXxF+8J8V8W0gNyUhxGkDf1lY0f5IvB3jyySSt8sfYDKUAXn+vx3j10v
         AaPCnDJhxoDvDeUdrU79EqHGk0DUJPvtss2ZYBonnEFGVuIrPMT3oa1hT1NVeLsArl5V
         lcoWLYcHHLuuQM8bRQka1E4X6eR9y4gewjcH5vX1GcA9J8PbMBQZjH9KZE7x1I40GXON
         x8wxh9iovGvaRJMpLUOmI/6+qSK1/BQCs8Ggl3uBQw8kNk8XWOdZkkGe5mVQemrdE1Kx
         3KIA==
X-Forwarded-Encrypted: i=1; AJvYcCWePNQsF2uj9YJ4NCPNbYlaX3Bz5ggl4tGzXyPYWBRAulijS+tTGoheUIr5zn/n0a1a4WTlzffUtyOw1zPO/tFGxw==@vger.kernel.org, AJvYcCXzFw+/9bp4C5UuMOpJPO0d1oBd06HknDN03FsDaFCunCS0tF1wqvDsvcLDDWmBl2fPpEj/L3BIfu8wEmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyG3JppU6vF7/FWg6rANZ9SGCQkYdoTup2PPMryZL4MSR3AOa0
	6cUCqmTksIAJ+CWej2bj+i/9d3tcG9YeFdD6dCKm04kd+XmsjNEM
X-Google-Smtp-Source: AGHT+IEqnVMm+q8IXiFX97RA6vBRsMH9hMecq5xPM3krYiBRU1IYhIyuqw93bvvcTH37ogLvLrWmTQ==
X-Received: by 2002:a17:90a:c718:b0:2d3:d066:f58b with SMTP id 98e67ed59e1d1-2d646bae055mr5596345a91.12.1724517206621;
        Sat, 24 Aug 2024 09:33:26 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:26 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 2/8] perf trace: Add trace__bpf_sys_enter_beauty_map() to prepare for fetching data in BPF
Date: Sun, 25 Aug 2024 00:33:16 +0800
Message-ID: <20240824163322.60796-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824163322.60796-1-howardchu95@gmail.com>
References: <20240824163322.60796-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up beauty_map, load it to BPF, in such format: if argument No.3 is a
struct of size 32 bytes (of syscall number 114) beauty_map[114][2] = 32;

if argument No.3 is a string (of syscall number 114) beauty_map[114][2] =
1;

if argument No.3 is a buffer, its size is indicated by argument No.4 (of
syscall number 114) beauty_map[114][2] = -4; /* -1 ~ -6, we'll read this
buffer size in BPF  */

Committer notes:

Moved syscall_arg_fmt__cache_btf_struct() from a ifdef
HAVE_LIBBPF_SUPPORT to closer to where it is used, that is ifdef'ed on
HAVE_BPF_SKEL and thus breaks the build when building with
BUILD_BPF_SKEL=0, as detected using 'make -C tools/perf build-test'.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240815013626.935097-4-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 106 +++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d6ca541fdc78..c26eab196623 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -113,6 +113,7 @@ struct syscall_arg_fmt {
 	bool	   show_zero;
 #ifdef HAVE_LIBBPF_SUPPORT
 	const struct btf_type *type;
+	int	   type_id; /* used in btf_dump */
 #endif
 };
 
@@ -3446,6 +3447,23 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 }
 
 #ifdef HAVE_BPF_SKEL
+static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+{
+       int id;
+
+	if (arg_fmt->type != NULL)
+		return -1;
+
+       id = btf__find_by_name(btf, type);
+       if (id < 0)
+		return -1;
+
+       arg_fmt->type    = btf__type_by_id(btf, id);
+       arg_fmt->type_id = id;
+
+       return 0;
+}
+
 static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
 {
 	struct bpf_program *pos, *prog = NULL;
@@ -3521,6 +3539,83 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
 	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
 }
 
+static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key, unsigned int *beauty_array)
+{
+	struct tep_format_field *field;
+	struct syscall *sc = trace__syscall_info(trace, NULL, key);
+	const struct btf_type *bt;
+	char *struct_offset, *tmp, name[32];
+	bool can_augment = false;
+	int i, cnt;
+
+	if (sc == NULL)
+		return -1;
+
+	trace__load_vmlinux_btf(trace);
+	if (trace->btf == NULL)
+		return -1;
+
+	for (i = 0, field = sc->args; field; ++i, field = field->next) {
+		struct_offset = strstr(field->type, "struct ");
+
+		if (field->flags & TEP_FIELD_IS_POINTER && struct_offset) { /* struct */
+			struct_offset += 7;
+
+			/* for 'struct foo *', we only want 'foo' */
+			for (tmp = struct_offset, cnt = 0; *tmp != ' ' && *tmp != '\0'; ++tmp, ++cnt) {
+			}
+
+			strncpy(name, struct_offset, cnt);
+			name[cnt] = '\0';
+
+			/* cache struct's btf_type and type_id */
+			if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fmt[i], trace->btf, name))
+				continue;
+
+			bt = sc->arg_fmt[i].type;
+			beauty_array[i] = bt->size;
+			can_augment = true;
+		} else if (field->flags & TEP_FIELD_IS_POINTER && /* string */
+		    strcmp(field->type, "const char *") == 0 &&
+		    (strstr(field->name, "name") ||
+		     strstr(field->name, "path") ||
+		     strstr(field->name, "file") ||
+		     strstr(field->name, "root") ||
+		     strstr(field->name, "key") ||
+		     strstr(field->name, "special") ||
+		     strstr(field->name, "type") ||
+		     strstr(field->name, "description"))) {
+			beauty_array[i] = 1;
+			can_augment = true;
+		} else if (field->flags & TEP_FIELD_IS_POINTER && /* buffer */
+			   strstr(field->type, "char *") &&
+			   (strstr(field->name, "buf") ||
+			    strstr(field->name, "val") ||
+			    strstr(field->name, "msg"))) {
+			int j;
+			struct tep_format_field *field_tmp;
+
+			/* find the size of the buffer that appears in pairs with buf */
+			for (j = 0, field_tmp = sc->args; field_tmp; ++j, field_tmp = field_tmp->next) {
+				if (!(field_tmp->flags & TEP_FIELD_IS_POINTER) && /* only integers */
+				    (strstr(field_tmp->name, "count") ||
+				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
+				     (strstr(field_tmp->name, "len") && strcmp(field_tmp->name, "filename")))) {
+					 /* filename's got 'len' in it, we don't want that */
+					beauty_array[i] = -(j + 1);
+					can_augment = true;
+					break;
+				}
+			}
+		}
+	}
+
+	if (can_augment)
+		return 0;
+
+	return -1;
+}
+
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
 {
 	struct tep_format_field *field, *candidate_field;
@@ -3625,7 +3720,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 {
 	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
 	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
+	int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
 	int err = 0;
+	unsigned int beauty_array[6];
 
 	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
 		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
@@ -3644,6 +3741,15 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
 		if (err)
 			break;
+
+		/* use beauty_map to tell BPF how many bytes to collect, set beauty_map's value here */
+		memset(beauty_array, 0, sizeof(beauty_array));
+		err = trace__bpf_sys_enter_beauty_map(trace, key, (unsigned int *)beauty_array);
+		if (err)
+			continue;
+		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
+		if (err)
+			break;
 	}
 
 	/*
-- 
2.45.2

