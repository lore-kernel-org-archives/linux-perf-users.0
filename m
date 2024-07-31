Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEF16087B;
	Wed, 31 Jul 2024 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455396; cv=none; b=nV5J/T0bgKbE/tylPC4rvoivAHWg+LzUxdyKFMyeaBEElBbL3FuMiLU8QBWZU6ANb0iN0AVFQVib0lVbO1Og7KUAUKgSqu86psDWrVKBvv6swJrctJ9GS305q1JgxcMOpgNjwjb7om8POu+S1AmcUtlxsPkcO+XSrx0dtKw24d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455396; c=relaxed/simple;
	bh=1hDFEnDRacC+it14el02NAS09S05fxBP/iOZ2CrCr4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDYQpFfI3jt9n/fUfroEyQooG2ev8nUD6oBDrWBUaLZ5b62ts4llqKN9AH5DsJLFVeNe8MZ0anuekjvCXcZ2XMOC4UEqRLmYqHvCcOmAbsEIgitQFjg2Gh9FfthQC/LCxwlkCeT7OYf8Ywc+Ny4Et3bfxkkgsma+FgTLWzGBir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ0qewH9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ0qewH9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc4fccdd78so44150615ad.2;
        Wed, 31 Jul 2024 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722455394; x=1723060194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjNeGwJc12dU9jdKLQoXBpdjOEy73PqC7kWN5ZA1lMc=;
        b=OJ0qewH9dGSUHlOelavmYw+hQSpDsRD2RJSXuWmT3R1NzBrEoEMyGsdhgyuTrlEC/J
         xjHmL3ijljhUEj8rwewGT5LQ6F8MjmFjDjp1tKiT1KWjAk0JXhYjpPONHYunDcD/l9wC
         JIvrmXfUOrNpsPBY3YiHXmpVobhTxJxj8C0mQNR6prGLy3hcLhNIXxH3DwkwpX5WO7tD
         toc7v3K5uZ9F5GAYXbQto2SxPuzoPdY4jBZlpRkMLaEDyjkA8Y04Qz9ZE/DwL0BnotVO
         FGmOTRx7SKVmkT5YzkLlKQ3ZaOR0V1D3JXS4S8iDCBKNn61ayxzMetRI7CqoBuVDMKO4
         tD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455394; x=1723060194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjNeGwJc12dU9jdKLQoXBpdjOEy73PqC7kWN5ZA1lMc=;
        b=AFO3pXcJNSYu3wNP0zETYBbnrtriuaudH93VKmS4u5P1Fyn22y9mhsz86g+1VUWrgV
         U9iWeuBGx9H836gjCf8FNw0ot4klurCPAPqVQPPCobxj0z13xxDjH5c+oMu6fBHym397
         pi39wdcrFqPFLjze12yiyu1sYtdVKGBhY8+QTVZweBCeVATefvei7H/DK3p9/ejoYRz2
         D8NUyNN0wkwPmBLGooBAjXV4STcnbTJO8OK0c0WZbl9slM1omj9GCPwG5CdE/FBFkPfz
         cdgu3+fociXbWCadOQnrHqhtQXkbW8B06uuEKRXPzGecrCkoDjcPJQy81Z2tLzBiGtDA
         qNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFSsBzfoYK2IrowL9rtIJ3KawIO7aUtgaxvjucvxIvsO2wQoINiwS5/vSW1mBpliLd1e3JXKs+hRoXduBsI99pXxUr+nfS6/tGoqNnvkNrJ0hLaZsluaSHnKQNahqbCXJRKyuL1wuayy0RS6kp6g==
X-Gm-Message-State: AOJu0Yy2fW9NUP/9V5m/w3bF6ntI+C/4Zek70KQdu8hsIz4Yb74JVDey
	CxYfiTmtiZ0DKL953X0HjfgMyMVhhRvSC49vqigMLp1Rm5XD3yEo
X-Google-Smtp-Source: AGHT+IEKbYtd1+eom6MgcIkN129ZfhJbh7ClrjZHNQt6/BiMO0Pb656JztLD51QSDW4h+cDQKyjUsQ==
X-Received: by 2002:a17:902:d2ca:b0:1fb:7f82:515 with SMTP id d9443c01a7336-1ff4cea205emr5843115ad.15.1722455393628;
        Wed, 31 Jul 2024 12:49:53 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7837e40sm124708615ad.0.2024.07.31.12.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:49:53 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] perf trace: Set up beauty_map, load it to BPF
Date: Thu,  1 Aug 2024 03:49:37 +0800
Message-ID: <20240731194939.4760-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731194939.4760-1-howardchu95@gmail.com>
References: <20240731194939.4760-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set up beauty_map, load it to BPF, in such format:
if argument No.3 is a struct of size 32 bytes (of syscall number 114)
beauty_map[114][2] = 32;

if argument No.3 is a string (of syscall number 114)
beauty_map[114][2] = 1;

if argument No.3 is a buffer, its size is indicated by argument No.4 (of syscall number 114)
beauty_map[114][2] = -4; /* -1 ~ -6, we'll read this buffer size in BPF  */

Add type_id member to syscall_arg_fmt because it is required by
btf_dump.

Add syscall_arg__scnprintf_buf() to pretty print augmented buffer.

Use btf_dump API to pretty print augmented struct pointer.

Add trace__init_pid_filter(), to set up pid_filter before running BPF
program. This way, we don't accidentally collect augmented data from
processes we don't care about.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 254 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8af93a2f0bcd..cf52fda453e0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -113,6 +113,7 @@ struct syscall_arg_fmt {
 	bool	   show_zero;
 #ifdef HAVE_LIBBPF_SUPPORT
 	const struct btf_type *type;
+	int	   type_id;
 #endif
 };
 
@@ -851,6 +852,11 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 
 #define SCA_FILENAME syscall_arg__scnprintf_filename
 
+static size_t syscall_arg__scnprintf_buf(char *bf, size_t size,
+					      struct syscall_arg *arg);
+
+#define SCA_BUF syscall_arg__scnprintf_buf
+
 static size_t syscall_arg__scnprintf_pipe_flags(char *bf, size_t size,
 						struct syscall_arg *arg)
 {
@@ -930,6 +936,24 @@ static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, str
 	arg_fmt->type = btf__type_by_id(btf, id);
 }
 
+static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+{
+	/* this function is solely used in trace__bpf_sys_enter_beauty_map */
+	int id;
+
+	if (arg_fmt->type != NULL)
+		return -1;
+
+	id = btf__find_by_name(btf, type);
+	if (id < 0)
+		return -1;
+
+	arg_fmt->type_id = id; /* used for dumping data later */
+	arg_fmt->type    = btf__type_by_id(btf, id);
+
+	return 0;
+}
+
 static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
 {
 	const struct btf_type *bt = arg->fmt->type;
@@ -991,8 +1015,56 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 	return 0;
 }
 
+#define DUMPSIZ 256
+
+static void btf_dump_snprintf(void *ctx, const char *fmt, va_list args)
+{
+	char *s = ctx, new[DUMPSIZ];
+
+	vsnprintf(new, DUMPSIZ, fmt, args);
+
+	if (strlen(s) + strlen(new) < DUMPSIZ)
+		strncat(s, new, DUMPSIZ);
+}
+
+static size_t btf_dump__struct_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, struct syscall_arg *arg, int type_id)
+{
+	char str[DUMPSIZ];
+	int dump_size;
+	int consumed;
+	struct btf_dump *btf_dump;
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	LIBBPF_OPTS(btf_dump_opts, dump_opts);
+	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
+
+	if (arg == NULL || arg->augmented.args == NULL)
+		return 0;
+
+	memset(str, 0, sizeof(str));
+
+	dump_data_opts.compact     = true;
+	dump_data_opts.skip_names  = true;
+
+	btf_dump = btf_dump__new(btf, btf_dump_snprintf, str, &dump_opts);
+	if (btf_dump == NULL)
+		return 0;
+
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
+
+	dump_size = btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts);
+	if (dump_size == 0)
+		return 0;
+
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+	arg->augmented.size -= consumed;
+
+	btf_dump__free(btf_dump);
+
+	return scnprintf(bf, size, "%s", str);
+}
+
 static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
-				   size_t size, int val, char *type)
+				   size_t size, int val, struct syscall_arg *arg, char *type)
 {
 	if (trace->btf == NULL)
 		return 0;
@@ -1008,6 +1080,8 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *
 
 	if (btf_is_enum(arg_fmt->type))
 		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
+	else if (btf_is_struct(arg_fmt->type))
+		return btf_dump__struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg, arg_fmt->type_id);
 
 	return 0;
 }
@@ -1694,6 +1768,53 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 	return 0;
 }
 
+#define MAX_CONTROL_CHAR 31
+#define MAX_ASCII 127
+#define MAX_BUF 32
+
+static size_t syscall_arg__scnprintf_augmented_buf(struct syscall_arg *arg, char *bf, size_t size)
+{
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	size_t printed = 0;
+	unsigned char *start = (unsigned char *)augmented_arg->value;
+	int i = 0, n = augmented_arg->size, consumed, digits;
+	char tmp[MAX_BUF * 4], tens[4];
+
+	memset(tmp, 0, sizeof(tmp));
+
+	for (int j = 0; j < n && i < (int)sizeof(tmp); ++j) {
+		/* print control characters(0~31 and 127), and characters bigger than 127 in \<value> */
+		if (start[j] <= MAX_CONTROL_CHAR || start[j] > MAX_ASCII) {
+			tmp[i++] = '\\';
+			digits = scnprintf(tens, sizeof(tmp) - i, "%d", (int)start[j]);
+			if (digits + i <= (int)sizeof(tmp)) {
+				strncpy(tmp + i, tens, digits);
+				i += digits;
+			}
+		} else  {
+			tmp[i++] = start[j];
+		}
+	}
+
+	printed = scnprintf(bf, size, "\"%s\"", tmp);
+
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
+
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+	arg->augmented.size -= consumed;
+
+	return printed;
+}
+
+static size_t syscall_arg__scnprintf_buf(char *bf, size_t size,
+					      struct syscall_arg *arg)
+{
+	if (arg->augmented.args)
+		return syscall_arg__scnprintf_augmented_buf(arg, bf, size);
+
+	return 0;
+}
+
 static bool trace__filter_duration(struct trace *trace, double t)
 {
 	return t < (trace->duration_filter * NSEC_PER_MSEC);
@@ -1903,8 +2024,16 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
-		     strstr(field->name, "path") != NULL))
+		     strstr(field->name, "path") ||
+		     strstr(field->name, "file") ||
+		     strstr(field->name, "root") ||
+		     strstr(field->name, "key") ||
+		     strstr(field->name, "special") ||
+		     strstr(field->name, "type") ||
+		     strstr(field->name, "description")))
 			arg->scnprintf = SCA_FILENAME;
+		else if (strstr(field->type, "char *") && strstr(field->name, "buf"))
+			arg->scnprintf = SCA_BUF;
 		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
 			arg->scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)
@@ -2263,7 +2392,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
 			btf_printed = trace__btf_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
-							   size - printed, val, field->type);
+							   size - printed, val, &arg, field->type);
 			if (btf_printed) {
 				printed += btf_printed;
 				continue;
@@ -2965,7 +3094,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, field->type);
+		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, NULL, field->type);
 		if (btf_printed) {
 			printed += btf_printed;
 			continue;
@@ -3523,6 +3652,82 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
 	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
 }
 
+static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key, unsigned int *beauty_array)
+{
+	struct tep_format_field *field;
+	struct syscall *sc = trace__syscall_info(trace, NULL, key);
+	const struct btf_type *bt;
+	char *struct_offset, *tmp, name[32];
+	bool augmented = false;
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
+			if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fmt[i], trace->btf, name))
+				continue;
+
+			bt = sc->arg_fmt[i].type;
+			beauty_array[i] = bt->size;
+			augmented = true;
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
+			augmented = true;
+		} else if (field->flags & TEP_FIELD_IS_POINTER && /* buffer */
+			   strstr(field->type, "char *") &&
+			   (strstr(field->name, "buf") ||
+			    strstr(field->name, "val") ||
+			    strstr(field->name, "msg"))) {
+			int j;
+			struct tep_format_field *field_tmp;
+
+			/* find the size of the buffer  */
+			for (j = 0, field_tmp = sc->args; field_tmp; ++j, field_tmp = field_tmp->next) {
+				if (!(field_tmp->flags & TEP_FIELD_IS_POINTER) && /* only integers */
+				    (strstr(field_tmp->name, "count") ||
+				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
+				     (strstr(field_tmp->name, "len") && strcmp(field_tmp->name, "filename")))) {
+					 /* filename's got 'len' in it, we don't want that */
+					beauty_array[i] = -(j + 1);
+					augmented = true;
+					break;
+				}
+			}
+		}
+	}
+
+	if (augmented)
+		return 0;
+
+	return -1;
+}
+
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
 {
 	struct tep_format_field *field, *candidate_field;
@@ -3627,7 +3832,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 {
 	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
 	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
+	int beauty_map_fd = bpf_map__fd(trace->skel->maps.beauty_map_enter);
 	int err = 0;
+	unsigned int beauty_array[6];
 
 	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
 		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
@@ -3646,6 +3853,15 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
 		if (err)
 			break;
+
+		/* set up the size of struct pointer argument for beauty map */
+		memset(beauty_array, 0, sizeof(beauty_array));
+		err = trace__bpf_sys_enter_beauty_map(trace, key, (unsigned int *)beauty_array);
+		if (err)
+			continue;
+		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
+		if (err)
+			break;
 	}
 
 	/*
@@ -3714,6 +3930,33 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 
 	return err;
 }
+
+static void trace__init_pid_filter(struct trace *trace)
+{
+	int pid_filter_fd = bpf_map__fd(trace->skel->maps.pid_filter);
+	bool exists = true;
+	struct str_node *pos;
+	struct strlist *pid_slist = strlist__new(trace->opts.target.pid, NULL);
+
+	trace->skel->bss->filter_pid = false;
+
+	if (pid_slist) {
+		strlist__for_each_entry(pos, pid_slist) {
+			char *end_ptr;
+			int pid = strtol(pos->s, &end_ptr, 10);
+
+			if (pid == INT_MIN || pid == INT_MAX ||
+			    (*end_ptr != '\0' && *end_ptr != ','))
+				continue;
+
+			bpf_map_update_elem(pid_filter_fd, &pid, &exists, BPF_ANY);
+			trace->skel->bss->filter_pid = true;
+		}
+	}
+
+	strlist__delete(pid_slist);
+}
+
 #endif // HAVE_BPF_SKEL
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
@@ -4108,6 +4351,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 #ifdef HAVE_BPF_SKEL
 	if (trace->skel && trace->skel->progs.sys_enter)
 		trace__init_syscalls_bpf_prog_array_maps(trace);
+
+	if (trace->skel)
+		trace__init_pid_filter(trace);
 #endif
 
 	if (trace->ev_qualifier_ids.nr > 0) {
-- 
2.45.2

